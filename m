Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF7CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311552154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZLG/AWwZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XR1ek7t4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311552154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHBWxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:53:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHBWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:53:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2440C6071C; Thu,  2 Aug 2018 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533243614;
        bh=K0CotnjXIR5ldMpeZ+osHivqxoRK4BKd5CF+27yz5Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZLG/AWwZBWZ9FD7qjnQ30RK216ZpmgTNv9P2fQveBSVYwW1AfHrGEkUdjGttm4HOA
         CkczPP5j2su4jOMpaUWBvU72iuk+49Aayx5opquzcC7ojBCt4/4g4MKmoodFPxj+g5
         kM3R1HXZbYuF1eH8P3WF77zzR7rlNjJq4SRbdpEw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9D9D36063A;
        Thu,  2 Aug 2018 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533243612;
        bh=K0CotnjXIR5ldMpeZ+osHivqxoRK4BKd5CF+27yz5Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XR1ek7t45CRLwo2nNpHrjUhwxbfE8MmKzWdGRBUbI9RPjZXn5dIX6EaETje0sy8Xo
         svb5RyWodC+/FJXrUzd6fHyBFZGv2R8EyuIidiscYcTcEq+ymqLFN2fkOS/xgAGfFh
         qEu4o/jB3YFz3NIznXO6CBguaiYoRBudGkvbYu8g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 14:00:12 -0700
From:   skannan@codeaurora.org
To:     myungjoo.ham@samsung.com
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
In-Reply-To: <20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <CGME20180802005756epcas4p465a12f42a0e36f0af6fd276a3a56957f@epcms1p3>
 <20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3>
Message-ID: <45c77ee02536e237c054399cad4c7669@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 02:56, MyungJoo Ham wrote:
>> Many CPU architectures have caches that can scale independent of the 
>> CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is 
>> not
>> a performance bottleneck that leads to poor performance and power. The 
>> same
>> idea applies for RAM/DDR.
>> 
>> To achieve this, this patch adds a generic devfreq governor that takes 
>> the
>> current frequency of each CPU frequency domain and then adjusts the
>> frequency of the cache (or any devfreq device) based on the frequency 
>> of
>> the CPUs. It listens to CPU frequency transition notifiers to keep 
>> itself
>> up to date on the current CPU frequency.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
> 
> This exactly has the same purpose with "passive" governor except for 
> the
> single part: passive governor depends on another devfreq driver, not
> cpufreq driver.
> 
> If both governors have many features in common, can you merge them into 
> one?
> Passive governor also has "get_target_freq", which allows driver 
> authors
> to define the mapping.

Thanks for the review and pointing me to the passive governor. I agree 
that at a high level they are both doing the same. I can certainly stuff 
this CPU freq to dev freq mapping into passive governor, but I think 
it'll just make one huge set of code that's harder to understand and 
maintain because it trying to do different things under the hood.

There are also a bunch of complexities and optimizations that come with 
the cpufreq-map governor that don't fit with the passive governor.

1. It's not one CPU who's frequency we have to listen to. There are 
multiple CPUs/policies we have to aggregate across.
2. We have to deal with big vs little having different needs/mappings.
3. Since it's always just CPUfreq, I can optimize the handling in the 
transition notifiers. If I have 4 different devices that are scaled 
based on CPU freq, I still use only 1 transition notifier. It becomes a 
bit harder to do with the passive governor.
4. It requires that the device explicitly support the passive governor 
and pick a mapping function. With cpufreq-map governor, the device 
drivers don't need to make any changes. Whoever is making a device/board 
can choose what devices to scale up base on CPU freq based on their 
board and their needs. Even an end user can say, scale the GPU based on 
my CPU based on interpolation if they choose to.
5. If a device has some other use for the private data, it can't work 
with passive governor, but can work with cpufreq-map governor.
6. I also want to improve cpufreq-map governor to handle hotplug 
correctly in later patches (needs more discussion) and that'll add more 
complexity.

I think for these reasons we shouldn't combine these two governors. Let 
me know what you think.

> Probably, you will need to add one more notifier call to get events 
> from
> cpufreq instead of devfreq.
> 
>> 
>> * Uses a CPU frequency to device frequency mapping table
>>  - Either one mapping table used for all CPU freq policies (typically 
>> used
>>    for system with homogeneous cores/clusters that have the same 
>> OPPs).
>>  - One mapping table per CPU freq policy (typically used for ASMP 
>> systems
>>    with heterogeneous CPUs with different OPPs)
>> 
>> OR
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>  the CPUs are running at their max frequency, the device runs at its 
>> max
>>  frequency.  If the CPUs are running at their min frequency, the 
>> device
>>  runs at its min frequency. And interpolated for frequencies in 
>> between.
> 
> If you want to satisfy these two cases to the "modified" passive 
> governors,
> you may need to supply two "preloaded" get_target_freq functions for
> struct devfreq_passive_data. If that's impossible, requiring a bit more
> modifications, you may need to write alternative routines in
> update_devfreq_passive().
> 

Thanks for the pointers. I understood what you mean here.

>> diff --git a/drivers/devfreq/governor_cpufreq_map.c 
>> b/drivers/devfreq/governor_cpufreq_map.c
>> new file mode 100644
>> index 0000000..084a3ff
>> --- /dev/null
>> +++ b/drivers/devfreq/governor_cpufreq_map.c
>> @@ -0,0 +1,583 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights 
>> reserved.
>> + */
> 
> Is this boilerplate fine? ( using // )

I was just following what I thought was the new standard. checkpatch 
even complains about not having this.

Thanks,
Saravana
