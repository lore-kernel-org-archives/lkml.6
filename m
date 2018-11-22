Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B8C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B454120831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B454120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393184AbeKVTW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:22:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47127 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKVTW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:22:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE23E20DB0; Thu, 22 Nov 2018 09:43:58 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96CD120D29;
        Thu, 22 Nov 2018 09:43:48 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:43:48 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Mesih Kilinc <mesihkilnc@gmail.com>
Subject: Re: [RFC PATCH v3 16/17] ARM: dts: suniv: add initial DTSI file for
 F1C100s
Message-ID: <20181122084348.fls7th5psdqulncl@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <05dab577154c72117678c2f49ae85a9663a630e2.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="52n6brchkjhynn6l"
Content-Disposition: inline
In-Reply-To: <05dab577154c72117678c2f49ae85a9663a630e2.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52n6brchkjhynn6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 09:30:49PM +0300, Mesih Kilinc wrote:
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As we have the support for suniv pin controller and CCU n=
ow, add a
> initial DTSI for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilnc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 151 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
>=20
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/sun=
iv-f1c100s.dtsi
> new file mode 100644
> index 0000000..3ad64ee
> --- /dev/null
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +/*
> + * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
> + * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
> + */
> +
> +#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
> +#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
> +
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	interrupt-parent =3D <&intc>;
> +
> +	clocks {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		osc24M: clk-24M {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <24000000>;
> +			clock-output-names =3D "osc24M";
> +		};
> +
> +		osc32k: clk-32k {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <32768>;
> +			clock-output-names =3D "osc32k";
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells =3D <0>;
> +		#size-cells =3D <0>;

I don't think you need those two properties (and the for the clocks as
well). Ideally, if you could compile the dtbs with W=3D1, and fix any
warning, that would be awesome. We're trying to get rid of them, so
let's not add some new ones.

> +		cpu {
> +			compatible =3D "arm,arm926ej-s";
> +			device_type =3D "cpu";
> +		};
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		sram-controller@1c00000 {
> +			compatible =3D "allwinner,suniv-f1c100s-system-control";
> +			reg =3D <0x01c00000 0x30>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			sram_d: sram@10000 {
> +				compatible =3D "mmio-sram";
> +				reg =3D <0x00010000 0x1000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0 0x00010000 0x1000>;
> +
> +				otg_sram: sram-section@0 {
> +					compatible =3D "allwinner,suniv-f1c100s-sram-d";
> +					reg =3D <0x0000 0x1000>;
> +					status =3D "disabled";
> +				};
> +			};
> +		};
> +
> +		ccu: clock@1c20000 {
> +			compatible =3D "allwinner,suniv-f1c100s-ccu";
> +			reg =3D <0x01c20000 0x400>;
> +			clocks =3D <&osc24M>, <&osc32k>;
> +			clock-names =3D "hosc", "losc";
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +		};
> +
> +		intc: interrupt-controller@1c20400 {
> +			compatible =3D "allwinner,suniv-f1c100s-ic";
> +			reg =3D <0x01c20400 0x400>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <1>;
> +		};
> +
> +		pio: pinctrl@1c20800 {
> +			compatible =3D "allwinner,suniv-f1c100s-pinctrl";
> +			reg =3D <0x01c20800 0x400>;
> +			interrupts =3D <38>, <39>, <40>;
> +			clocks =3D <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
> +			clock-names =3D "apb", "hosc", "losc";
> +			gpio-controller;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +			#gpio-cells =3D <3>;
> +
> +			uart0_pins_a: uart-pins-pe {
> +				pins =3D "PE0", "PE1";
> +				function =3D "uart0";
> +			};
> +		};
> +
> +		timer@1c20c00 {
> +			compatible =3D "allwinner,suniv-f1c100s-timer";
> +			reg =3D <0x01c20c00 0x90>;
> +			interrupts =3D <13>;
> +			clocks =3D <&osc24M>;
> +		};
> +
> +		wdt: watchdog@1c20ca0 {
> +			compatible =3D "allwinner,suniv-f1c100s-wdt";

If you don't have any difference with the A31 watchdog (and this is
the same case for the A10 system controller and SRAM's), you can just have

compatible =3D "allwinner,suniv-f1c100s-wdt", "allwinner,sun6i-a31-wdt";

This way, you don't have to patch the driver to add the compatible, it
will fall back to the A31 one (just make sure to document this
properly in the binding doc, you can follow the A64 example).

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--52n6brchkjhynn6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZsRAAKCRDj7w1vZxhR
xQ52AP9TDHedgHdIumVXmppAPBxOm7R+MNCvRCPxyLnSKjiwvgD9Gv8HZaOo8ePP
gMkXEQFdTD/Qw9QzbxpI3NbHNhQexgM=
=wrhr
-----END PGP SIGNATURE-----

--52n6brchkjhynn6l--
