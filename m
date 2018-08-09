Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46F221E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9E4LGkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46F221E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHIXNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:13:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38718 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHIXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:13:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so12186313oie.5;
        Thu, 09 Aug 2018 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fBSyQiWgITthq3Ub06IKe83elrOxzCSbfDH9fKv9hto=;
        b=O9E4LGkKIAlmGM4HaBdTYT0YpYoqmT9RrwhCRi9qMs7CNIJBrsoY2sH3RFQSDHW25/
         rXPUO1OFHzW1IHA0x7mEP5zwRQ367Fz3THJsVvAuDtWetVPi4Dn4tdSz30vFMXCzOSRj
         UC06qIRB1ScDvrWAWEuf5xs99zM+uGn9R//+NT3PpuwLltrwyzafWfDpiKkBfMxt0gbO
         EXdOmzSfarUvGs7cRKysrO8Nc7IYfMQzf5n+12IaPPmyvJi+UuNyqH57c/lVY3wkef1l
         +MlIXgsOtvtkg/oHiWoopAY32zGHfqGzeM1+Y42nNme6TjYsLrFrNgQzwfQu/XeKIf9e
         E8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fBSyQiWgITthq3Ub06IKe83elrOxzCSbfDH9fKv9hto=;
        b=fRUFGGGZUGksomCHKe8HdGcglJqclsClvXl58l7c3ojIpULuc4VL04vL7lTclprOe4
         H/Fjshemh17JYlfYw8WHWGu/LaSrL9UWswDY3uP2IiiaFL8uBKXIGRt/PrD31tH3O3gc
         lhOmw1FdAricgF6EyjSPk1TameKKey9DCoTzbgvIGN+XrJiQB3YsUc0qPo2i/3FnctIx
         sVJOdnJ+0UP0mppT1NftSMJsNBxeSWXOPMxraqGvBUeGnmwaIb9LJTPmmgV1o+lSnrg8
         ol5FHdolX3SHHspDFVn0FNRMfUX0c01bYxj5+vwtaV/Lp9HlgSASVkk0ZU43mi14daWx
         uWqw==
X-Gm-Message-State: AOUpUlEGmVlUSGeO6tSrOGWqoVaDTLuAawzye9XVOBqRoWDY9l9C3E7J
        0EsUZhEyxUFaOoZeGLMvH4jfxA5idjxClwFRprc=
X-Google-Smtp-Source: AA+uWPwoYHSrHp0P2+bwuIAsViH8vVbJlp8e8+wem3Z4PLRr7TAOcWojpjW2astODJot23ARKgQE47zIO9FNgCu3T2s=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr4063868oie.233.1533847637905;
 Thu, 09 Aug 2018 13:47:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 13:47:17 -0700 (PDT)
In-Reply-To: <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org> <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 22:47:17 +0200
X-Google-Sender-Auth: adS7o2suStkyL8HdsRmqYctRIB8
Message-ID: <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> The criteria for keeping tick running is the prediction duration is less
> than TICK_USEC,

Yes, because if the predicted idle duration is less than the tick
period, stopping the tick is pointless overhead (if the governor
predicts a CPU wakeup within the tick period length range, it may as
well let the tick run, because the CPU will be woken up relatively
shortly anyway).

> the mainline kernel configures HZ=250 so TICK_USEC equals

To be precise, other values of HZ may be used too, depending on how
the kernel is configured.

> to 4000us, so any prediction is less than 4000us will not stop tick and
> the idle state will be fixed up to one shallow state.  On the other hand,
> let's use 96boards Hikey (CA53 octa-CPUs) as an example, the platform has
> the deepest C-state is cluster off state which its 'target_residency' is
> 2700us, if the 'menu' governor predicts the next idle duration is any
> value fallen into the range [2700us, 4000us), then the 'menu' governor
> will keep sched tick running and and roll back to a shallow CPU off state
> rather than cluster off state.

Which is as expected.

> Finally we can see the CPU has much less
> chance to run into deepest state when a task repeatedly running on it
> with 5000us period and 40% duty cycle (so the task runs for 2000us and
> then sleep for 3000us in every period).  In theory, we should permit the
> CPU to stay in cluster off state due the CPU sleeping time 3000us is
> over its 'target_residency' 2700us.

For every particular choice of the criteria you can find a particular
case in which it will be suboptimal.

> This issue is caused by the 'menu' governor's criteria for decision if
> need to enable tick and roll back to shallow state, the criteria is:
> 'expected_interval < TICK_USEC'.  This criteria is only considering from
> tick aspect, but it doesn't consider idle state residency so misses
> better choice for deeper idle state; e.g., the deepest idle state
> 'target_residency' is less than TICK_USEC, which is quite common on Arm
> platforms.
>
> To fix this issue, this patch is to add one extra variable
> 'stop_tick_point' to help decision if need to stop tick or not.  If
> prediction is longer than 'stop_tick_point' then we can stop tick,
> otherwise it will keep tick running.

Opinions may differ on whether or not it is an issue that needs to be fixed.

> For 'stop_tick_point', except we need to compare prediction period with
> TICK_USEC, we also need consider from the perspective of deepest idle
> state 'target_residency'.  Finally, 'stop_tick_point' is coming from the
> minimum value within the deepest idle state 'target_residency' and
> TICK_USEC.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 41 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 30ab759..2ce4068 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -294,6 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         unsigned int expected_interval;
>         unsigned long nr_iowaiters, cpu_load;
>         ktime_t delta_next;
> +       unsigned int stop_tick_point;
>
>         if (data->needs_update) {
>                 menu_update(drv, dev);
> @@ -406,11 +407,47 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                 idx = 0; /* No states enabled. Must use 0. */
>
>         /*
> +        * Decide the time point for tick stopping, if the prediction is before
> +        * this time point it's better to keep the tick enabled and after the
> +        * time point it means the CPU can stay in idle state for enough long
> +        * time so should stop the tick.  This point needs to consider two
> +        * factors: the first one is tick period and the another factor is the
> +        * maximum target residency.
> +        *
> +        * We can divide into below cases:
> +        *
> +        * The first case is the prediction is shorter than the maximum target
> +        * residency and also shorter than tick period, this means the
> +        * prediction isn't to use deepest idle state and it's suppose the CPU
> +        * will be waken up within tick period, for this case we should keep
> +        * the tick to be enabled;
> +        *
> +        * The second case is the prediction is shorter than the maximum target
> +        * residency and longer than tick period, for this case the idle state
> +        * selection has already based on the prediction for shallow state and
> +        * we will expect some events can arrive later than tick to wake up the
> +        * CPU; another thinking for this case is the CPU is likely to stay in
> +        * the expected idle state for long while (which should be longer than
> +        * tick period), so it's reasonable to stop the tick.
> +        *
> +        * The third case is the prediction is longer than the maximum target
> +        * residency, but weather it's longer or shorter than tick period; for
> +        * this case we have selected the deepest idle state so it's pointless
> +        * to enable tick to wake up CPU from deepest state.
> +        *
> +        * To summary upper cases, we use the value of min(TICK_USEC,
> +        * maximum_target_residency) as the critical point to decide if need to
> +        * stop tick.
> +        */
> +       stop_tick_point = min_t(unsigned int, TICK_USEC,
> +                       drv->states[drv->state_count-1].target_residency);
> +
> +       /*
>          * Don't stop the tick if the selected state is a polling one or if the
> -        * expected idle duration is shorter than the tick period length.
> +        * expected idle duration is shorter than the estimated stop tick point.
>          */
>         if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -           expected_interval < TICK_USEC) {
> +           expected_interval < stop_tick_point) {

And that will cause the tick to be stopped unnecessarily in certain
situations, so why is this better?

>                 unsigned int delta_next_us = ktime_to_us(delta_next);
>
>                 *stop_tick = false;
> --
