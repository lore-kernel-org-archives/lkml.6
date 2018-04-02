Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeDBOZz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:25:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751418AbeDBOZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:25:50 -0400
Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
To: Yisheng Xie <xieyisheng1@huawei.com>,
        Neil Leeder <neil.m.leeder@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>,
        "Jon Masters" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
 <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
 <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <66ef3bf4-9550-94c7-f8ad-ee53d6c75025@huawei.com>
Date: Mon, 2 Apr 2018 22:24:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/2 14:37, Yisheng Xie wrote:
> Hi Neil,
> 
> On 2018/4/1 13:44, Neil Leeder wrote:
>> Hi Yisheng Xie,
>>
>> On 3/29/2018 03:03 AM, Yisheng Xie wrote:
>>>
>>> Hi Neil,
>>>
>>> On 2017/8/5 3:59, Neil Leeder wrote:
>>>> +    mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +    mem_map_0 = devm_ioremap_resource(&pdev->dev, mem_resource_0);
>>>> +
>>> Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
>>> IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
>>> devm_ioremap_resource will failed and return -EBUSY, eg.:
>>>
>>>   smmu reg ranges:        0x180000000 ~ 0x1801fffff
>>>   its smmu_pmu reg ranges:    0x180001000 ~ 0x180001fff
>>>
>> Just to let you know that I no longer work at Qualcomm and I won't be able to provide updates to this patchset. I expect that others from my former team at Qualcomm will pick up ownership.
> 
> Thanks for this infomation.
> 
> hi Agustin and Timur,
> 
> Is there any new status about this patchset?

I think we need to wait for the new version of IORT spec,
which includes the fix for the two base address for SMMUv3
PMCG (now just represent one).

Thanks
Hanjun
