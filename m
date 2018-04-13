Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617952-1523621814-2-15544793874605573817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523621814; b=dYVMduAxYmr921nV6wmQ7pticXyUBUJqw7ymD15XNqSa8Lu7LF
    9H+wVR9iAeeDzv+I5MSXqmeJ/OPdIJwzW8p7zgpkRqhiwrhkv44R9oJWrb9xJ55A
    KgjGs1m8EGs1vhA/FQQ2oBV5F6vLnDCOcSDk/sS8hj1OANPDZE3RNBIknHt0+JLh
    boLcsF0DCa4LgnP8AKq5mY5oTGva2ts0QnJmSsIl5vEKYRCpR6Tsw7FQHGedvxs2
    nXFiW35c4WULExqVBMSHzQwkc1ccyoHo0K+lpF1nVKRzBvh9mGsUS2IUutc8ku+P
    x6y+2FaASkVHnqtXxQGuufE8F8AefEGBA4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523621814;
    bh=PZioIo7d9qqXRQdl8zy0AZrxHtC/pMASSzruIn9My54=; b=nZtZHUOKsp+L
    js6S1rhL3c/yTG6nmUbs+hmcGpn5E1/wlFlFHAd7PG2l71pKcXZOzSB+BBFh6gYm
    rExbvKSZFqxzRnD536UQnX2C64io8PbRUfaRA1IuyEerQ/0y1IjbKxSThPzywrmk
    RyF5pZgUFWfK8/61SIyai37B383bxZyV7BWfkrnhwlK/O1OUeqQNMyPxU+nO1leJ
    imDhVIfP9LwZXyvxC6/B8HWRwh1systnTO7SEgCM7OkBG/TOj6qQMNczr3pssr+1
    wN/Lk7mCte+MMhnbdqB8GhXcRP58KRms+MzSE3/vQGIX0SkCtw+6V7MlyYiZOoj5
    nJ6jo1zKqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDX5W5op7K9XogxQEkDALT7Drhp/59C23flTK7+umJY6yuKD3Wb7fhNeJ2URrVXztJsKiJTjI07kpJSw6okSR1LDQPd/Gd1ecW0cRjohjqeYiKxVvNWn
    5LxxV9KiKqbXM+axfFav21gQ8gIjrq2JDiddCI3B2XNERTDtiLmJ9XPxsnGJTBFL/BxQmuusjIPLx2OKryfndpy896CWOKvOIGODPZEUefQukmmjmIuNpdhD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=Z4Rwk6OoAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=ijrbNN3TRNcxAotdAAoA:9
    a=leRpHoEPkKlTYCWF:21 a=mJinUqQ4DBnN-mHv:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeDMMQw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 08:16:52 -0400
Received: from mail.efficios.com ([167.114.142.138]:39798 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeDMMQv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 08:16:51 -0400
Date: Fri, 13 Apr 2018 08:16:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <625160026.9658.1523621809662.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFwFUeNA6_0a1MOU-7VGzCw5T99cfVCPiyTpZQJdd6z=bw@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <1580648199.9463.1523563167045.JavaMail.zimbra@efficios.com> <CA+55aFwFUeNA6_0a1MOU-7VGzCw5T99cfVCPiyTpZQJdd6z=bw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: 5M5IYuysyxAgZOeC4nxxQuEZVqZf2g==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 12, 2018, at 4:07 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Thu, Apr 12, 2018 at 12:59 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> What are your concerns about page pinning ?
> 
> Pretty much everything.
> 
> It's the most complex part by far, and the vmalloc space is a limited
> resource on 32-bit architectures.

The vmalloc space needed by cpu_opv is bound by the number of pages
a cpu_opv call can touch. On architectures with virtually aliased
dcache, we also need to add a few extra pages worth of address space
to account for SHMLBA alignment.

So on ARM32, with SHMLBA=4 pages, this means at most 1 MB of virtual
address space temporarily needed for a cpu_opv system call in the very
worst case scenario: 16 ops * 2 uaddr * 8 pages per uaddr
(if we're unlucky and find ourselves aligned across two SHMLBA) * 4096 bytes per page.

If this amount of vmalloc space happens to be our limiting factor, we can
change the max cpu_opv ops array size supported, e.g. bringing it from 16 down
to 4. The largest number of operations I currently need in the cpu-opv library
is 4. With 4 ops, the worse case vmalloc space used by a cpu_opv system call
becomes 256 kB.

> 
>> Do you have an alternative approach in mind ?
> 
> Do everything in user space.

I wish we could disable preemption and cpu hotplug in user-space.
Unfortunately, that does not seem to be a viable solution for many
technical reasons, starting with page fault handling.

> 
> And even if you absolutely want cpu_opv at all, why not do it in the
> user space *mapping* without the aliasing into kernel space?

That's because cpu_opv need to execute the entire array of operations
with preemption disabled, and we cannot take a page fault with preemption
off.

Page pinning and aliasing user-space pages in the kernel linear mapping
ensure that we don't end up in trouble in page fault scenarios, such as
having the pages we need to touch swapped out under our feet.

> 
> The cpu_opv approach isn't even fast. It's *really* slow if it has to
> do VM crap.
> 
> The whole rseq thing was billed as "faster than atomics". I
> *guarantee* that the cpu_opv's aren't faster than atomics.

Yes, and here is the good news: cpu_opv speed does not even matter. rseq assember instruction sequences are very fast, but cannot deal with infrequent corner-cases.
cpu_opv is slow, but is guaranteed to deal with the occasional corner-case
situations.

This is similar to pthread mutex/futex fast/slow paths. The common case is fast
(rseq), and the speed of the infrequent case (cpu_opv) does not matter as long
as it's used infrequently enough, which is the case here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
