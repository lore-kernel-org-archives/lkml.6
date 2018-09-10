Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06E2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muyFZpc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD06E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeIJVPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:15:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53079 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeIJVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:15:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so22022949wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AaThfsrbdIv9qSva0lZ+Ofq3oeuN3Vpi9OQBtgh1jcw=;
        b=muyFZpc2A6eVqTjIaZauTFQ0YQ1XYTNjw9FWmE3PRuAe2rH1XgmDRJYqksAHlkyOfY
         N0IoZx2USoDpzsc2EPfusLtWzsjYA75tzJeJS1vtpfloIcGZCWYa7UddHEGQg159fxLd
         +SZSaTAQtgJHbbJt2Z0cgqkNOohm78/kA+EJUaY8glRhtfeXRGue0PDHhLvyBh+Uw0jL
         O0AfwXAjXegI3osePiw8ez6216uGW+IAdWDf0dSCtlRSg5Mt8y095/+6dMUEaDuxLSEo
         INMOIpj/RA1b7LQGfrZX07NzQ0uVb0FNtiqeLPU+T+Kqf+87v93mOa4TDGgyUKHOEblp
         JKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AaThfsrbdIv9qSva0lZ+Ofq3oeuN3Vpi9OQBtgh1jcw=;
        b=oI7gviyRpyXoODpwZMuHpHifrZO2rz1/hlEQ3gKkk/QlPI3lWhi5WRG7JD6Jxj+xiU
         NS/B6ovnv2a44qTyKhGbNC90X0XSW6f8cKNvK998hxdesbGvw/N48c9GSfXkVoGntwvW
         jmtZhYFU2gOIVA+ZmXeu6aqWu6FvANgvO0kHU9uWjpj63z9A6XHcZFIvH3UWb9GtsaGE
         ZWUMvFd6sIBMpz0VASCH5PNzC0Y5dgOiEjvwCznhfYt9NUGiIGkCM2pm2Mm1dS8vyKlA
         XjVdFljGGFZMteR98GHy8hovlk2kc5lnowhMl5LLLzNZ1RSMRDbPUePyRD7EebdTFNZ9
         6kNQ==
X-Gm-Message-State: APzg51A/uHOEH9RZJMgfPDZyz7Wt7q8V25X25uMOf1hW29MSoBlzB03O
        jkcuSBG72FMu8or7qCQ7TPsmDT7+htCsYRGRWxdZXg==
X-Google-Smtp-Source: ANB0VdZAKsrcCxwY/Hf5PSKDO+yQ5BNGqydkkGZQ0kf1UJ9wDV13dt3XzvJ+4gxQdRgLPYbilrhz+a3bxJ0Yy3mOAZY=
X-Received: by 2002:a1c:d98a:: with SMTP id q132-v6mr1288189wmg.78.1536596430409;
 Mon, 10 Sep 2018 09:20:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 09:20:29
 -0700 (PDT)
In-Reply-To: <20180828135324.21976-12-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com> <20180828135324.21976-12-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Sep 2018 09:20:29 -0700
Message-ID: <CAJuCfpGSUzo9gxWZABUUKaEEEvxdnvny9d1ErnLVLEKrkYf+eQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] sched/core: uclamp: add system default clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
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

On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Clamp values cannot be tuned at the root cgroup level. Moreover, because
> of the delegation model requirements and how the parent clamps
> propagation works, if we want to enable subgroups to set a non null
> util.min, we need to be able to configure the root group util.min to the
> allow the maximum utilization (SCHED_CAPACITY_SCALE = 1024).
>
> Unfortunately this setup will also mean that all tasks running in the
> root group, will always get a maximum util.min clamp, unless they have a
> lower task specific clamp which is definitively not a desirable default
> configuration.
>
> Let's fix this by explicitly adding a system default configuration
> (sysctl_sched_uclamp_util_{min,max}) which works as a restrictive clamp
> for all tasks running on the root group.
>
> This interface is available independently from cgroups, thus providing a
> complete solution for system wide utilization clamping configuration.
>
> Each task has now by default:
>    task_struct::uclamp::value = UCLAMP_NOT_VALID
> unless:
>  - the task has been forked from a parent with a valid clamp and
>    !SCHED_FLAG_RESET_ON_FORK
>  - the task has got a task-specific value set via sched_setattr()
>
> A task with a UCLAMP_NOT_VALID clamp value is refcounted considering the
> system default clamps if either we do not have task group support or
> they are part of the root_task_group.
> Tasks without a task specific clamp value in a child task group will be
> refcounted instead considering the task group clamps.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Quentin Perret <quentin.perret@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>
> ---
> Changes in v4:
>  Message-ID: <20180820122728.GM2960@e110439-lin>
>  - fix unwanted reset of clamp values on refcount success
>  Others:
>  - by default all tasks have a UCLAMP_NOT_VALID task specific clamp
>  - always use:
>       p->uclamp[clamp_id].effective.value
>    to track the actual clamp value the task has been refcounted into.
>    This matches with the usage of
>       p->uclamp[clamp_id].effective.group_id
>  - rebased on v4.19-rc1
> ---
>  include/linux/sched/sysctl.h |  11 +++
>  kernel/sched/core.c          | 147 +++++++++++++++++++++++++++++++++--
>  kernel/sysctl.c              |  16 ++++
>  3 files changed, 168 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index a9c32daeb9d8..445fb54eaeff 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -56,6 +56,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
>  extern unsigned int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>
> +#ifdef CONFIG_UCLAMP_TASK
> +extern unsigned int sysctl_sched_uclamp_util_min;
> +extern unsigned int sysctl_sched_uclamp_util_max;
> +#endif
> +
>  #ifdef CONFIG_CFS_BANDWIDTH
>  extern unsigned int sysctl_sched_cfs_bandwidth_slice;
>  #endif
> @@ -75,6 +80,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
>                 void __user *buffer, size_t *lenp,
>                 loff_t *ppos);
>
> +#ifdef CONFIG_UCLAMP_TASK
> +extern int sched_uclamp_handler(struct ctl_table *table, int write,
> +                               void __user *buffer, size_t *lenp,
> +                               loff_t *ppos);
> +#endif
> +
>  extern int sysctl_numa_balancing(struct ctl_table *table, int write,
>                                  void __user *buffer, size_t *lenp,
>                                  loff_t *ppos);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da0b3bd41e96..fbc8d9fdfdbb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -728,6 +728,20 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>   */
>  static DEFINE_MUTEX(uclamp_mutex);
>
> +/*
> + * Minimum utilization for tasks in the root cgroup
> + * default: 0
> + */
> +unsigned int sysctl_sched_uclamp_util_min;
> +
> +/*
> + * Maximum utilization for tasks in the root cgroup
> + * default: 1024
> + */
> +unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> +
> +static struct uclamp_se uclamp_default[UCLAMP_CNT];
> +
>  /**
>   * uclamp_map: reference counts a utilization "clamp value"
>   * @value:    the utilization "clamp value" required
> @@ -961,11 +975,16 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
>   *
>   * This method returns the effective group index for a task, depending on its
>   * status and a proper aggregation of the clamp values listed above.
> + * Moreover, it ensures that the task's effective value:
> + *    task_struct::uclamp::effective::value
> + * is updated to represent the clamp value corresponding to the taks effective
> + * group index.
>   */
>  static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
>  {
>         struct uclamp_se *uc_se;
>         int clamp_value;
> +       bool unclamped;
>         int group_id;
>
>         /* Taks currently accounted into a clamp group */
> @@ -977,13 +996,40 @@ static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
>         clamp_value = uc_se->value;
>         group_id = uc_se->group_id;
>
> +       unclamped = (clamp_value == UCLAMP_NOT_VALID);
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
> +       /*
> +        * Tasks in the root group, which do not have a task specific clamp
> +        * value, get the system default clamp value.
> +        */
> +       if (unclamped && (task_group_is_autogroup(task_group(p)) ||
> +                         task_group(p) == &root_task_group)) {
> +               p->uclamp[clamp_id].effective.value =
> +                       uclamp_default[clamp_id].value;
> +
> +               return uclamp_default[clamp_id].group_id;
> +       }
> +
>         /* Use TG's clamp value to limit task specific values */
>         uc_se = &task_group(p)->uclamp[clamp_id];
> -       if (clamp_value > uc_se->effective.value)
> -               group_id = uc_se->effective.group_id;
> +       if (unclamped || clamp_value > uc_se->effective.value) {
> +               p->uclamp[clamp_id].effective.value =
> +                       uc_se->effective.value;
> +
> +               return uc_se->effective.group_id;
> +       }
> +#else
> +       /* By default, all tasks get the system default clamp value */
> +       if (unclamped) {
> +               p->uclamp[clamp_id].effective.value =
> +                       uclamp_default[clamp_id].value;
> +
> +               return uclamp_default[clamp_id].group_id;
> +       }
>  #endif
>
> +       p->uclamp[clamp_id].effective.value = clamp_value;
> +
>         return group_id;
>  }
>
> @@ -999,9 +1045,10 @@ static inline int uclamp_group_value(int clamp_id, int group_id)
>
>  static inline int uclamp_task_value(struct task_struct *p, int clamp_id)
>  {
> -       int group_id = uclamp_task_group_id(p, clamp_id);
> +       /* Ensure effective task's clamp value is update */

typo: is updated

> +       uclamp_task_group_id(p, clamp_id);
>
> -       return uclamp_group_value(clamp_id, group_id);
> +       return p->uclamp[clamp_id].effective.value;
>  }
>
>  /**
> @@ -1047,7 +1094,7 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>
>         /* Reset clamp holds on idle exit */
>         uc_cpu = &rq->uclamp;
> -       clamp_value = p->uclamp[clamp_id].value;
> +       clamp_value = p->uclamp[clamp_id].effective.value;
>         if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
>                 /*
>                  * This function is called for both UCLAMP_MIN (before) and
> @@ -1300,6 +1347,77 @@ static inline void uclamp_group_get(struct task_struct *p,
>         uclamp_group_put(clamp_id, prev_group_id);
>  }
>
> +int sched_uclamp_handler(struct ctl_table *table, int write,
> +                        void __user *buffer, size_t *lenp,
> +                        loff_t *ppos)
> +{
> +       int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +       struct uclamp_se *uc_se;
> +       int old_min, old_max;
> +       unsigned int value;
> +       int result;
> +
> +       mutex_lock(&uclamp_mutex);
> +
> +       old_min = sysctl_sched_uclamp_util_min;
> +       old_max = sysctl_sched_uclamp_util_max;
> +
> +       result = proc_dointvec(table, write, buffer, lenp, ppos);
> +       if (result)
> +               goto undo;
> +       if (!write)
> +               goto done;
> +
> +       result = -EINVAL;
> +       if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max)
> +               goto undo;
> +       if (sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE)
> +               goto undo;
> +
> +       /* Find a valid group_id for each required clamp value */
> +       if (old_min != sysctl_sched_uclamp_util_min) {
> +               value = sysctl_sched_uclamp_util_min;
> +               result = uclamp_group_find(UCLAMP_MIN, value);
> +               if (result == -ENOSPC) {
> +                       pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> +                       goto undo;
> +               }
> +               group_id[UCLAMP_MIN] = result;
> +       }
> +       if (old_max != sysctl_sched_uclamp_util_max) {
> +               value = sysctl_sched_uclamp_util_max;
> +               result = uclamp_group_find(UCLAMP_MAX, value);
> +               if (result == -ENOSPC) {
> +                       pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> +                       goto undo;
> +               }
> +               group_id[UCLAMP_MAX] = result;
> +       }
> +       result = 0;
> +
> +       /* Update each required clamp group */
> +       if (old_min != sysctl_sched_uclamp_util_min) {
> +               uc_se = &uclamp_default[UCLAMP_MIN];
> +               uclamp_group_get(NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
> +                                uc_se, sysctl_sched_uclamp_util_min);
> +       }
> +       if (old_max != sysctl_sched_uclamp_util_max) {
> +               uc_se = &uclamp_default[UCLAMP_MAX];
> +               uclamp_group_get(NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
> +                                uc_se, sysctl_sched_uclamp_util_max);
> +       }
> +       goto done;
> +
> +undo:
> +       sysctl_sched_uclamp_util_min = old_min;
> +       sysctl_sched_uclamp_util_max = old_max;
> +
> +done:
> +       mutex_unlock(&uclamp_mutex);
> +
> +       return result;
> +}
> +
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>  /**
>   * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
> @@ -1468,6 +1586,8 @@ static void uclamp_fork(struct task_struct *p, bool reset)
>                 if (unlikely(reset)) {
>                         next_group_id = 0;
>                         p->uclamp[clamp_id].value = uclamp_none(clamp_id);
> +                       p->uclamp[clamp_id].effective.value =
> +                               uclamp_none(clamp_id);
>                 }
>                 /* Forked tasks are not yet enqueued */
>                 p->uclamp[clamp_id].effective.group_id = UCLAMP_NOT_VALID;
> @@ -1475,6 +1595,10 @@ static void uclamp_fork(struct task_struct *p, bool reset)
>                 p->uclamp[clamp_id].group_id = UCLAMP_NOT_VALID;
>                 uclamp_group_get(NULL, clamp_id, next_group_id, uc_se,
>                                  p->uclamp[clamp_id].value);
> +
> +               /* By default we do not want task-specific clamp values */
> +               if (unlikely(reset))
> +                       p->uclamp[clamp_id].value = UCLAMP_NOT_VALID;
>         }
>  }
>
> @@ -1509,12 +1633,17 @@ static void __init init_uclamp(void)
>                 uc_se->group_id = UCLAMP_NOT_VALID;
>                 uclamp_group_get(NULL, clamp_id, 0, uc_se,
>                                  uclamp_none(clamp_id));
> +               /*
> +                * By default we do not want task-specific clamp values,
> +                * so that system default values apply.
> +                */
> +               uc_se->value = UCLAMP_NOT_VALID;
>
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>                 /* Init root TG's clamp group */
>                 uc_se = &root_task_group.uclamp[clamp_id];
>
> -               uc_se->effective.value = uclamp_none(clamp_id);
> +               uc_se->effective.value = uclamp_none(UCLAMP_MAX);

Both clamps are initialized with 1023 because children can go lower
but can't go higher? Comment might be helpful.
I saw this pattern of using uclamp_none(UCLAMP_MAX) for both clamps in
couple places. Maybe would be better to have smth like:

static inline int tg_uclamp_none(int clamp_id) {
    /* TG's min and max clamps default to SCHED_CAPACITY_SCALE to
allow children to tighten the restriction */
    return SCHED_CAPACITY_SCALE;
}

and use tg_uclamp_none(clamp_id) instead of uclamp_none(UCLAMP_MAX)?
Functionally the same but much more readable.

>                 uc_se->effective.group_id = 0;
>
>                 /*
> @@ -1526,6 +1655,12 @@ static void __init init_uclamp(void)
>                 uclamp_group_get(NULL, clamp_id, 0, uc_se,
>                                  uclamp_none(UCLAMP_MAX));
>  #endif
> +
> +               /* Init system defaul's clamp group */

typo: default

> +               uc_se = &uclamp_default[clamp_id];
> +               uc_se->group_id = UCLAMP_NOT_VALID;
> +               uclamp_group_get(NULL, clamp_id, 0, uc_se,
> +                                uclamp_none(clamp_id));
>         }
>  }
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cc02050fd0c4..378ea57e5fc5 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -445,6 +445,22 @@ static struct ctl_table kern_table[] = {
>                 .mode           = 0644,
>                 .proc_handler   = sched_rr_handler,
>         },
> +#ifdef CONFIG_UCLAMP_TASK
> +       {
> +               .procname       = "sched_uclamp_util_min",
> +               .data           = &sysctl_sched_uclamp_util_min,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = sched_uclamp_handler,
> +       },
> +       {
> +               .procname       = "sched_uclamp_util_max",
> +               .data           = &sysctl_sched_uclamp_util_max,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = sched_uclamp_handler,
> +       },
> +#endif
>  #ifdef CONFIG_SCHED_AUTOGROUP
>         {
>                 .procname       = "sched_autogroup_enabled",
> --
> 2.18.0
>
