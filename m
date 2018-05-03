Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1656041-1525310145-2-12741427173101133888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525310144; b=fLa/iBLpoGVt7ASAnzI7f47ugFbHLqjfRtF2u6ZJyE9jedczyQ
    oGXBWPKaexMQFZoFvPj/9kiY2DLhJNh1QFO4LKOIqeoQewHSBRozQr4Ffm9htXkk
    h7VZPUIIiTLix39krygL9J+UnZiA18WGiwP6t6Ie4s+VpBCaX+kM43Q21yrSXBZx
    r0xKUp2UHOyQABZLeKjMBw0jovYX6GLgf/nGptYIwVuqBeFq5yKANZoJwdIA2cXn
    keCrQcyQpeawxYOrYqhzHEaqhNrRaLhdU5vzdF/GZlphAK/bTz1I7Vr+LasTg76g
    2Cbhy3T9g+lnHi03DhOKMDN4NxQ8AkdPWvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525310144;
    bh=FWw1tZhrqiFe9Ei7F4TPaBy26szY5P6wFOlJAw1bG40=; b=Y5/xJ8f64K8N
    moNTghlG8DzsjAfwUjnha3LWD3KbpF3aslH42cn/WX9jKKg5GXSADcmkrasD1KYx
    V8MCdW+0FFUVZorFVOiDWfnEWmo1WzaU5ERGzAVhQGLQ7xAT3UKE3FkLCm/nt64Y
    EPL3cYcuU4CCQNIZPqbm+3m3LYMDl+HmDqVesF2k7hdlDCnK6WSzQ0ip5Tck7u3J
    VCgMiAety0auORiyLor3wH+7Yc4XcLAl8EIGKNlw6u6gQZsSXS+fdgTe9srrFHlN
    xx5WQzwyrB4+qMNwLlY5UDNqi+Xdff3EnBzMQxdoBoDLK2Fb6ucLC5k0U+d6ItLM
    UZ3RE3UAcA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHdsXG8J8Zu2SZFbJBODPQAT32tiPOZenmV+kHxTF+wDsxOShBxEe2OiQhkLjJcShLkXe+uebjKCHJDUS1oHSQfL1s41LzIL3rjbnZRY53g2uN06gY0g
    pcgHltrV43kDqQD4arK8E11J/rDgMKIAVVtGLwmpraWPtJ19Wj+QKaP3XIeVDlNEdCo4LKhrOYkSVPahLqoV+z+OKj0bP3m+yKcCaGn1yg8UMeJdfvOZhP7e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=9XQvd26-PR8NOnvoxPsA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeECBPl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 21:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbeECBPk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 May 2018 21:15:40 -0400
Date: Wed, 2 May 2018 21:15:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Colascione <dancol@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        Joel Fernandes <joelaf@google.com>,
        Robert Haas <robertmhaas@gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
Message-ID: <20180502211536.44b560c7@vmware.local.home>
In-Reply-To: <CAKOZuevUq-XsT632VHU1TQQ5_rGqNROXiZAqv7S+ky=-wcQ3bQ@mail.gmail.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
        <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
        <20180502172218.GL12180@hirez.programming.kicks-ass.net>
        <CAKOZuesjF8QxfphgsyRKctO89jR9VAM727dspTe7PX1z8KFpyw@mail.gmail.com>
        <20180502202233.GV12217@hirez.programming.kicks-ass.net>
        <CAKOZuevUq-XsT632VHU1TQQ5_rGqNROXiZAqv7S+ky=-wcQ3bQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 02 May 2018 20:37:13 +0000
Daniel Colascione <dancol@google.com> wrote:

> On Wed, May 2, 2018 at 1:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, May 02, 2018 at 06:27:22PM +0000, Daniel Colascione wrote:  
> > > On Wed, May 2, 2018 at 10:22 AM Peter Zijlstra <peterz@infradead.org>  
> wrote:
> > > >> On Wed, May 02, 2018 at 03:53:47AM +0000, Daniel Colascione wrote:
> > > > > Suppose we make a userspace mutex implemented with a lock word  
> having
> > > three  
> > > > > bits: acquired, sleep_mode, and wait_pending, with the rest of the  
> word
> > > not  
> > > > > being relevant at the moment.  
> > >  
> > > > So ideally we'd kill FUTEX_WAIT/FUTEX_WAKE for mutexes entirely, and  
> go
> > > > with FUTEX_LOCK/FUTEX_UNLOCK that have the same semantics as the
> > > > existing FUTEX_LOCK_PI/FUTEX_UNLOCK_PI, namely, the word contains the
> > > > owner TID.  
> > >
> > > That doesn't work if you want to use the rest of the word for something
> > > else, like a recursion count. With FUTEX_WAIT and FUTEX_WAKE, you can  
> make
> > > a lock with two bits.  
> 
> > Recursive locks are teh most horrible crap ever. And having the tid in  
> 
> What happened to providing mechanism, not policy?
> 
> You can't wish away recursive locking. It's baked into Java and the CLR,
> and it's enshrined in POSIX. It's not going away, and there's no reason not
> to support it efficiently.
> 
> > the word allows things like kernel based optimistic spins and possibly
> > PI related things.  
> 
> Sure. A lot of people don't want PI though, or at least they want to opt
> into it. And we shouldn't require an entry into the kernel for what we can
> in principle do efficiently in userspace.
> 
> > > > As brought up in the last time we talked about spin loops, why do we
> > > > care if the spin loop is in userspace or not? Aside from the whole PTI
> > > > thing, the syscall cost was around 150 cycle or so, while a LOCK  
> CMPXCHG
> > > > is around 20 cycles. So ~7 spins gets you the cost of entry. 

What about exit?
 
> > >
> > > That's pre-KPTI, isn't it?  
> 
> > Yes, and once the hardware gets sorted, we'll be there again. I don't
> > think we should design interfaces for 'broken' hardware.  
> 
> It would be a mistake to design interfaces under the assumption that
> everyone has fast permission level transitions.

Note, Robert Haas told me a few years ago at a plumbers conference that
postgresql implements their own user space spin locks because anything
that goes into the kernel has killed the performance. And they tried to
use futex but that still didn't beat out plain userspace locks.

-- Steve
