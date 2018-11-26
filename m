Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6862C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SS9E6cLD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F9d1wR3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6862C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeKZWRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:17:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41904 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeKZVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:49:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4437760BE8; Mon, 26 Nov 2018 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543229747;
        bh=GB/kJloFxJ9BpSF1SfDzU6pafBMfaxJSFy4IsRKHEkU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SS9E6cLDBZoYhiBpyLRiCTgty5Zf663NqqYiRENbGQah7X83A1Prua9wk1ZapGMNa
         f9jkWTMqqqWZsi9GQueJJftC0IQp/KOOFuNE6FKvPaFFm6UymvrIB77hqJQ1UAYwLL
         PAXfIuYpYVz7V4J6oqEuO48lbwY3NJmHdywBu1pw=
Received: from [10.79.40.201] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86BB2609A8;
        Mon, 26 Nov 2018 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543229743;
        bh=GB/kJloFxJ9BpSF1SfDzU6pafBMfaxJSFy4IsRKHEkU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F9d1wR3EVM7evWFMuh/20OftIFj6tdmIYgZ1ndxr1NtIYS889KSPo19iYpbjYoFBF
         kdAMqGYLFso0NlpceuM4DG+/XPY6H8IP2EQcwZzTjN6PEle80R0frRTunFsQG/+Q+g
         p+iyEwCDTpxNBR4P/FMEXV0AIOgwcQIv9/LURC5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86BB2609A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
To:     Will Deacon <will.deacon@arm.com>, thor.thayer@linux.intel.com
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
        robh+dt <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org>
 <20181121173803.GB9801@arm.com>
 <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
 <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
 <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
 <20181123183428.GD21183@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <30fd45b5-50f0-7f2f-aab3-adc4528d21a8@codeaurora.org>
Date:   Mon, 26 Nov 2018 16:25:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181123183428.GD21183@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/24/2018 12:04 AM, Will Deacon wrote:
> On Fri, Nov 23, 2018 at 03:06:29PM +0530, Vivek Gautam wrote:
>> On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>> On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
>>>>> On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
>>>>>> @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>>>>>>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>>>>>>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>>>>>>
>>>>>> +static const char * const qcom_smmuv2_clks[] = {
>>>>>> +     "bus", "iface",
>>>>>> +};
>>>>>> +
>>>>>> +static const struct arm_smmu_match_data qcom_smmuv2 = {
>>>>>> +     .version = ARM_SMMU_V2,
>>>>>> +     .model = QCOM_SMMUV2,
>>>>>> +     .clks = qcom_smmuv2_clks,
>>>>>> +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
>>>>>> +};
>>>>> These seems redundant if we go down the route proposed by Thor, where we
>>>>> just pull all of the clocks out of the device-tree. In which case, why
>>>>> do we need this match_data at all?
>>>> Which is better? Driver relying solely on the device tree to tell
>>>> which all clocks
>>>> are required to be enabled,
>>>> or, the driver deciding itself based on the platform's match data,
>>>> that it should
>>>> have X, Y, & Z clocks that should be supplied from the device tree.
>>> The former would simplify the driver, but would also make it
>>> impossible to spot mistakes in DT, which would ultimately surface out
>>> as very hard to debug bugs (likely complete system lockups).
>> Thanks.
>> Yea, this is how I understand things presently. Relying on device tree
>> puts the things out of driver's control.
> But it also has the undesirable effect of having to update the driver
> code whenever we want to add support for a new SMMU implementation. If
> we do this all in the DT, as Thor is trying to do, then older kernels
> will work well with new hardware.
>
>> Hi Will,
>> Am I unable to understand the intentions here for Thor's clock-fetch
>> design change?
> I'm having trouble parsing your question, sorry. Please work with Thor
> so that we have a single way to get the clock information. My preference
> is to take it from the firmware, for the reason I stated above.
Hi Will,

Sure, thanks. I will work with Thor to get this going.

Hi Thor,
Does it sound okay to you to squash your patch [1] into my patch [2] with
your 'Signed-off-by' tag?
I will update the commit log to include the information about getting
clock details from device tree.

[1] https://patchwork.kernel.org/patch/10628725/
[2] https://patchwork.kernel.org/patch/10686061/

Best regards
Vivek
>
> Will

