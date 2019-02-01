Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75687C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4512C2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JNyp1wxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfBAPtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:49:23 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18832 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfBAPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:49:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c546a570000>; Fri, 01 Feb 2019 07:48:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 07:49:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 07:49:22 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 15:49:19 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <5490ad66-7d20-7093-7025-1d0ec8da6dec@nvidia.com>
 <3c9b86ba-32dd-76b2-9a51-6cd86782cadf@nvidia.com>
 <ab418999-a45c-bd9c-b9bd-5c382e86d26c@nvidia.com>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <c33697d8-43a9-654b-503f-e60adbaf289f@nvidia.com>
Date:   Fri, 1 Feb 2019 23:49:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ab418999-a45c-bd9c-b9bd-5c382e86d26c@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549036120; bh=SjYRayLmjrLPYjKGkL341MDkDszyHBUg+VtNsNQYVVo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JNyp1wxJjHcmyWe3emHSjH45gGMqadlrbAcut4/I+bls7QHSL8QCCHHKIuX+EcvIY
         EaFlofhk5zpiK0ycQFWDLErUqOCJkzBPPritwCyBjLcEmiri/weLMViHo68hWSoiaQ
         ZmIjcFkPkLgxbnKyygOcqDbiEHj3qwQM7gpESCNl5kcPKHeIjLkYXEc5+A7126B4P/
         +Xwg5k0K2vvZcPpFvnhC00z7ZhZ6KW1ZRzhJDyUXuddw0c6kaKKGa9nlVCCSxGKGmy
         YaBsWSyMX7OsXsxY+l+vEISR7G5c3eV8slVLsyV4P4jxNdDBPry8elYpGR2cJZOPO2
         KKOFJ3AivOKsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 11:43 PM, Jon Hunter wrote:
> 
> 
> On 01/02/2019 14:39, Joseph Lo wrote:
>> On 2/1/19 8:44 PM, Jon Hunter wrote:
>>>
>>> On 01/02/2019 03:36, Joseph Lo wrote:
>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>> (TMR10-TMR13). We need these timers to work as clock event device and to
>>>> replace the ARMv8 architected timer due to it can't survive across the
>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a
>>>> wake-up
>>>> source when CPU suspends in power down state.
>>>>
>>>> Also convert the original driver to use timer-of API.
>>>
>>> It may have been nice to split this into 2 patches to make it easier to
>>> see what is going on but not a big deal.
>>>
>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> ---
snip.
>>>
>> This can't get the timer base address. I think you mean ...
>>
>> +#ifdef CONFIG_ARM
>> +#define TIMER_CPU0 0x50 /* TIMER3 */
>> +#else
>> +#define TIMER_CPU0 0x90 /* TIMER10 */
>> +#endif
>> +#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
> 
> Ah I see.
> 
>> This doesn't need.
>> +#define TIMER_FOR_CPU(cpu) (TIMER_CPU0 + cpu)
> How come? Don't you still need to know the timer index for a given CPU?
> 

Doesn't need. TIMER_BASE_FOR_CPU is enough. Other use cases are well 
handled by timer-of API. :)

Thanks,
Joseph
