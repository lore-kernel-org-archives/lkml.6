Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03248C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8922133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270509;
	bh=mHti6NHOfV8BeuQGnSFPSBDRNT6yiZNsRVVxBTGAAkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2oV5C4kCWfvnEhXZsrHopYOiJj5vIGNx3OgfigkS9SXU5sPUQCr6N6l8EWUYvwn0
	 qbaNbiEHv5buSHAv60UxqDND690Xh9+O7q7yiDig4CL+Gz0xD4vrrfk4J644wSaBi+
	 MHn59xO54FB+Us3D/hi7g86SoRqK12t2WjE/M7Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeLaPfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:35:08 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466E72133F;
        Mon, 31 Dec 2018 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270506;
        bh=mHti6NHOfV8BeuQGnSFPSBDRNT6yiZNsRVVxBTGAAkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmfSlTqt28I1ktoKMuyXeATLZ63+jIG6tTavQQ3QWD+d9YDjDCVutODG9qW593urj
         sA1ctxf8UqG5itrAUDB+LMCJ5CGAMDkFi1ckKzmuLPSTrmKbF4xF4MWM9HDmLLGRBP
         PVje2nSQ9O0Ve6c6QF3FCG6IND8gVaQDrBcSxbio=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 10/14] csky: remove unused members in processor.h
Date:   Mon, 31 Dec 2018 23:33:01 +0800
Message-Id: <1546270384-4590-9-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Cleanup struct cpuinfo_csky and struct thread_struct, remove all esp0
related code. We could get pt_regs from sp and backtrace could use fp
in switch_stack.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/processor.h | 12 ------------
 arch/csky/kernel/asm-offsets.c    |  1 -
 arch/csky/kernel/entry.S          | 12 ------------
 arch/csky/kernel/ptrace.c         |  4 ----
 arch/csky/kernel/signal.c         |  2 --
 arch/csky/kernel/traps.c          |  6 ------
 arch/csky/mm/fault.c              |  3 ---
 7 files changed, 40 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 5ac3f32..8f45481 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -17,14 +17,7 @@
 #endif
 
 struct cpuinfo_csky {
-	unsigned long udelay_val;
 	unsigned long asid_cache;
-	/*
-	 * Capability and feature descriptor structure for CSKY CPU
-	 */
-	unsigned long options;
-	unsigned int processor_id[4];
-	unsigned int fpu_id;
 } __aligned(SMP_CACHE_BYTES);
 
 extern struct cpuinfo_csky cpu_data[];
@@ -50,11 +43,6 @@ extern struct cpuinfo_csky cpu_data[];
 struct thread_struct {
 	unsigned long  ksp;       /* kernel stack pointer */
 	unsigned long  sr;        /* saved status register */
-	unsigned long  esp0;      /* points to SR of stack frame */
-
-	/* Other stuff associated with the thread. */
-	unsigned long address;      /* Last user fault */
-	unsigned long error_code;
 
 	/* FPU regs */
 	struct user_fp __aligned(16) user_fp;
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index 2f07670..9b48b1b 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -20,7 +20,6 @@ int main(void)
 	/* offsets into the thread struct */
 	DEFINE(THREAD_KSP,        offsetof(struct thread_struct, ksp));
 	DEFINE(THREAD_SR,         offsetof(struct thread_struct, sr));
-	DEFINE(THREAD_ESP0,       offsetof(struct thread_struct, esp0));
 	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, user_fp.fesr));
 	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, user_fp.fcr));
 	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, user_fp.vr));
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index de378e4..5137ed9 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -122,16 +122,6 @@ ENTRY(csky_systemcall)
 
 	psrset  ee, ie
 
-	/* Stack frame for syscall, origin call set_esp0 */
-	mov     r12, sp
-
-	bmaski  r11, 13
-	andn    r12, r11
-	bgeni   r11, 9
-	addi    r11, 32
-	addu    r12, r11
-	st      sp, (r12, 0)
-
 	lrw     r11, __NR_syscalls
 	cmphs   syscallid, r11		/* Check nr of syscall */
 	bt      ret_from_exception
@@ -230,8 +220,6 @@ resume_userspace:
 1:  RESTORE_ALL
 
 exit_work:
-	mov	a0, sp			/* Stack address is arg[0] */
-	jbsr	set_esp0		/* Call C level */
 	btsti	r8, TIF_NEED_RESCHED
 	bt	work_resched
 	/* If thread_info->flag is empty, RESTORE_ALL */
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index eb62e07..57f1afe 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -50,15 +50,11 @@ static void singlestep_enable(struct task_struct *tsk)
  */
 void user_enable_single_step(struct task_struct *child)
 {
-	if (child->thread.esp0 == 0)
-		return;
 	singlestep_enable(child);
 }
 
 void user_disable_single_step(struct task_struct *child)
 {
-	if (child->thread.esp0 == 0)
-		return;
 	singlestep_disable(child);
 }
 
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 66e1b72..e680dc1 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -238,8 +238,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	if (!user_mode(regs))
 		return;
 
-	current->thread.esp0 = (unsigned long)regs;
-
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index a8368ed..f487a9b 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -106,7 +106,6 @@ void buserr(struct pt_regs *regs)
 	pr_err("User mode Bus Error\n");
 	show_regs(regs);
 
-	current->thread.esp0 = (unsigned long) regs;
 	force_sig_fault(SIGSEGV, 0, (void __user *)regs->pc, current);
 }
 
@@ -162,8 +161,3 @@ asmlinkage void trap_c(struct pt_regs *regs)
 	}
 	send_sig(sig, current, 0);
 }
-
-asmlinkage void set_esp0(unsigned long ssp)
-{
-	current->thread.esp0 = ssp;
-}
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 6a94661..d6f4b66 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -172,8 +172,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		tsk->thread.address = address;
-		tsk->thread.error_code = write;
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
@@ -207,6 +205,5 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	if (!user_mode(regs))
 		goto no_context;
 
-	tsk->thread.address = address;
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 }
-- 
2.7.4

