#!/bin/bash
set -e

###
# Build Script
# Use this script to build theme assets,
# and perform any other build-time tasks.
##

# Install PHP dependencies (WordPress, plugins, etc.)
composer install --ignore-platform-req=ext-simplexml

# Build theme assets
# Supports multiple themes
for d in web/app/themes/*; do
  if [[ -f "$d/package.json" ]]; then
    echo "***"
    echo "Compiliing $d"
    echo "***"
    cd "$d"
    npm install
    npm run production --if-present
    npm run build-minify --if-present
    rm -rf node_modules
    cd ../../../..
  fi
done

# Remove composer auth.json
rm -f auth.json
