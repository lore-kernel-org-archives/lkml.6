Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 223C4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB902208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYDZOiSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB902208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934118AbeFLOhW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:37:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35322 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933243AbeFLOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:37:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so24371810wrn.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9rHGchfFy0pbRO13HduTIdIeP3a+Mk7JvcWlwijNITU=;
        b=HYDZOiSuEpUSO0yGxxGYaYnbMfogibBoCX7t2YRn+a0391Ntox3wVUQqqAcQSC5Pkj
         XA1/Z8w3PPeZmrfTJJM7d7zmnbXk/f4ZZYFJ+n0t8fMtM6CtCJb+9iCDdk/t7elVgCT3
         M8lSNvE70SDlBsSWEbJc1PQJ3YJpuqa14uvnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9rHGchfFy0pbRO13HduTIdIeP3a+Mk7JvcWlwijNITU=;
        b=E0ywrKyueMeRHcjCTvWlb+csXJM2/G/IUvaKSFjcTAe2M24zTlukW6oUeYiSHTgIP5
         VAm0vAyerDjlolLp7wQHLTL6IgyTa0wKsbIvsRNbxvl8kdzHUqyIlF4fPUAoZ9GamGc6
         7l95k2+i8Jvj1RZNGLGKZ+WoeVsWGc7pjLQMBkA7DgVl2dcYz7SsAfZvtvaeBajikFqI
         NDGjC/gBb7Bb0MubvqSJdhvbyONnDLxFmAJLfihZp+ORR6eS/Re+1sulRT0GBelHFMbf
         cvaj0k6fEOyfBn8RLTqKAbFZXHY5tlUmeE4mRIYCNBe8l5Aa0EHb138zzyQpYdoxuVZG
         u+Jg==
X-Gm-Message-State: APt69E2I/Gm6IkCONS+0VWv8/r8zZeul8icL2O7v53XLQpbVOxVc9/ou
        t5zN/OgBzqDYnMo5wvOrZY6b+Q==
X-Google-Smtp-Source: ADUXVKKv8LT2FeNTN1/O2MbUXnYDuNcupp3JH0RG8enB3eQs+nzul+GVznzTcUIB8JhGTOgfuOEcJg==
X-Received: by 2002:adf:8e30:: with SMTP id n45-v6mr505258wrb.27.1528814239115;
        Tue, 12 Jun 2018 07:37:19 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:6506:4f49:e430:ddb9? ([2001:41d0:fe90:b800:6506:4f49:e430:ddb9])
        by smtp.googlemail.com with ESMTPSA id g105-v6sm448807wrd.37.2018.06.12.07.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 07:37:18 -0700 (PDT)
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
Date:   Tue, 12 Jun 2018 16:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 16:06, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 03:02:14PM +0200, Daniel Lezcano wrote:
>> On 12/06/2018 14:52, Peter Zijlstra wrote:
>>> In this case, you can do:
>>
>> That is what we had before but we change the code to set the count
>> before waking up the task, so compute the cpumask_weight of the
>> resulting AND right before this loop.
>>
>>> +       for_each_cpu_and(cpu, &ii_dev->cpumask, cpu_online_mask) {
>>> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
>>> +               iit->should_run = 1;
>>> +               wake_up_process(iit->tsk);
>>> +       }
> 
> 
> Ah, I see, but since you do:
> 
> 	if (atomic_dec_and_test())
> 	  last_man()
> 
> where that last_man() thing will start a timer, there is no real problem
> with doing atomic_inc() with before wake_up_process().

Viresh was worried about the scenario:

https://lkml.org/lkml/2018/6/5/276


> Yes, it allows doing last_man, too often, but repeated hrtimer_start()
> will DTRT and reprogram the timer.
> 
> Also, last_man() uses @run_duration, but the way I read it, the timer is
> for waking things up again, this means it is in fact the sleep duration,
> no?

No, it is the next idle injection deadline, meanwhile we let the system
continue running.

The sleep duration is managed by another timer in play_idle().

> Furthermore, should you not be using hrtimer_forward(&timer,
> idle_duration + run_duration) instead? AFAICT the current scheme is
> prone to drifting.

(I assume you meant setting the timer in the wakeup task function).

Yes, drifting is not an issue if that happens. This scheme is simpler
and safer than setting the timer ahead before waking up the tasks with
the risk it expires before all the tasks ended their idle cycles.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

