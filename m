Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xTeOGSPwGFt6DQAAmS7hNA
	; Thu, 07 Jun 2018 08:44:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 19959607F7; Thu,  7 Jun 2018 08:44:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGCoMFUo"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 51797602FC;
	Thu,  7 Jun 2018 08:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51797602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeFGIou (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:44:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44762 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeFGIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:44:48 -0400
Received: by mail-io0-f195.google.com with SMTP id g7-v6so10885485ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x/yc3VgSUiDw8FCw5qzMeEoZdN4wuSgHn2d7aaWwTT8=;
        b=kGCoMFUoGQVtZFDKid98e33brgysOA9VrOLyu89VmGFWC0Z8cilje/NwIJDkaKRyz8
         Wqfu78+U3LwbqFIGAOGgiwrBmUYWkZ2GtQCZ8NOdFCK1B2TQyWoP5VKJX+ATVFcpWFUo
         w7V9UmFJVy5q624PaetuhmGc0aWIR8wFcdZik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x/yc3VgSUiDw8FCw5qzMeEoZdN4wuSgHn2d7aaWwTT8=;
        b=TEBiAHv/thIWYbKmzSin534iAlYBNlTGKRAkSQ9ccAr+ZbIMTPgQQYmqWXZkhumOkg
         4JzLqMTfhX0RSPkmtWWDLrhMXVBtdf0tZQatiI0MXNAmVTzeWxAaYOtM6xiSU6tCEofW
         ZFy211Udw0KyGcyZPGcLrJkivyH0Ms8L59Cc9Fnpi8qhjJf7zNhA72HsBjQ5qZ3EG1zG
         PjIV4cY5EUqd+ubm2m2L8fhzx8RKv6B9gnrqijxRZllYaW/pjlPTxyjGSO6SNDwtn2T+
         BuGClnbgfwCobVaWS113EskdNexHhDSPxRD+tBsLh6b+mLBV4QHs9G+12vBDF5zYcHyN
         NQCw==
X-Gm-Message-State: APt69E3d74q2mwdtPU3Q0sblxJfyyz7zN3rl91VweSAxG1YxrA5qD1b+
        P0NGRPnEPE/Y46P9PfO3zGBUygosFfx4hXoFtZTGgg==
X-Google-Smtp-Source: ADUXVKJeaNo7DHvggSoNJQMxOcvBent0XtIdZXyngaMIHPHcw5Rb0kJZOaX65fE92r93eYvDP/EARvzg1f8E2KASVV0=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr801035iov.18.1528361087676;
 Thu, 07 Jun 2018 01:44:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:304a:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 01:44:26 -0700 (PDT)
In-Reply-To: <4368a36c-3df4-1454-1837-473e569b9080@arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-8-git-send-email-vincent.guittot@linaro.org>
 <72473e6f-8ade-8e26-3282-276fcae4c4c7@arm.com> <CAKfTPtC8c9sP7TjefZPN2SFuNVGS7Q12WBj3BBYEbJFzxVN-2A@mail.gmail.com>
 <fba5a810-3c3b-dc8b-15fb-8078a591ec2b@arm.com> <CAKfTPtAMf1FUyY-HtziVzZ8JecnKTrQ1LaF60hg6bd=Nv9pCQQ@mail.gmail.com>
 <4368a36c-3df4-1454-1837-473e569b9080@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 7 Jun 2018 10:44:26 +0200
Message-ID: <CAKfTPtCc0pgxnBU4YN5mSxDqfq9k7=qEWE2nDp+MipPNsTwzWw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] sched/irq: add irq utilization tracking
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 June 2018 at 10:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 06/06/2018 06:06 PM, Vincent Guittot wrote:
>>
>> Hi Dietmar,
>>
>> Sorry for the late answer
>>
>> On 31 May 2018 at 18:54, Dietmar Eggemann <dietmar.eggemann@arm.com>
>> wrote:
>>>
>>> On 05/30/2018 08:45 PM, Vincent Guittot wrote:
>>>>
>>>> Hi Dietmar,
>>>>
>>>> On 30 May 2018 at 17:55, Dietmar Eggemann <dietmar.eggemann@arm.com>
>>>> wrote:
>>>>>
>>>>> On 05/25/2018 03:12 PM, Vincent Guittot wrote:
>>>
>>>
>>> [...]
>>>
>>>>>> +        */
>>>>>> +       ret = ___update_load_sum(rq->clock - running, rq->cpu,
>>>>>> &rq->avg_irq,
>>>>>> +                               0,
>>>>>> +                               0,
>>>>>> +                               0);
>>>>>> +       ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
>>>>>> +                               1,
>>>>>> +                               1,
>>>>>> +                               1);
>>>
>>>
>>> Can you not change the function parameter list to the usual
>>> (u64 now, struct rq *rq, int running)?
>>>
>>> Something like this (only compile and boot tested):
>>
>>
>> To be honest, I prefer to keep the specific sequence above in a
>> dedicated function instead of adding it in core code.
>
>
> No big issue.
>
>> Furthermore,  we end up calling call twice ___update_load_avg instead
>> of only once. This will set an intermediate and incorrect value in
>> util_avg and this value can be read in the meantime
>
>
> Can't buy this argument though because this is true with the current
> implementation as well since the 'decay load sum' - 'accrue load sum'
> sequence is not atomic.

it's not a problem that the _sum variable are updated in different
step because there are internal variable
Only util_avg is used "outside" and the latter is updated after both
idle and running steps have been applied

>
> What about calling update_irq_load_avg(rq, 0) in update_rq_clock_task() if
> (irq_delta + steal) eq. 0 and sched_feat(NONTASK_CAPACITY) eq. true in this
> #ifdef CONFIG_XXX_TIME_ACCOUNTING block?

update_irq_load_avg(rq, 0) is called in update_blocked_averages to
decay smoothly like other blocked signals and replace the need to call
update_irq_load_avg(rq, 0) for every call to update_rq_clock_task()
which can be significant

>
> Maintaining a irq/steal time signal makes only sense if at least one of the
> CONFIG_XXX_TIME_ACCOUNTING is set and NONTASK_CAPACITY is true. The call to
> update_irq_load_avg() in update_blocked_averages() isn't guarded my them.

good point

>
> [...]
