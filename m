Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74715C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF821741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbeLTNmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:42:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34280 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbeLTNmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:42:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 70CA12072F; Thu, 20 Dec 2018 14:42:01 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1270520717;
        Thu, 20 Dec 2018 14:42:01 +0100 (CET)
Date:   Thu, 20 Dec 2018 14:42:01 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2
 NAND controller documentation
Message-ID: <20181220144201.54f182e1@bbrezillon>
In-Reply-To: <1544781488-18723-2-git-send-email-christophe.kerello@st.com>
References: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
        <1544781488-18723-2-git-send-email-christophe.kerello@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 10:58:06 +0100
Christophe Kerello <christophe.kerello@st.com> wrote:

> This patch adds the documentation of the device tree bindings for the STM32
> FMC2 NAND controller.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> new file mode 100644
> index 0000000..ad2bef8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> @@ -0,0 +1,61 @@
> +STMicroelectronics Flexible Memory Controller 2 (FMC2)
> +NAND Interface
> +
> +Required properties:
> +- compatible: Should be one of:
> +              * st,stm32mp15-fmc2
> +- reg: NAND flash controller memory areas.
> +       First region contains the register location.
> +       Regions 2 to 4 respectively contain the data, command,
> +       and address space for CS0.
> +       Regions 5 to 7 contain the same areas for CS1.
> +- interrupts: The interrupt number
> +- pinctrl-0: Standard Pinctrl phandle (see: pinctrl/pinctrl-bindings.txt)
> +- clocks: The clock needed by the NAND flash controller
> +
> +Optional properties:
> +- resets: Reference to a reset controller asserting the FMC controller
> +- dmas: DMA specifiers (see: dma/stm32-mdma.txt)
> +- dma-names: Must be "tx", "rx" and "ecc"
> +
> +* NAND device bindings:
> +
> +Required properties:
> +- reg: describes the CS lines assigned to the NAND device.
> +
> +Optional properties:
> +- nand-on-flash-bbt: see nand.txt
> +- nand-ecc-strength: see nand.txt
> +- nand-ecc-step-size: see nand.txt
> +
> +The following ECC strength and step size are currently supported:
> + - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Hamming)
> + - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
> + - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8) (default)
> +
> +Example:
> +
> +	fmc: nand-controller@58002000 {
> +		compatible = "st,stm32mp15-fmc2";
> +		reg = <0x58002000 0x1000>,
> +		      <0x80000000 0x1000>,
> +		      <0x88010000 0x1000>,
> +		      <0x88020000 0x1000>,
> +		      <0x81000000 0x1000>,
> +		      <0x89010000 0x1000>,
> +		      <0x89020000 0x1000>;
> +		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&rcc FMC_K>;
> +		resets = <&rcc FMC_R>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fmc_pins_a>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		nand@0 {
> +			reg = <0>;
> +			nand-on-flash-bbt;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +	};

