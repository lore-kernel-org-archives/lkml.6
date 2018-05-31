Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeEaEVS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:21:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeEaEVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:21:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54768602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 1/6] soc: qcom: rpmpd: Add a powerdomain driver to
 model corners
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        collinsd@codeaurora.org
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-2-rnayak@codeaurora.org>
 <CAPDyKFoAJjZknWtbbQLn0Hnc3Du_1vnSUnqfwZLYK76j2rg52g@mail.gmail.com>
 <0e07d577-9728-e97a-2da0-dd7dd324f058@codeaurora.org>
 <CAPDyKFpuZ4s7C+Nr3NhU-A40oVw84yK7eEniO6NhHNJ3VosR-A@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c4d9f752-0368-6257-bdab-6459b18eb893@codeaurora.org>
Date: Thu, 31 May 2018 09:50:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpuZ4s7C+Nr3NhU-A40oVw84yK7eEniO6NhHNJ3VosR-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2018 06:14 PM, Ulf Hansson wrote:
> [...]
> 
>>>> +
>>>> +static DEFINE_MUTEX(rpmpd_lock);
>>>> +
>>>> +/* msm8996 RPM powerdomains */
>>>> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddcx, vddcx_ao, 1);
>>>> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddmx, vddmx_ao, 2);
>>>> +DEFINE_RPMPD_CORN_LDOA(msm8996, vddsscx, 26);
>>>> +
>>>> +DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
>>>> +DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
>>>> +
>>>> +static struct rpmpd *msm8996_rpmpds[] = {
>>>> +       [0] = &msm8996_vddcx,
>>>> +       [1] = &msm8996_vddcx_ao,
>>>> +       [2] = &msm8996_vddcx_vfc,
>>>> +       [3] = &msm8996_vddmx,
>>>> +       [4] = &msm8996_vddmx_ao,
>>>> +       [5] = &msm8996_vddsscx,
>>>> +       [6] = &msm8996_vddsscx_vfc,
>>>> +};
>>>
>>> It's not my call, but honestly the above all macros makes the code
>>> less readable.
>>
>> This is all static data per SoC. The macros will keep the new additions
>> needed for every new SoC to a minimal. Currently this supports only
>> msm8996.
> 
> Right, that's fine then.
> 
>>
>>>
>>> Anyway, I think you should convert to allocate these structs
>>> dynamically from the heap (kzalloc/kcalloc), instead of statically as
>>> above.
> 
> However, I assume this is still doable!?

Perhaps it is, but is there any specific advantage of constructing these structures
dynamically vs statically, given they are static data?
Most other powerdomain/clock/regulator drivers I see do it statically, and thats
what I followed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
