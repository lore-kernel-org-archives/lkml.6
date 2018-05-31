Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeEaLJb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:09:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38914 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754464AbeEaLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:09:25 -0400
X-Google-Smtp-Source: ADUXVKIh5c8N+yhSk73THRPCjPiTsDJWZ9e4spIFE98mMT6qrsN1d8O86ZgUueMVFewTtOYNhxFG3ftzsJJ6sRL1Mg4=
MIME-Version: 1.0
In-Reply-To: <c4d9f752-0368-6257-bdab-6459b18eb893@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org> <20180525100121.28214-2-rnayak@codeaurora.org>
 <CAPDyKFoAJjZknWtbbQLn0Hnc3Du_1vnSUnqfwZLYK76j2rg52g@mail.gmail.com>
 <0e07d577-9728-e97a-2da0-dd7dd324f058@codeaurora.org> <CAPDyKFpuZ4s7C+Nr3NhU-A40oVw84yK7eEniO6NhHNJ3VosR-A@mail.gmail.com>
 <c4d9f752-0368-6257-bdab-6459b18eb893@codeaurora.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 May 2018 13:09:23 +0200
Message-ID: <CAPDyKFox1y5wxL8fxGRxEJL=p+ckOn8hMg3v+pVBHKsg-9aKrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] soc: qcom: rpmpd: Add a powerdomain driver to
 model corners
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        collinsd@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2018 at 06:20, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 05/30/2018 06:14 PM, Ulf Hansson wrote:
>> [...]
>>
>>>>> +
>>>>> +static DEFINE_MUTEX(rpmpd_lock);
>>>>> +
>>>>> +/* msm8996 RPM powerdomains */
>>>>> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddcx, vddcx_ao, 1);
>>>>> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddmx, vddmx_ao, 2);
>>>>> +DEFINE_RPMPD_CORN_LDOA(msm8996, vddsscx, 26);
>>>>> +
>>>>> +DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
>>>>> +DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
>>>>> +
>>>>> +static struct rpmpd *msm8996_rpmpds[] = {
>>>>> +       [0] = &msm8996_vddcx,
>>>>> +       [1] = &msm8996_vddcx_ao,
>>>>> +       [2] = &msm8996_vddcx_vfc,
>>>>> +       [3] = &msm8996_vddmx,
>>>>> +       [4] = &msm8996_vddmx_ao,
>>>>> +       [5] = &msm8996_vddsscx,
>>>>> +       [6] = &msm8996_vddsscx_vfc,
>>>>> +};
>>>>
>>>> It's not my call, but honestly the above all macros makes the code
>>>> less readable.
>>>
>>> This is all static data per SoC. The macros will keep the new additions
>>> needed for every new SoC to a minimal. Currently this supports only
>>> msm8996.
>>
>> Right, that's fine then.
>>
>>>
>>>>
>>>> Anyway, I think you should convert to allocate these structs
>>>> dynamically from the heap (kzalloc/kcalloc), instead of statically as
>>>> above.
>>
>> However, I assume this is still doable!?
>
> Perhaps it is, but is there any specific advantage of constructing these structures
> dynamically vs statically, given they are static data?

Well, I was just thinking that the genpd struct has grown quite big.

> Most other powerdomain/clock/regulator drivers I see do it statically, and thats
> what I followed.

Right, so forget it and keep it as is.

Kind regards
Uffe
