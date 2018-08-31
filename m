Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B929EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B6D20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B6D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHaLne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:43:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbeHaLnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:43:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6B8CC20797; Fri, 31 Aug 2018 09:37:25 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3AA1E20711;
        Fri, 31 Aug 2018 09:37:25 +0200 (CEST)
Date:   Fri, 31 Aug 2018 09:37:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 12/13] ARM: dts: sun4i: a10: add sata-port/sata-phy
 nodes
Message-ID: <20180831073724.kuw5tb6yypb4pmkp@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-13-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ke4krpggj66q5zwd"
Content-Disposition: inline
In-Reply-To: <20180830190120.722-13-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ke4krpggj66q5zwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 09:01:19PM +0200, Corentin Labbe wrote:
> This patch convert sun4i-a10 sata to the new binding which use a sata
> phy node.
>=20
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 3d62a8950720..52d5c2e79499 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -556,7 +556,20 @@
>  			reg =3D <0x01c18000 0x1000>;
>  			interrupts =3D <56>;
>  			clocks =3D <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
>  			status =3D "disabled";
> +
> +			sata_port: sata-port@0 {
> +				reg =3D <0>;
> +				phys =3D <&sata_phy>;
> +			};
> +		};
> +
> +		sata_phy: sata_phy@1c180c0 {
> +			compatible =3D "allwinner,sun4i-a10-sata-phy";
> +			reg =3D <0x01c180c0 0x200>;
> +			#phy-cells =3D <0>;
>  		};

This patch, together with the following one, breaks the DT ABI, this
isn't something we can do anymore.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ke4krpggj66q5zwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI8DMACgkQ0rTAlCFN
r3TIvg/7BtOUVbVjDkyGZeyygO0FxtTsxVy8yPZdAJlOsyhgTZlD6u22sAJHx3LG
cda8PxMPVKj0azdN0djklzqX0+1Ri6f5RUYy89p8g9usZO+hSIm6jtc3yTiK9us3
rMYUyE0aTS7MztrlcQDiNMVKGaiC/Rz/Z4h+GT/Uu9FmBK5V39QC0dTPx+VNTC7g
0g5xgZz8fpGU+nRNDzTdOALCgYsoeGz+ZSCYB8bmKK5j6kTCVI7VHJ+lisI/7z1I
eRmzVUzz7nsN2W9hx7znYlOqiixt5sixgXN6k3IpRHZkjFgsQ+rYw7knS8hrtUNL
VbOqAPL6XrjXduGcS5GqVPtVT2K6iFlQGB6Zi/eyjYRoZ0s5mBB2lU29IHF8QRc9
W983jBDpn/rdDGMHacSjGWkYt2pzP6gUCTImwC4FW2OyO+lFU5PAS59jvbQc6j1P
TjtvijQm+uve+vEEQY/PGoUl0JMntOIu68MDYVmPXGfg2pHTipi+Ws4krc9LN4SZ
Iudok+e5XORRuuNtGdkYs5msd9lzc8J+JhPzibvrGLzlOCheeAL91q1HOshH8Vxn
e9TmmvNru90kXYF6JUnpQdjBdApqIS5cVgw6r01exreCBvxm/sPwSTjPwgaCrf8h
cDekAmy5Fm2oGBvuF0QUYZAJQoLdk9olqfoWcGpD6IOaWudnjHQ=
=5wEv
-----END PGP SIGNATURE-----

--ke4krpggj66q5zwd--
