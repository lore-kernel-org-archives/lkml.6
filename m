Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DBF20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DBF20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeKAS7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:59:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:59:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA19v4na2765565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Nov 2018 02:57:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA19v4Y62765562;
        Thu, 1 Nov 2018 02:57:04 -0700
Date:   Thu, 1 Nov 2018 02:57:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-85f8507192fbfb4ad2ac01de879cb50045f4247f@git.kernel.org>
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, mark.rutland@arm.com, boqun.feng@gmail.com
In-Reply-To: <20180904104830.2975-6-mark.rutland@arm.com>
References: <20180904104830.2975-6-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Check generated headers are
 up-to-date
Git-Commit-ID: 85f8507192fbfb4ad2ac01de879cb50045f4247f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  85f8507192fbfb4ad2ac01de879cb50045f4247f
Gitweb:     https://git.kernel.org/tip/85f8507192fbfb4ad2ac01de879cb50045f4247f
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Tue, 4 Sep 2018 11:48:29 +0100
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 1 Nov 2018 10:48:19 +0100

locking/atomics: Check generated headers are up-to-date

Now that all the generated atomic headers are in place, it would be good
to ensure that:

a) the headers are up-to-date when scripting changes.

b) developers don't directly modify the generated headers.

To ensure both of these properties, let's add a Kbuild step to check
that the generated headers are up-to-date.

Cc: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linuxdrivers@attotech.com
Cc: dvyukov@google.com
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: glider@google.com
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180904104830.2975-6-mark.rutland@arm.com
---
 Kbuild                          | 18 ++++++++++++++++--
 scripts/atomic/check-atomics.sh | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Kbuild b/Kbuild
index 005304205482..47c9fe175bd9 100644
--- a/Kbuild
+++ b/Kbuild
@@ -6,7 +6,8 @@
 # 2) Generate timeconst.h
 # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
 # 4) Check for missing system calls
-# 5) Generate constants.py (may need bounds.h)
+# 5) check atomics headers are up-to-date
+# 6) Generate constants.py (may need bounds.h)
 
 #####
 # 1) Generate bounds.h
@@ -72,7 +73,20 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 	$(call cmd,syscalls)
 
 #####
-# 5) Generate constants for Python GDB integration
+# 5) Check atomic headers are up-to-date
+#
+
+always += old-atomics
+targets += old-atomics
+
+quiet_cmd_atomics = CALL    $<
+      cmd_atomics = $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+
+old-atomics: scripts/atomic/check-atomics.sh FORCE
+	$(call cmd,atomics)
+
+#####
+# 6) Generate constants for Python GDB integration
 #
 
 extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
new file mode 100644
index 000000000000..c30101cddf2d
--- /dev/null
+++ b/scripts/atomic/check-atomics.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if atomic headers are up-to-date
+
+ATOMICDIR=$(dirname $0)
+ATOMICTBL=${ATOMICDIR}/atomics.tbl
+LINUXDIR=${ATOMICDIR}/../..
+
+cat <<EOF |
+gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
+gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-fallback.h
+EOF
+while read script header; do
+	if ! (${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
+		printf "warning: include/${header} is out-of-date.\n"
+	fi
+done
