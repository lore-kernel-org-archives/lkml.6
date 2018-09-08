Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC5C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 23:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50CC20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 23:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srtbIqcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50CC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeIIEfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 00:35:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41525 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeIIEfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 00:35:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so18257417wrb.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9gpKBl/HJuwoG9DZIxjUYcSvzmlgHrkd82xrG/oiZnI=;
        b=srtbIqcGijWKb+zRVcpuGXsaF8lymp+2JnTmo80i6kKY9RyXlAVgvtr1Pu8YeGkM1J
         yI05cTUqIo22J13R2pMZ7T1BBRsavjTkNXTgGTJ2AVVfkO5XzKpFjWnTiS0a/yc7WEqa
         BeqIzoVMVWx45TtwwJgCAVLcjFX2a+HnCEboTTjGHVwR1hXk3biquE9XDtLE6tkka0fy
         RpLRfX6fDlVyCSsN6a1LnBVaxzY87SGewVQpXmYbPzoK0vuz4vruqvaxTR5VITShpXNB
         lGYGoqMPpfWEq3MTBfBL8aiyJxa9iczsRkiWAq8Xp0JmAzNh6YWKWvgB8UxdWZ3lUeeQ
         hzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9gpKBl/HJuwoG9DZIxjUYcSvzmlgHrkd82xrG/oiZnI=;
        b=UWPEvr+3de60L9pwJXGpAcAIYY0MVXPEEuUimodt9dlz54xvcjK2SkTVI3yZKfxqiB
         5tZjvW1h5h+9o74/IaHF5yh+Wymg8o+aOb14ItLWRhy/1IDOn+WWxZGxBV4gvUYsxXFA
         e2Y6q0FJ0FjzzmSO+PSc42d6llj0Fn/KKF1sS2FesBi9+SXTO45Ie2Klj0KmuYvAXs/V
         R77+cVwV2doZW2gO4ZKwFY6oAUsR0SSjkiM+DYUEt5KOO8W8cwW/Md3mF4i5nR3dVoAq
         EmG+BwHqjIxetVoT1o+bR7ubnqil8zCG7al833uIbTDGyvVilCAsDjY8fOooWGKcLpGy
         1/Lg==
X-Gm-Message-State: APzg51AOtdyxELOcBwgI1/GmHq3ekURSHQjXbXT073vGu7JyzQ9J82GO
        LImPiX+xuh+4GbIKttiRE2Rkuws7Ys/BXlbyP2JMBg==
X-Google-Smtp-Source: ANB0Vda8/6M2rYvCSH14ytHfEVOZSTXEw/rXTYSi0NEv1PfEn8dgPicqzj49sK/RbZBS2HwgbbQ2UopIz9CuTGPlnDc=
X-Received: by 2002:adf:f504:: with SMTP id q4-v6mr11062827wro.241.1536450454880;
 Sat, 08 Sep 2018 16:47:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 16:47:33 -0700 (PDT)
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com> <20180828135324.21976-3-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Sep 2018 16:47:33 -0700
Message-ID: <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values into
 CPU's clamp groups
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

Hi Patrick!

On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
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
> position within the array of reference counters.
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
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Quentin Perret <quentin.perret@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>
> ---
> Changes in v4:
>  Message-ID: <20180814112509.GB2661@codeaurora.org>
>  - add uclamp_exit_task() to release clamp refcount from do_exit()
>  Message-ID: <20180816133249.GA2964@e110439-lin>
>  - keep the WARN but butify a bit that code
>  Message-ID: <20180413082648.GP4043@hirez.programming.kicks-ass.net>
>  - move uclamp_enabled at the top of sched_class to keep it on the same
>    cache line of other main wakeup time callbacks
>  Others:
>  - init uclamp for the init_task and refcount its clamp groups
>  - add uclamp specific fork time code into uclamp_fork
>  - add support for SCHED_FLAG_RESET_ON_FORK
>    default clamps are now set for init_task and inherited/reset at
>    fork time (when then flag is set for the parent)
>  - enable uclamp only for FAIR tasks, RT class will be enabled only
>    by a following patch which also integrate the class to schedutil
>  - define uclamp_maps ____cacheline_aligned_in_smp
>  - in uclamp_group_get() ensure to include uclamp_group_available() and
>    uclamp_group_init() into the atomic section defined by:
>       uc_map[next_group_id].se_lock
>  - do not use mutex_lock(&uclamp_mutex) in uclamp_exit_task
>    which is also not needed since refcounting is already guarded by
>    the uc_map[group_id].se_lock spinlock
>  - rebased on v4.19-rc1
>
> Changes in v3:
>  Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
>  - rename UCLAMP_NONE into UCLAMP_NOT_VALID
>  - remove not necessary checks in uclamp_group_find()
>  - add WARN on unlikely un-referenced decrement in uclamp_group_put()
>  - make __setscheduler_uclamp() able to set just one clamp value
>  - make __setscheduler_uclamp() failing if both clamps are required but
>    there is no clamp groups available for one of them
>  - remove uclamp_group_find() from uclamp_group_get() which now takes a
>    group_id as a parameter
>  Others:
>  - rebased on tip/sched/core
> Changes in v2:
>  - rabased on v4.18-rc4
>  - set UCLAMP_GROUPS_COUNT=2 by default
>    which allows to fit all the hot-path CPU clamps data, partially
>    intorduced also by the following patches, into a single cache line
>    while still supporting up to 2 different {min,max}_utiql clamps.
> ---
>  include/linux/sched.h      |  16 +-
>  include/linux/sched/task.h |   6 +
>  include/uapi/linux/sched.h |   6 +-
>  init/Kconfig               |  20 ++
>  init/init_task.c           |   4 -
>  kernel/exit.c              |   1 +
>  kernel/sched/core.c        | 395 +++++++++++++++++++++++++++++++++++--
>  kernel/sched/fair.c        |   4 +
>  kernel/sched/sched.h       |  28 ++-
>  9 files changed, 456 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 880a0c5c1f87..7385f0b1a7c0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -279,6 +279,9 @@ struct vtime {
>         u64                     gtime;
>  };
>
> +/* Clamp not valid, i.e. group not assigned or invalid value */
> +#define UCLAMP_NOT_VALID -1
> +
>  enum uclamp_id {
>         UCLAMP_MIN = 0, /* Minimum utilization */
>         UCLAMP_MAX,     /* Maximum utilization */
> @@ -575,6 +578,17 @@ struct sched_dl_entity {
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
> +       unsigned int value;
> +       unsigned int group_id;
> +};
> +
>  union rcu_special {
>         struct {
>                 u8                      blocked;
> @@ -659,7 +673,7 @@ struct task_struct {
>
>  #ifdef CONFIG_UCLAMP_TASK
>         /* Utlization clamp values for this task */
> -       int                             uclamp[UCLAMP_CNT];
> +       struct uclamp_se                uclamp[UCLAMP_CNT];
>  #endif
>
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 108ede99e533..36c81c364112 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -68,6 +68,12 @@ static inline void exit_thread(struct task_struct *tsk)
>  #endif
>  extern void do_group_exit(int);
>
> +#ifdef CONFIG_UCLAMP_TASK
> +extern void uclamp_exit_task(struct task_struct *p);
> +#else
> +static inline void uclamp_exit_task(struct task_struct *p) { }
> +#endif /* CONFIG_UCLAMP_TASK */
> +
>  extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index c27d6e81517b..ae7e12de32ca 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -50,7 +50,11 @@
>  #define SCHED_FLAG_RESET_ON_FORK       0x01
>  #define SCHED_FLAG_RECLAIM             0x02
>  #define SCHED_FLAG_DL_OVERRUN          0x04
> -#define SCHED_FLAG_UTIL_CLAMP          0x08
> +
> +#define SCHED_FLAG_UTIL_CLAMP_MIN      0x10
> +#define SCHED_FLAG_UTIL_CLAMP_MAX      0x20
> +#define SCHED_FLAG_UTIL_CLAMP  (SCHED_FLAG_UTIL_CLAMP_MIN | \
> +                                SCHED_FLAG_UTIL_CLAMP_MAX)
>
>  #define SCHED_FLAG_ALL (SCHED_FLAG_RESET_ON_FORK       | \
>                          SCHED_FLAG_RECLAIM             | \
> diff --git a/init/Kconfig b/init/Kconfig
> index 738974c4f628..10536cb83295 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -633,7 +633,27 @@ config UCLAMP_TASK
>
>           If in doubt, say N.
>
> +config UCLAMP_GROUPS_COUNT
> +       int "Number of different utilization clamp values supported"
> +       range 0 32
> +       default 5
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
> +         If in doubt, use the default value.
> +
>  endmenu
> +
>  #
>  # For architectures that want to enable the support for NUMA-affine scheduler
>  # balancing logic:
> diff --git a/init/init_task.c b/init/init_task.c
> index 5bfdcc3fb839..7f77741b6a9b 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -92,10 +92,6 @@ struct task_struct init_task
>  #endif
>  #ifdef CONFIG_CGROUP_SCHED
>         .sched_task_group = &root_task_group,
> -#endif
> -#ifdef CONFIG_UCLAMP_TASK
> -       .uclamp[UCLAMP_MIN] = 0,
> -       .uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE,
>  #endif
>         .ptraced        = LIST_HEAD_INIT(init_task.ptraced),
>         .ptrace_entry   = LIST_HEAD_INIT(init_task.ptrace_entry),
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0e21e6d21f35..feb540558051 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -877,6 +877,7 @@ void __noreturn do_exit(long code)
>
>         sched_autogroup_exit_task(tsk);
>         cgroup_exit(tsk);
> +       uclamp_exit_task(tsk);
>
>         /*
>          * FIXME: do that only when needed, using sched_exit tracepoint
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 16d3544c7ffa..2668990b96d1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -717,25 +717,389 @@ static void set_load_weight(struct task_struct *p, bool update_load)
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
> +                                   [CONFIG_UCLAMP_GROUPS_COUNT + 1]
> +                                   ____cacheline_aligned_in_smp;
> +
> +#define UCLAMP_ENOSPC_FMT "Cannot allocate more than " \
> +       __stringify(CONFIG_UCLAMP_GROUPS_COUNT) " UTIL_%s clamp groups\n"
> +
> +/**
> + * uclamp_group_available: checks if a clamp group is available
> + * @clamp_id: the utilization clamp index (i.e. min or max clamp)
> + * @group_id: the group index in the given clamp_id
> + *
> + * A clamp group is not free if there is at least one SE which is sing a clamp

typo in the sentence

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
> +       return (uc_map[group_id].value == UCLAMP_NOT_VALID);
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
> +       uclamp_group_init(clamp_id, group_id, UCLAMP_NOT_VALID);
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
> + * groups have been assigned for the specified value, a new group is assigned,
> + * if possible.
> + * Otherwise an error is returned, meaning that an additional clamp value is
> + * not (currently) supported.
> + */
> +static int
> +uclamp_group_find(int clamp_id, unsigned int clamp_value)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       int free_group_id = UCLAMP_NOT_VALID;
> +       unsigned int group_id = 0;
> +
> +       for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> +               /* Keep track of first free clamp group */
> +               if (uclamp_group_available(clamp_id, group_id)) {
> +                       if (free_group_id == UCLAMP_NOT_VALID)
> +                               free_group_id = group_id;
> +                       continue;
> +               }

Not a big improvement but reordering the two conditions in this loop
would avoid finding and recording free_group_id if the very first
group is the one we are looking for.

> +               /* Return index of first group with same clamp value */
> +               if (uc_map[group_id].value == clamp_value)
> +                       return group_id;
> +       }
> +
> +       if (likely(free_group_id != UCLAMP_NOT_VALID))
> +               return free_group_id;
> +
> +       return -ENOSPC;
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

Is the size and the number of invocations of this function small
enough for inlining? Same goes for uclamp_group_get() and especially
for __setscheduler_uclamp().

> +static inline void uclamp_group_put(int clamp_id, int group_id)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       unsigned long flags;
> +
> +       /* Ignore SE's not yet attached */
> +       if (group_id == UCLAMP_NOT_VALID)
> +               return;
> +
> +       /* Remove SE from this clamp group */
> +       raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
> +       if (likely(uc_map[group_id].se_count))
> +               uc_map[group_id].se_count -= 1;
> +#ifdef SCHED_DEBUG
> +       else {

nit: no need for braces

> +               WARN(1, "invalid SE clamp group [%d:%d] refcount\n",
> +                    clamp_id, group_id);
> +       }
> +#endif
> +       if (uc_map[group_id].se_count == 0)
> +               uclamp_group_reset(clamp_id, group_id);
> +       raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
> +}
> +
> +/**
> + * uclamp_group_get: increase the reference count for a clamp group
> + * @clamp_id: the clamp index affected by the task
> + * @next_group_id: the clamp group to refcount
> + * @uc_se: the utilization clamp data for the task
> + * @clamp_value: the new clamp value for the task
> + *
> + * Each time a task changes its utilization clamp value, for a specified clamp
> + * index, we need to find an available clamp group which can be used to track
> + * this new clamp value. The corresponding clamp group index will be used by
> + * the task to reference count the clamp value on CPUs while enqueued.
> + */
> +static inline void uclamp_group_get(int clamp_id, int next_group_id,
> +                                   struct uclamp_se *uc_se,
> +                                   unsigned int clamp_value)
> +{
> +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +       int prev_group_id = uc_se->group_id;
> +       unsigned long flags;
> +
> +       /* Allocate new clamp group for this clamp value */
> +       raw_spin_lock_irqsave(&uc_map[next_group_id].se_lock, flags);
> +       if (uclamp_group_available(clamp_id, next_group_id))
> +               uclamp_group_init(clamp_id, next_group_id, clamp_value);
> +
> +       /* Update SE's clamp values and attach it to new clamp group */
> +       uc_se->value = clamp_value;
> +       uc_se->group_id = next_group_id;
> +       uc_map[next_group_id].se_count += 1;
> +       raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
> +
> +       /* Release the previous clamp group */
> +       uclamp_group_put(clamp_id, prev_group_id);
> +}
> +
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>                                         const struct sched_attr *attr)
>  {
> -       if (attr->sched_util_min > attr->sched_util_max)
> -               return -EINVAL;
> -       if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> -               return -EINVAL;
> +       int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +       int lower_bound, upper_bound;
> +       struct uclamp_se *uc_se;
> +       int result = 0;
>
> -       p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> -       p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> +       mutex_lock(&uclamp_mutex);
>
> -       return 0;
> +       /* Find a valid group_id for each required clamp value */
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +               upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> +                       ? attr->sched_util_max
> +                       : p->uclamp[UCLAMP_MAX].value;
> +
> +               if (upper_bound == UCLAMP_NOT_VALID)
> +                       upper_bound = SCHED_CAPACITY_SCALE;
> +               if (attr->sched_util_min > upper_bound) {
> +                       result = -EINVAL;
> +                       goto done;
> +               }
> +
> +               result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> +               if (result == -ENOSPC) {
> +                       pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> +                       goto done;
> +               }
> +               group_id[UCLAMP_MIN] = result;
> +       }
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +               lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> +                       ? attr->sched_util_min
> +                       : p->uclamp[UCLAMP_MIN].value;
> +
> +               if (lower_bound == UCLAMP_NOT_VALID)
> +                       lower_bound = 0;
> +               if (attr->sched_util_max < lower_bound ||
> +                   attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> +                       result = -EINVAL;
> +                       goto done;
> +               }
> +
> +               result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
> +               if (result == -ENOSPC) {
> +                       pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> +                       goto done;
> +               }
> +               group_id[UCLAMP_MAX] = result;
> +       }
> +
> +       /* Update each required clamp group */
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +               uc_se = &p->uclamp[UCLAMP_MIN];
> +               uclamp_group_get(UCLAMP_MIN, group_id[UCLAMP_MIN],
> +                                uc_se, attr->sched_util_min);
> +       }
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +               uc_se = &p->uclamp[UCLAMP_MAX];
> +               uclamp_group_get(UCLAMP_MAX, group_id[UCLAMP_MAX],
> +                                uc_se, attr->sched_util_max);
> +       }
> +
> +done:
> +       mutex_unlock(&uclamp_mutex);
> +
> +       return result;
> +}
> +
> +/**
> + * uclamp_exit_task: release referenced clamp groups
> + * @p: the task exiting
> + *
> + * When a task terminates, release all its (eventually) refcounted
> + * task-specific clamp groups.
> + */
> +void uclamp_exit_task(struct task_struct *p)
> +{
> +       struct uclamp_se *uc_se;
> +       int clamp_id;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +               uc_se = &p->uclamp[clamp_id];
> +               uclamp_group_put(clamp_id, uc_se->group_id);
> +       }
> +}
> +
> +/**
> + * uclamp_fork: refcount task-specific clamp values for a new task
> + */
> +static void uclamp_fork(struct task_struct *p, bool reset)
> +{
> +       int clamp_id;
> +
> +       if (unlikely(!p->sched_class->uclamp_enabled))
> +               return;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +               int next_group_id = p->uclamp[clamp_id].group_id;
> +               struct uclamp_se *uc_se = &p->uclamp[clamp_id];

Might be easier to read if after the above assignment you use
uc_se->xxx instead of p->uclamp[clamp_id].xxx in the code below.

> +
> +               if (unlikely(reset)) {
> +                       next_group_id = 0;
> +                       p->uclamp[clamp_id].value = uclamp_none(clamp_id);
> +               }
> +
> +               p->uclamp[clamp_id].group_id = UCLAMP_NOT_VALID;
> +               uclamp_group_get(clamp_id, next_group_id, uc_se,
> +                                p->uclamp[clamp_id].value);
> +       }
> +}
> +
> +/**
> + * init_uclamp: initialize data structures required for utilization clamping
> + */
> +static void __init init_uclamp(void)
> +{
> +       struct uclamp_se *uc_se;
> +       int clamp_id;
> +
> +       mutex_init(&uclamp_mutex);
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +               struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> +               int group_id = 0;
> +
> +               for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> +                       uc_map[group_id].value = UCLAMP_NOT_VALID;
> +                       raw_spin_lock_init(&uc_map[group_id].se_lock);
> +               }
> +
> +               /* Init init_task's clamp group */
> +               uc_se = &init_task.uclamp[clamp_id];
> +               uc_se->group_id = UCLAMP_NOT_VALID;
> +               uclamp_group_get(clamp_id, 0, uc_se, uclamp_none(clamp_id));
> +       }
>  }
> +
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>                                         const struct sched_attr *attr)
>  {
>         return -EINVAL;
>  }
> +static inline void uclamp_fork(struct task_struct *p, bool reset) { }
> +static inline void init_uclamp(void) { }
>  #endif /* CONFIG_UCLAMP_TASK */
>
>  static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> @@ -2314,6 +2678,7 @@ static inline void init_schedstats(void) {}
>  int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  {
>         unsigned long flags;
> +       bool reset;
>
>         __sched_fork(clone_flags, p);
>         /*
> @@ -2331,7 +2696,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>         /*
>          * Revert to default priority/policy on fork if requested.
>          */
> -       if (unlikely(p->sched_reset_on_fork)) {
> +       reset = p->sched_reset_on_fork;
> +       if (unlikely(reset)) {
>                 if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
>                         p->policy = SCHED_NORMAL;
>                         p->static_prio = NICE_TO_PRIO(0);
> @@ -2342,11 +2708,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>                 p->prio = p->normal_prio = __normal_prio(p);
>                 set_load_weight(p, false);
>
> -#ifdef CONFIG_UCLAMP_TASK
> -               p->uclamp[UCLAMP_MIN] = 0;
> -               p->uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE;
> -#endif
> -
>                 /*
>                  * We don't need the reset flag anymore after the fork. It has
>                  * fulfilled its duty:
> @@ -2363,6 +2724,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>
>         init_entity_runnable_average(&p->se);
>
> +       uclamp_fork(p, reset);
> +
>         /*
>          * The child is not yet in the pid-hash so no cgroup attach races,
>          * and the cgroup is pinned to this child due to cgroup_fork()
> @@ -4756,8 +5119,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
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
> @@ -6107,6 +6470,8 @@ void __init sched_init(void)
>
>         init_schedstats();
>
> +       init_uclamp();
> +
>         scheduler_running = 1;
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b39fb596f6c1..dab0405386c1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10055,6 +10055,10 @@ const struct sched_class fair_sched_class = {
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
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4a2e8cae63c4..72df2dc779bc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1501,10 +1501,12 @@ extern const u32                sched_prio_to_wmult[40];
>  struct sched_class {
>         const struct sched_class *next;
>
> +#ifdef CONFIG_UCLAMP_TASK
> +       int uclamp_enabled;
> +#endif
> +
>         void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
>         void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
> -       void (*yield_task)   (struct rq *rq);
> -       bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
>
>         void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
>
> @@ -1537,7 +1539,6 @@ struct sched_class {
>         void (*set_curr_task)(struct rq *rq);
>         void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
>         void (*task_fork)(struct task_struct *p);
> -       void (*task_dead)(struct task_struct *p);
>
>         /*
>          * The switched_from() call is allowed to drop rq->lock, therefore we
> @@ -1554,12 +1555,17 @@ struct sched_class {
>
>         void (*update_curr)(struct rq *rq);
>
> +       void (*yield_task)   (struct rq *rq);
> +       bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
> +
>  #define TASK_SET_GROUP         0
>  #define TASK_MOVE_GROUP                1
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         void (*task_change_group)(struct task_struct *p, int type);
>  #endif
> +
> +       void (*task_dead)(struct task_struct *p);
>  };
>
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
> @@ -2177,6 +2183,22 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
>  static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  #endif /* CONFIG_CPU_FREQ */
>
> +/**
> + * uclamp_none: default value for a clamp
> + *
> + * This returns the default value for each clamp
> + * - 0 for a min utilization clamp
> + * - SCHED_CAPACITY_SCALE for a max utilization clamp
> + *
> + * Return: the default value for a given utilization clamp
> + */
> +static inline unsigned int uclamp_none(int clamp_id)
> +{
> +       if (clamp_id == UCLAMP_MIN)
> +               return 0;
> +       return SCHED_CAPACITY_SCALE;
> +}
> +
>  #ifdef arch_scale_freq_capacity
>  # ifndef arch_scale_freq_invariant
>  #  define arch_scale_freq_invariant()  true
> --
> 2.18.0
>

Thanks,
Suren.
