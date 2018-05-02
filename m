Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065540-1525280163-2-10351138097442087061
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
    1525280162; b=J2FXilYaBDDnbvAP0VxPQ/n/pu2D/ypoTefSSZDhdE32/mkza7
    VdK43uhauDeIonSb/va2lU2ovp/dek4ncO09VQ1LJqNu8L7jlwAix2asGj7CQ/bP
    HoKRrW1Sdxb8z8uHHo8anKD1GeegXCK/XA6cGem+njXl7EMzWF6KwP1QhEg72sSq
    heTdsVnqzqCXWvbDLQ7ctFUinxA3NKsx+EDLxERMvHFQMWuxMZq8RPOMGsNI0hJt
    aTQzVOPP1B0x/gR13LTvCD4McnWglVebal4YPp9CAVx1iNUQB/zkySWcL7co6w1T
    UgUFS9DokABWNmIbBUXF2eCyUKKj4w+DeC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525280162; bh=mAFb+TZcZebNjbLLcTafC5LK5XhQL9DO3aN1J52fjB
    g=; b=eLf2sTAiyLYqKtUztmLH/ys97YvEDDyoJ2EYDVUq2aAD+Shs/juDt5/i3F
    vIxftBmtFR1K1IAh9SgW/x4OW14etj6gKJO4lLdFnsGA0E1PPY/ObXZBaEVZGbPL
    qBxF4w0NbepIjERnIUI5P7j7TnN3A1wdUj80xWaknr7yf5/DVg+ZL7xxbwPufPHG
    DQdGnWdjSYudwDcmoSsMoTTAFippDZZSA/T/HMa1EImizk317SMA40Gjlfv/D7cH
    9QWj7TXqeXZZXfoZ6III8xto22548RGZzaqA3NzA/AUBdXhs8N6i3zEKjPfFP5wT
    jM0N2s54SlcaDGXtN9q91gVApcJA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=KrC7+F0h x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gVNO5fYf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=KrC7+F0h x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gVNO5fYf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNP1RYrqQC3xtrq+q9nzH8a/RSvilCOk0mxEyxIk7tyh3W/R/z7StJ3RgpU0ahQfqD79HVi997iI7A5Xe1Xt6EnHt4jPsJScWoVe8ALGdaekHtxv65wg
    RPpl7lVNGfUdny3bWosHGWd4kQGJDtWScWeJFJ4ydJ1t5vJd5G5bG8dnN+IBxFfrnNRmY111lQDm+KFcplH4Hp0AUdS/uxBaPHKRe0/xNLrbjgGtJevZN8Ec
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=SWhmzX8CHmD3_NRxhBAA:9
    a=RPw8_s6z2vd0UvpX:21 a=2JzY91faTCS7Iw2o:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeEBQz5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:55:57 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36546 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeEBQz4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 12:55:56 -0400
X-Google-Smtp-Source: AB8JxZrxuOHZxBYMhbBPw4FjgNwXhQKflczidm28jhXpUrYCz4x+0bg4N7qqZZ7j3OJOOIRl3d+MrgGN3ovWyDfaqqM=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
 <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com> <20180502124253.145253cb@gandalf.local.home>
In-Reply-To: <20180502124253.145253cb@gandalf.local.home>
From: Daniel Colascione <dancol@google.com>
Date: Wed, 02 May 2018 16:55:44 +0000
Message-ID: <CAKOZuetA0A8ML9V23aoFPSGqFiVgJ4enBTmjR2HEL7hE1QAJiQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: rostedt@goodmis.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, josh@joshtriplett.org,
        torvalds@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 9:42 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 02 May 2018 16:07:48 +0000
> Daniel Colascione <dancol@google.com> wrote:

> > Why couldn't we take a page fault just before schedule? The reason we
can't
> > take a page fault in atomic context is that doing so might call
schedule.
> > Here, we're about to call schedule _anyway_, so what harm does it do to
> > call something that might call schedule? If we schedule via that call,
we
> > can skip the manual schedule we were going to perform.

> Another issue is slowing down something that is considered a fast path.

There are two questions: 1) does this feature slow down schedule when
you're not using it? and 2) is schedule unacceptably slow when you are
using this feature?

The answer to #1 is no; rseq already tests current->rseq during task switch
(via rseq_set_notify_resume), so adding a single further branch (which we'd
only test when we follow the current->rseq path anyway) isn't a problem.

Regarding #2: yes, a futex operation will increase path length for that one
task switch, but in the no-page-fault case, only by a tiny amount. We can
run benchmarks of course, but I don't see any reason to suspect that the
proposal would make task switching unacceptably slow. If we *do* take a
page fault, we won't have done much additional work overall, since
*somebody* is going to take that page fault anyway when the lock is
released, and the latency of the task switch shouldn't increase, since the
futex code will very quickly realize that it needs to sleep and call
schedule anyway.
