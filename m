Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C420893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C8VSt8Qc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DvE3md9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeGZI2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:28:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeGZI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:28:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2DFE360588; Thu, 26 Jul 2018 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532589173;
        bh=c1EHWvB9159J8YwndT2rO+E9yKDVFyWMDWjcMgETID0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=C8VSt8QcY+RF0k+12jAGg6wEyHCF0LHv+JjiIoJ5AIJfWXgCI+8kJ6CdW9M65bbQD
         DPAYH8d4OS5DamsZPMpHLE4smYOeMftKlRq3ssRLaRMSr0eWa/GBdIpV1bf80c8wmO
         kIMxWLkUBxJo5B5rLOEQ3BbMAz6IRKQSBmFaMj5s=
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com [209.85.220.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1E0660B19;
        Thu, 26 Jul 2018 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532589171;
        bh=c1EHWvB9159J8YwndT2rO+E9yKDVFyWMDWjcMgETID0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=DvE3md9mg2zZDnJrjDelwjornn8Rvq0RtB6iJ9hsCSnO1TrQZtRqdDoZ+Mgf9IsEN
         onsqllgovGEYpVCcvEFRGv98CKqQGi+7mtlDIHSbUDHsY5XhfQOOmuFfWHHqiKxaXQ
         da7hbd5Sks0HFPfRe7ObWsC0lk3wtNBlorfZrWNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1E0660B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f172.google.com with SMTP id b5-v6so389382qkg.6;
        Thu, 26 Jul 2018 00:12:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlHu3aBcALXYC6I402zUBRnkQ2h847FTo2e+B5pia0plX0u9Xti1
        VY6lB80JM3SjUFhZH+jebXsXgHxtdoncMi67lmE=
X-Google-Smtp-Source: AAOMgpdfOdHpOc0dBiSl45KXZiK0mNM/mB9AXrBddzpuKFENlWhr5ImVIFWPPlzLiV+vHguhnZLPy0V4XBt/8+0vwwA=
X-Received: by 2002:a37:5942:: with SMTP id n63-v6mr653686qkb.28.1532589170876;
 Thu, 26 Jul 2018 00:12:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 00:12:50 -0700 (PDT)
In-Reply-To: <CAFp+6iF1XzFn1QhWjatxE-1sue-EFS7wNmQ4OB=c3pf1VMLuMA@mail.gmail.com>
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
 <20180719101539.6104-2-vivek.gautam@codeaurora.org> <e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
 <CAFp+6iF1XzFn1QhWjatxE-1sue-EFS7wNmQ4OB=c3pf1VMLuMA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 26 Jul 2018 12:42:50 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA@mail.gmail.com>
Message-ID: <CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:46 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> On Tue, Jul 24, 2018 at 8:51 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 19/07/18 11:15, Vivek Gautam wrote:
>>>
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> The smmu needs to be functional only when the respective
>>> master's using it are active. The device_link feature
>>> helps to track such functional dependencies, so that the
>>> iommu gets powered when the master device enables itself
>>> using pm_runtime. So by adapting the smmu driver for
>>> runtime pm, above said dependency can be addressed.
>>>
>>> This patch adds the pm runtime/sleep callbacks to the
>>> driver and also the functions to parse the smmu clocks
>>> from DT and enable them in resume/suspend.
>>>
>>> Also, while we enable the runtime pm add a pm sleep suspend
>>> callback that pushes devices to low power state by turning
>>> the clocks off in a system sleep.
>>> Also add corresponding clock enable path in resume callback.
>>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>> [vivek: rework for clock and pm ops]
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>
>>> Changes since v12:
>>>   - Added pm sleep .suspend callback. This disables the clocks.
>>>   - Added corresponding change to enable clocks in .resume
>>>    pm sleep callback.
>>>
>>>   drivers/iommu/arm-smmu.c | 75
>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 73 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index c73cfce1ccc0..9138a6fffe04 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c

[snip]

>>> platform_device *pdev)
>>>         arm_smmu_device_remove(pdev);
>>>   }
>>>   +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>> +{
>>> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>> +
>>> +       return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>
>>
>> If there's a power domain being automatically switched by genpd then we need
>> a reset here because we may have lost state entirely. Since I remembered the
>> otherwise-useless GPU SMMU on Juno is in a separate power domain, I gave it
>> a poking via sysfs with some debug stuff to dump sCR0 in these callbacks,
>> and the problem is clear:
>>
>> ...
>> [    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
>> [    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 0x00201936
>> [    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 6733980 ns
>> [   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
>> [   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 0x00220101
>> [   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 6658020 ns
>> ...
>
> Qualcomm SoCs have retention enabled for SMMU registers so they don't
> lose state.
> ...
> [  256.013367] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
> SCR0 = 0x201e36
> [  256.013367]
> [  256.019160] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
> SCR0 = 0x201e36
> [  256.019160]
> [  256.027368] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
> SCR0 = 0x201e36
> [  256.027368]
> [  256.036786] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
> SCR0 = 0x201e36
> ...
>
> However after adding arm_smmu_device_reset() in runtime_resume() I observe
> some performance degradation when kill an instance of 'kmscube' and
> start it again.
> The launch time with arm_smmu_device_reset() in runtime_resume() change is
> more.
> Could this be because of frequent TLB invalidation and sync?

Some more information that i gathered.
On Qcom SoCs besides the registers retention, TCU invalidates TLB cache on
a CX power collapse exit, which is the system wide suspend case.
The arm-smmu software is not aware of this CX power collapse /
auto-invalidation.

So wouldn't doing an explicit TLB invalidations during runtime resume be
detrimental to performance?

I have one more doubt here -
We do runtime power cycle around arm_smmu_map/unmap() too.
Now during map/unmap we selectively do TLB maintenance (either
tlb_sync or tlb_add_flush).
But with runtime pm we want to do TLBIALL*. Is that a problem?

Best regards
Vivek

>
> Best regards
> Vivek

[snip]

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
