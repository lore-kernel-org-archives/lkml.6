Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523898167-2-17513040680205640867
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
    1523898166; b=po84FkqVxTKZCr6P6g+++9QpgfdeObr6wtjKMUxQjzUAJj6ev2
    rfyZgO3FyTXpb1QKFY2KyhzG97VE9ElDTD5L+IlFZ+wTKZodq0T+2AmMXxp7BEM5
    Db2KSrwnpHa2vksKaoe+/T5fqVXXU1iuN+CoRhXyCf/gnEyCzCO2GmEvx8Kyyvav
    1RWNFrdhoLyyBYtHg3d2LKlqKneXNY9TEbAGVbUMH9ixHfd6R5/lKD3f8FDveWvH
    An0HyqvQQYYXV2BaLNg8vpWgWIehrafmuXZZGpnqGSw0D25rDQDnW5IntSIQlz12
    bJK+EhTTaHjnJpowo+yzSfZqyY9o4x2TGXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523898166; bh=XuJI9GzmDzZCOLuyRKYMORK72MnV3K
    k8s6VguuebTT4=; b=Au6Feli9vhcO3oq6edzJJu9PQ3uJ1rPveYBiA5y8n11DZk
    rWrHG9qN2qz8tsWVk/Ji3oED/KI0vJIeRm/m8q4eJ6pdGra6jxzoj0g+QF+qufJD
    JZ2XDv0rP1+ZVbli/muFlnj9bEcrsOqvTrSO6PvGMyjjpC9I4CJ6As8daKKaYbWR
    sTLLMKg/XM9P9if4Uy037UoimFllkNia1orVA3Zcb5Ffkpf8+JO5/AMvZLcJes6m
    UCduRlwaV9z8O5axONSAyOQTW9aXw+xwivS4sElmSBmOd+ZC3p2WDgjbp04rlU9b
    2u+BHuUP3M21NfDLCHFIEZGejSq3QG3b1TNGcV2A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=firstfloor.org header.i=@firstfloor.org header.b=esvxTEIz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=firstfloor.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=firstfloor.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=firstfloor.org header.i=@firstfloor.org header.b=esvxTEIz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=firstfloor.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=firstfloor.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP+iNTR/ft2zvctd1s69zr+C1RK4x/LEUDqiszs0fJFACQJk6BSBDKMUeoIMPA6E9MICa1CgU+jDADnGQSwRRU9JS79t7vSmmEGhcl7ZwK8dX82oVkxQ
    DMBj+uusq2UtuZJUBgl35EGYo3Otp+ZjxNTvgp3LSZ5NvA8QquwbQ1nRbw2D5R20pdWzms5mj1R3WA7zJWX7qHiJ6x89Z/filDqaPveKEX9xVZ7p06VitCvU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=XVx0xDqltJnYtrmeZsIA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDPRCo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:02:44 -0400
Received: from one.firstfloor.org ([193.170.194.197]:47028 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPRCn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 13:02:43 -0400
Date: Mon, 16 Apr 2018 10:02:41 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andi Kleen <andi@firstfloor.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
Message-ID: <20180416170240.mymd2kqfimydkhos@two.firstfloor.org>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com>
 <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
 <20180412202302.xnw5jdl3upl46ywt@two.firstfloor.org>
 <751033048.11156.1523896094938.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751033048.11156.1523896094938.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Single-stepping is only a subset of the rseq limitations addressed
> by cpu_opv. Anoher major limitation is algorithms requiring data
> migration between per-cpu data structures safely against CPU hotplug,
> and without having to change the cpu affinity mask. This is the case

And how many people are going to implement such a complex separate
path just for CPU hotplug? And even if they implement it how long
before it bitrots? Seems more like a checkbox item than a realistic
approach.

> for memory allocators and userspace task schedulers which require
> cpu_opv for migration between per-cpu memory pools and scheduler
> runqueues.

Not sure about that. Is that common?

> 
> About the vgettimeofday and general handling of vDSO by gdb, gdb's
> approach only takes care of line-by-line single-stepping by hiding
> Linux' vdso mapping so users cannot target source code lines within
> that shared object. However, it breaks instruction-level single-stepping.
> I reported this issue to you back in Nov. 2017:
> https://lkml.org/lkml/2017/11/20/803

It was known from day 1, but afaik never a problem.

-Andi
