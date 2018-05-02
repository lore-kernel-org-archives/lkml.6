Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-17291-1525233270-2-12491948461158503227
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
    1525233269; b=Uq2rKvIbVXR4K4mOTh/p0KrKLBu0gt05f3XJCEplg5+uh2emu2
    xJdfBoquapTq7aEGZ1E4Vp9VN5CEXOMn1QbKOrIjt04+Fu1PTRYJaXnHzgC36TTv
    F/aYdit6tj8qqRNabhh8BlxVsZgTzM6FKj+BXsq2p5UcQNOMXwC+ImjoX+ZIFGJh
    Zv75HR9mgf6LhTxUH9m7rbL4XEhwC8Mi7GiVTcvHSN0b5chi9IM91VGWVNmlWsPy
    DJfr73EQhGEgUswopCCrIOpJjirBGMUzjozzbBOcehtlLEuaKLYrNOIWhm7YcezU
    d4HVtmg3M+F1lS1fenHdZHNZN45iylWUNClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525233269; bh=1bU4VCABcTMMf9Ds9OhCqNPBrJbvePkPfbgfXKhFnb
    g=; b=GVOYEyNbOSPZkQw+dBO6k2RsQQ9X01N4ZzQMVbwhyj5zQ3wc5wvl/o4ZI0
    BRSxnW8pKwNrp/OE/TCuACGj8kkMkP2qBmXmzFNXZiCjjcuYMFNwUfQkEmnn+/4Y
    qHFQ0ehsq0AmgSkg6Uj6d1aFvhkWlRg2dy4PsYqVgglBhXkiIp6UxVCA+9y76sZB
    /K0IwjlFx89h5vNgUyXjQn2GjZ1JXSFMW/MaZmfo3M/BenTMhNdfni7hUIm2eIMn
    QgeMSXtpY950JWOBjN+oaaHlNW+02IrGrs6L7V/mLrjD4VfZW+F4Kx5QvKURszav
    f1j7oNW3NtqoYCrdSUzA4oLeb1RA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=KC/DXuuZ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ovVRgkx9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=KC/DXuuZ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ovVRgkx9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA6OZ6hHX3hVSBqrFCclXjfVgdQinFH10Z5fe3/jRB6kypl1Y574f3v8mhfPI1X+R7oYW022Qf/Z8bQywHAc3jrHGtC+TBhwJageQXErl2jnzzOL6Jpl
    sf6gx0xHEIim14A9JQrjToTpve9kQhFHqL28L7SNLRonoLosBRmzQSH2eXw4k+OyK802EUcy2w+Pt4MFsBd0SG4Be2Sq1c4XDLKv0BRms5bbdesSMQaAfkYH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=BRi-28aq6-tBcg6lgJ0A:9
    a=umyNAV90VNNyEExJ:21 a=EiA4tLEh5ArVI-2h:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeEBDyA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:54:00 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:51112 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBDyA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 May 2018 23:54:00 -0400
X-Google-Smtp-Source: AB8JxZqs4jhlCIa8WvR5Zb96qzjbQYlVxhA4G2Trgii94t8MvXohO6InZrFMJUkj7Lr6f1m9npIdG9SLiN2QEA+iqT0=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
From: Daniel Colascione <dancol@google.com>
Date: Wed, 02 May 2018 03:53:47 +0000
Message-ID: <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: mathieu.desnoyers@efficios.com
Cc: Peter Zijlstra <peterz@infradead.org>, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pjt@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, rostedt@goodmis.org,
        josh@joshtriplett.org, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        mtk.manpages@gmail.com, Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mathieu: this work looks very cool. See inline.

On Mon, Apr 30, 2018 at 3:48 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,

> Here is an updated RFC round of the Restartable Sequences patchset
> based on kernel 4.17-rc3. Based on feedback from Linus, I'm introducing
> only the rseq system call, keeping the rest for later.

> This already enables speeding up the Facebook jemalloc and arm64 PMC
> read from user-space use-cases, as well as speedup of use-cases relying
> on getting the current cpu number from user-space. We'll have to wait
> until a more complete solution is introduced before the LTTng-UST
> tracer can replace its ring buffer atomic instructions with rseq
> though. But let's proceed one step at a time.

I like the general theme of the kernel using its "superpowers" (in this
case, knowledge of preemption) to help userspace do a better job without
userspace code needing to enter the kernel to benefit. The per-CPU data
structures this patch enables help in a lot of use cases, but I think
there's another use case that you might not have considered, one that can
benefit from a extension to your proposed API.

Consider mutexes: in the kernel, for mutual exclusion, we can use a
spinlock, which in the kernel ends up being simpler and (in a lot of
scenarios) more efficient than a mutex: a core that takes a spinlock
promises to keep the lock held for only a very short time, and it disables
interrupts to delay asynchronous work that might unexpectedly lengthen the
critical section. A different core that wants to grab that spinlock can
just spin on the lock word, confident that its spin will be short because
any core owning the lock is guaranteed to release it very quickly. (Long
spins would be very bad for power.) The overall result is a lock that's
much lighter than a mutex. (A spinlock can also be used in places we can't
sleep, but this ability isn't relevant to the discussion below.)

Userspace doesn't have a good equivalent to a lightweight spinlock. While
you can build a spinlock in userspace, the result ends up having serious
problems because of preemption: first, a thread owning such a lock can be
preempted in its critical section, lengthening the critical section
arbitrarily. Second, a thread spinning on a lock will keep spinning even
when the owning thread isn't scheduled anywhere.

Userspace can just implement a mutex as a try-acquire and a FUTEX_WAIT on
failure. This approach works fine when there's no contention, but a system
call is a pretty heavy operation. Why pay for a system call on occasional
light congestion with a short critical section. Can we do better?

The usual approach to "better" is an "adaptive mutex". Such a thing, when
it attempts to acquire a lock another thread owns, spins for some number of
iterations, then falls back to futex. I guess that's a little better than
immediately jumping to futex, but it's not optimal. We can still spin when
the lock owner isn't scheduled, and the spin count is usually some guess
(either specified manually or estimated statistically) that's not
guaranteed to produce decent results. Even if we do pick a good spin count,
we run a very good chance of under- or over-spinning on any given
lock-acquire. We always want to sleep when spinning would be pointless.

One important case of the spin-while-not-scheduled problem is operation on
a uniprocessor system: on such a system, only a single task can be
scheduled at a time, making all spins maximally pointless. The usual
approach to avoiding wasted spins for adaptive mutexes is for the adaptive
mutex library to ask upon initialization "How many cores are in this
system?", and if the answer comes back as "1", disable spinning. This
approach is inadequate: CPU affinity can change at arbitrary times, and CPU
affinity can produce the same spin pessimization that a uniprocessor system
does.

I think a small enhancement to rseq would let us build a perfect userspace
mutex, one that spins on lock-acquire only when the lock owner is running
and that sleeps otherwise, freeing userspace from both specifying ad-hoc
spin counts and from trying to detect situations in which spinning is
generally pointless.

It'd work like this: in the per-thread rseq data structure, we'd include a
description of a futex operation for the kernel would perform (in the
context of the preempted thread) upon preemption, immediately before
schedule(). If the futex operation itself sleeps, that's no problem: we
will have still accomplished our goal of running some other thread instead
of the preempted thread.

Suppose we make a userspace mutex implemented with a lock word having three
bits: acquired, sleep_mode, and wait_pending, with the rest of the word not
being relevant at the moment.

We'd implement lock-acquire the usual way, CASing the acquired bit into the
lock and deeming the lock taken if we're successful. Except that before
attempting the CAS, we'd configure the current thread's rseq area to
bitwise-or the sleep_mode bit into the lock word if the current thread is
scheduled.

Now, imagine that we're a different thread that wants to take the lock
while the first thread owns it. We'll attempt a CAS as before. The CAS will
fail. That's fine --- we'll spin by retrying the CAS. Here's where we
differ from a conventional from a conventional adaptive mutex. A normal
adaptive mutex will execute a fixed maximum number of CAS attempts, then
FUTEX_WAIT. We, instead, keep spinning until we either grab the lock or we
notice the sleep_mode bit set in the lock word. (On every CAS attempt, we
update our local cached copy of the lock word.) When we do notice the
sleep_mode bit set, we'll fall back to the usual sleeping strategy: CAS the
wait_pending bit into the lock word and FUTEX_WAIT.

Back in the owning thread, when we release the model, we'll CAS again to
reset the acquired bit and (if set) sleep_mode bit, and if we see
wait_pending, FUTEX_WAKE any waiters. At this point, we can disable the
rseq registration. (If we're preempted after the unlock but before the rseq
disarm, we'll spuriously set sleep_mode, but that's fine, since we'll reset
it on next lock-acquire.)

This scheme gives us optimal spinning behavior. We spin on lock-acquire
only as long as the owning thread is actually running. We don't spin at all
on uniprocessor machines or in situations where we've set up affinity to
create the moral equivalent of a uniprocessor system. We correctly fall
back to sleeping when the owner itself schedules (which indicates that the
critical section is likely to last a while). And we don't need to choose
some arbitrary constant or use some estimation function to guess how many
times we want to spin. We can stop spinning as soon as we know it'll be
unproductive.

In practice, I think you'd want to impose a maximum spin count anyway to
guard against 1) unexpected non-scheduling critical section lengthening via
bugs, and 2) the possibility that the futex-on-schedule operation sleeps
before setting sleep_mode.

If you don't think the futex-on-schedule thing is a good idea, there are
other ways to accomplish the same basic task. For example, you could add an
is_running field to struct rseq, and the kernel would take of making this
field true only when the task owning the struct rseq is, in fact, running.

A sufficiently clever runtime system could stash the owning thread ID in
the lockword and provide a way to find a thread's struct rseq given its
thread ID. On lock contention, instead of switching to FUTEX_WAIT when we
notice sleep_mode set in the lock word, we'd switch to FUTEX_WAIT when we
notice is_running in the owning thread's struct rseq become false. This
approach is probably simpler, but makes each spin a bit heavier due to the
need to fetch two separate memory locations (the lockword and the
is_running field).

Anyway, I'm sure there are other variations on the general theme of the
rseq mechanism helping to optimize mutex acquisition. What do you think?
