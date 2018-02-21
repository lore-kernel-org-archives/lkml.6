Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218023-5-12007181324088555739
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
    t=1519218022; b=mEq1HbNmXopean9JZ9fejeGPsmKL7iWZSl7FZAoOn57ilOU
    ihYWIU5qOYr3tm1m8dwK6Woz/iYSjx4G7AQVSyd0Opkkt/1ZspHSSXWKU9GDdUEu
    wnzPqABk8je+i1BOGmHXeW6en05mcJ/ZdfXKYc1GYqKTc3YIOQp6EtPln3JIF+ys
    NaRUPxLvE4+AwVN+WGiZiCIuuXXPlQx3ukvp5mPYPwu2YKJgFir+UDMIxG13gRuK
    zJiNZdro7Uwz6CjR984ow/Khf74x4Bw5ZLXr0GPbFp3RiIKxXrE5br9mtu5gv1SM
    ivW8na4GaXpUa+8OoXGCsagoxgmZeED+zTr5Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218022; bh=fHi3RYwevtREPBwXG2a66o+/yK
    RMFsPPnj5YS+4Dvf4=; b=cO7LRgmwi9BuYazLeJf+Uf6UpdVeb/YMjYqjLwh+uS
    +DSo63tvD/p+VrVTklsWS++hokyruZWWPBF/A+lfRh6CC4wxCL6nwV/s5/HyKUG8
    QsTl3ehcYTG1B4gU+CK+q1HVEETESG4grbkevSoQeB0m3noRDRmsFd48ZJnvIE/R
    jBvKPCTEvcLEO2kMhmFUthew42Ec5rUlI6zBqR9C6j7/r/cSS8csZQAVv7wZX27K
    6v4o14juas6qVTgi3Ojk6qioCP53RWzJFhQCWBTdiaTc+sRFOAp9DFj5PKchJPXN
    5NIrXtA91erQqVDvo6+xKt2ZmVmwoZ2UJ/QzR/KhL8ZQ==
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
        id S935283AbeBUNAO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:00:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935281AbeBUNAN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:00:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 057/167] x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface
Date: Wed, 21 Feb 2018 13:47:48 +0100
Message-Id: <20180221124527.660437341@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 3ac6d8c787b835b997eb23e43e09aa0895ef7d58 upstream.

Clear the 'extra' registers on entering the 64-bit kernel for exceptions
and interrupts. The common registers are not cleared since they are
likely clobbered well before they can be exploited in a speculative
execution attack.

Originally-From: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog and the code comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   19 +++++++++++++++++++
 arch/x86/entry/entry_64.S |    6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -147,6 +147,25 @@ For 32-bit we have the following convent
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	/*
+	 * Sanitize registers of values that a speculation attack
+	 * might otherwise want to exploit. The lower registers are
+	 * likely clobbered well before they could be put to use in
+	 * a speculative execution gadget:
+	 */
+	.macro CLEAR_REGS_NOSPEC
+	xorl %ebp, %ebp
+	xorl %ebx, %ebx
+	xorq %r8, %r8
+	xorq %r9, %r9
+	xorq %r10, %r10
+	xorq %r11, %r11
+	xorq %r12, %r12
+	xorq %r13, %r13
+	xorq %r14, %r14
+	xorq %r15, %r15
+	.endm
+
 	.macro POP_EXTRA_REGS
 	popq %r15
 	popq %r14
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -571,6 +571,7 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1127,6 +1128,7 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1172,6 +1174,7 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1224,8 +1227,8 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1422,6 +1425,7 @@ ENTRY(nmi)
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
