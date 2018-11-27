Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5779C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E7F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E7F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbeK0U5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:57:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33591 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbeK0U5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:57:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 84547207A8; Tue, 27 Nov 2018 11:00:08 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4F160206D8;
        Tue, 27 Nov 2018 10:59:58 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:59:58 +0100
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
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v4 16/17] ARM: dts: suniv: add initial DTSI file for
 F1C100s
Message-ID: <20181127095958.vxyymf63ehdyem4z@flea>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <3a0db6052d58eb440ea29772fc7ad2502a1dfa3b.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55oy4ixgvhonlwnx"
Content-Disposition: inline
In-Reply-To: <3a0db6052d58eb440ea29772fc7ad2502a1dfa3b.1543131714.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55oy4ixgvhonlwnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 10:43:19AM +0300, Mesih Kilinc wrote:
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As we have the support for suniv pin controller and CCU n=
ow, add a
> initial DTSI for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 147 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
>=20
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/sun=
iv-f1c100s.dtsi
> new file mode 100644
> index 0000000..11bc999
> --- /dev/null
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -0,0 +1,147 @@
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
> +			compatible =3D "allwinner,suniv-f1c100s-system-control",
> +				     "allwinner,sun4i-a10-system-control";
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
> +					compatible =3D "allwinner,suniv-f1c100s-sram-d",
> +						     "allwinner,sun4i-a10-sram-d";
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

The dt bindings headers and those DT are going to be merged through
separate trees, so you can't use these defines yet. Please use the
actual numbers in the DT for now, and send a patch fixing this when
4.21-rc1 will be out.

> +			clock-names =3D "apb", "hosc", "losc";
> +			gpio-controller;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +			#gpio-cells =3D <3>;
> +
> +			uart0_pins_a: uart-pins-pe {

This would be uart0_pe_pins: uart0-pe-pins.

Thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--55oy4ixgvhonlwnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0VngAKCRDj7w1vZxhR
xeoDAQCtN0ya4XEl1e0z8MmFGWxi29S2FMHXI8MK8IUe+jGZzAD+J5sglK7AB1Nb
eLgdBK5qSnjL2+FZbfMLxPYhr62Bvwg=
=gDu/
-----END PGP SIGNATURE-----

--55oy4ixgvhonlwnx--
