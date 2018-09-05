Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A03FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3175206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mUcePa7B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dEN1wfCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3175206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeIENvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:51:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIENvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:51:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BEC946081C; Wed,  5 Sep 2018 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536139349;
        bh=mVgfDffMFI//w+16aQS6ri7vpUvqjHyuLU8SH+vs2kU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=mUcePa7BCQR7XjFmEwlWaion4ZNsFXWQWUz0LMb+DE5IW6hTr0RpApUtF9Phub8sX
         6EVruuRYzraV/xM+aQnBQoyyBQ1dBvSl4TIMynEoclv4IKV1NLFSaG1VFUGcNG9Yg/
         Yyo6vfj69M11RrSvmcvqHLZmkWrnVu46liEuByb8=
Received: from [10.79.41.39] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 534D56034F;
        Wed,  5 Sep 2018 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536139348;
        bh=mVgfDffMFI//w+16aQS6ri7vpUvqjHyuLU8SH+vs2kU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dEN1wfCjhl7eZEuwrNtu8fS0kbhve8dG80Tz7umW1x7b56JwfcTmye9sK30xnQo5S
         izfeqRYGeu93GM1PmCu8ECRTNvBml0Yz8Ba8+UrCkJkjACz+XLtJP4gqNZXwOZFXpA
         styIPKGYy3tVMGPtV1s6Wo+HyyVV3tl/JNaYgvz0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 534D56034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     Will Deacon <will.deacon@arm.com>, robdclark@gmail.com
Cc:     joro@8bytes.org, andy.gross@linaro.org, robin.murphy@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
        mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814114009.GF28664@arm.com>
 <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
Message-ID: <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
Date:   Wed, 5 Sep 2018 14:52:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/14/2018 5:54 PM, Vivek Gautam wrote:
> Hi Will,
>
>
> On 8/14/2018 5:10 PM, Will Deacon wrote:
>> Hi Vivek,
>>
>> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
>>> Qcom's implementation of arm,mmu-500 on sdm845 has a 
>>> functional/performance
>>> errata [1] because of which the TCU cache look ups are stalled during
>>> invalidation cycle. This is mitigated by serializing all the 
>>> invalidation
>>> requests coming to the smmu.
>> How does this implementation differ from the one supported by 
>> qcom_iommu.c?
>> I notice you're adding firmware hooks here, which we avoided by 
>> having the
>> extra driver. Please help me understand which devices exist, how they
>> differ, and which drivers are intended to support them!
>
> IIRC, the qcom_iommu driver was intended to support the static context 
> bank - SID
> mapping, and is very specific to the smmu-v2 version present on 
> msm8916 soc.
> However, this is the qcom's mmu-500 implementation specific errata. 
> qcom_iommu
> will not be able to support mmu-500 configurations.
> Rob Clark can add more.
> Let you know what you suggest.

Rob, can you please comment about how qcom-smmu driver has different 
implementation
from arm-smmu driver?
Will, in case we would want to use arm-smmu driver, what would you 
suggest for
having the firmware hooks?
Thanks.

Best regards
Vivek
>
>>
>> Also -- you didn't CC all the maintainers for the firmware bits, so 
>> adding
>> Andy here for that, and Rob for the previous question.
>
> I added Andy to the series, would you want me to add Rob H also?
>
> Best regards
> Vivek
>
>>
>> Thanks,
>>
>> Will
>

