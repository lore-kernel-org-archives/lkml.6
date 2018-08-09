Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCBD21EC4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="baNEGgl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCBD21EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeHISzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:55:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42952 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbeHISzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:55:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so5652456wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3SXkMP/LxgdXwBCipZqAe4VzUfA7f5QYHd/FqgU5T/8=;
        b=baNEGgl38sPNlYI0IF7wzJxiAG8I9lK+k998a5WccXG3bAaRN+KD4+abwjSC/bTIRA
         V9eaHB0/lxa+1CWdGKfnh3xleHQEDLbvMkE0elmosxL34EdRtTlCzcLKOJdPsiBCW8hR
         M6eatNJfKG/IhHw7kJ+5ZDwIX7YwhUcAGurI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SXkMP/LxgdXwBCipZqAe4VzUfA7f5QYHd/FqgU5T/8=;
        b=axgBzxq0DwnAcgB2FqnizpPimm2Gy+5bfMuhhhPmJH95p7Md8QjUdCOJjq6mpf4peA
         z9AqXwsycy34VTqQ+iXvofl1mvBG3ot2eQ/Q5tT0N/8GV1D9TN4GWxld9XlJ7+AFT4Pg
         xUxI877m+Kb0nK4J3xpldU949gaQOZwO8HxYJwjDk3fhA3NqlTaxR07nCj6BsmegX4jO
         /6do+uBv3c4l2k+CFL83THMszpoUyqItR8G8eQuqgumhAHzcoR6CsYESekYbE5gmLpJp
         Ao4GeNXqWb5zN+jhLJ6FYhX/rkz01Ooj+4F4ceNVHeDznB8D9nt8tkheY9s2IdNlHOvT
         gHBA==
X-Gm-Message-State: AOUpUlH/XSKs5/w6uMK3fV7MJEpo2sFSSF0u95DTtONMXeA1LKDZQ2kd
        EULoHp5PSzqUzz1kKAdNDSOTSQ==
X-Google-Smtp-Source: AA+uWPwzxmk6OgnHBsPgn4LsjLJCMJm9qHf8JT6Anbg84TM9bZWhhk8I2qWQ9P0ptWhB0gbrP8Gcqg==
X-Received: by 2002:a5d:4410:: with SMTP id z16-v6mr1973844wrq.272.1533832210471;
        Thu, 09 Aug 2018 09:30:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id p25-v6sm4602810wmc.29.2018.08.09.09.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 09:30:09 -0700 (PDT)
Date:   Fri, 10 Aug 2018 00:29:57 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Message-ID: <20180809162957.GD14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <2704016.RYJlhC2yyo@aspire.rjw.lan>
 <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 05:42:30PM +0200, Rafael J. Wysocki wrote:

[...]

> >> This issue can be easily reproduce with the case on Arm Hikey board: use
> >> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
> >> function it start a hrtimer with 4ms, so the 4ms timer delta value can
> >> let 'menu' governor to choose deepest state in the next entering idle
> >> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
> >> 10 times, so this can utilize the typical pattern in 'menu' governor to
> >> have prediction for 1ms duration, finally idle governor is easily to
> >> select a shallow state, on Hikey board it usually is to select CPU off
> >> state.  From then on, CPU7 stays in this shallow state for long time
> >> until there have other interrupts on it.
> >
> > And which means that the above-mentioned code misses this case.
> 
> And I don't really understand how this happens. :-/
> 
> If menu sees that the tick has been stopped, it sets
> data->predicted_us to the minimum of TICK_USEC and
> ktime_to_us(delta_next) and the latency requirements comes from PM QoS
> (no interactivity boost).  Thus the only case when it will say "do not
> stop the tick" is when delta_next is below the tick period length, but
> that's OK, because it means that there is a timer pending that much
> time away, so it doesn't make sense to select a deeper idle state
> then.
> 
> If there is a short-interval timer pending every time we go idle, it
> doesn't matter that the tick is stopped really, because the other
> timer will wake the CPU up anyway.
> 
> Have I missed anything?

Yeah, you miss one case is if there haven't anymore timer event, for this
case the ktime_to_us(delta_next) is a quite large value and
data->predicted_us will be to set TICK_USEC; if HZ=1000 then TICK_USEC is
1000us, on Hikey board if data->predicted_us is 1000us then it's easily
to set shallow state (C1) rather than C2.  Unfortunately, this is the
last time the CPU can predict idle state before it will stay in idle
for long period.

[...]

> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index 1a3e9bd..802286e 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -190,10 +190,18 @@ static void cpuidle_idle_call(void)
> >>                */
> >>               next_state = cpuidle_select(drv, dev, &stop_tick);
> >>
> >> -             if (stop_tick)
> >> +             if (stop_tick) {
> >>                       tick_nohz_idle_stop_tick();
> >> -             else
> >> +             } else {
> >> +                     /*
> >> +                      * The cpuidle framework says to not stop tick but
> >> +                      * the tick has been stopped yet, so restart it.
> >> +                      */
> >> +                     if (tick_nohz_tick_stopped())
> >> +                             tick_nohz_idle_restart_tick();
> >
> > You need an "else" here IMO as Peter said.

Yeah, I have replied to Peter, after we restart the tick, I found must to
call tick_retain() to clear 'ts->timer_expires_base' to 0, otherwise
tick_nohz_idle_exit() reports warning when exit from idle loop.

> And I really would prefer to avoid restarting the tick here, because
> it is overhead and quite likely unnecessary.

I understand the logic when read the code, actually I did some experiments
on the function menu_select(), in menu_select() function it discards the
consideration for typical pattern interval and it also tries to avoid to
enable tick and select more shallow state at the bottom of function.  So I
agree that in the middle of idles it's redundant to reenable tick and the
code is careful thought.

But this patch tries to rescue the case at the last time the CPU enter one
shallow idle state but without wake up event.

> >> +
> >>                       tick_nohz_idle_retain_tick();
> >> +             }
> >>
> >>               rcu_idle_enter();
> >>
> >>
> >
> > Please CC cpuidle patches to linux-pm@vger.kernel.org, that helps a lot.
> 
> Thanks,
> Rafael
