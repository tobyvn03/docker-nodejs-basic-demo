# This is a Dockerfile--a list of instructions or a blueprint to build an
# image. The parent image, working directory, packages/dependencies, and source
# code are all specified in this file.

FROM node:12
# Use an official Node runtime as a parent image

WORKDIR /app
# cd immediately into this directory

COPY package*.json ./
# COPY from <source> in local system to <dest> in image's filesystem

RUN npm install
# equivalent to opening a terminal and running 'npm install' at build time
# npm is Node Package Manager for Node.js
# 'npm install' installs ALL dependencies listed in 'package.json'
# good practice to install dependencies BEFORE loading source code...
# ...to take advantage of caching and improve build speeds

COPY . .
# COPY all local files to image working directory
# .dockerignore will instruct COPY to not copy node_modules...
# ...preventing COPY from overwriting node packages

ENV PORT=8080
# declare an environment variable

EXPOSE 8080

CMD [ "npm", "start" ]

# After specifying how to build the Docker image, the image itself can be built
# by running 'docker build -t <image-name>:<image-tag> <dest-path>' in the
# terminal. -t or --tag allows the user to include a name and/or tag to the
# image for easier reference.

# 'docker build -t my-app:v1 .' creates an image with name 'my-app' and tag 'v1'
# 'docker build -t my-app .' creates an image with a default tag 'latest'
# 'docker build .' creates an image only by its image ID (a long SHA256 hash)