Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA31C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59E20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cma5reha";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LJpieiiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC59E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeIGOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:18:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeIGOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:18:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F34C46083C; Fri,  7 Sep 2018 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536313094;
        bh=NgwEYxA5lkHx+VNzqa6GL0iqQPzixkCvsKGpqHwJRjQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cma5rehawuiwauYz/cGh7JG8TCiO65T9DgT9GmKTJPVkgJAAFdU2v7nGv8s6MJRoV
         hovyCCMjEUYmWzKGQ2x3FbYK6yiBzAS+UoYvK/vQUPCpJQmx4XcbSk7pL7Iuzee+tk
         0pGqL8FNwpDCNl33KvQDsJvPG6K7ZpSFZBqhQmZw=
Received: from [10.79.41.39] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A3026055B;
        Fri,  7 Sep 2018 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536313092;
        bh=NgwEYxA5lkHx+VNzqa6GL0iqQPzixkCvsKGpqHwJRjQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LJpieiiKfOfNS6LTAsR/C/Mya3Y+WgTmCFg2QiBL2B5o3+KEN1ofa7ZQgHnCk5Kcz
         xRfDg8Y3v6glPqpgupLWfuasIsLPn3aJQVc0s4GK5LlCd0h1psm2CnsNO9mW0cDUE1
         meFY35Vh8t7KTrJMuU0giB/qVjQocSIdIIc7V1aM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A3026055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org>
 <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
Date:   Fri, 7 Sep 2018 15:08:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,


On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> Hi Vivek,
>
> On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>> Global locks are also initialized before enabling runtime pm as the
>> runtime_resume() calls device_reset() which does tlb_sync_global()
>> that ultimately requires locks to be initialized.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 81 insertions(+), 8 deletions(-)
> [snip]
>> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>          if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>>                  dev_err(&pdev->dev, "removing device with active domains!\n");
>>
>> +       arm_smmu_rpm_get(smmu);
>>          /* Turn the thing off */
>>          writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> +       arm_smmu_rpm_put(smmu);
>> +
>> +       if (pm_runtime_enabled(smmu->dev))
>> +               pm_runtime_force_suspend(smmu->dev);
>> +       else
>> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
>>
>> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> Aren't we missing pm_runtime_disable() here? We'll have the enable
> count unbalanced if the driver is removed and probed again.

pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not 
wrong.
And, as mentioned in a previous thread [1], we were seeing a warning 
which we avoided
by keeping force_suspend().

[1] https://lkml.org/lkml/2018/7/8/124

Thanks
Vivek
>
> Also, if we add pm_runtime_disable(), we can reorder things a bit and
> simplify into:
>
>         arm_smmu_rpm_get(smmu);
>
>         /* Turn the thing off */
>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>
>         if (pm_runtime_enabled())
>                 pm_runtime_disable();
>          arm_smmu_rpm_put(smmu);
>
>          clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>
> Best regards,
> Tomasz

