Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA65AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870002070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501245;
	bh=gKkUd27cBgf1y0jdoI28lNvPokesaiMoZiE8OdUsKUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mYEHxtOkhX6XQb0MzjEiPfWRI5VaJBTU2ZjV5+yGq7mgUzM+BTsfcs7Kua/uAg8nL
	 Zpd9In88J3wZ7n/BkGWP/1dfczSjb3aW6SWPfBJg/GpyLZU/elWp8G7l7LYNIJvcAZ
	 cygYo5LQTbfdi9xM95E5OcWrIWoXZU4TV3Qxoqaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfBROrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:47:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41314 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbfBROrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:47:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so12242203otk.8;
        Mon, 18 Feb 2019 06:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mi5KJ4XJl6hs8QPqo8n1vqN9I3V/5JezP3CF56Gj/Fk=;
        b=MU2RUFdcIg2y30HD0LAVYT2UgDipY7UaaIdU6/ByoVFaV1+qZKN2Yu1DAeWr3n8UpT
         1JHt9sOD6+7VGk6ifGuXtf3WO8zhUGGXyGJ6bGfD1SUmwbxWVCj7D/RXqkt0bRXz9K3i
         SrnNC+QCN3Ga80KaUPdAcc8gw70JJm/utYEnVxUvQxyhJoXT4Q6WrbOlYk9AofiYuqD5
         Et/X5wjmBEwB0qreupJsbcC2TxQOxLUAdvNGjJ71vaZYF/HIhTCmQpeavya3vpwytCet
         RPhlxG1TUJ2aDJYWA3I8p98c65NZ4nrBDvYwmj9mKrVAeUNdobbvSiOGvvcXP+2Mf6Ng
         MdkQ==
X-Gm-Message-State: AHQUAuazEy6hVWHyr49qAMx217zluBndpeyfMcDNuaKIv3QgMOlYKNaU
        zghpYr8jK2T+uzHEycjrzpZsxSA=
X-Google-Smtp-Source: AHgI3IaZRnuTuypXOjt44Iu8Lq0xprBFB2vawC7NKIt9SaAgWtVubytjH3+d+2llkk5lb/NnVi1cLg==
X-Received: by 2002:a9d:7417:: with SMTP id n23mr13908923otk.63.1550501241034;
        Mon, 18 Feb 2019 06:47:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm2285575otx.57.2019.02.18.06.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 06:47:20 -0800 (PST)
Date:   Mon, 18 Feb 2019 08:47:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     shun-chih.yu@mediatek.com
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com
Subject: Re: [PATCH 1/1] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
Message-ID: <20190218144719.GA28079@bogus>
References: <1550130058-16566-1-git-send-email-shun-chih.yu@mediatek.com>
 <1550130058-16566-2-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550130058-16566-2-git-send-email-shun-chih.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:40:58PM +0800, shun-chih.yu@mediatek.com wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6765 SoC or other similar Mediatek SoCs.
> 
> Change-Id: I9736c8cac9be160358feeab935fabaffc5730519

Drop this.

> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.txt b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> new file mode 100644
> index 0000000..fb12927
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> @@ -0,0 +1,31 @@
> +MediaTek Command-Queue DMA Controller
> +==================================
> +
> +Required properties:
> +
> +- compatible:	Must be "mediatek,mt6765-cqdma" for MT6765.
> +- reg:		Should contain the base address and length for each channel.
> +- interrupts:	Should contain references to the interrupts for each channel.
> +- clocks:	Should be the clock specifiers corresponding to the entry in
> +		clock-names property.
> +- clock-names:	Should contain "cqdma" entries.
> +- dma-channels: The number of DMA channels supported by the controller.

What's the range of valid values?

> +- dma-requests: The number of DMA request supported by the controller.

What's the range of valid values?

> +- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
> +		in dmas property of a client device represents the channel
> +		number.
> +Example:
> +
> +        cqdma: dma-controller@10212000 {
> +		compatible = "mediatek,mt6765-cqdma";
> +		reg = <0 0x10212000 0 0x1000>;

Should be 2 entries here since there are 2 channels? Or the description 
above is wrong.

> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +			<GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_IFR_CQ_DMA>;
> +		clock-names = "cqdma";
> +		dma-channels = <2>;
> +		dma-requests = <32>;
> +		#dma-cells = <1>;
> +	};
> +
> +DMA clients must use the format described in dma/dma.txt file.
> -- 
> 1.7.9.5
> 
