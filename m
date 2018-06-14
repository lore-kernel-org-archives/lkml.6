Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5FE90C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A3A208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A3A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936061AbeFNMFC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:05:02 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54051 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755124AbeFNMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:05:00 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4F934FF826;
        Thu, 14 Jun 2018 12:04:57 +0000 (UTC)
Date:   Thu, 14 Jun 2018 14:04:46 +0200
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
Message-ID: <20180614120446.GA12638@w540>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1528974029-29617-3-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michel,

On Thu, Jun 14, 2018 at 12:00:18PM +0100, Michel Pollet wrote:
> The Renesas R9A06G032 PINCTRL node description.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  .../bindings/pinctrl/renesas,r9a06g032-pinctrl.txt | 124 +++++++++++++++=
++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,r9a=
06g032-pinctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-=
pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-p=
inctrl.txt
> new file mode 100644
> index 0000000..f63696f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-pinctrl=
=2Etxt
> @@ -0,0 +1,124 @@
> +Renesas RZ/A1 combined Pin and GPIO controller
> +
> +The Renesas SoCs of the RZ/A1 family feature a combined Pin and GPIO con=
troller,
> +named "Ports" in the hardware reference manual.
> +Pin multiplexing and GPIO configuration is performed on a per-pin basis
> +writing configuration values to per-port register sets.
> +Each "port" features up to 16 pins, each of them configurable for GPIO
> +function (port mode) or in alternate function mode.
> +Up to 8 different alternate function modes exist for each single pin.

This is a plain copy of the RZ/A1 pin controller documentation.
I don't know RZ/N devices and cannot tell if it applies here too, but
this needs an s/A1/N at the least.

=46rom a very superficial look at the proposed bindings and pinctrl
driver, I wonder if the rza1 pinctrl driver could be expanded and re-used.
Have you considered that before starting one from scratch?

Thanks
   j

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
> +		compatible =3D "renesas,r9a06g032-pinctrl";
> +		reg =3D <0x40067000 0x1000>, <0x51000000 0x800>;
> +		clocks =3D <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> +		clock-names =3D "bus";
> +		status =3D "okay";
> +	};
> +
> +
> +Sub-nodes
> +---------
> +  The child nodes of the pin controller node describe a pin multiplexing
> +  group that can be used by driver nodes.
> +
> +  A pin multiplexing sub-node describes how to configure a set of
> +  (or a single) pin in some desired alternate function mode.
> +  A single sub-node may define several pin configurations.
> +
> +  The allowed generic formats for a pin multiplexing sub-node are the
> +  following ones:
> +
> +  Client sub-nodes shall refer to pin multiplexing sub-nodes using the p=
handle
> +  of the most external one.
> +
> +  Eg.
> +
> +  client-1 {
> +      ...
> +      pinctrl-0 =3D <&node-1>;
> +      ...
> +  };
> +
> +  client-2 {
> +      ...
> +      pinctrl-0 =3D <&node-2>;
> +      ...
> +  };
> +
> +  Required properties:
> +    - renesas,rzn1-pinctrl:
> +      Array of integers representing each 'pin' and it's configuration.
> +
> +      A 'pin number' does not correspond 1:1 to the hardware manual noti=
on of
> +      PL_GPIO directly. Numbers 0...169 are PL_GPIOs, however there is a=
lso two
> +      extra 170 and 171 that corresponds to the MDIO0 and MDIO1 bus conf=
ig.
> +
> +      A 'function' also does not correspond 1:1 to the hardware manual. =
There
> +      are 2 levels of pin muxing, Level 1, level 2 -- to this are added =
the
> +      MDIO configurations.
> +
> +      Helper macros to ease assembling the pin index and function identi=
fier
> +      are provided by the pin controller header file at:
> +      <include/dt-bindings/pinctrl/r9a06g032-pinctrl.h>
> +
> +Example #1:
> +  A simple case configuring only the function for a given 'pin' works as=
 follow:
> +	#include <include/dt-bindings/pinctrl/r9a06g032-pinctrl.h>
> +	&pinctrl {
> +		pinsuart0: pinsuart0 {
> +			renesas,rzn1-pinmux-ids =3D <
> +				RZN1_MUX(103, UART0_I)	/* UART0_TXD */
> +				RZN1_MUX(104, UART0_I)	/* UART0_RXD */
> +			>;
> +		};
> +	};
> +
> +	&uart0 {
> +		status =3D "okay";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinsuart0>;
> +	};
> +  Note that in this case the other functions of the pins are not changed.
> +
> +Example #2:
> +  Here we also set the pullups on the RXD pin:
> +	&pinctrl {
> +		pinsuart0: pinsuart0 {
> +			renesas,rzn1-pinmux-ids =3D <
> +				RZN1_MUX(103, UART0_I)	/* UART0_TXD */
> +				RZN1_MUX_PUP(104, UART0_I)	/* UART0_RXD */
> +			>;
> +		};
> +	};
> +  There are many alternative macros to set the pullup/down/none and the =
drive
> +  strenght in the r9a06g032-pinctrl.h header file.
> +
> +Example #3:
> +  The Soc has two configurable MDIO muxes, these can also be configured
> +  with this interface using the 'special' MDIO constants:
> +
> +	&pinctrl {
> +		mdio_mux: mdiomux {
> +			renesas,rzn1-pinmux-ids =3D <
> +				RZN1_MUX(RZN1_MDIO_BUS0, RZN1_FUNC_MDIO_MUX_MAC0)
> +				RZN1_MUX(RZN1_MDIO_BUS1, RZN1_FUNC_MDIO_MUX_SWITCH)
> +			>;
> +		};
> +	};
> +  Clearly the pull/up/none and drive constants will be ignored, even if
> +  specified.
> +
> +Note that Renesas provides an extensive webapp that can generates a devi=
ce tree
> +file for your board. See their website for this part number for details.
> --
> 2.7.4
>

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbIlneAAoJEHI0Bo8WoVY85sgQAJiDP5mkkYI6iC1UbmmPI8R2
krwaCfjZUXwwc3jyd13/gn4GzF1qbR54QbwXaJjB2QPdDFu0v6ZiXoBFXUIoW6Tp
2Dvy/lKzEuuEa8nthcVeG1QZGpWqAcrN4iBFCohHY9j371l9VmuO85af/mZMEVd7
hv85D4/OQDQ7+flkrmLpj012LuF//wvCgwH+pAKseaJlx4QC2aRpjvtUJytWxNmX
DUscN/gDl9KY4KgzYfR18jwIxoQEZzFJ8HHdqmcuZPkTAY1dVPTn1pVCrcwfqgc+
Ift9yyiwa/dC0pPgVgqXa9O7kWXAvfSa/zk06cYM7Ua9LZb8Urj/lg7wb5RpACql
Nin3VNezp85RkyfM2Bm/X9QfZazU/pEDa1IOaPU/Yrx5skdlIb+F1gZ/OFp+1Yoh
wZQwuofHoaEVDbf/I3iQkdev14nnBzAl25fVLc9nxOL2HpaU2/3mK7szx431jI/z
VQi7zLsZwrm6yqLFbV9yzLHmm1wyHhpMCk+eAawvunYGOcULTylAuMjuJfYFoL+U
PT9LDr0zeosPOtqnXmN/PjyQTzL7hiJJbrA+LEhpsZbG3bTaJdqesIYYAEl0SrvI
S6jo7naCNhLhC/3VmdzG55P/fWBQN3+8JPegBjdzuLfzdAl3VlxhspkGbtic2/Rd
QZKW60zD2c16nr0y0H/U
=I9lS
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
