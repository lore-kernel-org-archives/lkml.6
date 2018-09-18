Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A0ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0F8214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0F8214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeIRO7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:59:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41137 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeIRO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:59:18 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DDE7B20012;
        Tue, 18 Sep 2018 09:27:28 +0000 (UTC)
Date:   Tue, 18 Sep 2018 11:27:27 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: renesas,rzn1-pinctrl:
 documentation
Message-ID: <20180918092727.GN16851@w540>
References: <20180917163609.30457-1-phil.edworthy@renesas.com>
 <20180917163609.30457-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Content-Disposition: inline
In-Reply-To: <20180917163609.30457-2-phil.edworthy@renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Phil,
   thanks for the update. This looks much better :)

On Mon, Sep 17, 2018 at 05:36:07PM +0100, Phil Edworthy wrote:
> The Renesas RZ/N1 device family PINCTRL node description.
>
> Based on a patch originally written by Michel Pollet at Renesas.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v3:
>  - Use standard bindings
>  - Change the way the functions are defined so it is easy to check
>    against the hardware numbering.
>  - Add functions for the MDIO source peripheral instead of using
>    virtual pins.
>
> v2:
>  - Change filename to generic rzn1, instead of device specific.
>  - Add "renesas,rzn1-pinctrl" compatible fallback string.
>  - Example register size corrected.
>  - Typos fixed.
>  - Changes suggested by Jacopo Mondi.
>  - rzn1-pinctrl.h squashed into this as requested by Rob Herring.
> ---
>  .../bindings/pinctrl/renesas,rzn1-pinctrl.txt | 129 ++++++++++++++++
>  include/dt-bindings/pinctrl/rzn1-pinctrl.h    | 141 ++++++++++++++++++
>  2 files changed, 270 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
>  create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
> new file mode 100644
> index 000000000000..203131ed8d2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
> @@ -0,0 +1,129 @@
> +Renesas RZ/N1 SoC Pinctrl node description.
> +
> +Pin controller node
> +-------------------
> +Required properties:
> +- compatible: SoC-specific compatible string "renesas,<soc-specific>-pinctrl"
> +  followed by "renesas,rzn1-pinctrl" as fallback. The SoC-specific compatible
> +  strings must be one of:
> +	"renesas,r9a06g032-pinctrl" for RZ/N1D
> +	"renesas,r9a06g033-pinctrl" for RZ/N1S
> +- reg: Address base and length of the memory area where the pin controller
> +  hardware is mapped to.
> +- clocks: phandles for the clock, see the description of clock-names below.
> +- clock-names: Contains the name of the clock:
> +    "bus", the bus clock, sometimes described as pclk, for register accesses.

If that's the only clock, the clock name is optional. If you drop it,
then please mention that the only phandle in 'clocks' refers to the
"bus" clock.

> +
> +Example:
> +	pinctrl: pin-controller@40067000 {
> +	    compatible = "renesas,r9a06g032-pinctrl", "renesas,rzn1-pinctrl";
> +	    reg = <0x40067000 0x1000>, <0x51000000 0x480>;
> +	    clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> +	    clock-names = "bus";
> +	};
> +
> +Sub-nodes
> +---------
> +
> +The child nodes of the pin controller node describe a pin multiplexing
> +function or a GPIO controller alternatively.
> +
> +- Pin multiplexing sub-nodes:
> +  A pin multiplexing sub-node describes how to configure a set of
> +  (or a single) pin in some desired alternate function mode.
> +  A single sub-node may define several pin configurations.
> +  Please refer to pinctrl-bindings.txt to get to know more on generic
> +  pin properties usage.
> +
> +  The allowed generic formats for a pin multiplexing sub-node are the
> +  following ones:
> +
> +  node-1 {
> +      pinmux = <PIN_ID_AND_MUX>, <PIN_ID_AND_MUX>, ... ;
> +      GENERIC_PINCONFIG;
> +  };
> +
> +  node-2 {
> +      sub-node-1 {
> +          pinmux = <PIN_ID_AND_MUX>, <PIN_ID_AND_MUX>, ... ;
> +          GENERIC_PINCONFIG;
> +      };
> +
> +      sub-node-2 {
> +          pinmux = <PIN_ID_AND_MUX>, <PIN_ID_AND_MUX>, ... ;
> +          GENERIC_PINCONFIG;
> +      };
> +
> +      ...
> +
> +      sub-node-n {
> +          pinmux = <PIN_ID_AND_MUX>, <PIN_ID_AND_MUX>, ... ;
> +          GENERIC_PINCONFIG;
> +      };
> +  };
> +
> +  Use the second format when pins part of the same logical group need to have
> +  different generic pin configuration flags applied.
> +
> +  Client sub-nodes shall refer to pin multiplexing sub-nodes using the phandle
> +  of the most external one.
> +
> +  Eg.
> +
> +  client-1 {
> +      ...
> +      pinctrl-0 = <&node-1>;
> +      ...
> +  };
> +
> +  client-2 {
> +      ...
> +      pinctrl-0 = <&node-2>;
> +      ...
> +  };
> +
> +  Required properties:
> +    - pinmux:
> +      integer array representing pin number and pin multiplexing configuration.
> +      When a pin has to be configured in alternate function mode, use this
> +      property to identify the pin by its global index, and provide its
> +      alternate function configuration number along with it.
> +      When multiple pins are required to be configured as part of the same
> +      alternate function they shall be specified as members of the same
> +      argument list of a single "pinmux" property.
> +      Integers values in the "pinmux" argument list are assembled as:
> +      (PIN | MUX_FUNC << 8)
> +      where PIN directly corresponds to the pl_gpio pin number and MUX_FUNC is
> +      one of the alternate function identifiers defined in:
> +      <include/dt-bindings/pinctrl/rzn1-pinctrl.h>

You have a macro for assembling pin and mux functions, do you think it
is worth mentioning it here?

> +      These identifiers collapse the IO Multiplex Configuration Level 1 and
> +      Level 2 numbers that are detailed in the hardware reference manual into a
> +      single number. The identifiers for Level 2 are simply offset by 10.
> +      Additional identifiers are provided to specify the MDIO source peripheral.

As we discussed offline, I don't see that much value in mentioning
details about the pinmuxing levels, as this is driver internal stuff
that reflects on which set of registers to use depending on the muxing
'level'. I understand though that as the SoC manual mentions levels,
you may want to refer to them. Up to you....

> +
> +  Example:
> +  A serial communication interface with a TX output pin and an RX input pin.
> +
> +  &pinctrl {
> +	pins_uart0: pins_uart0 {
> +		pinmux = <
> +			RZN1_MUX(103, UART0_I)	/* UART0_TXD */
> +			RZN1_MUX(104, UART0_I)	/* UART0_RXD */
> +		>;
> +	};
> +  };
> +
> +  Example 2:
> +  Here we set the pull up on the RXD pin of the UART.
> +
> +  &pinctrl {
> +	pins_uart0: pins_uart0 {
> +		pins_uart6_tx {
> +			pinmux = <RZN1_MUX(103, UART0_I)>;	/* UART0_TXD */
> +		};
> +		pins_uart6_rx {
> +			pinmux = <RZN1_MUX(104, UART0_I)>;	/* UART0_RXD */
> +			bias-pull-up;
> +		};
> +	};
> +  };

I like this version much more. With those minor issues clarified (up
to you to decide how to handle them) please add my:
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Cheers
   j


> diff --git a/include/dt-bindings/pinctrl/rzn1-pinctrl.h b/include/dt-bindings/pinctrl/rzn1-pinctrl.h
> new file mode 100644
> index 000000000000..40369ee36e6a
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/rzn1-pinctrl.h
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Defines macros and constants for Renesas RZ/N1 pin controller pin
> + * muxing functions.
> + */
> +#ifndef __DT_BINDINGS_RZN1_PINCTRL_H
> +#define __DT_BINDINGS_RZN1_PINCTRL_H
> +
> +#define RZN1_MUX(_gpio, _func) \
> +	(((RZN1_FUNC_##_func) << 8) | (_gpio))
> +
> +/*
> + * Given the different levels of muxing on the SoC, it was decided to
> + * 'linearize' them into one numerical space. So mux level 1, 2 and the MDIO
> + * muxes are all represented by one single value.
> + *
> + * You can derive the hardware value pretty easily too, as
> + * 0...9   are Level 1
> + * 10...71 are Level 2. The Level 2 mux will be set to this
> + *         value - RZN1_FUNC_L2_OFFSET, and the Level 1 mux will be
> + *         set accordingly.
> + * 72...103 are for the 2 MDIO muxes.
> + */
> +#define RZN1_FUNC_HIGHZ				0
> +#define RZN1_FUNC_0L				1
> +#define RZN1_FUNC_CLK_ETH_MII_RGMII_RMII	2
> +#define RZN1_FUNC_CLK_ETH_NAND			3
> +#define RZN1_FUNC_QSPI				4
> +#define RZN1_FUNC_SDIO				5
> +#define RZN1_FUNC_LCD				6
> +#define RZN1_FUNC_LCD_E				7
> +#define RZN1_FUNC_MSEBIM			8
> +#define RZN1_FUNC_MSEBIS			9
> +#define RZN1_FUNC_L2_OFFSET			10	/* I'm Special */
> +
> +#define RZN1_FUNC_HIGHZ1			(RZN1_FUNC_L2_OFFSET + 0)
> +#define RZN1_FUNC_ETHERCAT			(RZN1_FUNC_L2_OFFSET + 1)
> +#define RZN1_FUNC_SERCOS3			(RZN1_FUNC_L2_OFFSET + 2)
> +#define RZN1_FUNC_SDIO_E			(RZN1_FUNC_L2_OFFSET + 3)
> +#define RZN1_FUNC_ETH_MDIO			(RZN1_FUNC_L2_OFFSET + 4)
> +#define RZN1_FUNC_ETH_MDIO_E1			(RZN1_FUNC_L2_OFFSET + 5)
> +#define RZN1_FUNC_USB				(RZN1_FUNC_L2_OFFSET + 6)
> +#define RZN1_FUNC_MSEBIM_E			(RZN1_FUNC_L2_OFFSET + 7)
> +#define RZN1_FUNC_MSEBIS_E			(RZN1_FUNC_L2_OFFSET + 8)
> +#define RZN1_FUNC_RSV				(RZN1_FUNC_L2_OFFSET + 9)
> +#define RZN1_FUNC_RSV_E				(RZN1_FUNC_L2_OFFSET + 10)
> +#define RZN1_FUNC_RSV_E1			(RZN1_FUNC_L2_OFFSET + 11)
> +#define RZN1_FUNC_UART0_I			(RZN1_FUNC_L2_OFFSET + 12)
> +#define RZN1_FUNC_UART0_I_E			(RZN1_FUNC_L2_OFFSET + 13)
> +#define RZN1_FUNC_UART1_I			(RZN1_FUNC_L2_OFFSET + 14)
> +#define RZN1_FUNC_UART1_I_E			(RZN1_FUNC_L2_OFFSET + 15)
> +#define RZN1_FUNC_UART2_I			(RZN1_FUNC_L2_OFFSET + 16)
> +#define RZN1_FUNC_UART2_I_E			(RZN1_FUNC_L2_OFFSET + 17)
> +#define RZN1_FUNC_UART0				(RZN1_FUNC_L2_OFFSET + 18)
> +#define RZN1_FUNC_UART0_E			(RZN1_FUNC_L2_OFFSET + 19)
> +#define RZN1_FUNC_UART1				(RZN1_FUNC_L2_OFFSET + 20)
> +#define RZN1_FUNC_UART1_E			(RZN1_FUNC_L2_OFFSET + 21)
> +#define RZN1_FUNC_UART2				(RZN1_FUNC_L2_OFFSET + 22)
> +#define RZN1_FUNC_UART2_E			(RZN1_FUNC_L2_OFFSET + 23)
> +#define RZN1_FUNC_UART3				(RZN1_FUNC_L2_OFFSET + 24)
> +#define RZN1_FUNC_UART3_E			(RZN1_FUNC_L2_OFFSET + 25)
> +#define RZN1_FUNC_UART4				(RZN1_FUNC_L2_OFFSET + 26)
> +#define RZN1_FUNC_UART4_E			(RZN1_FUNC_L2_OFFSET + 27)
> +#define RZN1_FUNC_UART5				(RZN1_FUNC_L2_OFFSET + 28)
> +#define RZN1_FUNC_UART5_E			(RZN1_FUNC_L2_OFFSET + 29)
> +#define RZN1_FUNC_UART6				(RZN1_FUNC_L2_OFFSET + 30)
> +#define RZN1_FUNC_UART6_E			(RZN1_FUNC_L2_OFFSET + 31)
> +#define RZN1_FUNC_UART7				(RZN1_FUNC_L2_OFFSET + 32)
> +#define RZN1_FUNC_UART7_E			(RZN1_FUNC_L2_OFFSET + 33)
> +#define RZN1_FUNC_SPI0_M			(RZN1_FUNC_L2_OFFSET + 34)
> +#define RZN1_FUNC_SPI0_M_E			(RZN1_FUNC_L2_OFFSET + 35)
> +#define RZN1_FUNC_SPI1_M			(RZN1_FUNC_L2_OFFSET + 36)
> +#define RZN1_FUNC_SPI1_M_E			(RZN1_FUNC_L2_OFFSET + 37)
> +#define RZN1_FUNC_SPI2_M			(RZN1_FUNC_L2_OFFSET + 38)
> +#define RZN1_FUNC_SPI2_M_E			(RZN1_FUNC_L2_OFFSET + 39)
> +#define RZN1_FUNC_SPI3_M			(RZN1_FUNC_L2_OFFSET + 40)
> +#define RZN1_FUNC_SPI3_M_E			(RZN1_FUNC_L2_OFFSET + 41)
> +#define RZN1_FUNC_SPI4_S			(RZN1_FUNC_L2_OFFSET + 42)
> +#define RZN1_FUNC_SPI4_S_E			(RZN1_FUNC_L2_OFFSET + 43)
> +#define RZN1_FUNC_SPI5_S			(RZN1_FUNC_L2_OFFSET + 44)
> +#define RZN1_FUNC_SPI5_S_E			(RZN1_FUNC_L2_OFFSET + 45)
> +#define RZN1_FUNC_SGPIO0_M			(RZN1_FUNC_L2_OFFSET + 46)
> +#define RZN1_FUNC_SGPIO1_M			(RZN1_FUNC_L2_OFFSET + 47)
> +#define RZN1_FUNC_GPIO				(RZN1_FUNC_L2_OFFSET + 48)
> +#define RZN1_FUNC_CAN				(RZN1_FUNC_L2_OFFSET + 49)
> +#define RZN1_FUNC_I2C				(RZN1_FUNC_L2_OFFSET + 50)
> +#define RZN1_FUNC_SAFE				(RZN1_FUNC_L2_OFFSET + 51)
> +#define RZN1_FUNC_PTO_PWM			(RZN1_FUNC_L2_OFFSET + 52)
> +#define RZN1_FUNC_PTO_PWM1			(RZN1_FUNC_L2_OFFSET + 53)
> +#define RZN1_FUNC_PTO_PWM2			(RZN1_FUNC_L2_OFFSET + 54)
> +#define RZN1_FUNC_PTO_PWM3			(RZN1_FUNC_L2_OFFSET + 55)
> +#define RZN1_FUNC_PTO_PWM4			(RZN1_FUNC_L2_OFFSET + 56)
> +#define RZN1_FUNC_DELTA_SIGMA			(RZN1_FUNC_L2_OFFSET + 57)
> +#define RZN1_FUNC_SGPIO2_M			(RZN1_FUNC_L2_OFFSET + 58)
> +#define RZN1_FUNC_SGPIO3_M			(RZN1_FUNC_L2_OFFSET + 59)
> +#define RZN1_FUNC_SGPIO4_S			(RZN1_FUNC_L2_OFFSET + 60)
> +#define RZN1_FUNC_MAC_MTIP_SWITCH		(RZN1_FUNC_L2_OFFSET + 61)
> +
> +#define RZN1_FUNC_MDIO_OFFSET			(RZN1_FUNC_L2_OFFSET + 62)
> +
> +/* These are MDIO0 peripherals for the RZN1_FUNC_ETH_MDIO function */
> +#define RZN1_FUNC_MDIO0_HIGHZ			(RZN1_FUNC_MDIO_OFFSET + 0)
> +#define RZN1_FUNC_MDIO0_GMAC0			(RZN1_FUNC_MDIO_OFFSET + 1)
> +#define RZN1_FUNC_MDIO0_GMAC1			(RZN1_FUNC_MDIO_OFFSET + 2)
> +#define RZN1_FUNC_MDIO0_ECAT			(RZN1_FUNC_MDIO_OFFSET + 3)
> +#define RZN1_FUNC_MDIO0_S3_MDIO0		(RZN1_FUNC_MDIO_OFFSET + 4)
> +#define RZN1_FUNC_MDIO0_S3_MDIO1		(RZN1_FUNC_MDIO_OFFSET + 5)
> +#define RZN1_FUNC_MDIO0_HWRTOS			(RZN1_FUNC_MDIO_OFFSET + 6)
> +#define RZN1_FUNC_MDIO0_SWITCH			(RZN1_FUNC_MDIO_OFFSET + 7)
> +/* These are MDIO0 peripherals for the RZN1_FUNC_ETH_MDIO_E1 function */
> +#define RZN1_FUNC_MDIO0_E1_HIGHZ		(RZN1_FUNC_MDIO_OFFSET + 8)
> +#define RZN1_FUNC_MDIO0_E1_GMAC0		(RZN1_FUNC_MDIO_OFFSET + 9)
> +#define RZN1_FUNC_MDIO0_E1_GMAC1		(RZN1_FUNC_MDIO_OFFSET + 10)
> +#define RZN1_FUNC_MDIO0_E1_ECAT			(RZN1_FUNC_MDIO_OFFSET + 11)
> +#define RZN1_FUNC_MDIO0_E1_S3_MDIO0		(RZN1_FUNC_MDIO_OFFSET + 12)
> +#define RZN1_FUNC_MDIO0_E1_S3_MDIO1		(RZN1_FUNC_MDIO_OFFSET + 13)
> +#define RZN1_FUNC_MDIO0_E1_HWRTOS		(RZN1_FUNC_MDIO_OFFSET + 14)
> +#define RZN1_FUNC_MDIO0_E1_SWITCH		(RZN1_FUNC_MDIO_OFFSET + 15)
> +
> +/* These are MDIO1 peripherals for the RZN1_FUNC_ETH_MDIO function */
> +#define RZN1_FUNC_MDIO1_HIGHZ			(RZN1_FUNC_MDIO_OFFSET + 16)
> +#define RZN1_FUNC_MDIO1_GMAC0			(RZN1_FUNC_MDIO_OFFSET + 17)
> +#define RZN1_FUNC_MDIO1_GMAC1			(RZN1_FUNC_MDIO_OFFSET + 18)
> +#define RZN1_FUNC_MDIO1_ECAT			(RZN1_FUNC_MDIO_OFFSET + 19)
> +#define RZN1_FUNC_MDIO1_S3_MDIO0		(RZN1_FUNC_MDIO_OFFSET + 20)
> +#define RZN1_FUNC_MDIO1_S3_MDIO1		(RZN1_FUNC_MDIO_OFFSET + 21)
> +#define RZN1_FUNC_MDIO1_HWRTOS			(RZN1_FUNC_MDIO_OFFSET + 22)
> +#define RZN1_FUNC_MDIO1_SWITCH			(RZN1_FUNC_MDIO_OFFSET + 23)
> +/* These are MDIO1 peripherals for the RZN1_FUNC_ETH_MDIO_E1 function */
> +#define RZN1_FUNC_MDIO1_E1_HIGHZ		(RZN1_FUNC_MDIO_OFFSET + 24)
> +#define RZN1_FUNC_MDIO1_E1_GMAC0		(RZN1_FUNC_MDIO_OFFSET + 25)
> +#define RZN1_FUNC_MDIO1_E1_GMAC1		(RZN1_FUNC_MDIO_OFFSET + 26)
> +#define RZN1_FUNC_MDIO1_E1_ECAT			(RZN1_FUNC_MDIO_OFFSET + 27)
> +#define RZN1_FUNC_MDIO1_E1_S3_MDIO0		(RZN1_FUNC_MDIO_OFFSET + 28)
> +#define RZN1_FUNC_MDIO1_E1_S3_MDIO1		(RZN1_FUNC_MDIO_OFFSET + 29)
> +#define RZN1_FUNC_MDIO1_E1_HWRTOS		(RZN1_FUNC_MDIO_OFFSET + 30)
> +#define RZN1_FUNC_MDIO1_E1_SWITCH		(RZN1_FUNC_MDIO_OFFSET + 31)
> +
> +#define RZN1_FUNC_MAX				(RZN1_FUNC_MDIO_OFFSET + 32)
> +
> +#endif /* __DT_BINDINGS_RZN1_PINCTRL_H */
> --
> 2.17.1
>

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJboMT/AAoJEHI0Bo8WoVY8Rt4QAKfXPRRJgPVrt0CB02M6CZXL
OBXsC7NByWyKnAUQH7f+klTTSfsT/+QV/sY4S36kfXj3Ryr1pkq8dJko82Fe0+iP
/aZVN+eHMmL9GiO78mpnDOJlZjACX1xVW5NdBp3l50Y9IGAWuDcQzD+Vdp0qaNUM
6fv1HrQ8+bhdI+P2AtxV9xGmBZBUtHU6zFS7OnMpCxYjfbWjwV5p6IuycVrG4PDp
VmtW53LjBSn+CCXKBnXXkDhYHR3irDH/Gacmd96QnUxzoEfTxSTuWOuZs2dmROum
CzwXbJoxOI4R2HNhLrfOD5Rbt7ikVjOdpajzp1TmE98ISs+EPID8McLRV8ju4Rj4
hOPqDuLYZ9e1B+kOM+RaS+aGJAKJsJtvyTNLa1T/i4s7NLaKiN5etBsHyvoLBUt2
3pF7yDrcV4aLELjxqkeZdjf8c0KzLKpzoLeDTeJGk7Ujl0651Fb+Cm1f7lPz1kcc
8Hp+FtdAstwLWFDZpudizsrJEKVgircqd6wHPB9T7MsvNwQuEvM2N5yqfGMiAe+r
cAh93AlAzYLZFozVd5t0bMvdnV6JsAmdjpHhVfqfH7UV8YHmdrp9LN3AFM9JacCU
3TIKGnXWjY8INQZ9XU/vjrRJ48kF+xYKJXXgoAQY6TNcA62GE6PB08q0xhIWJ5UX
Nc6HT1vBg/D2Q66X/xCz
=siDm
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
