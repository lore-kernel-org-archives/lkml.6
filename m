Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1256816-1525292595-2-3448559883374515036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525292594; b=OCYJFbQ3ThshS220SA0o/BwMDe1HD70nGa4bmbpYzGq7unxA7s
    4Plf2LuCrxcGZvAZ/3Ow2VyBZc5pt95uOMd6HMJen+4H51QZ7zkGGU0D4yBPmwmf
    NIdjPpSZ6XQvn84gyf5M5BLM4gO0gLpCCvTGGC5SdvNEiyRBOHeUk0JXJ/GYmSbQ
    4mgRVvBMAVNxuZtr2lnbhbyhlHCHtK9XxKy4BknRmXNCVLYl5n9/R28RaQaIzpNC
    Zz6EXx6IfqagqwTFvxC1Lfx0r2QKtgAwIbDyvjD3pSmN0o0Ijq7wgUkTeE1Idamw
    O0ezZK65cWNXoO5Ab/c6NvzK1e+9Q7m9UJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525292594; bh=PqXnuJQKo2kljJfyy+RCATQrKGYMQY
    h1mbBJ2Yc/wnI=; b=WAEH5Wuv0bXFevuRsuUpIW5VIoLdUWxZyHfIlxVw49hSK8
    NdfeJf14vzQn/jItBr4A+SEQs5vHHW6OTdcEyEnI9wXNev4N7xOUmMR5Hhw+JGzv
    HbGbxaVYDj0gh3Dh0Kth/gWqNHB9QJ/ESEP1Bn4KciyI2BWYDu8nzqB2t0P6aqSJ
    VAsg6jLOh1DgEfh9D94vz5C3AwpauDTJ19SMglo9Ch862e8zC0n6Ihin8as9agkC
    HzdtJMZrYjx/CNuq2aEDtJNEhFEgt6WEThr73XLDjM3ag9WdGr7lZ+nj0KD9y73M
    kCcVaP/IZsu4llVJuXWKpudRlG2snE8FtZpbHRJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=I/07liZk
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=I/07liZk
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPuzMKPyVpZujDZMrmCLkPK8GDGJ7KkxGk7gdYboqpIZp6bnuimztZCZw1o/ZJgOAEX1WnUU+CrJknHNCDiBOTzS9yRdfNJVh0Vr8hqxLRbAWk4CniQg
    qtb85GPxcGLYixzRifa5T4IBO2ADKgjpEIfQ7wZxZEHUZwtnAEtrgOfggEgjm4W6llEnZRU5Xir5Mdm1dOep4XxiewOh7m7JTqEJCGj1NbeV0urwwZ7/Snra
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=FVppMHUiS4SEgOsqw00A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeEBUXN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 16:23:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeEBUXM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 16:23:12 -0400
Date: Wed, 2 May 2018 22:22:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Colascione <dancol@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, rostedt@goodmis.org,
        josh@joshtriplett.org, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
Message-ID: <20180502202233.GV12217@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <20180502172218.GL12180@hirez.programming.kicks-ass.net>
 <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 06:27:22PM +0000, Daniel Colascione wrote:
> On Wed, May 2, 2018 at 10:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Wed, May 02, 2018 at 03:53:47AM +0000, Daniel Colascione wrote:
> > > Suppose we make a userspace mutex implemented with a lock word having
> three
> > > bits: acquired, sleep_mode, and wait_pending, with the rest of the word
> not
> > > being relevant at the moment.
> 
> > So ideally we'd kill FUTEX_WAIT/FUTEX_WAKE for mutexes entirely, and go
> > with FUTEX_LOCK/FUTEX_UNLOCK that have the same semantics as the
> > existing FUTEX_LOCK_PI/FUTEX_UNLOCK_PI, namely, the word contains the
> > owner TID.
> 
> That doesn't work if you want to use the rest of the word for something
> else, like a recursion count. With FUTEX_WAIT and FUTEX_WAKE, you can make
> a lock with two bits.

Recursive locks are teh most horrible crap ever. And having the tid in
the word allows things like kernel based optimistic spins and possibly
PI related things.

> > As brought up in the last time we talked about spin loops, why do we
> > care if the spin loop is in userspace or not? Aside from the whole PTI
> > thing, the syscall cost was around 150 cycle or so, while a LOCK CMPXCHG
> > is around 20 cycles. So ~7 spins gets you the cost of entry.
> 
> That's pre-KPTI, isn't it?

Yes, and once the hardware gets sorted, we'll be there again. I don't
think we should design interfaces for 'broken' hardware.
