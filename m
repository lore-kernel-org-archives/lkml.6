Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED853C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3777520651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3777520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJWIt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:49:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33166 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:49:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id q50so41998107otd.0;
        Mon, 22 Oct 2018 17:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6X8nWS+YyJuIBEmaP0/b1JSWrXynlAhK60hKxU2Yro=;
        b=Xz5h9tKJSJ+0HEI3/TNBJq2MGDBiOlH+hyWfeQU2J6u6CxTqr9icvuu0ktImYTV2BV
         Av0hbQGz+enb9vQwo+1Pi8rTWfYl8MrOdjSqrO2JLdYent+Vem0fLCfAWlEqFBKFXaN0
         ZLmHwLJsOWz3uhI+UMUo6pc1qnyv50phDmcFBfa+Ed3odetczdvJaUn9TtmfU7fPlsEw
         fIDCLjyq70Q/hx4k4gQcrqYFFDw1+nMefU0HBrIqmtTMQ/E8V3VimB+TzNBzRH7peHJ/
         k5F2kGhXghY0xj1H2tbQqwkDJAM0gzI6YoRgQs6HyaCnWZXZA9vY2hfoN29dmYVjJ0Ca
         1Mvg==
X-Gm-Message-State: ABuFfojJ/2rxmGghWRyBQq+B2PN6+rL/9ww4+4ZXh4B+TGrPBsmFPX4Q
        NFLgDcpDLR+laSLSjwxgpg==
X-Google-Smtp-Source: ACcGV61paUviXl7+pM2Qc/mbN9oYTzFuNbZC/b+n4ShAWoar+gKGtrrNZz6Py9I8+ULvLdgXMjBm3A==
X-Received: by 2002:a9d:488e:: with SMTP id d14mr32090082otf.354.1540254544919;
        Mon, 22 Oct 2018 17:29:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w31sm12326090ota.22.2018.10.22.17.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:29:04 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:29:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        swboyd@chromium.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy-qcom-qmp: Fix register
 underspecification
Message-ID: <20181023002903.GA16854@bogus>
References: <20181018210933.113592-1-evgreen@chromium.org>
 <20181018210933.113592-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018210933.113592-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 02:09:29PM -0700, Evan Green wrote:
> This change adds register regions for the second lane of dual-lane nodes.
> This additional specification is needed so that the driver can stop
> reaching beyond the tx and rx register allocations to get at the
> second lane registers in a dual-lane PHY.
> 
> While in there, document #clock-cells as optional for PHYs that don't
> provide a pipe clock. Also, document the pcs_misc register region, which
> was being quietly supplied and used.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> This applies atop linux-next 20181018 with the addition of Doug's
> changes [1] and [2].
> 
> [1] https://lore.kernel.org/lkml/20181012213632.252346-1-dianders@chromium.org/
> [2] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 73 +++++++++++++++++++---
>  1 file changed, 65 insertions(+), 8 deletions(-)

One nit below, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index fbc198d5dd39..297a7c753fc8 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -25,7 +25,7 @@ Required properties:
>    - For all others:
>      - The reg-names property shouldn't be defined.
>  
> - - #clock-cells: must be 1
> + - #clock-cells: must be 1 (PCIe and USB3 PHYs only)
>      - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
>        interface (for pipe based PHYs). These clock are then gate-controlled
>        by gcc.
> @@ -82,23 +82,26 @@ Required nodes:
>   - Each device node of QMP phy is required to have as many child nodes as
>     the number of lanes the PHY has.
>  
> -Required properties for child node:
> +Required properties for child nodes of PCIe PHYs (one child per lane):
>   - reg: list of offset and length pairs of register sets for PHY blocks -
> -	- index 0: tx
> -	- index 1: rx
> -	- index 2: pcs
> -	- index 3: pcs_misc (optional)
> +	tx, rx, pcs, and pcs_misc (optional).
> + - #phy-cells: must be 0
>  
> +Required properties for a single "lanes" child node of non-PCIe PHYs:
> + - reg: list of offset and length pairs of register sets for PHY blocks
> +	For 1-lane devices:
> +		tx, rx, pcs, and (optionally) pcs_misc
> +	For 2-lane devices:
> +		tx0, rx0, pcs, tx1, rx1, and (optionally) pcs_misc
>   - #phy-cells: must be 0
>  
> -Required properties child node of pcie and usb3 qmp phys:
> +Required properties for child node of PCIe and USB3 qmp phys:
>   - clocks: a list of phandles and clock-specifier pairs,
>  	   one for each entry in clock-names.
>   - clock-names: Must contain following:
>  		 "pipe<lane-number>" for pipe clock specific to each lane.
>   - clock-output-names: Name of the PHY clock that will be the parent for
>  		       the above pipe clock.
> -
>  	For "qcom,ipq8074-qmp-pcie-phy":
>  		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
>  			(or)
> @@ -150,3 +153,57 @@ Example:
>  		...
>  		...
>  	};
> +
> +	phy@88eb000 {
> +		compatible = "qcom,sdm845-qmp-usb3-uni-phy";
> +		reg = <0x88eb000 0x18c>;
> +		status = "disabled";

Don't show status in examples.

> +		#clock-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> +			 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +			 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
> +			 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
> +		clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> +
> +		resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
> +			 <&gcc GCC_USB3_PHY_SEC_BCR>;
> +		reset-names = "phy", "common";
> +
> +		lane@88eb200 {
> +			reg = <0x88eb200 0x128>,
> +			      <0x88eb400 0x1fc>,
> +			      <0x88eb800 0x218>,
> +			      <0x88e9600 0x70>;
> +			#phy-cells = <0>;
> +			clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> +			clock-names = "pipe0";
> +			clock-output-names = "usb3_uni_phy_pipe_clk_src";
> +		};
> +	};
> +
> +	phy@1d87000 {
> +		compatible = "qcom,sdm845-qmp-ufs-phy";
> +		reg = <0x1d87000 0x18c>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-names = "ref",
> +			      "ref_aux";
> +		clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> +			 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +
> +		status = "disabled";
> +
> +		lanes@1d87400 {
> +			reg = <0x1d87400 0x108>,
> +			      <0x1d87600 0x1e0>,
> +			      <0x1d87c00 0x1dc>,
> +			      <0x1d87800 0x108>,
> +			      <0x1d87a00 0x1e0>;
> +			#phy-cells = <0>;
> +		};
> +	};
> -- 
> 2.16.4
> 
