Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B08C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E63826927
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E63826927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934892AbeFZK2O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:28:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933581AbeFZK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:28:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QARCTX1648415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:27:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QARCkQ1648412;
        Tue, 26 Jun 2018 03:27:12 -0700
Date:   Tue, 26 Jun 2018 03:27:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-5d5176baed7abf88bb465a128d414fa8748dcab7@git.kernel.org>
Cc:     acme@kernel.org, chris@zankel.net, tglx@linutronix.de,
        acme@redhat.com, frederic@kernel.org, ysato@users.sourceforge.jp,
        mark.rutland@arm.com, luto@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, peterz@infradead.org, hpa@zytor.com,
        dalias@libc.org, torvalds@linux-foundation.org, jcmvbkbc@gmail.com,
        alexander.shishkin@linux.intel.com, will.deacon@arm.com,
        namhyung@kernel.org, joel.opensrc@gmail.com, mingo@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Reply-To: mpe@ellerman.id.au, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          catalin.marinas@arm.com, namhyung@kernel.org,
          will.deacon@arm.com, joel.opensrc@gmail.com, jcmvbkbc@gmail.com,
          torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          hpa@zytor.com, dalias@libc.org, benh@kernel.crashing.org,
          luto@kernel.org, paulus@samba.org, ysato@users.sourceforge.jp,
          frederic@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
          acme@kernel.org, chris@zankel.net, acme@redhat.com
In-Reply-To: <1529981939-8231-5-git-send-email-frederic@kernel.org>
References: <1529981939-8231-5-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/powerpc: Implement
 hw_breakpoint_arch_parse()
Git-Commit-ID: 5d5176baed7abf88bb465a128d414fa8748dcab7
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

Commit-ID:  5d5176baed7abf88bb465a128d414fa8748dcab7
Gitweb:     https://git.kernel.org/tip/5d5176baed7abf88bb465a128d414fa8748dcab7
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:51 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:55 +0200

perf/arch/powerpc: Implement hw_breakpoint_arch_parse()

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-5-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h |  6 ++++-
 arch/powerpc/kernel/hw_breakpoint.c      | 41 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 4d0b1bfcdfd0..38ae180610bd 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -52,6 +52,7 @@ struct arch_hw_breakpoint {
 #include <asm/reg.h>
 #include <asm/debug.h>
 
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 struct perf_sample_data;
@@ -61,7 +62,10 @@ struct perf_sample_data;
 extern int hw_breakpoint_slots(int type);
 extern int arch_bp_generic_fields(int type, int *gen_bp_type);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 899bcec3f3c8..fec8a6773119 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -139,30 +139,31 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
 /*
  * Validate the arch-specific HW Breakpoint register settings
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
 	int ret = -EINVAL, length_max;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
 	if (!bp)
 		return ret;
 
-	info->type = HW_BRK_TYPE_TRANSLATE;
-	if (bp->attr.bp_type & HW_BREAKPOINT_R)
-		info->type |= HW_BRK_TYPE_READ;
-	if (bp->attr.bp_type & HW_BREAKPOINT_W)
-		info->type |= HW_BRK_TYPE_WRITE;
-	if (info->type == HW_BRK_TYPE_TRANSLATE)
+	hw->type = HW_BRK_TYPE_TRANSLATE;
+	if (attr->bp_type & HW_BREAKPOINT_R)
+		hw->type |= HW_BRK_TYPE_READ;
+	if (attr->bp_type & HW_BREAKPOINT_W)
+		hw->type |= HW_BRK_TYPE_WRITE;
+	if (hw->type == HW_BRK_TYPE_TRANSLATE)
 		/* must set alteast read or write */
 		return ret;
-	if (!(bp->attr.exclude_user))
-		info->type |= HW_BRK_TYPE_USER;
-	if (!(bp->attr.exclude_kernel))
-		info->type |= HW_BRK_TYPE_KERNEL;
-	if (!(bp->attr.exclude_hv))
-		info->type |= HW_BRK_TYPE_HYP;
-	info->address = bp->attr.bp_addr;
-	info->len = bp->attr.bp_len;
+	if (!attr->exclude_user)
+		hw->type |= HW_BRK_TYPE_USER;
+	if (!attr->exclude_kernel)
+		hw->type |= HW_BRK_TYPE_KERNEL;
+	if (!attr->exclude_hv)
+		hw->type |= HW_BRK_TYPE_HYP;
+	hw->address = attr->bp_addr;
+	hw->len = attr->bp_len;
 
 	/*
 	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
@@ -176,12 +177,12 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
-		if ((bp->attr.bp_addr >> 9) !=
-		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 9))
+		if ((attr->bp_addr >> 9) !=
+		    ((attr->bp_addr + attr->bp_len - 1) >> 9))
 			return -EINVAL;
 	}
-	if (info->len >
-	    (length_max - (info->address & HW_BREAKPOINT_ALIGN)))
+	if (hw->len >
+	    (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
 		return -EINVAL;
 	return 0;
 }
