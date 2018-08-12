Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA33C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5394821A01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQ1HyRX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5394821A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeHLQWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:22:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39448 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeHLQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:22:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so12029075wre.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YOng7MCMDFD/c+9AJx1UhKjv05gBlCSSD2vi76KX05Y=;
        b=ZQ1HyRX23wHghgb9anf/rxKdn/rpcoCCdYhRHxGKhuMVj4K4BavRgv45Ifj2vDbZ/q
         Rxa7D14E8HG35wcAembZy+tr6CqZXbcgyCafWzyVr4ivkpCGomTTdmQ99Znfh84dnBAE
         Qdlzc/8G9/d2WM+npxmfLgK0bN+0GiezEieqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOng7MCMDFD/c+9AJx1UhKjv05gBlCSSD2vi76KX05Y=;
        b=mnYM3l7MAhgheLcvhi0/Ha8fmHt3BLfYIVm14zabytPVMfSEbwf1/c5MnN7F+on7FV
         00X0gZW4BV3DtREae93jdCLHcADqCVGeXfy91RJWBddJ4cMCvZW5FAcyRbvtef++iM2e
         C2qDO1b6mrs1Mnyj01menLlYElZgplmbYN5dLc7fpxVGMhbA5S6PLdnDmR6W9Sk7bbRq
         s203acWKmHjkmceyc9Pz/V9YzjicyuxeS0ASAIIHkthQEhajgauVpaGWSfnYZknqOiLK
         KUO2wQBhZpN0Wsziy6LATsoqIfldfSfSrHOHeo1LpU4gQtlrbMRJ3nIfYSfG1c2ExjAE
         uOTQ==
X-Gm-Message-State: AOUpUlG5sSrKG7RXrVv7hB7l/4TWnuxJ0Tq27RIhq/5BdEiz9c0ZTIsZ
        X8Lkg9M2+WfJQFNd/xn8mBh4+mvzph3e6g==
X-Google-Smtp-Source: AA+uWPw6iSyJ1mmr248MZQkj3sTvQCxBA6v+Q2+A48uiyQTeE4GskIKf3aDq0FTFH7CtxDiMyELDoA==
X-Received: by 2002:adf:9203:: with SMTP id 3-v6mr8442771wrj.275.1534081457173;
        Sun, 12 Aug 2018 06:44:17 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7283090wro.47.2018.08.12.06.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 06:44:16 -0700 (PDT)
Date:   Sun, 12 Aug 2018 21:44:04 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180812134404.GA28966@leoy-ThinkPad-X240s>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <20180810092034.GF11817@leoy-ThinkPad-X240s>
 <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
 <20180810123143.GG11817@leoy-ThinkPad-X240s>
 <CAJZ5v0h5XWES6ye152MjijWKqTWBVO2mjo5Jz3MmMn+=7tRqWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h5XWES6ye152MjijWKqTWBVO2mjo5Jz3MmMn+=7tRqWA@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 12:07:45PM +0200, Rafael J. Wysocki wrote:

[...]

> > > > > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > > > > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > > > > @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
> > > > >  {
> > > > >       struct menu_device *data = this_cpu_ptr(&menu_devices);
> > > > >       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> > > > > -     int i;
> > > > > -     int first_idx;
> > > > > -     int idx;
> > > > > +     int first_idx = 0;
> > > > > +     int idx, i;
> > > > >       unsigned int interactivity_req;
> > > > >       unsigned int expected_interval;
> > > > >       unsigned long nr_iowaiters, cpu_load;
> > > > > @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
> > > > >       /* determine the expected residency time, round up */
> > > > >       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> > > > >
> > > > > +     /*
> > > > > +      * If the tick is already stopped, the cost of possible short idle
> > > > > +      * duration misprediction is much higher, because the CPU may be stuck
> > > > > +      * in a shallow idle state for a long time as a result of it.  In that
> > > > > +      * case say we might mispredict and use the known time till the closest
> > > > > +      * timer event for the idle state selection.
> > > > > +      */
> > > > > +     if (tick_nohz_tick_stopped()) {
> > > > > +             data->predicted_us = ktime_to_us(delta_next);
> > > > > +             goto select;
> > > > > +     }
> > > > > +
> > > >
> > > > This introduce two potential issues:
> > > >
> > > > - This will totally ignore the typical pattern in idle loop; I
> > > >   observed on the mmc driver can trigger multiple times (> 10 times)
> > > >   with consistent interval;
> > >
> > > I'm not sure what you mean by "ignore".
> >
> > You could see after move code from blow to this position, the typical
> > pattern interval will not be accounted; so if in the middle of idles
> > there have a bunch of interrupts with fix pattern, the upper code
> > cannot detect this pattern anymore.
> 
> I'm not really following you here.
> 
> The part of the code skipped for tick_nohz_tick_stopped() doesn't
> update the data at all AFAICS.  It only computes some values that
> would be discarded later anyway, so I'm not sure what the point of
> running that computation is.

Sorry I don't explain clearly, so try to rephrase:

With your patch for the tick stopped case, it directly uses tick delta
value as prediction and goto 'select' tag.  So it skips below code
pieces, these codes have minor improvement for typical pattern which
can be applied in the middle of idles, for example, the mmc driver
triggers 16 interrupts with ~1500us interval, these interrupts are all
handled within the idle loop, so the typical pattern can detect the mmc
interrupts pattern and it will help idle governor to select a shallower
idle state so can avoid to break the residency.

You mentioned these computed values would be discarded later, this is
true for most cases, but it isn't always true actually.  Without your
patch, the governor will discard the computed values only when
'data->predicted_us < TICK_USEC', otherwise the interval pattern is
still be applied in the prediction.

	expected_interval = get_typical_interval(data);
	expected_interval = min(expected_interval, data->next_timer_us);

	[...]

	/*
	 * Use the lowest expected idle interval to pick the idle state.
	 */
	data->predicted_us = min(data->predicted_us, expected_interval);

> The statistics are updated by menu_update() and that still runs and it
> will take the actual wakeup events into account, won't it?

Yes.

> > [...]
> >
> > > > > -     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > > > -         expected_interval < TICK_USEC) {
> > > > > +     if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > > > +         expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
> > > >
> > > > I am not sure this logic is right... Why not use below checking, so
> > > > for POLLING state we will never ask to stop the tick?
> > > >
> > > >         if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING ||
> > > >             (expected_interval < TICK_USEC && !tick_nohz_tick_stopped())) {
> > > >
> > >
> > > The only effect of it would be setting stop_tick to false, but why
> > > would that matter?
> >
> > Please consider below situation, not sure if this case is existed or
> > not:
> >
> >   step1: first time: enter one idle state with stopping tick;
> >   step2: second time: select POLLING state and tick_nohz_tick_stopped()
> >   is true;
> >
> > So in step2, it cannot set stop_tick to false with below sentence.
> >
> > > > >               unsigned int delta_next_us = ktime_to_us(delta_next);
> > > > >
> > > > >               *stop_tick = false;
> 
> But setting *stop_tick has no effect as far as the current code is
> concerned (up to the bug fixed by the other patch).

Yeah.

> Also the POLLING state can only be selected if there are no other
> states matching delta_next available in that case which means that
> there will be a timer to break the polling loop soon enough (and BTW
> the polling has a built-in timeout too), so I don't really see a
> problem here.

Ah, now I understand the logic and I misunderstand the POLLING mode
before; now agree with this.  Sorry for noise.

Thanks,
Leo Yan
