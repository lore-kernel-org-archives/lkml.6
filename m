Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2B0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWlly4lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2B0214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJKARh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:17:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39561 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:17:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so6531498wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eGSctD7DxRoQ/l+bfjpbUU1rKv8QWDoJjYp9DdpmNWE=;
        b=JWlly4lfrqzy8AXT9dS/avnAV5ok5iVpvj16NoSVX2KaXTF1XU3k55Fp8bglDxDEvZ
         9ywBNrYvOYaYtwwwZhHCHFEAIJyd1fkAu16JihMoEBR4y1oaGui1X9BjqkcvBzEKty7K
         zBstDM5k1z1JSl6gaBLu55Abvc5kkEMYj9Cwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGSctD7DxRoQ/l+bfjpbUU1rKv8QWDoJjYp9DdpmNWE=;
        b=Mj/rwZB4MpeceCk2bsdgOjIcyq+Nu1j4+Qv3bNyJvW5D+hCRs3SxO5W3ZoHB7AzXRb
         WwEmbWGa0EB0D5FOiPO2zIn6RqGGKEGlTfniqwFsYTgE4yNpvidZgCShOBW5YrLAATMl
         ztxeVvGnzPPKcpWZ4FTjRGtaN3ff02nVE3+4wDXiab9wOC/5v1RTU5YAr+zWad3dcsaC
         YvhiX0My7f3rhgu60MzRIeMAQXpCRDipOkYwOE8JTUL6VRkR2jF9EdiRBrf0sXdrGOK2
         GUp2sqQK6CCWgGQ/rg6fR2KUEMu/dinVjFHs0DqMqFBCRUgMLJvmfPdhWbduD2ueo6mu
         BNTg==
X-Gm-Message-State: ABuFfognjQrCSP9erzLxEtimApo8GQfj3JKBcksb6arQUUq7TY8THC71
        y9xaqXb7ZqvvOacOO51jrdnUlw==
X-Google-Smtp-Source: ACcGV60vfUnSMqGBq8sj7zZ+TrkOOk6C7UEzcr3PvgYnk3QWuCe0ps1ejQoeNLB5HIJCPwCb2pAqjg==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr13394183wru.105.1539190475049;
        Wed, 10 Oct 2018 09:54:35 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id u5-v6sm33571660wru.16.2018.10.10.09.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 09:54:34 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
 <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e2091e7e-b6e6-950d-ebab-18ba2de9264f@linaro.org>
Date:   Wed, 10 Oct 2018 18:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 17:35, Lukasz Luba wrote:
> Hi Thara,
> 
> I have run it on Exynos5433 mainline.
> When it is enabled with step_wise thermal governor,
> some of my tests are showing ~30-50% regression (i.e. hackbench),
> dhrystone ~10%.
> 
> Could you tell me which thermal governor was used in your case?
> Please also share the name of that benchmark, i will give it a try.
> Is it single threaded compute-intensive?

aobench AFAICT

It would be interesting if you can share the thermal profile of your board.


> On 10/09/2018 06:24 PM, Thara Gopinath wrote:
>> Thermal governors can respond to an overheat event for a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in linux kernel, in event of maximum
>> frequency capping of a cpu, the maximum available compute
>> capacity of the cpu is not adjusted at all. In other words, scheduler
>> is unware maximum cpu capacity restrictions placed due to thermal
>> activity. This patch series attempts to address this issue.
>> The benefits identified are better task placement among available
>> cpus in event of overheating which in turn leads to better
>> performance numbers.
>>
>> The delta between the maximum possible capacity of a cpu and
>> maximum available capacity of a cpu due to thermal event can
>> be considered as thermal pressure. Instantaneous thermal pressure
>> is hard to record and can sometime be erroneous as there can be mismatch
>> between the actual capping of capacity and scheduler recording it.
>> Thus solution is to have a weighted average per cpu value for thermal
>> pressure over time. The weight reflects the amount of time the cpu has
>> spent at a capped maximum frequency. To accumulate, average and
>> appropriately decay thermal pressure, this patch series uses pelt
>> signals and reuses the available framework that does a similar
>> bookkeeping of rt/dl task utilization.
>>
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on hikey960 mainline kernel with debian file system.
>> Further aobench (An occlusion renderer for benchmarking realworld
>> floating point performance) showed the following results on hikey960
>> with debain.
>>
>>                                          Result          Standard        Standard
>>                                          (Time secs)     Error           Deviation
>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>
>> Thara Gopinath (7):
>>    sched/pelt: Add option to make load and util calculations frequency
>>      invariant
>>    sched/pelt.c: Add support to track thermal pressure
>>    sched: Add infrastructure to store and update instantaneous thermal
>>      pressure
>>    sched: Initialize per cpu thermal pressure structure
>>    sched/fair: Enable CFS periodic tick to update thermal pressure
>>    sched/fair: update cpu_capcity to reflect thermal pressure
>>    thermal/cpu-cooling: Update thermal pressure in case of a maximum
>>      frequency capping
>>
>>   drivers/base/arch_topology.c  |  1 +
>>   drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
>>   include/linux/sched.h         | 14 +++++++++
>>   kernel/sched/Makefile         |  2 +-
>>   kernel/sched/core.c           |  2 ++
>>   kernel/sched/fair.c           |  4 +++
>>   kernel/sched/pelt.c           | 40 ++++++++++++++++++--------
>>   kernel/sched/pelt.h           |  7 +++++
>>   kernel/sched/sched.h          |  1 +
>>   kernel/sched/thermal.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/thermal.h        | 13 +++++++++
>>   11 files changed, 157 insertions(+), 13 deletions(-)
>>   create mode 100644 kernel/sched/thermal.c
>>   create mode 100644 kernel/sched/thermal.h
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

