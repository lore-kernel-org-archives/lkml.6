Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C235921436
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bPNLzztD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hpTKTLu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C235921436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbeGKLeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733118AbeGKLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2E0E60B7A; Wed, 11 Jul 2018 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531308625;
        bh=j8/TrVMkZ7n8Rj7zySqVAR6Uato/8p+hSyte8EpAYhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bPNLzztDQutdoOXM+K3RGiTVm7rjWE+1CETqj0MkFOGyLMMloev3g7VzJupww4c5E
         6cYdLceZy2yiVHFW1zs3e3RdQHm7yBOFzyMwkSxW200ylRpZN9GZnHCu07vDzy5eJj
         9s7tk6VQNArpmLnFTcK3kNwxEXizseaFSJVRw45Y=
Received: from [10.79.40.147] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0753460274;
        Wed, 11 Jul 2018 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531308623;
        bh=j8/TrVMkZ7n8Rj7zySqVAR6Uato/8p+hSyte8EpAYhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hpTKTLu12QwTBG7R4gOfOPvJX9bZb8XtwxH2XWOtuaW+r3wYpKBAVIXt5Dj0B7h14
         XplBS8Un4zC3gfQdzC18wJdTz/8684a394gLJH1U4thE6dAye0qXUhXrOLZObVLa9f
         UdeZhddI3aRhoTC2sqYzCT0CnGpvfvcOb6Ke6BF4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0753460274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v12 2/4] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        jcrouse@codeaurora.org
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-3-vivek.gautam@codeaurora.org>
 <1694664.FhRBrgajmF@aspire.rjw.lan>
 <CAAFQd5COVfXRBuq2ofHoOvNb+cMVmAFDaekh5KM4DBB1ZEf5pA@mail.gmail.com>
 <CAJZ5v0hMQJQ0Z-H2OLaeCdT+-MW_eSWmg7saVzkpDqJ-=i3DnQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <1bc641d5-a5d0-e459-57cf-07b6b7e055f4@codeaurora.org>
Date:   Wed, 11 Jul 2018 17:00:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hMQJQ0Z-H2OLaeCdT+-MW_eSWmg7saVzkpDqJ-=i3DnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2018 4:29 PM, Rafael J. Wysocki wrote:
> On Wed, Jul 11, 2018 at 12:05 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> Hi Rafael,
>>
>> Thanks for review.
>>
>> On Wed, Jul 11, 2018 at 6:53 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Sunday, July 8, 2018 7:34:11 PM CEST Vivek Gautam wrote:
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> The smmu device probe/remove and add/remove master device callbacks
>>>> gets called when the smmu is not linked to its master, that is without
>>>> the context of the master device. So calling runtime apis in those places
>>>> separately.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> [vivek: Cleanup pm runtime calls]
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>> ---
>>>>
>>>>   - Change since v11
>>>>     * Replaced pm_runtime_disable() with pm_runtime_force_suspend()
>>>>       to avoid warning about " Unpreparing enabled clock".
>>>>       Full warning text mentioned in cover patch.
>>>>
>>>>   drivers/iommu/arm-smmu.c | 92 +++++++++++++++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 84 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index a01d0dde21dd..09265e206e2d 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
>>>> @@ -268,6 +268,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>>>>        { 0, NULL},
>>>>   };
>>>>
>>>> +static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>>>> +{
>>>> +     if (pm_runtime_enabled(smmu->dev))
>>> Why do you need the pm_runtime_enabled() checks here and below?
>>>
>>> pm_runtime_get_sync() and pm_runtime_put() should work just fine if
>>> runtime PM is not enabled.
>> Because pm_runtime_get_sync() acquires a spin lock, even if only for
>> the short time of checking if runtime PM is enabled and SMMU driver
>> maintainers didn't want any spin locks in certain IOMMU API code paths
>> on hardware implementations that don't need runtime PM, while we still
>> need to be able to control runtime PM there on hardware
>> implementations that need so.
> OK, so it is an optimization.  It would be good to put a comment in
> there to that effect.

Yea, actually there's a comment placed in arm_smmu_device_probe()
  where the runtime PM is conditionally enabled.
I can add comments for these wrappers too if you would like.

Thanks & Regards
Vivek
