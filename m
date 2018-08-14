Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABEFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF2721772
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF2721772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeHNNgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:36:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41538 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbeHNNgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:36:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF52A7A9;
        Tue, 14 Aug 2018 03:49:45 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 040CB3F73C;
        Tue, 14 Aug 2018 03:49:43 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, andy.gross@linaro.org, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jordan Crouse <jcrouse@codeaurora.org>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
 <20180814102740.30222-4-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
Date:   Tue, 14 Aug 2018 11:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814102740.30222-4-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 14/08/18 11:27, Vivek Gautam wrote:
> Add device node for qcom,smmu-v2 available on sdm845.
> This smmu is available only to GPU device.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1c2be2082f33..bd1ec5fa5146 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -989,6 +990,28 @@
>   			cell-index = <0>;
>   		};
>   
> +		gpu_smmu: iommu@5040000 {
> +			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";

Which of "sdm845" or "msm8996"[1] is the actual SoC name here?

Robin.

[1] 
https://www.mail-archive.com/freedreno@lists.freedesktop.org/msg02659.html

> +			reg = <0x5040000 0x10000>;
> +			#iommu-cells = <1>;
> +			#global-interrupts = <2>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +			clock-names = "bus", "iface";
> +			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_CFG_AHB_CLK>;
> +
> +			/*power-domains = <&gpucc GPU_CX_GDSC>;*/
> +		};
> +
>   		apps_smmu: iommu@15000000 {
>   			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>   			reg = <0x15000000 0x80000>;
> 
