Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0C42175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbD8wJ9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfA1WqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:46:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33875 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1Wp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:45:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so14584705oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RM044dE9hBEzHSiouuipjyFT4Scxv3Vo3M1SK0ouvB0=;
        b=RbD8wJ9WL7W493DRqBL5ddDDCCj9ccp1SW35keqVE70OonSCwK4JnK9vJdmcDzKzn2
         +Vwv/dLhexJzdjA5WE98uN+mik0u9F74m88A1nqYOY7LmzffLNmAEAX+IfwtL1zb2cY4
         8xVolcilysuY49ReNhFKo1f7le48OjkJmf/NTdaidHDOOkTtL23xDBeNSeaMrsaVaWqo
         CiQ2v+640biorvex6vLPN5UYotIovLfKPiuB0XH0yeMNOobcGtyjYhd7h2OAG6a4JK9V
         aADm109aUoW2sOgkqc8T4XdFqOc+67LTDsrohjUhpQlLVZ5DsWdRpEkbgO5NEnUU5aQT
         0Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RM044dE9hBEzHSiouuipjyFT4Scxv3Vo3M1SK0ouvB0=;
        b=KcQcIubDfEAmq13vGutr39VBzsQ0Ob4eV/J4AOxs64HvcPdhq8t1N/jcnf+Skq5sAW
         Opx+rsdeXWDPiMlV2/tZjuO1mzDJrNCaMiZYA5UolHcOGPr9mSOAcpkzpDctZB/vqO0W
         gNi4+/RinC0Esoms8QmKgadzUD6env5vEm6CxFAQxQ0HzgU1Nuz4EWoQvMHQ7K8HjWWp
         tm+r14udlfoRam290tmqJ7qdHNPYg0Wvl3fHv+COHOG6CnfmlJSFWi6Df90sSugoTW9F
         CUDYUP28fnojjZx4meCdl+ldFb7hS1XCA9SiE7raOPeYrPnSi9rjPTyyevMmjDO+JFbv
         Hu/w==
X-Gm-Message-State: AJcUukda53F1ALl9iAkby4q8YhFwsKBFZwrdfYsiiGxKE2azDn3WgTFX
        dfC3u3UvLuSqBKyPPE9rZBw3T+Sbe9Zv6SOv0tE0nA==
X-Google-Smtp-Source: ALg8bN52fmpC8tAHVPZFZLQCzKAEMsDWndNjm4cF9vHAnq830uylLrAULUDHPzhVxWv4emI9IHhlZKcy+C+CupsLFpk=
X-Received: by 2002:aca:3c06:: with SMTP id j6mr7331244oia.126.1548715558593;
 Mon, 28 Jan 2019 14:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20190128220707.30774-1-mathieu.desnoyers@efficios.com> <20190128223948.GD4240@linux.ibm.com>
In-Reply-To: <20190128223948.GD4240@linux.ibm.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Jan 2019 23:45:32 +0100
Message-ID: <CAG48ez1+Vx7=ZqeLJ0waceSneCQhEcoS=bv9ggb3Dbveb+W6AQ@mail.gmail.com>
Subject: Re: [PATCH] Fix: membarrier: racy access to p->mm in membarrier_global_expedited()
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:39 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> On Mon, Jan 28, 2019 at 05:07:07PM -0500, Mathieu Desnoyers wrote:
> > Jann Horn identified a racy access to p->mm in the global expedited
> > command of the membarrier system call.
> >
> > The suggested fix is to hold the task_lock() around the accesses to
> > p->mm and to the mm_struct membarrier_state field to guarantee the
> > existence of the mm_struct.
> >
> > Link: https://lore.kernel.org/lkml/CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
[...]
> > --- a/kernel/sched/membarrier.c
> > +++ b/kernel/sched/membarrier.c
> > @@ -81,12 +81,27 @@ static int membarrier_global_expedited(void)
> >
> >               rcu_read_lock();
> >               p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> > -             if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> > -                                MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> > -                     if (!fallback)
> > -                             __cpumask_set_cpu(cpu, tmpmask);
> > -                     else
> > -                             smp_call_function_single(cpu, ipi_mb, NULL, 1);
> > +             /*
> > +              * Skip this CPU if the runqueue's current task is NULL or if
> > +              * it is a kernel thread.
> > +              */
> > +             if (p && READ_ONCE(p->mm)) {
> > +                     bool mm_match;
> > +
> > +                     /*
> > +                      * Read p->mm and access membarrier_state while holding
> > +                      * the task lock to ensure existence of mm.
> > +                      */
> > +                     task_lock(p);
> > +                     mm_match = p->mm && (atomic_read(&p->mm->membarrier_state) &
>
> Are we guaranteed that this p->mm will be the same as the one loaded via
> READ_ONCE() above?

No; the way I read it, that's just an optimization and has no effect
on correctness.

> Either way, wouldn't it be better to READ_ONCE() it a
> single time and use the same value everywhere?

No; the first READ_ONCE() returns a pointer that you can't access
because it wasn't read under a lock. You can only use it for a NULL
check.
