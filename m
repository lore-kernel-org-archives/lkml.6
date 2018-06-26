Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0D726913
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0D726913
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934838AbeFZK1l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:27:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934154AbeFZK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:27:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAQf8t1648218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:26:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAQf601648214;
        Tue, 26 Jun 2018 03:26:41 -0700
Date:   Tue, 26 Jun 2018 03:26:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-a0baf043c5cfa3a489a63ac50f5201c31a651e21@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ysato@users.sourceforge.jp, benh@kernel.crashing.org,
        jcmvbkbc@gmail.com, mark.rutland@arm.com, chris@zankel.net,
        hpa@zytor.com, catalin.marinas@arm.com, dalias@libc.org,
        frederic@kernel.org, will.deacon@arm.com, jolsa@redhat.com,
        mpe@ellerman.id.au, mingo@kernel.org, luto@kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, acme@kernel.org,
        peterz@infradead.org, paulus@samba.org, joel.opensrc@gmail.com
Reply-To: dalias@libc.org, catalin.marinas@arm.com, hpa@zytor.com,
          chris@zankel.net, mark.rutland@arm.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          benh@kernel.crashing.org, jcmvbkbc@gmail.com,
          ysato@users.sourceforge.jp, peterz@infradead.org,
          acme@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, joel.opensrc@gmail.com,
          paulus@samba.org, jolsa@redhat.com, frederic@kernel.org,
          will.deacon@arm.com, acme@redhat.com, mingo@kernel.org,
          luto@kernel.org, mpe@ellerman.id.au
In-Reply-To: <1529981939-8231-4-git-send-email-frederic@kernel.org>
References: <1529981939-8231-4-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/x86: Implement hw_breakpoint_arch_parse()
Git-Commit-ID: a0baf043c5cfa3a489a63ac50f5201c31a651e21
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

Commit-ID:  a0baf043c5cfa3a489a63ac50f5201c31a651e21
Gitweb:     https://git.kernel.org/tip/a0baf043c5cfa3a489a63ac50f5201c31a651e21
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:50 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:55 +0200

perf/arch/x86: Implement hw_breakpoint_arch_parse()

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit.

Original-patch-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-4-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/hw_breakpoint.h |  6 +++-
 arch/x86/kernel/hw_breakpoint.c      | 60 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 78924596f51f..6c88e8e22678 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -49,11 +49,15 @@ static inline int hw_breakpoint_slots(int type)
 	return HBP_NUM;
 }
 
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index c43379188f4f..34a5c1715148 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -239,19 +239,20 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
 }
 
-static int arch_build_bp_info(struct perf_event *bp)
+static int arch_build_bp_info(struct perf_event *bp,
+			      const struct perf_event_attr *attr,
+			      struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
+	hw->mask = 0;
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_W:
-		info->type = X86_BREAKPOINT_WRITE;
+		hw->type = X86_BREAKPOINT_WRITE;
 		break;
 	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
-		info->type = X86_BREAKPOINT_RW;
+		hw->type = X86_BREAKPOINT_RW;
 		break;
 	case HW_BREAKPOINT_X:
 		/*
@@ -259,23 +260,23 @@ static int arch_build_bp_info(struct perf_event *bp)
 		 * acceptable for kprobes.  On non-kprobes kernels, we don't
 		 * allow kernel breakpoints at all.
 		 */
-		if (bp->attr.bp_addr >= TASK_SIZE_MAX) {
+		if (attr->bp_addr >= TASK_SIZE_MAX) {
 #ifdef CONFIG_KPROBES
-			if (within_kprobe_blacklist(bp->attr.bp_addr))
+			if (within_kprobe_blacklist(attr->bp_addr))
 				return -EINVAL;
 #else
 			return -EINVAL;
 #endif
 		}
 
-		info->type = X86_BREAKPOINT_EXECUTE;
+		hw->type = X86_BREAKPOINT_EXECUTE;
 		/*
 		 * x86 inst breakpoints need to have a specific undefined len.
 		 * But we still need to check userspace is not trying to setup
 		 * an unsupported length, to get a range breakpoint for example.
 		 */
-		if (bp->attr.bp_len == sizeof(long)) {
-			info->len = X86_BREAKPOINT_LEN_X;
+		if (attr->bp_len == sizeof(long)) {
+			hw->len = X86_BREAKPOINT_LEN_X;
 			return 0;
 		}
 	default:
@@ -283,28 +284,26 @@ static int arch_build_bp_info(struct perf_event *bp)
 	}
 
 	/* Len */
-	info->mask = 0;
-
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->len = X86_BREAKPOINT_LEN_1;
+		hw->len = X86_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->len = X86_BREAKPOINT_LEN_2;
+		hw->len = X86_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->len = X86_BREAKPOINT_LEN_4;
+		hw->len = X86_BREAKPOINT_LEN_4;
 		break;
 #ifdef CONFIG_X86_64
 	case HW_BREAKPOINT_LEN_8:
-		info->len = X86_BREAKPOINT_LEN_8;
+		hw->len = X86_BREAKPOINT_LEN_8;
 		break;
 #endif
 	default:
 		/* AMD range breakpoint */
-		if (!is_power_of_2(bp->attr.bp_len))
+		if (!is_power_of_2(attr->bp_len))
 			return -EINVAL;
-		if (bp->attr.bp_addr & (bp->attr.bp_len - 1))
+		if (attr->bp_addr & (attr->bp_len - 1))
 			return -EINVAL;
 
 		if (!boot_cpu_has(X86_FEATURE_BPEXT))
@@ -317,8 +316,8 @@ static int arch_build_bp_info(struct perf_event *bp)
 		 * breakpoints, then we'll have to check for kprobe-blacklisted
 		 * addresses anywhere in the range.
 		 */
-		info->mask = bp->attr.bp_len - 1;
-		info->len = X86_BREAKPOINT_LEN_1;
+		hw->mask = attr->bp_len - 1;
+		hw->len = X86_BREAKPOINT_LEN_1;
 	}
 
 	return 0;
@@ -327,22 +326,23 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	unsigned int align;
 	int ret;
 
 
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		return ret;
 
-	switch (info->len) {
+	switch (hw->len) {
 	case X86_BREAKPOINT_LEN_1:
 		align = 0;
-		if (info->mask)
-			align = info->mask;
+		if (hw->mask)
+			align = hw->mask;
 		break;
 	case X86_BREAKPOINT_LEN_2:
 		align = 1;
@@ -363,7 +363,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * Check that the low-order bits of the address are appropriate
 	 * for the alignment implied by len.
 	 */
-	if (info->address & align)
+	if (hw->address & align)
 		return -EINVAL;
 
 	return 0;
