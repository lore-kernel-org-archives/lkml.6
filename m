Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F1A2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZei+II2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F1A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeLFWXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:23:53 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40064 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLFWXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:23:52 -0500
Received: by mail-qk1-f201.google.com with SMTP id y83so1733883qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=50o4MvtjLTdhL3u0ZwwFnXOeAd7cA9fIDGEIiqzQvao=;
        b=AZei+II2V6jWx0me6vDCCyk0FIhbhE8opLZeexdh9DmxcCLX4hvVdEAcN6E2zWa10q
         LY1sTCif6FTGn5I2rusoGg9XR4JvaFvA4MchJgB0PDvnFjd7ebXnfNwA4rNSxWTwqxs1
         yZ+jwLi3PHmtQQ9uoXI+cNNH8wF8Di5e/3DbqSmKKAJXsRyLfXG2PfEpU7cZogBuA56Z
         dNJs7a60Jx4PXNJBdFuJstSu4PSm64KzgIHhjGvXESKL9IGUyDv7o03Z7ms/oWIwTa8O
         N7M/wVy158EGCqDp8Gk27Acn3ggJjwXaVut8zeh4z+Uk+GztEPFvMqLTKG4e+4z+1n2V
         8+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=50o4MvtjLTdhL3u0ZwwFnXOeAd7cA9fIDGEIiqzQvao=;
        b=jBzKDF4JQs5QwdHqrmC5C5gyhoynPgB8k8MLrCdGDNjLeR3fIk0DUKP0ORZ6uVE88n
         CxWk01wuXmTHyXnRUzE2VT/98OxnprJxZqN/ZDQGz8xvRxJE4HVbQmDOWcVTe5zMRFEy
         UfRhdKthHUNkwuj3bL5PcGbQbY5GFGA45eaemGnwR1ESdoF3dwZ5wPAsn0CocFm+PbVz
         lxAUxXORBsVf7MFWCSCHXzYhN/blLgx7i9B/52jnh1nViV4iXIi1JQuEy05s6JSUYBZg
         h36r70sPpgr1OscDK/Z3VoAef8oHJxOBdVjMaJoeHPzmD/LKi7wqqtvOtZE9M0G1aQdA
         9GgA==
X-Gm-Message-State: AA+aEWZCYx7dFnsoLNsmlY7edK5mU6fRKtpwaEZ2iPes+tNKh63128Yv
        BWL33WJ+vdXd5gcKxgz2nwa3o95RYITMlw==
X-Google-Smtp-Source: AFSGD/UXXY8g2CPTbqMvLEz+PJH0Ny3gcdb4PNzFYEuKY1tJVUhKl/ujqNQzpAG4utta+JOJE4qA8XBUiOqAiA==
X-Received: by 2002:a0c:879a:: with SMTP id 26mr22484767qvj.62.1544135031575;
 Thu, 06 Dec 2018 14:23:51 -0800 (PST)
Date:   Thu,  6 Dec 2018 14:23:18 -0800
Message-Id: <20181206222318.218157-1-tmroeder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] scripts: add a tool to produce a compile_commands.json file
From:   Tom Roeder <tmroeder@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Roeder <tmroeder@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLVM/Clang project provides many tools for analyzing C source code.
Many of these tools are based on LibTooling
(https://clang.llvm.org/docs/LibTooling.html), which depends on a
database of compiler flags. The standard container for this database is
compile_commands.json, which consists of a list of JSON objects, each
with "directory", "file", and "command" fields.

Some build systems, like cmake or bazel, produce this compilation
information directly. Naturally, Makefiles don't. However, the kernel
makefiles already create .<target>.o.cmd files that contain all the
information needed to build a compile_commands.json file.

So, this commit adds scripts/gen_compile_commands.py, which recursively
searches through a directory for .<target>.o.cmd files and extracts
appropriate compile commands from them. It writes a
compile_commands.json file that LibTooling-based tools can use.

By default, gen_compile_commands.py starts its search in its working
directory and (over)writes compile_commands.json in the working
directory. However, it also supports --output and --directory flags for
out-of-tree use.

Note that while gen_compile_commands.py enables the use of clang-based
tools, it does not require the kernel to be compiled with clang. E.g.,
the following sequence of commands produces a compile_commands.json file
that works correctly with LibTooling.

make defconfig
make
scripts/gen_compile_commands.py

Also note that this script is written to work correctly in both Python 2
and Python 3, so it does not specify the Python version in its first
line.

For an example of the utility of this script: after running
gen_compile_commands.json on the latest kernel version, I was able to
use Vim + the YouCompleteMe pluging + clangd to automatically jump to
definitions and declarations. Obviously, cscope and ctags provide some
of this functionality; the advantage of supporting LibTooling is that it
opens the door to many other clang-based tools that understand the code
directly and do not rely on regular expressions and heuristics.

Tested: Built several recent kernel versions and ran the script against
them, testing tools like clangd (for editor/LSP support) and clang-check
(for static analysis). Also extracted some test .cmd files from a kernel
build and wrote a test script to check that the script behaved correctly
with all permutations of the --output and --directory flags.

Signed-off-by: Tom Roeder <tmroeder@google.com>
---
 scripts/gen_compile_commands.py | 146 ++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 scripts/gen_compile_commands.py

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
new file mode 100755
index 000000000000..d6c4d7281976
--- /dev/null
+++ b/scripts/gen_compile_commands.py
@@ -0,0 +1,146 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Google LLC, 2018
+#
+# Author: Tom Roeder <tmroeder@google.com>
+#
+"""A tool for generating compile_commands.json in the Linux kernel."""
+
+import argparse
+import json
+import logging
+import os
+import re
+
+_DEFAULT_OUTPUT = 'compile_commands.json'
+_DEFAULT_LOG_LEVEL = 'WARNING'
+
+_FILENAME_PATTERN = r'^\..*\.cmd$'
+_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
+_VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
+
+# A kernel build generally has over 2000 entries in its compile_commands.json
+# database. If this code finds 500 or fewer, then warn the user that they might
+# not have all the .cmd files, and they might need to compile the kernel.
+_LOW_COUNT_THRESHOLD = 500
+
+
+def parse_arguments():
+    """Sets up and parses command-line arguments.
+
+    Returns:
+        log_level: A logging level to filter log output.
+        directory: The directory to search for .cmd files.
+        output: Where to write the compile-commands JSON file.
+    """
+    usage = 'Creates a compile_commands.json database from kernel .cmd files'
+    parser = argparse.ArgumentParser(description=usage)
+
+    directory_help = ('Path to the kernel source directory to search '
+                      '(defaults to the working directory)')
+    parser.add_argument('-d', '--directory', type=str, help=directory_help)
+
+    output_help = ('The location to write compile_commands.json (defaults to '
+                   'compile_commands.json in the search directory)')
+    parser.add_argument('-o', '--output', type=str, help=output_help)
+
+    log_level_help = ('The level of log messages to produce (one of ' +
+                      ', '.join(_VALID_LOG_LEVELS) + '; defaults to ' +
+                      _DEFAULT_LOG_LEVEL + ')')
+    parser.add_argument(
+        '--log_level', type=str, default=_DEFAULT_LOG_LEVEL,
+        help=log_level_help)
+
+    args = parser.parse_args()
+
+    log_level = args.log_level
+    if log_level not in _VALID_LOG_LEVELS:
+        raise ValueError('%s is not a valid log level' % log_level)
+
+    directory = args.directory or os.getcwd()
+    output = args.output or os.path.join(directory, _DEFAULT_OUTPUT)
+    directory = os.path.abspath(directory)
+
+    return log_level, directory, output
+
+
+def process_line(root_directory, file_directory, command_prefix, relative_path):
+    """Extracts information from a .cmd line and creates an entry from it.
+
+    Args:
+        root_directory: The directory that was searched for .cmd files. Usually
+            used directly in the "directory" entry in compile_commands.json.
+        file_directory: The path to the directory the .cmd file was found in.
+        command_prefix: The extracted command line, up to the last element.
+        relative_path: The .c file from the end of the extracted command.
+            Usually relative to root_directory, but sometimes relative to
+            file_directory and sometimes neither.
+
+    Returns:
+        An entry to append to compile_commands.
+
+    Raises:
+        ValueError: Could not find the extracted file based on relative_path and
+            root_directory or file_directory.
+    """
+
+    cur_dir = root_directory
+    expected_path = os.path.join(cur_dir, relative_path)
+    if not os.path.exists(expected_path):
+        # Try using file_directory instead. Some of the tools have a different
+        # style of .cmd file than the kernel.
+        cur_dir = file_directory
+        expected_path = os.path.join(cur_dir, relative_path)
+        if not os.path.exists(expected_path):
+            raise ValueError('File %s not in %s or %s' %
+                             (relative_path, root_directory, file_directory))
+    return {
+        'directory': cur_dir,
+        'file': relative_path,
+        'command': command_prefix + relative_path,
+    }
+
+
+def main():
+    """Walks through the directory and finds and parses .cmd files."""
+    log_level, directory, output = parse_arguments()
+
+    level = getattr(logging, log_level)
+    logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
+
+    filename_matcher = re.compile(_FILENAME_PATTERN)
+    line_matcher = re.compile(_LINE_PATTERN)
+
+    compile_commands = []
+    for dirpath, _, filenames in os.walk(directory):
+        for filename in filenames:
+            if not filename_matcher.match(filename):
+                continue
+            filepath = os.path.join(dirpath, filename)
+
+            with open(filepath, 'rt') as f:
+                for line in f:
+                    result = line_matcher.match(line)
+                    if not result:
+                        continue
+
+                    try:
+                        entry = process_line(directory, dirpath,
+                                             result.group(1), result.group(2))
+                        compile_commands.append(entry)
+                    except ValueError as err:
+                        logging.info('Could not add line from %s: %s',
+                                     filepath, err)
+
+    with open(output, 'wt') as f:
+        json.dump(compile_commands, f, indent=2, sort_keys=True)
+
+    count = len(compile_commands)
+    if count < _LOW_COUNT_THRESHOLD:
+        logging.warning(
+            'Found %s entries. Have you compiled the kernel?', count)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.20.0.rc2.403.gdbc3b29805-goog

