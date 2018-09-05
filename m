Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DBAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8981A20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pIPCR5zO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HAw5tfTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8981A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIEPzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:55:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:55:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C3926081A; Wed,  5 Sep 2018 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536146732;
        bh=r4wET2phV7PBOYKGIZGI3mCMwfu3Myseg3F8erW5388=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pIPCR5zOMwCVUlVOMfxMuJSerj/GINu4y3WiluM6lWjf1vMzMh6x0Q/XRmeVgJniO
         QzCbhU3A4c+cjR257jWD80WA2daYXYrhlREA/oJWqDuIdYEW/JauvqBuf1XRxnn5tr
         hx2eQbBNcU+Q3Qt6VcoSz7nXvxXMfgRBslF40ujU=
Received: from [10.79.41.39] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73A3A602AE;
        Wed,  5 Sep 2018 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536146731;
        bh=r4wET2phV7PBOYKGIZGI3mCMwfu3Myseg3F8erW5388=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HAw5tfTc/18jqb2/ejEKXOdMSqwlAXyuBxYPHi2n3wJ8MGQEgOxBhI2d2c59jeeul
         hlh98ajryG5HAfV9MRXuBF4OHXHKEQoHMSZYBwxFr+WzODVgwBoQRHWMgkSRDPc1lH
         1s7cBvP/nyx7wctiy0b/HSH6uEqZA7HzY3yBfVIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73A3A602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
To:     Rob Clark <robdclark@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814114009.GF28664@arm.com>
 <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
 <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
 <CAF6AEGsuAXXtUbeteQk5ssZEqk8XLViDZH5PfxQjn6sg8+B08A@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <3ac669af-a68e-874f-4c3e-91a2e9f676af@codeaurora.org>
Date:   Wed, 5 Sep 2018 16:55:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAF6AEGsuAXXtUbeteQk5ssZEqk8XLViDZH5PfxQjn6sg8+B08A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2018 3:34 PM, Rob Clark wrote:
> On Wed, Sep 5, 2018 at 5:22 AM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>
>> On 8/14/2018 5:54 PM, Vivek Gautam wrote:
>>> Hi Will,
>>>
>>>
>>> On 8/14/2018 5:10 PM, Will Deacon wrote:
>>>> Hi Vivek,
>>>>
>>>> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
>>>>> Qcom's implementation of arm,mmu-500 on sdm845 has a
>>>>> functional/performance
>>>>> errata [1] because of which the TCU cache look ups are stalled during
>>>>> invalidation cycle. This is mitigated by serializing all the
>>>>> invalidation
>>>>> requests coming to the smmu.
>>>> How does this implementation differ from the one supported by
>>>> qcom_iommu.c?
>>>> I notice you're adding firmware hooks here, which we avoided by
>>>> having the
>>>> extra driver. Please help me understand which devices exist, how they
>>>> differ, and which drivers are intended to support them!
>>> IIRC, the qcom_iommu driver was intended to support the static context
>>> bank - SID
>>> mapping, and is very specific to the smmu-v2 version present on
>>> msm8916 soc.
>>> However, this is the qcom's mmu-500 implementation specific errata.
>>> qcom_iommu
>>> will not be able to support mmu-500 configurations.
>>> Rob Clark can add more.
>>> Let you know what you suggest.
>> Rob, can you please comment about how qcom-smmu driver has different
>> implementation
>> from arm-smmu driver?
> sorry, I missed this thread earlier.  But yeah, as you mentioned, the
> purpose for qcom_iommu.c was to deal with the static context/SID
> mapping.
>
> (I guess it is all just software, and we could make qcom_iommu.c
> support dynamic mapping as well, but I think then it starts to
> duplicate most of arm_smmu.c, so that doesn't seem like the right
> direction)

Thanks Rob for the response. I will wait for Will's response on how would he
like this support be implemented.

Best regards
Vivek
>
> BR,
> -R
>
>> Will, in case we would want to use arm-smmu driver, what would you
>> suggest for
>> having the firmware hooks?
>> Thanks.
>>
>> Best regards
>> Vivek

