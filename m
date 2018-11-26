Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB05120664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WrFVehrw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eo0aeECo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeKZQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:56:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:56:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87C586086B; Mon, 26 Nov 2018 06:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543212202;
        bh=TtMPE2NKj0InUGwHDyByTBIeSUegY40+/tfqcG3xP0U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WrFVehrw2FC51qLfo6AwKCP1afd0rL7nQYpe/DQHLmCQD+XgvhfJAPJ1R8wqNB+5a
         gYOeBtlg+4HptetjKtaXsWhoRlS5BziyPfRiGMAm9wuZvIS4I5uhhe0QGWkKQ5JuCQ
         Vyxo6h1/3BdOqdV4p5eSu1w5NCJ4IqAYI4DvHUbo=
Received: from [10.79.40.201] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93D9B602BD;
        Mon, 26 Nov 2018 06:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543212201;
        bh=TtMPE2NKj0InUGwHDyByTBIeSUegY40+/tfqcG3xP0U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eo0aeECo3Ujhrfn0M54YfcJZklMVWUWJ4I6FrSgBZa8/1QO2/cPytCP7xsbTosvyV
         AV4bmaH1RYki+ISl6bGtIiZ/qLDI7baZp7tuFq5zRx9YDtwIeauGDobghxXqVCusZM
         q/b1xk7/InnU7O/tN5AWkMc0yvdZ12KnSolensMc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93D9B602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [RESEND PATCH v17 2/5] iommu/arm-smmu: Invoke pm_runtime during
 probe, add/remove device
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, robh+dt <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-3-vivek.gautam@codeaurora.org>
 <20181121173757.GA9801@arm.com>
 <CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg@mail.gmail.com>
 <20181123183555.GE21183@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <9064c01e-cef0-9306-078a-8d303cd6614b@codeaurora.org>
Date:   Mon, 26 Nov 2018 11:33:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181123183555.GE21183@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2018 12:06 AM, Will Deacon wrote:
> On Thu, Nov 22, 2018 at 05:32:24PM +0530, Vivek Gautam wrote:
>> Hi Will,
>>
>> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
>>> On Fri, Nov 16, 2018 at 04:54:27PM +0530, Vivek Gautam wrote:
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> The smmu device probe/remove and add/remove master device callbacks
>>>> gets called when the smmu is not linked to its master, that is without
>>>> the context of the master device. So calling runtime apis in those places
>>>> separately.
>>>> Global locks are also initialized before enabling runtime pm as the
>>>> runtime_resume() calls device_reset() which does tlb_sync_global()
>>>> that ultimately requires locks to be initialized.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> [vivek: Cleanup pm runtime calls]
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>   drivers/iommu/arm-smmu.c | 101 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 91 insertions(+), 10 deletions(-)
>>> Given that you're doing the get/put in the TLBI ops unconditionally:
>>>
>>>>   static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
>>>>   {
>>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>
>>>> -     if (smmu_domain->tlb_ops)
>>>> +     if (smmu_domain->tlb_ops) {
>>>> +             arm_smmu_rpm_get(smmu);
>>>>                smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
>>>> +             arm_smmu_rpm_put(smmu);
>>>> +     }
>>>>   }
>>>>
>>>>   static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>>>>   {
>>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>
>>>> -     if (smmu_domain->tlb_ops)
>>>> +     if (smmu_domain->tlb_ops) {
>>>> +             arm_smmu_rpm_get(smmu);
>>>>                smmu_domain->tlb_ops->tlb_sync(smmu_domain);
>>>> +             arm_smmu_rpm_put(smmu);
>>>> +     }
>>> Why do you need them around the map/unmap calls as well?
>> We still have .tlb_add_flush path?
> Ok, so we could add the ops around that as well. Right now, we've got
> the runtime pm hooks crossing two parts of the API.

Sure, will do that then, and remove the runtime pm hooks from map/unmap.

Thanks
Vivek
>
> Will

