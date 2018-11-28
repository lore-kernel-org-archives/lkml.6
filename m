Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706BFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZFAhEFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6D42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeK2GlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:41:02 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:54974 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbeK2GlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:41:00 -0500
Received: by mail-it1-f202.google.com with SMTP id v3so4271059itf.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vAK0p7vKTuMPpezuXE/k7QGLFOufe8xVPHMWIxnzcOw=;
        b=HZFAhEFpsemMuzBPrmsGrjv52lptKO71UvLKo8R2cqvpqs1fsoXvzEW9M82vVbiG4I
         8lgm+sQr+xKpgGcI7n57+Iqp4EL/gw1tAT1r5AzBwEMUCY6uDx4HumzI5JusEDB9i0gT
         1aXleqwgLn8rIP+5OiJ8PMWwF9NrssiZgN5lGGKq+tgV+qhjf0N0IRW6EXo5QmczSDFv
         sfTS7DnEtq0yWfymSBjFNaRT2AnoJ0F1kMTq6CJvrMF6HNzvjc4JFjUQ1ZL1V67M+DbU
         KMzcuowcCU7kdr/QxmqyuYiHmsdeq/7YReCEQcungg8JXo/tErb0d4cugphcf/gfr7a4
         3+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vAK0p7vKTuMPpezuXE/k7QGLFOufe8xVPHMWIxnzcOw=;
        b=D1P0UswH8peupv7dmIsbe4IyT2AwlKPAiy5F7CswgO6RpVLK4HAJTtrjwHmNFjTBuU
         hUMNaLGGS0TGDLkP/Mqwe9Qp6kJ14J1riZiEYkzsJVjTEujD5QlOYY+BMmpIlGiKKOF9
         h9cEIefynSCwQWAkKQWFgIptQHELPFkKJI5z5cch2+U4kSzqyBiFmMuU4NEVxbO45N4O
         6yZYvLRkkAwu3E4T9uC9sPpcSwefBa0c/t3atRTZPUGu6vRHBqZ4eHZaNHk9o/G/wVxT
         GNd/DcXVAYC5GOZp37BigN52sLvRpcwfsHitL0mg96+QRsFQt6DKAmnpMYP4g3dg4JBk
         K8rA==
X-Gm-Message-State: AA+aEWacLDEFwoKBWgCrJ1Vrytrr/vVXBunw0FYzGyK1jP89v8Pb2Opn
        SCscVXJTGnP/JgtOokaVpf+kl4qlUgVHKlyoH4MKkQ==
X-Google-Smtp-Source: AFSGD/Ujo8L+z++cqBiX0TR/cZSdTP71zFmLdi9OlccxU3BUppjqS2CtoJDToemuwTkNGpAvvuqMQL2o2zW3kWe3LvqXRA==
X-Received: by 2002:a24:ac6c:: with SMTP id m44-v6mr3565488iti.40.1543433895704;
 Wed, 28 Nov 2018 11:38:15 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:30 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-14-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 13/19] kunit: improve output from python wrapper
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
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>,
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
 tools/testing/kunit/kunit.py        | 27 ++++++++-
 tools/testing/kunit/kunit_parser.py | 93 ++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 1356be404996b..0b8e8c20a746e 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -6,6 +6,7 @@
 import argparse
 import sys
 import os
+import time
 
 import kunit_config
 import kunit_kernel
@@ -21,20 +22,40 @@ parser.add_argument('--timeout', help='maximum number of seconds to allow for '
 		    'build the tests.', type=int, default=300,
 		    metavar='timeout')
 
+parser.add_argument('--jobs',
+		    help='As in the make command, "Specifies  the number of '
+		    'jobs (commands) to run simultaneously."',
+		    type=int, default=8, metavar='jobs')
+
 cli_args = parser.parse_args()
 linux = kunit_kernel.LinuxSourceTree()
 
+config_start = time.time()
 success = linux.build_reconfig()
+config_end = time.time()
 if not success:
 	quit()
 
-print('Building KUnit Kernel ...')
-success = linux.build_um_kernel()
+kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+
+build_start = time.time()
+success = linux.build_um_kernel(jobs=cli_args.jobs)
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
2.20.0.rc0.387.gc7a69e6b6c-goog

