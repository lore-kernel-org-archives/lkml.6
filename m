Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BBD20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRs4geMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BBD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755852AbeFSGWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:22:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39972 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754527AbeFSGWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:22:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id w8-v6so5643912pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8a3zIXleatqf+SNc1r1dTdYTup9b4Y1pkDOL8vgcklY=;
        b=dRs4geMyvzlmACmnjqXW6L+oMs8KaNH8tFm7sjAyHEIhnDELmlXEKDxPvASu8MBF7Y
         vOW7mLcWOmrer1pWGcDcEGHL5M94SYf5zKP/VfTsJZvnyVkeKxPAZiUOG8Vg0SLJxNPE
         1zsVUT6jtufoH3JOYlHqjaO+bEQWTLREmlq8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8a3zIXleatqf+SNc1r1dTdYTup9b4Y1pkDOL8vgcklY=;
        b=bPnEMUOMbXF3NMHgWJDlXh+ODxFb5FP6vmPgxnPYeRdlZNj7qR4n6cMzhkWv55Xzcx
         wyOgYlxIAhnKZFro/Uye1B9Ev3hlh6Rt+wD+47KOCZduAyzPT6hlACpCto4kAgkTwVD1
         SdZW4dUquafk2ozfTesaWfFOu42KIH+/yJdIVhdeqZRPOXXpumGPKiJz1Gq6pFokrSWv
         GfljGapC0XZO0IUeRX5vNRMiTlflnuVr1clFbcQdaR0XqoiqP+P88ydHbt9i2wR94Qwx
         j0mTtNHEaAmHcZyBmVepDpiTR39qRsGgXStHx7/pXKDbFSoaL9NEFgV5+BHhhVC7z2MV
         Fufg==
X-Gm-Message-State: APt69E2oILBBty3rPYE42LiiOd/BaDihFNoR8v6k7HuzmEKeIfAr8jbl
        E46+hqfsA8eNR70dAJ+6qpjgVw==
X-Google-Smtp-Source: ADUXVKLXwogfXvCJYEtdDt/fyXVfIRxIRGPWfmcJI0/Zo5wxpcyIyXAvbjbHJP/xtqc7xLQzzaeizQ==
X-Received: by 2002:a62:9bc9:: with SMTP id e70-v6mr16475511pfk.15.1529389350152;
        Mon, 18 Jun 2018 23:22:30 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id j3-v6sm20505635pgp.47.2018.06.18.23.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:22:29 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:52:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180619062227.uyan2t63fqwxj3eb@vireshk-i7>
References: <1529387906-3838-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529387906-3838-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 07:58, Daniel Lezcano wrote:
> +++ b/drivers/powercap/idle_injection.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The idle injection framework proposes a way to force a cpu to enter
> + * an idle state during a specified amount of time for a specified
> + * period.
> + *
> + * It relies on the smpboot kthreads which handles, via its main loop,
> + * the common code for hotplugging and [un]parking.
> + *
> + * At init time, all the kthreads are created.
> + *
> + * A cpumask is specified as parameter for the idle injection
> + * registering function. The kthreads will be synchronized regarding
> + * this cpumask.
> + *
> + * The idle + run duration is specified via the helpers and then the
> + * idle injection can be started at this point.
> + *
> + * A kthread will call play_idle() with the specified idle duration
> + * from above.
> + *
> + * A timer is set after waking up all the tasks, to the next idle
> + * injection cycle.
> + *
> + * The task handling the timer interrupt will wakeup all the kthreads
> + * belonging to the cpumask.
> + *
> + * Stopping the idle injection is synchonuous, when the function

                                     synchronous

> + * returns, there is the guarantee there is no more idle injection
> + * kthread in activity.
> + *
> + * It is up to the user of this framework to provide a lock at an
> + * upper level to prevent stupid things to happen, like starting while
> + * we are unregistering.
> + */

> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	unsigned int cpu;
> +
> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +		iit->should_run = 1;
> +		wake_up_process(iit->tsk);
> +	}
> +}

Thread A                                        Thread B

                                                CPU3 hotplug out
                                                -> idle_injection_park()
                                                  iit(of-CPU3)->should_run = 0;

idle_injection_wakeup()
 for_each_cpu_and(online)..
   CPU3-selected
                                                clear CPU3 from cpu-online mask.


   iit(of-CPU3)->should_run = 1;
   wake_up_process()

With the above sequence of events, is it possible that the iit->should_run
variable is set to 1 while the CPU is offlined ? And so the crash we discussed
in the previous version may still exist ? Sorry I am not able to take my mind
away from thinking about these stupid races :(

> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires which
> + * will wake up the idle injection tasks and these ones, in turn, play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_RESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
> +{
> +	unsigned int run_duration_ms;
> +	unsigned int idle_duration_ms;
> +	struct idle_injection_device *ii_dev =
> +		container_of(timer, struct idle_injection_device, timer);
> +
> +	run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +	idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
> +
> +	idle_injection_wakeup(ii_dev);
> +
> +	hrtimer_forward_now(timer,
> +			    ms_to_ktime(idle_duration_ms + run_duration_ms));
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +/**
> + * idle_injection_fn - idle injection routine
> + * @cpu: the CPU number the task belongs to
> + *
> + * The idle injection routine will stay idle the specified amount of
> + * time
> + */
> +static void idle_injection_fn(unsigned int cpu)
> +{
> +	struct idle_injection_device *ii_dev;
> +	struct idle_injection_thread *iit;
> +
> +	ii_dev = per_cpu(idle_injection_device, cpu);
> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +	/*
> +	 * Boolean used by the smpboot main loop and used as a
> +	 * flip-flop in this function
> +	 */
> +	iit->should_run = 0;
> +
> +	play_idle(READ_ONCE(ii_dev->idle_duration_ms));
> +}

Maybe we shouldn't change things now (too much effort already went into it
already), I just wanted to share an idea that popped up in my mind. Maybe we
could have used the msleep() or similar API with run_duration_ms from the
kthread instead of the whole hrtimer stuff. Maybe that would have been simpler
to manage? Maybe not :)

The patch looks fine otherwise. I don't have any other (negative) feedback :)

-- 
viresh
