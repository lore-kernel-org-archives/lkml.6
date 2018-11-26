Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350A9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF11C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dZUd+Z/f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fwPa2yJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF11C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeKZWUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:20:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeKZWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:20:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F1AC61340; Mon, 26 Nov 2018 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543231610;
        bh=S2TovgHbTmonJkPtnYyIkOIPJcN8+A5P8wvW9NqSomc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dZUd+Z/fPihcFhQdtPvgEvwl8Ejs/edplVztJD+e3SX3nnF0ntp1j+ZSYrnWNIJNL
         cVw9LH+fFM4WNhy93k58Nf0IgvrpHOqB/yhMDbor44eLT4E8hNyrD6KAt/rgzEx/+Q
         kNnnz1Blypg4a0NqEogqmN0TAA5CmJ1cioX4GPD4=
Received: from [10.79.40.201] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BD576132B;
        Mon, 26 Nov 2018 11:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543231609;
        bh=S2TovgHbTmonJkPtnYyIkOIPJcN8+A5P8wvW9NqSomc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=fwPa2yJ4xEBaqarClY8i2xM2ynP00tw2azFNnbr5ItfKYs4H/HoKn8AyBHP922rj1
         6wM62cl5u1gKmF7UMFyLjXLkL2NLcLkoOUCFwU8DacK3DIRjE+AR9nCC8Lahnx/Jv9
         N6btaVpTzZYw2E8CTQDAsMvmvBx1urYDrFyCUXaI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BD576132B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [RESEND PATCH v17 2/5] iommu/arm-smmu: Invoke pm_runtime during
 probe, add/remove device
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-3-vivek.gautam@codeaurora.org>
 <20181121173757.GA9801@arm.com>
 <CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg@mail.gmail.com>
 <20181123183555.GE21183@arm.com>
 <9064c01e-cef0-9306-078a-8d303cd6614b@codeaurora.org>
Message-ID: <d66c5dbf-2e44-a915-14a0-1968c8ede832@codeaurora.org>
Date:   Mon, 26 Nov 2018 16:56:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9064c01e-cef0-9306-078a-8d303cd6614b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2018 11:33 AM, Vivek Gautam wrote:
>
>
> On 11/24/2018 12:06 AM, Will Deacon wrote:
>> On Thu, Nov 22, 2018 at 05:32:24PM +0530, Vivek Gautam wrote:
>>> Hi Will,
>>>
>>> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> 
>>> wrote:
>>>> On Fri, Nov 16, 2018 at 04:54:27PM +0530, Vivek Gautam wrote:
>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>
>>>>> The smmu device probe/remove and add/remove master device callbacks
>>>>> gets called when the smmu is not linked to its master, that is 
>>>>> without
>>>>> the context of the master device. So calling runtime apis in those 
>>>>> places
>>>>> separately.
>>>>> Global locks are also initialized before enabling runtime pm as the
>>>>> runtime_resume() calls device_reset() which does tlb_sync_global()
>>>>> that ultimately requires locks to be initialized.
>>>>>
>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>> [vivek: Cleanup pm runtime calls]
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>>> ---
>>>>>   drivers/iommu/arm-smmu.c | 101 
>>>>> ++++++++++++++++++++++++++++++++++++++++++-----
>>>>>   1 file changed, 91 insertions(+), 10 deletions(-)
>>>> Given that you're doing the get/put in the TLBI ops unconditionally:
>>>>
>>>>>   static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
>>>>>   {
>>>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>>
>>>>> -     if (smmu_domain->tlb_ops)
>>>>> +     if (smmu_domain->tlb_ops) {
>>>>> +             arm_smmu_rpm_get(smmu);
>>>>> smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
>>>>> +             arm_smmu_rpm_put(smmu);
>>>>> +     }
>>>>>   }
>>>>>
>>>>>   static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>>>>>   {
>>>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>>
>>>>> -     if (smmu_domain->tlb_ops)
>>>>> +     if (smmu_domain->tlb_ops) {
>>>>> +             arm_smmu_rpm_get(smmu);
>>>>> smmu_domain->tlb_ops->tlb_sync(smmu_domain);
>>>>> +             arm_smmu_rpm_put(smmu);
>>>>> +     }
>>>> Why do you need them around the map/unmap calls as well?
>>> We still have .tlb_add_flush path?
>> Ok, so we could add the ops around that as well. Right now, we've got
>> the runtime pm hooks crossing two parts of the API.
>
> Sure, will do that then, and remove the runtime pm hooks from map/unmap.

I missed this earlier -
We are adding runtime pm hooks in the 'iommu_ops' callbacks and not 
really to
'tlb_ops'. So how the runtime pm hooks crossing the paths?
'.map/.unmap' iommu_ops don't call '.flush_iotlb_all' or '.iotlb_sync' 
iommu_ops
anywhere.

E.g., only callers to domain->ops->flush_iotlb_all() are:
iommu_dma_flush_iotlb_all(), or iommu_flush_tlb_all() which are not in 
map/unmap paths.

Regards
Vivek

>
> Thanks
> Vivek
>>
>> Will
>

