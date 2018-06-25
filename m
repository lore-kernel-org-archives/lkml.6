Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B37C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E6F25D9B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E6F25D9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754979AbeFYP7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:59:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60432 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754186AbeFYP7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:59:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F021720834; Mon, 25 Jun 2018 17:59:37 +0200 (CEST)
Received: from localhost (unknown [88.128.82.118])
        by mail.bootlin.com (Postfix) with ESMTPSA id B2582203B4;
        Mon, 25 Jun 2018 17:59:27 +0200 (CEST)
Date:   Mon, 25 Jun 2018 17:59:28 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 6/7] arm64: allwinner: a64: add device tree node for
 HDMI simplefb
Message-ID: <20180625155928.ep6xrqhbxwejjr4a@flea>
References: <20180622124540.56203-1-icenowy@aosc.io>
 <20180622124540.56203-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="noanhksd45spdaor"
Content-Disposition: inline
In-Reply-To: <20180622124540.56203-5-icenowy@aosc.io>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--noanhksd45spdaor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 08:45:39PM +0800, Icenowy Zheng wrote:
> As the U-Boot bootloader now is also capable of initialize the HDMI on
> A64 boards, add a simplefb device tree node for accessing the HDMI
> framebuffer initialized by the bootloader.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Dropped LCD SimpleFB as it's already added. LCD SimpleFB needs some
>   fix but the fix is present when adding DE2 CCU.
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 318c4ba8ae9f..840753432ea5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -68,6 +68,15 @@
>  				 <&display_clocks CLK_MIXER0>;
>  			status =3D "disabled";
>  		};
> +
> +		simplefb_hdmi: framebuffer-hdmi {
> +			compatible =3D "allwinner,simple-framebuffer",
> +				     "simple-framebuffer";
> +			allwinner,pipeline =3D "mixer1-lcd1-hdmi";
> +			clocks =3D <&display_clocks CLK_MIXER1>,
> +				 <&ccu CLK_TCON1>, <&ccu CLK_HDMI>;
> +			status =3D "disabled";
> +		};

This node should be before the lcd node

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--noanhksd45spdaor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsxEV8ACgkQ0rTAlCFN
r3Sg5g/9GijgGQ4CNam22NlFUhkaJ4xYrrXyLO08zT3ZQftHGhlxefjYSSzFoVu1
Rf1aKj0NzawGwq+m7k7G+BMa/sR6nL5+tYDzyACVkvD+HwCZO+TntT3O98HbAJ3d
7EMra8uW4aIUAcZXT6BPn3b+MFqgLjTqkpbLm+HA2MD/lEGievVcR9lFn161Tvzf
DXrcmOpDOf2Z/WwaLi8tVcwZXMY4Du3Dgtaydkez9up2g7rhJR1n/7vDjPcM1Fec
1v9kS7XBDABEvMgkKDYkhAm/wpWr9WMxfTIQoYcL3hdX1WGpaM7F9AEJwzVjHWnl
1Zwj5KEUMJrr86T1XKn/N2fTob97JgoIXEynTKblA7NCBefI2N947mLb8DTciYV9
Pt9Rp3evTcv8F2QgESCGp1oH+3t7vfXcofiaC35a6Zp6qJ6POqLTxELyc8TflK22
xhCeFOrb1FKW9HsdOPA+IvRhQNl751aWhGB+5gZvfcpbXQKmfTQ7PR5Jkja+Ee5l
FgmXUcSA/XYIuB9UEVqI6U5vb6eGL3gzFbGwYkJ40aKCerRfGfTS+CuVgQsF+6g8
NhRLaKs5rkT1U+t++DP5+oYuNfEJRp6xdmnL87od6/1HNfGBnyzNJLo0mBJaAhSU
C1bsrXgAE+MYxu0XDgPFbu0qjWDbvnOqly5ZCYCTAROImw8iTTQ=
=jVZD
-----END PGP SIGNATURE-----

--noanhksd45spdaor--
