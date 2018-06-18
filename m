Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3163C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B870208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjCt9WTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B870208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936905AbeFRKgD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:36:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39012 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934091AbeFRKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:36:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so16256712wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iEOZPvaTUCClcxwfPwAx5WQa0EttNW1QyV9d62M81f0=;
        b=JjCt9WTvGW88rkYsu1zi9xunBrgQ1ZHjYW4Vh5v2Mb+ZRSiRsSn1hwgEO2HBHEtZFJ
         HbxTaOoQkLsiPpNqL71m5Xla7isU3iXNpZzWgt3flvrD0YXdIS56cTZHsnVnKS5vSMiN
         r68INjJR8BPSuEPp+I1BmL4PfbslgIJ888y38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iEOZPvaTUCClcxwfPwAx5WQa0EttNW1QyV9d62M81f0=;
        b=d5u07WfRm3GhYTe2A1cYlQSbc4DHzseb+6bw2sIq5tiiUJpDRVcTIOJz2MRJ/xBMk3
         pPqUrhH8XIdSQBfHMozsUIWSWAeq+SQEYMe08XGYok3/A75KdfzIDyNio19vcnd0qn4u
         T0MgQ+gX7Z4AGnU1UZKjJFBRpLABl5Nz4YZNBVM+bPV4NWGKDfCSO5yKCJ8KzvxZrZ/g
         wuMeY+I+HBb5mdXT1dIBO/HEyxne0u2w4weXkmrobfYS4WdVkrti5iMlW1Bs4gIy5FJV
         ww9k4s8ASgKyRkC6ck3nQOxL0MQGDA3ra3hVOk3Xi7wxEIgDYgGpD/q0TQovzz9DcDTc
         VZdA==
X-Gm-Message-State: APt69E1IQfhpWKAU6O0GVz7r53wHp+vO9YeplMKRQgs6ZSX1rUyhUKhr
        aXZoRWFRpIZCQzby8Um+hOe+Jw==
X-Google-Smtp-Source: ADUXVKLgXsPRRyWVTOgBThZEFMgiRva/c/3+gzWaUDIGaqMfn18hYQCF6dSKB3fjSyK4E1c5u+qzbw==
X-Received: by 2002:a5d:4049:: with SMTP id w9-v6mr10148070wrp.96.1529318159203;
        Mon, 18 Jun 2018 03:35:59 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:781a:ae4b:958c:76a1? ([2001:41d0:fe90:b800:781a:ae4b:958c:76a1])
        by smtp.googlemail.com with ESMTPSA id n18-v6sm18246499wrj.58.2018.06.18.03.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 03:35:58 -0700 (PDT)
Subject: Re: [PATCH V7] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
References: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
 <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
Date:   Mon, 18 Jun 2018 12:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2018 12:22, Viresh Kumar wrote:
> On 15-06-18, 11:19, Daniel Lezcano wrote:
>> +/**
>> + * idle_injection_stop - stops the idle injections
>> + * @ii_dev: a pointer to an idle injection_device structure
>> + *
>> + * The function stops the idle injection and waits for the threads to
>> + * complete. If we are in the process of injecting an idle cycle, then
>> + * this will wait the end of the cycle.
>> + *
>> + * When the function returns there is no more idle injection
>> + * activity. The kthreads are scheduled out and the periodic timer is
>> + * off.
>> + */
>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>> +{
>> +	struct idle_injection_thread *iit;
>> +	unsigned int cpu;
>> +
>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
>> +
>> +	hrtimer_cancel(&ii_dev->timer);
>> +
>> +	/*
>> +	 * We want the guarantee we have a quescient point where
>> +	 * parked threads stay in there state while we are stopping
>> +	 * the idle injection. After exiting the loop, if any CPU is
>> +	 * plugged in, the 'should_run' boolean being false, the
>> +	 * smpboot main loop schedules the task out.
>> +	 */
>> +	cpu_hotplug_disable();
>> +
>> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> 
> Maybe you should do below for all CPUs in the mask. Is the below usecase
> possible ?
> 
> - CPU0-4 are part of the mask and are all online.
> - hrtimer fires and sets should_run for all of them to 1.

    ^^
hrtimer_cancel gives you the guarantee, the timer is no longer active
and there is no execution in the timer handler. So the timer can no
longer fire after hrtimer_cancel() is called (which is a blocking call).

> - Right at this time CPU3 goes offline, so the thread gets parked with
>   should_run == 1. Is there a reason why this can't happen ?
> - Now we unregister the stuff and CPU3 again comes online.
> - Because it had should_run as true, we again run the thread and Crash.
> 
> makes sense ?


>> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> +		iit->should_run = 0;
>> +
>> +		wait_task_inactive(iit->tsk, 0);
> 
> I am not very sure of what guarantees this will provide.

We get the guarantee any idle injection cycle is ended.

> @Peter: Do you see any more race scenarios here ?
> 
>> +	}
>> +
>> +	cpu_hotplug_enable();
>> +}
> 
>> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
>> +{
>> +	struct idle_injection_device *ii_dev;
>> +	int cpu;
>> +
>> +	ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
>> +	if (!ii_dev)
>> +		return NULL;
>> +
>> +	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	ii_dev->timer.function = idle_injection_wakeup_fn;
>> +
>> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>> +
>> +		if (per_cpu(idle_injection_device, cpu)) {
>> +			pr_err("cpu%d is already registered\n", cpu);
>> +			goto out_rollback_per_cpu;
>> +		}
>> +
>> +		per_cpu(idle_injection_device, cpu) = ii_dev;
>> +	}
>> +
>> +	return ii_dev;
>> +
>> +out_rollback_per_cpu:
>> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
>> +		per_cpu(idle_injection_device, cpu) = NULL;
> 
> So if two parts of the kernel call this routine with the same cpumask, then the
> second call will also overwrite the masks with NULL and return error. That will
> screw up things a bit here.

Apparently there is a misunderstanding :)

https://lkml.org/lkml/2018/5/29/209 (at the end)



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

