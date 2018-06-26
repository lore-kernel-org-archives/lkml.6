Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153E726944
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153E726944
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934826AbeFZKbe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:31:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933789AbeFZKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:31:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QATZJg1648634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:29:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QATYif1648631;
        Tue, 26 Jun 2018 03:29:34 -0700
Date:   Tue, 26 Jun 2018 03:29:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-551624d6fc6b282cdcc3f8ab395cb03da0a38fc7@git.kernel.org>
Cc:     acme@kernel.org, mark.rutland@arm.com, luto@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        chris@zankel.net, will.deacon@arm.com, frederic@kernel.org,
        dalias@libc.org, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jcmvbkbc@gmail.com,
        linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp,
        namhyung@kernel.org, jolsa@redhat.com, acme@redhat.com,
        catalin.marinas@arm.com, mpe@ellerman.id.au, paulus@samba.org,
        benh@kernel.crashing.org
Reply-To: paulus@samba.org, benh@kernel.crashing.org,
          catalin.marinas@arm.com, mpe@ellerman.id.au, acme@redhat.com,
          jolsa@redhat.com, namhyung@kernel.org,
          ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
          jcmvbkbc@gmail.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, joel.opensrc@gmail.com,
          torvalds@linux-foundation.org, dalias@libc.org,
          frederic@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, chris@zankel.net, will.deacon@arm.com,
          mark.rutland@arm.com, luto@kernel.org, acme@kernel.org
In-Reply-To: <1529981939-8231-9-git-send-email-frederic@kernel.org>
References: <1529981939-8231-9-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/sh: Implement hw_breakpoint_arch_parse()
Git-Commit-ID: 551624d6fc6b282cdcc3f8ab395cb03da0a38fc7
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

Commit-ID:  551624d6fc6b282cdcc3f8ab395cb03da0a38fc7
Gitweb:     https://git.kernel.org/tip/551624d6fc6b282cdcc3f8ab395cb03da0a38fc7
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:55 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:57 +0200

perf/arch/sh: Implement hw_breakpoint_arch_parse()

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit

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
Link: http://lkml.kernel.org/r/1529981939-8231-9-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sh/include/asm/hw_breakpoint.h |  6 +++++-
 arch/sh/kernel/hw_breakpoint.c      | 37 +++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index dae622d9b10b..867edcc60e8f 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -40,6 +40,7 @@ struct sh_ubc {
 	struct clk	*clk;	/* optional interface clock / MSTP bit */
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct task_struct;
 struct pmu;
@@ -54,7 +55,10 @@ static inline int hw_breakpoint_slots(int type)
 
 /* arch/sh/kernel/hw_breakpoint.c */
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index c453a0cea3c2..d9ff3b42da7c 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -173,40 +173,40 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	return 0;
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
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->len = SH_BREAKPOINT_LEN_1;
+		hw->len = SH_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->len = SH_BREAKPOINT_LEN_2;
+		hw->len = SH_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->len = SH_BREAKPOINT_LEN_4;
+		hw->len = SH_BREAKPOINT_LEN_4;
 		break;
 	case HW_BREAKPOINT_LEN_8:
-		info->len = SH_BREAKPOINT_LEN_8;
+		hw->len = SH_BREAKPOINT_LEN_8;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_R:
-		info->type = SH_BREAKPOINT_READ;
+		hw->type = SH_BREAKPOINT_READ;
 		break;
 	case HW_BREAKPOINT_W:
-		info->type = SH_BREAKPOINT_WRITE;
+		hw->type = SH_BREAKPOINT_WRITE;
 		break;
 	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
-		info->type = SH_BREAKPOINT_RW;
+		hw->type = SH_BREAKPOINT_RW;
 		break;
 	default:
 		return -EINVAL;
@@ -218,19 +218,20 @@ static int arch_build_bp_info(struct perf_event *bp)
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
 
 	ret = -EINVAL;
 
-	switch (info->len) {
+	switch (hw->len) {
 	case SH_BREAKPOINT_LEN_1:
 		align = 0;
 		break;
@@ -251,7 +252,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * Check that the low-order bits of the address are appropriate
 	 * for the alignment implied by len.
 	 */
-	if (info->address & align)
+	if (hw->address & align)
 		return -EINVAL;
 
 	return 0;
