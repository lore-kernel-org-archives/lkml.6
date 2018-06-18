Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8147C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739C4208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="awm2FYvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739C4208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbeFRKit (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:38:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44465 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933477AbeFRKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:38:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so8789671plk.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+dvN3rgj5osvAxyWENGpRyWOjriK14NRTWBF+TKrCI=;
        b=awm2FYvKpdeEHGV4RriZWWRv3xRqgYjMplezOYSbNaBwaLNyNXstKw0YZFLQoKTjgw
         natwpFHuIIaRp5bFHY01/byUmcPiwXb1h7PgP0+xKj1oyLnY3cL0ZaYm4Y0vtqYO9VZy
         yzDFiynU7ggZy8MKsHBDhN3WTrD/kywj4ICKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+dvN3rgj5osvAxyWENGpRyWOjriK14NRTWBF+TKrCI=;
        b=HqtMdtChHPl37ZGuPrMm0oTmTb109uOdGkKOakpOaZaWxIsqx3Rwa9CYGgvZqxN02z
         dRBzyhJ+pNPq3HnXJfDTwVH70xqD/njNnq7PLOdr27ojgcXzuo9uBq/9yIYogyKRYBXT
         s+9+5edeeIBln/kcUs5kHu6m4IGMTN+lYqjaz4N8aSis9XAy9/Aax1Jn3nM0dLjTyQ9n
         aFptYF37GvZLPJr3pMqEaEx0qjHIm8N2q+ZrGVNBUUhLV+bdk9zG8WwkRcJl5alsQBFu
         3EygmaRF43iCTbQ7py5jHDXhDXM2wTmi1q1cL3PJtR/1ac9IPwgdbpQ9CAgu9KKqcIT2
         t2ZA==
X-Gm-Message-State: APt69E3tADGg5OwdZ+asnRjkPB7ps4OS1i4bsY7PWU7IZYJj/TRiPX3v
        yTBgPtl3Q04C2hqSeOvLkGCvXA==
X-Google-Smtp-Source: ADUXVKIl40jJEgDnyEVD2tmZOKuZrkHwEUimHosKTI9kQxLJ54bWY86PzRpeudF8/8ScESZ+e5RpYw==
X-Received: by 2002:a17:902:b706:: with SMTP id d6-v6mr13563937pls.105.1529318326739;
        Mon, 18 Jun 2018 03:38:46 -0700 (PDT)
Received: from localhost ([122.167.164.190])
        by smtp.gmail.com with ESMTPSA id r79-v6sm29849807pfe.115.2018.06.18.03.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 03:38:46 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:08:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V7] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180618103844.t2minxwc7tiu2qgd@vireshk-i7>
References: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
 <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
 <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 12:35, Daniel Lezcano wrote:
> On 18/06/2018 12:22, Viresh Kumar wrote:
> > On 15-06-18, 11:19, Daniel Lezcano wrote:
> >> +/**
> >> + * idle_injection_stop - stops the idle injections
> >> + * @ii_dev: a pointer to an idle injection_device structure
> >> + *
> >> + * The function stops the idle injection and waits for the threads to
> >> + * complete. If we are in the process of injecting an idle cycle, then
> >> + * this will wait the end of the cycle.
> >> + *
> >> + * When the function returns there is no more idle injection
> >> + * activity. The kthreads are scheduled out and the periodic timer is
> >> + * off.
> >> + */
> >> +void idle_injection_stop(struct idle_injection_device *ii_dev)
> >> +{
> >> +	struct idle_injection_thread *iit;
> >> +	unsigned int cpu;
> >> +
> >> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
> >> +		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
> >> +
> >> +	hrtimer_cancel(&ii_dev->timer);
> >> +
> >> +	/*
> >> +	 * We want the guarantee we have a quescient point where
> >> +	 * parked threads stay in there state while we are stopping
> >> +	 * the idle injection. After exiting the loop, if any CPU is
> >> +	 * plugged in, the 'should_run' boolean being false, the
> >> +	 * smpboot main loop schedules the task out.
> >> +	 */
> >> +	cpu_hotplug_disable();
> >> +
> >> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> > 
> > Maybe you should do below for all CPUs in the mask. Is the below usecase
> > possible ?
> > 
> > - CPU0-4 are part of the mask and are all online.
> > - hrtimer fires and sets should_run for all of them to 1.
> 
>     ^^
> hrtimer_cancel gives you the guarantee, the timer is no longer active
> and there is no execution in the timer handler. So the timer can no
> longer fire after hrtimer_cancel() is called (which is a blocking call).

Right but that isn't called yet in my sequence.

> > - Right at this time CPU3 goes offline, so the thread gets parked with
> >   should_run == 1. Is there a reason why this can't happen ?
> > - Now we unregister the stuff and CPU3 again comes online.

It gets called here from unregister/stop.

> > - Because it had should_run as true, we again run the thread and Crash.
> > 
> > makes sense ?

> >> +out_rollback_per_cpu:
> >> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
> >> +		per_cpu(idle_injection_device, cpu) = NULL;
> > 
> > So if two parts of the kernel call this routine with the same cpumask, then the
> > second call will also overwrite the masks with NULL and return error. That will
> > screw up things a bit here.
> 
> Apparently there is a misunderstanding :)
> 
> https://lkml.org/lkml/2018/5/29/209 (at the end)

Right, your earlier version was doing the right thing :)

-- 
viresh
