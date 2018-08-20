Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14139C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1CF20E20
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1CF20E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHTXD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:03:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44181 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:03:26 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so27935441oih.11;
        Mon, 20 Aug 2018 12:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mhweG7h6HrUV+gEn4oUQ9YKkHC4bbNOFLykVCOnGBJA=;
        b=aFb0PzI4gB7/DmU3VRUcyAFt3NyCanD2cpWvlRH6lsckmHOsn7UA5fJtvKiajHLj2d
         qWrRPBTT1sxZy2zlrvv3LMmvmytFu9awJGYbABIl8BICzhXwticyDz6MKsMA5lORJG0w
         jDkuJ1aLVG+VV9Z3SFjvhpiGX5Ori1oyCeN/OB7ExSd90RZkjHXNfIX6fHmTp2Iw4ZvR
         /0ZFvx/mTTi7p+lRvFNEdgmiBiGKF0WGd+Ew35L+1d+LDRQ6TPQOz1aMyEnmqCLYD3sQ
         juNTOgtL+2lP/J4y4upkRAFr2R71FbQAPzmAcDWtdRMwrSjUJ2haRXy2g7BKNljJsvgs
         OxEw==
X-Gm-Message-State: AOUpUlFJdYNm67UGum7vKLiVk51ZC6HsosBSx8RwPvlRgh9o0UONxT97
        UGusrKl1MeqNXnX0mOF2mE7rs4c=
X-Google-Smtp-Source: AA+uWPynMD9x7uPPhtR7DYhroEnh3IuA+9tgizQ8M6EDQLgCML6CA+VuFIpwQrGQ60KDOx5VVU32JQ==
X-Received: by 2002:aca:305:: with SMTP id 5-v6mr14323783oid.84.1534794389510;
        Mon, 20 Aug 2018 12:46:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q124-v6sm7971931oif.8.2018.08.20.12.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:46:28 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:46:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com, mark.rutland@arm.com, rajanv@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
Message-ID: <20180820194628.GA26783@bogus>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
 <1534447304-12919-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534447304-12919-2-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:21:42PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe ZynqMP power domain bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47 ++++++++++++++++++++++

This should be with all the other power domain bindings.

>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index d215d15..5fa10a0 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -64,6 +64,29 @@ Output clocks are registered based on clock information received
>  from firmware. Output clocks indexes are mentioned in
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
>  
> +-----------------------------------------------------------
> +Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
> +-----------------------------------------------------------
> +The binding for zynqmp-power-controller follow the common
> +generic PM domain binding[1].
> +
> +[1] Documentation/devicetree/bindings/power/power_domain.txt
> +
> +== Zynq MPSoC Generic PM Domain Node ==
> +
> +Required properties:
> + - compatible:	Must be: "xlnx,zynqmp-power-controller"
> +
> +This node contains a number of subnodes, each representing a single PM domain
> +that PM domain consumer devices reference.
> +
> +== PM Domain Nodes ==
> +
> +Required properties:
> + - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 0.
> + - pd-id:		Domain identifier as defined by platform firmware.
> +			This identifier is passed to the PM firmware.

Make this a cell for the power domain consumer.

> +
>  -------
>  Example
>  -------
> @@ -78,5 +101,29 @@ firmware {
>  			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
>  			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
>  		};
> +		zynqmp-power-controller {
> +			compatible = "xlnx,zynqmp-power-controller";
> +
> +			pd_usb0: pd-usb0 {
> +				pd-id = <22>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			pd_sata: pd-sata {
> +				pd-id = <28>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			pd_gpu : pd-gpu {
> +				pd-id = <58 20 21>;
> +				#power-domain-cells = <0>;
> +			};
> +		};
>  	};
>  };
> +
> +sata0: ahci@SATA_AHCI_HBA {

Don't use defines in unit-addresses (or reg for that matter). It's 
pointless indirection.

> +	...
> +	power-domains = <&pd_sata>;
> +	...
> +};
> -- 
> 2.7.4
> 
