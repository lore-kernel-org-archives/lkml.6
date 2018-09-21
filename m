Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7897121523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7897121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389728AbeIUSZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:25:41 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33301 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:25:41 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8919CE000B;
        Fri, 21 Sep 2018 12:36:54 +0000 (UTC)
Date:   Fri, 21 Sep 2018 14:36:52 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: renesas,rzn1-pinctrl:
 documentation
Message-ID: <20180921123652.GH16851@w540>
References: <20180919142346.25468-1-phil.edworthy@renesas.com>
 <20180919142346.25468-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oWj5HoUXCVjyUFuT"
Content-Disposition: inline
In-Reply-To: <20180919142346.25468-2-phil.edworthy@renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oWj5HoUXCVjyUFuT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Phil,

On Wed, Sep 19, 2018 at 03:23:44PM +0100, Phil Edworthy wrote:
> The Renesas RZ/N1 device family PINCTRL node description.
>
> Based on a patch originally written by Michel Pollet at Renesas.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v4:
>  - Add alternative way to use the pinmux prop.
>  - Remove mention of gpios.
>
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
>  .../bindings/pinctrl/renesas,rzn1-pinctrl.txt | 153 ++++++++++++++++++
>  include/dt-bindings/pinctrl/rzn1-pinctrl.h    | 141 ++++++++++++++++
>  2 files changed, 294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
>  create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
> new file mode 100644
> index 000000000000..323ef5c6c1c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
> @@ -0,0 +1,153 @@
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
> +- clocks: phandle for the clock, see the description of clock-names below.
> +- clock-names: Contains the name of the clock:
> +    "bus", the bus clock, sometimes described as pclk, for register accesses.
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
> +function.
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
> +  node-3 {
> +      pinmux = <PIN_ID_AND_MUX>, <PIN_ID_AND_MUX>, ... ;
> +      GENERIC_PINCONFIG;
> +
> +      sub-node-1 {
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

I can't think a use case for this format, but it doesn't hurt I guess

> +
> +  Use the latter two formats when pins part of the same logical group need to
> +  have different generic pin configuration flags applied. Note that the generic
> +  pinconfig in node-3 does not apply to the sub-nodes.
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
> +      These identifiers collapse the IO Multiplex Configuration Level 1 and
> +      Level 2 numbers that are detailed in the hardware reference manual into a
> +      single number. The identifiers for Level 2 are simply offset by 10.
> +      Additional identifiers are provided to specify the MDIO source peripheral.
> +
> +  Optional generic properties:
Optional generic pinconf properties

Minors apart, please add my:
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j

> +    - bias-disable		- disable any pin bias
> +    - bias-pull-up		- pull up the pin with 50 KOhm
> +    - bias-pull-down		- pull down the pin with 50 KOhm
> +    - bias-high-impedance	- high impedance mode
> +    - drive-strength		- sink or source at most 4, 6, 8 or 12 mA
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
> +		pinmux = <RZN1_MUX(103, UART0_I)>;	/* UART0_TXD */
> +
> +		pins_uart6_rx {
> +			pinmux = <RZN1_MUX(104, UART0_I)>;	/* UART0_RXD */
> +			bias-pull-up;
> +		};
> +	};
> +  };
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

--oWj5HoUXCVjyUFuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbpOXkAAoJEHI0Bo8WoVY8cUwP/3BDRFIzvvn/wvP3R2HjqkI1
l1gfxuc00/Vo15kKCMkGzdXIS1JxTxJkQmGEEeIYbBk2adY4POgb4sweDakscKkX
vtowbQi99fcrzJgo6YwCTAMMkqcEzG/Zdab36Wja4Gl5XOr4XhnJmaEFovBdP3yV
TL9zKMuE4HOWkP0tYCaeU7zqlbJGsvaM71raxZDdIoLBxWUmC+EmZu9ChYK4GZYx
6Ff2ZZlcIEy3U2GtFGMKOrIbfCUvE+vrN52Wzib7c19S+tSafNEajVs0E6/8eEBC
NsqNyh5Mqrd+50TH9sHrOVgqqMHF43Pn931AfEVeR3HX30t3BzPlrBQUs03qlm9H
rxlH0eeLfpDej+oeNVz7EaZWkx8HDJX4A9QlMH1gwwLldAA5Cu7I0SrbeNP8QFJ8
aySKhaSunXwTZ1g2J6d8lAFPRQONVLgY88XJ9nu69ftu5Upo6WSb+1ni0z9Qo9wA
K60RrYWCpkc2g+Z4pobtnqbKsuzlZWwhVboOQ+uQxTz9+6LAg1XHDqo2dnymG+Kd
UzSSPGlTSxCWetizdVO09/lweNTOAUDt1LELouCgIsDQ8nNu0ffG0vSDEo+tikxR
UwMZ0yjzR+kTE5443NusRVrn9FbcWRJAHjMrvlL48SLqc8B4rjv4Y7E9RYPvhd1I
kA/WKM7Hv2Gz3YVmfY4o
=EWGh
-----END PGP SIGNATURE-----

--oWj5HoUXCVjyUFuT--
