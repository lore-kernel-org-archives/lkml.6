Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047415-1517918282-2-13934391757020610043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517918281; b=HvVZvqSCgym3G+cb9UAmjSh8aB+C3LLwkwE7cIzVWVPDQqz
    ha1oim/ujqkMpqDcs8p9YJNxJTbITcVYruLtSWmfp51Eha2O9S4TmKuZBBVSxasi
    Z/wubDY6SmQqTpK2ej8fILyR+rINzkWoINjclgytkWjAQVQpX4ZSOY5hSlwjupyh
    qvCcB7l4vNP+WX6t3lGhlbamqhGch8oUnXGXNBg4S18dJ0yaWRO1wPZ+clwrNdMs
    g17FPiskFGhXzCvU+fUUNK3KEshhnTbXAy6uJvWnZcUI/odGIL43AJvXQC4Wv03g
    aZ4VOAzu3kTVY1H3Y11CdA0FFt0LtV9fdoYWiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:mime-version
    :content-transfer-encoding:content-type:sender:list-id; s=
    arctest; t=1517918281; bh=dKbWhB4feuCoFfhHKgZvl7ZY7/u+lbTYc6DHZW
    seKcg=; b=XIVTrAHsbVbK77DdVb4+y380/0NJgJ3BAhr4FRyCfLuX34Q966P/wT
    617CgHZ1LjpxRQ0ixmqQM8TaX194c6FjzjmX5Q2kXmryJ6hpKZpQBbY7W3mBIjQL
    taaC4g3dnwxoOWX/XmARPxdXsUSSi3iPTIavDTPrS+g60IRvDc08qnvYcxBWin9z
    2Gm9sj2vQdtlkYOIm5r4Rqv0fMwJFFimScv4OSrJDE+G/7UTCFpda6O8BBIKmPup
    dznEGn+Idmdf73Isbr09ebcCA1rsp++N/u3u0rorx6rlYZQsqb19962pemEYe00Q
    dpqnsxhcRwMLSOpBG9v0Ws0gahMF2Cow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeBFL6A (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 06:58:00 -0500
Received: from terminus.zytor.com ([65.50.211.136]:53943 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeBFL5s (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 06:57:48 -0500
Date: Tue, 6 Feb 2018 03:52:01 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-8e1eb3fa009aa7c0b944b3c8b26b07de0efb3200@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, dan.j.williams@intel.com, stable@vger.kernel.org,
        dvlasenk@redhat.com, mingo@kernel.org, hpa@zytor.com,
        brgerst@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        jpoimboe@redhat.com, ak@linux.intel.com, luto@kernel.org
Reply-To: bp@alien8.de, dan.j.williams@intel.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          dvlasenk@redhat.com, stable@vger.kernel.org, hpa@zytor.com,
          brgerst@gmail.com, mingo@kernel.org, luto@kernel.org,
          jpoimboe@redhat.com, ak@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <151787988577.7847.16733592218894189003.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151787988577.7847.16733592218894189003.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Clear extra registers beyond syscall
 arguments, to reduce speculation attack surface
Git-Commit-ID: 8e1eb3fa009aa7c0b944b3c8b26b07de0efb3200
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on terminus.zytor.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  8e1eb3fa009aa7c0b944b3c8b26b07de0efb3200
Gitweb:     https://git.kernel.org/tip/8e1eb3fa009aa7c0b944b3c8b26b07de0efb3200
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 5 Feb 2018 17:18:05 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 08:30:27 +0100

x86/entry/64: Clear extra registers beyond syscall arguments, to reduce speculation attack surface

At entry userspace may have (maliciously) populated the extra registers
outside the syscall calling convention with arbitrary values that could
be useful in a speculative execution (Spectre style) attack.

Clear these registers to minimize the kernel's attack surface.

Note, this only clears the extra registers and not the unused
registers for syscalls less than 6 arguments, since those registers are
likely to be clobbered well before their values could be put to use
under speculation.

Note, Linus found that the XOR instructions can be executed with
minimized cost if interleaved with the PUSH instructions, and Ingo's
analysis found that R10 and R11 should be included in the register
clearing beyond the typical 'extra' syscall calling convention
registers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787988577.7847.16733592218894189003.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog and the code comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c752abe..065a71b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -235,13 +235,26 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%r8				/* pt_regs->r8 */
 	pushq	%r9				/* pt_regs->r9 */
 	pushq	%r10				/* pt_regs->r10 */
+	/*
+	 * Clear extra registers that a speculation attack might
+	 * otherwise want to exploit. Interleave XOR with PUSH
+	 * for better uop scheduling:
+	 */
+	xorq	%r10, %r10			/* nospec   r10 */
 	pushq	%r11				/* pt_regs->r11 */
+	xorq	%r11, %r11			/* nospec   r11 */
 	pushq	%rbx				/* pt_regs->rbx */
+	xorl	%ebx, %ebx			/* nospec   rbx */
 	pushq	%rbp				/* pt_regs->rbp */
+	xorl	%ebp, %ebp			/* nospec   rbp */
 	pushq	%r12				/* pt_regs->r12 */
+	xorq	%r12, %r12			/* nospec   r12 */
 	pushq	%r13				/* pt_regs->r13 */
+	xorq	%r13, %r13			/* nospec   r13 */
 	pushq	%r14				/* pt_regs->r14 */
+	xorq	%r14, %r14			/* nospec   r14 */
 	pushq	%r15				/* pt_regs->r15 */
+	xorq	%r15, %r15			/* nospec   r15 */
 	UNWIND_HINT_REGS
 
 	TRACE_IRQS_OFF
