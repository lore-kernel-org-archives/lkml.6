Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8KisD7I8GVu8NgAAmS7hNA
	; Thu, 07 Jun 2018 14:11:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2F7A3608BA; Thu,  7 Jun 2018 14:11:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kT37NPXl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A2B94607DC;
	Thu,  7 Jun 2018 14:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2B94607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeFGOLH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:11:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40835 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeFGOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:11:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so19476898wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o1Q48xep+oSfSgwhPdpkG4OeimmgXTnAy1K9s3bqo1w=;
        b=kT37NPXlh43+uj0oiW837j2ZU/IGWPqNeQEKDuI2BmC/PpNHQzVxlpSEvraL3FJgVc
         QwCIxzGwt2nA0ahezcguIx0YeKXHD7EiQU8UnewS8YZUv5yEfAknbcHHOlqM8Ay2B4nx
         0Zk0OD3R3rdEb+Njlk36fKG8eaUYcCEk9IB4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o1Q48xep+oSfSgwhPdpkG4OeimmgXTnAy1K9s3bqo1w=;
        b=ImkMKYXBxSvrXobuopH6LCF8Q/i3UtigTPUj0S62n0wPrWZTSAVGeOj+RMF4RHK9Om
         HZF2PDwEbOAzvMYxFMlCxbK5KAFfETi/g6QGFuBGCAtrgLpYY4z1aB5h8wL/CUlo/C90
         O/hoHsH2Z8w1d+j3TDJQCjXugI/MBgVG+dUDTaXOFmHu1eTbiGObpVlKEVBEMmAK4fpe
         yUEmmD0RBSSAq5aYb41RQM85mLYugLvxcelRiWU0fQXNLcjAhOUc21npWPbb0lHiZk4B
         5r/yvtLm99bLzkdAOThl9w0OpfaiiGetp7ZGz8J314j+qJgCmG6vPZ77vsNZVIIZn1+T
         zYEw==
X-Gm-Message-State: APt69E0ch+PJHWqks7Xff/j86Dd9y4XjsdlcxjBzxyC8kX3QXXSBt03M
        aEXWaMsKhfodsoT/OyGw2htotQ==
X-Google-Smtp-Source: ADUXVKLbRVU6FCOqdGxEH4o8GjdScabd3tec23spKTy/IJiuYQByw+ZTkbA52l1k62+BAY5oKcmQEg==
X-Received: by 2002:a1c:448b:: with SMTP id r133-v6mr1659123wma.55.1528380663275;
        Thu, 07 Jun 2018 07:11:03 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id g75-v6sm2843578wmd.15.2018.06.07.07.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:11:02 -0700 (PDT)
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d542490-fcb5-33fd-ab3b-eddf3d300bd4@linaro.org>
Date: Thu, 7 Jun 2018 16:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 12:45, Viresh Kumar wrote:
> On 06-06-18, 12:22, Daniel Lezcano wrote:
>> (mb() are done in the atomic operations AFAICT).
> 
> AFAIU, it is required to make sure the operations are seen in a particular order
> on another CPU and the compiler doesn't reorganize code to optimize it.
> 
> For example, in our case what if the compiler reorganizes the atomic-set
> operation after wakeup-process ? But maybe that wouldn't happen across function
> calls and we should be safe then.
> 
>> What about:
>>
>> 	get_online_cpus();
>>
>> 	nr_tasks = cpumask_weight(
>> 		cpumask_and(ii_dev->cpumask, cpu_online_mask);
>> 			
>> 	atomic_set(&ii_dev->count, nr_tasks);
>>
>> 	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
>> 		iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> 		iit->should_run = 1;
>> 		wake_up_process(iit->tsk);
>> 	}
>>
>> 	put_online_cpus();
>> ?
> 
> Looks good this time.
> 
>> I'm wondering if we can have a CPU hotplugged right after the
>> 'put_online_cpus', resulting in the 'should park' flag set and then the
>> thread goes in the kthread_parkme instead of jumping back the idle
>> injection function and decrease the count, leading up to the timer not
>> being set again.
> 
> True. That looks like a valid problem to me as well.
> 
> What about starting the hrtimer right from this routine itself, after taking
> into account running-time, idle-time, delay, etc ? That would get rid of the
> count stuff, this get_online_cpus(), etc.
> 
> Even if we restart the next play-idle cycle a bit early or with some delay, sky
> wouldn't fall :)

We won't be able to call completion() in this case.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
