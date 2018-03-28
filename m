Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeC1GME (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:12:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751908AbeC1GMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:12:02 -0400
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2
 variant
To: Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-6-vivek.gautam@codeaurora.org>
 <61d30fff-1bf8-d2c1-bbe9-f93de836ae77@huawei.com>
 <7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        Gaojianbo <gaojianbo@hisilicon.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
Date: Wed, 28 Mar 2018 14:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 2018/3/28 12:37, Vivek Gautam wrote:
> Hi Yisheng
> 
> 
> On 3/28/2018 6:54 AM, Yisheng Xie wrote:
>> Hi Vivek,
>>
>> On 2018/3/13 16:55, Vivek Gautam wrote:
>>> +- power-domains:  Specifiers for power domains required to be powered on for
>>> +                  the SMMU to operate, as per generic power domain bindings.
>>> +
>> In this patchset, power-domains is not used right? And you just do the clock gating,
>> but not power gating, right?
> 
> We are handling the power-domains too. Please see the example in this binding doc.

I see, but I do not find the point in code of these patchset, do you mean PMIC(e.g mmcc)
will gate the power domain of SMMU(e.g. MDSS_GDSC of mmcc) when PMIC suspend?

> 
>>
>> Another question is if smmu do power gating, it will reset some of its registers, so
>> it need save at suspend and restore at resume, right?
> 
> Qualcomm implementation of the arm-smmu has the retenetion enabled. So the smmu doesn't
> loose state when power is pulled out of it.
> And now we are just selectively enabling the runtime pm. So only the platforms that can really
> support runtime pm can enable it.

Get it, thanks for your explain.

Thanks
Yisheng
> 
> Thanks
> Vivek
>>
>> Thanks
>> Yisheng
>>
> 
> 
> 
