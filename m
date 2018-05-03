Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839629-1525367954-2-5845515739124979309
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
    1525367953; b=fYqbu4B9fGYU//YaaDv0//fy2w/fB22ibM0xYbEl0ITfsYFkv0
    ne/Dasag/fQ8Cc9ZdKUD5zXU0pnRBfPmAWcNNFG9ITYUu9nDP7losllqq1Vq1NtE
    6294zga4bebWif+lUUmBonMAab5SOrHayVjG6nMFX3bkhyTSIK1pnbbEnqrAcDqu
    eXVweOqUF1h6olW+FU/js6ZuHA4MwCx1eC70dATQiNutLZ56IioDwtvMKbkr3+CL
    XrdHwaw58qD+bS/d68OxD/VWapsZVh8aN0yXRErU83SeNdhAEJ7Le+OVJk0ty8fj
    tViQt2GcFM0WodUhfo6PtRuwAEtcwxjs/E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525367953; bh=4zyCINWLB4ztuqx9F0FXaqRYSWx5FjbYLn7LOLTI23
    w=; b=fmTWf2bc4PHvffBSF1BQr2RSa57Or2RjWVAD32RqlEbfgCtNvjLkM8ODxy
    ukYku456OrTS+HJO9XfzKnsHamJPWOG8+AgJsJvPh90SO1gxQa3iIOfCxJSAhEJg
    zIm5mUt36D1/ktNq6ZvaHDN/gyBgsQM4EogJD25HKFc4PBeWPbe4atGrGnDVqugI
    cyVABFYYVP2kMv+nNk19mJQtBcR3uQflFgF6IyDtvBxknoStEr+eHqTUAsFCXf56
    0eN0ZRnQhtjz9N8p4iEg3uYzQR/3YJqua+TqPgGOQ8TiTqOR1lnuG02RCxV0S3uQ
    1rnyu30EO7vpW4+PNN4uxWH50nPw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=rRfKQlNa x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KI2U532Y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=rRfKQlNa x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KI2U532Y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCKzzH5okH4UWWUgljhuFz1hIoOv6xZXtpP8ghAsVc5gQKz+AQduG/YNLsdvbtiuYrzjHCBk+Ar7ilr/YEMxIqxZv555Aak6F+Vr0fx9dwV8xohYuZEr
    pxhile0JX0rj6xY4HAruAwwqnMzeojr1A2T1Z705P5kCB8Ip8/HjUGJZvgm7p6F4tIOZx+bOWUq0XhDlAOt+lyuV/clmMheF9IYPDD3jdB+GHyNilsU6iqZt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=GEZHSwSkSHIjnUOVNtMA:9
    a=eF3Px7vDghp3IKL9:21 a=ld5bDyEt2zGoyfGk:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECRTM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 13:19:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40919 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeECRTL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 13:19:11 -0400
X-Google-Smtp-Source: AB8JxZrmglHLZJsyHZ+0JTP1seuq2PeOGHrLtM2rs/YzPn2bSM8AgvoNx6vbpXAVKegSjOXztmi69H0xHVOmenoVQMY=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
 <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
 <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com> <CAJWu+opXjYrjrz1=k0TjjCqiYQ0y=6jRMiRWNvb8_dHAtSByug@mail.gmail.com>
In-Reply-To: <CAJWu+opXjYrjrz1=k0TjjCqiYQ0y=6jRMiRWNvb8_dHAtSByug@mail.gmail.com>
From: Daniel Colascione <dancol@google.com>
Date: Thu, 03 May 2018 17:18:58 +0000
Message-ID: <CAKOZueve1K8bmS0pmeCAAburoJtzRA4DeN=OCyW3kHiNo8WO=A@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Joel Fernandes <joelaf@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 9:48 AM Joel Fernandes <joelaf@google.com> wrote:
> > > can skip the manual schedule we were going to perform.

> > By the way, if we eventually find a way to enhance user-space mutexes in
> the
> > fashion you describe here, it would belong to another TLS area, and
would
> > be registered by another system call than rseq. I proposed a more
generic

> Right. Also I still don't see any good reason why optimistic spinning in
> the kernel with FUTEX_LOCK, as Peter described, can't be used instead of
> using the rseq implementation and spinning in userspace, for such a case.
I
> don't really fully buy that we need to design this interface assuming any
> privilege transition level time.

> If privilege level transitions are slow,
> we're going to have bad performance anyway.

That's not the case. There's a large class of program that does useful work
while seldom entering the kernel: just ask the user-space network stack
people.

It's not wise to design interfaces around system calls being cheap. Even if
system calls are currently cheap enough on some architectures some of the
time, there's no guarantee that they'll stay that way, especially relative
to straight-line user-mode execution. A pure user-space approach, on the
other hand, involves no work in the kernel, and doing nothing is always the
optimal strategy. Besides, there are environments where system calls end up
being more expensive than you might think: consider strace or rr. If the
kernel needs to get involved on some path, it's best that its involvement
be as light as possible.

> we should really stick to using FUTEX_LOCK and
> reuse all the work that went into that area for Android and otherwise (and
> work with Waiman and others on improving that if there are any problems
> with it).

FUTEX_LOCK is a return to the bad old days when systems gave you a fixed
list of synchronization primitives and if you wanted something else, tough.
That the latest version of the FUTEX_LOCK patch includes a separate
FUTEX_LOCK_SHARED mode is concerning. The functionality the kernel provides
to userspace should be more general-purpose and allow more experimentation
without changes in the kernel. I see no reason to force userspace into 1)
reserving 30 bits of its lockword for a TID and 2) adopting the kernel's
idea of spin time heuristics and lock stealing when the same basic
functionality can be provided in a generic way while reserving only one
bit. That this mechanism happens to be more efficient as well is a bonus.

"Mechanism not policy" is still a good design principle.
