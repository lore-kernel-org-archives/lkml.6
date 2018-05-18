Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3687130-1526635497-2-14916959401900866751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526635496; b=njgQPQtweybIpuyd7nCCNuUwOTeeRvODs/0Ez1zqiwQJ7Yd6hI
    UibN8C8DILEJl0g2yPPGZjpFgjTc0r4qPN41vVDn5o9/ZIsgndekfnSE1wXaYZrB
    lTSOXdQyEC6GoMzFRxidgQbzAbelUTP/pkaplAPPCrFKtrP0UuWusgMzk+Crwmdr
    kwxE+3CLSBajvhxNQl32zonIbstCfFqYTP0ynuKFEkRHHTMTxQ1JOoWMea+VhjWJ
    zboaaOG3aSDmGxM9CHtEPFqrFK0HFNoSL65cKhLOrnBA/1j4hzfGiCmQsjrwM4Y0
    VejmWNGibj0Nv0pCeg/1zQw/yeEsxtn3U2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526635496; bh=
    lww90Om8DeX5g87hZOkXdWLS7zUX+Yrp8u7CaHoQSRI=; b=aOV3wHWefLFZ4wMc
    1c89T4GW6hg878yUBuh4BkVSYjsiUzD87cM1FU6W0iWqYz/oA6+VD/5IygO5iID9
    chVj0DVnCvYZRhXl2ZXNXjO0JB1KeTK2VpKghYaCNeZwN1PCEvxkilo+3d4WCz4k
    u4P7jc2haHN4b+IDnkYPCJ4vFdQYAhLz1TsAGhV0mU6A1SEscMghWqWWq2nUdhLg
    g9ElCnIQJOlPZpo92abvBgE+BB3QxJP17YHUtXKTrGlW80RW2sKTIlHQLQuHS9kh
    IqQLSVs5OLg3ObxFJNC/OMrSCBLqIZefKdrVVtHQpCHBNsLWYXdfXLQJoo11A64S
    L0+DKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMLdF5RSRrGvApfEzU0I7vjyIxPqG817kgVVWtjVn3B1im/iBThsX7vHMQJb+K0Q0kJgRhezztYOu/2vxS7rZ/hBecUIldhiq/jCp0HWjptCSKIQgOQi
    GFMEd4A2nJpiXCZWo4ewM2vSnxi7ZyWFL29lXbhBm6Ckmp/HSyHt4kjE8R3iOebw46u402v1Vtt+sm7BU8CCKCsQgKto+2RwscEc882e4LGj2COIirmwtSId
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8 a=Y5ylnYEk1F1vCFbhWmYA:9
    a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeERJYx (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 05:24:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeERJRh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 05:17:37 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v6 10/28] x86/asm/entry: annotate interrupt symbols properly
Date: Fri, 18 May 2018 11:17:03 +0200
Message-Id: <20180518091721.7604-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180518091721.7604-1-jslaby@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* annotate functions properly by SYM_CODE_START, SYM_CODE_START_LOCAL*
  and SYM_CODE_END -- these are not C-like functions, so we have to
  annotate them using CODE.
* use SYM_INNER_LABEL* for labels being in the middle of other functions

[v4] alignments preserved

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/entry/entry_32.S | 15 ++++++++-------
 arch/x86/entry/entry_64.S |  9 ++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 030fbeba5f4a..4b80b2fb4de1 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -340,7 +340,7 @@ ret_from_intr:
 	cmpl	$USER_RPL, %eax
 	jb	resume_kernel			# not returning to v8086 or userspace
 
-ENTRY(resume_userspace)
+SYM_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
@@ -579,10 +579,11 @@ restore_all:
 	INTERRUPT_RETURN
 
 .section .fixup, "ax"
-ENTRY(iret_exc	)
+SYM_CODE_START(iret_exc)
 	pushl	$0				# no error code
 	pushl	$do_iret_error
 	jmp	common_exception
+SYM_CODE_END(iret_exc)
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
 
@@ -674,7 +675,7 @@ END(irq_entries_start)
  * so IRQ-flags tracing has to follow that:
  */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
 	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 	SAVE_ALL
@@ -683,7 +684,7 @@ common_interrupt:
 	movl	%esp, %eax
 	call	do_IRQ
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+SYM_CODE_END(common_interrupt)
 
 #define BUILD_INTERRUPT3(name, nr, fn)	\
 ENTRY(name)				\
@@ -835,7 +836,7 @@ ENTRY(xen_hypervisor_callback)
 
 	jmp	xen_iret_crit_fixup
 
-ENTRY(xen_do_upcall)
+SYM_INNER_LABEL_ALIGN(xen_do_upcall, SYM_L_GLOBAL)
 1:	mov	%esp, %eax
 	call	xen_evtchn_do_upcall
 #ifndef CONFIG_PREEMPT
@@ -920,7 +921,7 @@ ENTRY(page_fault)
 	jmp common_exception
 END(page_fault)
 
-common_exception:
+SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	pushl	%fs
 	pushl	%es
@@ -950,7 +951,7 @@ common_exception:
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(common_exception)
+SYM_CODE_END(common_exception)
 
 ENTRY(debug)
 	/*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 80045cb2f44c..e0798c044055 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -637,7 +637,7 @@ END(interrupt_entry)
 	 * then jump to common_interrupt.
 	 */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
@@ -733,7 +733,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	 */
 	INTERRUPT_RETURN
 
-ENTRY(native_iret)
+SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
 	UNWIND_HINT_IRET_REGS
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
@@ -744,8 +744,7 @@ ENTRY(native_iret)
 	jnz	native_irq_return_ldt
 #endif
 
-.global native_irq_return_iret
-native_irq_return_iret:
+SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
@@ -827,7 +826,7 @@ native_irq_return_ldt:
 	 */
 	jmp	native_irq_return_iret
 #endif
-END(common_interrupt)
+SYM_CODE_END(common_interrupt)
 
 /*
  * APIC interrupts.
-- 
2.16.3
