Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5027C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624A42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVITtS3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624A42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937415AbeFSIAv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:00:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35770 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937236AbeFSIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:00:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id l10-v6so19493339wrn.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19WTOQeE48zfzCYPswmO+Llpk5l4XwnVt1Z2gXecbW8=;
        b=FVITtS3xG/4B7007B0FYkdV7zRd70pPA4c6SxRpyiIOFx9WA4gPyY/V9Pm/G3ECk2b
         pR3D/2SMixFEo+TbA5Rp1EUz6MJmdHLJElV+CT9wKwUijls4dzeugo4D6qnaA9zkUKoO
         zXHjWQk0/ogGylzyNO5WMwTZZXM/rY9GzAb5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19WTOQeE48zfzCYPswmO+Llpk5l4XwnVt1Z2gXecbW8=;
        b=hrnx02WB1Lxq7PEoToWyw29CnK9fAEjDxiebZspT5y8kDDKsCJzOGwXwRWAD326Nws
         XcLAjiTsAC0VF3fAiMimq2aydSVFJNcVzvRM5d7p1q369hH6nnB5Q7SmLyQn+7aMCHT9
         M1Ttjv+YeZTcA4vivgrAo/ufc9SFVK6HA2yhb/QEinQjxMpqj7eK0wYEhHh6feu4kuX9
         EYQTWD+t4MqLQaY6i94ZDPG2jbehNJpDxRdxGhlHFCI5+FLOZN8KKZs7FwD9MdklZPWg
         elB8PF70wB2o+KpTsKTTPPhe1/kZE0rZZJciYhY/dgt/eHNnk0QNopLV+vyiaejE2LjL
         yf6g==
X-Gm-Message-State: APt69E2emurdCJ3IVlkx1PftLIcuFR/hOb+Quhsc04Szyot5OFwnUdzL
        rMZRTHeVaY0ntfQohmN1EkzGmg==
X-Google-Smtp-Source: ADUXVKKO3FyKUJCZvhRC7Toj77MM6RDlcHg3HaODmuuSDcAzh8c9lUhdlK0eKyXjksxatQeSCemSKw==
X-Received: by 2002:adf:de82:: with SMTP id w2-v6mr13773561wrl.88.1529395248029;
        Tue, 19 Jun 2018 01:00:48 -0700 (PDT)
Received: from [192.168.0.82] (135-224-190-109.dsl.ovh.fr. [109.190.224.135])
        by smtp.googlemail.com with ESMTPSA id b80-v6sm11573382wmf.2.2018.06.19.01.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:00:47 -0700 (PDT)
Subject: Re: [PATCH v8] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
References: <1529387906-3838-1-git-send-email-daniel.lezcano@linaro.org>
 <20180619062227.uyan2t63fqwxj3eb@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bbc73374-194d-2c3f-fce7-e4b6de0a12bb@linaro.org>
Date:   Tue, 19 Jun 2018 10:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619062227.uyan2t63fqwxj3eb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2018 08:22, Viresh Kumar wrote:
> On 19-06-18, 07:58, Daniel Lezcano wrote:
>> +++ b/drivers/powercap/idle_injection.c
>> @@ -0,0 +1,375 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * The idle injection framework proposes a way to force a cpu to enter
>> + * an idle state during a specified amount of time for a specified
>> + * period.
>> + *
>> + * It relies on the smpboot kthreads which handles, via its main loop,
>> + * the common code for hotplugging and [un]parking.
>> + *
>> + * At init time, all the kthreads are created.
>> + *
>> + * A cpumask is specified as parameter for the idle injection
>> + * registering function. The kthreads will be synchronized regarding
>> + * this cpumask.
>> + *
>> + * The idle + run duration is specified via the helpers and then the
>> + * idle injection can be started at this point.
>> + *
>> + * A kthread will call play_idle() with the specified idle duration
>> + * from above.
>> + *
>> + * A timer is set after waking up all the tasks, to the next idle
>> + * injection cycle.
>> + *
>> + * The task handling the timer interrupt will wakeup all the kthreads
>> + * belonging to the cpumask.
>> + *
>> + * Stopping the idle injection is synchonuous, when the function
> 
>                                      synchronous
> 
>> + * returns, there is the guarantee there is no more idle injection
>> + * kthread in activity.
>> + *
>> + * It is up to the user of this framework to provide a lock at an
>> + * upper level to prevent stupid things to happen, like starting while
>> + * we are unregistering.
>> + */
> 
>> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
>> +{
>> +	struct idle_injection_thread *iit;
>> +	unsigned int cpu;
>> +
>> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
>> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> +		iit->should_run = 1;
>> +		wake_up_process(iit->tsk);
>> +	}
>> +}
> 
> Thread A                                        Thread B
> 
>                                                 CPU3 hotplug out
>                                                 -> idle_injection_park()
>                                                   iit(of-CPU3)->should_run = 0;
> 
> idle_injection_wakeup()
>  for_each_cpu_and(online)..
>    CPU3-selected
>                                                 clear CPU3 from cpu-online mask.
> 
> 
>    iit(of-CPU3)->should_run = 1;
>    wake_up_process()
> 
> With the above sequence of events, is it possible that the iit->should_run
> variable is set to 1 while the CPU is offlined ? And so the crash we discussed
> in the previous version may still exist ? Sorry I am not able to take my mind
> away from thinking about these stupid races :(

If I refer to previous Peter's comment about a similar race, I think it
is possible.

I guess setting the should_run flag to zero in the unpark() must fix the
issue also.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

