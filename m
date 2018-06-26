Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A43AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8D426946
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8D426946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964991AbeFZKbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:31:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933789AbeFZKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:31:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAUjQM1648924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:30:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAUiLc1648921;
        Tue, 26 Jun 2018 03:30:44 -0700
Date:   Tue, 26 Jun 2018 03:30:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-cffbb3bd444bc95186b6ab0ed3bf1d5bcf4aa620@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dalias@libc.org, mpe@ellerman.id.au,
        jolsa@redhat.com, benh@kernel.crashing.org, acme@redhat.com,
        torvalds@linux-foundation.org, ysato@users.sourceforge.jp,
        hpa@zytor.com, catalin.marinas@arm.com, jcmvbkbc@gmail.com,
        mark.rutland@arm.com, paulus@samba.org,
        alexander.shishkin@linux.intel.com, joel.opensrc@gmail.com,
        peterz@infradead.org, tglx@linutronix.de, chris@zankel.net,
        namhyung@kernel.org, mingo@kernel.org, luto@kernel.org,
        will.deacon@arm.com, acme@kernel.org, frederic@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, paulus@samba.org,
          jcmvbkbc@gmail.com, mark.rutland@arm.com,
          torvalds@linux-foundation.org, hpa@zytor.com,
          ysato@users.sourceforge.jp, catalin.marinas@arm.com,
          benh@kernel.crashing.org, acme@redhat.com, mpe@ellerman.id.au,
          jolsa@redhat.com, dalias@libc.org, linux-kernel@vger.kernel.org,
          acme@kernel.org, frederic@kernel.org, luto@kernel.org,
          will.deacon@arm.com, chris@zankel.net, mingo@kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          joel.opensrc@gmail.com
In-Reply-To: <1529981939-8231-11-git-send-email-frederic@kernel.org>
References: <1529981939-8231-11-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Remove default
 hw_breakpoint_arch_parse()
Git-Commit-ID: cffbb3bd444bc95186b6ab0ed3bf1d5bcf4aa620
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

Commit-ID:  cffbb3bd444bc95186b6ab0ed3bf1d5bcf4aa620
Gitweb:     https://git.kernel.org/tip/cffbb3bd444bc95186b6ab0ed3bf1d5bcf4aa620
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:57 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:58 +0200

perf/hw_breakpoint: Remove default hw_breakpoint_arch_parse()

All architectures have implemented it, we can now remove the poor weak
version.

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
Link: http://lkml.kernel.org/r/1529981939-8231-11-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/hw_breakpoint.h     |  1 -
 arch/arm64/include/asm/hw_breakpoint.h   |  1 -
 arch/powerpc/include/asm/hw_breakpoint.h |  1 -
 arch/sh/include/asm/hw_breakpoint.h      |  1 -
 arch/x86/include/asm/hw_breakpoint.h     |  1 -
 arch/xtensa/include/asm/hw_breakpoint.h  |  1 -
 kernel/events/hw_breakpoint.c            | 17 -----------------
 7 files changed, 23 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index 1e02925c11f4..ac54c06764e6 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -122,7 +122,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index bf9c305daa62..6a53e59ced95 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -129,7 +129,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 38ae180610bd..27d6e3c8fde9 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -65,7 +65,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 867edcc60e8f..199d17b765f2 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -58,7 +58,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 6c88e8e22678..a1f0e90d0818 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -57,7 +57,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index f347c2132e6b..9f119c1ca0b5 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -40,7 +40,6 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 int hw_breakpoint_arch_parse(struct perf_event *bp,
 			     const struct perf_event_attr *attr,
 			     struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
 
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 89fe94c9214c..e7bc8d0a5972 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -400,23 +400,6 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	return 0;
 }
 
-#ifndef hw_breakpoint_arch_parse
-int hw_breakpoint_arch_parse(struct perf_event *bp,
-			     const struct perf_event_attr *attr,
-			     struct arch_hw_breakpoint *hw)
-{
-	int err;
-
-	err = arch_validate_hwbkpt_settings(bp);
-	if (err)
-		return err;
-
-	*hw = bp->hw.info;
-
-	return 0;
-}
-#endif
-
 static int hw_breakpoint_parse(struct perf_event *bp,
 			       const struct perf_event_attr *attr,
 			       struct arch_hw_breakpoint *hw)
