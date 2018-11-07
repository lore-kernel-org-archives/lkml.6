Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507762081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDP2dxic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507762081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeKGW3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:29:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36698 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeKGW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:29:22 -0500
Received: by mail-it1-f195.google.com with SMTP id w7-v6so22542698itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxMt6D8za7895WYIt/xdvKqS6zXb0+QwCyXDw3fGgU4=;
        b=VDP2dxic9+6NzvO9+MUgHs8ghLRNGtArGfr7qLBWRgqg9uHODxGrSdZH69jFoCnIuD
         rGPWW7jsquKW34610SG3YcY72z2X7plYbM4wWEpx4joVPlPrLCz9ufmJb+qgWy/yECLE
         BGEtX0kaONUWGFCEqU+StqztasJiZMxBTV7ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxMt6D8za7895WYIt/xdvKqS6zXb0+QwCyXDw3fGgU4=;
        b=s+mJr+YnW/KIUlw1EsBtzxEzw/gkAP4aX7h71kzRZDJZM1IBJQOjKrZlEkOFDnbp0a
         RikihEkiFtoKPcwGDzDXKbaiucfRfLK4g3Lb0SIbVY8Umq/Db0c5mp8Wq2Tc37wDqgCw
         t6NGaNj+2KdbEpNqStgLeLV1b8zwETjd3J1b+oR/79g+DxYc0d7ktBVXo15T1ynV4pHd
         I4eK0Nzlk4RGt0/Zo6Wdsk0aYisrBCFpOonrBa4CnXLSKfhpIfQ04neCySPryAZ547bf
         QSUlyKXtmJdxuwv8t+noKSP3QjER6LZNUEhJsAl3fHURB0k2GrSGmaoBky/j9Ej45PHc
         TVwg==
X-Gm-Message-State: AGRZ1gJHT8yzBYVz0+3Yvc4YWkILN8q2D5LIHnrPor/Q8SVHrZ+wIpfI
        0QF1oIjRXhs8qjyTYMQI8sjbFFBnXyCJ0Wlgb7WbwQ==
X-Google-Smtp-Source: AJdET5ciKvT54Z4JOCCYaTNjL0bUDnfpyeMyTeChIA6/brqumJRm9fuMuf3p0CfAvzN7KDZZgmcqh4dpqjG+yTBT7+w=
X-Received: by 2002:a24:f246:: with SMTP id j67-v6mr96052ith.114.1541595544092;
 Wed, 07 Nov 2018 04:59:04 -0800 (PST)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com> <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
 <28af1313-8153-624d-1ae9-1554bb2db474@arm.com>
In-Reply-To: <28af1313-8153-624d-1ae9-1554bb2db474@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Nov 2018 13:58:52 +0100
Message-ID: <CAKfTPtDQJYG1a+JDO_okHcbk9mxn+k+b_dwP5hTbUH1e00ZszA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 at 11:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/5/18 10:10 AM, Vincent Guittot wrote:
> > On Fri, 2 Nov 2018 at 16:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 10/26/18 6:11 PM, Vincent Guittot wrote:
>
> [...]
>
> >> Thinking about this new approach on a big.LITTLE platform:
> >>
> >> CPU Capacities big: 1024 LITTLE: 512, performance CPUfreq governor
> >>
> >> A 50% (runtime/period) task on a big CPU will become an always running
> >> task on the little CPU. The utilization signal of the task and the
> >> cfs_rq of the little CPU converges to 1024.
> >>
> >> With contrib scaling the utilization signal of the 50% task converges to
> >> 512 on the little CPU, even it is always running on it, and so does the
> >> one of the cfs_rq.
> >>
> >> Two 25% tasks on a big CPU will become two 50% tasks on a little CPU.
> >> The utilization signal of the tasks converges to 512 and the one of the
> >> cfs_rq of the little CPU converges to 1024.
> >>
> >> With contrib scaling the utilization signal of the 25% tasks converges
> >> to 256 on the little CPU, even they run each 50% on it, and the one of
> >> the cfs_rq converges to 512.
> >>
> >> So what do we consider system-wide invariance? I thought that e.g. a 25%
> >> task should have a utilization value of 256 no matter on which CPU it is
> >> running?
> >>
> >> In both cases, the little CPU is not going idle whereas the big CPU does.
> >
> > IMO, the key point here is that there is no idle time. As soon as
> > there is no idle time, you don't know if a task has enough compute
> > capacity so you can't make difference between the 50% running task or
> > an always running task on the little core.
>
> Agreed. My '2 25% tasks on a 512 cpu' was a special example in the sense
> that the tasks would stay invariant since they are not restricted by the
> cpu capacity yet. '2 35% tasks' would also have 256 utilization each
> with contrib scaling so that's not invariant either.
>
> Could we say that in the overutilized case with contrib scaling each of
> the n tasks get cpu_cap/n utilization where with time scaling they get
> 1024/n utilization? Even though there is no value in this information
> because of the over-utilized state.
>
> > That's also interesting to noticed that the task will reach the always
> > running state after more than 600ms on little core with utilization
> > starting from 0.
> >
> > Then considering the system-wide invariance, the task are not really
> > invariant. If we take a 50% running task that run 40ms in a period of
> > 80ms, the max utilization of the task will be 721 on the big core and
> > 512 on the little core.
>
> Agreed, the utilization of the task on the big CPU oscillates between
> 721 and 321 so the average is still ~512.
>
> > Then, if you take a 39ms running task instead, the utilization on the
> > big core will reach 709 but it will be 507 on little core. So your
> > utilization depends on the current capacity.
>
> OK, but the average should be ~ 507 on big as well. There is idle time

I don't know about the average, the utilization varies between 709-292
on big core and between 507-486 in little core

> now even on the little CPU. But yeah, with longer period value, there
> are quite big amplitudes.
>
> > With the new proposal, the max utilization will be 709 on big and
> > little cores for the 39ms running task. For the 40ms running task, the
> > utilization will be 721 on big core. then if the task moves on the
> > little, it will reach the value 721 after 80ms,  then 900 after more
> > than 160ms and 1000 after 320ms
>
> We consider max values here? In this case, agreed. So this is a reminder

Yes, we consider max value as it's what is mainly used especially with
util_est feature

> that even if the average utilization of a task compared to the CPU
> capacity would mark the system as non-overutilized (39ms/80ms on a 512
> CPU), the utilization of that task looks different because of the
> oscillation which is pretty noticeable with long periods.
>
> The important bit for EAS is that it only uses utilization in the
> non-overutilized case. Here, utilization signals should look the same
> between the two approaches, not considering tasks with long periods like
> the 39/80ms example above.
> There are also some advantages for EAS with time scaling: (1) faster
> overutilization detection when a big task runs on a little CPU, (2)
> higher (initial) task utilization value when this task migrates from
> little to big CPU.
>
> We should run our EAS task placement tests with your time scaling patches.
