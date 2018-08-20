Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F85C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB542173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB542173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeHTW3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:29:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46221 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:29:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so27735244oie.13;
        Mon, 20 Aug 2018 12:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOjcWZNQT+oE4CmRPMJvaeuxf6azO0ttZBpl7JS+vH4=;
        b=iDXM8Dl4NfDC1T/SwQwilfW0gWkQ0QNE6HoiDhAKdP75Nk+mJR8rGLuQhx9cfSDslJ
         Wh5Mxa1h4q7mqAZzWU1S3sfnseuUarJ61DSRDLRq1ahMSuH3J99XsSeBi0dhLFFPsUfP
         UeRFYv9euq11BDTuOk+xB0vRn1cYsew2KLYOIFk0B8nFZm3MLEHANGWAC+61f+GsuxzH
         4V7qYxo1JydMoB83jxgHmWuigvc5/qJgA9H9188yCjTAhXJCcPUIfBkWFZQkwegx8kPi
         ZwF3GprchFflYmWJB0RMP2GYNsbf37K027IpB9OdaAqDf0oHmdyMnMZ9wFMhbMpQJbq0
         orzw==
X-Gm-Message-State: AOUpUlGMZDrGFJ29EB+UEBKDUjYKHbjylBCNuo+1y+rM9kQBx/hKfdgU
        UyECZlAe7BLG4t8eMyJnCA==
X-Google-Smtp-Source: AA+uWPzwB6WB3hy+DB5yDHoD/0Cp78MCBG627ZdKQ0AevivpTS7D5cEJtG7xwU+rVO6sRtKm9R9B+A==
X-Received: by 2002:aca:4fd1:: with SMTP id d200-v6mr16623370oib.224.1534792330340;
        Mon, 20 Aug 2018 12:12:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b125-v6sm5757605oia.38.2018.08.20.12.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:12:09 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:12:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Message-ID: <20180820191209.GA28618@bogus>
References: <20180818155430.5586-1-digetx@gmail.com>
 <20180818155430.5586-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818155430.5586-7-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver hasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. In a result

As a result...

> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT by introducing a new required property,
> the memory clock. Adding the new clock property also puts the tegra20-mc
> binding in line with the bindings of the later Tegra generations.

I don't understand this part. It looks to me like you are breaking 
compatibility. The driver failing to probe with an old DT is okay?

OS's like OpenSUSE use new DTs with older kernel versions, so you should 
consider how to not break them as well. I guess if all this is optional 
or has been unused, then there shouldn't be a problem.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 -----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 23 ++++++++++++++-----
>  2 files changed, 17 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> deleted file mode 100644
> index 099d9362ebc1..000000000000
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -NVIDIA Tegra 20 GART
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-gart"
> -- reg: Two pairs of cells specifying the physical address and size of
> -  the memory controller registers and the GART aperture respectively.
> -
> -Example:
> -
> -	gart {
> -		compatible = "nvidia,tegra20-gart";
> -		reg = <0x7000f024 0x00000018	/* controller registers */
> -		       0x58000000 0x02000000>;	/* GART aperture */
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> index 7d60a50a4fa1..1564df89392a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> @@ -2,25 +2,36 @@ NVIDIA Tegra20 MC(Memory Controller)
>  
>  Required properties:
>  - compatible : "nvidia,tegra20-mc"
> -- reg : Should contain 2 register ranges(address and length); see the
> -  example below. Note that the MC registers are interleaved with the
> -  GART registers, and hence must be represented as multiple ranges.
> +- reg : Should contain 2 register ranges: physical base address and length of
> +  the controller's registers and the GART aperture respectively.
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - mc: the module's clock input
>  - interrupts : Should contain MC General interrupt.
>  - #reset-cells : Should be 1. This cell represents memory client module ID.
>    The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>
>    or in the TRM documentation.
> +- #iommu-cells: Should be 0. This cell represents the number of cells in an
> +  IOMMU specifier needed to encode an address. GART supports only a single
> +  address space that is shared by all devices, therefore no additional
> +  information needed for the address encoding.
>  
>  Example:
>  	mc: memory-controller@7000f000 {
>  		compatible = "nvidia,tegra20-mc";
> -		reg = <0x7000f000 0x024
> -		       0x7000f03c 0x3c4>;
> -		interrupts = <0 77 0x04>;
> +		reg = <0x7000f000 0x400		/* controller registers */
> +		       0x58000000 0x02000000>;	/* GART aperture */
> +		clocks = <&tegra_car TEGRA20_CLK_MC>;
> +		clock-names = "mc";
> +		interrupts = <GIC_SPI 77 0x04>;
>  		#reset-cells = <1>;
> +		#iommu-cells = <0>;
>  	};
>  
>  	video-codec@6001a000 {
>  		compatible = "nvidia,tegra20-vde";
>  		...
>  		resets = <&mc TEGRA20_MC_RESET_VDE>;
> +		iommus = <&mc>;
>  	};
> -- 
> 2.18.0
> 
