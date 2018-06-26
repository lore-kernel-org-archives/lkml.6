Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126E25C02
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B126E25C02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964962AbeFZK2p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:28:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934696AbeFZK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:28:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QARlaN1648471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:27:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QARlBf1648468;
        Tue, 26 Jun 2018 03:27:47 -0700
Date:   Tue, 26 Jun 2018 03:27:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-9d52718cd392a94414f0ce780d9bae3ed518ab34@git.kernel.org>
Cc:     paulus@samba.org, will.deacon@arm.com, mingo@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com,
        joel.opensrc@gmail.com, peterz@infradead.org, luto@kernel.org,
        chris@zankel.net, jcmvbkbc@gmail.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        catalin.marinas@arm.com, alexander.shishkin@linux.intel.com,
        ysato@users.sourceforge.jp, frederic@kernel.org, dalias@libc.org,
        namhyung@kernel.org, benh@kernel.crashing.org, acme@redhat.com,
        jolsa@redhat.com
Reply-To: frederic@kernel.org, ysato@users.sourceforge.jp,
          namhyung@kernel.org, dalias@libc.org, jolsa@redhat.com,
          acme@redhat.com, benh@kernel.crashing.org, tglx@linutronix.de,
          mark.rutland@arm.com, mingo@kernel.org, will.deacon@arm.com,
          paulus@samba.org, peterz@infradead.org,
          torvalds@linux-foundation.org, joel.opensrc@gmail.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
          jcmvbkbc@gmail.com, luto@kernel.org, chris@zankel.net,
          catalin.marinas@arm.com, alexander.shishkin@linux.intel.com,
          acme@kernel.org
In-Reply-To: <1529981939-8231-6-git-send-email-frederic@kernel.org>
References: <1529981939-8231-6-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/arm: Implement hw_breakpoint_arch_parse()
Git-Commit-ID: 9d52718cd392a94414f0ce780d9bae3ed518ab34
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

Commit-ID:  9d52718cd392a94414f0ce780d9bae3ed518ab34
Gitweb:     https://git.kernel.org/tip/9d52718cd392a94414f0ce780d9bae3ed518ab34
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:52 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:56 +0200

perf/arch/arm: Implement hw_breakpoint_arch_parse()

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-6-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/hw_breakpoint.h |  6 ++-
 arch/arm/kernel/hw_breakpoint.c      | 71 ++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index d5a0f52c6755..1e02925c11f4 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -111,6 +111,7 @@ static inline void decode_ctrl_reg(u32 reg,
 	asm volatile("mcr p14, 0, %0, " #N "," #M ", " #OP2 : : "r" (VAL));\
 } while (0)
 
+struct perf_event_attr;
 struct notifier_block;
 struct perf_event;
 struct pmu;
@@ -118,7 +119,10 @@ struct pmu;
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 385dcf45d64b..1d5fbf1d1c67 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -517,42 +517,42 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+static int arch_build_bp_info(struct perf_event *bp,
+			      const struct perf_event_attr *attr,
+			      struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
-		info->ctrl.type = ARM_BREAKPOINT_EXECUTE;
+		hw->ctrl.type = ARM_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:
-		info->ctrl.type = ARM_BREAKPOINT_LOAD;
+		hw->ctrl.type = ARM_BREAKPOINT_LOAD;
 		break;
 	case HW_BREAKPOINT_W:
-		info->ctrl.type = ARM_BREAKPOINT_STORE;
+		hw->ctrl.type = ARM_BREAKPOINT_STORE;
 		break;
 	case HW_BREAKPOINT_RW:
-		info->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
+		hw->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_1;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_2;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		break;
 	case HW_BREAKPOINT_LEN_8:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
-		if ((info->ctrl.type != ARM_BREAKPOINT_EXECUTE)
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_8;
+		if ((hw->ctrl.type != ARM_BREAKPOINT_EXECUTE)
 			&& max_watchpoint_len >= 8)
 			break;
 	default:
@@ -565,24 +565,24 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * by the hardware and must be aligned to the appropriate number of
 	 * bytes.
 	 */
-	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE &&
-	    info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
-	    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
+	if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE &&
+	    hw->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
+	    hw->ctrl.len != ARM_BREAKPOINT_LEN_4)
 		return -EINVAL;
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
 
 	/* Privilege */
-	info->ctrl.privilege = ARM_BREAKPOINT_USER;
-	if (arch_check_bp_in_kernelspace(info))
-		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
+	hw->ctrl.privilege = ARM_BREAKPOINT_USER;
+	if (arch_check_bp_in_kernelspace(hw))
+		hw->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
 
 	/* Enabled? */
-	info->ctrl.enabled = !bp->attr.disabled;
+	hw->ctrl.enabled = !attr->disabled;
 
 	/* Mismatch */
-	info->ctrl.mismatch = 0;
+	hw->ctrl.mismatch = 0;
 
 	return 0;
 }
@@ -590,9 +590,10 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings.
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	int ret = 0;
 	u32 offset, alignment_mask = 0x3;
 
@@ -601,14 +602,14 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		return -ENODEV;
 
 	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		goto out;
 
 	/* Check address alignment. */
-	if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
+	if (hw->ctrl.len == ARM_BREAKPOINT_LEN_8)
 		alignment_mask = 0x7;
-	offset = info->address & alignment_mask;
+	offset = hw->address & alignment_mask;
 	switch (offset) {
 	case 0:
 		/* Aligned */
@@ -616,19 +617,19 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	case 1:
 	case 2:
 		/* Allow halfword watchpoints and breakpoints. */
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
+		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 			break;
 	case 3:
 		/* Allow single byte watchpoint. */
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
 			break;
 	default:
 		ret = -EINVAL;
 		goto out;
 	}
 
-	info->address &= ~alignment_mask;
-	info->ctrl.len <<= offset;
+	hw->address &= ~alignment_mask;
+	hw->ctrl.len <<= offset;
 
 	if (is_default_overflow_handler(bp)) {
 		/*
@@ -639,7 +640,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 			return -EINVAL;
 
 		/* We don't allow mismatch breakpoints in kernel space. */
-		if (arch_check_bp_in_kernelspace(info))
+		if (arch_check_bp_in_kernelspace(hw))
 			return -EPERM;
 
 		/*
@@ -654,8 +655,8 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		 * reports them.
 		 */
 		if (!debug_exception_updates_fsr() &&
-		    (info->ctrl.type == ARM_BREAKPOINT_LOAD ||
-		     info->ctrl.type == ARM_BREAKPOINT_STORE))
+		    (hw->ctrl.type == ARM_BREAKPOINT_LOAD ||
+		     hw->ctrl.type == ARM_BREAKPOINT_STORE))
 			return -EINVAL;
 	}
 
