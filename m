Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065540-1525281781-2-3267345225860207411
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
    1525281781; b=YL8i7yC2bKbbwpNZpSiNbIKR6egy1HQPGVU2/ifp3eFZ9ZYn+K
    4xm4uQh+r6hfCCcxGnuJyfZ/GYvlAHWajsxzO9E17mYkOCVyCsBOFkEsSHWrIXUp
    OcPBt5eYgGayUfvPTHVi1EAob08pqR61AO26okbpPn2bdWg/KenNhqmjBAU0qPY5
    MNehHw6j4OWoRMFa38jQLcvTcygTxUMWMjKqweEZsOX1qrNX81Eqvbv9m9/nCaCs
    B3QFEQH8slnTo1+9QikDrkbnlVbBDPZRc5ezpuVVNI657z646EC9Uaiik0RBlRF4
    0HUmRP80KjZFJnL/r/Tsc2FEUpera470n8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525281781; bh=xBV2ljhTr9UvWiCMB5bc55TZPfifgb
    wFBWZhl73bVV4=; b=PEHJ2Q5ZToemZIqBPZMGGeZFP6dTWiQP8va59ZS2n1dSXD
    krYE6JSa+X9MtPmhWVywtJcAu3Q8r5nuXxZboBT7RDVVqshFKZihKXtcuF/zIiH4
    KOPo9aNpFkN3WAbmBW7IPWUYvTKkEdht3FUN+EMGunUER6W40cxCOTiNnHAUbPiJ
    4yNYcIXB6MIZdlGQI/d6rcWoPOuckv0eaz+Amx0yAc6MehVINvGlfnbDna1e+Z1m
    iedE12/LDG1JTrqxyJwW8S62980mmJgOzU+6Eg23E84GeI3HbFHDO52ywXI9yl/i
    DOh+VFTudWtsZGtXx0r3hEi8NnxKOJJdbc4K0rlQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=EXVuSJtK
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
      header.d=infradead.org header.i=@infradead.org header.b=EXVuSJtK
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
X-CM-Envelope: MS4wfPQ9H9T4wUdljIsvnfl/N+xn6Gb8eLTaf/HzavPyXrtTbSjhdXyxLvISX6QzKuyrNnXRGRajr1Cvwy2b6T6/IMpsaisgpFE2o0teRqKrkyjdc5CFwBh2
    B3ZYAW2/NsbQVHM77WSdRcNZU1ES3wyqnnBstm3cyVIghu7sPtmYEGWId6HJ5PyzrDXbeqyrQ4o2+Sk7vsL+cLYGquBILipmzx1HQ7TG/35UVPuOHC2Kfa0N
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=cqcmvS0YR6wzJXb7wfIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbeEBRW6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 13:22:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59256 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEBRW5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 13:22:57 -0400
Date: Wed, 2 May 2018 19:22:18 +0200
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
Message-ID: <20180502172218.GL12180@hirez.programming.kicks-ass.net>
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
> Suppose we make a userspace mutex implemented with a lock word having three
> bits: acquired, sleep_mode, and wait_pending, with the rest of the word not
> being relevant at the moment.

So ideally we'd kill FUTEX_WAIT/FUTEX_WAKE for mutexes entirely, and go
with FUTEX_LOCK/FUTEX_UNLOCK that have the same semantics as the
existing FUTEX_LOCK_PI/FUTEX_UNLOCK_PI, namely, the word contains the
owner TID.

As brought up in the last time we talked about spin loops, why do we
care if the spin loop is in userspace or not? Aside from the whole PTI
thing, the syscall cost was around 150 cycle or so, while a LOCK CMPXCHG
is around 20 cycles. So ~7 spins gets you the cost of entry.
