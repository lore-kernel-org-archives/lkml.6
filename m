Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522259406-2-8352712192719552773
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522259406; b=f2Tx2e7ustCdDRp3X+3WRqSFTp3OmL5jVBsTSJBo+E3l4ig
    X5N+QtA0p76BCkT4uXlQ32yNCfvhZ0Jq7H8E0zv4rrnQ8ae/Z++U0Z2ZfBkyPrcp
    zBvhxrICY3N2DwzbY7Evb7Rh6Vdx/ZTlvlxYe1GJa/jaeda3w4FXNrGbWHsPHmf9
    uHPe+sRS/snY7hOj+VTKcyJHyvVNRXZThm08lNWprAAARb6z5MIH74UmKi92DjTs
    cxunXeEcQpto3hlO2iLS7YrzzWBtNusEIJ2USetQFIVY2WwvQ/vHPD6mqbReodqG
    vibLxIuVMDvBhoXVZe4F8RXnPfwBO/+aETmxvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522259406; bh=PEONV1nEzMKGYfESJ1jENQUjUg
    9d47dOf0uZ+Fu00Qw=; b=qzUvQZBmgYPJ7X+KHIkk7LlNzcZUlB1afrM+WlB6k0
    rumzSaffYN7SaJRTDF4PLWHwZURh1iihZFGhJIlnCxMo6NQrQbKeT7eYtGb0ltdo
    E1c3Mxkx1GpXVEB7ditcZQqx1DU805Dzzr2LR6eE1Gerued3itFY16DE5hRMK1vs
    C4IQF0I2VyvL7Db5Ow+B5HuSW4XRdh+u7D1qp7oysTQG0k5lCgXkmlYqLaYCHMTf
    r4fQQkNA3uO/MeDYRSoGaA5ZmINsWx/Vh5w3nNbh6O1BkdBK1WLewRo3y4j0vd7z
    RlFmnWGWWlqWotjJ+STZdUu7qKLR9e76yQEOHkj0MKnA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ZwVxv/EM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ZwVxv/EM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCxTzgoSfwzRoExMq2yvIgWSC+yhTiSxBlEMhzlIJw8s7QNr5FhqiPFWPZaEuMALigxlvXoro+Sgy8Ho9l5sBJikWSHJln9LMWDXDbagf0Fyk8lDxmz4
    Zr6y1vkq7LzwCur08sky6gqabW1aPk9oHaPWmBMLgjEsnpxVt7V2NiZ8zqhtGAcFBhmwz0uxqUzB62Yhdyip1ASciAFTfCDhS3GpRHUyDvVb17vaxz9HEJUn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=s80vuZI8E2cXY8wURNgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeC1RuD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 13:50:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeC1RuC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 13:50:02 -0400
Date: Wed, 28 Mar 2018 19:49:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180328174935.GK4082@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
 <20180328125004.GV4043@hirez.programming.kicks-ass.net>
 <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com>
 <20180328145946.GH4082@hirez.programming.kicks-ass.net>
 <265889560.1.1522250045589.JavaMail.zimbra@efficios.com>
 <20180328152814.GI4082@hirez.programming.kicks-ass.net>
 <533214853.56.1522251426819.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533214853.56.1522251426819.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:37:06AM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 28, 2018, at 11:28 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Wed, Mar 28, 2018 at 11:14:05AM -0400, Mathieu Desnoyers wrote:
> > 
> >> > If at all possible I would make it SIGSEGV when issueing SYSCALL()s from
> >> > within an RSEQ.
> >> 
> >> What's the goal there ? rseq critical sections can technically do system calls
> >> if they wish. Why prevent this ?
> > 
> > This all started as a way to do 'small' _fast_ per-cpu ops, System calls
> > do NOT fit in that pattern. If you're willing to do a system calls the
> > cost of atomics is not a problem.
> 
> I'm not arguing that a typical rseq would do a system call. I'm merely
> pointing out that if we start putting arbitrary limitations like "SIGSEGV
> when a fork or system call is encountered on top of rseq", this will cause
> pain in user-space.

I don't think disallowing system calls is arbitrary. And I think that is
something we really want to enforce, because it's batshit insane to
allow.

And if we allow now, people _will_ use it and we can't ever take it
away again.
