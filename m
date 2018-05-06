Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3085648-1525601039-2-17680547599888870174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525601039; b=mUEA+wRi0F6u1PL2jL3qFf9v+MbIOYXmncqiLZJ9xUEsPrav3t
    2GulXT4V/auhnrF96xU9aZyOrQM8mKxIzBo91Trpg+RkAf9ORRGE6WeAt8I7JcP1
    NGr+gF/qduWutNtt6WJs5KU+fAOM4pw9een455kX80Q3EyTnQMfhqctzA/rBIuw/
    q9bEYwJ1OMapZmJpGdHp39jyUNfoMQGQKW/J9Kqs3dOhaqvz7ftS8PG6wwJG9uaZ
    IihblQTgV4k+PUnwz1cdLYCMhtUKKbGNmfg77dVx6BZP8NO9jMWSbj0S64ZfmWnX
    b1BIfnBijIaYuY1p1VREyU90oxFLmXginfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525601039; bh=/ep37HPKXkEvMPwPp1lRctTx5BXFX4FvKjL0aVo
    q3H8=; b=iWA3Djj2MghobhMCovzDOH8yhF6xqMJkfoVu9v7bbkO3GYROluQBCQl
    U1kM1+d9i8yD7D4JAljX+WVmhXbsgD1HPETRPLCkc0qADQczwm8Q9Bp2LaqnmDQz
    Pzzel/nJvSPSF7wTnudCoTrdGZOKXeJOO/nOfX6ckGo1cTqZktj/fMaFaO2dD8td
    PEWgyfsrED2xHSTY9O0oNSFi0BlHermaDuK5R/TTwX3770ShLUWytG2eoL+2Nnkx
    YE0tbDDaid4uAHYCA3M7l1xqLdg20QBiag9n4VrKl4wXCW2kpMHPx/5RNZK5gcg3
    tapWQFDLrEsgbO4MI/S6IdtxhX26L1Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD86qDcV4UM1WszHZyhTNcg88UlMlZt074Ky1t+q8zQhxMSAqNWH8WHxGAARF2S405nM9RmE8TE/FJvG0+ZgMhaE5Q3G4mewmoM0qKtLy81r2nzCcl+n
    IH6fUzh+BAaQcisFCACAon67G/QdY3OgJ1bedaepx+rcxsS+ATV6cuCRKOWs0pI8cycOfIvLVqLmAMCOBhJAMTc+GglNZhRYHiPPkRFFWsYKjH1poivEO66g
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=NIdzBBMyTS-0PfTVrOMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeEFKDz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 06:03:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeEFKDy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 06:03:54 -0400
Date: Sun, 6 May 2018 12:03:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Daniel Colascione <dancol@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, mingo@redhat.com, hpa@zytor.com,
        Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, rostedt@goodmis.org,
        josh@joshtriplett.org, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
In-Reply-To: <20180502202233.GV12217@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1805061202550.1685@nanos.tec.linutronix.de>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com> <20180502172218.GL12180@hirez.programming.kicks-ass.net> <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
 <20180502202233.GV12217@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2 May 2018, Peter Zijlstra wrote:

> On Wed, May 02, 2018 at 06:27:22PM +0000, Daniel Colascione wrote:
> > On Wed, May 2, 2018 at 10:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >> On Wed, May 02, 2018 at 03:53:47AM +0000, Daniel Colascione wrote:
> > > > Suppose we make a userspace mutex implemented with a lock word having
> > three
> > > > bits: acquired, sleep_mode, and wait_pending, with the rest of the word
> > not
> > > > being relevant at the moment.
> > 
> > > So ideally we'd kill FUTEX_WAIT/FUTEX_WAKE for mutexes entirely, and go
> > > with FUTEX_LOCK/FUTEX_UNLOCK that have the same semantics as the
> > > existing FUTEX_LOCK_PI/FUTEX_UNLOCK_PI, namely, the word contains the
> > > owner TID.
> > 
> > That doesn't work if you want to use the rest of the word for something
> > else, like a recursion count. With FUTEX_WAIT and FUTEX_WAKE, you can make
> > a lock with two bits.
> 
> Recursive locks are teh most horrible crap ever. And having the tid in
> the word allows things like kernel based optimistic spins and possibly
> PI related things.

FWIW, robust futex have also the TID requirement.

Thanks,

	tglx
