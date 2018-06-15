Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6D795C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233A9208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233A9208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936191AbeFOIlG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:41:06 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46557 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeFOIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:41:04 -0400
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9F31F24000F;
        Fri, 15 Jun 2018 08:40:54 +0000 (UTC)
Date:   Fri, 15 Jun 2018 10:40:52 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] dt-bindings: clock: renesas,r9a06g032-pinctrl:
 documentation
Message-ID: <20180615084052.GB12638@w540>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <1528974029-29617-3-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi again Michel,

On Thu, Jun 14, 2018 at 12:00:18PM +0100, Michel Pollet wrote:
> The Renesas R9A06G032 PINCTRL node description.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  .../bindings/pinctrl/renesas,r9a06g032-pinctrl.txt | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-pinctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-pinctrl.txt
> new file mode 100644
> index 0000000..f63696f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-pinctrl.txt
> @@ -0,0 +1,124 @@
> +Renesas RZ/A1 combined Pin and GPIO controller
> +
> +The Renesas SoCs of the RZ/A1 family feature a combined Pin and GPIO controller,
> +named "Ports" in the hardware reference manual.
> +Pin multiplexing and GPIO configuration is performed on a per-pin basis
> +writing configuration values to per-port register sets.
> +Each "port" features up to 16 pins, each of them configurable for GPIO
> +function (port mode) or in alternate function mode.
> +Up to 8 different alternate function modes exist for each single pin.

Apart from the above part that should be re-worked, and the
s/clock/pinctrl in the patch subject, I have some more comments on the
proposed bindings.

> +
> +Pin controller node
> +-------------------
> +
> +Required properties:
> +  - compatible: should be:
> +    - "renesas,r9a05g032-pinctrl"
> +  - reg
> +    address base and length of the memory area where the pin controller
> +    hardware is mapped to.
> +
> +Example:
> +	pinctrl: pinctrl@40067000 {
> +		compatible = "renesas,r9a06g032-pinctrl";
> +		reg = <0x40067000 0x1000>, <0x51000000 0x800>;
> +		clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> +		clock-names = "bus";
> +		status = "okay";
> +	};
> +
> +
> +Sub-nodes
> +---------
> +  The child nodes of the pin controller node describe a pin multiplexing
> +  group that can be used by driver nodes.
> +

s/driver nodes/device nodes/ ?

> +  A pin multiplexing sub-node describes how to configure a set of
> +  (or a single) pin in some desired alternate function mode.
> +  A single sub-node may define several pin configurations.
> +

That's fine, even if it's a repetition of what is described in the
generic pinctrl bindings (pinctrl-bindings.txt)

> +  The allowed generic formats for a pin multiplexing sub-node are the
> +  following ones:
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

That's not necessary imho. Just refer to the generic pinctrl bindings
documentation. Or are there differences I am missing here?

> +  Required properties:
> +    - renesas,rzn1-pinctrl:
> +      Array of integers representing each 'pin' and it's configuration.
> +

Why a custom property? When upstreaming the rz/a1 infamous pinctrl
driver, we extended the generic bindings with the 'pinxmux' property
that allows to specify an array of (pin id + mux) 'pinmux groups', as reported
in the generic bindings documentation:

----------------------------------------------------------------------------
For hardware where pin multiplexing configurations have to be specified for
each single pin the number of required sub-nodes containing "pin" and
"function" properties can quickly escalate and become hard to write and
maintain.

For cases like this, the pin controller driver may use the pinmux helper
property, where the pin identifier is provided with mux configuration settings
in a pinmux group. A pinmux group consists of the pin identifier and mux
settings represented as a single integer or an array of integers.

The pinmux property accepts an array of pinmux groups, each of them describing
a single pin multiplexing configuration.

pincontroller {
	state_0_node_a {
		pinmux = <PINMUX_GROUP>, <PINMUX_GROUP>, ...;
	};
};

Each individual pin controller driver bindings documentation shall specify
how pin IDs and pin multiplexing configuration are defined and assembled
together in a pinmux group.
-----------------------------------------------------------------------------

Do you think too it applies to your use case?

> +      A 'pin number' does not correspond 1:1 to the hardware manual notion of
> +      PL_GPIO directly. Numbers 0...169 are PL_GPIOs, however there is also two
> +      extra 170 and 171 that corresponds to the MDIO0 and MDIO1 bus config.
> +
> +      A 'function' also does not correspond 1:1 to the hardware manual. There
> +      are 2 levels of pin muxing, Level 1, level 2 -- to this are added the
> +      MDIO configurations.
> +
> +      Helper macros to ease assembling the pin index and function identifier
> +      are provided by the pin controller header file at:
> +      <include/dt-bindings/pinctrl/r9a06g032-pinctrl.h>

This part is good and represent what the generic bindings refers to
with:

Each individual pin controller driver bindings documentation shall specify
how pin IDs and pin multiplexing configuration are defined and assembled
together in a pinmux group.

> +
> +Example #1:
> +  A simple case configuring only the function for a given 'pin' works as follow:
> +	#include <include/dt-bindings/pinctrl/r9a06g032-pinctrl.h>
> +	&pinctrl {
> +		pinsuart0: pinsuart0 {
> +			renesas,rzn1-pinmux-ids = <
> +				RZN1_MUX(103, UART0_I)	/* UART0_TXD */
> +				RZN1_MUX(104, UART0_I)	/* UART0_RXD */
> +			>;
> +		};
> +	};

That would be like

	&pinctrl {
		pinsuart0: pinsuart0 {
			pinmux = < RZN1_MUX(103, UART0_I),	/* UART0_TXD */
				   RZN1_MUX(104, UART0_I)	/* UART0_RXD */
			>;
		};
	};

> +
> +	&uart0 {
> +		status = "okay";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinsuart0>;
> +	};

just report the pinmux node, no need for the client in the example.
It's standard stuff.

> +  Note that in this case the other functions of the pins are not changed.

What 'other functions'? The pin configuration as in pull up/down etc?

> +
> +Example #2:
> +  Here we also set the pullups on the RXD pin:
> +	&pinctrl {
> +		pinsuart0: pinsuart0 {
> +			renesas,rzn1-pinmux-ids = <
> +				RZN1_MUX(103, UART0_I)	/* UART0_TXD */
> +				RZN1_MUX_PUP(104, UART0_I)	/* UART0_RXD */
> +			>;
> +		};
> +	};

I recall we used to upstream pin configuration along with pixmuxing,
as you're doing here and it didn't end well. I suggest to use the standard
properties where possible, in this case 'bias-pull-up'.

I think it should look like this:

	&pinctrl {
		pinsuart0: pinsuart0 {
                        pinsuart_rx {
                                /* UART0_TXD */
                                pinmux = <RZN1_MUX(103, UART0_I)>;
                        };
                        pinsuart_tx {
                                /* UART0_TXD with pull-up */
                                pinmux = <RZN1_MUX(104, UART0_I)>;
                                bias-pull-up;

                        };
		};
	};

        &uart0 {
                pinctrl-0 = <&pinsuart0>;
                ...
        };

Then in your driver you should parse pin configuration properties as
collected by the pinctrl core and apply them where appropriate.

> +  There are many alternative macros to set the pullup/down/none and the drive
> +  strenght in the r9a06g032-pinctrl.h header file.
> +
> +Example #3:
> +  The Soc has two configurable MDIO muxes, these can also be configured
> +  with this interface using the 'special' MDIO constants:
> +
> +	&pinctrl {
> +		mdio_mux: mdiomux {
> +			renesas,rzn1-pinmux-ids = <
> +				RZN1_MUX(RZN1_MDIO_BUS0, RZN1_FUNC_MDIO_MUX_MAC0)
> +				RZN1_MUX(RZN1_MDIO_BUS1, RZN1_FUNC_MDIO_MUX_SWITCH)
> +			>;
> +		};
> +	};
> +  Clearly the pull/up/none and drive constants will be ignored, even if
> +  specified.
> +
> +Note that Renesas provides an extensive webapp that can generates a device tree
> +file for your board. See their website for this part number for details.

Imho this shouldn't be mentioned here, and autogeneration of device
tree files with a custom proprietary tool shouldn't be encouraged at
all, at least not from the device bindings.

Thanks
   j

> --
> 2.7.4
>

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbI3uUAAoJEHI0Bo8WoVY8UbEQALmCefHjqk967t1IhSxoiHpZ
uJfiwyURnpSYWTsoy81FacDIvxSwLzhMgmo6N/dK8FPJNwUitvDa6g6AXZ2HZm76
/vp+2NArvbAjvciKpHWgnGSLqpGr8wZbKN8LGGuYLb5woFEPgzCDDw9xlWx3ZhcZ
m6F+FrgOMz16B9b20MXSyXiPFEhS1HDtO2VKmFVMlCY7zbGLRvYmbYRacOsWKJDP
UqS7/ivNMvlTC7JTXw9YO7meM9yMErbYxSsPPGUMGzLtyHYP1eQjJ+78UmaOgjtP
u+IarIN1dlNAUbCnOlvKb3mObXK6NW1TRnebrr7Z+QbvGeseiMXt2yjEHQ5bP8Sa
S3vgTw5BYgT6bm4I5n6n86Y6jr7hpEvNa4c8k4NxlxCVt0Gte6Tz9kJM8RpbyQLd
VqzMv5+Ovfbr58VJiA3zZ2wFrNKwLvbeKdUWHpydnXdltymx6BjlEx97nUALnTbX
K6Lm8qW/c354WSys15bZ6V+AYO36MlXIKizqGdSbLtQE7LF/+8mpjc3CPB1v7b3m
eyaNlcz2vNWEP0nFAY5Jb3k04Qp52wt93MHc1pyG3lmKuZMh7NAsO/GcCnHOyyEZ
PlBz2xFfEhzpnfBLuUQjOGNBH+/f65mUB+I3FCM5mmbB2Xu4L0Uyd4uHKslq3C/m
O2VeBNo76KzmsqWt+vvb
=fy28
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
