Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F7FC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EF420651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKoXlEUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EF420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeJXLKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:10:07 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:41228 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:10:07 -0400
Received: by mail-oi1-f201.google.com with SMTP id w139-v6so2448801oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YFO59fX7EPP/uO/HlrIPp45JUtgOHU1dmoFMJExfJlg=;
        b=EKoXlEUdUiYG4T64K8TZqfeeS5EU0N1ByNKdfePXYQVj+5HpWaiwZ4mQX5USfy0XS9
         CMR4oCSaBxbxZBLXxcD+GdyVuyAJdKDrU18fMd02PyB9ymCCOg1OhYJ33DrX2W6bHIX8
         TI+2ie3nBu3Djv2WA7kXU8t7oJ6XvZKWNIDh8JWreTrPobAu3wbHZO2Nba+hz/nw5UpJ
         kuB++U8p6z81LJ0e5o+dAitaw2Z6xb4cu+VvIsmlIbIeaiPmIp8Eyh9WJuMwWqMp7IVS
         lF51YXWE8tBfYAmxQ1JB7Pm1Gz/1H6Kolnha5/2/Oo1gA7KvL5sbbWf5cP1R2Im3NBay
         xP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YFO59fX7EPP/uO/HlrIPp45JUtgOHU1dmoFMJExfJlg=;
        b=BNbcXQFSH2CCsWE4i8s0S7xbckKhIVBQt7u+Oj4vIBXn1+mUm7oHhyU7995KOH6II9
         pX2ZeE/TRBKAcASAlupgH2slb5Z+YEWzCTTRdSWrA+QfMx6IS8B1sq9XD3JT+VQRSIeS
         Z4utlBRtwHiPQTeCLtYgLCUXayRKMS2MuTDv7YnhUtbL1uq98x//o4YlXOb/NUDGCvNN
         5LCjFWTwmRgkZHGF86wPBcyofXVvjxRGjpt77nh1/K3tqlRlgB4JwMz0g8QA8Bfbs/zp
         LIDX8BWgUx+6UmJNAwxJa1F6IyK+A7sJNn4DYjBYR/hVtWp4frKOF8Q1fvBwUy8mZym5
         pvbQ==
X-Gm-Message-State: AGRZ1gIcQbIzC/daJm0ofZbA7RZm4oOOSyQzw7vAe3sK0bAu3PHJlbyE
        2Am4FsjbWu7QyXRwKonyv2r/yLmZxau8oLIB5u13XA==
X-Google-Smtp-Source: AJdET5ffarvpmQM8b0S3au7iZZuluL8iR97GE2jAp2GWHjVTuYwLGVNKkZo69IAr1FuOre3N2ri/v3IEmVdenHZkpBwGJA==
X-Received: by 2002:a9d:5387:: with SMTP id w7mr323250otg.22.1540339207103;
 Tue, 23 Oct 2018 17:00:07 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:48 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 12/14] kunit.py: improve output from python wrapper
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add colors to displayed output
- add timing and summary

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 20 ++++++-
 tools/testing/kunit/kunit_parser.py | 93 ++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 1356be404996b..b36c7b7924567 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -6,6 +6,7 @@
 import argparse
 import sys
 import os
+import time
 
 import kunit_config
 import kunit_kernel
@@ -24,17 +25,32 @@ parser.add_argument('--timeout', help='maximum number of seconds to allow for '
 cli_args = parser.parse_args()
 linux = kunit_kernel.LinuxSourceTree()
 
+config_start = time.time()
 success = linux.build_reconfig()
+config_end = time.time()
 if not success:
 	quit()
 
-print('Building KUnit Kernel ...')
+kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+
+build_start = time.time()
 success = linux.build_um_kernel()
+build_end = time.time()
 if not success:
 	quit()
 
-print('Starting KUnit Kernel ...')
+kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
+test_start = time.time()
+
 if cli_args.raw_output:
 	kunit_parser.raw_output(linux.run_kernel(timeout=cli_args.timeout))
 else:
 	kunit_parser.parse_run_tests(linux.run_kernel(timeout=cli_args.timeout))
+
+test_end = time.time()
+
+kunit_parser.print_with_timestamp((
+	"Elapsed time: %.3fs total, %.3fs configuring, %.3fs " +
+	"building, %.3fs running.\n") % (test_end - config_start,
+	config_end - config_start, build_end - build_start,
+	test_end - test_start))
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 1dff3adb73bd3..d9051e407d5a7 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import re
+from datetime import datetime
 
 kunit_start_re = re.compile('console .* enabled')
 kunit_end_re = re.compile('List of all partitions:')
@@ -19,6 +20,94 @@ def raw_output(kernel_output):
 	for line in kernel_output:
 		print(line)
 
+DIVIDER = "=" * 30
+
+RESET = '\033[0;0m'
+
+def red(text):
+	return '\033[1;31m' + text + RESET
+
+def yellow(text):
+	return '\033[1;33m' + text + RESET
+
+def green(text):
+	return '\033[1;32m' + text + RESET
+
+def print_with_timestamp(message):
+	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+
+def print_log(log):
+	for m in log:
+		print_with_timestamp(m)
+
 def parse_run_tests(kernel_output):
-	for output in isolate_kunit_output(kernel_output):
-		print(output)
+	test_case_output = re.compile('^kunit .*?: (.*)$')
+
+	test_module_success = re.compile('^kunit .*: all tests passed')
+	test_module_fail = re.compile('^kunit .*: one or more tests failed')
+
+	test_case_success = re.compile('^kunit (.*): (.*) passed')
+	test_case_fail = re.compile('^kunit (.*): (.*) failed')
+	test_case_crash = re.compile('^kunit (.*): (.*) crashed')
+
+	total_tests = set()
+	failed_tests = set()
+	crashed_tests = set()
+
+	def get_test_name(match):
+		return match.group(1) + ":" + match.group(2)
+
+	current_case_log = []
+	def end_one_test(match, log):
+		log.clear()
+		total_tests.add(get_test_name(match))
+
+	print_with_timestamp(DIVIDER)
+	for line in isolate_kunit_output(kernel_output):
+		# Ignore module output:
+		if (test_module_success.match(line) or
+		    test_module_fail.match(line)):
+			print_with_timestamp(DIVIDER)
+			continue
+
+		match = re.match(test_case_success, line)
+		if match:
+			print_with_timestamp(green("[PASSED] ") +
+					     get_test_name(match))
+			end_one_test(match, current_case_log)
+			continue
+
+		match = re.match(test_case_fail, line)
+		# Crashed tests will report as both failed and crashed. We only
+		# want to show and count it once.
+		if match and get_test_name(match) not in crashed_tests:
+			failed_tests.add(get_test_name(match))
+			print_with_timestamp(red("[FAILED] " +
+						 get_test_name(match)))
+			print_log(map(yellow, current_case_log))
+			print_with_timestamp("")
+			end_one_test(match, current_case_log)
+			continue
+
+		match = re.match(test_case_crash, line)
+		if match:
+			crashed_tests.add(get_test_name(match))
+			print_with_timestamp(yellow("[CRASH] " +
+						    get_test_name(match)))
+			print_log(current_case_log)
+			print_with_timestamp("")
+			end_one_test(match, current_case_log)
+			continue
+
+		# Strip off the `kunit module-name:` prefix
+		match = re.match(test_case_output, line)
+		if match:
+			current_case_log.append(match.group(1))
+		else:
+			current_case_log.append(line)
+
+	fmt = green if (len(failed_tests) + len(crashed_tests) == 0) else red
+	print_with_timestamp(
+		fmt("Testing complete. %d tests run. %d failed. %d crashed." %
+		    (len(total_tests), len(failed_tests), len(crashed_tests))))
+
-- 
2.19.1.568.g152ad8e336-goog

