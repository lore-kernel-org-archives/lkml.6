Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4170472-1522168229-2-8122310989641174359
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168228; b=hGyyikiq7C3KUjY/CRPiX2hJnbYulWCQ93BCZ2RHkG69Xpx
    kiNzE+lYEwuT0kOxh9/2WDswmuOcYM/5iSKaSfbQnf2GxytSF4AWnbCdOQwSPYPr
    yQrjIkhFSc/kd1TgS9Vih8h6zWhlaaBQJq5O/j48C4cu+be4FWTXyHZn1GhFgXuB
    w85XRxAQvC5shWR3MZy/qRVfmkW77a48B3HCz28B3IKNZlfIIZafq8ioRaxw40zT
    qMYY6lM1O6W65OsLozfi8RYjrk58Q9VI+ba6Pw7pyMowoYikFaMcB8+ZR6ZcXcPb
    C+DuCmkLDRm8nqQoKz+rcabhsMA+6WqbTeBv3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168228; bh=DCcUSbnHqNT6GV8Dob0Xr6NWI8
    OODuYgtt7t4t1EyNc=; b=coxHu1khiVv6JTL6x8c1jl6dpC2lOjIT8V7Y0WDkCf
    Z3QvKrFk0dT+AvG1Cx5TLJo8uVCo7lv17A0gj5wk/vk907hMRjCux+j+D1u67OO/
    TeBs1kiHn8a25jsd51vy9AhoUIJJxgBZyMpD3hNkIATB8ahcSPcuW/ZAR9FYrpgK
    c2YZZ3/ePY2niBLTauqbZRqhb5ctdJYBZWNlwAsSz0zx86CArnc04SZynIazMz9N
    /hqQjCs/qBE/XpF4xR2JgOHASM5y3hZNP7S//z4LnsXkdZyVrzkVcRvfKJSuy3kq
    jZgIUHDDA1v1a9HvaEJ/jlgb2rFtJzNQp/xBxozM0+ug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBinMcikTPBRcmLPFiHIr4xApMVg0GuG3ZOldhnZ+HuevmUFEfMY1NxC+sA7N0jMYQvLwwSrfDV4P/iJpf0WBc/YmrLBRT/GhQMrHRfRjzi+caHQTBxC
    0KImgoQpn1VZDlO0HeygzRwvFuPuTshYU3+JQ4731oclX+DUy40H5Y6Ypk98RnlkOJsEniXeXg+VvJxQpBakKQBhTJvqitHGyQT0auEKUiJ4MTw+LbDjAzQX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8 a=lvJv-Mtu9OHMF5X8DM0A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeC0QaY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:30:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeC0QaW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:30:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.4 38/43] x86/entry/64: Dont use IST entry for #BP stack
Date: Tue, 27 Mar 2018 18:27:42 +0200
Message-Id: <20180327162718.547354643@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit d8ba61ba58c88d5207c1ba2f7d9a2280e7d03be9 upstream.

There's nothing IST-worthy about #BP/int3.  We don't allow kprobes
in the small handful of places in the kernel that run at CPL0 with
an invalid stack, and 32-bit kernels have used normal interrupt
gates for #BP forever.

Furthermore, we don't allow kprobes in places that have usergs while
in kernel mode, so "paranoid" is also unnecessary.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    2 +-
 arch/x86/kernel/traps.c   |   24 +++++++++++-------------
 2 files changed, 12 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1018,7 +1018,7 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3			do_int3			has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
+idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -480,7 +480,6 @@ do_general_protection(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-/* May run on IST stack. */
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -495,7 +494,15 @@ dotraplinkage void notrace do_int3(struc
 	if (poke_int3_handler(regs))
 		return;
 
+	/*
+	 * Use ist_enter despite the fact that we don't use an IST stack.
+	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
+	 * mode or even during context tracking state changes.
+	 *
+	 * This means that we can't schedule.  That's okay.
+	 */
 	ist_enter(regs);
+
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -512,15 +519,9 @@ dotraplinkage void notrace do_int3(struc
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
-	/*
-	 * Let others (NMI) know that the debug stack is in use
-	 * as we may switch to the interrupt stack.
-	 */
-	debug_stack_usage_inc();
 	preempt_conditional_sti(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
 	preempt_conditional_cli(regs);
-	debug_stack_usage_dec();
 exit:
 	ist_exit(regs);
 }
@@ -886,19 +887,16 @@ void __init trap_init(void)
 	cpu_init();
 
 	/*
-	 * X86_TRAP_DB and X86_TRAP_BP have been set
-	 * in early_trap_init(). However, ITS works only after
-	 * cpu_init() loads TSS. See comments in early_trap_init().
+	 * X86_TRAP_DB was installed in early_trap_init(). However,
+	 * IST works only after cpu_init() loads TSS. See comments
+	 * in early_trap_init().
 	 */
 	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
-	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
 
 	x86_init.irqs.trap_init();
 
 #ifdef CONFIG_X86_64
 	memcpy(&debug_idt_table, &idt_table, IDT_ENTRIES * 16);
 	set_nmi_gate(X86_TRAP_DB, &debug);
-	set_nmi_gate(X86_TRAP_BP, &int3);
 #endif
 }
