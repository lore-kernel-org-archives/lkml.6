Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDC9CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB2220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eyhe+ECF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB2220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755998AbeFOMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:18:30 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34259 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbeFOMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:18:29 -0400
Received: by mail-io0-f193.google.com with SMTP id e15-v6so10546448iog.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QI23K3MQIWIkBpRtZgEElxW3HPLq3P5GD5fVYLDiHME=;
        b=eyhe+ECFSeMR3NU8x2abTxpEbw4A4FPr1B+24NM3VMdRy1B8u3CA+cdtFr7Tx0Zu7u
         D7nWj43HIIBZeg1wyw2jLvgwZBdG/a3XhAqenVb+qLM3lzw5pD1wtCyTTY2TpVAGw6J1
         ve1WIzdljbgilaJVp2jLYI1ey+QHJS2cIkDWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QI23K3MQIWIkBpRtZgEElxW3HPLq3P5GD5fVYLDiHME=;
        b=FxnENPraDqXGGcHEQbLWzHdSV/A3p++NAO9IrPfEQecItA5Tq2u1aPgPUewRwe8yaX
         b6zudlhBg86PzLC/kYiiglyudTsuHY1USpSnuAMxbKHVzZIT2grli1DqgNwmzswD1Zkk
         jldtKKlM/T3494IdxZDjM15rfMmRHrdSmA0I61pl2hU5t7EB8Can3F5t0ugZcmuZYDnJ
         3PJSmYXsikRYwqfZ3IwvRtTRkPEglOS5CC4UiSDl8jurPQz+YAxy6yttlTmIIuT5set8
         hBLJcRS818uOTVrVAGKbjG4wE+CgLpvmMh6B03436vtgAGOcH3/D3mYQtsIuoaCyfybg
         3z8w==
X-Gm-Message-State: APt69E1z09mgcu1KVlRi7Rj4KR771nt62/wg/q3V9xuEvWTexOCeZiJY
        IiGdG0+ImBfyz3WCq571dLG1sBg9geZz3RhMP9P7yA==
X-Google-Smtp-Source: ADUXVKKeSo03hjaPV4bY2taGpt7SIZVsi/i839NncbcjafIE+MpUZ+I+I3EalAmbyKoJJ3ccjofz653/okmygmeAAkY=
X-Received: by 2002:a6b:1884:: with SMTP id 126-v6mr1179510ioy.183.1529065108277;
 Fri, 15 Jun 2018 05:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:304a:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 05:18:07
 -0700 (PDT)
In-Reply-To: <00f701a4-8ea6-82cb-6c76-5597ffcc9f11@arm.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-4-git-send-email-vincent.guittot@linaro.org> <00f701a4-8ea6-82cb-6c76-5597ffcc9f11@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Jun 2018 14:18:07 +0200
Message-ID: <CAKfTPtBHL0PEhqvpjH2wQmi7SasHyB0UfJsTQFx6e-3rAiDoVA@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] sched/rt: add rt_rq utilization tracking
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 15 June 2018 at 13:52, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 06/08/2018 02:09 PM, Vincent Guittot wrote:
>> schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
>> tasks are running. When the CPU is overloaded by cfs and rt tasks, cfs tasks
>> are preempted by rt tasks and in this case util_avg reflects the remaining
>> capacity but not what cfs want to use. In such case, schedutil can select a
>> lower OPP whereas the CPU is overloaded. In order to have a more accurate
>> view of the utilization of the CPU, we track the utilization of rt tasks.
>>
>> rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
>> the same at the root group level, so the PELT windows of the util_sum are
>> aligned.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> [...]
>
> ;
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index 4174582..81c0d7e 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -307,3 +307,25 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
>>
>>       return 0;
>>   }
>> +
>> +/*
>> + * rt_rq:
>> + *
>> + *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
>> + *   util_sum = cpu_scale * load_sum
>> + *   runnable_load_sum = load_sum
>> + *
>> + */
>> +
>> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
>> +{
>> +     if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
>> +                             running,
>> +                             running,
>> +                             running)) {
>
> The patch clearly says that this is about utilization but what happens
> to load and runnable load for the rt rq part when you call
> ___update_load_sum() with load=[0,1] and runnable=[0,1]?

I would say the same than what happens for se which has
___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
cfs_rq->curr == se))

>
> It looks like that the math would require 1024 instead of 1 for load and
> runnable so that we would see a load_avg or runnable_load_avg != 0.

why does it require 1024 ? the min  weight of a task is 15 and the min
share of a sched group is 2. AFAICT, there is no requirement mainly
because we are not using them as they will not give any additional
information compare to util_avg

>
> 1594.075128: bprint: update_rt_rq_load_avg: now=1593937228087 cpu=4 running=1
> 1594.075129: bprint: update_rt_rq_load_avg: delta=3068 cpu=4 load=1 runnable=1 running=1 scale_freq=1024 scale_cpu=1024 periods=2
> 1594.075130: bprint: update_rt_rq_load_avg: load_sum=23927 +2879 runnable_load_sum=23927 +2879 util_sum=24506165 +2948096
> 1594.075130: bprint: update_rt_rq_load_avg: load_avg=0 runnable_load_avg=0 util_avg=513
>
> IMHO, the patch should say whether load and runnable load are supported as well or not.

Although it is stated that we track only utilization , i can probably
mentioned clearly that load_avg and runnable_load_avg are useless

Vincent
>
> [...]
