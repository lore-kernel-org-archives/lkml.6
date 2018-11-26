Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2628AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DCA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dwxsP2En";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jUBZ2Xo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DCA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeK0EuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:50:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeK0EuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:50:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E47460B19; Mon, 26 Nov 2018 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543254931;
        bh=YhDeB5upuxZqSv0LYfqVxly2P8ongk9RP5ApbS0TZUQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dwxsP2EnmkDeSRIPnRTrMkMkCseAaCvcW7eLMKXuBJOkg7pMVTFM2/ceZKHfv9m/r
         /hvyTdAbqLsOFrytxN1zn4iCUgDLI0oEvMbXKHwfzzFUXpsCnGmEHq8jPJixuKeJjj
         3ox8GZgyo7aTcFFFFY4bfuBah7sXvKms8a83iPeg=
Received: from [192.168.43.100] (unknown [1.39.165.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ACEC60722;
        Mon, 26 Nov 2018 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543254929;
        bh=YhDeB5upuxZqSv0LYfqVxly2P8ongk9RP5ApbS0TZUQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jUBZ2Xo/o4uLeKR1jntmOT+5HnX/W0be4P5/MllVNPAoT2B4U719e90mwh8JqyyQD
         2FRZC3IqHChfqNdjvZHo7HbixeuXCUuyHb2WQSUKTO2V5gPwnQWytIb8BEjfo61zII
         qFzUeDVqseE7PWJm3naknJnr9bKpKnAn7C5SmhBI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ACEC60722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
To:     thor.thayer@linux.intel.com, Will Deacon <will.deacon@arm.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, alex.williamson@redhat.com,
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
 <30fd45b5-50f0-7f2f-aab3-adc4528d21a8@codeaurora.org>
 <ca287382-1d21-ad73-1648-00291a5da21b@linux.intel.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <a6ea5f85-db61-3f6d-9dba-65eacc8f739d@codeaurora.org>
Date:   Mon, 26 Nov 2018 23:25:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ca287382-1d21-ad73-1648-00291a5da21b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thor,


On 11/26/2018 8:11 PM, Thor Thayer wrote:
> Hi Vivek,
>
> On 11/26/18 4:55 AM, Vivek Gautam wrote:
>>
>> On 11/24/2018 12:04 AM, Will Deacon wrote:
>>> On Fri, Nov 23, 2018 at 03:06:29PM +0530, Vivek Gautam wrote:
>>>> On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga@chromium.org> 
>>>> wrote:
>>>>> On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
>>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>>> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon 
>>>>>> <will.deacon@arm.com> wrote:
>>>>>>> On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
>>>>>>>> @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, 
>>>>>>>> ARM_SMMU_V1_64K, GENERIC_SMMU);
>>>>>>>>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>>>>>>>>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>>>>>>>>
>>>>>>>> +static const char * const qcom_smmuv2_clks[] = {
>>>>>>>> +     "bus", "iface",
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static const struct arm_smmu_match_data qcom_smmuv2 = {
>>>>>>>> +     .version = ARM_SMMU_V2,
>>>>>>>> +     .model = QCOM_SMMUV2,
>>>>>>>> +     .clks = qcom_smmuv2_clks,
>>>>>>>> +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
>>>>>>>> +};
>>>>>>> These seems redundant if we go down the route proposed by Thor, 
>>>>>>> where we
>>>>>>> just pull all of the clocks out of the device-tree. In which 
>>>>>>> case, why
>>>>>>> do we need this match_data at all?
>>>>>> Which is better? Driver relying solely on the device tree to tell
>>>>>> which all clocks
>>>>>> are required to be enabled,
>>>>>> or, the driver deciding itself based on the platform's match data,
>>>>>> that it should
>>>>>> have X, Y, & Z clocks that should be supplied from the device tree.
>>>>> The former would simplify the driver, but would also make it
>>>>> impossible to spot mistakes in DT, which would ultimately surface out
>>>>> as very hard to debug bugs (likely complete system lockups).
>>>> Thanks.
>>>> Yea, this is how I understand things presently. Relying on device tree
>>>> puts the things out of driver's control.
>>> But it also has the undesirable effect of having to update the driver
>>> code whenever we want to add support for a new SMMU implementation. If
>>> we do this all in the DT, as Thor is trying to do, then older kernels
>>> will work well with new hardware.
>>>
>>>> Hi Will,
>>>> Am I unable to understand the intentions here for Thor's clock-fetch
>>>> design change?
>>> I'm having trouble parsing your question, sorry. Please work with Thor
>>> so that we have a single way to get the clock information. My 
>>> preference
>>> is to take it from the firmware, for the reason I stated above.
>> Hi Will,
>>
>> Sure, thanks. I will work with Thor to get this going.
>>
>> Hi Thor,
>> Does it sound okay to you to squash your patch [1] into my patch [2] 
>> with
>> your 'Signed-off-by' tag?
>> I will update the commit log to include the information about getting
>> clock details from device tree.
>>
>> [1] https://patchwork.kernel.org/patch/10628725/
>> [2] https://patchwork.kernel.org/patch/10686061/
>>
>
> Yes, that would be great and easier to understand than my patch on top 
> of yours.
>
> Additionally, can you remove the "Error:" as Will requested as part of 
> the squash?

Thanks for your consent. I have reworked the patch today, and have 
addressed Will's
comment. I will give a try on the board and post it by tomorrow.

Best regards
Vivek

>
> Thank you!
>
> Thor
>
>> Best regards
>> Vivek
>>>
>>> Will
>>
>>
>

