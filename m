Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977504-1522333455-2-288520789765414495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522333455; b=remPGFQ126Jo0chbanA7xVf1pY6cnWNd6rC24OUSVCaQNUESCk
    1ZPd+2XqgTxnJ39K2r98NoPYSbHxvrvlCiqCapi1HdqEf+PpXh7UJUCsHd1pkocT
    7qljls0sihtyPzdzyNLW2ZYHBLFzhc3S6AECRpu21PDwHS07mGQ22qQqi985A95Q
    wtBxCXepUwesGNaZNCW6Xas7VYX8NGIfzb9xPiPO6knUCRfTCa9RibyfINu7qkEr
    59wcrbVJKC1xunvzfkbg+qSm3/0phiv31+RQixJsiFe97D4Aj8jebt3kRLsX0Gff
    EE7zt2y5u7QZh0/ugGvHij6CMlCl5LS86OZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522333455; bh=E+m39RlXJDSlLM+PrTcMiAYQAGN5Nu
    U8tRzY0nteDxs=; b=Xtp4BCQn4z3dp+xrgE4J6PvLLLrMnojggreMYHKucN7CDT
    hJLhhSKARbnQgZ7ORT/bO8vQz/n9DYMI1ZdmVRCwuA3TqU7/lI5oicYTqPk9vrmU
    /jJkbS2Ao/wZNzWJT5K9GYYh4vYIKr6ok//SIjy3wUEI7qWVJ3g2MAzfdPi2ro3a
    yEebkkh5hbyHki7Msx1YbAoAa+1GF35nG5evsfT+f3BR+YV7cw0eJpbUrqGy+ZWs
    Y1rs8N7hv2A/F21fpmOa5xuYij6MK38GKe+yStGFqgMHSXQ35Ez1lgZeZiAZ1hst
    hA0D2e1x9fHEdZjnuoc3ZE1Gvohm47lO5e11R0Xw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dSlwO6h8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dSlwO6h8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBEs1IECPefiGtvT6coPb4i3R6fEzUQkSQUt8re7+azQ+3HKLgQyF453QULCrQhgy7IeN4o6fyd5zpS30Zr9zaAOK6oyqgs+G5RyW6XUS/JjJbL3ySCb
    buFtojXz1ocbYNZqMYV0d9Si2M3J92ak5o6DOUYFOhwtNpJ3ZEm6q9IIAsW3EXrZFQTdinQgxii7dI3ZrkIVfIzcKiFwntQEmS9Q0ifVRNqn2f0A6zSbJ5p5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=zKYkV1LRVLWhQiTY3JMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeC2OYN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 10:24:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2OYN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 10:24:13 -0400
Date: Thu, 29 Mar 2018 16:23:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180329142338.GD4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180328145946.GH4082@hirez.programming.kicks-ass.net>
 <265889560.1.1522250045589.JavaMail.zimbra@efficios.com>
 <20180328152814.GI4082@hirez.programming.kicks-ass.net>
 <533214853.56.1522251426819.JavaMail.zimbra@efficios.com>
 <20180328174935.GK4082@hirez.programming.kicks-ass.net>
 <181076499.279.1522268382303.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
 <87410797.545.1522331641598.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87410797.545.1522331641598.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 09:54:01AM -0400, Mathieu Desnoyers wrote:
> Let's say we disallow system calls from rseq critical sections. A few points
> arise:
> 
> - We still need to allow traps (page faults, breakpoints, ...) within rseq c.s.,
> 
> - We still need to allow interrupts within rseq c.s.,

Sure, but all those are different entry points, so that shouldn't be a
problem.

> - We need to decide whether we just document that syscalls within rseq c.s.
>   are not supported, or we enforce a behavior if this happens (e.g. SIGSEGV).
>   If we enforce a SIGSEGV, we'd have to figure out whether it's worth it to
>   add extra branches to the system call fast path to validate this.

Without enforcement someone will eventually do this :/ We might (maybe)
get away with it being a debug option somewhere, but even that sounds
like trouble.

> - We need to carefully consider the case of system calls issued within signal
>   handlers nested on top of rseq. When RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL is
>   _not_ set, neither in the rseq c.s. descriptor nor in the TLS @flags,
>   it's pretty much straightforward: upon signal delivery, the kernel moves the
>   ip to abort, and clears the tls @rseq_cs pointer. This means that any system
>   call issued within the signal handler is not actually within the rseq c.s.
>   upon which the signal is nested.
> 
>   The case I worry about is if a thread sets the RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
>   flag in its TLS @flags field (useful in a debugging scenario where we want a
>   debugger to single-step through the rseq c.s. and observe registers at each step).
>   Arguably, this is only ever used in development. However, it does allow a situation
>   where a system call executed within a signal handler can nest over a rseq c.s..
>   So if we choose to be very strict and SIGSEGV any syscall nested over rseq
>   c.s., we may very well end up killing the process for no good reason in this
>   scenario.

Yes, that needs a little thought; but when we run the signal handler,
the IP would no longer be inside the active RSEQ, right?

> - We need to decide whether all syscalls are disallowed, or if we want to pick
>   specific ones (e.g. fork()).

All.
