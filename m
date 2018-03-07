Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbeCGT2x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:28:53 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36785 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:28:51 -0500
X-Google-Smtp-Source: AG47ELv+UVNUmY66nyPjleFoU483IdsvaFsIicBSAl5ZqDSXHJRpreTjWIAhaWx8+dMVLwT7qajdNA==
Date: Wed, 7 Mar 2018 13:28:49 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: dmaengine: Add MediaTek High-Speed
 DMA controller bindings
Message-ID: <20180307192849.bdedrzqmpmwprpc2@rob-hp-laptop>
References: <cover.1520407882.git.sean.wang@mediatek.com>
 <1ae80ef14cac41dea35dca49e8071d67c955f5e7.1520407882.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae80ef14cac41dea35dca49e8071d67c955f5e7.1520407882.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:16:26PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings for MediaTek High-Speed DMA controller
> which could be found on MT7623 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-hsdma.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

Please add reviewed-by's when posting new versions.

> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
> new file mode 100644
> index 0000000..4bb31735
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
> @@ -0,0 +1,33 @@
> +MediaTek High-Speed DMA Controller
> +==================================
> +
> +This device follows the generic DMA bindings defined in dma/dma.txt.
> +
> +Required properties:
> +
> +- compatible:	Must be one of
> +		  "mediatek,mt7622-hsdma": for MT7622 SoC
> +		  "mediatek,mt7623-hsdma": for MT7623 SoC
> +- reg:		Should contain the register's base address and length.
> +- interrupts:	Should contain a reference to the interrupt used by this
> +		device.
> +- clocks:	Should be the clock specifiers corresponding to the entry in
> +		clock-names property.
> +- clock-names:	Should contain "hsdma" entries.
> +- power-domains: Phandle to the power domain that the device is part of
> +- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
> +		in dmas property of a client device represents the channel
> +		number.
> +Example:
> +
> +        hsdma: dma-controller@1b007000 {
> +		compatible = "mediatek,mt7623-hsdma";
> +		reg = <0 0x1b007000 0 0x1000>;
> +		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
> +		clock-names = "hsdma";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
> +		#dma-cells = <1>;
> +	};
> +
> +DMA clients must use the format described in dma/dma.txt file.
> -- 
> 2.7.4
> 
