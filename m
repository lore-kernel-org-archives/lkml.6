Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209120-1525337408-2-15924538659552610248
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
    1525337407; b=jCQDsXren9aDP4HAB8bUM0HJjsi1FlkKIJDu1dYGX0B3IeDN3w
    ag0I9fXu3GYLmGb8Me0h9lxf3zg44n0SMv8Joen7EjzjyDDyKoCQKzmTcqADEYCT
    eEyuMvcvWHNxPFjbnd1ckxYFusNc2yQglZdp5gRTpetVbS0/y0+18wREjd8VVIGM
    jV0viBl1CUIxwiodWGrCLs4j9neQEnHqXq9UHiVGOXfN3HHHWAUAYUAeuIB3OXLg
    4OGQ7u55Q8JDPNVWQWkiTaRrGD5lzRZIkJWsHe47a8kiGSfpnY0C5mcjbn0i32gn
    c5V7zOgdFonyXeniNMaXGzR7ARX+YOC9WgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525337407; bh=/vmQ56IsfVIXza3NxQXWE4snvy5OSY
    mhE/bbitzUWCk=; b=XJeLgnVoEuTBUiHARho+UcF0zHlphmjcYI70dQbyJYH6J8
    6pYcdf5KhcCH1YdONahryHm6Uc6I2k54R0QXnswK9vis/cZehqp8sIfx4IydrkSu
    oofxkqRN1zadmN0WYaG9EFhOrxhD3O2L88vuYdKkZ2vB6enJ3rzlJEid8d3TEXwM
    OAQlhgpM4UGwtHzJc0epj+tle4TaXLCKj/eNtJwslOMNCWnEzysVZVhDdA1oMXJ+
    kCigtHcYrvvvPcJHZV+SZrfWEFjP9xZPQ7nsrHP8RE7yf3bb7yW1/+7KDk9ZEuar
    WeElAp1gchN4jlR4B5V895zzXwA0YAGtSjJMuCSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=oI6837qz
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=oI6837qz
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
X-CM-Envelope: MS4wfHZXlHQyGgjKYV2VHU57nKn9VSDGIq5kM7CP5RN4kjYn/NbMhOqOtmAHk5thnz36QyF3b2gJFXo1OGCJCKDPDu9ZpmYDsxgA68BPGakToC+NDp4p4xUG
    8x9nShkM7G9lpy9dG1pr0PzexC1V9OH1ZfBPvZvdoLo8X8mN2GQI/vLHvu+9Bk3TNGY6yu1RNaJ8yzcWmfdLkTzQxvf7ul8Dyb5Hn27O3lMNv8Yx9o9AEJp9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=o4dMybTK_ykot_HXqoMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeECIuD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 04:50:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeECIt6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 04:49:58 -0400
Date: Thu, 3 May 2018 10:49:06 +0200
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
Message-ID: <20180503084906.GW12217@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <20180502172218.GL12180@hirez.programming.kicks-ass.net>
 <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
 <20180502202233.GV12217@hirez.programming.kicks-ass.net>
 <CAKOZuevUq-XsT632VHU1TQQ5_rGqNROXiZAqv7S+ky=-wcQ3bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevUq-XsT632VHU1TQQ5_rGqNROXiZAqv7S+ky=-wcQ3bQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 08:37:13PM +0000, Daniel Colascione wrote:
> > Recursive locks are teh most horrible crap ever. And having the tid in
> 
> What happened to providing mechanism, not policy?
> 
> You can't wish away recursive locking. It's baked into Java and the CLR,
> and it's enshrined in POSIX. It's not going away, and there's no reason not
> to support it efficiently.

You can implement recursive locks just fine with a TID based word, just
keep the recursion counter external to the futex word. If owner==self,
increment etc..

> > the word allows things like kernel based optimistic spins and possibly
> > PI related things.
> 
> Sure. A lot of people don't want PI though, or at least they want to opt
> into it. And we shouldn't require an entry into the kernel for what we can
> in principle do efficiently in userspace.

Any additional PI would certainly be opt-in, but the kernel based
spinning might make sense unconditionally.
