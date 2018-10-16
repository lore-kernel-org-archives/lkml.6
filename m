Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4237CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6752087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFgOnFqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6752087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJQHrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:48 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41775 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeJQHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:47 -0400
Received: by mail-vk1-f201.google.com with SMTP id g190-v6so6837741vkf.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b78I6LKXjAodHUg1SMFyP1EtiuoqQQpIaEv86gV4Xbc=;
        b=MFgOnFqNwee3qTqac0+1kGkl0rS+vYGvFIBLBufRfS3v1MXYhn22rsjgmcf11NzfKb
         6vIzxA5cHEUZtogrsugVhk0X+fCnrwD0sn0GQ/e/u1WuLEn2VaybNHXot4Q4T67CWL8P
         /W6ZtQ/keAdQ2Sltw52cXo/2I+yjSyuTdfg2jw0mi5EkpY5gKg+WanunU6o1qrHeCdgv
         avoH4eG6Ah64+dwj2C98wAan5tXz1n470+Dy5k6jrxzvQ58MbzfZ1OjTQGoOGD+TPufz
         zd9h5aiF0nwj2vFWNUXCQiBBCarUOVN7UYjKu/VuIJngDm52b8v5CFbEgg1oYoXtkfj0
         Ugrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b78I6LKXjAodHUg1SMFyP1EtiuoqQQpIaEv86gV4Xbc=;
        b=h5Kb/v7tKiMW/RQFgj99ZLjaxy02tDcli/F/oZbbsMYnasxVhrPuxOEoiogKNt4qeQ
         udCSE/4QOUmf5cKABI4UuXLU66vPmEH8xho68F7Hq7R4SIOVypHW1MdUIaLzK84W76Au
         11baTaUXUuFtKZOsXTUpACkX1XCdmlGIjc6urhI+J7rjufN7ZeW+KW1bzKU4CjuQA3Gu
         qAGip28SY1sZgRN7rQeItdGJYwMp8gw8U7lUeCru83yxttL+fvgOZu7lgMNir/VlrLwK
         LOS6/XQovLInkn1mlZn2pkRYOZxX2hTQJoOy3L2+bvKNP6eLUo2vPzAG+Y5PZrJ3moAS
         qsEg==
X-Gm-Message-State: ABuFfoha0QmSiHaJKHvdo1OrvTHM25vSAZR/U0KqesJEZRnwLUzwGkQ4
        4VisTB3sRb7zAW5eD+bvrXlUf51a9EoFanKP8Mfabg==
X-Google-Smtp-Source: ACcGV625MofNGMvfOzo8UkZmTs25veQzMn5HpPhVQdFoT4Fqjoc0uo2vdAsUhJJMhyisfsXRetfoFMHpRW53BERU3en0xA==
X-Received: by 2002:a1f:720f:: with SMTP id n15mr4022284vkc.5.1539734097147;
 Tue, 16 Oct 2018 16:54:57 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:18 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-30-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 29/31] kunit: added KUnit wrapper script and simple output parser
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>,
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
index 87abaede50513..c1259b174f7d4 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -113,8 +113,7 @@ class LinuxSourceTree(object):
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
2.19.1.331.ge82ca0e54c-goog

