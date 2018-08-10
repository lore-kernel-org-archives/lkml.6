Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE4FC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9870223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaJJ2a7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9870223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeHJJxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:53:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39404 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHJJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:53:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so14267989oib.6;
        Fri, 10 Aug 2018 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j/Yy+4ROWJm5ddfI59XCDrsImkkDPVxo+sWO0V6Gneg=;
        b=OaJJ2a7OLLYZK1EwSFJlxbM9xXKJOnS1hHj0HRxTWOSCvPtO7r4NMGfFqbdKMRP5VM
         3dhH6tqabiSyroCLp0MDgZ/AfFQnb2pPmQEI9W84dQqzMKbYFPd6D6ZiJ4LUaFu9uV8z
         /PBDgDNj5p6hRzF0448FE+hiVjoyuuAX46GJ+Vl31OSuotqb7zqyiBkqpicOscDjDbk/
         cSCxX0OZuw8pWPsobDfbJdTzTpsWcCHvN/9odZV826Y8Fq8HJMPW36KOck/B8cSouYJz
         PwUi86IwZGBjGHrr04TV7Tid2+YKyKaSRMxS7XUOTY+VGyX/Fqf+ZsXB7tB53xnXs+2g
         TfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=j/Yy+4ROWJm5ddfI59XCDrsImkkDPVxo+sWO0V6Gneg=;
        b=eY3wOro+otswdyHYXTQh29jGNgXosyCJ/4DYLs/blXB/1c0dqJ7AtPiJ80aQBVZjAR
         NBYf3VqPnr5N+DTjJ3MbraMtl+tH53Z2FkOksUYie/BYY37De+q1h3IggGmfwElXb2vX
         fFswmbFMVixKRR4MZ8LhfKcOLzSH983jf8PvLMKH/gy5X22ofi8ySvaxA9XhqtDMbLpo
         osYjui6ZUFa5cqBpiVInDucz8HhwCC7slSr1xwuLoKX+Eg8DsS+RKeT6eH8bfCeqvUsw
         AYicndLhmCkRtLdZHn6PMBHJv3i02ehhnFfQXGPP6TJHlpm6ZUiqLl1R3Rt4KTn4Sjp7
         aUHA==
X-Gm-Message-State: AOUpUlFTev2i3mdxzi2m3VFc+NQwaGYXmSwYK90Z2Aaw5RbKRO1Ze+uP
        TYqdF4tHMO3FBSfo+6ra6IKbT/ya1ymtMUyX3ik=
X-Google-Smtp-Source: AA+uWPxlh7qO6aSGCQQU+08oEXHEQ0s7U9CqqGRAb7dLfkIIs9YSESAwE+9oaG1SLI5uOi83aAwZx5a8z7ZO0mksW7I=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr5230077oib.120.1533885884599;
 Fri, 10 Aug 2018 00:24:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 00:24:44
 -0700 (PDT)
In-Reply-To: <20180810055345.GA11817@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <20180809162957.GD14362@leoy-ThinkPad-X240s> <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
 <8620035.OlGfqWSkfk@aspire.rjw.lan> <20180810055345.GA11817@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Aug 2018 09:24:44 +0200
X-Google-Sender-Auth: WGlB4Om8dCrTLFdVy4SXbrM1nFw
Message-ID: <CAJZ5v0hHd1Qb_J+OAgGO+RG2sHbHMnTZbp1+nGvAgdiPSgo0_w@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 7:53 AM,  <leo.yan@linaro.org> wrote:
> On Thu, Aug 09, 2018 at 11:31:46PM +0200, Rafael J . Wysocki wrote:
>
> [...]
>
>> > >> And I really would prefer to avoid restarting the tick here, because
>> > >> it is overhead and quite likely unnecessary.
>> > >
>> > > I understand the logic when read the code, actually I did some experiments
>> > > on the function menu_select(), in menu_select() function it discards the
>> > > consideration for typical pattern interval and it also tries to avoid to
>> > > enable tick and select more shallow state at the bottom of function.  So I
>> > > agree that in the middle of idles it's redundant to reenable tick and the
>> > > code is careful thought.
>> > >
>> > > But this patch tries to rescue the case at the last time the CPU enter one
>> > > shallow idle state but without wake up event.
>> >
>> > It is better to avoid entering a shallow state IMO.  Let me think
>> > about that a bit.
>>
>> The simple change below should address this issue and I don't quite see
>> what it can break.  It may cause deeper idle states to be selected with
>> the tick already stopped, but that really shouldn't be problematic, as
>> (since the tick has been stopped) there are no strict latency constraints,
>> so even if there is an early wakeup, we should be able to tolerate the
>> extra latency just fine.
>>
>> ---
>>  drivers/cpuidle/governors/menu.c |   10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>> @@ -349,14 +349,12 @@ static int menu_select(struct cpuidle_dr
>>                * If the tick is already stopped, the cost of possible short
>>                * idle duration misprediction is much higher, because the CPU
>>                * may be stuck in a shallow idle state for a long time as a
>> -              * result of it.  In that case say we might mispredict and try
>> -              * to force the CPU into a state for which we would have stopped
>> -              * the tick, unless a timer is going to expire really soon
>> -              * anyway.
>> +              * result of it.  In that case say we might mispredict and use
>> +              * the known time to the closest timer event for the idle state
>> +              * selection.
>>                */
>>               if (data->predicted_us < TICK_USEC)
>> -                     data->predicted_us = min_t(unsigned int, TICK_USEC,
>> -                                                ktime_to_us(delta_next));
>> +                     data->predicted_us = ktime_to_us(delta_next);
>
> I did the testing on this, but above change cannot really resolve the
> issue, it misses to handle the case if 'data->predicted_us > TICK_USEC';
> if the prediction is longer than TICK_USEC, e.g. data->predicted_us is
> 2ms, TICK_USEC=1ms;  for this case the deepest state will not be
> chosen and if the data->predicted_us is decided by typical pattern
> value but not the closest timer, finally the CPU still might stay in
> shallow state for long time.

I noticed that too in the meantime. :-)

> Actually in the CPU idle loop with the tick is stopped, I think we
> should achieve two targets:
> - Ensure the CPU can enter the deepest idle state at the last time it
>   runs into into idle;
> - In the middle of idles, we will not reenable the tick at all; though
>   the idle states can be chosen a shallow state for short prediction;
>
> To achieve the first target, we need to define what's the possible
> case the CPU might stay into shallow state but cannot be waken up in
> short time; so for this purpose it's pointeless to compare the value
> between 'data->predicted_us' and TICK_USEC, so I'd like to check if
> the next timer event is reliable to wake up CPU in short time, this
> can be finished by comparison between 'ktime_to_us(delta_next)' with
> maximum target residency;
>
> For the second target, we should not enable the tick again in the idle
> loop after the tick is stopped, whatever the governor choose any idle
> state.
>
> So how about below changes?  I did some verify on this.

I have a similar, but somewhat different patch.  I'll post it shortly.

>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 30ab759..e2de7c2 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -351,18 +351,21 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         data->predicted_us = min(data->predicted_us, expected_interval);
>
>         if (tick_nohz_tick_stopped()) {
> +               unsigned int delta_next_us = ktime_to_us(delta_next);
> +
>                 /*
>                  * If the tick is already stopped, the cost of possible short
>                  * idle duration misprediction is much higher, because the CPU
>                  * may be stuck in a shallow idle state for a long time as a
> -                * result of it.  In that case say we might mispredict and try
> -                * to force the CPU into a state for which we would have stopped
> -                * the tick, unless a timer is going to expire really soon
> -                * anyway.
> +                * result of it.  If the next timer event is later than the
> +                * maximum target residency, this means the timer event is not
> +                * trusted to wake up CPU in short term and the typical pattern
> +                * interval or other factors might lead to a shallow state, in
> +                * that case say we might mispredict and use the known time to
> +                * the closest timer event for the idle state selection.
>                  */
> -               if (data->predicted_us < TICK_USEC)
> -                       data->predicted_us = min_t(unsigned int, TICK_USEC,
> -                                                  ktime_to_us(delta_next));
> +               if (delta_next_us >= drv->states[drv->state_count-1].target_residency)
> +                       data->predicted_us = delta_next_us;
>         } else {
>                 /*
>                  * Use the performance multiplier and the user-configurable
> @@ -410,12 +413,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>          * expected idle duration is shorter than the tick period length.
>          */
>         if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -           expected_interval < TICK_USEC) {
> +           (!tick_nohz_tick_stopped() && expected_interval < TICK_USEC)) {
>                 unsigned int delta_next_us = ktime_to_us(delta_next);
>
>                 *stop_tick = false;
>
> -               if (!tick_nohz_tick_stopped() && idx > 0 &&
> +               if (idx > 0 &&
>                     drv->states[idx].target_residency > delta_next_us) {
>                         /*
>                          * The tick is not going to be stopped and the target
