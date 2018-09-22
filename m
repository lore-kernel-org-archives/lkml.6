Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC812154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC812154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIVO1b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:27:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57674 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeIVO1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 10:27:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1077820795; Sat, 22 Sep 2018 10:34:45 +0200 (CEST)
Received: from xps13 (unknown [37.168.24.12])
        by mail.bootlin.com (Postfix) with ESMTPSA id CDEEA20726;
        Sat, 22 Sep 2018 10:34:43 +0200 (CEST)
Date:   Sat, 22 Sep 2018 10:34:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <christophe.kerello@st.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
Message-ID: <20180922103440.12575714@xps13>
In-Reply-To: <1537199260-7280-2-git-send-email-christophe.kerello@st.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
        <1537199260-7280-2-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

<christophe.kerello@st.com> wrote on Mon, 17 Sep 2018 17:47:38 +0200:

> From: Christophe Kerello <christophe.kerello@st.com>
> 
> This patch adds the documentation of the device tree bindings for the STM32
> FMC2 NAND controller.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> new file mode 100644
> index 0000000..93eaf11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> @@ -0,0 +1,90 @@
> +STMicroelectronics Flexible Memory Controller 2 (FMC2)
> +NAND Interface
> +
> +Required properties:
> +- compatible: "st,stm32mp15-fmc2"

I think this form is preferred:

"
- compatible: Should be one of:
              * st,stm32mp15-fmc2
"

> +- reg: the first contains the register location and length

the register location and length of...?

> +       the second contains the data common space used for cs0 and length
> +       the third contains the cmd attribute space used for cs0 and length
> +       the fourth contains the addr attribute space used for cs0 and length
> +       the fifth contains the data common space used for cs1 and length
> +       the sixth contains the cmd attribute space used for cs1 and length
> +       the seventh contains the addr attribute space used for cs1 and length

Maybe you could simplify a bit with something like:

-reg: NAND flash controller memory areas.
      First region ...
      Regions 2 to 4 respectively contain the data, command, and
      address space for CS0.
      Regions 5 to 7 contain the same areas for CS1.

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
> +Children nodes represent the available nand chips.

Please s/nand/NAND/ in plain English.

> +
> +Optional properties:
> +- nand-on-flash-bbt: see nand.txt
> +- nand-ecc-strength: see nand.txt
> +- nand-ecc-step-size: see nand.txt
> +- st,fmc2_timings: array of 8 bytes for NAND timings. The meanings of
> +  these bytes are:
> +  byte 0 TCLR      : CLE to RE delay in number of AHB clock cycles, only 4 bits
> +                     are valid. Zero means one clock cycle, 15 means 16 clock
> +                     cycles.
> +  byte 1 TAR       : ALE to RE delay, 4 bits are valid. Same format as TCLR.
> +  byte 2 THIZ      : number of HCLK clock cycles during which the data bus is
> +                     kept in Hi-Z (tristate) after the start of a write access.
> +                     Only valid for write transactions. Zero means 1 cycle,
> +                     255 means 256 cycles.
> +  byte 3 TWAIT     : number of HCLK clock cycles to assert the command to the
> +                     NAND flash in response to SMWAITn. Zero means 1 cycle,
> +                     255 means 256 cycles.
> +  byte 4 THOLD_MEM : common memory space timing
> +                     number of HCLK clock cycles to hold the address (and data
> +                     when writing) after the command deassertion. Zero means
> +                     1 cycle, 255 means 256 cycles.
> +  byte 5 TSET_MEM  : common memory space timing
> +                     number of HCLK clock cycles to assert the address before
> +                     the command is asserted. Zero means 1 cycle, 255 means 256
> +                     cycles.
> +  byte 6 THOLD_ATT : attribute memory space timing
> +                     number of HCLK clock cycles to hold the address (and data
> +                     when writing) after the command deassertion. Zero means
> +                     1 cycle, 255 means 256 cycles.
> +  byte 7 TSET_ATT  : attribute memory space timing
> +                     number of HCLK clock cycles to assert the address before
> +                     the command is asserted. Zero means 1 cycle, 255 means 256
> +                     cycles.

Let me review the driver but this array of timings is really
suspicious. I am pretty sure you don't need it in the DT.

> +
> +The following ECC strength and step size are currently supported:
> + - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (HAMMING)
> + - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
> + - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8) (default)
> +
> +Example:
> +
> +	fmc2_nand: fmc2_nand@58002000 {
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
> +		pinctrl-0 = <&fmc2_pins_a>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		nand@0 {
> +			reg = <0>;
> +			nand-on-flash-bbt;
> +			st,fmc2_timings = /bits/ 8 <2 2 1 7 1 0 104 25>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +	};

Thanks,
Miquèl
