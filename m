Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeERKOT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:14:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeERKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:14:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE7D6601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v11 0/4] iommu/arm-smmu: Add runtime pm/sleep support
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>, Lukas Wunner <lukas@wunner.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
 <CAAFQd5CDY5p8oBz4QC5f6GsKiiYqdenCHGCqKhuWn10JwKjOpw@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <8bda01d5-61aa-d163-3b25-e8b055d54644@codeaurora.org>
Date: Fri, 18 May 2018 15:44:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CDY5p8oBz4QC5f6GsKiiYqdenCHGCqKhuWn10JwKjOpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


On 4/9/2018 9:52 AM, Tomasz Figa wrote:
> Hi Will, Robin,
>
> On Thu, Mar 22, 2018 at 7:22 PM Vivek Gautam <vivek.gautam@codeaurora.org>
> wrote:
>
>> This series provides the support for turning on the arm-smmu's
>> clocks/power domains using runtime pm. This is done using the
>> recently introduced device links patches, which lets the smmu's
>> runtime to follow the master's runtime pm, so the smmu remains
>> powered only when the masters use it.
>> As not all implementations support clock/power gating, we are checking
>> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
>> power management for such smmu implementations that can support it.
>> This series also adds support for Qcom's arm-smmu-v2 variant that
>> has different clocks and power requirements.
>> Took some reference from the exynos runtime patches [1].
>> With conditional runtime pm now, we avoid touching dev->power.lock
>> in fastpaths for smmu implementations that don't need to do anything
>> useful with pm_runtime.
>> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
>> calls in map/unmap callbacks so that the clients do not have to
>> worry about handling any of the arm-smmu's power.
>> Previous version of this patch series is @ [5].
>> [v11]
>>      * Some more cleanups for device link. We don't need an explicit
>>        delete for device link from the driver, but just set the flag
>>        DL_FLAG_AUTOREMOVE.
>>        device_link_add() API description says -
>>        "If the DL_FLAG_AUTOREMOVE is set, the link will be removed
>>        automatically when the consumer device driver unbinds."
>>      * Addressed the comments for 'smmu' in arm_smmu_map/unmap().
>>      * Dropped the patch [10] that introduced device_link_del_dev() API.
> As far as I can see, this version addresses all the earlier comments. Do
> you think this is something that you could apply?
>
> Best regards,
> Tomasz

Gentle ping. Are we picking this series for 4.18?

Regards
Vivek
