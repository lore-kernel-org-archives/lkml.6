Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149CC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124222077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeJMEGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:06:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeJMEGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:06:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id u22so13526897ota.12;
        Fri, 12 Oct 2018 13:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P1bHwF+AFT8xNDZsYdwNSvT99/dNs63nIP1CdMQEhdM=;
        b=IwtDgWKjI3UrRHhQrDdsXml2Bf/gPIdwGMduSQcNPEmOZPK8d6fw6OaEIuS5fYLLW3
         aP1kF3ZGDF94hItJZm2MTtxL2nKRh6r/umZ3MJ/HPzG15rxvt0vNmTnzy1DI4j0mc7dD
         w8m9EMwLJmGYxxJr92Q4nnSLbg8IA0CiDnKFgAfVkYgyti53Wbb+GJBT6PSEnh45uxfi
         s6wQ9UqUeAcM28g4WO+oUeBqqjaRgG4oQ+BTJTc8zQ6Rzv+Qf9zGgG42J4+sdiqbtTju
         Bb6D/wl69SW0qJngyfPbeUiQ9w+7qPgpbKVz7RrOrIXN2h0PHbdSiTa/Ka7pl1IkI4wv
         qtJg==
X-Gm-Message-State: ABuFfojDe4O/34t+fPKNrTfTb8+FE6RGzkyid4io8zp0qGbGtviGgnzm
        /l5GYDbmCj6F2hihzBBhh8H4tss=
X-Google-Smtp-Source: ACcGV62dM6QyFzqj2ACiuimi3vedCC5JPV6AMjIWb3wOAD6DNKtFP1cROWWBuUuqsD7G0vMq4OgeAQ==
X-Received: by 2002:a9d:5b6:: with SMTP id 51mr4614411otd.221.1539376351398;
        Fri, 12 Oct 2018 13:32:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 110sm670197otj.19.2018.10.12.13.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:32:30 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:32:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     christophe.kerello@st.com
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
Message-ID: <20181012203229.GA9657@bogus>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
 <1538732520-2800-2-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538732520-2800-2-git-send-email-christophe.kerello@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 11:41:58AM +0200, christophe.kerello@st.com wrote:
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
> +- interrupts: The interrupt number
> +- pinctrl-0: Standard Pinctrl phandle (see: pinctrl/pinctrl-bindings.txt)
> +- clocks: Use common clock framework

How many? 'common clock framework' is a Linux thing, not part of 
bindings.

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
> -- 
> 1.9.1
> 
