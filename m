Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A2AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BD425C95
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BD425C95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbeFZK31 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:29:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54745 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934634AbeFZK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:29:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QASOU81648523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:28:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QASONW1648518;
        Tue, 26 Jun 2018 03:28:24 -0700
Date:   Tue, 26 Jun 2018 03:28:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-8c449753a681517f0e6f877aad8539ac4c71757d@git.kernel.org>
Cc:     peterz@infradead.org, catalin.marinas@arm.com, chris@zankel.net,
        will.deacon@arm.com, mpe@ellerman.id.au, luto@kernel.org,
        acme@redhat.com, mark.rutland@arm.com, mingo@kernel.org,
        joel.opensrc@gmail.com, tglx@linutronix.de, acme@kernel.org,
        benh@kernel.crashing.org, namhyung@kernel.org, jcmvbkbc@gmail.com,
        ysato@users.sourceforge.jp, paulus@samba.org, dalias@libc.org,
        hpa@zytor.com, frederic@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, catalin.marinas@arm.com,
          mpe@ellerman.id.au, luto@kernel.org, will.deacon@arm.com,
          chris@zankel.net, acme@redhat.com, mark.rutland@arm.com,
          joel.opensrc@gmail.com, tglx@linutronix.de, mingo@kernel.org,
          acme@kernel.org, namhyung@kernel.org, jcmvbkbc@gmail.com,
          benh@kernel.crashing.org, paulus@samba.org, dalias@libc.org,
          ysato@users.sourceforge.jp, jolsa@redhat.com,
          frederic@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org
In-Reply-To: <1529981939-8231-7-git-send-email-frederic@kernel.org>
References: <1529981939-8231-7-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/arm64: Implement
 hw_breakpoint_arch_parse()
Git-Commit-ID: 8c449753a681517f0e6f877aad8539ac4c71757d
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

Commit-ID:  8c449753a681517f0e6f877aad8539ac4c71757d
Gitweb:     https://git.kernel.org/tip/8c449753a681517f0e6f877aad8539ac4c71757d
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:53 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:56 +0200

perf/arch/arm64: Implement hw_breakpoint_arch_parse()

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-7-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/hw_breakpoint.h |  6 ++-
 arch/arm64/kernel/hw_breakpoint.c      | 79 +++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 9f4a3d48762e..bf9c305daa62 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -119,13 +119,17 @@ static inline void decode_ctrl_reg(u32 reg,
 
 struct task_struct;
 struct notifier_block;
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type, int *offset);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 6a90d12e4ff2..8c9644376326 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -420,53 +420,53 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
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
 	case HW_BREAKPOINT_LEN_3:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_3;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_3;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		break;
 	case HW_BREAKPOINT_LEN_5:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_5;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_5;
 		break;
 	case HW_BREAKPOINT_LEN_6:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_6;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_6;
 		break;
 	case HW_BREAKPOINT_LEN_7:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_7;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_7;
 		break;
 	case HW_BREAKPOINT_LEN_8:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_8;
 		break;
 	default:
 		return -EINVAL;
@@ -477,37 +477,37 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * AArch32 also requires breakpoints of length 2 for Thumb.
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
-	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
+	if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
 		if (is_compat_bp(bp)) {
-			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
-			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
+			if (hw->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
+			    hw->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
-		} else if (info->ctrl.len != ARM_BREAKPOINT_LEN_4) {
+		} else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
 			/*
 			 * FIXME: Some tools (I'm looking at you perf) assume
 			 *	  that breakpoints should be sizeof(long). This
 			 *	  is nonsense. For now, we fix up the parameter
 			 *	  but we should probably return -EINVAL instead.
 			 */
-			info->ctrl.len = ARM_BREAKPOINT_LEN_4;
+			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		}
 	}
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
 
 	/*
 	 * Privilege
 	 * Note that we disallow combined EL0/EL1 breakpoints because
 	 * that would complicate the stepping code.
 	 */
-	if (arch_check_bp_in_kernelspace(info))
-		info->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
+	if (arch_check_bp_in_kernelspace(hw))
+		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
 	else
-		info->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
+		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
 
 	/* Enabled? */
-	info->ctrl.enabled = !bp->attr.disabled;
+	hw->ctrl.enabled = !attr->disabled;
 
 	return 0;
 }
@@ -515,14 +515,15 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings.
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	int ret;
 	u64 alignment_mask, offset;
 
 	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		return ret;
 
@@ -536,42 +537,42 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * that here.
 	 */
 	if (is_compat_bp(bp)) {
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
+		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
 			alignment_mask = 0x3;
-		offset = info->address & alignment_mask;
+		offset = hw->address & alignment_mask;
 		switch (offset) {
 		case 0:
 			/* Aligned */
 			break;
 		case 1:
 			/* Allow single byte watchpoint. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
 				break;
 		case 2:
 			/* Allow halfword watchpoints and breakpoints. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
+			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 				break;
 		default:
 			return -EINVAL;
 		}
 	} else {
-		if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE)
+		if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE)
 			alignment_mask = 0x3;
 		else
 			alignment_mask = 0x7;
-		offset = info->address & alignment_mask;
+		offset = hw->address & alignment_mask;
 	}
 
-	info->address &= ~alignment_mask;
-	info->ctrl.len <<= offset;
+	hw->address &= ~alignment_mask;
+	hw->ctrl.len <<= offset;
 
 	/*
 	 * Disallow per-task kernel breakpoints since these would
 	 * complicate the stepping code.
 	 */
-	if (info->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
+	if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
 		return -EINVAL;
 
 	return 0;
