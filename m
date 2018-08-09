Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE75C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8821EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRosKmml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C8821EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeHIXcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:32:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35620 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeHIXcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:32:45 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so12324197oic.2;
        Thu, 09 Aug 2018 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pv/lhu7rTZynC1mJYYk43uEB2DnypJnd8HrVMX/ETuk=;
        b=LRosKmml/nWtZnRxsr99RlhVqd1CVH9vZxD6zziOolDmEX6PaxTwq8SPbTNAhpA7Lu
         PUg8Wy7L0k0Z/Frsm1FUojSnfJHx7bTb3AKRSZFk8gSk65nMFEr7nEOE9XGimW4FWEPl
         8Z7jAlp+FZGbQ+mTUkJLqaRh9WKSlU6gObUK9IV2oda3OJ4Js/jl5f1ATUrvHnvfBIkQ
         OpyoNh6KEwP7OaVrZ196aABG0b9aSg0875E+jWBZHM3WGa2+UMhH/1ULLC1LT2cWsfIB
         PzdFo/7N+31yLoO/CY5EIV9Lbp5T/Qew43FWBaNLPtVDxhGZtanNeVX6uqaKhNaEluX2
         lINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pv/lhu7rTZynC1mJYYk43uEB2DnypJnd8HrVMX/ETuk=;
        b=sqlSN3k0VJGjGO+9TJSmYbDb+9X5QhlKgBiUBCSg68HoweCrNqMjj16LWB1CF33zop
         RRYYxLMsIL8iZs7eh/mS+vl9gVPD6UCdCwZGJhqw89V6y3Qo4KmVJ0ez12AC8P5WOWyS
         fFzpVdQMumODD3SoL6Vl1ZBezEI8XPnDlJOhx9Uu4N3wWKIUZgxcog6MlubXL77/l1yB
         dtSMZKZ6cgffMIsMNdWmOskMd+mn6fbWUpUxYlZN3SeVT8rBNi3HlKn2I3AEIhj0W8si
         PV5sWo3p7MRXmuaIVqTDboIabhm6fgVoqZDOA4qPZ0OU/D87N9Hk6+OKasETvUzLJ84i
         pGKA==
X-Gm-Message-State: AOUpUlFm6HDK9sQ/uD/4PhgeWPBSIofD69Ei9fHaXcKoXZgHpJWIZ8ON
        IwDBWKuOBSct/MoIv7X6U4OISHxqLaQ+orlTEbo=
X-Google-Smtp-Source: AA+uWPwpaJlQDI3l4cPQZpGnmaDDDt4OljrxkfTpiyEvDPmd2i/OOP8JjNzEFUw4l/8U/2jpuvG/7GcWb5Qy3fd6JoU=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr4109049oib.116.1533848768276;
 Thu, 09 Aug 2018 14:06:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 14:06:07 -0700 (PDT)
In-Reply-To: <1533835203-5789-3-git-send-email-leo.yan@linaro.org>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org> <1533835203-5789-3-git-send-email-leo.yan@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 23:06:07 +0200
X-Google-Sender-Auth: 8LyeCGKBMx-fV1l64KL1qQyGA9s
Message-ID: <CAJZ5v0ggZXDCvQ7EbO1gtZhMewK6ToRW9JSiDzwpdZqZLDY31g@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 2/2] cpuidle: menu: Dismiss tick impaction on
 correction factors
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
> If the idle duration predictor detects the tick is triggered, and with
> meeting the condition 'data->next_timer_us > TICK_USEC', it will give a
> big compensation for the 'measured' interval; this is purposed to avoid
> artificially small correction factor values.  Unfortunately, this still
> cannot cover all cases of the tick impaction on correction factors,
> e.g. if the predicted next event is less than ITCK_USEC, then all
> wakening up by the ticks will be taken as usual case and reducing exit
> latency, as results the tick events heavily impacts the correction
> factors.
>
> Moreover, the coming tick sometimes is very soon, especially
> at the first time when the CPU becomes idle the tick expire time might
> be vary, so ticks can introduce big deviation on correction factors.
>
> If idle governor deliberately doesn't stop the tick timer, the tick
> event is coming as expected with fixed interval, so the tick event is
> predictable; if the tick event is coming early than other normal timer
> event and other possible wakeup events, we need to dismiss the tick
> impaction on correction factors, this can let the correction factor
> array is purely used for other wakeup events correctness rather than
> sched tick.
>
> This patch is to check if it's a tick wakeup, it takes the CPU can
> stay in the idle state for enough time so it gives high compensation
> for the measured' interval, this can avoid tick impaction on the
> correction factor array.

Well, again, this is questionable.

Yes, you can remove the tick influence on correction factors this way,
but will the resulting idle duration predictions be actually better
because of that?

Do you have any data to demonstrate the difference?

>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 2ce4068..43cbde3 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -525,15 +525,13 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>          * assume the state was never reached and the exit latency is 0.
>          */
>
> -       if (data->tick_wakeup && data->next_timer_us > TICK_USEC) {
> +       if (data->tick_wakeup) {
>                 /*
> -                * The nohz code said that there wouldn't be any events within
> -                * the tick boundary (if the tick was stopped), but the idle
> -                * duration predictor had a differing opinion.  Since the CPU
> -                * was woken up by a tick (that wasn't stopped after all), the
> -                * predictor was not quite right, so assume that the CPU could
> -                * have been idle long (but not forever) to help the idle
> -                * duration predictor do a better job next time.
> +                * Since the CPU was woken up by a tick (that wasn't stopped
> +                * after all), the predictor was not quite right, so assume

This part of the comment is not valid any more IMO.

The fact that the CPU was woken up by the tick alone doesn't tell you
much about the prediction.  The tick may have not been stopped,
because the nohz code saw timer events within the tick boundary, in
which case the CPU could not be idle very long.  The next_timer_us
check is there to see what the nohz code told us.

> +                * that the CPU could have been idle long (but not forever)
> +                * to help the idle duration predictor do a better job next
> +                * time.
>                  */
>                 measured_us = 9 * MAX_INTERESTING / 10;
>         } else {
> --
