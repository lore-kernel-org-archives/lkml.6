Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeBEGKQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:10:16 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42375 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeBEGJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:12 -0500
X-Google-Smtp-Source: AH8x224Ue5FhPo6NzQKBvy6asqgk34k85QBW9KcTZUXNvhtSxGmgIsOq2ZB0b4weRhPlznS1HCzPeg==
Date: Mon, 5 Feb 2018 00:09:10 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: Add MediaTek High-Speed
 DMA controller bindings
Message-ID: <20180205035244.zrltzoxwe4owe4dw@rob-hp-laptop>
References: <cover.1517454174.git.sean.wang@mediatek.com>
 <698453fba5198168829a596ec8d58d1f730aaf45.1517454174.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698453fba5198168829a596ec8d58d1f730aaf45.1517454174.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 11:45:23AM +0800, sean.wang@mediatek.com wrote:
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
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
> new file mode 100644
> index 0000000..c07c03e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
> @@ -0,0 +1,33 @@
> +MediaTek High-Speed DMA Controller
> +==================================
> +
> +This driver follows the generic DMA bindings defined in dma/dma.txt.

Bindings describe h/w, not drivers.

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
> +        hsdma: hsdma@1b007000 {

dma-controller@...

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
