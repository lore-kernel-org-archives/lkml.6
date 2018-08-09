Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4ECC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B01B21D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qza/yHSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B01B21D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbeHISIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:08:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33098 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHISH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:07:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so10654440oip.0;
        Thu, 09 Aug 2018 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jXZerd+g2ESTBOI2bI8Wz67ya+eeXgjHajNs5BmUvzo=;
        b=qza/yHSJyHA+JHARJ2uYd+oQKbrjxpxOTBWyaB14kYZ2D9GmJTbrEQSegt7xXAqwjl
         mI2Dvb1itjf4G6arxW2h7Kr3cXjEjs5QF11r4uKzWA6SseahqJODxzPiNQLkNM+mrBk1
         P6w79z+4YQKgZBkrO8ZYDi9tKPpirZ5UAtaq9or5YCUkVMm9Su88DV8rpQm59z7Yjjey
         3CKrRsYwyLKjFGG2q1V3GrwqquOj2GSSqKr/fiOFzHlmDwZ/9zxTQOIiUOtlzHbO6CCZ
         dyDaLMoz0L9/D9YP0xQv1vl6PkRp0N5Zwr3OpnprdquGqlT2XEugAmZEzR4P+4SS8r7n
         0sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jXZerd+g2ESTBOI2bI8Wz67ya+eeXgjHajNs5BmUvzo=;
        b=JH0vzgqSIdRmFwV/oEpZqhHF+l+ozj/JOvtfM2JjpnhbU1FnHocjh8a9DUr0wUtPJL
         V9APP537xBpiDpB7GeOizJ0IhfNZHZRbkxanuPjudb5X4yCk8usWr+i/iRjSScDCq0zO
         KXilbko2TpQwe97luSMvhq8U61MyJT8gK1qTFZdt1Lk7CepNW4A9UszczAFY30y6scRB
         3xkL+qAujcQCKiHp9uUxNyKrGxIj6QqIURcQuKUSuP9/YNvECC5kIbPBPJKWY3Zj7QQL
         bj6SKNwREuaTBDv+smC2xrE5Osj/9VBu74f0NcInEB0LQYD1SN9VbRhadcg9P8+YdPs8
         E3Zg==
X-Gm-Message-State: AOUpUlFLkKeAmd8lrS6p7AKzoUSJZ/JFQSuWpDad4l7YVIu9pPDNGFKC
        3pTEwIp9v89p9vs9ajWghGYafBvsRSW9iOjV7c+/uqOO
X-Google-Smtp-Source: AA+uWPzrHd6bPpO84snuuWOfadQbgJhIdM6yiPvZi+Y0WT3v7Y2IEhOyBQI1+2Vn/gjQuUKH+7JFIb5hLnbDLSO4u+c=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2413178oia.154.1533829351016;
 Thu, 09 Aug 2018 08:42:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 08:42:30 -0700 (PDT)
In-Reply-To: <2704016.RYJlhC2yyo@aspire.rjw.lan>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org> <2704016.RYJlhC2yyo@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 17:42:30 +0200
X-Google-Sender-Auth: SSBipzW0i00lvrI_7TwzIXcu9f8
Message-ID: <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
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

On Thu, Aug 9, 2018 at 2:05 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, August 9, 2018 7:47:27 AM CEST Leo Yan wrote:
>> The idle loop stops tick by respecting the decision from cpuidle
>> framework, if the condition 'need_resched()' is false without any task
>> scheduling, the CPU keeps running in the loop in do_idle() and it has no
>> chance call tick_nohz_idle_exit() to enable the tick.  This results in
>> the idle loop cannot reenable sched tick afterwards, if the idle
>> governor selects a shallow state, thus the powernightmares issue can
>> occur again.
>
> Well, there is code in the menu governor to avoid that.

So the governor is not expected to select a shallow state then, unless
it knows that there will be a timer interrupt (which is not a tick,
obviously), that will wake up the CPU early enough.

The menu governor works like that, but I agree that it should not
request the tick to be running then (which it does).

>> This issue can be easily reproduce with the case on Arm Hikey board: use
>> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
>> function it start a hrtimer with 4ms, so the 4ms timer delta value can
>> let 'menu' governor to choose deepest state in the next entering idle
>> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
>> 10 times, so this can utilize the typical pattern in 'menu' governor to
>> have prediction for 1ms duration, finally idle governor is easily to
>> select a shallow state, on Hikey board it usually is to select CPU off
>> state.  From then on, CPU7 stays in this shallow state for long time
>> until there have other interrupts on it.
>
> And which means that the above-mentioned code misses this case.

And I don't really understand how this happens. :-/

If menu sees that the tick has been stopped, it sets
data->predicted_us to the minimum of TICK_USEC and
ktime_to_us(delta_next) and the latency requirements comes from PM QoS
(no interactivity boost).  Thus the only case when it will say "do not
stop the tick" is when delta_next is below the tick period length, but
that's OK, because it means that there is a timer pending that much
time away, so it doesn't make sense to select a deeper idle state
then.

If there is a short-interval timer pending every time we go idle, it
doesn't matter that the tick is stopped really, because the other
timer will wake the CPU up anyway.

Have I missed anything?

>>
>> C2: cluster off; C1: CPU off
>>
>> Idle state:           C2    C2    C2    C2    C2    C2    C2    C1
>>             --------------------------------------------------------->
>> Interrupt:   ^        ^     ^     ^     ^     ^     ^     ^     ^
>>             IPI      Timer Timer Timer Timer Timer Timer Timer Timer
>>                    4ms   1ms   1ms   1ms   1ms   1ms   1ms   1ms
>>
>> To fix this issue, the idle loop needs to support reenabling sched tick.
>> This patch checks the conditions 'stop_tick' is false when the tick is
>> stopped, this condition indicates the cpuidle governor asks to reenable
>> the tick and we can use tick_nohz_idle_restart_tick() for this purpose.
>>
>> A synthetic case is used to to verify this patch, we use CPU0 to send
>> IPI to wake up CPU7 with 50ms interval, CPU7 generate a series hrtimer
>> events (the first interval is 4ms, then the sequential 10 timer events
>> are 1ms interval, same as described above).  We do statistics for idle
>> states duration, the unit is second (s), the testing result shows the
>> C2 state (deepest state) staying time can be improved significantly for
>> CPU7 (+7.942s for 10s execution time on CPU7) and all CPUs wide
>> (+13.360s for ~80s of all CPUs execution time).
>>
>>        Without patches         With patches         Difference
>>      --------------------  --------------------  -----------------------
>> CPU    C0     C1      C2     C0     C1      C2      C0      C1       C2
>> 0    0.000  0.027   9.941  0.055  0.038   9.700  +0.055  +0.010   -0.240
>> 1    0.045  0.000   9.964  0.019  0.000   9.943  -0.026  +0.000   -0.020
>> 2    0.002  0.003  10.007  0.035  0.053   9.916  +0.033  +0.049   -0.090
>> 3    0.000  0.023   9.994  0.024  0.246   9.732  +0.024  +0.222   -0.261
>> 4    0.032  0.000   9.985  0.015  0.007   9.993  -0.016  +0.007   +0.008
>> 5    0.001  0.000   9.226  0.039  0.000   9.971  +0.038  +0.000   +0.744
>> 6    0.000  0.000   0.000  0.036  0.000   5.278  +0.036  +0.000   +5.278
>> 7    1.894  8.013   0.059  1.509  0.026   8.002  -0.384  -7.987   +7.942
>> All  1.976  8.068  59.179  1.737  0.372  72.539  -0.239  -7.695  +13.360
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>  kernel/sched/idle.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index 1a3e9bd..802286e 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -190,10 +190,18 @@ static void cpuidle_idle_call(void)
>>                */
>>               next_state = cpuidle_select(drv, dev, &stop_tick);
>>
>> -             if (stop_tick)
>> +             if (stop_tick) {
>>                       tick_nohz_idle_stop_tick();
>> -             else
>> +             } else {
>> +                     /*
>> +                      * The cpuidle framework says to not stop tick but
>> +                      * the tick has been stopped yet, so restart it.
>> +                      */
>> +                     if (tick_nohz_tick_stopped())
>> +                             tick_nohz_idle_restart_tick();
>
> You need an "else" here IMO as Peter said.

And I really would prefer to avoid restarting the tick here, because
it is overhead and quite likely unnecessary.

>> +
>>                       tick_nohz_idle_retain_tick();
>> +             }
>>
>>               rcu_idle_enter();
>>
>>
>
> Please CC cpuidle patches to linux-pm@vger.kernel.org, that helps a lot.

Thanks,
Rafael
