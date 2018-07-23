Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B8420852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeYy23pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B8420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbeGWSNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:13:30 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46716 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:13:29 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so1142756ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f4MnpIAcAU9BeI6m4cqes0SWnXUCIOpfmKF8rZl9oJE=;
        b=TeYy23pU+Oq8AMGVAYwsEzZFqIOGPGXqGD3gXYG+eliZV9gkyW1zx7VYxtRQY84DEt
         cPIk3xTKVD44YJr9UfT9XTmrlCJHlDznJI/i7DMWvZFbNN2XY6QzB4p65Kr/7zl4/o2g
         /MdVCiAyApar24XQJcAkBwlzGzqtrkDABIN/WuQ1OFAwt3kXdNjBH/zzvLV+j6ColIHX
         aefhtGPOJ2qo0/oF24ARN7k5AXyOaUQ4o7z8GBhMXfT3KGlWXevB7jnw7k2b0AVbV65S
         436TnSxMBGwKoY59Sr8jIThhuJJVJoi7I68v9WtMYr94oJ7CZymK9WDBAkkILIs+lyzy
         4JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f4MnpIAcAU9BeI6m4cqes0SWnXUCIOpfmKF8rZl9oJE=;
        b=a5wYOMG5zH3ZyXwOXHA2PXGLer216TAJ0WE6JFHJhbIhltTTdCkhSKPM4hpomIouhl
         ujNVh+juxWVLEYth06WUs5MHKM8NFnyzLlAUeLFnnobrQzlcUfrU5HL4O29FTP6dtwDf
         HamHsmFesIctmO706OHIuprO0wjzC/r8A2Hhh2Eja1SSgTOdw52XNJMnSVs7hhUF6BvN
         kqdD77/WQYY3uno13UCJb8XGq3EuHyvHXKdj3Q8KqxTX9vhXgMpDjvXdrd7oDqPJb19r
         mJmZENqwucU+hAAXMbUgfAVN3cQZgf9cjB6YH94dUCE83zp4y+x+fMA/KXTXICPdxlL8
         WG/A==
X-Gm-Message-State: AOUpUlGFBuwsbZfmMU+gARg/TX/lyjsrK/N14y2cElxfRcmA4zKSxD1f
        +s8k+b8o/6nQV5jUYyMiOS6UtKdyYfQSIBlqAJDn1o3Q6rk=
X-Google-Smtp-Source: AAOMgpfY2PRSJL/wkO8mKFvb43oGxDClSGOO/5r39oMh4O2iwqyjM0TjgWEUxZS8ERAOlcq1MGB8UWfrGPRHP0sYu5M=
X-Received: by 2002:a6b:87db:: with SMTP id r88-v6mr11437533ioi.243.1532365878537;
 Mon, 23 Jul 2018 10:11:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 10:11:17
 -0700 (PDT)
In-Reply-To: <20180723154025.GF2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com> <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 <20180723154025.GF2683@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jul 2018 10:11:17 -0700
Message-ID: <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
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

On Mon, Jul 23, 2018 at 8:40 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 21-Jul 20:05, Suren Baghdasaryan wrote:
>> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>> > When a task's util_clamp value is configured via sched_setattr(2), this
>> > value has to be properly accounted in the corresponding clamp group
>> > every time the task is enqueued and dequeued. When cgroups are also in
>> > use, per-task clamp values have to be aggregated to those of the CPU's
>> > controller's Task Group (TG) in which the task is currently living.
>> >
>> > Let's update uclamp_cpu_get() to provide aggregation between the task
>> > and the TG clamp values. Every time a task is enqueued, it will be
>> > accounted in the clamp_group which defines the smaller clamp between the
>> > task specific value and its TG value.
>>
>> So choosing smallest for both UCLAMP_MIN and UCLAMP_MAX means the
>> least boosted value and the most clamped value between syscall and TG
>> will be used.
>
> Right
>
>> My understanding is that boost means "at least this much" and clamp
>> means "at most this much".
>
> Right
>
>> So to satisfy both TG and syscall requirements I think you would
>> need to choose the largest value for UCLAMP_MIN and the smallest one
>> for UCLAMP_MAX, meaning the most boosted and most clamped range.
>> Current implementation choses the least boosted value, so
>> effectively one of the UCLAMP_MIN requirements (either from TG or
>> from syscall) are being ignored...  Could you please clarify why
>> this choice is made?
>
> The TG values are always used to specify a _restriction_ on
> task-specific values.
>
> Thus, if you look or example at the CPU mask for a task, you can have
> a task with affinity to CPUs 0-1, currently running on a cgroup with
> cpuset.cpus=0... then the task can run only on CPU 0 (althought its
> affinity includes CPU1 too).
>
> Same we do here: if a task has util_min=10, but it's running in a
> cgroup with cpu.util_min=0, then it will not be boosted.
>
> IOW, this allows to implement a "nice" policy at task level, where a
> task (via syscall) can decide to be less boosted with respect to its
> group but never more boosted. The same task can also decide to be more
> clamped, but not less clamped then its current group.
>

The fact that boost means "at least this much" to me seems like we can
safely choose higher CPU bandwidth (as long as it's lower than
UCLAMP_MAX) but from your description sounds like TG's UCLAMP_MIN
means "at most this much boost" and it's not safe to use CPU bandwidth
higher than TG's UCLAMP_MIN. So instead of specifying min CPU
bandwidth for a task it specifies the max allowed boost. Seems like a
discrepancy to me but maybe there are compelling usecases when this
behavior is necessary? In that case would be good to spell them out to
explain why this choice is made.

> [...]
>
>> > @@ -982,18 +989,30 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>> >         int clamp_value;
>> >         int group_id;
>> >
>> > -       /* No task specific clamp values: nothing to do */
>> >         group_id = p->uclamp[clamp_id].group_id;
>> > +       clamp_value = p->uclamp[clamp_id].value;
>> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> > +       /* Use TG's clamp value to limit task specific values */
>> > +       if (group_id == UCLAMP_NONE ||
>> > +           clamp_value >= task_group(p)->uclamp[clamp_id].value) {
>>
>> Not a big deal but do you need to override if (clamp_value ==
>> task_group(p)->uclamp[clamp_id].value)? Maybe:
>> -           clamp_value >= task_group(p)->uclamp[clamp_id].value) {
>> +          clamp_value > task_group(p)->uclamp[clamp_id].value) {
>
> Good point, yes... the override is not really changing anything here.
> Will fix this!
>
>> > +               clamp_value = task_group(p)->uclamp[clamp_id].value;
>> > +               group_id = task_group(p)->uclamp[clamp_id].group_id;
>> > +       }
>> > +#else
>> > +       /* No task specific clamp values: nothing to do */
>> >         if (group_id == UCLAMP_NONE)
>> >                 return;
>> > +#endif
>> >
>> >         /* Reference count the task into its current group_id */
>> >         uc_grp = &rq->uclamp.group[clamp_id][0];
>> >         uc_grp[group_id].tasks += 1;
>> >
>> > +       /* Track the effective clamp group */
>> > +       p->uclamp_group_id[clamp_id] = group_id;
>> > +
>> >         /* Force clamp update on idle exit */
>> >         uc_cpu = &rq->uclamp;
>> > -       clamp_value = p->uclamp[clamp_id].value;
>> >         if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
>> >                 if (clamp_id == UCLAMP_MAX)
>> >                         uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
>
> [...]
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
