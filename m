Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954CE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954CE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeH2A1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:27:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35864 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH2A1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:27:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so5277060oie.3;
        Tue, 28 Aug 2018 13:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DT1IZEKKTQ8xlWEhwxsz1xiiS+Ad5h6kFGT4NSGGXQ=;
        b=BwnCUXAQ3BhQBFq3iFfpLjQLajVq5YkTLrdnijqK3WHnm9+lNO1ReRJpBTAqSDkuWb
         bxziYzvl6WXjkDsSsilH/ypH3UN0mG99yyxqFTjDE6JrjeybJSPPy8wkFFqtjmtqMH9H
         cm6BKjhUMY3LZgLg/XvtAlMvq2OIiUA43ocL6m5sP3i9tzQkwKyMRWmeijQZ1GXFlx52
         nvOjmrezkXAgHj1cxHzIWP3ZpKLijEdrVtOGkYBLvZWYOYl7sHaIkHcdgYfheruHI7y3
         XRddLBqhL7dZB+WiJFF+g/WPHixCJH0kY3dQ63Y6j+kJ70hP2ilOnKKkWZQZOMJoDqOD
         2OZA==
X-Gm-Message-State: APzg51BkO84oinmGjrlzfPMJm/mSuh8msAdqzzdnEv8eH46cCHOMfbUO
        XjkXErW3o5KWDgjqojM+Eg==
X-Google-Smtp-Source: ANB0VdZ9cO+FLX2NecbSo4xoT28bdZz006bCsh4D/Hi25+JJSBnK3F5ucxNTtvJv8gHZ3owhfunJPA==
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr2655661oiy.191.1535488459928;
        Tue, 28 Aug 2018 13:34:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l204-v6sm986798oia.45.2018.08.28.13.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 13:34:19 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:34:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, andy.gross@linaro.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
Message-ID: <20180828203418.GA18366@bogus>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-5-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827105551.16346-5-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:25:50PM +0530, Vivek Gautam wrote:
> Add bindings doc for Qcom's smmu-v2 implementation.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> Changes since v14:
>  - This is a new patch added in v15 after noticing the new
>    checkpatch warning for separate dt-bindings doc.
>  - This patch also addresses comments given by Rob and Robin to add
>    a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
>    compatible string.
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..52198a539606 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,10 +17,24 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"

The v2 in the compatible string is kind of redundant unless the SoC has 
other SMMU types.

>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
>  
> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> +                  string that should be present along with the "qcom,smmu-v2"
> +                  to facilitate SoC specific clocks/power connections and to
> +                  address specific bug fixes.
> +                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
> +                  following:
> +                  msm8996 - for msm8996 Qcom SoC.
> +                  sdm845 - for sdm845 Qcom Soc.

Rather than all this prose, it would be simpler to just add 2 lines with 
the full compatibles rather than <soc>. The <soc> thing is not going to 
work when/if we move bindings to json-schema also.

> +
> +                  An example string would be -
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
> +
>  - reg           : Base address and size of the SMMU.
>  
>  - #global-interrupts : The number of global interrupts exposed by the
> @@ -71,6 +85,22 @@ conditions.
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
> @@ -137,3 +167,20 @@ conditions.
>                  iommu-map = <0 &smmu3 0 0x400>;
>                  ...
>          };
> +
> +	/* Qcom's arm,smmu-v2 implementation */
> +	smmu4: iommu {

Needs a unit-address.

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
