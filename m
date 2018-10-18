Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FAAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5C7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDgxQN3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5C7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeJSAT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:19:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44171 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbeJSAT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:19:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so19107431qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Rj9eN+RNwHNUP+x/7EyQVnEz5FheLdyxjsLvXYNdINg=;
        b=aDgxQN3AjbRkVer8YzZ/DMIBLpAsiLrFDQ4wbh6sTEjsjJ+2KQkRi4xKSD3tw2yjtm
         spIcTANP72If9HPACGg1afh1j9Bzirc1Csz3DhEIR7DYaimVZsFUJMl1EsU2Ca6biubu
         UeWvpjx0g4SbaWhSFCHHzehl5EWT+fM/qGjfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Rj9eN+RNwHNUP+x/7EyQVnEz5FheLdyxjsLvXYNdINg=;
        b=dlQ0HCtzoJaX25IsTvlG+IQm/yIfLGD0JhMRea42/AzGWRo5KfhlGFwzm+ux6Qc2m5
         kgR3g3ckbO66LGAsLXlQBiyffEnoCKxOYGSJRCpzmnO0sK89lHMbbOXx8bvq8JMh7YHh
         aWk3ez6c1hXOQTiSXoqwQfPEW/9JeDzELvZkTyREtqFctXRx/uj+uoAie8U8yvgAr2hJ
         TQxfywLhXFl5co8HgalFl+WzKoEyMPHTZz8QChrpxYKPaeOwoEoB8hf6R653CvtIU2FT
         pts+ACvB9N79uzY2sCeSjyCK/0FPKIztENo4eMHifHWJNCxWKnj35Fe2Lr9zNboFo9QW
         4jVw==
X-Gm-Message-State: ABuFfoiro1NkoJf/Wb1CWBxWYbZz3GP4XP/znSp5LDdrI/Z0ooZ5ANgN
        mhMfGHnGgg1esARVasAbz0fHIA==
X-Google-Smtp-Source: ACcGV62wsLKqZ5m1BpcbkJWkLoBpqYST67sCzS572v7JuKiFHlHzRQszTyGBDN6UgBbLwCn8FtyXYQ==
X-Received: by 2002:a37:9985:: with SMTP id b127-v6mr29800946qke.155.1539879465632;
        Thu, 18 Oct 2018 09:17:45 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id y50-v6sm12440160qta.60.2018.10.18.09.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:17:44 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Ingo Molnar <mingo@kernel.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com> <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BC8B226.2040109@linaro.org>
Date:   Thu, 18 Oct 2018 12:17:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181018064849.GA42813@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 02:48 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>> On 10/16/2018 03:33 AM, Ingo Molnar wrote:
>>>
>>> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>>
>>>>>> Regarding testing, basic build, boot and sanity testing have been
>>>>>> performed on hikey960 mainline kernel with debian file system.
>>>>>> Further aobench (An occlusion renderer for benchmarking realworld
>>>>>> floating point performance) showed the following results on hikey960
>>>>>> with debain.
>>>>>>
>>>>>>                                         Result          Standard        Standard
>>>>>>                                         (Time secs)     Error           Deviation
>>>>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>>>>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>>>>
>>>>> Wow, +13% speedup, impressive! We definitely want this outcome.
>>>>>
>>>>> I'm wondering what happens if we do not track and decay the thermal 
>>>>> load at all at the PELT level, but instantaneously decrease/increase 
>>>>> effective CPU capacity in reaction to thermal events we receive from 
>>>>> the CPU.
>>>>
>>>> The problem with instantaneous update is that sometimes thermal events 
>>>> happen at a much faster pace than cpu_capacity is updated in the 
>>>> scheduler. This means that at the moment when scheduler uses the 
>>>> value, it might not be correct anymore.
>>>
>>> Let me offer a different interpretation: if we average throttling events 
>>> then we create a 'smooth' average of 'true CPU capacity' that doesn't 
>>> fluctuate much. This allows more stable yet asymmetric task placement if 
>>> the thermal characteristics of the different cores is different 
>>> (asymmetric). This, compared to instantaneous updates, would reduce 
>>> unnecessary task migrations between cores.
>>>
>>> Is that accurate?
>>
>> Yes. I think it is accurate. I will also add that if we don't average
>> throttling events, we will miss the events that occur in between load
>> balancing(LB) period.
> 
> Yeah, so I'd definitely suggest to not integrate this averaging into 
> pelt.c in the fashion presented, because:
> 
>  - This couples your thermal throttling averaging to the PELT decay
>    half-time AFAICS, which would break the other user every time the
>    decay is changed/tuned.
Let me pose the question in this manner. Today rt utilization, dl
utilization etc is tracked via PELT. The inherent idea is that, a cpu
has some capacity stolen by let us say rt task and so subtract the
capacity utilized by the rt task from cpu when calculating the remaining
capacity for a CFS task. Now, the idea behind thermal pressure is that,
the maximum available capacity of a cpu is limited due to a thermal
event, so take it out of the remaining capacity of a cpu for a CFS task
(at-least to start with). If utilization for rt task, dl task etc is
calculated via PELT and the capacity constraint due to thermal event
calculated by another averaging algorithm, there can be some mismatch in
the "capacity stolen" calculations, right? Isnt't it better to track all
the events that can limit the capacity of a cpu via one algorithm ?

> 
>  - The boolean flag that changes behavior in pelt.c is not particularly
>    clean either and complicates the code.

I agree. Part of the idea behind this RFC patch set was to brainstorm if
there is a better approach to this.
> 
>  - Instead maybe factor out a decaying average library into
>    kernel/sched/avg.h perhaps (if this truly improves the code), and use
>    those methods both in pelt.c and any future thermal.c - and maybe
>    other places where we do decaying averages.
> 
>  - But simple decaying averages are not that complex either, so I think
>    your original solution of open coding it is probably fine as well. 
> 
> Furthermore, any logic introduced by thermal.c and the resulting change 
> to load-balancing behavior would have to be in perfect sync with cpufreq 
> governor actions - one mechanism should not work against the other.
I agree. I will go one step further and argue that the changes here make
best sense with sched util governor as it picks up the signals directly
from the scheduler to choose an OPP. Any other governor will be less
effective.


> 
> The only long term maintainable solution is to move all high level 
> cpufreq logic and policy handling code into kernel/sched/cpufreq*.c, 
> which has been done to a fair degree already in the past ~2 years - but 
> it's unclear to me to what extent this is true for thermal throttling 
> policy currently: there might be more governor surgery and code 
> reshuffling required?
> 
> The short term goal would be to at minimum have all the bugs lined up in 
> kernel/sched/* neatly, so that we have the chance to see and fix them in 
> a single place. ;-)

I see that Daniel has already sent some patches for this!
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
