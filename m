Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127483-2-8646394382463316373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127483; b=cVCSMWxL08oNs8I7SlFKl/A3jlIG3Xcf9H9133FZa6OWALqu1/
    6fVXadnwzQfgkzQn4RkbxeHd7NDCzzbqf0MPQMgBWoDC53D1rWk2eCtlTEgbqnND
    H5AAO4zfn/P8f7Vgp7QxOqoYKr/hfVPvAxGwX3B4AElwsRUguyOo2Oy91xJMDdn+
    WAqkP5Xw5S70JNS4xyS2bs0PftkPy+CzxHuOO0vP0bPqDaDN3HeqnoYsbkvqU8/4
    TKvdppn1P8uREUOz2pVNyrtP9A2lHchgsNG51+DMeKrBmbei9pslLpKEYIADYIm9
    p/CeXACnFM5059Fc/ujmTHOYOiHFZLG5gUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127483;
    bh=lzaUN0Rz0kvjQcvlzb3nnIli0n6SRmqyIA0UxgTxupM=; b=Xys1emXbS3Vf
    8kn8A34YSh6yhH63JlTgTabi7dH13qWYbm1Zkn/NHRYNCC8fB1qC5YR4kHuRlrzk
    x7bKDvpxSe5Wy+BZoXytiGxSOaYdi6E2y7EFxMlVfkOkg3cjyzhaTPulb/njmph0
    hmHXRh4ORlJb+9raTYg1saENIYzPjYqbJeQv/b/zi1oSRTBEzOYfDU8ShA9lI7Be
    urBbOQUGtAb8PbyjRZfooWi/TiyeFRDqMalDWeEua5ah1wYGuUTwXU17YTmwa/2B
    FMOw4cTuxiETdECk1FvcHvGKnLV2n7VPkadk9KB6HDLvHD86Ila4HIzP6o0VF6X0
    pGM8Q5fZ9Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=je+N0Q+n header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=je+N0Q+n header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO+tjbyW+M8kg93GEkqFZSDYfDH3E0vqY25iiAR1MAe2o68BcfypPFJGXNGKcjO4te8Dg22ZDGebEoOLHCMVheoJ8WKgO3QkrQaOlgUm/WIYORLBvDpC
    QFHzd2OUWfXL25C4pbhkaZlfMC2j6p7fhDViVVLh9miKcSeu22WiyjOvFbUZGO++MEnkAjcv6kwJZgqzXGLoC6VyAnBZlv1sSySJDhURWkrZ9tP29+/5V6AR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=JfrnYn6hAAAA:8 a=3RsymZzYhAzwhJxJRqAA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeFDPvU (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFDPvT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:51:19 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH -tip v5 05/27] ARM: kprobes: Remove jprobe arm implementation
Date: Tue,  5 Jun 2018 00:50:55 +0900
Message-Id: <152812745575.10068.2084342434320216874.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/arm.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/kprobes.h |    2 -
 arch/arm/include/asm/probes.h  |    1 
 arch/arm/probes/kprobes/core.c |  114 ----------------------------------------
 3 files changed, 117 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index 59655459da59..82290f212d8e 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -44,8 +44,6 @@ struct prev_kprobe {
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
 	struct prev_kprobe prev_kprobe;
-	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
index 1e5b9bb92270..991c9127c650 100644
--- a/arch/arm/include/asm/probes.h
+++ b/arch/arm/include/asm/probes.h
@@ -51,7 +51,6 @@ struct arch_probes_insn {
  * We assume one instruction can consume at most 64 bytes stack, which is
  * 'push {r0-r15}'. Instructions consume more or unknown stack space like
  * 'str r0, [sp, #-80]' and 'str r0, [sp, r1]' should be prohibit to probe.
- * Both kprobe and jprobe use this macro.
  */
 #define MAX_STACK_SIZE			64
 
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index e90cc8a08186..23562111c511 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -47,9 +47,6 @@
 			   (unsigned long)(addr) +	\
 			   (size))
 
-/* Used as a marker in ARM_pc to note when we're in a jprobe. */
-#define JPROBE_MAGIC_ADDR		0xffffffff
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -521,117 +518,6 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	regs->ARM_lr = (unsigned long)&kretprobe_trampoline;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long sp_addr = regs->ARM_sp;
-	long cpsr;
-
-	kcb->jprobe_saved_regs = *regs;
-	memcpy(kcb->jprobes_stack, (void *)sp_addr, MIN_STACK_SIZE(sp_addr));
-	regs->ARM_pc = (long)jp->entry;
-
-	cpsr = regs->ARM_cpsr | PSR_I_BIT;
-#ifdef CONFIG_THUMB2_KERNEL
-	/* Set correct Thumb state in cpsr */
-	if (regs->ARM_pc & 1)
-		cpsr |= PSR_T_BIT;
-	else
-		cpsr &= ~PSR_T_BIT;
-#endif
-	regs->ARM_cpsr = cpsr;
-
-	preempt_disable();
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	__asm__ __volatile__ (
-		/*
-		 * Setup an empty pt_regs. Fill SP and PC fields as
-		 * they're needed by longjmp_break_handler.
-		 *
-		 * We allocate some slack between the original SP and start of
-		 * our fabricated regs. To be precise we want to have worst case
-		 * covered which is STMFD with all 16 regs so we allocate 2 *
-		 * sizeof(struct_pt_regs)).
-		 *
-		 * This is to prevent any simulated instruction from writing
-		 * over the regs when they are accessing the stack.
-		 */
-#ifdef CONFIG_THUMB2_KERNEL
-		"sub    r0, %0, %1		\n\t"
-		"mov    sp, r0			\n\t"
-#else
-		"sub    sp, %0, %1		\n\t"
-#endif
-		"ldr    r0, ="__stringify(JPROBE_MAGIC_ADDR)"\n\t"
-		"str    %0, [sp, %2]		\n\t"
-		"str    r0, [sp, %3]		\n\t"
-		"mov    r0, sp			\n\t"
-		"bl     kprobe_handler		\n\t"
-
-		/*
-		 * Return to the context saved by setjmp_pre_handler
-		 * and restored by longjmp_break_handler.
-		 */
-#ifdef CONFIG_THUMB2_KERNEL
-		"ldr	lr, [sp, %2]		\n\t" /* lr = saved sp */
-		"ldrd	r0, r1, [sp, %5]	\n\t" /* r0,r1 = saved lr,pc */
-		"ldr	r2, [sp, %4]		\n\t" /* r2 = saved psr */
-		"stmdb	lr!, {r0, r1, r2}	\n\t" /* push saved lr and */
-						      /* rfe context */
-		"ldmia	sp, {r0 - r12}		\n\t"
-		"mov	sp, lr			\n\t"
-		"ldr	lr, [sp], #4		\n\t"
-		"rfeia	sp!			\n\t"
-#else
-		"ldr	r0, [sp, %4]		\n\t"
-		"msr	cpsr_cxsf, r0		\n\t"
-		"ldmia	sp, {r0 - pc}		\n\t"
-#endif
-		:
-		: "r" (kcb->jprobe_saved_regs.ARM_sp),
-		  "I" (sizeof(struct pt_regs) * 2),
-		  "J" (offsetof(struct pt_regs, ARM_sp)),
-		  "J" (offsetof(struct pt_regs, ARM_pc)),
-		  "J" (offsetof(struct pt_regs, ARM_cpsr)),
-		  "J" (offsetof(struct pt_regs, ARM_lr))
-		: "memory", "cc");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_addr = kcb->jprobe_saved_regs.ARM_sp;
-	long orig_sp = regs->ARM_sp;
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-
-	if (regs->ARM_pc == JPROBE_MAGIC_ADDR) {
-		if (orig_sp != stack_addr) {
-			struct pt_regs *saved_regs =
-				(struct pt_regs *)kcb->jprobe_saved_regs.ARM_sp;
-			printk("current sp %lx does not match saved sp %lx\n",
-			       orig_sp, stack_addr);
-			printk("Saved registers for jprobe %p\n", jp);
-			show_regs(saved_regs);
-			printk("Current registers\n");
-			show_regs(regs);
-			BUG();
-		}
-		*regs = kcb->jprobe_saved_regs;
-		memcpy((void *)stack_addr, kcb->jprobes_stack,
-		       MIN_STACK_SIZE(stack_addr));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
