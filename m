Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32ECC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1FC208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1FC208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeHTW5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:57:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35578 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:57:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so27966310oic.2;
        Mon, 20 Aug 2018 12:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nuco+OqmOzAfNFG4sNG21WzIS/yzueInajrBtSETmnE=;
        b=h59NlPwrdkWctwlOlMDHlSVoIZe/DiVl2IDolvUt7cHEfx0MjKkdGpFVEXUQQamU1I
         ltJJM57T2VOOUyGiHBAZxh0s2aeEBEMdW7kR4ehzsnUIPBXFlruq4B6wojHgIYLIK6V8
         KuqXLWc2OH7qHzetHO3509r2rV67dIiWjyfzYo6bI80TXs7Dcttt3AVH+Xwk7LUke+p+
         3XJ5JxVGCLaRv4EGuLXxzmr2yngKcsJEgL7bZZT84xGEjZ97DH0gmxNKdwPsXXEX2qBZ
         bE+TOOY7SvTx+BY9V2pFbe++Fsk0vVLnlkPzUCiBtNZydddWstvnCQ0wh4BqPjc9CwLb
         aTEg==
X-Gm-Message-State: AOUpUlGLR8GqtSuDYoe1m25QhVqQdFtj4FD+CVIxieXh86z5+Jv3MEcE
        3hmq6kN3TSGsuSfB0pz3qw==
X-Google-Smtp-Source: AA+uWPwa4jZf1VO9c8K1ugO8GVx5M/Dk/iazp6OOahZ+sbbn6zYQxFEE+MrOyyujy7RvMZn6JJwScg==
X-Received: by 2002:aca:eb0d:: with SMTP id j13-v6mr16216688oih.304.1534794059098;
        Mon, 20 Aug 2018 12:40:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n131-v6sm9725371oia.17.2018.08.20.12.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:40:58 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:40:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com, mark.rutland@arm.com, rajanv@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Message-ID: <20180820194057.GA21738@bogus>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
 <1534446483-12156-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534446483-12156-2-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:08:01PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP power management
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index d215d15..cb9a6b7 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -64,6 +64,17 @@ Output clocks are registered based on clock information received
>  from firmware. Output clocks indexes are mentioned in
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
>  
> +--------------------------------------------------------------------
> +Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
> +--------------------------------------------------------------------
> +The zynqmp-power node describes the power management configurations.
> +It will control remote suspend/shutdown interfaces.
> +
> +Required properties:
> + - compatible:		Must contain:	"xlnx,zynqmp-power"
> + - interrupt-parent:	Interrupt controller the interrupt is routed through

interrupt-parent is implied and could be in a parent node, so remove.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> + - interrupts:		Interrupt specifier
> +
>  -------
>  Example
>  -------
> @@ -78,5 +89,10 @@ firmware {
>  			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
>  			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
>  		};
> +		zynqmp_power: zynqmp-power {
> +			compatible = "xlnx,zynqmp-power";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 35 4>;
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
