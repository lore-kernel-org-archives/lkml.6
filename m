Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1338824-1525293458-2-2814333723543528705
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525293458; b=D64FbEQc0JpjhGLOXeiswZp6pfTKRAt0vuKgXACGEIIZ/kQadE
    1SdOGApv0Z5TakFSx4wpfhWqxpX0l/QrTXPE3T0GQ/6i7+5gy67HHNvELlSl0Mga
    Zgyj3bWu6PMDz+0fbeoEC5ePngj+AQFc61gks7SMxlw8bvzfnwyru8SVs4uwuRVv
    5zmp72goCYVGHkjao4YYYDCE06ghwf7Ohym4oBgz7obtuiOmOppLGqbe2lw2t5mf
    sOd2KC+Wx7q71U5mWoGTnefXdQbncFs/3ILr2NATwrJMXzuoX7QWmcwdf5Q4NDJq
    2WqUYsGnUKhblGVuH2lYtbXvGZJWE0J3ldQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525293458; bh=UKCURdDaSCy45k7SRaPNsV/e+kyKkESschemnvuyzQ
    Q=; b=msXYQ7xJ6vCNmPa/TfH/52KFVLExKEWk36sJW63yjtp348mqTl5HZQxxaD
    Y+0URMZkf2jkXAEJx9DNezntNZGs4mlukOI1R5tqCfYt2CCMvfPQEON/gJROSnqK
    7h27PqCRxR+NANwz0LN6K1Ibn/RqYBFLDbdNt3I/uQMen2cTT4uS/8WSyVEXQJhI
    tLKoPttROB872Cnt79VyMI/uMDYVMRjUrgqKazA0J3mQFNcFi3+hEgSHbnBRJscT
    bLYWnpHWS1OD1NB/CbdLHv4scgkBzK/5XYn4Ybb+RfR2H1WmpMsrisNCTyEGVMFB
    77PIH08KvsLDzyGuydsoQq+F+T0A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=YklaQuKO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=G445C7+Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=YklaQuKO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=G445C7+Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKv02MFLraBcKvqvedwEEjAFIZuROToQ2637wunxHGMfFqou16dxebG1zIlzkw9+jr48yzDf3XEDgspIgyHGWMj1SLbiWulUT0MAvKH6K2XqvNSl64Ae
    nQdl5gqT00H3eMv9pjpLgpfHfxEy4GeMtKjQ7sPgO4DJmYt9vMzl4n1iY2xCW0XxmTjSVNajZMetLcsMsoFa/lVhSlYhXiRbkwJn/TpvCTNqjO3FelA3jgas
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=XT7g224mjikRb-yCuZIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750993AbeEBUhZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 16:37:25 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53571 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEBUhY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 16:37:24 -0400
X-Google-Smtp-Source: AB8JxZp3zi3QZAUKvdBkCdD30nDEliiMyfsWGANIMeebrsGugoWnLuAXXDI8HBjXLcF16OL5Dqzp2Zmbu0+KVwjUAKA=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <20180502172218.GL12180@hirez.programming.kicks-ass.net> <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
 <20180502202233.GV12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180502202233.GV12217@hirez.programming.kicks-ass.net>
From: Daniel Colascione <dancol@google.com>
Date: Wed, 02 May 2018 20:37:13 +0000
Message-ID: <CAKOZuevUq-XsT632VHU1TQQ5_rGqNROXiZAqv7S+ky=-wcQ3bQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 1:23 PM Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 02, 2018 at 06:27:22PM +0000, Daniel Colascione wrote:
> > On Wed, May 2, 2018 at 10:22 AM Peter Zijlstra <peterz@infradead.org>
wrote:
> > >> On Wed, May 02, 2018 at 03:53:47AM +0000, Daniel Colascione wrote:
> > > > Suppose we make a userspace mutex implemented with a lock word
having
> > three
> > > > bits: acquired, sleep_mode, and wait_pending, with the rest of the
word
> > not
> > > > being relevant at the moment.
> >
> > > So ideally we'd kill FUTEX_WAIT/FUTEX_WAKE for mutexes entirely, and
go
> > > with FUTEX_LOCK/FUTEX_UNLOCK that have the same semantics as the
> > > existing FUTEX_LOCK_PI/FUTEX_UNLOCK_PI, namely, the word contains the
> > > owner TID.
> >
> > That doesn't work if you want to use the rest of the word for something
> > else, like a recursion count. With FUTEX_WAIT and FUTEX_WAKE, you can
make
> > a lock with two bits.

> Recursive locks are teh most horrible crap ever. And having the tid in

What happened to providing mechanism, not policy?

You can't wish away recursive locking. It's baked into Java and the CLR,
and it's enshrined in POSIX. It's not going away, and there's no reason not
to support it efficiently.

> the word allows things like kernel based optimistic spins and possibly
> PI related things.

Sure. A lot of people don't want PI though, or at least they want to opt
into it. And we shouldn't require an entry into the kernel for what we can
in principle do efficiently in userspace.

> > > As brought up in the last time we talked about spin loops, why do we
> > > care if the spin loop is in userspace or not? Aside from the whole PTI
> > > thing, the syscall cost was around 150 cycle or so, while a LOCK
CMPXCHG
> > > is around 20 cycles. So ~7 spins gets you the cost of entry.
> >
> > That's pre-KPTI, isn't it?

> Yes, and once the hardware gets sorted, we'll be there again. I don't
> think we should design interfaces for 'broken' hardware.

It would be a mistake to design interfaces under the assumption that
everyone has fast permission level transitions.
