Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1837C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOpcGfM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC20C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934298AbeFRL2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:28:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54389 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933481AbeFRL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:28:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so13402117wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j6rzjPqkd5J5vev4JfE1DpslIaGumNJv5GrkhC7U8NU=;
        b=bOpcGfM2Ufz0Nw23eZ2CAazt32YQ5uCroOl8V3rpcVa3KVXS0IiHuMvhkuPHUqjgpl
         wmxESXfToPqoPllsNzldrXiHM7OFz5vuIeW73k6eLGYHbK9XnqaHBtHX6JaTNmHg5n5q
         MyARlJyqwVNdDJHw74f4R/cCN4iqcKNLX397I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j6rzjPqkd5J5vev4JfE1DpslIaGumNJv5GrkhC7U8NU=;
        b=IBqJnd9nXidV/Eamm9F3cZN5rvZ4xDswyVVi1S6PMcePuA4USbPyQ5gfLjFyxAYvlZ
         LJKviU0tAa/53JIPmjLaW0VIrai2Z56RyjtNEvfQOJdX+HsB018++v2P0GpPV9JLH0ve
         72ED5yVQ71plzxIbhdBPRGWrKqCgmVN8eRejmd5P0WIVE3U3bcqo2PoC18CTRWZtBOFF
         k2JnYVyqtJhnDjuBV3QNxgUN5nU0jrkQUDTUPpMCKu/x6Ll/5pGcFmiBKej5Ma+wKYFL
         MqKystjUsHf35TiY1Zpdld4yDtfvIGT0c8bZzdxU5TmkezjZa0gwJbNrh/mbPv744D1u
         nLQg==
X-Gm-Message-State: APt69E3ubo+Ex/T3HEUB+O3LT5IC/2AXOTzd8KECUdag9hwpJze3TvE+
        uk5hKZ2pOaXO71vO0EfoZ77KRQ==
X-Google-Smtp-Source: ADUXVKKvcckClT/FIDLw+IMB6kWbBwfwgs+fIF7sIFrBAWs38qBxSy5v4ZHpkozmtqnv338c5Aav3g==
X-Received: by 2002:a1c:150:: with SMTP id 77-v6mr8859195wmb.3.1529321302091;
        Mon, 18 Jun 2018 04:28:22 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:781a:ae4b:958c:76a1? ([2001:41d0:fe90:b800:781a:ae4b:958c:76a1])
        by smtp.googlemail.com with ESMTPSA id p38-v6sm33714596wrc.11.2018.06.18.04.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 04:28:21 -0700 (PDT)
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
 <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
 <20180618103844.t2minxwc7tiu2qgd@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <883320cc-5677-6612-1565-b5a05b8684e1@linaro.org>
Date:   Mon, 18 Jun 2018 13:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618103844.t2minxwc7tiu2qgd@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2018 12:38, Viresh Kumar wrote:
> On 18-06-18, 12:35, Daniel Lezcano wrote:
>> On 18/06/2018 12:22, Viresh Kumar wrote:
>>> On 15-06-18, 11:19, Daniel Lezcano wrote:
>>>> +/**
>>>> + * idle_injection_stop - stops the idle injections
>>>> + * @ii_dev: a pointer to an idle injection_device structure
>>>> + *
>>>> + * The function stops the idle injection and waits for the threads to
>>>> + * complete. If we are in the process of injecting an idle cycle, then
>>>> + * this will wait the end of the cycle.
>>>> + *
>>>> + * When the function returns there is no more idle injection
>>>> + * activity. The kthreads are scheduled out and the periodic timer is
>>>> + * off.
>>>> + */
>>>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>>>> +{
>>>> +	struct idle_injection_thread *iit;
>>>> +	unsigned int cpu;
>>>> +
>>>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>>>> +		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
>>>> +
>>>> +	hrtimer_cancel(&ii_dev->timer);
>>>> +
>>>> +	/*
>>>> +	 * We want the guarantee we have a quescient point where
>>>> +	 * parked threads stay in there state while we are stopping
>>>> +	 * the idle injection. After exiting the loop, if any CPU is
>>>> +	 * plugged in, the 'should_run' boolean being false, the
>>>> +	 * smpboot main loop schedules the task out.
>>>> +	 */
>>>> +	cpu_hotplug_disable();
>>>> +
>>>> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
>>>
>>> Maybe you should do below for all CPUs in the mask. Is the below usecase
>>> possible ?
>>>
>>> - CPU0-4 are part of the mask and are all online.
>>> - hrtimer fires and sets should_run for all of them to 1.
>>
>>     ^^
>> hrtimer_cancel gives you the guarantee, the timer is no longer active
>> and there is no execution in the timer handler. So the timer can no
>> longer fire after hrtimer_cancel() is called (which is a blocking call).
> 
> Right but that isn't called yet in my sequence.
> 
>>> - Right at this time CPU3 goes offline, so the thread gets parked with
>>>   should_run == 1. Is there a reason why this can't happen ?

for this specific case, we can use the park() callback to set should_run
to false, no ?

>>> - Now we unregister the stuff and CPU3 again comes online.
> 
> It gets called here from unregister/stop.
> 
>>> - Because it had should_run as true, we again run the thread and Crash.
>>>
>>> makes sense ?
> 
>>>> +out_rollback_per_cpu:
>>>> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
>>>> +		per_cpu(idle_injection_device, cpu) = NULL;
>>>
>>> So if two parts of the kernel call this routine with the same cpumask, then the
>>> second call will also overwrite the masks with NULL and return error. That will
>>> screw up things a bit here.
>>
>> Apparently there is a misunderstanding :)
>>
>> https://lkml.org/lkml/2018/5/29/209 (at the end)
> 
> Right, your earlier version was doing the right thing :)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

