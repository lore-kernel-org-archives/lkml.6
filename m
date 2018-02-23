Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411683-2-3661565850497082215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411683; b=e3qrx7/NxoKe6ZgeMq6Ic+KkWjEXq3NA0RNcAgJmKH3jyjy
    6o0HTcfnyw21NvkxAWY94JJfs6GjcHfOUyOOJ3NQphH9VDQrxBKfoiopdv3AO7h+
    iuWxGbHTDgADvMP4pjThzalcaNIItQ7ekILTEJQ+ri1tcpsic/KUKG+hIbwh7yWE
    u99D+z3nRnT4XqorXHELeRGXO7PDazedkhTJ05M1SgPw1uWGUB3Xc2NsjR+Q0D2j
    XPAEF7WbZNyH8tQ3oIYlbQxtcTGrJ2dOTykoVn/+S6hCs3XzHtHklVlmFIp32FNw
    us7hoQpcUtxAyKHInD91lsnf4lu45Fra99LbWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411683; bh=WT3ypbTc5LjKen5XKX/8hShYcS
    pY4DSGUjKmd9qNl3s=; b=h6RXWa1nSw7LDhyU3DH+bWeYYPkw8/pDJHyV0L1BV5
    Iag6/rGdQPmiQle6ihaFrByVff62VNLHmJQQqtFJTCqfWTQgxWhpaxflzdaOYQhN
    xxm04ZEE8DJFvWx9ErNq49jSZN901JAHe9WDM40LqgLCBCvgsQphRXM4ax/HcL/B
    YvJoQej5vi72zJBqNbicLwmbsJUNMVbtaI9hI7ERHmWHnljJBEdmraxxHqQh2Es9
    8CducvPWfmQwqQIlqZswz4/2+B550lItndNSKIk+CQdl9P65uyzw/D0Xm/YUG6b8
    NbdpvVJ6qNL1mz4qU+ueuecu45Wi6J9cx1Cgf4llOtGA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933940AbeBWSr5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933902AbeBWSry (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 088/145] powerpc/64s: Simple RFI macro conversions
Date: Fri, 23 Feb 2018 19:26:34 +0100
Message-Id: <20180223170736.127502808@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 222f20f140623ef6033491d0103ee0875fe87d35 upstream.

This commit does simple conversions of rfi/rfid to the new macros that
include the expected destination context. By simple we mean cases
where there is a single well known destination context, and it's
simply a matter of substituting the instruction for the appropriate
macro.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Backport to 4.9, use RFI_TO_KERNEL in idle_book3s.S]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/exception-64s.h |    2 +-
 arch/powerpc/kernel/entry_64.S           |    9 ++++-----
 arch/powerpc/kernel/exceptions-64s.S     |   22 +++++++++++-----------
 arch/powerpc/kernel/idle_book3s.S        |    7 ++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    7 +++----
 arch/powerpc/kvm/book3s_rmhandlers.S     |    7 +++++--
 arch/powerpc/kvm/book3s_segment.S        |    4 ++--
 7 files changed, 30 insertions(+), 28 deletions(-)

--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -242,7 +242,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtspr	SPRN_##h##SRR0,r12;					\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
-	h##rfid;							\
+	h##RFI_TO_KERNEL;						\
 	b	.	/* prevent speculative execution */
 #define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -401,8 +401,7 @@ tabort_syscall:
 	mtmsrd	r10, 1
 	mtspr	SPRN_SRR0, r11
 	mtspr	SPRN_SRR1, r12
-
-	rfid
+	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 #endif
 
@@ -1078,7 +1077,7 @@ _GLOBAL(enter_rtas)
 	
 	mtspr	SPRN_SRR0,r5
 	mtspr	SPRN_SRR1,r6
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 rtas_return_loc:
@@ -1103,7 +1102,7 @@ rtas_return_loc:
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 	.align	3
@@ -1174,7 +1173,7 @@ _GLOBAL(enter_prom)
 	LOAD_REG_IMMEDIATE(r12, MSR_SF | MSR_ISF | MSR_LE)
 	andc	r11,r11,r12
 	mtsrr1	r11
-	rfid
+	RFI_TO_KERNEL
 #endif /* CONFIG_PPC_BOOK3E */
 
 1:	/* Return from OF */
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -244,7 +244,7 @@ BEGIN_FTR_SECTION
 	LOAD_HANDLER(r12, machine_check_handle_early)
 1:	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r11
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 2:
 	/* Stack overflow. Stay on emergency stack and panic.
@@ -280,7 +280,7 @@ machine_check_pSeries_0:
 	mtspr	SPRN_SRR0,r12
 	mfspr	r12,SPRN_SRR1
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
@@ -446,7 +446,7 @@ EXC_COMMON_BEGIN(machine_check_handle_ea
 	li	r3,MSR_ME
 	andc	r10,r10,r3		/* Turn off MSR_ME */
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 2:
 	/*
@@ -464,7 +464,7 @@ EXC_COMMON_BEGIN(machine_check_handle_ea
 	 */
 	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
-	rfid
+	RFI_TO_USER_OR_KERNEL
 9:
 	/* Deliver the machine check to host kernel in V mode. */
 	MACHINE_CHECK_HANDLER_WINDUP
@@ -706,7 +706,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_R
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 EXC_COMMON_BEGIN(unrecov_slb)
@@ -893,7 +893,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
-	rfid ; 							\
+	RFI_TO_KERNEL ;						\
 	b	. ;	/* prevent speculative execution */
 
 #define SYSCALL_PSERIES_3					\
@@ -901,7 +901,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 1:	mfspr	r12,SPRN_SRR1 ;					\
 	xori	r12,r12,MSR_LE ;				\
 	mtspr	SPRN_SRR1,r12 ;					\
-	rfid ;		/* return to userspace */		\
+	RFI_TO_USER ;	/* return to userspace */		\
 	b	. ;	/* prevent speculative execution */
 
 #if defined(CONFIG_RELOCATABLE)
@@ -1276,7 +1276,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
 	ld	r13,PACA_EXGEN+EX_R13(r13)
-	HRFID
+	HRFI_TO_UNKNOWN
 	b	.
 #endif
 
@@ -1350,7 +1350,7 @@ masked_##_H##interrupt:					\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
 	GET_SCRATCH0(r13);				\
-	##_H##rfid;					\
+	##_H##RFI_TO_KERNEL;				\
 	b	.
 
 /*
@@ -1372,7 +1372,7 @@ TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
 	addi	r13, r13, 4
 	mtspr	SPRN_SRR0, r13
 	GET_SCRATCH0(r13)
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
@@ -1384,7 +1384,7 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 	addi	r13, r13, 4
 	mtspr	SPRN_HSRR0, r13
 	GET_SCRATCH0(r13)
-	hrfid
+	HRFI_TO_KERNEL
 	b	.
 #endif
 
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -9,6 +9,7 @@
  */
 
 #include <linux/threads.h>
+#include <asm/exception-64s.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/cputable.h>
@@ -178,7 +179,7 @@ _GLOBAL(pnv_powersave_common)
 	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
 	mtspr	SPRN_SRR0, r5
 	mtspr	SPRN_SRR1, r7
-	rfid
+	RFI_TO_KERNEL
 
 	.globl pnv_enter_arch207_idle_mode
 pnv_enter_arch207_idle_mode:
@@ -668,7 +669,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	mtcr	r6
 	mtspr	SPRN_SRR1,r4
 	mtspr	SPRN_SRR0,r5
-	rfid
+	RFI_TO_KERNEL
 
 /*
  * R3 here contains the value that will be returned to the caller
@@ -689,4 +690,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	mtcr	r6
 	mtspr	SPRN_SRR1,r4
 	mtspr	SPRN_SRR0,r5
-	rfid
+	RFI_TO_KERNEL
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -65,7 +65,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
 	mtmsrd	r0,1		/* clear RI in MSR */
 	mtsrr0	r5
 	mtsrr1	r6
-	RFI
+	RFI_TO_KERNEL
 
 kvmppc_call_hv_entry:
 	ld	r4, HSTATE_KVM_VCPU(r13)
@@ -171,7 +171,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtsrr0	r8
 	mtsrr1	r7
 	beq	cr1, 13f		/* machine check */
-	RFI
+	RFI_TO_KERNEL
 
 	/* On POWER7, we have external interrupts set to use HSRR0/1 */
 11:	mtspr	SPRN_HSRR0, r8
@@ -1018,8 +1018,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r0, VCPU_GPR(R0)(r4)
 	ld	r4, VCPU_GPR(R4)(r4)
-
-	hrfid
+	HRFI_TO_GUEST
 	b	.
 
 secondary_too_late:
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -46,6 +46,9 @@
 
 #define FUNC(name)		name
 
+#define RFI_TO_KERNEL	RFI
+#define RFI_TO_GUEST	RFI
+
 .macro INTERRUPT_TRAMPOLINE intno
 
 .global kvmppc_trampoline_\intno
@@ -141,7 +144,7 @@ kvmppc_handler_skip_ins:
 	GET_SCRATCH0(r13)
 
 	/* And get back into the code */
-	RFI
+	RFI_TO_KERNEL
 #endif
 
 /*
@@ -164,6 +167,6 @@ _GLOBAL_TOC(kvmppc_entry_trampoline)
 	ori	r5, r5, MSR_EE
 	mtsrr0	r7
 	mtsrr1	r6
-	RFI
+	RFI_TO_KERNEL
 
 #include "book3s_segment.S"
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -156,7 +156,7 @@ no_dcbz32_on:
 	PPC_LL	r9, SVCPU_R9(r3)
 	PPC_LL	r3, (SVCPU_R3)(r3)
 
-	RFI
+	RFI_TO_GUEST
 kvmppc_handler_trampoline_enter_end:
 
 
@@ -389,5 +389,5 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	cmpwi	r12, BOOK3S_INTERRUPT_DOORBELL
 	beqa	BOOK3S_INTERRUPT_DOORBELL
 
-	RFI
+	RFI_TO_KERNEL
 kvmppc_handler_trampoline_exit_end:
