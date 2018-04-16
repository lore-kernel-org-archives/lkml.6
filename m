Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523904773-2-3495661108947972220
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523904773; b=NB5fa8h1cBSOuOiBAMW2EHVgZjNMyUxqCwZbJolWwt5nxxoooO
    6oHha8mmH9/IIbQC1IBZdGfPW0C+eHOMc3a3HGf34iLXUCF08qHnx28R0KDIS+bx
    p39tGZv+AC/Za9UHPO8XyebvtS1DUAGvC17t6mHyQocYH4TYjBVvmzcIPz9Tzjbr
    ND0nhCpUTPaMarGC4iPwzLdxwd4FKAnJWAbrHWUjNN6wpkv7WxPP/FwjV4x3OvoM
    yrKZayhnCDjkV7F8Y4Fr9xkpyBWKGWbWJ5xI9Qrtq1A9R7PQDECsL+woQXapr22R
    sEUapXJXIXbsWVqSV2Wp9Xkq4dQl+FvwOCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523904773; bh=fjMfOqd1FHuJHc+2yToB/Iucw2HbMZo4imXqrC5Jq0
    4=; b=TCOFaC0K/JVF+yRWuJ48NtnQh5/qZ6pRqCo83iP1DWLAYWZCDC2edGp10m
    Bp1X2q5eXvjSTGIY/xU4+fDypdgdHkrHhtjLVGcGlcvEWMifnv9HkmCOZDBt3tZz
    OwXZEoqO2jgYz8ntdLwNS1f2vEZeFvllccLTJIOGEkLbZ0ZSAFBWa+/rXRIz9bkg
    KJXB/QGcLiNCquUmacEvG+Eq1qNddLf9I1B+Ei6cGqRCm/37OrdOrUJ3sTjffIhC
    KdXrjO1pFnLEzwFPLR54psk15PcqbfOR5Lcgu2Ql4lE0wO6455FKDVpC0KLu701s
    LLF2wiYscMpDMn2vi1j7tKD3pLNQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OXBq+bil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IMSEwzqH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y4wFGYMj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OXBq+bil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IMSEwzqH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y4wFGYMj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhebNm87RQZy2P1pyzDCTrjI7esMYThsmZ3S/qwN/KcZFO2HmXRAG62yiGqiuDfDIbj7HNKQFqY5qNIlIzz3kM5Cc1sG47ATX3wybIh2nMTSpOaSWVg
    2+nTiE9CfLmn2yBZNQ2uQl0wK8Y1UJ0IAHlIKCSa2Ulyh2hXsKLLue3eorJKHBGW67Zi01NKcJMY9hi5YuFOFce+V2fEZ4nLWy37oQ61l+JMNLpQvumbR0yF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=BDiQlp9NxWKCIJu-mlgA:9 a=QEXdDO2ut3YA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeDPSwu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:52:50 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:44082 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDPSwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 14:52:49 -0400
X-Google-Smtp-Source: AIpwx49qSohkT1O7hJ0+RcacVbqJ6uOcLWuSuBVMErvnUDXQ/2D+AsAhJ8mMBWPpfSR58Lg50u7PBaM3C8FHxa7MSbY=
MIME-Version: 1.0
In-Reply-To: <20180416144117.5757ee70@gandalf.local.home>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
 <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com> <20180416144117.5757ee70@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 11:52:48 -0700
X-Google-Sender-Auth: Jz6EJ2cJD7adV8PKLyd981btY_o
Message-ID: <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:41 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>I never said the second
> bug fix should not have been backported. I even said that the first bug
> "didn't go far enough".

You're still not getting it.

The "didn't go far enough" means that the bug fix is *BUGGY*. It needs
to be reverted.

> I hope the answer was not to revert the bug and put back the possible
> bad memory access in to keep API.

But that very must *IS* the answer. If there isn't a fix for the ABI
breakage, then the first bugfix needs to be reverted.

Really. There is no such thing as "but the fix was more important than
the bug it introduced".

This is why we started with the whole "actively revert things that
introduce regressions". Because people always kept claiming that "but
but I fixed a worse bug, and it's better to fix the worse bug even if
it then introduces another problem, because the other problem is
lesser".

NO.

We're better off making *no* progress, than making "unsteady progress".

Really. Seriously.

If you cannot fix a bug without introducing another one, don't do it.
Don't do kernel development.

The whole mentality you show is NOT ACCEPTABLE.

So the *only* answer is: "fix the bug _and_ keep the API".  There is
no other choice.

The whole "I fixed one problem but introduced another" is not how we
work. You should damn well know that. There are no excuses.

And yes, sometimes that means jumping through hoops. But that's what
it takes to keep users happy.

                 Linus
