Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CFECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 01:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B01E20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 01:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6ThI6qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B01E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeGUCOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 22:14:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41654 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeGUCOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 22:14:46 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so11319113ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 18:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3BZcRJeWvcBCYQmfS3G3Oh+DroCNUxj7KQd1G2vJRXU=;
        b=J6ThI6qp7l52p25RzwDFlyFMnBPs4z44TxZoDuT4G4+RTbTLGW+hgdFxLbVlPFZwBc
         OAMur4t+DSDOKGjpGs83JOIHsblBkuyGwir5V/OnPgW1L1kITAziJw5cswrU4p68rq3B
         YOWwXanUA0McApZqgHfd+FJ4NUwMUuz4eGsrxkLXjfjwdpqEzeK93PsVOrOdfpyKIYjK
         6Av66oUgkquAY0P7n5QSFpxSU0e3SvNg0NOZK6+RFMaaIWq4aq0nzObirADye0ouKxcs
         Y0rO9E9Lwldpenl759ag2unyxY1Lr9F86ls3PscP89+EE9XC+2/gJz+IzK8Bs+n6/m6V
         9RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3BZcRJeWvcBCYQmfS3G3Oh+DroCNUxj7KQd1G2vJRXU=;
        b=IOFbz4XfZLgGfDV/ZCqy6GpnW0AN4BuA7Q0vRDrpzW98E3aYn6wINYzTxAGwkWsTDS
         NLXx7DmQ6568ByFaDkBIRrwn4++PjDV8NMeWWOtMgrjFb3wB+MzfVEf3GxjkrR5RR0Z5
         25PpHIhE/2Tyi9Yq73K2ToarZyCA2zmsFaB22uFBMN1D2e3q1uzaGUWkTk8GfgIoIv90
         kvH83VKGsSTf9Qa0IuM9VMrgn8lDRnUpRZTpE63EkhRIPu99ThFswI+tRRCdSXC0klIN
         MQOofcu6F6BWJZ0TKzkVoHwRvwFksF0wH89XUiQqQKmT2mcK9Ps6B9TAUNphxruCRDKo
         C74w==
X-Gm-Message-State: AOUpUlEXWgyRwngCm9cV5n3rBONDvSoXy61VXD8V0eTtLMqdhCRwS6e5
        +Xx/T6fwgbgmj9o7soSKaLqG3FS7aXVnlbN4x2gdeQ==
X-Google-Smtp-Source: AAOMgpcZdIuITYXR8nVrf0kZ5SJHbTuXOJcXPpf13RpFgn/Ze/C5CeFwhiBNMfQZhYwnahFvcXoWicHBvTtGOtBrpEk=
X-Received: by 2002:a6b:87db:: with SMTP id r88-v6mr3585077ioi.243.1532136237738;
 Fri, 20 Jul 2018 18:23:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 18:23:57
 -0700 (PDT)
In-Reply-To: <20180716082906.6061-8-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com> <20180716082906.6061-8-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jul 2018 18:23:57 -0700
Message-ID: <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] sched/core: uclamp: enforce last task UCLAMP_MAX
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

On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> When a util_max clamped task sleeps, its clamp constraints are removed
> from the CPU. However, the blocked utilization on that CPU can still be
> higher than the max clamp value enforced while that task was running.
> This max clamp removal when a CPU is going to be idle could thus allow
> unwanted CPU frequency increases, right while the task is not running.
>
> This can happen, for example, where there is another (smaller) task
> running on a different CPU of the same frequency domain.
> In this case, when we aggregates the utilization of all the CPUs in a

typo: we aggregate

> shared frequency domain, schedutil can still see the full non clamped
> blocked utilization of all the CPUs and thus eventually increase the
> frequency.
>
> Let's fix this by using:
>
>    uclamp_cpu_put_id(UCLAMP_MAX)
>       uclamp_cpu_update(last_clamp_value)
>
> to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
> condition. Thus, while a CPU is idle, we can still enforce the last used
> clamp value for it.
>
> To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
> idle, we don't want to enforce any minimum frequency
> Indeed, we relay just on blocked load decay to smoothly reduce the

typo: We rely

> frequency.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/core.c  | 30 ++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  2 ++
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b2424eea7990..0cb6e0aa4faa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -930,7 +930,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
>   * For the specified clamp index, this method computes the new CPU utilization
>   * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
>   */
> -static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
> +static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
> +                                    unsigned int last_clamp_value)
>  {
>         struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
>         int max_value = UCLAMP_NONE;
> @@ -948,6 +949,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>                 if (max_value >= SCHED_CAPACITY_SCALE)
>                         break;
>         }
> +
> +       /*
> +        * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> +        * task, we keep the CPU clamped to the last task's clamp value.
> +        * This avoids frequency spikes to MAX when one CPU, with an high
> +        * blocked utilization, sleeps and another CPU, in the same frequency
> +        * domain, do not see anymore the clamp on the first CPU.
> +        */
> +       if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NONE) {
> +               rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> +               max_value = last_clamp_value;
> +       }
> +
>         rq->uclamp.value[clamp_id] = max_value;
>  }
>
> @@ -977,13 +991,21 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>         uc_grp = &rq->uclamp.group[clamp_id][0];
>         uc_grp[group_id].tasks += 1;
>
> +       /* Force clamp update on idle exit */
> +       uc_cpu = &rq->uclamp;
> +       clamp_value = p->uclamp[clamp_id].value;
> +       if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {

The condition below is not needed because UCLAMP_FLAG_IDLE is set only
for UCLAMP_MAX clamp_id, therefore the above condition already covers
the one below.

> +               if (clamp_id == UCLAMP_MAX)
> +                       uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
> +               uc_cpu->value[clamp_id] = clamp_value;
> +               return;
> +       }
> +
>         /*
>          * If this is the new max utilization clamp value, then we can update
>          * straight away the CPU clamp value. Otherwise, the current CPU clamp
>          * value is still valid and we are done.
>          */
> -       uc_cpu = &rq->uclamp;
> -       clamp_value = p->uclamp[clamp_id].value;
>         if (uc_cpu->value[clamp_id] < clamp_value)
>                 uc_cpu->value[clamp_id] = clamp_value;
>  }
> @@ -1028,7 +1050,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
>         uc_cpu = &rq->uclamp;
>         clamp_value = uc_grp[group_id].value;
>         if (clamp_value >= uc_cpu->value[clamp_id])
> -               uclamp_cpu_update(rq, clamp_id);
> +               uclamp_cpu_update(rq, clamp_id, clamp_value);
>  }
>
>  /**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1207add36478..7e4f10c507b7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -783,6 +783,8 @@ struct uclamp_group {
>   * values, i.e. no min/max clamping at all.
>   */
>  struct uclamp_cpu {
> +#define UCLAMP_FLAG_IDLE 0x01
> +       int flags;
>         int value[UCLAMP_CNT];
>         struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
>  };
> --
> 2.17.1
>
