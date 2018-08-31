Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6511C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6720420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6720420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeHaLlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:41:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57015 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeHaLlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:41:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4CA7A20797; Fri, 31 Aug 2018 09:35:01 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1BD9720711;
        Fri, 31 Aug 2018 09:35:01 +0200 (CEST)
Date:   Fri, 31 Aug 2018 09:35:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Message-ID: <20180831073500.zubqpvar4yhjqrge@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gns7kcfnkcvtbpqy"
Content-Disposition: inline
In-Reply-To: <20180830190120.722-10-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gns7kcfnkcvtbpqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> R40 have a sata controller which is the same as A20.
> This patch adds a DT node for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 852c2ccc3268..d6b5820da850 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -550,6 +550,29 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		ahci: sata@1c18000 {
> +			compatible =3D "allwinner,sun8i-r40-ahci";
> +			reg =3D <0x01c18000 0x1000>;
> +			interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> +			resets =3D <&ccu RST_BUS_SATA>;
> +			resets-name =3D "ahci";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +
> +			sata_port: sata-port@0 {
> +				reg =3D <0>;
> +				phys =3D <&sata_phy>;
> +			};
> +		};
> +
> +		sata_phy: sata-phy@1c180c0  {
> +			compatible =3D "allwinner,sun8i-r40-sata-phy";
> +			reg =3D <0x1c180c0 0x200>;

Overlapping devices in the DTS is not ok.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gns7kcfnkcvtbpqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI75kACgkQ0rTAlCFN
r3TVsxAAiRBUS1NUOVgTI7NK7Km9EkXQMTOXplhC38XQIZWTYVzjDFmmJAg2cwud
dY92VUllKtiD5IBDmN9NjBKZ0m1UkSFL51seSmSb9TvcG0uf5ljwp0qgNPbT8GM7
C9IsEnfRhYi1vbESePXUgtgzQYTRbTJgWZfLZFyCMEVqDPhiSAhsOZbmQza+72hP
ktp0FZPG14NDVy9bobPy/0Xlf4aYyO0yIh8Tg3l4/rKRPj9sSpx7CG8UjZkcNs99
UxeBgbBPi+rG+JHKZkI3tFJyTkeYVSJNujrKgvo6BVixZ18XbEWcCGWAhVSqUrPr
5+1hM2dLgKUJJEvCbBPtMvygP2IpQgbqkT/VznBNMZc8nZ6rlvmqMiLC3djWnkne
m3CZNLSpRtE7QwelXzU1ePevS5uxUxLXU+PnVKJDGAqIGJAlKd7XnVaHnCoub++7
IuANBG6aFtLkwM76w8rbFk0ozXmU+vsoQRFNdkJ1fMXbPHYzZq4AoKtzh7SWHRtN
zwoP0rFPZ0a4FZDiOEs8GK3AJgJQCEwbz6mwUMAFMZOtIknXa5Fczva91YvV0xIf
54tVCa0jQjOg8Rr7DjtToXI7yYQlRWx37QNnvavVTlilHoCz8via2mbxHakNZ+wt
ohjhU38zg8UubY9Q1i4oD34R876xa02psxVcEqpTgNwFI1up5Q4=
=k52F
-----END PGP SIGNATURE-----

--gns7kcfnkcvtbpqy--
