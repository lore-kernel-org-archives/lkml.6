Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C3AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FEB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uN3NIK+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FEB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeGTAgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:36:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53341 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTAgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:36:42 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so12322287itw.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vWqs/Bz+jpfLg07NvHYQguwCnx7+vIJRlKPsM6lq+ZU=;
        b=uN3NIK+gDTH0mqnbJa8m3pWn8fobUVYo/ZNe5u6Z7yx83ZXQ9E2hramX2oY+Wr6bve
         d/3p9j9SSOxo3lr4CY0x5XCWkXTfZb8SQpxyMOnGtFSfrUCjuDBRxQ8GVO6aqutGprCW
         sKVsQi1zuJgoJxzVdDJu+TCSkDBiZSxMk+YKY6h1JLLMDgrHErIWmys5iswPeR04MeCJ
         UVMR385hhG3x5cHJnjPkukgW5MMgpMSsnnD61gXMNITZ3oTOsbose1j2a82r6Pe4WnZP
         sjo1FNS055zmofLyo11tzLPP/K1yE3GKGFZepKpuEFf1UeUtobqe4SpJvCu9FbCZRIzH
         iz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vWqs/Bz+jpfLg07NvHYQguwCnx7+vIJRlKPsM6lq+ZU=;
        b=Q8AgtvuFPWBLPF/6s3ZaLeEbCeHozdVogle7NbXB2yQqPBJEoSBpnOMvoeIU0MorRW
         ZJFgh85rZFJuyvZzJnTtvYOiDfqhJEyXWWyhWM6AcgjGm3fOvq8LmAn+sUdc8Hn8E2Oh
         d24g+DSe9Fd9BeRYm7TTBgUro66wJZz/CzIj9hWcCQsQU3pouaO67YzkIxf0FPDF5Iu9
         1bfPkp4RTEpBTU8S2RjNAAIGGQDzbDJ0oGhjJ41Dad49hlVquG10apV2u5x/08vuZlU6
         TuWXxNvZPPPycJyybyQWMFuPwPmlXX51MKIaUh7hZVM/YVsfY0FdCSIACicRTvAghSL3
         i2fw==
X-Gm-Message-State: AOUpUlG8aQ96axu91bZ2o7zRqkqMBYUjiCSbxwv5et5wlzYKSpbwICRd
        PpuHlAEeeRdWjUCzXTwkHmTe+f+57wq3k6oxdu5xOg==
X-Google-Smtp-Source: AAOMgpd/N1hnRhNmbtSd1bDKiHaXCrSQSv2Zpm/rd04sjXM1TOsfZhAWG6uldS+4TkzfwtoUGNDgz7Vs6YreXA1jq0o=
X-Received: by 2002:a24:e4cf:: with SMTP id o198-v6mr114077ith.21.1532044272701;
 Thu, 19 Jul 2018 16:51:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 16:51:12
 -0700 (PDT)
In-Reply-To: <20180716082906.6061-3-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com> <20180716082906.6061-3-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Jul 2018 16:51:12 -0700
Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] sched/core: uclamp: map TASK's clamp values into
 CPU's clamp groups
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

On Mon, Jul 16, 2018 at 1:28 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Utilization clamping requires each CPU to know which clamp values are
> assigned to tasks that are currently RUNNABLE on that CPU.
> Multiple tasks can be assigned the same clamp value and tasks with
> different clamp values can be concurrently active on the same CPU.
> Thus, a proper data structure is required to support a fast and
> efficient aggregation of the clamp values required by the currently
> RUNNABLE tasks.
>
> For this purpose we use a per-CPU array of reference counters,
> where each slot is used to account how many tasks require a certain
> clamp value are currently RUNNABLE on each CPU.
> Each clamp value corresponds to a "clamp index" which identifies the
> position within the array of reference couters.
>
>                                  :
>        (user-space changes)      :      (kernel space / scheduler)
>                                  :
>              SLOW PATH           :             FAST PATH
>                                  :
>     task_struct::uclamp::value   :     sched/core::enqueue/dequeue
>                                  :         cpufreq_schedutil
>                                  :
>   +----------------+    +--------------------+     +-------------------+
>   |      TASK      |    |     CLAMP GROUP    |     |    CPU CLAMPS     |
>   +----------------+    +--------------------+     +-------------------+
>   |                |    |   clamp_{min,max}  |     |  clamp_{min,max}  |
>   | util_{min,max} |    |      se_count      |     |    tasks count    |
>   +----------------+    +--------------------+     +-------------------+
>                                  :
>            +------------------>  :  +------------------->
>     group_id = map(clamp_value)  :  ref_count(group_id)
>                                  :
>                                  :
>
> Let's introduce the support to map tasks to "clamp groups".
> Specifically we introduce the required functions to translate a
> "clamp value" into a clamp's "group index" (group_id).
>
> Only a limited number of (different) clamp values are supported since:
> 1. there are usually only few classes of workloads for which it makes
>    sense to boost/limit to different frequencies,
>    e.g. background vs foreground, interactive vs low-priority
> 2. it allows a simpler and more memory/time efficient tracking of
>    the per-CPU clamp values in the fast path.
>
> The number of possible different clamp values is currently defined at
> compile time. Thus, setting a new clamp value for a task can result into
> a -ENOSPC error in case this will exceed the number of maximum different
> clamp values supported.
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
>  include/linux/sched.h |  15 ++-
>  init/Kconfig          |  22 ++++
>  kernel/sched/core.c   | 300 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 330 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index fd8495723088..0635e8073cd3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -578,6 +578,19 @@ struct sched_dl_entity {
>         struct hrtimer inactive_timer;
>  };
>
> +/**
> + * Utilization's clamp group
> + *
> + * A utilization clamp group maps a "clamp value" (value), i.e.
> + * util_{min,max}, to a "clamp group index" (group_id).
> + */
> +struct uclamp_se {
> +       /* Utilization constraint for tasks in this group */
> +       unsigned int value;
> +       /* Utilization clamp group for this constraint */
> +       unsigned int group_id;
> +};
> +
>  union rcu_special {
>         struct {
>                 u8                      blocked;
> @@ -662,7 +675,7 @@ struct task_struct {
>
>  #ifdef CONFIG_UCLAMP_TASK
>         /* Utlization clamp values for this task */
> -       int                             uclamp[UCLAMP_CNT];
> +       struct uclamp_se                uclamp[UCLAMP_CNT];
>  #endif
>
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
> diff --git a/init/Kconfig b/init/Kconfig
> index 1d45a6877d6f..0a377ad7c166 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -601,7 +601,29 @@ config UCLAMP_TASK
>
>           If in doubt, say N.
>
> +config UCLAMP_GROUPS_COUNT
> +       int "Number of different utilization clamp values supported"
> +       range 0 127
> +       default 2
> +       depends on UCLAMP_TASK
> +       help
> +         This defines the maximum number of different utilization clamp
> +         values which can be concurrently enforced for each utilization
> +         clamp index (i.e. minimum and maximum utilization).
> +
> +         Only a limited number of clamp values are supported because:
> +           1. there are usually only few classes of workloads for which it
> +              makes sense to boost/cap for different frequencies,
> +              e.g. background vs foreground, interactive vs low-priority.
> +           2. it allows a simpler and more memory/time efficient tracking of
> +              the per-CPU clamp values.
> +
> +         Set to 0 (default value) to disable the utilization clamping feature.
> +
> +         If in doubt, use the default value.
> +
>  endmenu
> +
>  #
>  # For architectures that want to enable the support for NUMA-affine scheduler
>  # balancing logic:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6a42cd86b6f3..50e749067df5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -740,25 +740,309 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>  }
>
>  #ifdef CONFIG_UCLAMP_TASK
> +/**
> + * uclamp_mutex: serializes updates of utilization clamp values
> + *
> + * A utilization clamp value update is usually triggered from a user-space
> + * process (slow-path) but it requires a synchronization with the scheduler's
> + * (fast-path) enqueue/dequeue operations.
> + * While the fast-path synchronization is protected by RQs spinlock, this
> + * mutex ensures that we sequentially serve user-space requests.
> + */
> +static DEFINE_MUTEX(uclamp_mutex);
> +
> +/**
> + * uclamp_map: reference counts a utilization "clamp value"
> + * @value:    the utilization "clamp value" required
> + * @se_count: the number of scheduling entities requiring the "clamp value"
> + * @se_lock:  serialize reference count updates by protecting se_count
> + */
> +struct uclamp_map {
> +       int value;
> +       int se_count;
> +       raw_spinlock_t se_lock;
> +};
> +
> +/**
> + * uclamp_maps: maps each SEs "clamp value" into a CPUs "clamp group"
> + *
> + * Since only a limited number of different "clamp values" are supported, we
> + * need to map each different clamp value into a "clamp group" (group_id) to
> + * be used by the per-CPU accounting in the fast-path, when tasks are
> + * enqueued and dequeued.
> + * We also support different kind of utilization clamping, min and max
> + * utilization for example, each representing what we call a "clamp index"
> + * (clamp_id).
> + *
> + * A matrix is thus required to map "clamp values" to "clamp groups"
> + * (group_id), for each "clamp index" (clamp_id), where:
> + * - rows are indexed by clamp_id and they collect the clamp groups for a
> + *   given clamp index
> + * - columns are indexed by group_id and they collect the clamp values which
> + *   maps to that clamp group
> + *
> + * Thus, the column index of a given (clamp_id, value) pair represents the
> + * clamp group (group_id) used by the fast-path's per-CPU accounting.
> + *
> + * NOTE: first clamp group (group_id=0) is reserved for tracking of non
> + * clamped tasks.  Thus we allocate one more slot than the value of
> + * CONFIG_UCLAMP_GROUPS_COUNT.
> + *
> + * Here is the map layout and, right below, how entries are accessed by the
> + * following code.
> + *
> + *                          uclamp_maps is a matrix of
> + *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
> + *          |                                |
> + *          |                /---------------+---------------\
> + *          |               +------------+       +------------+
> + *          |  / UCLAMP_MIN | value      |       | value      |
> + *          |  |            | se_count   |...... | se_count   |
> + *          |  |            +------------+       +------------+
> + *          +--+            +------------+       +------------+
> + *             |            | value      |       | value      |
> + *             \ UCLAMP_MAX | se_count   |...... | se_count   |
> + *                          +-----^------+       +----^-------+
> + *                                |                   |
> + *                      uc_map =  +                   |
> + *                     &uclamp_maps[clamp_id][0]      +
> + *                                                clamp_value =
> + *                                       uc_map[group_id].value
> + */
> +static struct uclamp_map uclamp_maps[UCLAMP_CNT]
> +                                   [CONFIG_UCLAMP_GROUPS_COUNT + 1];
> +
> +/**
> + * uclamp_group_available: checks if a clamp group is available
> + * @clamp_id: the utilization clamp index (i.e. min or max clamp)
> + * @group_id: the group index in the given clamp_id
> + *
> + * A clamp group is not free if there is at least one SE which is sing a clamp

Did you mean to say "single clamp"?

> + * value mapped on the specified clamp_id. These SEs are reference counted by
> + * the se_count of a uclamp_map entry.
> + *
> + * Return: true if there are no SE's mapped on the specified clamp
> + *         index and group
> + */
> +static inline bool uclamp_group_available(int clamp_id, int group_id)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +
> +       return (uc_map[group_id].value == UCLAMP_NONE);

The usage of UCLAMP_NONE is very confusing to me. It was not used at
all in the patch where it was introduced [1/12], here it's used as a
clamp value and in uclamp_group_find() it's used as group_id. Please
clarify the usage. I also feel UCLAMP_NONE does not really belong to
the uclamp_id enum because other elements there are indexes in
uclamp_maps and this one is a special value. IMHO if both *group_id*
and *value* need a special value (-1) to represent
unused/uninitialized entry it would be better to use different
constants. Maybe UCLAMP_VAL_NONE and UCLAMP_GROUP_NONE?

> +}
> +
> +/**
> + * uclamp_group_init: maps a clamp value on a specified clamp group
> + * @clamp_id: the utilization clamp index (i.e. min or max clamp)
> + * @group_id: the group index to map a given clamp_value
> + * @clamp_value: the utilization clamp value to map
> + *
> + * Initializes a clamp group to track tasks from the fast-path.
> + * Each different clamp value, for a given clamp index (i.e. min/max
> + * utilization clamp), is mapped by a clamp group which index is used by the
> + * fast-path code to keep track of RUNNABLE tasks requiring a certain clamp
> + * value.
> + *
> + */
> +static inline void uclamp_group_init(int clamp_id, int group_id,
> +                                    unsigned int clamp_value)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +
> +       uc_map[group_id].value = clamp_value;
> +       uc_map[group_id].se_count = 0;
> +}
> +
> +/**
> + * uclamp_group_reset: resets a specified clamp group
> + * @clamp_id: the utilization clamp index (i.e. min or max clamping)
> + * @group_id: the group index to release
> + *
> + * A clamp group can be reset every time there are no more task groups using
> + * the clamp value it maps for a given clamp index.
> + */
> +static inline void uclamp_group_reset(int clamp_id, int group_id)
> +{
> +       uclamp_group_init(clamp_id, group_id, UCLAMP_NONE);
> +}
> +
> +/**
> + * uclamp_group_find: finds the group index of a utilization clamp group
> + * @clamp_id: the utilization clamp index (i.e. min or max clamping)
> + * @clamp_value: the utilization clamping value lookup for
> + *
> + * Verify if a group has been assigned to a certain clamp value and return
> + * its index to be used for accounting.
> + *
> + * Since only a limited number of utilization clamp groups are allowed, if no
> + * groups have been assigned for the specified value, a new group is assigned
> + * if possible. Otherwise an error is returned, meaning that an additional clamp
> + * value is not (currently) supported.
> + */
> +static int
> +uclamp_group_find(int clamp_id, unsigned int clamp_value)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       int free_group_id = UCLAMP_NONE;
> +       unsigned int group_id = 0;
> +
> +       for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> +               /* Keep track of first free clamp group */
> +               if (uclamp_group_available(clamp_id, group_id)) {
> +                       if (free_group_id == UCLAMP_NONE)
> +                               free_group_id = group_id;
> +                       continue;
> +               }
> +               /* Return index of first group with same clamp value */
> +               if (uc_map[group_id].value == clamp_value)
> +                       return group_id;
> +       }
> +       /* Default to first free clamp group */
> +       if (group_id > CONFIG_UCLAMP_GROUPS_COUNT)

Is the condition above needed? I think it's always true if you got here.
Also AFAIKT after the for loop you can just do:

return (free_group_id != UCLAMP_NONE) ? free_group_id : -ENOSPC;

> +               group_id = free_group_id;
> +       /* All clamp group already track different clamp values */
> +       if (group_id == UCLAMP_NONE)
> +               return -ENOSPC;
> +       return group_id;
> +}
> +
> +/**
> + * uclamp_group_put: decrease the reference count for a clamp group
> + * @clamp_id: the clamp index which was affected by a task group
> + * @uc_se: the utilization clamp data for that task group
> + *
> + * When the clamp value for a task group is changed we decrease the reference
> + * count for the clamp group mapping its current clamp value. A clamp group is
> + * released when there are no more task groups referencing its clamp value.
> + */
> +static inline void uclamp_group_put(int clamp_id, int group_id)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       unsigned long flags;
> +
> +       /* Ignore SE's not yet attached */
> +       if (group_id == UCLAMP_NONE)
> +               return;
> +
> +       /* Remove SE from this clamp group */
> +       raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
> +       uc_map[group_id].se_count -= 1;

If uc_map[group_id].se_count was 0 before decrement you end up with
se_count == -1 and no reset for the element.

> +       if (uc_map[group_id].se_count == 0)
> +               uclamp_group_reset(clamp_id, group_id);
> +       raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
> +}
> +
> +/**
> + * uclamp_group_get: increase the reference count for a clamp group
> + * @p: the task which clamp value must be tracked
> + * @clamp_id: the clamp index affected by the task
> + * @uc_se: the utilization clamp data for the task
> + * @clamp_value: the new clamp value for the task
> + *
> + * Each time a task changes its utilization clamp value, for a specified clamp
> + * index, we need to find an available clamp group which can be used to track
> + * this new clamp value. The corresponding clamp group index will be used by
> + * the task to reference count the clamp value on CPUs while enqueued.
> + *
> + * Return: -ENOSPC if there are no available clamp groups, 0 on success.
> + */
> +static inline int uclamp_group_get(struct task_struct *p,
> +                                  int clamp_id, struct uclamp_se *uc_se,
> +                                  unsigned int clamp_value)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       int prev_group_id = uc_se->group_id;
> +       int next_group_id = UCLAMP_NONE;
> +       unsigned long flags;
> +
> +       /* Lookup for a usable utilization clamp group */
> +       next_group_id = uclamp_group_find(clamp_id, clamp_value);
> +       if (next_group_id < 0) {
> +               pr_err("Cannot allocate more than %d utilization clamp groups\n",
> +                      CONFIG_UCLAMP_GROUPS_COUNT);
> +               return -ENOSPC;
> +       }
> +
> +       /* Allocate new clamp group for this clamp value */
> +       if (uclamp_group_available(clamp_id, next_group_id))
> +               uclamp_group_init(clamp_id, next_group_id, clamp_value);
> +
> +       /* Update SE's clamp values and attach it to new clamp group */
> +       raw_spin_lock_irqsave(&uc_map[next_group_id].se_lock, flags);
> +       uc_se->value = clamp_value;
> +       uc_se->group_id = next_group_id;
> +       uc_map[next_group_id].se_count += 1;
> +       raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
> +
> +       /* Release the previous clamp group */
> +       uclamp_group_put(clamp_id, prev_group_id);
> +
> +       return 0;
> +}
> +
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>                                         const struct sched_attr *attr)
>  {
> +       struct uclamp_se *uc_se;
> +       int retval = 0;
> +
>         if (attr->sched_util_min > attr->sched_util_max)
>                 return -EINVAL;
>         if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
>                 return -EINVAL;
>
> -       p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> -       p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> +       mutex_lock(&uclamp_mutex);
> +
> +       /* Update min utilization clamp */
> +       uc_se = &p->uclamp[UCLAMP_MIN];
> +       retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
> +                                  attr->sched_util_min);
> +
> +       /* Update max utilization clamp */
> +       uc_se = &p->uclamp[UCLAMP_MAX];
> +       retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
> +                                  attr->sched_util_max);
> +
> +       mutex_unlock(&uclamp_mutex);
> +
> +       /*
> +        * If one of the two clamp values should fail,
> +        * let the userspace know.
> +        */
> +       if (retval)
> +               return -ENOSPC;

Maybe a minor issue but this failure is ambiguous. It might mean:
1. no clamp value was updated
2. UCLAMP_MIN was updated but UCLAMP_MAX was not
3. UCLAMP_MAX was updated but UCLAMP_MIN was not

>
>         return 0;
>  }
> +
> +/**
> + * init_uclamp: initialize data structures required for utilization clamping
> + */
> +static void __init init_uclamp(void)
> +{
> +       int clamp_id;
> +
> +       mutex_init(&uclamp_mutex);
> +
> +       /* Init SE's clamp map */
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +               struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +               int group_id = 0;
> +
> +               for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> +                       uc_map[group_id].value = UCLAMP_NONE;
> +                       raw_spin_lock_init(&uc_map[group_id].se_lock);
> +               }
> +       }
> +}
> +
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>                                         const struct sched_attr *attr)
>  {
>         return -EINVAL;
>  }
> +static inline void init_uclamp(void) { }
>  #endif /* CONFIG_UCLAMP_TASK */
>
>  static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> @@ -2199,8 +2483,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  #endif
>
>  #ifdef CONFIG_UCLAMP_TASK
> -       p->uclamp[UCLAMP_MIN] = 0;
> -       p->uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE;
> +       p->uclamp[UCLAMP_MIN].value = 0;
> +       p->uclamp[UCLAMP_MIN].group_id = UCLAMP_NONE;
> +       p->uclamp[UCLAMP_MAX].value = SCHED_CAPACITY_SCALE;
> +       p->uclamp[UCLAMP_MAX].group_id = UCLAMP_NONE;
>  #endif
>
>  #ifdef CONFIG_SCHEDSTATS
> @@ -4784,8 +5070,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>                 attr.sched_nice = task_nice(p);
>
>  #ifdef CONFIG_UCLAMP_TASK
> -       attr.sched_util_min = p->uclamp[UCLAMP_MIN];
> -       attr.sched_util_max = p->uclamp[UCLAMP_MAX];
> +       attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
> +       attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
>  #endif
>
>         rcu_read_unlock();
> @@ -6151,6 +6437,8 @@ void __init sched_init(void)
>
>         init_schedstats();
>
> +       init_uclamp();
> +
>         scheduler_running = 1;
>  }
>
> --
> 2.17.1
>
