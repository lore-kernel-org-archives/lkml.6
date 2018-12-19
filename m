Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFCCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B62218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3gzm/El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeLSNkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:40:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55073 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeLSNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:40:11 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so9679906ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0yZqwcB1aqg1r0dsM3COhRbwgnUvQciXLl598fwrx0=;
        b=k3gzm/ElgHxzys4iJQQh0P1e1VFFUL/0eiM/LMKwYYX6ui3+S3Os2yxrM3Jk4m1BmE
         msVdFmdTAkljtY5XzguyBCEqqxfEr8UCp6nQE0p8iRA44n0SdhtnMwcos8XBNl+/YGZQ
         p0kpDdp4vn/3kcUG2M/wC0lAzh/jJnQPRLToU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0yZqwcB1aqg1r0dsM3COhRbwgnUvQciXLl598fwrx0=;
        b=KCNulz7XDbO91+Q9plVAV+GW6k3XuOPM/RlahSSJQVluXH5zYxG10yFN1tioDv6gr0
         4QGlSVnHsv7QXdtcq3/42qA97yqrvq/RgJR6GN2YaNzvsMZuj4MMS0hPFeSFwy4vytG+
         a8y7g+sMu/N1jwm+PDcRjWJBfPhnznRPu2oIkav4CJhJXCeUoL4E5rV9fzQaIbLbLcEX
         +KFE5A2GxVROdBu34evvQgt94x7wvhcopESLawMMQxVMLDY+ET/43Wac0/JA+mc+YCuf
         FHZyOLcsvKMBQNXvrO4KnbCq0VVDY0nsCppKsndCibUTq9uFtAQFHpN5njnih7N8/20s
         f/Nw==
X-Gm-Message-State: AA+aEWarKTC7y+ZOrnc7VqTzhdFpBi7G51Mw0C8Bz1vyc6Wws/v+QCOO
        fTTVWESoHax4mVniubutU4EFUusYMTXsGYylJABclw==
X-Google-Smtp-Source: AFSGD/Vwj8Lt9GZMi1MjQWWRgShmdjgt2Wq89OTnWPEGcDax1PCCYiywqGcYvk8QcysvHJztSGu1XgUrVZV/IVfr+jY=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr6513468itb.152.1545226809867;
 Wed, 19 Dec 2018 05:40:09 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com> <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
 <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com>
In-Reply-To: <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 14:39:58 +0100
Message-ID: <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 12:58, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/12/2018 08:32, Vincent Guittot wrote:
> [...]
> > This is another UC, asym packing is used at SMT level for now and we
> > don't face this kind of problem, it has been also tested and DynamiQ
> > configuration which is similar to SMT : 1 CPU per sched_group
> > The legacy b.L one was not the main target although it can be
> >
> > The rounding error is there and should be fixed and your UC is another
> > case for legacy b.L that can be treated in another patch
> >
>
> I used that setup out of convenience for myself, but AFAICT that use-case
> just stresses that issue.

After looking at you UC in details, your problem comes from the wl=1
for cpu0 whereas there is no running task.
But wl!=0 without running task should not be possible since fdf5f3
("wsched/fair: Disable LB_BIAS by default")

This explain the 1023 instead of 1022

>
> In the end we still have an imbalance value that can vary with only
> slight group_capacity changes. And that's true even if that group
> contains a single CPU, as the imbalance value computed by
> check_asym_packing() can vary by +/-1 with very tiny capacity changes
> (rt/IRQ pressure). That means that sometimes you're off by one and don't
> do the packing because some CPU was pressured, but some other time you
> might do it because that CPU was *more* pressured. It's doesn't make sense.
>
>
> In the end problem is that in update_sg_lb_stats() we do:
>
>         sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
>
> and in check_asym_packing() we do:
>
>         env->imbalance = DIV_ROUND_CLOSEST(
>                 sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
>                 SCHED_CAPACITY_SCALE)
>
> So we end up with something like:
>
>                     group_load * SCHED_CAPACITY_SCALE * group_capacity
>         imbalance = --------------------------------------------------
>                             group_capacity * SCHED_CAPACITY_SCALE
>
> Which you'd hope to reduce down to:
>
>         imbalance = group_load
>
> but you get division errors all over the place. So actually, the fix we'd
> want would be:
>
> -----8<-----
> @@ -8463,9 +8463,7 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
>         if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
>                 return 0;
>
> -       env->imbalance = DIV_ROUND_CLOSEST(
> -               sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
> -               SCHED_CAPACITY_SCALE);
> +       env->imbalance = sds->busiest_stat.group_load;
>
>         return 1;
>  }
> ----->8-----
