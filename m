Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17B22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfBRItg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:49:36 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35063 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:49:35 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F0A84E0009;
        Mon, 18 Feb 2019 08:49:31 +0000 (UTC)
Date:   Mon, 18 Feb 2019 09:49:31 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
Message-ID: <20190218084931.fdut6d4cgwkwvihx@flea>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="scnr26aml4g7phhd"
Content-Disposition: inline
In-Reply-To: <20190217162316.14111-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--scnr26aml4g7phhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> Add support for H5's SID controller.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/nvmem/sunxi_sid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 570a2e354f30..036029e90921 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg =
=3D {
>  	.size =3D 0x100,
>  };
> =20
> +static const struct sunxi_sid_cfg sun50i_h5_cfg =3D {
> +	.value_offset =3D 0x200,
> +	.size =3D 0x100,
> +};

IIRC, there was an endianness issue on the newer SoCs, with the driver
converting the data from big endian to little endian, while it's
actually stored little endian in the SID.

Have you checked the SID content?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--scnr26aml4g7phhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGpxmwAKCRDj7w1vZxhR
xXx7AQDcwq0iKz7NwrOgeLiQJtBdc0cgjMZh9PBcdpG0bCWIBwD7BwtI5UEDPuB5
GNkfU1d6DR0iUKSDPFYUTL3dTKlK0QU=
=Okil
-----END PGP SIGNATURE-----

--scnr26aml4g7phhd--
