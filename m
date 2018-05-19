Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeESCqx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 22:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752361AbeESCqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 22:46:49 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 10/12] perf/breakpoint: Remove default hw_breakpoint_arch_parse()
Date: Sat, 19 May 2018 04:45:47 +0200
Message-Id: <1526697950-7091-11-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526697950-7091-1-git-send-email-frederic@kernel.org>
References: <1526697950-7091-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All architectures have implemented it, we can now remove the poor weak
version.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
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
index 451544d..3533fbe 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -122,7 +122,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 3b43319..d1a9c73 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -129,7 +129,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 8f647e6..22226fe 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -65,7 +65,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index ed421dc..4910990 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -58,7 +58,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 8cc161f..525f8c7 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -57,7 +57,6 @@ extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index 58632d3..f3b6036 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -40,7 +40,6 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 int hw_breakpoint_arch_parse(struct perf_event *bp,
 			     struct perf_event_attr *attr,
 			     struct arch_hw_breakpoint *hw);
-#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
 
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 9ac03ab..d7ed438 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -400,23 +400,6 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	return 0;
 }
 
-#ifndef hw_breakpoint_arch_parse
-int hw_breakpoint_arch_parse(struct perf_event *bp,
-			     struct perf_event_attr *attr,
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
 			       struct perf_event_attr *attr,
 			       struct arch_hw_breakpoint *hw)
-- 
2.7.4
