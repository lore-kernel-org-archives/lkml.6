Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F473C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E5B20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E5B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJEQvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:51:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38139 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeJEQvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:51:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6FC492074F; Fri,  5 Oct 2018 11:53:50 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id F3677206A1;
        Fri,  5 Oct 2018 11:53:49 +0200 (CEST)
Date:   Fri, 5 Oct 2018 11:53:50 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <christophe.kerello@st.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2
 NAND controller documentation
Message-ID: <20181005115350.64d640eb@bbrezillon>
In-Reply-To: <1538732520-2800-2-git-send-email-christophe.kerello@st.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
        <1538732520-2800-2-git-send-email-christophe.kerello@st.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 11:41:58 +0200
<christophe.kerello@st.com> wrote:

> From: Christophe Kerello <christophe.kerello@st.com>
> 
> This patch adds the documentation of the device tree bindings for the STM32
> FMC2 NAND controller.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> new file mode 100644
> index 0000000..b620176
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> @@ -0,0 +1,59 @@
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

Maybe you could use reg-names here ("nfc", "csX-data", "csX-cmd",
"csX-addr"). Anyway, even without this

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> +- interrupts: The interrupt number
> +- pinctrl-0: Standard Pinctrl phandle (see: pinctrl/pinctrl-bindings.txt)
> +- clocks: Use common clock framework
> +
> +Optional properties:
> +- resets: Reference to a reset controller asserting the FMC controller
> +- dmas: DMA specifiers (see: dma/stm32-mdma.txt)
> +- dma-names: Must be "tx", "rx" and "ecc"
> +
> +Optional children nodes:
> +Children nodes represent the available NAND chips.
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

