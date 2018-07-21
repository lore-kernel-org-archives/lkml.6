Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4613EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D193D20862
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qK+HvjHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D193D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeGUEHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 00:07:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33035 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeGUEHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 00:07:12 -0400
Received: by mail-io0-f195.google.com with SMTP id z20-v6so11458347iol.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rXZA2FtjTWcYisMR8lG1Ps03rsNi4SqqoYIFHjCmx50=;
        b=qK+HvjHGufx8puFC/7ac7LBhhPDXtnIcZGz4/gXCd+o5nbZQeWP0QqeHP1EsQpHsEw
         La+yWJ23bgL/ZPioKTPuguestcGrvwfij36tt96a+VwTgc9GR3s1suHp1he9vhkB19Lv
         hcW8W2kFiPaWm0GomjU88LJlh4OKhDhIBdP5p2QAdAoj4Bg1b9NRJ/3YXONU0OlIjuE0
         gRNMB9S9mZsrclwB6P/UJLCcQRnbBGud8rMRk5Z8L3VzXZ3WdstGn9MuxTrGOoopA5k4
         Nvj55r8Lr4Io7i5VNjVtkJPTeB5o1zUjwzrDObX8cX25pfUJeA2RGiCw5bU68h8V+fq+
         4SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rXZA2FtjTWcYisMR8lG1Ps03rsNi4SqqoYIFHjCmx50=;
        b=JTHElF33nVzOZcB9KcCL6GIbbVrJkmg6HpAyRrne0dbDtewvCy4wbMF5kOgOQDzNiy
         u8N/YFTtP1cfm+VoA0I0qLxvFsn56u6Xv7kDVvdWaS7A7H3Mpu3/e86NbxEoGy78ubqL
         V4S3kv3n/eFbp6nqwLt5Wt4uqZzTzadvFQHenq7xbdI0/rExjzNrL3sD5U4zWwCG5XK3
         mrxkg0qkG/kbABvN4zauCUPNZYpjbrYgqcrx4HxDlS0iURyux5bpXQisHcY9Cw2Shmz7
         Ow+c/5m0NrgmOFLxcn6JbZZpennJyhqiUqXMfBcqt9xL3ef1FNvLg48RNAc9ZWgIR8Z2
         RdSA==
X-Gm-Message-State: AOUpUlFDZ6kETpUNrm7qcZl2SLTBEJYhvESdQSxnCXCD+RnhjR/8MIhg
        KdA7k/6pQNeKm9++fSeTKF7hcKJ1NuXZ9RChlU8hHw==
X-Google-Smtp-Source: AAOMgpdav5vNAVD9Yuo3X7UEShne0oHysoNTNppADUJQZWDUH8olYizLGEXv5j0CbbJQvmqY9KSlpWVpCT8U8xrkFYc=
X-Received: by 2002:a5e:8341:: with SMTP id y1-v6mr3318365iom.183.1532142967079;
 Fri, 20 Jul 2018 20:16:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 20:16:06
 -0700 (PDT)
In-Reply-To: <CAJuCfpE4FbtrwbXNCjj=pXAvTiTLw7z1aLS4+-28X=y4V+SJ-Q@mail.gmail.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com> <CAJuCfpE4FbtrwbXNCjj=pXAvTiTLw7z1aLS4+-28X=y4V+SJ-Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jul 2018 20:16:06 -0700
Message-ID: <CAJuCfpG4zqxdicVDj6VhFhK33VoPptYHtgPCo=umSe2TT6AX9Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup controller
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

On Fri, Jul 20, 2018 at 7:37 PM, Suren Baghdasaryan <surenb@google.com> wrote:
> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
>> The cgroup's CPU controller allows to assign a specified (maximum)
>> bandwidth to the tasks of a group. However this bandwidth is defined and
>> enforced only on a temporal base, without considering the actual
>> frequency a CPU is running on. Thus, the amount of computation completed
>> by a task within an allocated bandwidth can be very different depending
>> on the actual frequency the CPU is running that task.
>> The amount of computation can be affected also by the specific CPU a
>> task is running on, especially when running on asymmetric capacity
>> systems like Arm's big.LITTLE.
>>
>> With the availability of schedutil, the scheduler is now able
>> to drive frequency selections based on actual task utilization.
>> Moreover, the utilization clamping support provides a mechanism to
>> bias the frequency selection operated by schedutil depending on
>> constraints assigned to the tasks currently RUNNABLE on a CPU.
>>
>> Give the above mechanisms, it is now possible to extend the cpu
>> controller to specify what is the minimum (or maximum) utilization which
>> a task is expected (or allowed) to generate.
>> Constraints on minimum and maximum utilization allowed for tasks in a
>> CPU cgroup can improve the control on the actual amount of CPU bandwidth
>> consumed by tasks.
>>
>> Utilization clamping constraints are useful not only to bias frequency
>> selection, when a task is running, but also to better support certain
>> scheduler decisions regarding task placement. For example, on
>> asymmetric capacity systems, a utilization clamp value can be
>> conveniently used to enforce important interactive tasks on more capable
>> CPUs or to run low priority and background tasks on more energy
>> efficient CPUs.
>>
>> The ultimate goal of utilization clamping is thus to enable:
>>
>> - boosting: by selecting an higher capacity CPU and/or higher execution
>>             frequency for small tasks which are affecting the user
>>             interactive experience.
>>
>> - capping: by selecting more energy efficiency CPUs or lower execution
>>            frequency, for big tasks which are mainly related to
>>            background activities, and thus without a direct impact on
>>            the user experience.
>>
>> Thus, a proper extension of the cpu controller with utilization clamping
>> support will make this controller even more suitable for integration
>> with advanced system management software (e.g. Android).
>> Indeed, an informed user-space can provide rich information hints to the
>> scheduler regarding the tasks it's going to schedule.
>>
>> This patch extends the CPU controller by adding a couple of new
>> attributes, util_min and util_max, which can be used to enforce task's
>> utilization boosting and capping. Specifically:
>>
>> - util_min: defines the minimum utilization which should be considered,
>>             e.g. when schedutil selects the frequency for a CPU while a
>>             task in this group is RUNNABLE.
>>             i.e. the task will run at least at a minimum frequency which
>>                 corresponds to the min_util utilization
>>
>> - util_max: defines the maximum utilization which should be considered,
>>             e.g. when schedutil selects the frequency for a CPU while a
>>             task in this group is RUNNABLE.
>>             i.e. the task will run up to a maximum frequency which
>>                 corresponds to the max_util utilization
>>
>> These attributes:
>>
>> a) are available only for non-root nodes, both on default and legacy
>>    hierarchies
>> b) do not enforce any constraints and/or dependency between the parent
>>    and its child nodes, thus relying on the delegation model and
>>    permission settings defined by the system management software
>> c) allow to (eventually) further restrict task-specific clamps defined
>>    via sched_setattr(2)
>>
>> This patch provides the basic support to expose the two new attributes
>> and to validate their run-time updates.
>>
>> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Joel Fernandes <joelaf@google.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-pm@vger.kernel.org
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  25 ++++
>>  init/Kconfig                            |  22 +++
>>  kernel/sched/core.c                     | 186 ++++++++++++++++++++++++
>>  kernel/sched/sched.h                    |   5 +
>>  4 files changed, 238 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 8a2c52d5c53b..328c011cc105 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -904,6 +904,12 @@ controller implements weight and absolute bandwidth limit models for
>>  normal scheduling policy and absolute bandwidth allocation model for
>>  realtime scheduling policy.
>>
>> +Cycles distribution is based, by default, on a temporal base and it
>> +does not account for the frequency at which tasks are executed.
>> +The (optional) utilization clamping support allows to enforce a minimum
>> +bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
>> +which should never be exceeded by a CPU.
>> +
>>  WARNING: cgroup2 doesn't yet support control of realtime processes and
>>  the cpu controller can only be enabled when all RT processes are in
>>  the root cgroup.  Be aware that system management software may already
>> @@ -963,6 +969,25 @@ All time durations are in microseconds.
>>         $PERIOD duration.  "max" for $MAX indicates no limit.  If only
>>         one number is written, $MAX is updated.
>>
>> +  cpu.util_min
>> +        A read-write single value file which exists on non-root cgroups.
>> +        The default is "0", i.e. no bandwidth boosting.
>> +
>> +        The minimum utilization in the range [0, 1023].
>> +
>> +        This interface allows reading and setting minimum utilization clamp
>> +        values similar to the sched_setattr(2). This minimum utilization
>> +        value is used to clamp the task specific minimum utilization clamp.
>> +
>> +  cpu.util_max
>> +        A read-write single value file which exists on non-root cgroups.
>> +        The default is "1023". i.e. no bandwidth clamping
>> +
>> +        The maximum utilization in the range [0, 1023].
>> +
>> +        This interface allows reading and setting maximum utilization clamp
>> +        values similar to the sched_setattr(2). This maximum utilization
>> +        value is used to clamp the task specific maximum utilization clamp.
>>
>>  Memory
>>  ------
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 0a377ad7c166..d7e2b74637ff 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -792,6 +792,28 @@ config RT_GROUP_SCHED
>>
>>  endif #CGROUP_SCHED
>>
>> +config UCLAMP_TASK_GROUP
>> +       bool "Utilization clamping per group of tasks"
>> +       depends on CGROUP_SCHED
>> +       depends on UCLAMP_TASK
>> +       default n
>> +       help
>> +         This feature enables the scheduler to track the clamped utilization
>> +         of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
>> +
>> +         When this option is enabled, the user can specify a min and max
>> +         CPU bandwidth which is allowed for each single task in a group.
>> +         The max bandwidth allows to clamp the maximum frequency a task
>> +         can use, while the min bandwidth allows to define a minimum
>> +         frequency a task will always use.
>> +
>> +         When task group based utilization clamping is enabled, an eventually
>> +          specified task-specific clamp value is constrained by the cgroup
>> +         specified clamp value. Both minimum and maximum task clamping cannot
>> +          be bigger than the corresponding clamping defined at task group level.
>> +
>> +         If in doubt, say N.
>> +
>>  config CGROUP_PIDS
>>         bool "PIDs controller"
>>         help
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0cb6e0aa4faa..30b1d894f978 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1227,6 +1227,74 @@ static inline int uclamp_group_get(struct task_struct *p,
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> +/**
>> + * init_uclamp_sched_group: initialize data structures required for TG's
>> + *                          utilization clamping
>> + */
>> +static inline void init_uclamp_sched_group(void)
>> +{
>> +       struct uclamp_map *uc_map;
>> +       struct uclamp_se *uc_se;
>> +       int group_id;
>> +       int clamp_id;
>> +
>> +       /* Root TG's is statically assigned to the first clamp group */
>> +       group_id = 0;
>> +
>> +       /* Initialize root TG's to default (none) clamp values */
>> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>> +               uc_map = &uclamp_maps[clamp_id][0];
>> +
>> +               /* Map root TG's clamp value */
>> +               uclamp_group_init(clamp_id, group_id, uclamp_none(clamp_id));
>> +
>> +               /* Init root TG's clamp group */
>> +               uc_se = &root_task_group.uclamp[clamp_id];
>> +               uc_se->value = uclamp_none(clamp_id);
>> +               uc_se->group_id = group_id;
>> +
>> +               /* Attach root TG's clamp group */
>> +               uc_map[group_id].se_count = 1;
>> +       }
>> +}
>> +
>> +/**
>> + * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
>> + * @tg: the newly created task group
>> + * @parent: its parent task group
>> + *
>> + * A newly created task group inherits its utilization clamp values, for all
>> + * clamp indexes, from its parent task group.
>> + * This ensures that its values are properly initialized and that the task
>> + * group is accounted in the same parent's group index.
>> + *
>> + * Return: !0 on error
>> + */
>> +static inline int alloc_uclamp_sched_group(struct task_group *tg,
>> +                                          struct task_group *parent)
>> +{
>> +       struct uclamp_se *uc_se;
>> +       int clamp_id;
>> +
>> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>> +               uc_se = &tg->uclamp[clamp_id];
>> +
>> +               uc_se->value = parent->uclamp[clamp_id].value;
>> +               uc_se->group_id = UCLAMP_NONE;
>> +       }
>> +
>> +       return 1;
>> +}
>> +#else /* CONFIG_UCLAMP_TASK_GROUP */
>> +static inline void init_uclamp_sched_group(void) { }
>> +static inline int alloc_uclamp_sched_group(struct task_group *tg,
>> +                                          struct task_group *parent)
>> +{
>> +       return 1;
>> +}
>> +#endif /* CONFIG_UCLAMP_TASK_GROUP */
>> +
>>  static inline int __setscheduler_uclamp(struct task_struct *p,
>>                                         const struct sched_attr *attr)
>>  {
>> @@ -1289,11 +1357,18 @@ static void __init init_uclamp(void)
>>                         raw_spin_lock_init(&uc_map[group_id].se_lock);
>>                 }
>>         }
>> +
>> +       init_uclamp_sched_group();
>>  }
>>
>>  #else /* CONFIG_UCLAMP_TASK */
>>  static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
>>  static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
>> +static inline int alloc_uclamp_sched_group(struct task_group *tg,
>> +                                          struct task_group *parent)
>> +{
>> +       return 1;
>> +}
>>  static inline int __setscheduler_uclamp(struct task_struct *p,
>>                                         const struct sched_attr *attr)
>>  {
>> @@ -6890,6 +6965,9 @@ struct task_group *sched_create_group(struct task_group *parent)
>>         if (!alloc_rt_sched_group(tg, parent))
>>                 goto err;
>>
>> +       if (!alloc_uclamp_sched_group(tg, parent))
>> +               goto err;
>> +
>>         return tg;
>>
>>  err:
>> @@ -7110,6 +7188,88 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>>                 sched_move_task(task);
>>  }
>>
>> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> +static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
>> +                                 struct cftype *cftype, u64 min_value)
>> +{
>> +       struct task_group *tg;
>> +       int ret = -EINVAL;
>> +
>> +       if (min_value > SCHED_CAPACITY_SCALE)
>> +               return -ERANGE;
>> +
>> +       mutex_lock(&uclamp_mutex);
>> +       rcu_read_lock();
>> +
>> +       tg = css_tg(css);
>> +       if (tg->uclamp[UCLAMP_MIN].value == min_value) {
>> +               ret = 0;
>> +               goto out;
>> +       }
>> +       if (tg->uclamp[UCLAMP_MAX].value < min_value)
>> +               goto out;
>> +
>
> + tg->uclamp[UCLAMP_MIN].value = min_value;
> + ret = 0;
>
> Are these assignments missing or am I missing something? Same for
> cpu_util_max_write_u64().
>

Ah, I see the assignments now in [9/12] patch...

>> +out:
>> +       rcu_read_unlock();
>> +       mutex_unlock(&uclamp_mutex);
>> +
>> +       return ret;
>> +}
>> +
>> +static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>> +                                 struct cftype *cftype, u64 max_value)
>> +{
>> +       struct task_group *tg;
>> +       int ret = -EINVAL;
>> +
>> +       if (max_value > SCHED_CAPACITY_SCALE)
>> +               return -ERANGE;
>> +
>> +       mutex_lock(&uclamp_mutex);
>> +       rcu_read_lock();
>> +
>> +       tg = css_tg(css);
>> +       if (tg->uclamp[UCLAMP_MAX].value == max_value) {
>> +               ret = 0;
>> +               goto out;
>> +       }
>> +       if (tg->uclamp[UCLAMP_MIN].value > max_value)
>> +               goto out;
>> +
>> +out:
>> +       rcu_read_unlock();
>> +       mutex_unlock(&uclamp_mutex);
>> +
>> +       return ret;
>> +}
>> +
>> +static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
>> +                                 enum uclamp_id clamp_id)
>> +{
>> +       struct task_group *tg;
>> +       u64 util_clamp;
>> +
>> +       rcu_read_lock();
>> +       tg = css_tg(css);
>> +       util_clamp = tg->uclamp[clamp_id].value;
>> +       rcu_read_unlock();
>> +
>> +       return util_clamp;
>> +}
>> +
>> +static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
>> +                                struct cftype *cft)
>> +{
>> +       return cpu_uclamp_read(css, UCLAMP_MIN);
>> +}
>> +
>> +static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
>> +                                struct cftype *cft)
>> +{
>> +       return cpu_uclamp_read(css, UCLAMP_MAX);
>> +}
>> +#endif /* CONFIG_UCLAMP_TASK_GROUP */
>> +
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>  static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
>>                                 struct cftype *cftype, u64 shareval)
>> @@ -7437,6 +7597,18 @@ static struct cftype cpu_legacy_files[] = {
>>                 .read_u64 = cpu_rt_period_read_uint,
>>                 .write_u64 = cpu_rt_period_write_uint,
>>         },
>> +#endif
>> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> +       {
>> +               .name = "util_min",
>> +               .read_u64 = cpu_util_min_read_u64,
>> +               .write_u64 = cpu_util_min_write_u64,
>> +       },
>> +       {
>> +               .name = "util_max",
>> +               .read_u64 = cpu_util_max_read_u64,
>> +               .write_u64 = cpu_util_max_write_u64,
>> +       },
>>  #endif
>>         { }     /* Terminate */
>>  };
>> @@ -7604,6 +7776,20 @@ static struct cftype cpu_files[] = {
>>                 .seq_show = cpu_max_show,
>>                 .write = cpu_max_write,
>>         },
>> +#endif
>> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> +       {
>> +               .name = "util_min",
>> +               .flags = CFTYPE_NOT_ON_ROOT,
>> +               .read_u64 = cpu_util_min_read_u64,
>> +               .write_u64 = cpu_util_min_write_u64,
>> +       },
>> +       {
>> +               .name = "util_max",
>> +               .flags = CFTYPE_NOT_ON_ROOT,
>> +               .read_u64 = cpu_util_max_read_u64,
>> +               .write_u64 = cpu_util_max_write_u64,
>> +       },
>>  #endif
>>         { }     /* terminate */
>>  };
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 7e4f10c507b7..1471a23e8f57 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -389,6 +389,11 @@ struct task_group {
>>  #endif
>>
>>         struct cfs_bandwidth    cfs_bandwidth;
>> +
>> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> +       struct                  uclamp_se uclamp[UCLAMP_CNT];
>> +#endif
>> +
>>  };
>>
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>> --
>> 2.17.1
>>
