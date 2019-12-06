#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://8dbdd585.ngrok.io/project/5dea3a72d3543f62eaa27942/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://8dbdd585.ngrok.io/pull/5dea3a72d3543f62eaa27942 
fi
curl -s -X POST https://8dbdd585.ngrok.io/project/5dea3a72d3543f62eaa27942/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://8dbdd585.ngrok.io/project/5dea3a72d3543f62eaa27942/webhook/build/publish > /dev/null
