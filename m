Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E719ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6B420658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWq0o+B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6B420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJRARw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:17:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45684 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeJRARv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:17:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so16841561qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WrfAD2+3i7ZJ95a4/drlAFrIwUpse9bbWec9AmIVWeY=;
        b=HWq0o+B0MECQTEuDQoU2HMFEqdIkDtambj6jY0HSV5oM1jCpdTKkzrJqSvEY18igxX
         kv7s+wrxiV6EU3BgS2Vkl+GJWYGKoarCURg2XixipBFRDwrReQOLB+o45UL5VlzufL7s
         QpIwWoKu4BsWFmediMkC5xQ159/l739oq6RIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WrfAD2+3i7ZJ95a4/drlAFrIwUpse9bbWec9AmIVWeY=;
        b=L9YhyGSl0Mz1WdeBDHM/n1GrLipkG8oCo2B13cJcp1SHQXgZXDJGT4tBv/ZrHQFMyy
         fPoN/qPkOlGa6LNHtud/ESP8FdzZAd01vZu0bzUnNGn3/BXRUzW94iy9aZzsT39hcG3q
         xhSr92GCjO6gb99o7X8XpbeONUEF/MSlxYY9etkawqDVdEkoX3eiIKdLiAeooC3HNp2g
         Qcg4pYuScqA/wO7/zN5iHeKFCEcoEddUxnFV0g1TQd7s8A7HtL7AH2mo2XY+EXE4UkIz
         Xx33tzupkepnXOpYkj57F1BZMF2HDi2/ilqggsn2OD5UtYE33Ddr7XdLp/MtBzcJUvGi
         8KFQ==
X-Gm-Message-State: ABuFfoiP1Tld2MaBMiNlCX0ARyGA9+RAvm0stY4GKZIlv8BlF0zKidX9
        RQZBh/C3ONPg3Lp3xndDp6zZGQ==
X-Google-Smtp-Source: ACcGV60sAnksfmVrlFhXmwJO9mWZrhFfobCWJdosIkSnm26y7w8x6SvmVa+I0PnQkylo1K5udQvzNw==
X-Received: by 2002:a37:3bc1:: with SMTP id i184-v6mr2245831qka.286.1539793284125;
        Wed, 17 Oct 2018 09:21:24 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id l3-v6sm20084272qtl.2.2018.10.17.09.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:21:22 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Ingo Molnar <mingo@kernel.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BC76181.90105@linaro.org>
Date:   Wed, 17 Oct 2018 12:21:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181016073305.GA64994@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 03:33 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>>>> Regarding testing, basic build, boot and sanity testing have been
>>>> performed on hikey960 mainline kernel with debian file system.
>>>> Further aobench (An occlusion renderer for benchmarking realworld
>>>> floating point performance) showed the following results on hikey960
>>>> with debain.
>>>>
>>>>                                         Result          Standard        Standard
>>>>                                         (Time secs)     Error           Deviation
>>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>>
>>> Wow, +13% speedup, impressive! We definitely want this outcome.
>>>
>>> I'm wondering what happens if we do not track and decay the thermal 
>>> load at all at the PELT level, but instantaneously decrease/increase 
>>> effective CPU capacity in reaction to thermal events we receive from 
>>> the CPU.
>>
>> The problem with instantaneous update is that sometimes thermal events 
>> happen at a much faster pace than cpu_capacity is updated in the 
>> scheduler. This means that at the moment when scheduler uses the 
>> value, it might not be correct anymore.
> 
> Let me offer a different interpretation: if we average throttling events 
> then we create a 'smooth' average of 'true CPU capacity' that doesn't 
> fluctuate much. This allows more stable yet asymmetric task placement if 
> the thermal characteristics of the different cores is different 
> (asymmetric). This, compared to instantaneous updates, would reduce 
> unnecessary task migrations between cores.
> 
> Is that accurate?

Yes. I think it is accurate. I will also add that if we don't average
throttling events, we will miss the events that occur in between load
balancing(LB) period.

> 
> If the thermal characteristics of the cores is roughly symmetric and the 
> measured CPU-intense load itself is symmetric as well, then I have 
> trouble seeing why reacting to thermal events should make any difference 
> at all.
In this scenario, i agree that scheduler reaction to thermal events
should not make any difference in fact we should not observe any
improvement or degradation in performance.

> 
> Are there any inherent asymmetries in the thermal properties of the 
> cores, or in the benchmarked workload itself?

The benchmarked workload , meaning aobench? I don't think there arre any
asymmetries there. On Hikey960, there are two clusters with different
frequency domains. So yes I will say there is asymmetry there. Asides,
IMHO, any other tasks running on the system can create an inherent
asymmetry as cpu utilizations can vary.

Regards
Thara
> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara
