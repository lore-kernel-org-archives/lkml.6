Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629663-1522250930-2-4522123711196791354
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
    t=1522250929; b=r4lfdxkWsoVl3hd7PNpR8PPIuTWuMaKh9TOtCaU7cev8Naw
    9R98ncbAAwwY5AAIBSnJFwqlzI3ImC4sGx3DpHof3mPAkt0/L63E82QOTrSRHPpA
    bogiYQbPk6IXm0ioQU2D8xoWLQk3x+94b0DIJwTwJCHcupoQ+omLW2e/dPBVO6C+
    gAofonLRfs4zX9za+LUspS0XCFPfEsPnng0jFOunYrNUXTF8BLPlntknn23d7uhA
    wwb1USCI6SDm/kYtax1cjJWxei2GkkqgIJE8jfVUhJnXXTadqIcZcu1zTctIMhMV
    hnpV2dGx6Y0X7qYJwkqpBTNlFJNhoQyU0TfYqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522250929; bh=0DBJd2aIn2axDISG+dISq1tRxh
    1Lh/d8T7ey4pkLW0Y=; b=Ge08uccF55O1VDoZgIy63uRrcdrniLSXUJnqKb34O2
    wiR6MEv5D3kTUCQgmq1GHbUXt5oaXLTHaz0rJa0lXZu973TQEixlicJOdH7uNYOo
    pj/tePfckL/ZUY+iODh7WVDUT/oN+KO0gr2NZ35EUsCgdDX1KzGRW1nNingG+ZDH
    LPfLbdM61mjIWj65S6PKmzJYRu5Z7nwN11D+c9Iiy5wyJx7jmmFwhFX1CLTxfkNz
    zd55VfEi2oaBHM5kJ6f1k8glMbLBxSUO6bOSlVBjHkJtSrJrLZ2vRNW8wPozNcoy
    h3JWUOrIRb6FeTra0F1m/SAlsgW00lULqMublfl6AOuA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YvPO3PM2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YvPO3PM2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ7CVGKHTYMi+HXCXfGhmLjO/pyhaDMzOXyB/fmKdkHSVu2RMZWR5KSXMQE2FM5ejq4DJIpZ6bLgBt7DHyaxJcAmihaR2Uevakj7VYhFQanqemo0R6q6
    I4fTKJx/Pgi8NiD7TMJtxgXbXFv9KLsHK5dDpLOw9w1sZkszVUZH/crv991X9krYLI2Teh2MFPvGlkVmQ6vad5MCj9gf3K2MBnrcX1C5daisnwjRLNaD4a6X
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=tNHiDg_IQ_6bsilUGuAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeC1P2l (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:28:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeC1P2i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 11:28:38 -0400
Date: Wed, 28 Mar 2018 17:28:14 +0200
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
Message-ID: <20180328152814.GI4082@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
 <20180328125004.GV4043@hirez.programming.kicks-ass.net>
 <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com>
 <20180328145946.GH4082@hirez.programming.kicks-ass.net>
 <265889560.1.1522250045589.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265889560.1.1522250045589.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:14:05AM -0400, Mathieu Desnoyers wrote:

> > If at all possible I would make it SIGSEGV when issueing SYSCALL()s from
> > within an RSEQ.
> 
> What's the goal there ? rseq critical sections can technically do system calls
> if they wish. Why prevent this ?

This all started as a way to do 'small' _fast_ per-cpu ops, System calls
do NOT fit in that pattern. If you're willing to do a system calls the
cost of atomics is not a problem.

> How would you handle signal handlers that issue system calls while nested
> on top of a rseq critical section in the userspace thread ? SIGSEGV on
> SYSCALLs will break this case.

Have the rseq thing aborted prior to delivering the signal ?
