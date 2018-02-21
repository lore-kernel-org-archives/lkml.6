Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218075-2-8686643674210594011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218074; b=GHOMiHZwtGpsse+2Fk+4LPnhmmyvnFhlRW99P4qmsMq0EFL
    OC8aH7HGdwlJ+kLcLEuDJqhrE1NveIiqvgzHIV4f+ABq3742G/wrISnNelaH0/w5
    1wYhOWs9+sqLRuuHI1nZaiDC93MlKjX8rupDSlaljWkMB1DW1HuFX2efcCFfTn9a
    bcANuoPGdgnyexhphfTCQVVryyml0IntwaGnowkF6TKbtMAVUKvvfqn660yvh20q
    VNZgtkXbvfdikkCitiwvmrYL2LMKSLUeqhEbWBakOXif1IoPKbGnR2qRQdWlyr9M
    9CZg8UrrLPVfRK5n8xdepFqPTjhxywq4BtfjZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218074; bh=rzWIV10keHvBNMOYD1l9rJ6wnC
    +o76rchvdIvX2QxRM=; b=lX3rtMxIurTT1buoKwjtSmV7qRn8bHzG4GcBEsPaDm
    mhddT1D8WHguCfuCF50JfcMaaw/KzoBgsgHyeMY7TzKALzOQ+j2QT83Hrpm/ijpM
    hsBWcIMrCOO69AeAl03eqBo9tcfIoQkZEDtjCWJ6YQj5MUi1kfZn5+GxoNlTixeD
    2sZSanBSm88BOpSsaxu/i1bDQq26tzDe0b/Kx0lwE7+OPWOKzgplNMDbY3i13ODI
    taUH4y/6XajVhnOhd3jmTwHy2S3GL4jW29tk6pyIxSSCxAwz6QddEa4PTr+VB+yj
    H3e4RIuZLSAod2UK58CqYICT/SEbjE1o5G6p58x3jexA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933050AbeBUNAv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:00:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932962AbeBUNAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:00:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, dan.j.williams@intel.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 063/167] x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros
Date: Wed, 21 Feb 2018 13:47:54 +0100
Message-Id: <20180221124527.948125254@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit dde3036d62ba3375840b10ab9ec0d568fd773b07 upstream.

Previously, error_entry() and paranoid_entry() saved the GP registers
onto stack space previously allocated by its callers. Combine these two
steps in the callers, and use the generic PUSH_AND_CLEAR_REGS macro
for that.

This adds a significant amount ot text size. However, Ingo Molnar points
out that:

	"these numbers also _very_ significantly over-represent the
	extra footprint. The assumptions that resulted in
	us compressing the IRQ entry code have changed very
	significantly with the new x86 IRQ allocation code we
	introduced in the last year:

	- IRQ vectors are usually populated in tightly clustered
	  groups.

	  With our new vector allocator code the typical per CPU
	  allocation percentage on x86 systems is ~3 device vectors
	  and ~10 fixed vectors out of ~220 vectors - i.e. a very
	  low ~6% utilization (!). [...]

	  The days where we allocated a lot of vectors on every
	  CPU and the compression of the IRQ entry code text
	  mattered are over.

	- Another issue is that only a small minority of vectors
	  is frequent enough to actually matter to cache utilization
	  in practice: 3-4 key IPIs and 1-2 device IRQs at most - and
	  those vectors tend to be tightly clustered as well into about
	  two groups, and are probably already on 2-3 cache lines in
	  practice.

	  For the common case of 'cache cold' IRQs it's the depth of
	  the call chain and the fragmentation of the resulting I$
	  that should be the main performance limit - not the overall
	  size of it.

	- The CPU side cost of IRQ delivery is still very expensive
	  even in the best, most cached case, as in 'over a thousand
	  cycles'. So much stuff is done that maybe contemporary x86
	  IRQ entry microcode already prefetches the IDT entry and its
	  expected call target address."[*]

[*] http://lkml.kernel.org/r/20180208094710.qnjixhm6hybebdv7@gmail.com

The "testb $3, CS(%rsp)" instruction in the idtentry macro does not need
modification. Previously, %rsp was manually decreased by 15*8; with
this patch, %rsp is decreased by 15 pushq instructions.

[jpoimboe@redhat.com: unwind hint improvements]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-7-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   42 +-----------------------------------------
 arch/x86/entry/entry_64.S |   20 +++++++++-----------
 2 files changed, 10 insertions(+), 52 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,46 +97,6 @@ For 32-bit we have the following convent
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro ALLOC_PT_GPREGS_ON_STACK
-	addq	$-(15*8), %rsp
-	.endm
-
-	.macro SAVE_AND_CLEAR_REGS offset=0
-	/*
-	 * Save registers and sanitize registers of values that a
-	 * speculation attack might otherwise want to exploit. The
-	 * lower registers are likely clobbered well before they
-	 * could be put to use in a speculative execution gadget.
-	 * Interleave XOR with PUSH for better uop scheduling:
-	 */
-	movq %rdi, 14*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rcx, 11*8+\offset(%rsp)
-	movq %rax, 10*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	xorq %r8, %r8				/* nospec r8 */
-	movq %r9,  8*8+\offset(%rsp)
-	xorq %r9, %r9				/* nospec r9 */
-	movq %r10, 7*8+\offset(%rsp)
-	xorq %r10, %r10				/* nospec r10 */
-	movq %r11, 6*8+\offset(%rsp)
-	xorq %r11, %r11				/* nospec r11 */
-	movq %rbx, 5*8+\offset(%rsp)
-	xorl %ebx, %ebx				/* nospec rbx */
-	movq %rbp, 4*8+\offset(%rsp)
-	xorl %ebp, %ebp				/* nospec rbp */
-	movq %r12, 3*8+\offset(%rsp)
-	xorq %r12, %r12				/* nospec r12 */
-	movq %r13, 2*8+\offset(%rsp)
-	xorq %r13, %r13				/* nospec r13 */
-	movq %r14, 1*8+\offset(%rsp)
-	xorq %r14, %r14				/* nospec r14 */
-	movq %r15, 0*8+\offset(%rsp)
-	xorq %r15, %r15				/* nospec r15 */
-	UNWIND_HINT_REGS offset=\offset
-	.endm
-
 	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
@@ -211,7 +171,7 @@ For 32-bit we have the following convent
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_AND_CLEAR_REGS because it corrupts
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -867,7 +867,9 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	ALLOC_PT_GPREGS_ON_STACK
+	/* Save all registers in pt_regs */
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 
 	.if \paranoid < 2
 	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
@@ -1115,15 +1117,12 @@ idtentry machine_check		do_mce			has_err
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
+ * Switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
-	UNWIND_HINT_FUNC
 	cld
-	SAVE_AND_CLEAR_REGS 8
-	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -1136,7 +1135,7 @@ ENTRY(paranoid_entry)
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
-END(paranoid_entry)
+ENDPROC(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
@@ -1167,14 +1166,12 @@ ENTRY(paranoid_exit)
 END(paranoid_exit)
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
+ * Switch gs if needed.
  * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
-	UNWIND_HINT_FUNC
+	UNWIND_HINT_REGS offset=8
 	cld
-	SAVE_AND_CLEAR_REGS 8
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1565,7 +1562,8 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	ALLOC_PT_GPREGS_ON_STACK
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
