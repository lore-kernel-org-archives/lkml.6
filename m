Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720833-2-12060012464050767258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720832; b=RRwtVFDMe7zlfj0PR5/PhsvbSRco/e/5AglL3rZOAc1c75o
    p2WTaZi+LPVZ9X+SkIAMeZn7zQWNp/a7vUpXILpCEUif51m4e8sdeNv+uwl9kcN9
    gvcxwpGN9JxRpkQRGhU7CPAx+HMGba1Dxm+qTXEwOgDIquebSKXH8/5AdvlRljcQ
    eFMOur9IVCOIYYdxiBk6aYkSr0RX/UHVGM2BniAJrvC44X1Bg410QlcXAoS48BGA
    RD4P5YKQQip3fJMMMnRQC0GK4YBeLMCkEmOT3HQ6azOPsyJ2uynAgrn0CKVklG3D
    VJkzyUyrwCZEL/G0O0ipBpwnM/tJtJs2CuF4Msw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720832; bh=lPqAF8q9Lclu+pYPy4ZzpdTX+K
    Oqxe1JDCGqNITAcpo=; b=XHtyFo4iGGVinTRozXE6TMojmlJgWBouNw00opPwue
    YeErcwBH20UXE8WlVUjZ+cwJQt5Ux2d/rH5jnC5g+cVBj5VCS/vek4uxRVvFm/8G
    TkJwZ4MYwR/1lbirCAA9AtBkHyrU7+8nbtXoagW+/lohTdDORT9JZOnJ6itSSjNo
    yuaMF4qYI7i6cunISWS9/jBHX435FIPDrb9E8erqYVNZ2axGyXO2rfI5Ujr/rp6W
    N4VKzNjxCC5/UW+s4TUHw+K406EEhmbuKVZhyS6/a9/uZhokpNzEC2it0+Fykqfz
    f6dEw0i9c0+PmIbsG+M0eyS4tPeCt6fKWUZb8dE82iFA==
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
        id S1162051AbeBOSxi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:53:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161918AbeBOPVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 4.4 007/108] powerpc/64s: Simple RFI macro conversions
Date: Thu, 15 Feb 2018 16:16:04 +0100
Message-Id: <20180215151223.351918149@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 222f20f140623ef6033491d0103ee0875fe87d35 upstream.

This commit does simple conversions of rfi/rfid to the new macros that
include the expected destination context. By simple we mean cases
where there is a single well known destination context, and it's
simply a matter of substituting the instruction for the appropriate
macro.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[Balbir fixed issues with backporting to stable]
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/exception-64s.h |    2 +-
 arch/powerpc/kernel/entry_64.S           |   14 +++++++++-----
 arch/powerpc/kernel/exceptions-64s.S     |   18 +++++++++---------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    7 +++----
 arch/powerpc/kvm/book3s_rmhandlers.S     |    7 +++++--
 arch/powerpc/kvm/book3s_segment.S        |    4 ++--
 6 files changed, 29 insertions(+), 23 deletions(-)

--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -220,7 +220,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
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
@@ -36,6 +36,11 @@
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/exception-64s.h>
+#else
+#include <asm/exception-64e.h>
+#endif
 
 /*
  * System calls.
@@ -353,8 +358,7 @@ tabort_syscall:
 	mtmsrd	r10, 1
 	mtspr	SPRN_SRR0, r11
 	mtspr	SPRN_SRR1, r12
-
-	rfid
+	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 #endif
 
@@ -1077,7 +1081,7 @@ _GLOBAL(enter_rtas)
 	
 	mtspr	SPRN_SRR0,r5
 	mtspr	SPRN_SRR1,r6
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 rtas_return_loc:
@@ -1102,7 +1106,7 @@ rtas_return_loc:
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 	.align	3
@@ -1173,7 +1177,7 @@ _GLOBAL(enter_prom)
 	LOAD_REG_IMMEDIATE(r12, MSR_SF | MSR_ISF | MSR_LE)
 	andc	r11,r11,r12
 	mtsrr1	r11
-	rfid
+	RFI_TO_KERNEL
 #endif /* CONFIG_PPC_BOOK3E */
 
 1:	/* Return from OF */
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -46,7 +46,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
-	rfid ; 							\
+	RFI_TO_KERNEL ; 							\
 	b	. ;	/* prevent speculative execution */
 
 #define SYSCALL_PSERIES_3					\
@@ -54,7 +54,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 1:	mfspr	r12,SPRN_SRR1 ;					\
 	xori	r12,r12,MSR_LE ;				\
 	mtspr	SPRN_SRR1,r12 ;					\
-	rfid ;		/* return to userspace */		\
+	RFI_TO_USER ;		/* return to userspace */		\
 	b	. ;	/* prevent speculative execution */
 
 #if defined(CONFIG_RELOCATABLE)
@@ -507,7 +507,7 @@ BEGIN_FTR_SECTION
 	LOAD_HANDLER(r12, machine_check_handle_early)
 1:	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r11
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 2:
 	/* Stack overflow. Stay on emergency stack and panic.
@@ -601,7 +601,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
 	ld	r13,PACA_EXGEN+EX_R13(r13)
-	HRFID
+	HRFI_TO_UNKNOWN
 	b	.
 #endif
 
@@ -666,7 +666,7 @@ masked_##_H##interrupt:					\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
 	GET_SCRATCH0(r13);				\
-	##_H##rfid;					\
+	##_H##RFI_TO_KERNEL;				\
 	b	.
 	
 	MASKED_INTERRUPT()
@@ -756,7 +756,7 @@ kvmppc_skip_interrupt:
 	addi	r13, r13, 4
 	mtspr	SPRN_SRR0, r13
 	GET_SCRATCH0(r13)
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 kvmppc_skip_Hinterrupt:
@@ -768,7 +768,7 @@ kvmppc_skip_Hinterrupt:
 	addi	r13, r13, 4
 	mtspr	SPRN_HSRR0, r13
 	GET_SCRATCH0(r13)
-	hrfid
+	HRFI_TO_KERNEL
 	b	.
 #endif
 
@@ -1439,7 +1439,7 @@ machine_check_handle_early:
 	li	r3,MSR_ME
 	andc	r10,r10,r3		/* Turn off MSR_ME */
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 2:
 	/*
@@ -1457,7 +1457,7 @@ machine_check_handle_early:
 	 */
 	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
-	rfid
+	RFI_TO_USER_OR_KERNEL
 9:
 	/* Deliver the machine check to host kernel in V mode. */
 	MACHINE_CHECK_HANDLER_WINDUP
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -64,7 +64,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
 	mtmsrd	r0,1		/* clear RI in MSR */
 	mtsrr0	r5
 	mtsrr1	r6
-	RFI
+	RFI_TO_KERNEL
 
 kvmppc_call_hv_entry:
 	ld	r4, HSTATE_KVM_VCPU(r13)
@@ -170,7 +170,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtsrr0	r8
 	mtsrr1	r7
 	beq	cr1, 13f		/* machine check */
-	RFI
+	RFI_TO_KERNEL
 
 	/* On POWER7, we have external interrupts set to use HSRR0/1 */
 11:	mtspr	SPRN_HSRR0, r8
@@ -965,8 +965,7 @@ BEGIN_FTR_SECTION
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
