Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 58ddFVU7HVuAawAAmS7hNA
	; Sun, 10 Jun 2018 14:53:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3673560795; Sun, 10 Jun 2018 14:53:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czCqUysK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A374B601C3;
	Sun, 10 Jun 2018 14:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A374B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeFJOxG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:53:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35323 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeFJOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:53:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so11822255wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oC2cacfKI/jQ1T1rWZ5MzJlK2AopP4vAVEDjBOXQ+xE=;
        b=czCqUysKIuhwZAfc9PEuKNdFMQ+uaCkdJBGKkkKIK7utpbtj6on78rjDc6clDIr0hj
         gITnMxKI0PBUVjaPIaodVQHjw6m+t99D0XR/nD8DvURlYH7Q+906s1L5vxzoNWIqBlmg
         CgEQSzDipM9i81gzgkNIvh1IIXdIFe5sbvKHtl0s626/lHEcZwiW8INVPTMIVEVauA3B
         AHYhPhKe4tJ3r5/UAuPE3CLe1RGnRS8p2FCBFskGj+IVZeMQw2VXlZOxpJDD/gmkrPq7
         cJWK+m43XnvGm135W7y3U80bUqX/GVHURpcIBtUHP9UwemRjEC6ewXq+TmnrK9VHHwFQ
         vojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oC2cacfKI/jQ1T1rWZ5MzJlK2AopP4vAVEDjBOXQ+xE=;
        b=IVmTc0IN4S0IvvRx6LZI+9rIb56gWPdgLzBzxMvURAIwOQlp47pmt5jc9+dAiasHQa
         J8ID2ifKEe0i9yL5MFtj0PC/q2Om91rmVmweSU2f79ETbjk62vbCk89M0faCQNzEiZFw
         m7W5OmnSVQGFKRwwUuyqTJCLmTGlru0mGb9yzMo4Ryt6lDIn2O/8zTPKhjlBJ14xOsNE
         ox6a1ZWbXGXMvz+34JOeNHLteoAcfxSESbZKZyzYVqLv1Cxdv7kNPCpfd0YLZ0opQB/w
         eFR+VYqAyLEbWMPyQkb6wCQN/44FdYfBQBUyvM0PxqXD2e74u7pChqWdfe8GpDA/OVJz
         Rg4g==
X-Gm-Message-State: APt69E1Z2wkrNrEjFqfS7XJYNiOGMsGBC52mzkpzZhPv73nSJPOKF/mP
        lSd59y5qF0ADG4z0Ms+fECotP4vuYg+OOtpgD5DyTg==
X-Google-Smtp-Source: ADUXVKJALL4D+JNGndobPMZFI3dz5+p5a9Dr8wm2bwFp+N37G5zB/FSuUjjHSfG+6Rm1T6rOiZo7EYAWD4btk1EJwcw=
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr6507615wmf.112.1528642382659;
 Sun, 10 Jun 2018 07:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180530001204.183758-1-shakeelb@google.com> <20180609102027.5vkqucnzvh6nfdxu@esperanza>
In-Reply-To: <20180609102027.5vkqucnzvh6nfdxu@esperanza>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 10 Jun 2018 07:52:50 -0700
Message-ID: <CALvZod7OrDrq571An-GHeWFNvARWsS+fvX1-G9=nYzxgq2N3UQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between kmem_cache destroy, create and deactivate
To: Vladimir Davydov <vdavydov.dev@gmail.com>,
        paulmck@linux.vnet.ibm.com
Cc: Michal Hocko <mhocko@kernel.org>, Christoph Lameter <cl@linux.com>,
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

On Sat, Jun 9, 2018 at 3:20 AM Vladimir Davydov <vdavydov.dev@gmail.com> wrote:
>
> On Tue, May 29, 2018 at 05:12:04PM -0700, Shakeel Butt wrote:
> > The memcg kmem cache creation and deactivation (SLUB only) is
> > asynchronous. If a root kmem cache is destroyed whose memcg cache is in
> > the process of creation or deactivation, the kernel may crash.
> >
> > Example of one such crash:
> >       general protection fault: 0000 [#1] SMP PTI
> >       CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
> >       ...
> >       Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
> >       RIP: 0010:has_cpu_slab
> >       ...
> >       Call Trace:
> >       ? on_each_cpu_cond
> >       __kmem_cache_shrink
> >       kmemcg_cache_deact_after_rcu
> >       kmemcg_deactivate_workfn
> >       process_one_work
> >       worker_thread
> >       kthread
> >       ret_from_fork+0x35/0x40
> >
> > To fix this race, on root kmem cache destruction, mark the cache as
> > dying and flush the workqueue used for memcg kmem cache creation and
> > deactivation.
>
> > @@ -845,6 +862,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       if (unlikely(!s))
> >               return;
> >
> > +     flush_memcg_workqueue(s);
> > +
>
> This should definitely help against async memcg_kmem_cache_create(),
> but I'm afraid it doesn't eliminate the race with async destruction,
> unfortunately, because the latter uses call_rcu_sched():
>
>   memcg_deactivate_kmem_caches
>    __kmem_cache_deactivate
>     slab_deactivate_memcg_cache_rcu_sched
>      call_rcu_sched
>                                             kmem_cache_destroy
>                                              shutdown_memcg_caches
>                                               shutdown_cache
>       memcg_deactivate_rcufn
>        <dereference destroyed cache>
>
> Can we somehow flush those pending rcu requests?

You are right and thanks for catching that. Now I am wondering if
synchronize_sched() just before flush_workqueue() should be enough.
Otherwise we might have to replace call_sched_rcu with
synchronize_sched() in kmemcg_deactivate_workfn which I would not
prefer as that would holdup the kmem_cache workqueue.

+Paul

Paul, we have a situation something similar to the following pseudo code.

CPU0:
lock(l)
if (!flag)
  call_rcu_sched(callback);
unlock(l)
------
CPU1:
lock(l)
flag = true
unlock(l)
synchronize_sched()
------

If CPU0 has called already called call_rchu_sched(callback) then later
if CPU1 calls synchronize_sched(). Is there any guarantee that on
return from synchronize_sched(), the rcu callback scheduled by CPU0
has already been executed?

thanks,
Shakeel
