Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB96ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F71020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q01SX9bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F71020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJYTPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:15:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39558 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:15:47 -0400
Received: by mail-it1-f194.google.com with SMTP id m15so1119056itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcVRZvIVQC32u59oN03YXMK2/wRYTY9sub/BrtrSqYk=;
        b=Q01SX9bR8tys7Vh6HSEXjDl55m/geDdk7nR20jyJOZpgfKBN8hFlaYVdBNrH/dH8G4
         5uZfSfELXhbJfAyuao3Ufc3dgK1DbNti3vc98uCqeij4ONUMFSVDDAMKtQDKSdo8z7Fg
         4bLwn8L+GemJoj8BMk0Iths9eWCaFG5HUrw84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcVRZvIVQC32u59oN03YXMK2/wRYTY9sub/BrtrSqYk=;
        b=Q2vP9bCvfRqIjyBPpJQUrsrPrDku4k323XkCSLMCBZ9YWHsSJmssNORvIIQF95zOVc
         6nEPlfFgbEfT/zQJUxaaAZYKx195vVR3cfnflVOVMq6F+IMQC5tO8B3hC1cdZAEEx+Q0
         qGsFzzXIp5Ugg8dwMFOL9pqeV3UFb6NKHSnAOO9oK3s0gCI8e86ymtivjh1krQW8LuHn
         4Ty8JTZNKrA5UozQsnG6Yc+gv+Jj5f2m1u3NY4gDW3xLQoEGdb+U3BNPYh0wNzH+ZRNs
         3M471AkBDqO5pV+9L53xdLl28VUXXBeSSErHSk7fMb36gB1zyCzXLr5SN/nacoaefKn/
         K6aw==
X-Gm-Message-State: AGRZ1gKnBqB8/UUPkmM6ldLx2lnF1+xKFv/ucUmNiXRst2USzfHeqzpp
        eFIPqTVyF7PnLKSQRgWy8LFIbgJ4GT22Sjfx5CCJDg==
X-Google-Smtp-Source: AJdET5c5/vclVCLIBdWawz9Jju89Fy6RTsTvgikuSTk33nHS+ka93AWaO7xMhPB5Wcpge4Ng1WK7OHgUr1Q3b/2iKLs=
X-Received: by 2002:a24:670a:: with SMTP id u10-v6mr595288itc.114.1540464215667;
 Thu, 25 Oct 2018 03:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org> <43b126ab-403b-3fb3-5951-45a107e4a14b@arm.com>
In-Reply-To: <43b126ab-403b-3fb3-5951-45a107e4a14b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Oct 2018 12:43:23 +0200
Message-ID: <CAKfTPtCypUSMu8JG_tdqwK4EnAjCbunDXzJvsPwBjqm+D5iG9g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 at 12:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Hi Vincent,
>
> On 10/19/18 6:17 PM, Vincent Guittot wrote:
> > The current implementation of load tracking invariance scales the
> > contribution with current frequency and uarch performance (only for
> > utilization) of the CPU. One main result of this formula is that the
> > figures are capped by current capacity of CPU. Another one is that the
> > load_avg is not invariant because not scaled with uarch.
> >
> > The util_avg of a periodic task that runs r time slots every p time slots
> > varies in the range :
> >
> >      U * (1-y^r)/(1-y^p) * y^i < Utilization < U * (1-y^r)/(1-y^p)
> >
> > with U is the max util_avg value = SCHED_CAPACITY_SCALE
> >
> > At a lower capacity, the range becomes:
> >
> >      U * C * (1-y^r')/(1-y^p) * y^i' < Utilization <  U * C * (1-y^r')/(1-y^p)
> >
> > with C reflecting the compute capacity ratio between current capacity and
> > max capacity.
> >
> > so C tries to compensate changes in (1-y^r') but it can't be accurate.
> >
> > Instead of scaling the contribution value of PELT algo, we should scale the
> > running time. The PELT signal aims to track the amount of computation of
> > tasks and/or rq so it seems more correct to scale the running time to
> > reflect the effective amount of computation done since the last update.
> >
> > In order to be fully invariant, we need to apply the same amount of
> > running time and idle time whatever the current capacity. Because running
> > at lower capacity implies that the task will run longer, we have to ensure
> > that the same amount of idle time will be apply when system becomes idle
> > and no idle time has been "stolen". But reaching the maximum utilization
> > value (SCHED_CAPACITY_SCALE) means that the task is seen as an
> > always-running task whatever the capacity of the CPU (even at max compute
> > capacity). In this case, we can discard this "stolen" idle times which
> > becomes meaningless.
> >
> > In order to achieve this time scaling, a new clock_pelt is created per rq.
> > The increase of this clock scales with current capacity when something
> > is running on rq and synchronizes with clock_task when rq is idle. With
> > this mecanism, we ensure the same running and idle time whatever the
> > current capacity. This also enables to simplify the pelt algorithm by
> > removing all references of uarch and frequency and applying the same
> > contribution to utilization and loads. Furthermore, the scaling is done
> > only once per update of clock (update_rq_clock_task()) instead of during
> > each update of sched_entities and cfs/rt/dl_rq of the rq like the current
> > implementation. This is interesting when cgroup are involved as shown in
> > the results below:
>
> I have a couple of questions related to the tests you ran.
>
> > On a hikey (octo ARM platform).
> > Performance cpufreq governor and only shallowest c-state to remove variance
> > generated by those power features so we only track the impact of pelt algo.
>
> So you disabled c-state 'cpu-sleep' and 'cluster-sleep'?

yes

>
> I get 'hisi_thermal f7030700.tsensor: THERMAL ALARM: 66385 > 65000' on
> my hikey620. Did you change the thermal configuration? Not sure if there
> are any actions attached to this warning though.

I have a fan to ensure that no thermal mitigation will bias the measurement.

>
> > each test runs 16 times
> >
> > ./perf bench sched pipe
> > (higher is better)
> > kernel        tip/sched/core     + patch
> >          ops/seconds        ops/seconds         diff
> > cgroup
> > root    59648(+/- 0.13%)   59785(+/- 0.24%)    +0.23%
> > level1  55570(+/- 0.21%)   56003(+/- 0.24%)    +0.78%
> > level2  52100(+/- 0.20%)   52788(+/- 0.22%)    +1.32%
> >
> > hackbench -l 1000
>
> Shouldn't this be '-l 100'?

I have re checked and it's -l 1000

>
> > (lower is better)
> > kernel        tip/sched/core     + patch
> >          duration(sec)      duration(sec)        diff
> > cgroup
> > root    4.472(+/- 1.86%)   4.346(+/- 2.74%)     -2.80%
> > level1  5.039(+/- 11.05%)  4.662(+/- 7.57%)     -7.47%
> > level2  5.195(+/- 10.66%)  4.877(+/- 8.90%)     -6.12%
> >
> > The responsivness of PELT is improved when CPU is not running at max
> > capacity with this new algorithm. I have put below some examples of
> > duration to reach some typical load values according to the capacity of the
> > CPU with current implementation and with this patch.
> >
> > Util (%)     max capacity  half capacity(mainline)  half capacity(w/ patch)
> > 972 (95%)    138ms         not reachable            276ms
> > 486 (47.5%)  30ms          138ms                     60ms
> > 256 (25%)    13ms           32ms                     26ms
>
> Could you describe these testcases in more detail?

You don't need to run test case. These numbers are computed based on
geometric series and half period value

>
> So I assume you run one 100% task (possibly pinned to one CPU) on your
> hikey620 with userspace governor and for:
>
>   (1) max capacity:
>
>   echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
>
>   (2) half capacity:
>
>   echo 729000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
>
> and then you measure the time till t1 reaches 25%, 47.5% and 95%
> utilization?
> What's the initial utilization value of t1? I assume t1 starts with
> utilization=512 (post_init_entity_util_avg()).
>
> > On my hikey (octo ARM platform) with schedutil governor, the time to reach
> > max OPP when starting from a null utilization, decreases from 223ms with
> > current scale invariance down to 121ms with the new algorithm. For this
> > test, I have enable arch_scale_freq for arm64.
>
> Isn't the arch-specific arch_scale_freq_capacity() enabled by default on
> arm64 with cpufreq support?

Yes. that's a remain of previous version when arch_scale_freq was not yet merged

>
> I would like to run the same tests so we can discuss results more easily.

Let me know if you need more details
