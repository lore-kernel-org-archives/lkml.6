Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2966C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C178208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzgMdVPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C178208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeK2AfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:35:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50303 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2AfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:35:09 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so4329051iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=is4cdw48JHoY6N+SUCD4PP8rHuHPJEZ4dwRnnfwougE=;
        b=ZzgMdVPlHlKAECn72COcTntRasvOs6EMvH2D2vrpsk4zmBqCEtEavUrWTSAjywTP2Z
         G7xqTcv1fSNC4Tzb4VEV1jOfZ6hlPyuR3u82axsSoLu93vJsR8nF3C7+QLPoqFMZsdeX
         3uhbvLg2gdnDDy48AqYjl8GxpuJ29YLRcrLg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=is4cdw48JHoY6N+SUCD4PP8rHuHPJEZ4dwRnnfwougE=;
        b=DEQhUKn/ZR/WaHEsNV0i1ZL7R/dzyeP8RxFIJwhTsznudr7Uznqpu+XGdez9pYo5dq
         7lOYePDQYCSw2D+e8Sk/1jjHTYqYoxBdPPeBZ2G7d+4wz46u+gflgEPb6eLdGyRVICb8
         0daysj6mi5XPmMHgAj6sUPlodm1ofIgdwJHh02pbGYNHdHEc3hA13zQzhFzH8JcLmbIn
         +4q5JNciZKhgmb0Cx3paOOBOArXxY8J+awb8IPlMqbucs+0zRywjUW8ASo8ZBuwaaCHq
         kg6hDxNTV8hlzcuRN/MNc79YIYA2I90m+HBGUKtsRKqcxhouPh39RzxhfEyGGg/H3vW0
         7oEA==
X-Gm-Message-State: AA+aEWatBFY+rWh7pLAlw/DCMmZJeH1W3qP5ZOLg0OVRsO+uXH9qsnkd
        yarM1KUUhwNuCNzU/BRqM8Mz7CXruUCkYDseWyhonA==
X-Google-Smtp-Source: AFSGD/XDmh/JFNYYTM/643GZQPvgFAwLmzZedDv+DipHWiGfODyZMuQJCunsmX85PvSYYAE1yYbdzo+BBt8nrC1dM0I=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr2998012itf.14.1543412008149;
 Wed, 28 Nov 2018 05:33:28 -0800 (PST)
MIME-Version: 1.0
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net> <20181128115336.GB23094@e110439-lin>
In-Reply-To: <20181128115336.GB23094@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Nov 2018 14:33:17 +0100
Message-ID: <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 12:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 28-Nov 11:02, Peter Zijlstra wrote:
> > On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:
> >
> > > Is there anything else that I should do for these patches ?
> >
> > IIRC, Morten mention they break util_est; Patrick was going to explain.
>
> I guess the problem is that, once we cross the current capacity,
> strictly speaking util_avg does not represent anymore a utilization.
>
> With the new signal this could happen and we end up storing estimated
> utilization samples which will overestimate the task requirements.
>
> We will have a spike in estimated utilization at next wakeup, since we
> use MAX(util_avg@dequeue_time, ewma). Potentially we also inflate the EWMA in
> case we collect multiple samples above the current capacity.

TBH I don't see how it's different from current implementation with a
task that was scheduled on big core and now wakes up on little core.
The util_est is overestimated as well.

But I'm fine with adding your proposal on to on the patchset

>
> So, a possible fix could be to avoid storing util_est samples if we
> end up with a utilization above the current capacity.
>
> Something like:
>
> ----8<---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ac855b2f4774..93e0cf5d8a76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3661,6 +3661,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>         if (!task_sleep)
>                 return;
>
> +       /* Skip samples which do not represent an actual utilization */
> +       if (unlikely(task_util(p) > capacity_of(task_cpu(p))))
> +               return;
> +
>         /*
>          * If the PELT values haven't changed since enqueue time,
>          * skip the util_est update.
> ---8<---
>
> Could that work ?
>
> Maybe using a new utility function to wrap the new check.
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
