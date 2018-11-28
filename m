Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A5AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009D20864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVg5n/fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F009D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeK2Gk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:40:58 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44441 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbeK2Gk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:40:58 -0500
Received: by mail-pg1-f201.google.com with SMTP id a2so12710228pgt.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PSWj5cFU+jrigLyNwOIkjVkSQOjGgnr+grtJvw72p2k=;
        b=ZVg5n/fJ90O5sJ3IAOCgBQT0Y735goRSISlmv+c+yyF4e39VXUeukE1DtCXZgiFsws
         3CywqLzYt/Xhiav0fZQYXuP0MBPa2nj7xGUqjl4yl6PkgRF46WyaNehaXEstMd/0ZPco
         VTeAOL/V+elEzDVz8z+IOR1L3qbY93bwZ/KLsOrNx4lPYIJw6R+nr+w1Bow/TVkgE3+o
         BbHyFCw6lvIp1p/XeyiTcwpouOAogKZFDv1/WBmGooPKp1CAggkUUd+xFA//d4OZe+rO
         kNdACscRvJZ+9+nUv6754NjbTu0ZDERwEC42qfElTYMeQmt85QBlULjbj4UXeWOt1QPD
         RdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PSWj5cFU+jrigLyNwOIkjVkSQOjGgnr+grtJvw72p2k=;
        b=Y6fgJ1+FUmayNSOd35OahDIxj01eo2YR2I36ExOeUZxfc2ypldlvspYQTYISay0PIp
         u6VFhw+52M4Bnee/RnNcggrM8CdJZag9g1hj0wT3MDvHc/uPyn6d7Fxo05BUkHUD7xQp
         GwSP1SW5R2gT/rAx+sXl9hm7+v60Lt03kzAQKYc/ZQAkSVGPr0hAGI4DBkid4hyan0i7
         dTR9dvnc7cB2Nv+ub8/BZ5aARNp938va1kfOJBsgg8huLv5eYWPKJ7pfSkQy5Lp4OSmn
         TK3jPHjFvV45pG8+sddMQRU3m5R8StrqLk+iTjqI1Kcw8jJFsMKoduVefo+iOrnIyGcY
         ISHQ==
X-Gm-Message-State: AA+aEWYp7Es0AFcHAh0mEzNO/At85mXE4Zta0cd0drbtQq8FeOew7HIj
        96e1LplezPUBVa+xDqlpPJswC6Zv6Ek3vE4EOtLkmw==
X-Google-Smtp-Source: AFSGD/UNL8VzMXvdy/txBvVB+FEhEs2NNoQ9cq2xnih5rgsgUaCtXAFa837C43GfxD4knn2v0XS0RHUhlr4yWXZK/F1pTA==
X-Received: by 2002:a63:b601:: with SMTP id j1mr2949103pgf.58.1543433893299;
 Wed, 28 Nov 2018 11:38:13 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:29 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 12/19] kunit: add KUnit wrapper script and simple output parser
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

The KUnit wrapper script interfaces with the two modules
(kunit_config.py and kunit_kernel.py) and provides a command line
interface for running KUnit tests. This interface allows the caller to
specify options like test timeouts. The script handles configuring,
building and running the kernel and tests.

The output parser (kunit_parser.py) simply strips out all the output
from the kernel that is outputted as part of it's initialization
sequence. This ensures that only the output from KUnit is displayed
on the screen.

A full version of the output is written to test.log, or can be seen by
passing --raw_output to the wrapper script.

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 40 +++++++++++++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  3 +--
 tools/testing/kunit/kunit_parser.py | 24 +++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/kunit/kunit.py
 create mode 100644 tools/testing/kunit/kunit_parser.py

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
new file mode 100755
index 0000000000000..1356be404996b
--- /dev/null
+++ b/tools/testing/kunit/kunit.py
@@ -0,0 +1,40 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+
+# A thin wrapper on top of the KUnit Kernel
+
+import argparse
+import sys
+import os
+
+import kunit_config
+import kunit_kernel
+import kunit_parser
+
+parser = argparse.ArgumentParser(description='Runs KUnit tests.')
+
+parser.add_argument('--raw_output', help='don\'t format output from kernel',
+		    action='store_true')
+
+parser.add_argument('--timeout', help='maximum number of seconds to allow for '
+		    'all tests to run. This does not include time taken to '
+		    'build the tests.', type=int, default=300,
+		    metavar='timeout')
+
+cli_args = parser.parse_args()
+linux = kunit_kernel.LinuxSourceTree()
+
+success = linux.build_reconfig()
+if not success:
+	quit()
+
+print('Building KUnit Kernel ...')
+success = linux.build_um_kernel()
+if not success:
+	quit()
+
+print('Starting KUnit Kernel ...')
+if cli_args.raw_output:
+	kunit_parser.raw_output(linux.run_kernel(timeout=cli_args.timeout))
+else:
+	kunit_parser.parse_run_tests(linux.run_kernel(timeout=cli_args.timeout))
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bba7ea7ca1869..623f25b16f6c8 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -116,8 +116,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def run_kernel(self, args=[]):
-		timeout = None
+	def run_kernel(self, args=[], timeout=None):
 		args.extend(['mem=256M'])
 		process = self._ops.linux_bin(args, timeout)
 		with open('test.log', 'w') as f:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
new file mode 100644
index 0000000000000..1dff3adb73bd3
--- /dev/null
+++ b/tools/testing/kunit/kunit_parser.py
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import re
+
+kunit_start_re = re.compile('console .* enabled')
+kunit_end_re = re.compile('List of all partitions:')
+
+def isolate_kunit_output(kernel_output):
+	started = False
+	for line in kernel_output:
+		if kunit_start_re.match(line):
+			started = True
+		elif kunit_end_re.match(line):
+			break
+		elif started:
+			yield line
+
+def raw_output(kernel_output):
+	for line in kernel_output:
+		print(line)
+
+def parse_run_tests(kernel_output):
+	for output in isolate_kunit_output(kernel_output):
+		print(output)
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

