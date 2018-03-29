Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1224189-1522340701-2-13395586948761014948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522340701; b=T5UFvFx6IfNp/KB2JltNmLj4YE1D8K3QEFlTsrDTU1C0pPI1om
    NpDmbARVug9tLHgBiE7Fc1LcP088NTsR8HebF3a3qYfn1eUaWwIqlGp6xSY/XZNX
    U7VRupT6spusdStGi8qt7EmsFxYYWI/5FgnjoLUFTF62CZRRAun+f6Ath1ytUkd3
    pIZc3jvyqI1UlU4mURWbw/UXYGwt8kl7L7hh3cZaVUp4bfez0+yhEHquH1/kUlrH
    OhfeWyrogTKPCUs7eFU4yC2TtccVmnhMvwLiRy3sT/0/KbGalNnjv9u/XkP2qJfv
    gSA44L0Iyoyrob/zF8e5BVh3twzNwggIWb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522340701;
    bh=jd7EpB83xxOlZk5G/Wpv2uQonwXFfOnxHQQeoATu6Cc=; b=enmIgv4pLxky
    Ul4CDYoIxV1LsJGqBD7OoxO4RIV67BHzv+RB3rY0iVCFRysy/f6b+MEfTJ5axZ2x
    sYe81PQ0fsna/ecS9qXuMzDe5AszBba2smYojxrqOozKygwclA/xZaAPz5ertGv/
    TQIv4y2nUpSUnB7aUZbAS9q/YN2U3u/gsNczDIbiogDQULCZ4avYx2Y+Kpn/z+6X
    3/A+BA+AYNJXz9U8hZvaDweNZUHHrowQUwi/z2Dy7JuxwH1r4EPURsS+7G5RfLvP
    hbHY3q1WUm7GGHJ4zUQ+l6lRjJAHXVF0hpW/AsEIfWhHME5M3kT2eyFfm552uMUS
    4hrHf8LwLA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyR35WMJDy3UXhbBvRqMSKK6Dr4WbbQ3NtYX1HzIV9g2lQIonX4oUs/GlPvzEp1gYXFa6gnyeQRnO4rj9q9oPJHwnOXhY6hlZGCLdhZmYRd/6PJfrhh
    72Ga1dj/38mkIjUnzPWQBtJs+1pFmnl7VjepAqIRXfD4gRxOx/yTZhphHLD9FIiM0bP1x9peXfyJSjqLwdQjILuv81pUV3Qt81zAOzFzsAdzO4YstRSJZD4Y
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=8DdmwB8Ear8l6ka34QgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeC2QYr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 12:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751859AbeC2QYo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 12:24:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE8521773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 12:24:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
Message-ID: <20180329122439.4a909c72@gandalf.local.home>
In-Reply-To: <544124089.623.1522337940950.JavaMail.zimbra@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
        <20180328152814.GI4082@hirez.programming.kicks-ass.net>
        <533214853.56.1522251426819.JavaMail.zimbra@efficios.com>
        <20180328174935.GK4082@hirez.programming.kicks-ass.net>
        <181076499.279.1522268382303.JavaMail.zimbra@efficios.com>
        <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
        <87410797.545.1522331641598.JavaMail.zimbra@efficios.com>
        <20180329142338.GD4043@hirez.programming.kicks-ass.net>
        <544124089.623.1522337940950.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 11:39:00 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Enforcing SIGSEGV on syscall entry when nested in a rseq critical section
> will not be free both in terms of syscall overhead, and in terms of code
> maintenance: we'd need to add those checks into entry.S for each architecture
> supported, which pretty much doubles the amount of architecture-specific
> code we need to implement for rseq. Currently, all we need is to hook in
> signal delivery and wire up the system call numbers.

Why not have the check on syscall exit? Then we could use the ptrace
type mechanism to only go that path when a rseq exists for the program.

-- Steve
