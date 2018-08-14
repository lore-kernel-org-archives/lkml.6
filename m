Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952721727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cPaGwj5a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZivrMMgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A952721727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeHNW23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:28:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNW23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:28:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 73A9660E5D; Tue, 14 Aug 2018 19:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534275585;
        bh=XkgD7EI+KS8zA+esL+IO9rwEG/l3/KezO6fztAEMoZA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cPaGwj5anonxyNBnncmdXlsF5xcZNFQAb5qP9HLDeBxcYy0j8PtwijI2cYuImXXbp
         MkVFRmE1AAK+RKBo/KVmcsCi07J/9rOPrrN4WADJfeyFxwDJvtiw22AmLsc9aaUPt4
         U8+KmjEDE8twk87bI6koZb9EbUQLne2o5LYa0am8=
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com [209.85.220.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76C6160E57;
        Tue, 14 Aug 2018 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534275584;
        bh=XkgD7EI+KS8zA+esL+IO9rwEG/l3/KezO6fztAEMoZA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZivrMMgFJVfwurLx0on6jlgHG7KLwwjzKPHShu27e8addzoJ3bx5rBujH9yTTYSSv
         NmkBpaG+jkUWkfMT97S5O4XpuLRFdEwJqu5gp8AGwydR/UR0CByFRxT9CA3EXHcpzg
         GJOOAAJnQbPiJWl8R/gDlecNfZvICjNAoKS2UjIg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76C6160E57
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f175.google.com with SMTP id n85-v6so14239333qke.8;
        Tue, 14 Aug 2018 12:39:44 -0700 (PDT)
X-Gm-Message-State: AOUpUlFUqmm70CrHHP7SmzP9ylfgkuBB5XxW4gDo63ZcU2ivE7vf/yaK
        i8tgnFkmormwL6c9TgUpslSY8YpfMxk+d3V0q9Y=
X-Google-Smtp-Source: AA+uWPzItCBLl3OD6VctO5gqR1ksVGlGX+ZP4DQ4n0detL7vY/vzAxjs34CgSozgYGy1J8hIsk8ZDGCcpgOp+Oocs68=
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr20312277qkd.32.1534275583736;
 Tue, 14 Aug 2018 12:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 12:39:43 -0700 (PDT)
In-Reply-To: <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
 <20180814102740.30222-4-vivek.gautam@codeaurora.org> <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 15 Aug 2018 01:09:43 +0530
X-Gmail-Original-Message-ID: <CAFp+6iG8HohQ5=gwL37OuykK+R4U407yfrp=WN6pSgOK-mdzzA@mail.gmail.com>
Message-ID: <CAFp+6iG8HohQ5=gwL37OuykK+R4U407yfrp=WN6pSgOK-mdzzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
To:     Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Jordan here.

On Tue, Aug 14, 2018 at 4:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Vivek,
>
> On 14/08/18 11:27, Vivek Gautam wrote:
>>
>> Add device node for qcom,smmu-v2 available on sdm845.
>> This smmu is available only to GPU device.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 1c2be2082f33..bd1ec5fa5146 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -6,6 +6,7 @@
>>    */
>>     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> @@ -989,6 +990,28 @@
>>                         cell-index = <0>;
>>                 };
>>   +             gpu_smmu: iommu@5040000 {
>> +                       compatible = "qcom,sdm845-smmu-v2",
>> "qcom,smmu-v2";
>
>
> Which of "sdm845" or "msm8996"[1] is the actual SoC name here?

Well, the bindings use the SoC prefix with smmu-v2, so it should be
sdm845 for this SoC. This is same as I posted in my v1 of the series [2].
Using 8996 based string in sdm845 makes things look awful.

Thanks
Vivek

[2] https://patchwork.kernel.org/patch/10534989/

>
> Robin.
>
> [1]
> https://www.mail-archive.com/freedreno@lists.freedesktop.org/msg02659.html
>
>> +                       reg = <0x5040000 0x10000>;
>> +                       #iommu-cells = <1>;
>> +                       #global-interrupts = <2>;
>> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
>> +                       clock-names = "bus", "iface";
>> +                       clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>> +                                <&gcc GCC_GPU_CFG_AHB_CLK>;
>> +
>> +                       /*power-domains = <&gpucc GPU_CX_GDSC>;*/
>> +               };
>> +
>>                 apps_smmu: iommu@15000000 {
>>                         compatible = "qcom,sdm845-smmu-500",
>> "arm,mmu-500";
>>                         reg = <0x15000000 0x80000>;
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
