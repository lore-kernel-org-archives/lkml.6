Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804811-1525366116-2-17320995226789456869
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
    1525366116; b=Hw7g66f8EleWn2QVoF6N4mxVur+LHbSARhtjMnTpYuTN0IzINz
    9CKh8HNyGr8okTaDcpt1chUNcSqwmxCY6QLYmfA0O3tZg+j17KO66dAe5ms9OMFF
    B1h30ajpk7BMxfUhuM0UGvpY0H+8hRggD7OKV976LFsJIfZreu4wfrT9fsRcSDKX
    /MmkT7IUuN2jFx++bUq9CTv8SejeBaidHu9AFTHCKBM02ucUkWPKCoF+8xzC0YbC
    6h1v4+2XX5WS1pVs+ba2/dFcHbRJfqNaKxXbwfHNTaVpzbJPvI/Uciux712FRNw0
    KXtoarVdgrBC1XmU/GmhOW7eiDvj5lQ6/5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525366116; bh=9YYYvqcHipl5RFXTT+avZ/q6D7UjRLU7eEY+0Yh+qi
    8=; b=DT7nxg2TrpZIGXqqFApcOGz/0Ah8CUc1jC3OZiRsmh4xdoGRHcImUDiCoB
    Y4Y+c5Zn/DXcRKbbJc6Qex3MAUHL6Td4jTyKPAQPsD/c/dPBp3NRhKzqcQUWa9WM
    iT7zkNPrse4Oi3RYpC9a61jd2xZDl+GpMpvIdXG0HcIN5SlQq7p8FNqDJeV3YA6C
    EuacK4zqen65OoGCn4aMxnCpZokp2RTd29gNDBR/wqX4m7Jl1xDERuBtwGqOty2A
    j9ptcNIDr1K0mEQO1PgNhOlnPKVu9is+DwC1pJ2tfjNn9tKVl/jPo5L/e9+n5k0/
    oASLaWRnkh9G87qbdXZIizN3wVXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=HOcQV0tx x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=T0UhEY88;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=HOcQV0tx x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=T0UhEY88;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCA3byaJMU93gbtCZsf0EGZsSaIz9TcHG3RCuRKjQb/boY+FXlLhgp+wX6RWdp1UAGqEwfugV8WE5A3O/CaT1DjnuHeeXs3aIRLm/PEwD7wBHpOlUcl0
    sQ97vP5V1+cJWTLz7Pl2KD4fIzAXfYnZlII5Ad3Q+cS9IPQyrURiEKCxKr8I2t9qFsmKrC5Ojam6yvYLRU6+08BiTHm8G9tfzRJTwa9yrtBlOaW+ak7BTW7r
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7d_E57ReAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=61TxCGIKCZZU9BoXu6UA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeECQsc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 12:48:32 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34389 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECQsb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 12:48:31 -0400
X-Google-Smtp-Source: AB8JxZrK4V+3dfCKx8WKYR0EXjtkH3ubE8KZQGRBNS5v6AEL4t0rRktq24g6v0vXSYA6gfRDCWX6n7c2ct17SobFIp4=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
 <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com> <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
In-Reply-To: <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 03 May 2018 16:48:19 +0000
Message-ID: <CAJWu+opXjYrjrz1=k0TjjCqiYQ0y=6jRMiRWNvb8_dHAtSByug@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Daniel Colascione <dancol@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>, davejwatson@fb.com,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, mtk.manpages@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 9:12 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On May 2, 2018, at 12:07 PM, Daniel Colascione dancol@google.com
wrote:

> > On Wed, May 2, 2018 at 9:03 AM Mathieu Desnoyers <
> > mathieu.desnoyers@efficios.com> wrote:
> >
> >> ----- On May 1, 2018, at 11:53 PM, Daniel Colascione dancol@google.com
> > wrote:
> >> [...]
> >> >
> >> > I think a small enhancement to rseq would let us build a perfect
> > userspace
> >> > mutex, one that spins on lock-acquire only when the lock owner is
> > running
> >> > and that sleeps otherwise, freeing userspace from both specifying
ad-hoc
> >> > spin counts and from trying to detect situations in which spinning is
> >> > generally pointless.
> >> >
> >> > It'd work like this: in the per-thread rseq data structure, we'd
> > include a
> >> > description of a futex operation for the kernel would perform (in the
> >> > context of the preempted thread) upon preemption, immediately before
> >> > schedule(). If the futex operation itself sleeps, that's no problem:
we
> >> > will have still accomplished our goal of running some other thread
> > instead
> >> > of the preempted thread.
> >
> >> Hi Daniel,
> >
> >> I agree that the problem you are aiming to solve is important. Let's
see
> >> what prevents the proposed rseq implementation from doing what you
> > envision.
> >
> >> The main issue here is touching userspace immediately before
schedule().
> >> At that specific point, it's not possible to take a page fault. In the
> > proposed
> >> rseq implementation, we get away with it by raising a task struct flag,
> > and using
> >> it in a return to userspace notifier (where we can actually take a
> > fault), where
> >> we touch the userspace TLS area.
> >
> >> If we can find a way to solve this limitation, then the rest of your
> > design
> >> makes sense to me.
> >
> > Thanks for taking a look!
> >
> > Why couldn't we take a page fault just before schedule? The reason we
can't
> > take a page fault in atomic context is that doing so might call
schedule.
> > Here, we're about to call schedule _anyway_, so what harm does it do to
> > call something that might call schedule? If we schedule via that call,
we
> > can skip the manual schedule we were going to perform.

> By the way, if we eventually find a way to enhance user-space mutexes in
the
> fashion you describe here, it would belong to another TLS area, and would
> be registered by another system call than rseq. I proposed a more generic

Right. Also I still don't see any good reason why optimistic spinning in
the kernel with FUTEX_LOCK, as Peter described, can't be used instead of
using the rseq implementation and spinning in userspace, for such a case. I
don't really fully buy that we need to design this interface assuming any
privilege transition level time. If privilege level transitions are slow,
we're going to have bad performance anyway. Unless there's some data to
show that we have to optimistically spin in userspace than the kernel
because its better to do so, we should really stick to using FUTEX_LOCK and
reuse all the work that went into that area for Android and otherwise (and
work with Waiman and others on improving that if there are any problems
with it).

I am excited though about the other synchronization design other than lock
implementation that rseq can help in.

thanks!

- Joel
