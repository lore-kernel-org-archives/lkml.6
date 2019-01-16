Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F376C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590AB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Inc4/WPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfAPU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:59:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35726 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfAPU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:59:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so8607225wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDEx8TNch+LJ5foQu6Yv32rFHNNxnxHO68LnOI+cDNo=;
        b=Inc4/WPoTTBL7b2xSVme8hY2bf3bhDanLNRvju6J8Ut6EHhsamk285rYMtDOjBIVF7
         g773Tp8GrvtEisVxUMUKV2SSeNnjdnDHeu9sPE/72aV227p/vnhZFxUm0Kg0MVsTVoBE
         gGTbmYM4nEheBpZXgh1VtshZl5Itzp4+fP03riXgsPExNKXrO6ZzHvMEZWalG9dE+8DF
         g5cP8D5Xscfj7hHn+qvRZzCEdO2RuqDKPFvGG/1PTn8JCaKsDqrZoBxcojNciyC+wid1
         m4ccQ+K/aOeNZ7tKwIYaqLUlkKSzNKQYPTm8kgJVn+iHBpexWnX36E/3Lg0KqQGKP7F3
         PI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDEx8TNch+LJ5foQu6Yv32rFHNNxnxHO68LnOI+cDNo=;
        b=njXT9NZAdXb6ShBGC3dhK1Im+t8ZL/m5sKLZNYf5omccOD9sUgfyYmOjFqymcsjKzv
         SbJwEArAWTQlLt5Jm6b19TVwYwlkb1LoPlssqNaABtXC+cLx9sH/Mdxe2jttDE6Sr0ZI
         v6i5Suww5SnB+iCrY/BTcZ0ibDvH+Zmmm0UgT8AeltOnmOmR7gKXn/AGz6z4vwEznwJ8
         rzih7INnaTE3LapiisuR2f20/sp8eh8ZxYlAaO5DlCYHAm+u0MIIyCdY6bg2691yB59N
         xxgheNxmNsZLMmlPXVsLXI5xCwOUiR2eL3TIPGYTfDJluf56qq6Qu85vTqzGs+Uv/lCH
         hthQ==
X-Gm-Message-State: AJcUukcqrEozv8xX4om4UA7Y6UAOk1jNk7srn8WX7hUeGdPIf20yWTQQ
        IDWCevcIT2n2g3CXAKbYgnYdGJsAuLNf56me2/JSqw==
X-Google-Smtp-Source: ALg8bN4CmR0TeyY4WXwy3IXpftQ0PfFk8jul5cqJgsSoby9ZHOpINNU7RgEyT7OD7GOklbZasYr5P+52TNPJVER6Bjk=
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr9332499wrj.107.1547672394612;
 Wed, 16 Jan 2019 12:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20190116193501.1910-1-hannes@cmpxchg.org>
In-Reply-To: <20190116193501.1910-1-hannes@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 16 Jan 2019 12:59:43 -0800
Message-ID: <CAJuCfpHA4Qfu=vFJg-bNSJtvrng3Swe4YJo9J31bHx9Bmm+kuQ@mail.gmail.com>
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,
Thanks for fixing this. I'll test this approach and report back the
results within a day or two.

On Wed, Jan 16, 2019 at 11:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> psi has provisions to shut off the periodic aggregation worker when
> there is a period of no task activity - and thus no data that needs
> aggregating. However, while developing psi monitoring, Suren noticed
> that the aggregation clock currently won't stay shut off for good.
>
> Debugging this revealed a flaw in the idle design: an aggregation run
> will see no task activity and decide to go to sleep; shortly
> thereafter, the kworker thread that executed the aggregation will go
> idle and cause a scheduling change, during which the psi callback will
> kick the !pending worker again. This will ping-pong forever, and is
> equivalent to having no shut-off logic at all (but with more code!)
>
> Fix this by exempting aggregation workers from psi's clock waking
> logic when the state change is them going to sleep. To do this, tag

The above sentence seems to be misspelled somehow.

> workers with the last work function they executed, and if in psi we
> see a worker going to sleep after aggregating psi data, we will not
> reschedule the aggregation work item.
>
> What if the worker is also executing other items before or after?
>
> Any psi state times that were incurred by work items preceding the
> aggregation work will have been collected from the per-cpu buckets
> during the aggregation itself. If there are work items following the
> aggregation work, the worker's last_func tag will be overwritten and
> the aggregator will be kept alive to process this genuine new activity.
>
> If the aggregation work is the last thing the worker does, and we
> decide to go idle, the brief period of non-idle time incurred between
> the aggregation run and the kworker's dequeue will be stranded in the
> per-cpu buckets until the clock is woken by later activity. But that
> should not be a problem. The buckets can hold 4s worth of time, and
> future activity will wake the clock with a 2s delay, giving us 2s
> worth of data we can leave behind when disabling aggregation. If it
> takes a worker more than two seconds to go idle after it finishes its
> last work item, we likely have bigger problems in the system, and
> won't notice one sample that was averaged with a bogus per-CPU weight.
>
> Fixes: eb414681d5a0 ("psi: pressure stall information for CPU, memory, and IO")
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/psi.c          | 21 +++++++++++++++++----
>  kernel/workqueue.c          | 23 +++++++++++++++++++++++
>  kernel/workqueue_internal.h |  6 +++++-
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> Sending this for 5.0. I don't think CC stable is warranted on this.
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index fe24de3fbc93..c3484785b179 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -124,6 +124,7 @@
>   * sampling of the aggregate task states would be.
>   */
>
> +#include "../workqueue_internal.h"
>  #include <linux/sched/loadavg.h>
>  #include <linux/seq_file.h>
>  #include <linux/proc_fs.h>
> @@ -480,9 +481,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
>                         groupc->tasks[t]++;
>
>         write_seqcount_end(&groupc->seq);
> -
> -       if (!delayed_work_pending(&group->clock_work))
> -               schedule_delayed_work(&group->clock_work, PSI_FREQ);
>  }
>
>  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> @@ -513,6 +511,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  {
>         int cpu = task_cpu(task);
>         struct psi_group *group;
> +       bool wake_clock = true;
>         void *iter = NULL;
>
>         if (!task->pid)
> @@ -530,8 +529,22 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>         task->psi_flags &= ~clear;
>         task->psi_flags |= set;
>
> -       while ((group = iterate_groups(task, &iter)))
> +       /*
> +        * Periodic aggregation shuts off if there is a period of no
> +        * task changes, so we wake it back up if necessary. However,
> +        * don't do this if the task change is the aggregation worker
> +        * itself going to sleep, or we'll ping-pong forever.
> +        */
> +       if (unlikely((clear & TSK_RUNNING) &&
> +                    (task->flags & PF_WQ_WORKER) &&
> +                    wq_worker_last_func(task) == psi_update_work))
> +               wake_clock = false;
> +
> +       while ((group = iterate_groups(task, &iter))) {
>                 psi_group_change(group, cpu, clear, set);
> +               if (wake_clock && !delayed_work_pending(&group->clock_work))
> +                       schedule_delayed_work(&group->clock_work, PSI_FREQ);
> +       }
>  }
>
>  void psi_memstall_tick(struct task_struct *task, int cpu)
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 392be4b252f6..fc5d23d752a5 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -909,6 +909,26 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
>         return to_wakeup ? to_wakeup->task : NULL;
>  }
>
> +/**
> + * wq_worker_last_func - retrieve worker's last work function
> + *
> + * Determine the last function a worker executed. This is called from
> + * the scheduler to get a worker's last known identity.
> + *
> + * CONTEXT:
> + * spin_lock_irq(rq->lock)
> + *
> + * Return:
> + * The last work function %current executed as a worker, NULL if it
> + * hasn't executed any work yet.
> + */
> +work_func_t wq_worker_last_func(struct task_struct *task)
> +{
> +       struct worker *worker = kthread_data(task);
> +
> +       return worker->last_func;
> +}
> +
>  /**
>   * worker_set_flags - set worker flags and adjust nr_running accordingly
>   * @worker: self
> @@ -2184,6 +2204,9 @@ __acquires(&pool->lock)
>         if (unlikely(cpu_intensive))
>                 worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
>
> +       /* tag the worker for identification in schedule() */
> +       worker->last_func = worker->current_func;
> +
>         /* we're done with it, release */
>         hash_del(&worker->hentry);
>         worker->current_work = NULL;
> diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
> index 66fbb5a9e633..cb68b03ca89a 100644
> --- a/kernel/workqueue_internal.h
> +++ b/kernel/workqueue_internal.h
> @@ -53,6 +53,9 @@ struct worker {
>
>         /* used only by rescuers to point to the target workqueue */
>         struct workqueue_struct *rescue_wq;     /* I: the workqueue to rescue */
> +
> +       /* used by the scheduler to determine a worker's last known identity */
> +       work_func_t             last_func;
>  };
>
>  /**
> @@ -67,9 +70,10 @@ static inline struct worker *current_wq_worker(void)
>
>  /*
>   * Scheduler hooks for concurrency managed workqueue.  Only to be used from
> - * sched/core.c and workqueue.c.
> + * sched/ and workqueue.c.
>   */
>  void wq_worker_waking_up(struct task_struct *task, int cpu);
>  struct task_struct *wq_worker_sleeping(struct task_struct *task);
> +work_func_t wq_worker_last_func(struct task_struct *task);
>
>  #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
> --
> 2.20.1
>
