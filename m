Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1173628-1525285658-2-10227827978058251311
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
    1525285657; b=ReB1OFYF2w03l5H4LDI0z0vPkRYtPiiPcgWYUGBRSsaW/5gBDi
    1Xo2HniisizBjZYyZACukaSKbDBFoiminewERwc7kqMOov6eo4dvrfC+S9H8UWvU
    qsEG9hGyk4DUPkivONL4QaczlcykDcelsu9IiBzi1m8HQd2Io/PulKh+GyjzcJvN
    KFlp7r73Ydqz1H+uA+dipJQeISKElWHIh2GOcScV3Cy4ZFVjHukV+mdwJG1p4vat
    ZzquWPgyErCVBxJuckGqilUL8ByQ1AYJ2YqC9LaG9IDjiz5kdxhKA0wMI05szk2O
    VtncZHz7e8f+aM4ToLesOod1md+4JE0Pv/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525285657; bh=uiIa90Vb+p4KgyeHQC/QkXUuH8vBOj+2ZU985ohOhX
    M=; b=S2ooijbZbeqYYMbwbwtvjZyl5kMJA1EsJ9cTTd2Czmf06gyytZTeHGKCMc
    N8FzyzKbz4fR3KKLKc+zo5y3Gz+9wl3CP73aAdZU/hDmL8uY8B8MZ260BbgRM/HW
    Znt+dar2e8BXdltf1LZ3XeJ3gezpd9oR09lrLef80FS/M6yE2ucHGCfCYBIPshQ9
    PgMZk4+fqLe61ZSVkr92AmpT5p9bu2H167fw9EhaYO8fo9x0vkwjVtcAo9ZIHTkU
    QYp47xjTglulSYyEzN9A3Vj2TrMgHFCW8ReO7v9CTufmIunHQ/p5UqjnKvYZGkaU
    Qc7goIPZDc6NN1YloEbVaBP3ZkvA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=BI3xbDv9 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=MK3m0Cnp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=BI3xbDv9 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=MK3m0Cnp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpoxIIsZGMdeX3pDp4eR/CF3p+wxJ8o5ngE/5MzfmZCvQhWvcANCpYSr74RRe8m9TMPLHSlYHM1s6yxKbPq59jDs91xqLm5ZGBReUSAek0JJvSI4poJ
    op5jQQT1P/itxR4wlPhFSrSuBVVlKuwvRvD9sNCJoOAL17LNtDT4tj2EkGwMiV+R8Cq5qMG//eOQlo0flul/59gp9Xv4nMPEjnxRVjXWaaIyJX2cMdz3gtJK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=4a5mOlgJNlI9TdP705kA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeEBS1g (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 14:27:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36736 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeEBS1e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 14:27:34 -0400
X-Google-Smtp-Source: AB8JxZokXsAdMWsCeDE4RpigQi+7taF8phGuH8cU9AuCJMnPs8f8irsFKtQ+sfw2kPvrApimGSbtLuItc56ZuYkIX+s=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com> <20180502172218.GL12180@hirez.programming.kicks-ass.net>
In-Reply-To: <20180502172218.GL12180@hirez.programming.kicks-ass.net>
From: Daniel Colascione <dancol@google.com>
Date: Wed, 02 May 2018 18:27:22 +0000
Message-ID: <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 10:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Wed, May 02, 2018 at 03:53:47AM +0000, Daniel Colascione wrote:
> > Suppose we make a userspace mutex implemented with a lock word having
three
> > bits: acquired, sleep_mode, and wait_pending, with the rest of the word
not
> > being relevant at the moment.

> So ideally we'd kill FUTEX_WAIT/FUTEX_WAKE for mutexes entirely, and go
> with FUTEX_LOCK/FUTEX_UNLOCK that have the same semantics as the
> existing FUTEX_LOCK_PI/FUTEX_UNLOCK_PI, namely, the word contains the
> owner TID.

That doesn't work if you want to use the rest of the word for something
else, like a recursion count. With FUTEX_WAIT and FUTEX_WAKE, you can make
a lock with two bits.

> As brought up in the last time we talked about spin loops, why do we
> care if the spin loop is in userspace or not? Aside from the whole PTI
> thing, the syscall cost was around 150 cycle or so, while a LOCK CMPXCHG
> is around 20 cycles. So ~7 spins gets you the cost of entry.

That's pre-KPTI, isn't it?
