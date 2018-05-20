Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3059854-1526825014-2-13131961791411344438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526825013; b=SGJZxGavbWZoXjU81oIaF9yMNZBddtoGuvxAm2JbMcd8Z8ZoNt
    ksHbwLKlFUSgnCywEalyg5UgpCk5AP1rcTJ0w2QbuVf3y/6lbcx44dpQ+/LmV9EL
    AH4IvZlWWmfIi1KPvaZ74ctVQ+X6QAGh/01HGVr4Ge5clqK6voSNgojHluLojA6+
    a/oC4a6GIHcloZ/RBJTTLEEVeSe16O/GGisUXu1gwJZvfDaNPxE1qAIpGWdjqjkl
    Rbbcwv6fJv+Rd28uJdJZbzzE4Kg1ojbteXa+4KFJNC/ZMKyqS7QhKb0QekPxFtuP
    hCSI3McaSHi7TLjciNVxaqlgSAF2Vp5izTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526825013; bh=Wn80tatomCbni813v3SD6YBdOrvoq7
    QowP1Wz8hhA6U=; b=lv/0HPCpLdsAufEyTOITCKLXZsAlpd5T/i7VDIg7IaiSiI
    1cgnmFrkKv73ZRDUIwMVVTAU6pPXuJPrdTrZlInPk5qfb4sJWC0EJBm8X4iYP2QB
    S0jhSkezvkklFCYb1JAih6LesYBavh/OoGwPdvK27RVhThQmSuG29tiu5Y0Q0s5e
    pMHGolZuXbsSDo1uPvH1CDxLSUexIDgBKTU6Xs+bBQVzHkBieOFW5RVEyG4sRm0C
    sRM6KrmjXuskZ2OlNT5Sxwk+pkb+tsOAGEPr0C7YJTn29BmDEYcVCCcIvdMndJri
    FZlSgh9Kb8lCN7YHkWusPp/P++L4c7mty/R1ftig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=rW4Om3SF x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Mux/V/Ep;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=rW4Om3SF x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Mux/V/Ep;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKkiA86K9isu+eHIOnbXlJiJP1WtyEuvlUFRsBb7d11hn+iaFX5BzgfBXLOCTFyJAvOoHOKjyncItOKkSKF8ZwjX2gpQ5XnHOhcZDffa7iH+/JsL6ze7
    l1vaHXw9BVS+wagPOcSEf+91GpJaWycIiKI+byc/5Rfdeuq+DmSTriEt6aDadaI+k7jhLJTOy73g+DtUHuwoDYPT83k668qfdV0yxtyOtZC1y8R066HwJcKy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=RT4zlxQfEhcA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=jeQiSZwj_hS0VBDRgvIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeETOD3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 10:03:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51032 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeETOD2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 20 May 2018 10:03:28 -0400
X-Google-Smtp-Source: AB8JxZopSviGxF2R8LNaZnifxWpA0KoFilnRENDI8ASaI7zqPmS+/qkraFm8KTF74IqOORjBJ7Y2Mg==
X-ME-Sender: <xms:KYABWwPTP57HBAEonfRCMIJdXMvlagmWplpCjLGD67CzZy7P5ihQeQ>
Date: Sun, 20 May 2018 22:08:11 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Message-ID: <20180520140811.GB1121@tardis>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
 <20180516161837.GI12198@hirez.programming.kicks-ass.net>
 <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
 <20180517011949.GA1121@tardis>
 <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
 <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
 <418003803.516.1526667437396.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418003803.516.1526667437396.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 02:17:17PM -0400, Mathieu Desnoyers wrote:
> ----- On May 17, 2018, at 7:50 PM, Boqun Feng boqun.feng@gmail.com wrote:
> [...]
> >> > I think you're right. So we have to introduce callsite to rseq_syscall()
> >> > in syscall path, something like:
> >> > 
> >> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> >> > index 51695608c68b..a25734a96640 100644
> >> > --- a/arch/powerpc/kernel/entry_64.S
> >> > +++ b/arch/powerpc/kernel/entry_64.S
> >> > @@ -222,6 +222,9 @@ system_call_exit:
> >> > 	mtmsrd	r11,1
> >> > #endif /* CONFIG_PPC_BOOK3E */
> >> > 
> >> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
> >> > +	bl	rseq_syscall
> >> > +
> >> > 	ld	r9,TI_FLAGS(r12)
> >> > 	li	r11,-MAX_ERRNO
> >> > 	andi.
> >> > 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> >> > 
> 
> By the way, I think this is not the right spot to call rseq_syscall, because
> interrupts are disabled. I think we should move this hunk right after system_call_exit.
> 

Good point.

> Would you like to implement and test an updated patch adding those calls for ppc 32 and 64 ?
> 

I'd like to help, but I don't have a handy ppc environment for test...
So I made the below patch which has only been build-tested, hope it
could be somewhat helpful.

Regards,
Boqun

--------------------------------->8
Subject: [PATCH] powerpc: Add syscall detection for restartable sequences

Syscalls are not allowed inside restartable sequences, so add a call to
rseq_syscall() at the very beginning of system call exiting path for
CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect whether there
is a syscall issued inside restartable sequences.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/kernel/entry_32.S | 5 +++++
 arch/powerpc/kernel/entry_64.S | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index eb8d01bae8c6..2f134eebe7ed 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -365,6 +365,11 @@ syscall_dotrace_cont:
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Check whether the syscall is issued inside a restartable sequence */
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      rseq_syscall
+#endif
 	mr	r6,r3
 	CURRENT_THREAD_INFO(r12, r1)
 	/* disable interrupts so current_thread_info()->flags can't change */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..2e2d59bb45d0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -204,6 +204,11 @@ system_call:			/* label this so stack traces look sane */
  * This is blacklisted from kprobes further below with _ASM_NOKPROBE_SYMBOL().
  */
 system_call_exit:
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Check whether the syscall is issued inside a restartable sequence */
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      rseq_syscall
+#endif
 	/*
 	 * Disable interrupts so current_thread_info()->flags can't change,
 	 * and so that we don't get interrupted after loading SRR0/1.
-- 
2.16.2

