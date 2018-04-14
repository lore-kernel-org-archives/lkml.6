Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3054875-1523745875-2-3987448979387848341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523745874; b=iVnSnzrX1/X55Owx6Aht1Xmpi6uwTQd0Q4zRn9rWpHD2HsFvj0
    OiQgva9Z95ud6ElVQXeyBrDpHIuOY9yc+y4V8S1YPVTspErffErA045k3nUiDwt5
    RdCrnCGY3u6fYGJcYhJVs6Qb8uK0ftMByZIDo2+/V9fnCqWsB+sTdNN/73RxY8f4
    hKZYbhCqfSJYrfQCNsrVusULScVerDULPPQLTitspKtptChqXw/ilJ2ewKop+njR
    W+hZHGafxYHRt0L65ujxdcJI2zf+7vgS5YSd5jhL+62g91kXS+ykVqzVTD6g6oIh
    Jd3eDsmj2vQ95+0aRkEMVPLHuWzAaaqvvRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523745874; bh=2Vdnn1UoCUeKMOLNgnYQwhM6q5Lq4MGLe55iIPgma8
    A=; b=LsHeOCg2Q7J+qFm4rP7f2pJzPyF9A4hUVo89hsJuzNii6hwDEqshOcavyW
    V2lEe8+m4Iquc78x9TFx3u2zuMALgPRzqy4sXUV8AwRemaJc5csJdz2udfEr3u+c
    3V/c2zGphvqhCkrnJRrhw2aDKeDRJ7Z7agzHePUpCurxq+EKYLRS/oTjR2wjlnc7
    HUaHI00tLtLQuWfsChSknkBkOS12LUuNfD9I1VTo+JtuBURizkzQVmqZXcu1vWym
    CsNk5T2NPauzQggg1tnXh053npcjvGLqLPobodx6Zaeg9XyzpCPGpxwoPcITlBfR
    VhLlKcZHqR5BOUImAxff9NVGRV6g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=u0HtCV3n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E4DAHMwW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=u0HtCV3n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E4DAHMwW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMAPChm3ysee9zqYwiNrQWwrXPOzrG3hKuwy1y3AKDfNnKlJXXr82i0bTjoEXyTwmpE3O64lfpotsNGRmO/7gDkoxVEibPCrpNk1gKOrR5nsR31+7jFf
    I/AdL9NoSy0+4fDbWZP0OUi5+pT6tUO9HMaXOOwrnrI+yn9jvc/gf7v6MImQrsPi3/rRD+uT6CC00ATNk67Yz3j3fm4Xb+BPUMp2r6cFA5Cjjn10IJZPrG0G
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=hbg6G13i_pNgneBZaasA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeDNWod (ORCPT <rfc822;greg@kroah.com>);
        Sat, 14 Apr 2018 18:44:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38205 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeDNWo2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 14 Apr 2018 18:44:28 -0400
X-Google-Smtp-Source: AIpwx49LwWL3oBb12UNBFwvUxuDzKpzk0vHtldKnC3n5kJ22HfTcJBZedS8y0LhVkl42SYQETmuFpUaqX2Z0PReyLVc=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 14 Apr 2018 15:44:06 -0700
Message-ID: <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call (v7)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:43 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 12, 2018 at 12:27 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> The cpu_opv system call executes a vector of operations on behalf of
>> user-space on a specific CPU with preemption disabled. It is inspired
>> by readv() and writev() system calls which take a "struct iovec"
>> array as argument.
>
> Do we really want the page pinning?
>
> This whole cpu_opv thing is the most questionable part of the series,
> and the page pinning is the most questionable part of cpu_opv for me.
>
> Can we plan on merging just the plain rseq parts *without* this all
> first, and then see the cpu_opv thing as a "maybe future expansion"
> part.
>
> I think that would make Andy happier too.
>

It only makes me happier if the userspace code involved is actually
going to work when single-stepped, which might actually be the case
(fingers crossed).  That being said, I'm not really convinced that
cpu_opv() makes much difference here, since I'm not entirely convinced
that user code will actually use it or that user code will actually be
that well tested.  C'est la vie.
