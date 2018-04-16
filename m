Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523906800-2-7256872192136788550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523906800; b=X+DSh7/ZRjKvJcgo3UuGKprSi1NJi/0FiteJRsJfcV/JpDShxE
    tt/jB0m9PBaqG8I/eJao6JpXUTX/LQbkbmATSfbf3utMj0aUyGMry8CP9MaY0O6r
    IORfa56MgUw0+KAIy4BjLBfPr4RpPfgzFhXUA7C+3xw5Qdb2qaPfr/d99iaMwLS6
    iITHoZztkMgTSlJWZw7x1F9+MzusX9gI48YzNA8zH6gcnsJpD2SdX0nxKlCwMcEb
    3lkTtLDD6S01TJNoxc/jNssKLUO+tMp1FY5281/bdVGfDdxm8GiuLVL2zSTehzwd
    GWYtnqzA57whX4U1/4jetoa5KwtvCj5dKtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523906800; bh=R1vm7mkyI1Y6RuzC9v+igsnzfabPdGkICIVEFiycva
    w=; b=TVCn/djnbp5Cp+xXcDVPfQshdAaY+WeatCE6ajeoiPd7W3aNOJILrD7KRb
    Ij2v/o4KQFxIAwoqZWYvK6Nw2qIjiHOB9q14r7WpkqebpfczCYLKyCpLb+1bf2bS
    notKQN0j7UYyxmMlNc07uSCgKGK+ER29MJ2k5/TbjzULSabl957RZv/pRV2VbVRD
    FYxrkokWyR8nXA1KlzZoPRiiG/mQFoRtYIU2Z5YTywRyNFt8I+VNdTLLkEKSIJq7
    4+6P8ykg2z1Jz43+QuVJicOg/oqiUVhrk4q2clJxn/6pxtPyuUuxaSKgw//Nn/Is
    jESKcQOQ8I6TnF700a4T+jjstmcw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qg6jN3RY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vJKz1FYc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OXfvAY2g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qg6jN3RY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vJKz1FYc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OXfvAY2g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPgGlzGara3SLael+f+dg/s8VxgSnJa6Q9YhNe4UN7mw+Rvm1PP5KOYzzkvhNvHj4w5vwp2ZMYx0P5JbF9m+0o1bygTQAN2NFrgxL5vIC0N3x4rR6jhw
    0yxKo0XkhQ86mNkQR0j26oJGoz0HFarw12Ddyeh2r3JV+XbxHUq69CAmrhKrzW3rDSVCR7jEKifekV0rq/wOXsJongz9X+goe5FrXrqSGgmnDu79nSJudSXC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=toAGXmwsyvtZ_ilBNu0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDPT0i (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:26:38 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35523 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbeDPT0g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 15:26:36 -0400
X-Google-Smtp-Source: AIpwx48KVQ+Fuzs2WwwFNTdJ2RJeopgAkzC0OtOiBX7x3TAI5hsOCVnyIK1+Hq5pSX54avZVFjzm0ELZDkwqB4exOig=
MIME-Version: 1.0
In-Reply-To: <435471300.11403.1523906479091.JavaMail.zimbra@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
 <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com>
 <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com>
 <CA+55aFzZtY5ELKc+TGf9BA6px300BNzedadm_yNXzODTKN=HgQ@mail.gmail.com> <435471300.11403.1523906479091.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 12:26:35 -0700
X-Google-Sender-Auth: GngsxokCwTI62zHDD5D2ugi_dQ4
Message-ID: <CA+55aFxtZXi05UNLmtbKcZ=2N_ROE5pLnu9+v6FaXiuK=VbErA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call (v7)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:21 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> And I try very hard to avoid being told I'm the one breaking
> user-space. ;-)

You *can't* be breaking user space. User space doesn't use this yet.

That's actually why I'd like to start with the minimal set - to make
sure we don't introduce features that will come back to bite us later.

The one compelling use case I saw was a memory allocator that used
this for getting per-CPU (vs per-thread) memory scaling.

That code didn't need the cpu_opv system call at all.

And if somebody does a ldload of a malloc library, and then wants to
analyze the behavior of a program, maybe they should ldload their own
malloc routines first? That's pretty much par for the course for those
kinds of projects.

So I'd much rather we first merge the non-contentious parts that
actually have some numbers for "this improves performance and makes a
nice fancy malloc possible".

As it is, the cpu_opv seems to be all about theory, not about actual need.

              Linus
