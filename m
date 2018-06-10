Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KO4vHodiHVtbOgAAmS7hNA
	; Sun, 10 Jun 2018 17:40:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C6877607A4; Sun, 10 Jun 2018 17:40:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjyWmilk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2E5A9606FA;
	Sun, 10 Jun 2018 17:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E5A9606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932194AbeFJRkd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 13:40:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45127 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbeFJRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 13:40:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so17985467wrm.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sieg/I7LAGGKZUQMKPDEaWE+6n2bxxMDcM7JGVtpWyY=;
        b=gjyWmilkOuWuG5Y5710dsTdSBQuJOKW1qP9t/lkBJ0bYwcvu4Fcl4SADQzF0z0yb94
         lsiTf/1P9VY/xyAdj16vGUY9g7Ji1zDWnDg3pBXUEj16ekwZVW/p7EqHF3dNYcIQeKeO
         RjZqkIiAkRHBMTEEH/gNv1JQt5ghywfFB2BRxM2L9GnOdZP2fYOFas0vWO4BBZet7np5
         WzSU1l+BKSqpa3Fskzbn2FL1dZeQAtMIDJGtGIFIBHLMKWeyHMFqN2NAlAA7Ft4QnKAd
         6HCVfyKemtzAW0xZGe52srjz+ol+jyC1j8fU79Afc30Ttk4nXZe2UN97a46D0zEuD08f
         eydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sieg/I7LAGGKZUQMKPDEaWE+6n2bxxMDcM7JGVtpWyY=;
        b=rlBFeWBDjkIh6h13hn4EWqIlviLHq/tDEvPJOAqbEuteXI60PsoaCOWsF7f5mST0/+
         +QqJg4TxzxVaBNJOJnQhDDdsJh2pytZsgMJFsGmKWaeYJ95i6OcScrfwAQc8GxQAhQuJ
         EpAq1BszpFA+963COsZSOAnvU9kUrNaqDmp614z8xijHQlv5KKqrmkpSsgRDYTo3u18i
         SijOYa8BydxATfvhT0ybqfFnT4RTd55nOS+N1tK+Vt9+WPfaSXZVlBlCpEAEC0vzfGxE
         vco6uCOAkZ9RzlkwX+PfNNo+a19kf9ATR3xIgpHVo00xpBIIwpj+DUUtglnjgRCUe3EC
         CjeQ==
X-Gm-Message-State: APt69E2sD1DrdoPyNXOkrH3TBP2iWmvC8pb0VPicDePkWhON8M6yz8zu
        uj8l5W1OTksZQrgE/vA7AFWWKK32azO4moPEhQRvJA==
X-Google-Smtp-Source: ADUXVKK/ylPusrOBs+G1y53AycuQQRXajgEMKoGHfWVmzlCbpPLMyF5Lphsiw3/ZULGzB5ZDunZzKVh9lX3rfXadLDY=
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr10947284wrd.272.1528652429606;
 Sun, 10 Jun 2018 10:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180530001204.183758-1-shakeelb@google.com> <20180609102027.5vkqucnzvh6nfdxu@esperanza>
 <CALvZod7OrDrq571An-GHeWFNvARWsS+fvX1-G9=nYzxgq2N3UQ@mail.gmail.com> <20180610163420.GK3593@linux.vnet.ibm.com>
In-Reply-To: <20180610163420.GK3593@linux.vnet.ibm.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 10 Jun 2018 10:40:17 -0700
Message-ID: <CALvZod5HiwJPkD-_KnV+m=gWYgkb8rZceKoUkBK1KPW8iOzYug@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between kmem_cache destroy, create and deactivate
To: paulmck@linux.vnet.ibm.com
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 9:32 AM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> On Sun, Jun 10, 2018 at 07:52:50AM -0700, Shakeel Butt wrote:
> > On Sat, Jun 9, 2018 at 3:20 AM Vladimir Davydov <vdavydov.dev@gmail.com> wrote:
> > >
> > > On Tue, May 29, 2018 at 05:12:04PM -0700, Shakeel Butt wrote:
> > > > The memcg kmem cache creation and deactivation (SLUB only) is
> > > > asynchronous. If a root kmem cache is destroyed whose memcg cache is in
> > > > the process of creation or deactivation, the kernel may crash.
> > > >
> > > > Example of one such crash:
> > > >       general protection fault: 0000 [#1] SMP PTI
> > > >       CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
> > > >       ...
> > > >       Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
> > > >       RIP: 0010:has_cpu_slab
> > > >       ...
> > > >       Call Trace:
> > > >       ? on_each_cpu_cond
> > > >       __kmem_cache_shrink
> > > >       kmemcg_cache_deact_after_rcu
> > > >       kmemcg_deactivate_workfn
> > > >       process_one_work
> > > >       worker_thread
> > > >       kthread
> > > >       ret_from_fork+0x35/0x40
> > > >
> > > > To fix this race, on root kmem cache destruction, mark the cache as
> > > > dying and flush the workqueue used for memcg kmem cache creation and
> > > > deactivation.
> > >
> > > > @@ -845,6 +862,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > > >       if (unlikely(!s))
> > > >               return;
> > > >
> > > > +     flush_memcg_workqueue(s);
> > > > +
> > >
> > > This should definitely help against async memcg_kmem_cache_create(),
> > > but I'm afraid it doesn't eliminate the race with async destruction,
> > > unfortunately, because the latter uses call_rcu_sched():
> > >
> > >   memcg_deactivate_kmem_caches
> > >    __kmem_cache_deactivate
> > >     slab_deactivate_memcg_cache_rcu_sched
> > >      call_rcu_sched
> > >                                             kmem_cache_destroy
> > >                                              shutdown_memcg_caches
> > >                                               shutdown_cache
> > >       memcg_deactivate_rcufn
> > >        <dereference destroyed cache>
> > >
> > > Can we somehow flush those pending rcu requests?
> >
> > You are right and thanks for catching that. Now I am wondering if
> > synchronize_sched() just before flush_workqueue() should be enough.
> > Otherwise we might have to replace call_sched_rcu with
> > synchronize_sched() in kmemcg_deactivate_workfn which I would not
> > prefer as that would holdup the kmem_cache workqueue.
> >
> > +Paul
> >
> > Paul, we have a situation something similar to the following pseudo code.
> >
> > CPU0:
> > lock(l)
> > if (!flag)
> >   call_rcu_sched(callback);
> > unlock(l)
> > ------
> > CPU1:
> > lock(l)
> > flag = true
> > unlock(l)
> > synchronize_sched()
> > ------
> >
> > If CPU0 has called already called call_rchu_sched(callback) then later
> > if CPU1 calls synchronize_sched(). Is there any guarantee that on
> > return from synchronize_sched(), the rcu callback scheduled by CPU0
> > has already been executed?
>
> No.  There is no such guarantee.
>
> You instead want rcu_barrier_sched(), which waits for the callbacks from
> all prior invocations of call_rcu_sched() to be invoked.
>
> Please note that synchronize_sched() is -not- sufficient.  It is only
> guaranteed to wait for a grace period, not necessarily for all prior
> callbacks.  This goes both directions because if there are no callbacks
> in the system, then rcu_barrier_sched() is within its rights to return
> immediately.
>
> So please make sure you use each of synchronize_sched() and
> rcu_barrier_sched() to do the job that it was intended to do!  ;-)
>
> If your lock(l) is shorthand for spin_lock(&l), it looks to me like you
> actually only need rcu_barrier_sched():
>
>         CPU0:
>         spin_lock(&l);
>         if (!flag)
>           call_rcu_sched(callback);
>         spin_unlock(&l);
>
>         CPU1:
>         spin_lock(&l);
>         flag = true;
>         spin_unlock(&l);
>         /* At this point, no more callbacks will be registered. */
>         rcu_barrier_sched();
>         /* At this point, all registered callbacks will have been invoked. */
>
> On the other hand, if your "lock(l)" was instead shorthand for
> rcu_read_lock_sched(), then you need -both- synchronize_sched() -and-
> rcu_barrier().  And even then, you will be broken in -rt kernels.
> (Which might or might not be a concern, depending on whether your code
> matters to -rt kernels.
>
> Make sense?
>

Thanks a lot, that was really helpful. The lock is actually
mutex_lock. So, I think rcu_barrier_sched() should be sufficient.

Shakeel
