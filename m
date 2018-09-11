Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A268CC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4575620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9DT2cwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4575620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeIKXYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:24:53 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:45197 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:24:53 -0400
Received: by mail-yb1-f202.google.com with SMTP id q65-v6so12318533ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AtCfXA9nbKscmjV3yIzTXuJAzUdPpRrd7eyunY2O9BI=;
        b=k9DT2cwz4oPYtLPpX6KTeCTD00+AImGYglNBFtUgtDY+f/notk8OTcSZGhJ8yDMXx3
         AUDvNE8+QWq6XVL/cma7Dg6evRE8wC9I3O/2BGsc8BN5dAfWDk0c1UFjJFsfwpuDrGQu
         gT9Xfg0tiRbaHNUP3SFDIiuSP9puxL7SiNnVLI2V3pfOn63KcANHdRMLGDh5dK6WVzgv
         p6RAfSHzfosJWyqxqR5U76qvihm3uqlm9h2Tp3SDcSwaqcdVxVvTMMUu0M/AtX4Pgioe
         vvSk29AB2vSZurBGt6quKKev25jiSyDSDHd3CkvI46GRfWiueaPhyosB1y6jEtcrzpsQ
         qo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AtCfXA9nbKscmjV3yIzTXuJAzUdPpRrd7eyunY2O9BI=;
        b=nPyqYSfZhlJYzU51spFti7CJkGSSyMv6UCIBnb1K6IWoN379tT87QWPn/CQqIIcjvx
         XbwF6yNCBIinP/hJAs5fAANB5ylNePt9qoBBg6F8HauW07yUdU4JXWKG8k+VmpMY66oY
         9ZeiUk4UIvbHNA3TYWiPAoAmOA1D7c/sCNDM4V0k8jLX1nT4IDvr2K5AOSAUmKKSXamC
         PPRiDZDjSZb73abX/Oz1C9BIgG1mnReT1BROqEfMvrX1VRRBQnSLpMwThOm+9ZI4hYTM
         ZgPui+uGhWTl8QF+jPKl4x28gPuBH8spe36bvPG2l1Gu7BYSgiY3udibze5A2jHFLFZn
         v0sw==
X-Gm-Message-State: APzg51BbxJhmR+0HYOUXdy9P9nqcQBFUZuPqCcSPo/PucN5uW0d2emey
        rzXu6jmENCV+VpbvQvX6oLf6Ca/M5DyOKrw0ZNE=
X-Google-Smtp-Source: ANB0VdayYg01Ot5HE/US7dBgjXy/SK5NU5rnptYXG0gytVYgJeocwt6hXsX5MHEzM3TALUwk737CVJlhuf33N4TPtPw=
X-Received: by 2002:a25:b990:: with SMTP id r16-v6mr6013951ybg.32.1536690260303;
 Tue, 11 Sep 2018 11:24:20 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:24:13 -0700
Message-Id: <20180911182413.180715-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH v2] treewide: remove current_text_addr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer _THIS_IP_ defined in linux/kernel.h.

Most definitions of current_text_addr were the same as _THIS_IP_, but
a few archs had inline assembly instead.

This patch removes the final call site of current_text_addr, making all
of the definitions dead code.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
No Changes in v2, just a rebase. Resending without cc'ing everyone
suggested by scripts/get_maintainer.pl, which was a huge list.

Linus asked for a treewide change here:
https://lkml.org/lkml/2018/8/20/613
Linus suggested this conversion in:
https://lists.librecores.org/pipermail/openrisc/2018-August/001392.html
Peter has a good idea for a follow up:
https://lists.librecores.org/pipermail/openrisc/2018-August/001397.html

 arch/alpha/include/asm/processor.h      |  6 ------
 arch/arc/include/asm/processor.h        |  8 --------
 arch/arm/include/asm/processor.h        |  6 ------
 arch/arm64/include/asm/processor.h      |  7 -------
 arch/c6x/include/asm/processor.h        | 11 -----------
 arch/h8300/include/asm/processor.h      |  6 ------
 arch/hexagon/include/asm/processor.h    |  3 ---
 arch/ia64/include/asm/processor.h       |  6 ------
 arch/m68k/include/asm/processor.h       |  6 ------
 arch/microblaze/include/asm/processor.h | 12 ------------
 arch/mips/include/asm/processor.h       |  5 -----
 arch/nds32/include/asm/processor.h      |  6 ------
 arch/nios2/include/asm/processor.h      |  6 ------
 arch/openrisc/include/asm/processor.h   |  5 -----
 arch/parisc/include/asm/processor.h     | 11 -----------
 arch/powerpc/include/asm/processor.h    |  6 ------
 arch/riscv/include/asm/processor.h      |  6 ------
 arch/s390/include/asm/processor.h       |  6 ------
 arch/sh/include/asm/processor_32.h      |  6 ------
 arch/sh/include/asm/processor_64.h      | 15 ---------------
 arch/sparc/include/asm/processor_32.h   |  6 ------
 arch/sparc/include/asm/processor_64.h   |  6 ------
 arch/unicore32/include/asm/processor.h  |  6 ------
 arch/x86/include/asm/kexec.h            |  3 ++-
 arch/x86/include/asm/processor.h        | 12 ------------
 arch/x86/um/asm/processor_32.h          |  8 --------
 arch/x86/um/asm/processor_64.h          |  3 ---
 arch/xtensa/include/asm/processor.h     |  8 --------
 28 files changed, 2 insertions(+), 193 deletions(-)

diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index cb05d045efe3..6100431da07a 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -10,12 +10,6 @@
 
 #include <linux/personality.h>	/* for ADDR_LIMIT_32BIT */
 
-/*
- * Returns current instruction pointer ("program counter").
- */
-#define current_text_addr() \
-  ({ void *__pc; __asm__ ("br %0,.+4" : "=r"(__pc)); __pc; })
-
 /*
  * We have a 42-bit user address space: 4TB user VM...
  */
diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index 8ee41e988169..10346d6cf926 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -98,14 +98,6 @@ extern void start_thread(struct pt_regs * regs, unsigned long pc,
 
 extern unsigned int get_wchan(struct task_struct *p);
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- * Should the PC register be read instead ? This macro does not seem to
- * be used in many places so this wont be all that bad.
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l; })
-
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 1bf65b47808a..120f4c9bbfde 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -11,12 +11,6 @@
 #ifndef __ASM_ARM_PROCESSOR_H
 #define __ASM_ARM_PROCESSOR_H
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 #ifdef __KERNEL__
 
 #include <asm/hw_breakpoint.h>
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 79657ad91397..966214f473b4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -25,13 +25,6 @@
 #define USER_DS		(TASK_SIZE_64 - 1)
 
 #ifndef __ASSEMBLY__
-
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 #ifdef __KERNEL__
 
 #include <linux/build_bug.h>
diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
index 8f7cce829f8e..a8581f5b27f6 100644
--- a/arch/c6x/include/asm/processor.h
+++ b/arch/c6x/include/asm/processor.h
@@ -17,17 +17,6 @@
 #include <asm/page.h>
 #include <asm/current.h>
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr()			\
-({						\
-	void *__pc;				\
-	asm("mvc .S2 pce1,%0\n" : "=b"(__pc));	\
-	__pc;					\
-})
-
 /*
  * User space process size. This is mostly meaningless for NOMMU
  * but some C6X processors may have RAM addresses up to 0xFFFFFFFF.
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 985346393e4a..a060b41b2d31 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -12,12 +12,6 @@
 #ifndef __ASM_H8300_PROCESSOR_H
 #define __ASM_H8300_PROCESSOR_H
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l; })
-
 #include <linux/compiler.h>
 #include <asm/segment.h>
 #include <asm/ptrace.h>
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
index ce67940860a5..227bcb9cfdac 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -27,9 +27,6 @@
 #include <asm/registers.h>
 #include <asm/hexagon_vm.h>
 
-/*  must be a macro  */
-#define current_text_addr() ({ __label__ _l; _l: &&_l; })
-
 /*  task_struct, defined elsewhere, is the "process descriptor" */
 struct task_struct;
 
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 10061ccf0440..c91ef98ed6bf 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -602,12 +602,6 @@ ia64_set_unat (__u64 *unat, void *spill_addr, unsigned long nat)
 	*unat = (*unat & ~mask) | (nat << bit);
 }
 
-/*
- * Get the current instruction/program counter value.
- */
-#define current_text_addr() \
-	({ void *_pc; _pc = (void *)ia64_getreg(_IA64_REG_IP); _pc; })
-
 static inline __u64
 ia64_get_ivr (void)
 {
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index 464e9f5f50ee..3750819ac5a1 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -8,12 +8,6 @@
 #ifndef __ASM_M68K_PROCESSOR_H
 #define __ASM_M68K_PROCESSOR_H
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 #include <linux/thread_info.h>
 #include <asm/segment.h>
 #include <asm/fpu.h>
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 330d556860ba..66b537b8d138 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -45,12 +45,6 @@ extern void ret_from_kernel_thread(void);
  */
 # define TASK_SIZE	(0x81000000 - 0x80000000)
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-# define current_text_addr() ({ __label__ _l; _l: &&_l; })
-
 /*
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's. We won't be using it
@@ -92,12 +86,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #  ifndef __ASSEMBLY__
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#  define current_text_addr()	({ __label__ _l; _l: &&_l; })
-
 /* If you change this, you must change the associated assembly-languages
  * constants defined below, THREAD_*.
  */
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index b2fa62922d88..f08417f8772e 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -22,11 +22,6 @@
 #include <asm/mipsregs.h>
 #include <asm/prefetch.h>
 
-/*
- * Return current * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 /*
  * System setup and hardware flags..
  */
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
index 9c83caf4269f..c2660f566bac 100644
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -4,12 +4,6 @@
 #ifndef __ASM_NDS32_PROCESSOR_H
 #define __ASM_NDS32_PROCESSOR_H
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 #ifdef __KERNEL__
 
 #include <asm/ptrace.h>
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index 4944e2e1d8b0..94bcb86f679f 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -38,12 +38,6 @@
 #define KUSER_SIZE		(PAGE_SIZE)
 #ifndef __ASSEMBLY__
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l; })
-
 # define TASK_SIZE		0x7FFF0000UL
 # define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
 
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index af31a9fe736a..351d3aed7a06 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -30,11 +30,6 @@
 		   | SPR_SR_DCE | SPR_SR_SM)
 #define USER_SR   (SPR_SR_DME | SPR_SR_IME | SPR_SR_ICE \
 		   | SPR_SR_DCE | SPR_SR_IEE | SPR_SR_TEE)
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l; })
 
 /*
  * User space process size. This is hardcoded into a few places,
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 2bd5e695bdad..6e2a8176b0dd 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -20,17 +20,6 @@
 #include <asm/percpu.h>
 #endif /* __ASSEMBLY__ */
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#ifdef CONFIG_PA20
-#define current_ia(x)	__asm__("mfia %0" : "=r"(x))
-#else /* mfia added in pa2.0 */
-#define current_ia(x)	__asm__("blr 0,%0\n\tnop" : "=r"(x))
-#endif
-#define current_text_addr() ({ void *pc; current_ia(pc); pc; })
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 #define TASK_SIZE_OF(tsk)       ((tsk)->thread.task_size)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 52fadded5c1e..1fff74df06e6 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -67,12 +67,6 @@ extern int _chrp_type;
 
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 /* Macros for adjusting thread priority (hardware multi-threading) */
 #define HMT_very_low()   asm volatile("or 31,31,31   # very low priority")
 #define HMT_low()	 asm volatile("or 1,1,1	     # low priority")
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3fe4af8147d2..020e35947060 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -33,12 +33,6 @@
 struct task_struct;
 struct pt_regs;
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr()	({ __label__ _l; _l: &&_l; })
-
 /* CPU-specific state of a task */
 struct thread_struct {
 	/* Callee-saved registers */
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 7f2953c15c37..f8028d37bb18 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -73,12 +73,6 @@ static inline int test_cpu_flag_of(int flag, int cpu)
 
 #define arch_needs_cpu() test_cpu_flag(CIF_NOHZ_DELAY)
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ void *pc; asm("basr %0,0" : "=a" (pc)); pc; })
-
 static inline void get_cpu_id(struct cpuid *ptr)
 {
 	asm volatile("stidp %0" : "=Q" (*ptr));
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 95100d8a0b7b..0e0ecc0132e3 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -16,12 +16,6 @@
 #include <asm/types.h>
 #include <asm/hw_breakpoint.h>
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ void *pc; __asm__("mova	1f, %0\n.align 2\n1:":"=z" (pc)); pc; })
-
 /* Core Processor Version Register */
 #define CCN_PVR		0xff000030
 #define CCN_CVR		0xff000040
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index 777a16318aff..f3d7075648d0 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -19,21 +19,6 @@
 #include <asm/types.h>
 #include <cpu/registers.h>
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ \
-void *pc; \
-unsigned long long __dummy = 0; \
-__asm__("gettr	tr0, %1\n\t" \
-	"pta	4, tr0\n\t" \
-	"gettr	tr0, %0\n\t" \
-	"ptabs	%1, tr0\n\t"	\
-	:"=r" (pc), "=r" (__dummy) \
-	: "1" (__dummy)); \
-pc; })
-
 #endif
 
 /*
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 192493c257fa..3c4bc2189092 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -7,12 +7,6 @@
 #ifndef __ASM_SPARC_PROCESSOR_H
 #define __ASM_SPARC_PROCESSOR_H
 
-/*
- * Sparc32 implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ void *pc; __asm__("sethi %%hi(1f), %0; or %0, %%lo(1f), %0;\n1:" : "=r" (pc)); pc; })
-
 #include <asm/psr.h>
 #include <asm/ptrace.h>
 #include <asm/head.h>
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index aac23d4a4ddd..5cf145f18f36 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -8,12 +8,6 @@
 #ifndef __ASM_SPARC64_PROCESSOR_H
 #define __ASM_SPARC64_PROCESSOR_H
 
-/*
- * Sparc64 implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ void *pc; __asm__("rd %%pc, %0" : "=r" (pc)); pc; })
-
 #include <asm/asi.h>
 #include <asm/pstate.h>
 #include <asm/ptrace.h>
diff --git a/arch/unicore32/include/asm/processor.h b/arch/unicore32/include/asm/processor.h
index 4eaa42167667..b772ed1c0f25 100644
--- a/arch/unicore32/include/asm/processor.h
+++ b/arch/unicore32/include/asm/processor.h
@@ -13,12 +13,6 @@
 #ifndef __UNICORE_PROCESSOR_H__
 #define __UNICORE_PROCESSOR_H__
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l; })
-
 #ifdef __KERNEL__
 
 #include <asm/ptrace.h>
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index f327236f0fa7..86924d594ecd 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -21,6 +21,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
+#include <linux/kernel.h>
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
@@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
 		asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
 #endif
-		newregs->ip = (unsigned long)current_text_addr();
+		newregs->ip = _THIS_IP_;
 	}
 }
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d53c54b842da..6cb353b6b76e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -42,18 +42,6 @@ struct vm86;
 #define NET_IP_ALIGN	0
 
 #define HBP_NUM 4
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-static inline void *current_text_addr(void)
-{
-	void *pc;
-
-	asm volatile("mov $1f, %0; 1:":"=r" (pc));
-
-	return pc;
-}
 
 /*
  * These alignment constraints are for performance in the vSMP case,
diff --git a/arch/x86/um/asm/processor_32.h b/arch/x86/um/asm/processor_32.h
index c112de81c9e1..5fb1b8449adf 100644
--- a/arch/x86/um/asm/processor_32.h
+++ b/arch/x86/um/asm/processor_32.h
@@ -47,14 +47,6 @@ static inline void arch_copy_thread(struct arch_thread *from,
         memcpy(&to->tls_array, &from->tls_array, sizeof(from->tls_array));
 }
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter"). Stolen
- * from asm-i386/processor.h
- */
-#define current_text_addr() \
-	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
-
 #define current_sp() ({ void *sp; __asm__("movl %%esp, %0" : "=r" (sp) : ); sp; })
 #define current_bp() ({ unsigned long bp; __asm__("movl %%ebp, %0" : "=r" (bp) : ); bp; })
 
diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
index c3be85205a65..1ef9c21877bc 100644
--- a/arch/x86/um/asm/processor_64.h
+++ b/arch/x86/um/asm/processor_64.h
@@ -31,9 +31,6 @@ static inline void arch_copy_thread(struct arch_thread *from,
 	to->fs = from->fs;
 }
 
-#define current_text_addr() \
-	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
-
 #define current_sp() ({ void *sp; __asm__("movq %%rsp, %0" : "=r" (sp) : ); sp; })
 #define current_bp() ({ unsigned long bp; __asm__("movq %%rbp, %0" : "=r" (bp) : ); bp; })
 
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index e4ccb88b7996..be9bfd9aa865 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -152,14 +152,6 @@ struct thread_struct {
 	int align[0] __attribute__ ((aligned(16)));
 };
 
-
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr()  ({ __label__ _l; _l: &&_l;})
-
-
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

