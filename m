Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-999392-1525277284-2-11339620282229034167
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
    1525277283; b=endfot3qWUaKD6SswOKvWVPoRcJzDSPnXfipHDs5zq03S8yrn9
    T9YTMq5CknRHI2jO2LvEHYPHfC4Jni3r49IzyhQR7OSS9oF8mrx5IvdtvlA6t02c
    Oz5eWtBT2vuiULKIQc+W4SJ+DHKmWD6DbzHKlXnrGk/VjvxAP4IDSu96qPA15h28
    gON/qAfDNy1iOom9+JTsEWB8OEl7tSag3Sf+Hrs/NNMLNtIxEjPWrgibMDdespYx
    x22UaWSkx+JdPCXv1/iNK9rlK4dcoeOJn/XVMg3DPi8Y5S6f2R1wfuPPQBxCVb4o
    F196w8Il2u8LDCZB4WUDbRksfUhArowniDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525277283; bh=gNskO6LcKKpE31KsvSayEPey4XHys9+at/7jXUXkcA
    I=; b=d10KyzSz083dj6W6+RgwC0Q7bzIeBapoT7zCyibP8pQBG3m+x9slfy1NqT
    agSRkgtQx+fK7YyiLb6vm8Agxzii1/xIpHftG36vgRTBp4ZjTfHr9o/QtF1CyCss
    4rTJLTntr8tLobgogI3N0i8L++TJ742GtWgFBr5WU6Nr1x2qJSq0IEhLs7K+qPQ5
    3PpV8Op5oGSLtrZ8Om/WWnP+gej3bNnYmcxgKNl2Q1XZC3i0fjj143lDHVfwy5D2
    4HEtAU2LgFpUUmIiHrE5ROVjtDKXByA2lat/tYMPKFDjYyihMl470U7E3oFPf//B
    H8cn/M/usztN1uUEHvlf7f6Qwbhw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=bsOzUuS0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=WmTUXaJy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=bsOzUuS0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=WmTUXaJy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKsm2xr5oL1B8TWiaaxH5VhLs15TCZ4xU5YF105Gud2Jo38xodpLZm77ez2LxTFbXDPaN23BMO7i5TRtWvo+YBDcJLIB7O4g/dwbonndaZAhUqdItFjS
    iJE/dc5FwAcKEV/Mbltoek3cGeYxN4EK47ureBr6C52L7cvZg6cBZf5i8xdOAxZ5v8NW11qtFEDVk30ob0NxFkHRy7W9d/zV/0IKCgrkA4zXpTWtFeKYDovN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7d_E57ReAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=i6TFqgQx1yioKysgadAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeEBQIB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:08:01 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:42276 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeEBQIA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 12:08:00 -0400
X-Google-Smtp-Source: AB8JxZq8pVJtXB77/pWle6ul09i4430IoURhDAbBvBA0r+RKzhH/9XaCvfBmn1HmMmyC/ctdJoHUXQ4npXfHH+ctCtg=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com> <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
In-Reply-To: <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
From: Daniel Colascione <dancol@google.com>
Date: Wed, 02 May 2018 16:07:48 +0000
Message-ID: <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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

On Wed, May 2, 2018 at 9:03 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On May 1, 2018, at 11:53 PM, Daniel Colascione dancol@google.com
wrote:
> [...]
> >
> > I think a small enhancement to rseq would let us build a perfect
userspace
> > mutex, one that spins on lock-acquire only when the lock owner is
running
> > and that sleeps otherwise, freeing userspace from both specifying ad-hoc
> > spin counts and from trying to detect situations in which spinning is
> > generally pointless.
> >
> > It'd work like this: in the per-thread rseq data structure, we'd
include a
> > description of a futex operation for the kernel would perform (in the
> > context of the preempted thread) upon preemption, immediately before
> > schedule(). If the futex operation itself sleeps, that's no problem: we
> > will have still accomplished our goal of running some other thread
instead
> > of the preempted thread.

> Hi Daniel,

> I agree that the problem you are aiming to solve is important. Let's see
> what prevents the proposed rseq implementation from doing what you
envision.

> The main issue here is touching userspace immediately before schedule().
> At that specific point, it's not possible to take a page fault. In the
proposed
> rseq implementation, we get away with it by raising a task struct flag,
and using
> it in a return to userspace notifier (where we can actually take a
fault), where
> we touch the userspace TLS area.

> If we can find a way to solve this limitation, then the rest of your
design
> makes sense to me.

Thanks for taking a look!

Why couldn't we take a page fault just before schedule? The reason we can't
take a page fault in atomic context is that doing so might call schedule.
Here, we're about to call schedule _anyway_, so what harm does it do to
call something that might call schedule? If we schedule via that call, we
can skip the manual schedule we were going to perform.
