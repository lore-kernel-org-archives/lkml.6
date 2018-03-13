Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955765-2-11696188490774045317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955764; b=ET6d5ipAR3DgiYCx1pQQxYlgbVh2P3di2jxgziLYIC06qq9
    74HBNWyMThcSPPfFeYrcIDGKhYNqnvrPqVouhnhpqMMOwBG5+s8lKfMmp0B+TxMs
    +sxm0LWtEH9fOeSw8/qkbaX/Q1N2UOLQB8kngVN3NMmuCphJmgOiH81u+gd+W4h7
    rz3nlDPmINW2qNNDM+ZmAe4uCsjx34BzNPOn/wHACmUjkgn2H31+exl2XWr+fN2Z
    KVz8ESgTyXd57DrnXRTIK0zCpzqqPdyN2wsbNOygAi69FPUh11EOqhEKAMqjMsSp
    j+klGr965nh+75EwAu3x/2LftA5SEhlE8JvJV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955764; bh=/9TXWOjWI8E0raK5XKs9G1mD3Z
    Kqk20WuJHYjNqmv+c=; b=Pg36TJxyDfKhPyS+tIf8b6v/+kCaH352cnXRgnhHus
    VrldZ5MmUW0anEozCjQ5T3pE579NQr0Ls7EryaQQgmhKzKbAyaNVhYW86bSvCTPR
    T6qHEaOzLeKvVa/ealr2HJuDLCqyFSgNBPKDj+nYj+yoa6jVHthRcXvvgEZbWF12
    b7L+0OvDtJpTAJAsAmAeRCcHK+tUEhOizzwzcczNGkqgeMR9KRsFDB6YGpIRZP5x
    2/kkOPmPfSlLHCfTwNlGpN7D1RY2LME+O0jCkAdKBbKWR1RACTgsDqYgd+myztFz
    Am/SH+Ji1LCbeuYLOcdae0dB3HvD6S8SsF2EyDPo0OiA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934680AbeCMPm2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:42:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964864AbeCMPlo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 140/140] x86/kprobes: Fix kernel crash when probing .entry_trampoline code
Date: Tue, 13 Mar 2018 16:25:43 +0100
Message-Id: <20180313152507.583580756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
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

From: Francis Deslauriers <francis.deslauriers@efficios.com>

commit c07a8f8b08ba683ea24f3ac9159f37ae94daf47f upstream.

Disable the kprobe probing of the entry trampoline:

.entry_trampoline is a code area that is used to ensure page table
isolation between userspace and kernelspace.

At the beginning of the execution of the trampoline, we load the
kernel's CR3 register. This has the effect of enabling the translation
of the kernel virtual addresses to physical addresses. Before this
happens most kernel addresses can not be translated because the running
process' CR3 is still used.

If a kprobe is placed on the trampoline code before that change of the
CR3 register happens the kernel crashes because int3 handling pages are
not accessible.

To fix this, add the .entry_trampoline section to the kprobe blacklist
to prohibit the probing of code before all the kernel pages are
accessible.

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: mathieu.desnoyers@efficios.com
Cc: mhiramat@kernel.org
Link: http://lkml.kernel.org/r/1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/sections.h |    1 +
 arch/x86/kernel/kprobes/core.c  |   10 +++++++++-
 arch/x86/kernel/vmlinux.lds.S   |    2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -10,6 +10,7 @@ extern struct exception_table_entry __st
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1149,10 +1149,18 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
+	bool is_in_entry_trampoline_section = false;
+
+#ifdef CONFIG_X86_64
+	is_in_entry_trampoline_section =
+		(addr >= (unsigned long)__entry_trampoline_start &&
+		 addr < (unsigned long)__entry_trampoline_end);
+#endif
 	return  (addr >= (unsigned long)__kprobes_text_start &&
 		 addr < (unsigned long)__kprobes_text_end) ||
 		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
+		 addr < (unsigned long)__entry_text_end) ||
+		is_in_entry_trampoline_section;
 }
 
 int __init arch_init_kprobes(void)
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -118,9 +118,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
