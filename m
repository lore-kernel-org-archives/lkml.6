Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ECBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F9526942
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F9526942
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbeFZKbO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:31:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933870AbeFZKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:31:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAU8ST1648872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:30:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAU8AR1648868;
        Tue, 26 Jun 2018 03:30:08 -0700
Date:   Tue, 26 Jun 2018 03:30:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-ac46c7fddef702dadae18c1fc932530cd31cf9cd@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        joel.opensrc@gmail.com, paulus@samba.org, frederic@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, dalias@libc.org,
        alexander.shishkin@linux.intel.com, chris@zankel.net,
        ysato@users.sourceforge.jp, torvalds@linux-foundation.org,
        acme@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        will.deacon@arm.com, namhyung@kernel.org, mark.rutland@arm.com,
        hpa@zytor.com, jolsa@redhat.com, jcmvbkbc@gmail.com
Reply-To: torvalds@linux-foundation.org, ysato@users.sourceforge.jp,
          peterz@infradead.org, chris@zankel.net, dalias@libc.org,
          alexander.shishkin@linux.intel.com, paulus@samba.org,
          joel.opensrc@gmail.com, linux-kernel@vger.kernel.org,
          catalin.marinas@arm.com, frederic@kernel.org, acme@kernel.org,
          mingo@kernel.org, tglx@linutronix.de, luto@kernel.org,
          jcmvbkbc@gmail.com, jolsa@redhat.com, hpa@zytor.com,
          namhyung@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
          acme@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org
In-Reply-To: <1529981939-8231-10-git-send-email-frederic@kernel.org>
References: <1529981939-8231-10-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/xtensa: Implement
 hw_breakpoint_arch_parse()
Git-Commit-ID: ac46c7fddef702dadae18c1fc932530cd31cf9cd
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

Commit-ID:  ac46c7fddef702dadae18c1fc932530cd31cf9cd
Gitweb:     https://git.kernel.org/tip/ac46c7fddef702dadae18c1fc932530cd31cf9cd
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:56 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:58 +0200

perf/arch/xtensa: Implement hw_breakpoint_arch_parse()

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
Link: http://lkml.kernel.org/r/1529981939-8231-10-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/xtensa/include/asm/hw_breakpoint.h |  6 +++++-
 arch/xtensa/kernel/hw_breakpoint.c      | 33 ++++++++++++---------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index 2525bf6816a6..f347c2132e6b 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -30,13 +30,17 @@ struct arch_hw_breakpoint {
 	u16 type;
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct pt_regs;
 struct task_struct;
 
 int hw_breakpoint_slots(int type);
 int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-int arch_validate_hwbkpt_settings(struct perf_event *bp);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
 
diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index 6e34c3848885..c2e387c19cda 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -47,50 +47,41 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
-		info->type = XTENSA_BREAKPOINT_EXECUTE;
+		hw->type = XTENSA_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:
-		info->type = XTENSA_BREAKPOINT_LOAD;
+		hw->type = XTENSA_BREAKPOINT_LOAD;
 		break;
 	case HW_BREAKPOINT_W:
-		info->type = XTENSA_BREAKPOINT_STORE;
+		hw->type = XTENSA_BREAKPOINT_STORE;
 		break;
 	case HW_BREAKPOINT_RW:
-		info->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
+		hw->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Len */
-	info->len = bp->attr.bp_len;
-	if (info->len < 1 || info->len > 64 || !is_power_of_2(info->len))
+	hw->len = attr->bp_len;
+	if (hw->len < 1 || hw->len > 64 || !is_power_of_2(hw->len))
 		return -EINVAL;
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
-	if (info->address & (info->len - 1))
+	hw->address = attr->bp_addr;
+	if (hw->address & (hw->len - 1))
 		return -EINVAL;
 
 	return 0;
 }
 
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int ret;
-
-	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
-	return ret;
-}
-
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data)
 {
