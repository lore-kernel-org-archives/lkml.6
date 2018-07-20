Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3D20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCZMh4DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B3D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeGTVO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:14:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52799 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeGTVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:14:59 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so16317922itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9fiQ14pyPKFCh+xZv3hxVgCnMTCf/FXgIgeOi1m9vDQ=;
        b=MCZMh4DHb1qVfVwMnfntp5g8FIFe8391JfaMENwsc7Pr62T4Tr063h2cFbzvgxHgwN
         7IRK8Y49gAxypyjGBfdDVajyx+cMLs7ELO7zRFxiZzFMSunW2N/rUHbcmfsy6hM5OjBq
         C+iFBpP0xrK8oj84wzLJr+8txl+nhA2BlTV3pMIFGfS+huuQNQU+Lrk9pd/RmullMGDh
         DgBZutZggUXgafovMvJUJbM1lxD+QpU2Vwza7CoqIt9HLT71bCY3tgt4UJMDd8kWZ6p4
         zTEZSNcP77zGu/VqfEZpFdBey/6uotG1WVB4sMppb6rRm8QOsVcqVk1+R5EBX/9X3QyZ
         pLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9fiQ14pyPKFCh+xZv3hxVgCnMTCf/FXgIgeOi1m9vDQ=;
        b=J7FBOYbFvzK5+0s224H/TTVm2scwi27kNLA8lZKGQVgM0Y48PzY301RGhqwZ8abEUx
         ZEvuXA2+7/AzvTcDsu7f7ro/9siaPNckAEBjSSVrCTYfV+VJ9I1sbD9Fi6zKJxlnIlFW
         Beyautq3BQlYHn03ofhdkPIH+/YvZUYIxJfy0fq6E/NO5zWNWbmfEgji2RI80k7twStX
         EGlkOrkF8B6qCaO1BNr0shLETML3Uv19DU5TjCMLZHuxA1eYpKKXZbZVAczy3hGk/1gS
         AN49IFDg8oUa1z0ShwhwhqNWfQ8RmhxR7BiduPFrgjc61vE3JOaFhBgYyeXuk0m+9rvp
         qybA==
X-Gm-Message-State: AOUpUlGcEPyZ3Z5a7lSKgH2DiW77O1nT2do8/AzjlWCjNnwwp5y6GJA7
        zIOmDPK5pXVp7Z+hjBtmq2OAOCThrMZHqArk8/nqUA==
X-Google-Smtp-Source: AAOMgpf73Q1a0S/n3tdFARnKPa1ezA5i1i7IfTjN5AxosD7JgmUE5u4QK9e0MTpkngTSIrgGWOtBKt8rKWfrGquIBPE=
X-Received: by 2002:a02:6a2f:: with SMTP id l47-v6mr3201154jac.71.1532118305212;
 Fri, 20 Jul 2018 13:25:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 13:25:04
 -0700 (PDT)
In-Reply-To: <20180716082906.6061-4-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com> <20180716082906.6061-4-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jul 2018 13:25:04 -0700
Message-ID: <CAJuCfpGaKvxKcO=RLcmveHRB9qbMrvFs2yFVrk=k-v_m7JkxwQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] sched/core: uclamp: add CPU's clamp groups accounting
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Mon, Jul 16, 2018 at 1:28 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Utilization clamping allows to clamp the utilization of a CPU within a
> [util_min, util_max] range. This range depends on the set of currently
> RUNNABLE tasks on a CPU, where each task references two "clamp groups"
> defining the util_min and the util_max clamp values to be considered for
> that task. The clamp value mapped by a clamp group applies to a CPU only
> when there is at least one task RUNNABLE referencing that clamp group.
>
> When tasks are enqueued/dequeued on/from a CPU, the set of clamp groups
> active on that CPU can change. Since each clamp group enforces a
> different utilization clamp value, once the set of these groups changes
> it can be required to re-compute what is the new "aggregated" clamp
> value to apply on that CPU.
>
> Clamp values are always MAX aggregated for both util_min and util_max.
> This is to ensure that no tasks can affect the performance of other
> co-scheduled tasks which are either more boosted (i.e.  with higher
> util_min clamp) or less capped (i.e. with higher util_max clamp).
>
> Here we introduce the required support to properly reference count clamp
> groups at each task enqueue/dequeue time.
>
> Tasks have a:
>    task_struct::uclamp::group_id[clamp_idx]
> indexing, for each clamp index (i.e. util_{min,max}), the clamp group in
> which they should refcount at enqueue time.
>
> CPUs rq have a:
>    rq::uclamp::group[clamp_idx][group_idx].tasks
> which is used to reference count how many tasks are currently RUNNABLE on
> that CPU for each clamp group of each clamp index..
>
> The clamp value of each clamp group is tracked by
> rq::uclamp::group[][].value, thus making rq::uclamp::group[][] an
> unordered array of clamp values. However, the MAX aggregation of the
> currently active clamp groups is implemented to minimize the number of
> times we need to scan the complete (unordered) clamp group array to
> figure out the new max value. This operation indeed happens only when we
> dequeue last task of the clamp group corresponding to the current max
> clamp, and thus the CPU is either entering IDLE or going to schedule a
> less boosted or more clamped task.
> Moreover, the expected number of different clamp values, which can be
> configured at build time, is usually so small that a more advanced
> ordering algorithm is not needed. In real use-cases we expect less then
> 10 different values.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/core.c  | 188 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c  |   4 +
>  kernel/sched/rt.c    |   4 +
>  kernel/sched/sched.h |  71 ++++++++++++++++
>  4 files changed, 267 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 50e749067df5..d1969931fea6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -848,9 +848,19 @@ static inline void uclamp_group_init(int clamp_id, int group_id,
>                                      unsigned int clamp_value)
>  {
>         struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       struct uclamp_cpu *uc_cpu;
> +       int cpu;
>
> +       /* Set clamp group map */
>         uc_map[group_id].value = clamp_value;
>         uc_map[group_id].se_count = 0;
> +
> +       /* Set clamp groups on all CPUs */
> +       for_each_possible_cpu(cpu) {
> +               uc_cpu = &cpu_rq(cpu)->uclamp;
> +               uc_cpu->group[clamp_id][group_id].value = clamp_value;
> +               uc_cpu->group[clamp_id][group_id].tasks = 0;
> +       }
>  }
>
>  /**
> @@ -906,6 +916,172 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
>         return group_id;
>  }
>
> +/**
> + * uclamp_cpu_update: updates the utilization clamp of a CPU
> + * @cpu: the CPU which utilization clamp has to be updated
> + * @clamp_id: the clamp index to update
> + *
> + * When tasks are enqueued/dequeued on/from a CPU, the set of currently active
> + * clamp groups is subject to change. Since each clamp group enforces a
> + * different utilization clamp value, once the set of these groups changes it
> + * can be required to re-compute what is the new clamp value to apply for that
> + * CPU.
> + *
> + * For the specified clamp index, this method computes the new CPU utilization
> + * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
> + */
> +static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
> +{
> +       struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
> +       int max_value = UCLAMP_NONE;
> +       unsigned int group_id;
> +
> +       for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> +               /* Ignore inactive clamp groups, i.e. no RUNNABLE tasks */
> +               if (!uclamp_group_active(uc_grp, group_id))
> +                       continue;
> +
> +               /* Both min and max clamp are MAX aggregated */
> +               max_value = max(max_value, uc_grp[group_id].value);
> +
> +               /* Stop if we reach the max possible clamp */
> +               if (max_value >= SCHED_CAPACITY_SCALE)
> +                       break;
> +       }
> +       rq->uclamp.value[clamp_id] = max_value;
> +}
> +
> +/**
> + * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
> + * @p: the task being enqueued on a CPU
> + * @rq: the CPU's rq where the clamp group has to be reference counted
> + * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
> + *
> + * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
> + * the task's uclamp.group_id is reference counted on that CPU.
> + */
> +static inline void uclamp_cpu_get_id(struct task_struct *p,
> +                                    struct rq *rq, int clamp_id)
> +{
> +       struct uclamp_group *uc_grp;
> +       struct uclamp_cpu *uc_cpu;
> +       int clamp_value;
> +       int group_id;
> +
> +       /* No task specific clamp values: nothing to do */
> +       group_id = p->uclamp[clamp_id].group_id;
> +       if (group_id == UCLAMP_NONE)
> +               return;
> +
> +       /* Reference count the task into its current group_id */
> +       uc_grp = &rq->uclamp.group[clamp_id][0];
> +       uc_grp[group_id].tasks += 1;
> +
> +       /*
> +        * If this is the new max utilization clamp value, then we can update
> +        * straight away the CPU clamp value. Otherwise, the current CPU clamp
> +        * value is still valid and we are done.
> +        */
> +       uc_cpu = &rq->uclamp;
> +       clamp_value = p->uclamp[clamp_id].value;
> +       if (uc_cpu->value[clamp_id] < clamp_value)
> +               uc_cpu->value[clamp_id] = clamp_value;
> +}
> +
> +/**
> + * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
> + * @p: the task being dequeued from a CPU
> + * @cpu: the CPU from where the clamp group has to be released
> + * @clamp_id: the utilization clamp (e.g. min or max utilization) to release
> + *
> + * When a task is dequeued from a CPU's RQ, the CPU's clamp group reference
> + * counted by the task is decreased.
> + * If this was the last task defining the current max clamp group, then the
> + * CPU clamping is updated to find the new max for the specified clamp
> + * index.
> + */
> +static inline void uclamp_cpu_put_id(struct task_struct *p,
> +                                    struct rq *rq, int clamp_id)
> +{
> +       struct uclamp_group *uc_grp;
> +       struct uclamp_cpu *uc_cpu;
> +       unsigned int clamp_value;
> +       int group_id;
> +
> +       /* No task specific clamp values: nothing to do */
> +       group_id = p->uclamp[clamp_id].group_id;
> +       if (group_id == UCLAMP_NONE)
> +               return;
> +
> +       /* Decrement the task's reference counted group index */
> +       uc_grp = &rq->uclamp.group[clamp_id][0];
> +       uc_grp[group_id].tasks -= 1;
> +
> +       /* If this is not the last task, no updates are required */
> +       if (uc_grp[group_id].tasks > 0)
> +               return;
> +
> +       /*
> +        * Update the CPU only if this was the last task of the group
> +        * defining the current clamp value.
> +        */
> +       uc_cpu = &rq->uclamp;
> +       clamp_value = uc_grp[group_id].value;
> +       if (clamp_value >= uc_cpu->value[clamp_id])
> +               uclamp_cpu_update(rq, clamp_id);
> +}
> +
> +/**
> + * uclamp_cpu_get(): increase CPU's clamp group refcount
> + * @rq: the CPU's rq where the clamp group has to be refcounted
> + * @p: the task being enqueued
> + *
> + * Once a task is enqueued on a CPU's rq, all the clamp groups currently
> + * enforced on a task are reference counted on that rq.
> + * Not all scheduling classes have utilization clamping support, their tasks
> + * will be silently ignored.
> + *
> + * This method updates the utilization clamp constraints considering the
> + * requirements for the specified task. Thus, this update must be done before
> + * calling into the scheduling classes, which will eventually update schedutil
> + * considering the new task requirements.
> + */
> +static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p)
> +{
> +       int clamp_id;
> +
> +       if (unlikely(!p->sched_class->uclamp_enabled))
> +               return;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +               uclamp_cpu_get_id(p, rq, clamp_id);
> +}
> +
> +/**
> + * uclamp_cpu_put(): decrease CPU's clamp group refcount
> + * @cpu: the CPU's rq where the clamp group refcount has to be decreased
> + * @p: the task being dequeued
> + *
> + * When a task is dequeued from a CPU's rq, all the clamp groups the task has
> + * been reference counted at task's enqueue time have to be decreased for that
> + * CPU.
> + *
> + * This method updates the utilization clamp constraints considering the
> + * requirements for the specified task. Thus, this update must be done before
> + * calling into the scheduling classes, which will eventually update schedutil
> + * considering the new task requirements.
> + */
> +static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p)
> +{
> +       int clamp_id;
> +
> +       if (unlikely(!p->sched_class->uclamp_enabled))
> +               return;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +               uclamp_cpu_put_id(p, rq, clamp_id);
> +}
> +
>  /**
>   * uclamp_group_put: decrease the reference count for a clamp group
>   * @clamp_id: the clamp index which was affected by a task group
> @@ -1021,9 +1197,17 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
>  static void __init init_uclamp(void)
>  {
>         int clamp_id;
> +       int cpu;
>
>         mutex_init(&uclamp_mutex);
>
> +       /* Init CPU's clamp groups */
> +       for_each_possible_cpu(cpu) {
> +               struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
> +
> +               memset(uc_cpu, UCLAMP_NONE, sizeof(struct uclamp_cpu));
> +       }
> +
>         /* Init SE's clamp map */
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>                 struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> @@ -1037,6 +1221,8 @@ static void __init init_uclamp(void)
>  }
>
>  #else /* CONFIG_UCLAMP_TASK */
> +static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
> +static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>                                         const struct sched_attr *attr)
>  {
> @@ -1053,6 +1239,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>         if (!(flags & ENQUEUE_RESTORE))
>                 sched_info_queued(rq, p);
>
> +       uclamp_cpu_get(rq, p);
>         p->sched_class->enqueue_task(rq, p, flags);
>  }
>
> @@ -1064,6 +1251,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>         if (!(flags & DEQUEUE_SAVE))
>                 sched_info_dequeued(rq, p);
>
> +       uclamp_cpu_put(rq, p);
>         p->sched_class->dequeue_task(rq, p, flags);
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2f0a0be4d344..fd857440276c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10433,6 +10433,10 @@ const struct sched_class fair_sched_class = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         .task_change_group      = task_change_group_fair,
>  #endif
> +
> +#ifdef CONFIG_UCLAMP_TASK
> +       .uclamp_enabled         = 1,
> +#endif
>  };
>
>  #ifdef CONFIG_SCHED_DEBUG
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 572567078b60..056a7e1bd529 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2391,6 +2391,10 @@ const struct sched_class rt_sched_class = {
>         .switched_to            = switched_to_rt,
>
>         .update_curr            = update_curr_rt,
> +
> +#ifdef CONFIG_UCLAMP_TASK
> +       .uclamp_enabled         = 1,
> +#endif
>  };
>
>  #ifdef CONFIG_RT_GROUP_SCHED
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c7742dcc136c..65bf9ebacd83 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -744,6 +744,50 @@ extern void rto_push_irq_work_func(struct irq_work *work);
>  #endif
>  #endif /* CONFIG_SMP */
>
> +#ifdef CONFIG_UCLAMP_TASK
> +/**
> + * struct uclamp_group - Utilization clamp Group
> + * @value: utilization clamp value for tasks on this clamp group
> + * @tasks: number of RUNNABLE tasks on this clamp group
> + *
> + * Keep track of how many tasks are RUNNABLE for a given utilization
> + * clamp value.
> + */
> +struct uclamp_group {
> +       int value;
> +       int tasks;
> +};
> +
> +/**
> + * struct uclamp_cpu - CPU's utilization clamp
> + * @value: currently active clamp values for a CPU
> + * @group: utilization clamp groups affecting a CPU
> + *
> + * Keep track of RUNNABLE tasks on a CPUs to aggregate their clamp values.
> + * A clamp value is affecting a CPU where there is at least one task RUNNABLE
> + * (or actually running) with that value.
> + *
> + * We have up to UCLAMP_CNT possible different clamp value, which are
> + * currently only two: minmum utilization and maximum utilization.
> + *
> + * All utilization clamping values are MAX aggregated, since:
> + * - for util_min: we want to run the CPU at least at the max of the minimum
> + *   utilization required by its currently RUNNABLE tasks.
> + * - for util_max: we want to allow the CPU to run up to the max of the
> + *   maximum utilization allowed by its currently RUNNABLE tasks.
> + *
> + * Since on each system we expect only a limited number of different
> + * utilization clamp values (CONFIG_UCLAMP_GROUPS_COUNT), we use a simple
> + * array to track the metrics required to compute all the per-CPU utilization
> + * clamp values. The additional slot is used to track the default clamp
> + * values, i.e. no min/max clamping at all.
> + */
> +struct uclamp_cpu {
> +       int value[UCLAMP_CNT];
> +       struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
> +};
> +#endif /* CONFIG_UCLAMP_TASK */
> +
>  /*
>   * This is the main, per-CPU runqueue data structure.
>   *
> @@ -781,6 +825,11 @@ struct rq {
>         unsigned long           nr_load_updates;
>         u64                     nr_switches;
>
> +#ifdef CONFIG_UCLAMP_TASK
> +       /* Utilization clamp values based on CPU's RUNNABLE tasks */
> +       struct uclamp_cpu       uclamp ____cacheline_aligned;
> +#endif
> +
>         struct cfs_rq           cfs;
>         struct rt_rq            rt;
>         struct dl_rq            dl;
> @@ -1535,6 +1584,10 @@ struct sched_class {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         void (*task_change_group)(struct task_struct *p, int type);
>  #endif
> +
> +#ifdef CONFIG_UCLAMP_TASK
> +       int uclamp_enabled;
> +#endif
>  };
>
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
> @@ -2130,6 +2183,24 @@ static inline u64 irq_time_read(int cpu)
>  }
>  #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
>
> +#ifdef CONFIG_UCLAMP_TASK
> +/**
> + * uclamp_group_active: check if a clamp group is active on a CPU
> + * @uc_grp: the clamp groups for a CPU
> + * @group_id: the clamp group to check
> + *
> + * A clamp group affects a CPU if it as at least one RUNNABLE task.

typo: "has at least"

> + *
> + * Return: true if the specified CPU has at least one RUNNABLE task
> + *         for the specified clamp group.
> + */
> +static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
> +                                      int group_id)
> +{
> +       return uc_grp[group_id].tasks > 0;
> +}
> +#endif /* CONFIG_UCLAMP_TASK */
> +
>  #ifdef CONFIG_CPU_FREQ
>  DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
>
> --
> 2.17.1
>
