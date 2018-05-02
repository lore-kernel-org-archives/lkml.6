Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-437838-1525250698-2-7632773794294912713
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
    1525250697; b=Qu1wn4+3qyuZJ6pCIz1Cz/y4/h/ysgH30V7/KoXICYodRzNIbq
    p2xnKHKqEDLvg5IrZOzLHHnMIeGBVgeTMra5Z/2+Wsaz99h4EW674RReQ1ypejUp
    m1hkfsf0AH5Bk2Y6p0C0XzV0xqKQq1JHVC8WdTQ+79iW509Z7nEonbCSDvo+y7t9
    nKzO08ZWwkNPDv4FSZxJAMwgf0XIl/YwJZO+sHiFiV6hWVMJD0Nbc536EctAcpFn
    krGzEqkic6PxzW6Rix9qagvg9/65/nA5IJd4TNZ5MV75Sdj1TV9YoXhhSuojaDER
    oV+p2fbaTkwUn9A3/1qNidu9S/FiGVE6ZD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525250697; bh=aKlB/lMqUe2lHG0dOXHMGMrLnMkrS6
    KTaHPyMLCPsA8=; b=QtvVwE2yV1+M0VCK5YH9/S5EoC3jGxDMeBwpz5a2ewRyG6
    ktcQHWyJw9cnwNJQU89d0eM2IVcMggP0zB+tivAGmsRplytoZMhG4ez/5Utful+c
    CsxnP4gwktpS0Y9TiRqjF9RVP+pshyDVDLJObBPvxkW1RIkda4ek8JA0EaD1LaY/
    Ql/T2H0v2LmXC3TYwLOMlYdxFMRnaaU3g9jDhyDNU3HGAuEZ7J0QHkZoYW4J+hbz
    rvrVbcsABuy1adwCLeyf4evyYX8kSx0xa3VRTp/wEgvgOTL5Fv9/rBEIxdJTU0u6
    Q+mfuNiF3lMGOBmuWkOl7jFP3vncbm/dMKD9dtkA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Urz6CUvP
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
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
      header.d=infradead.org header.i=@infradead.org header.b=Urz6CUvP
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
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
X-CM-Envelope: MS4wfNV7Sj+FdT8kdiGTP6cXTlXHpYMeFbOqQ6caaq7h9lSaSqMrqVoLf3KbKknYjqOcgvqrcEkHRcBgwjC2Jp+eYHJUv+F8ycJS9pUhAMAv7u06a/gTtN1x
    +uwwSDB0AEgamv83f956lFnAliQxZIJgp3nwakLLX7do5Ix5Ff27GPe6CDu9e5CEzYM+1u6MSTTfgN+ShbAvxHbt8nmbcYktuuhdsyQY2lcmDLXV6KDTnVQz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=giMzFFmxwogncUu-seIA:9 a=r1lsvxauelOWCy9X:21
    a=tGpJ8-T8j5qnld5c:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeEBIoz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 04:44:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBIoy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 04:44:54 -0400
Date: Wed, 2 May 2018 10:43:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Colascione <dancol@google.com>
Cc: mathieu.desnoyers@efficios.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pjt@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, rostedt@goodmis.org,
        josh@joshtriplett.org, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        mtk.manpages@gmail.com, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
Message-ID: <20180502084328.GE12180@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 03:53:47AM +0000, Daniel Colascione wrote:
> The usual approach to "better" is an "adaptive mutex". Such a thing, when
> it attempts to acquire a lock another thread owns, spins for some number of
> iterations, then falls back to futex. I guess that's a little better than
> immediately jumping to futex, but it's not optimal. We can still spin when
> the lock owner isn't scheduled, and the spin count is usually some guess
> (either specified manually or estimated statistically) that's not
> guaranteed to produce decent results. Even if we do pick a good spin count,
> we run a very good chance of under- or over-spinning on any given
> lock-acquire. We always want to sleep when spinning would be pointless.

Look for the FUTEX_LOCK patches from Waiman.
