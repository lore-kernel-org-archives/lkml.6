Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86002C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8B9208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8B9208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeJAS4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:56:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeJAS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:56:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E3D18A;
        Mon,  1 Oct 2018 05:18:34 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7285D3F5A0;
        Mon,  1 Oct 2018 05:18:34 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 129871AE3C57; Mon,  1 Oct 2018 13:18:57 +0100 (BST)
Date:   Mon, 1 Oct 2018 13:18:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, robdclark@gmail.com,
        linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org,
        sboyd@kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
Message-ID: <20181001121857.GA31488@arm.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830144541.17740-5-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 08:15:40PM +0530, Vivek Gautam wrote:
> Add bindings doc for Qcom's smmu-v2 implementation.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

It would be nice to have an Ack from a DT maintainer on this, since it's
adding new compatible strings...

Will

> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..a6504b37cc21 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,10 +17,16 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> +                        "qcom,smmu-v2"
>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
>  
> +                  Qcom SoCs must contain, as below, SoC-specific compatibles
> +                  along with "qcom,smmu-v2":
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
> +                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
> +
>  - reg           : Base address and size of the SMMU.
>  
>  - #global-interrupts : The number of global interrupts exposed by the
> @@ -71,6 +77,22 @@ conditions.
>                    or using stream matching with #iommu-cells = <2>, and
>                    may be ignored if present in such cases.
>  
> +- clock-names:    List of the names of clocks input to the device. The
> +                  required list depends on particular implementation and
> +                  is as follows:
> +                  - for "qcom,smmu-v2":
> +                    - "bus": clock required for downstream bus access and
> +                             for the smmu ptw,
> +                    - "iface": clock required to access smmu's registers
> +                               through the TCU's programming interface.
> +                  - unspecified for other implementations.
> +
> +- clocks:         Specifiers for all clocks listed in the clock-names property,
> +                  as per generic clock bindings.
> +
> +- power-domains:  Specifiers for power domains required to be powered on for
> +                  the SMMU to operate, as per generic power domain bindings.
> +
>  ** Deprecated properties:
>  
>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -137,3 +159,20 @@ conditions.
>                  iommu-map = <0 &smmu3 0 0x400>;
>                  ...
>          };
> +
> +	/* Qcom's arm,smmu-v2 implementation */
> +	smmu4: iommu@d00000 {
> +		compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> +		reg = <0xd00000 0x10000>;
> +
> +		#global-interrupts = <1>;
> +		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
> +		#iommu-cells = <1>;
> +		power-domains = <&mmcc MDSS_GDSC>;
> +
> +		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
> +			 <&mmcc SMMU_MDP_AHB_CLK>;
> +		clock-names = "bus", "iface";
> +	};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
