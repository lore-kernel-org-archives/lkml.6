Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C7E2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="at7RrH8/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bnejXsH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C7E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeIFI0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:26:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeIFI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:26:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C892606AC; Thu,  6 Sep 2018 03:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536205957;
        bh=Up90DKzkJc+Tn0BLBBk8ck1qVbZkMiDUL2vrw6Ub27I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=at7RrH8/1EN6OcrnucduUNjtvLdsfoYrI184yXD/mPg4RXzIuBSlBO7DDNjk09VC4
         /uU3GWU4Vb+Zi3yxBt/K9UwLPIPdiiFimE6q63EXKvYJnuMjITtGK9xZ1SKVjVDdr5
         ku42JUtJtFKNVgW7fzIAkzzY61Tne22N0FhFg7UY=
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6490606AC;
        Thu,  6 Sep 2018 03:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536205950;
        bh=Up90DKzkJc+Tn0BLBBk8ck1qVbZkMiDUL2vrw6Ub27I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bnejXsH5fGfpT520f5mC1IvIaLzzD++ZlCC9yTIYFfxPyddFphq9yiqYaEpl3+puF
         BR6hz0EXszyPDrpFJT+E0TaKVETnHM6E8BV4crwRj9i+Uepu3wt0RH7R70O+ko3j0m
         Q8Fd7N3COn8DVUmSGIkrYNQH3rCyz73XpgkYe9tw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6490606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f170.google.com with SMTP id m13-v6so10821107qth.1;
        Wed, 05 Sep 2018 20:52:29 -0700 (PDT)
X-Gm-Message-State: APzg51DyUP6EiYVrP7BSX37D1UdeOP6bfsGJvCgPV9HWvL+ugI3HFH1d
        jwaTO3oYau7EK8uhUSnzSM9fvUqGN7VupoCmH6Q=
X-Google-Smtp-Source: ANB0Vdb4xAnF9PLTptIbcqXpQi8dUzV10hAy1osmjOje4kh+vBCqPXuID964oyxWXVrHhfZC113jrYVufkcNT15NGP4=
X-Received: by 2002:a0c:8563:: with SMTP id n90-v6mr585067qva.93.1536205949151;
 Wed, 05 Sep 2018 20:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org> <20180830144541.17740-5-vivek.gautam@codeaurora.org>
In-Reply-To: <20180830144541.17740-5-vivek.gautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 6 Sep 2018 09:22:16 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFstfn1LXh6m_XFZr8LfdUA7Yd3-bx+43-SM4TU3kPqXg@mail.gmail.com>
Message-ID: <CAFp+6iFstfn1LXh6m_XFZr8LfdUA7Yd3-bx+43-SM4TU3kPqXg@mail.gmail.com>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
To:     "robh+dt" <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Aug 30, 2018 at 8:16 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Add bindings doc for Qcom's smmu-v2 implementation.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

I removed your reviewed-by for this particular patch.
Can you please consider giving your review if you find the changes okay now.
Thanks.

Best regards
Vivek

>  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
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
> +       /* Qcom's arm,smmu-v2 implementation */
> +       smmu4: iommu@d00000 {
> +               compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> +               reg = <0xd00000 0x10000>;
> +
> +               #global-interrupts = <1>;
> +               interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
> +               #iommu-cells = <1>;
> +               power-domains = <&mmcc MDSS_GDSC>;
> +
> +               clocks = <&mmcc SMMU_MDP_AXI_CLK>,
> +                        <&mmcc SMMU_MDP_AHB_CLK>;
> +               clock-names = "bus", "iface";
> +       };
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
