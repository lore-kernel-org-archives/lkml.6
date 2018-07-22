Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 03:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA0520849
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 03:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7/HNMDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA0520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeGVEND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 00:13:03 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44233 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeGVENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 00:13:02 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so12937473ioh.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F7xzUz2V1pBj98eAwU5jKeWQv0TkaPXyeRst1taGrrc=;
        b=L7/HNMDNcEIra9Ckke+8MpWC/GakpkFxo8rxf8ir3utpu8BpdMvSP6q8GGo9/yRMVJ
         C88R4d1j5TAmFWZ6ZLsuKX9BIAwAH/kj1NpbnEVzTUOc0Pefcxyxrf85oGiyvo2fS9un
         P2F0DV93CcfzYa++0Ygl1BdyFbnGivNXm/5rBrkIcMCQhuk7I8CPfOxRO5IN/2MHzXpM
         XIZns9YHHSaKQeQIx6WrUX1XvI/GVQDgN1eFKO0LEyWIElXv4S48gVbV2g7h2p+hJW7M
         3/rTMWIJ5ysHyghly2gmeU8CVR+hLt3xV/VrTwy0dbTXlaPamudkhnAGWY7al/Eb6NWn
         biXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F7xzUz2V1pBj98eAwU5jKeWQv0TkaPXyeRst1taGrrc=;
        b=bHFGYxBRSb0APbQQMWuaWj51p45DsC7fC+hbDIfRyQYtyuaeH3UVYMuLbbT9hGhSxQ
         /V96F5BORwaiiFbCs7meho47RwF3YFYU9uRdj/SqbNoJ4HlJ4fRU4RAlhjE2M4rlTI12
         qqOKNE8u6EONh/D0dIil5lnpP/xRhfzx3Na0YX02S0bQBl+YP2F7vMslRf2nM7cnmgaV
         NO+dJ2HYF1/OfXn4rN8K3zCOwXLkBiMpuGL0bqjOTgzSNP4A3XtY6hOXV4BcoE+21lRZ
         8w7FP4OCVWrrFBjCACLClp8V/C58o9B4GFFSvG+sMWal4XfGnH1zQUwVJSNikVVdT1NS
         a+NQ==
X-Gm-Message-State: AOUpUlFoM0A73YFhyq33KO9/omsO04X80rs4A6XFyrINVrSQnR/dMsU3
        XMm29zj33RwvliPHAd+Dnm7esTgPXcaOG6BSQvwyhOBf
X-Google-Smtp-Source: AAOMgpcQD6hfqNAIPsf4MtJ4COkJYLiW5rbMBzjk8Ow30gpvxkUhrvqLneHwmh5eWs4Py1LIQUspmuEWkPZLKNF9lhQ=
X-Received: by 2002:a6b:fb04:: with SMTP id h4-v6mr6512340iog.193.1532229478659;
 Sat, 21 Jul 2018 20:17:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 20:17:57
 -0700 (PDT)
In-Reply-To: <20180716082906.6061-12-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com> <20180716082906.6061-12-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 21 Jul 2018 20:17:57 -0700
Message-ID: <CAJuCfpFdxG=1hELqg4MQoKfRCTDCGCkuvkRS=QdYAjdkU=r_8Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] sched/core: uclamp: update CPU's refcount on
 TG's clamp changes
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

On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> When a task group refcounts a new clamp group, we need to ensure that
> the new clamp values are immediately enforced to all its tasks which are
> currently RUNNABLE. This is to ensure that all currently RUNNABLE task

tasks

> are boosted and/or clamped as requested as soon as possible.
>
> Let's ensure that, whenever a new clamp group is refcounted by a task
> group, all its RUNNABLE tasks are correctly accounted in their
> respective CPUs. We do that by slightly refactoring uclamp_group_get()
> to get an additional parameter *cgroup_subsys_state which, when
> provided, it's used to walk the list of tasks in the correspond TGs and

corresponding TGs

> update the RUNNABLE ones.
>
> This is a "brute force" solution which allows to reuse the same refcount
> update code already used by the per-task API. That's also the only way
> to ensure a prompt enforcement of new clamp constraints on RUNNABLE
> tasks, as soon as a task group attribute is tweaked.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/core.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 50613d3d5b83..42cff5ffddae 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1198,21 +1198,43 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
>         raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
>  }
>
> +static inline void uclamp_group_get_tg(struct cgroup_subsys_state *css,
> +                                      int clamp_id, unsigned int group_id)
> +{
> +       struct css_task_iter it;
> +       struct task_struct *p;
> +
> +       /* Update clamp groups for RUNNABLE tasks in this TG */
> +       css_task_iter_start(css, 0, &it);
> +       while ((p = css_task_iter_next(&it)))
> +               uclamp_task_update_active(p, clamp_id, group_id);
> +       css_task_iter_end(&it);
> +}
> +
>  /**
>   * uclamp_group_get: increase the reference count for a clamp group
>   * @p: the task which clamp value must be tracked
> - * @clamp_id: the clamp index affected by the task
> - * @uc_se: the utilization clamp data for the task
> - * @clamp_value: the new clamp value for the task
> + * @css: the task group which clamp value must be tracked
> + * @clamp_id: the clamp index affected by the task (group)
> + * @uc_se: the utilization clamp data for the task (group)
> + * @clamp_value: the new clamp value for the task (group)
>   *
>   * Each time a task changes its utilization clamp value, for a specified clamp
>   * index, we need to find an available clamp group which can be used to track
>   * this new clamp value. The corresponding clamp group index will be used by
>   * the task to reference count the clamp value on CPUs while enqueued.
>   *
> + * When the cgroup's cpu controller utilization clamping support is enabled,
> + * each task group has a set of clamp values which are used to restrict the
> + * corresponding task specific clamp values.
> + * When a clamp value for a task group is changed, all the (active) tasks
> + * belonging to that task group must be update to ensure they are refcounting

must be updated

> + * the correct CPU's clamp value.
> + *
>   * Return: -ENOSPC if there are no available clamp groups, 0 on success.
>   */
>  static inline int uclamp_group_get(struct task_struct *p,
> +                                  struct cgroup_subsys_state *css,
>                                    int clamp_id, struct uclamp_se *uc_se,
>                                    unsigned int clamp_value)
>  {
> @@ -1240,6 +1262,10 @@ static inline int uclamp_group_get(struct task_struct *p,
>         uc_map[next_group_id].se_count += 1;
>         raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
>
> +       /* Newly created TG don't have tasks assigned */
> +       if (css)
> +               uclamp_group_get_tg(css, clamp_id, next_group_id);
> +
>         /* Update CPU's clamp group refcounts of RUNNABLE task */
>         if (p)
>                 uclamp_task_update_active(p, clamp_id, next_group_id);
> @@ -1307,7 +1333,7 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
>                 uc_se->value = parent->uclamp[clamp_id].value;
>                 uc_se->group_id = UCLAMP_NONE;
>
> -               if (uclamp_group_get(NULL, clamp_id, uc_se,
> +               if (uclamp_group_get(NULL, NULL, clamp_id, uc_se,
>                                      parent->uclamp[clamp_id].value)) {
>                         ret = 0;
>                         goto out;
> @@ -1362,12 +1388,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
>
>         /* Update min utilization clamp */
>         uc_se = &p->uclamp[UCLAMP_MIN];
> -       retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
> +       retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se,
>                                    attr->sched_util_min);
>
>         /* Update max utilization clamp */
>         uc_se = &p->uclamp[UCLAMP_MAX];
> -       retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
> +       retval |= uclamp_group_get(p, NULL, UCLAMP_MAX, uc_se,
>                                    attr->sched_util_max);
>
>         mutex_unlock(&uclamp_mutex);
> @@ -7274,7 +7300,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
>
>         /* Update TG's reference count */
>         uc_se = &tg->uclamp[UCLAMP_MIN];
> -       ret = uclamp_group_get(NULL, UCLAMP_MIN, uc_se, min_value);
> +       ret = uclamp_group_get(NULL, css, UCLAMP_MIN, uc_se, min_value);
>
>  out:
>         rcu_read_unlock();
> @@ -7306,7 +7332,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>
>         /* Update TG's reference count */
>         uc_se = &tg->uclamp[UCLAMP_MAX];
> -       ret = uclamp_group_get(NULL, UCLAMP_MAX, uc_se, max_value);
> +       ret = uclamp_group_get(NULL, css, UCLAMP_MAX, uc_se, max_value);
>
>  out:
>         rcu_read_unlock();
> --
> 2.17.1
>
