Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A133C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6D121EEF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anrVX1ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6D121EEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbeHITJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:09:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43550 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbeHITJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:09:38 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so10886988oib.10;
        Thu, 09 Aug 2018 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kU5ozwKzgANnNqkpAe/BLJSrCzvoumCjE2YSctJCB4I=;
        b=anrVX1MELTlixoB3w6SeQ4A5tVk0AtcvH2Y469yj3tBXOqmg0XWlllSN58GlOnQOPG
         1HKKPNWNCYCAj3qNCddRnEVs2Hnx8Ol3RHym+ssDaxd6zaYSX8CPwWns294SutCRAo7V
         0eg0tI6okojXO9mID7rK078QAttUhupz2vC3vxk2uULqEKeBI0xzvFT73lIY8ER3+3HG
         qHP0Hpr3aMRcuDmkm16XYmcKQe4gi0TTlkHfZTgsnLBEtOKy71whI5oAlryKQLtw2ofG
         ZC3D+JWTE+pVpy4f3cct7XphWDvcnPApTRBMsIxBOfvb1/3Avo8SatRyKUsMS2qjYYB9
         lCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kU5ozwKzgANnNqkpAe/BLJSrCzvoumCjE2YSctJCB4I=;
        b=kn98KoaemQCXgSDyGGbrb8fMgvP8e7b0k1C3hC65FAm64IJsN/nSTc+tUvLJoBkBiZ
         3HOc5ZABJVQQZnkvNyhnlVljdks+6I7kJCW5A6Gjr9uLZaIp82CiJaEvIcCHb9ayycUC
         uMZn8qKUuSFYJc/gMXa+0wg71Km4l0ED0wZle9RlwggzmjqrLOucYbgjqFlgNHlY2mKK
         8DvbJ2pG2wP6T+oHSh0eb8WufpV9DBneOTH33pigEYpr+Acv/Uv3o/YGm7mncZ+eNnrc
         b3uZCma1nL5FJ0iY4ojkYafNw6zDYUTNjO7L1YK4krBUAtpMRJSHWF/YothoeYGyX2d1
         lqTw==
X-Gm-Message-State: AOUpUlEmdVhfhn5Ddh8q/1JJz3XBMVDoKOAW7LI+pi+Nl6YfDeONi0zz
        E5HtSC+JR2sBl7vVKqA5j+E7SZ4SlwcIdPmUNf0=
X-Google-Smtp-Source: AA+uWPxHy6mWeCwuYcQPe01hgddx95K0+HMIg1MMhNJnks+pzue9JbBEI7qM54f7U/c/QOq3X/3Vn0QjzQIYz6B26to=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2628799oia.154.1533833035844;
 Thu, 09 Aug 2018 09:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 09:43:55 -0700 (PDT)
In-Reply-To: <20180809162957.GD14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <2704016.RYJlhC2yyo@aspire.rjw.lan> <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
 <20180809162957.GD14362@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 18:43:55 +0200
X-Google-Sender-Auth: oEVDhzqbYQXVg_gDe2-2LIewZ2M
Message-ID: <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Aug 9, 2018 at 6:29 PM,  <leo.yan@linaro.org> wrote:
> On Thu, Aug 09, 2018 at 05:42:30PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
>> >> This issue can be easily reproduce with the case on Arm Hikey board: use
>> >> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
>> >> function it start a hrtimer with 4ms, so the 4ms timer delta value can
>> >> let 'menu' governor to choose deepest state in the next entering idle
>> >> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
>> >> 10 times, so this can utilize the typical pattern in 'menu' governor to
>> >> have prediction for 1ms duration, finally idle governor is easily to
>> >> select a shallow state, on Hikey board it usually is to select CPU off
>> >> state.  From then on, CPU7 stays in this shallow state for long time
>> >> until there have other interrupts on it.
>> >
>> > And which means that the above-mentioned code misses this case.
>>
>> And I don't really understand how this happens. :-/
>>
>> If menu sees that the tick has been stopped, it sets
>> data->predicted_us to the minimum of TICK_USEC and
>> ktime_to_us(delta_next) and the latency requirements comes from PM QoS
>> (no interactivity boost).  Thus the only case when it will say "do not
>> stop the tick" is when delta_next is below the tick period length, but
>> that's OK, because it means that there is a timer pending that much
>> time away, so it doesn't make sense to select a deeper idle state
>> then.
>>
>> If there is a short-interval timer pending every time we go idle, it
>> doesn't matter that the tick is stopped really, because the other
>> timer will wake the CPU up anyway.
>>
>> Have I missed anything?
>
> Yeah, you miss one case is if there haven't anymore timer event, for this
> case the ktime_to_us(delta_next) is a quite large value and
> data->predicted_us will be to set TICK_USEC; if HZ=1000 then TICK_USEC is
> 1000us, on Hikey board if data->predicted_us is 1000us then it's easily
> to set shallow state (C1) rather than C2.  Unfortunately, this is the
> last time the CPU can predict idle state before it will stay in idle
> for long period.

Fair enough, but in that case the governor will want the tick to be
stopped, because expected_interval is TICK_USEC then, so I'm not sure
how the patch helps?

> [...]
>
>> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> >> index 1a3e9bd..802286e 100644
>> >> --- a/kernel/sched/idle.c
>> >> +++ b/kernel/sched/idle.c
>> >> @@ -190,10 +190,18 @@ static void cpuidle_idle_call(void)
>> >>                */
>> >>               next_state = cpuidle_select(drv, dev, &stop_tick);
>> >>
>> >> -             if (stop_tick)
>> >> +             if (stop_tick) {
>> >>                       tick_nohz_idle_stop_tick();
>> >> -             else
>> >> +             } else {
>> >> +                     /*
>> >> +                      * The cpuidle framework says to not stop tick but
>> >> +                      * the tick has been stopped yet, so restart it.
>> >> +                      */
>> >> +                     if (tick_nohz_tick_stopped())
>> >> +                             tick_nohz_idle_restart_tick();
>> >
>> > You need an "else" here IMO as Peter said.
>
> Yeah, I have replied to Peter, after we restart the tick, I found must to
> call tick_retain() to clear 'ts->timer_expires_base' to 0, otherwise
> tick_nohz_idle_exit() reports warning when exit from idle loop.

I see now, thanks.

>> And I really would prefer to avoid restarting the tick here, because
>> it is overhead and quite likely unnecessary.
>
> I understand the logic when read the code, actually I did some experiments
> on the function menu_select(), in menu_select() function it discards the
> consideration for typical pattern interval and it also tries to avoid to
> enable tick and select more shallow state at the bottom of function.  So I
> agree that in the middle of idles it's redundant to reenable tick and the
> code is careful thought.
>
> But this patch tries to rescue the case at the last time the CPU enter one
> shallow idle state but without wake up event.

It is better to avoid entering a shallow state IMO.  Let me think
about that a bit.
