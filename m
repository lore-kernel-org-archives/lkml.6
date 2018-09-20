Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DDCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0223F21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0223F21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbeITSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:25:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbeITSZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:25:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F467206F6; Thu, 20 Sep 2018 14:41:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D25F020379;
        Thu, 20 Sep 2018 14:41:46 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:41:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: sun8i-h3-nanopi-m1-plus: enable HDMI
 output
Message-ID: <20180920124147.u2f72ygfch5my5sa@flea>
References: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="75hr75ezvexduvs4"
Content-Disposition: inline
In-Reply-To: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75hr75ezvexduvs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Sep 19, 2018 at 08:14:11PM +0000, Corentin Labbe wrote:
> This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 26 +++++++++++++++++++++=
+++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boo=
t/dts/sun8i-h3-nanopi-m1-plus.dts
> index 65cba1050802..88b5ff6b66b6 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> @@ -67,6 +67,21 @@
>  		pinctrl-names =3D "default";
>  		reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>  	};
> +
> +	connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&de {
> +	status =3D "okay";
>  };
> =20
>  &ehci1 {
> @@ -94,6 +109,17 @@
>  	};
>  };
> =20
> +&hdmi {
> +	status =3D "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint =3D <&hdmi_con_in>;
> +	};
> +	status =3D "okay";

you don't need that status property here

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--75hr75ezvexduvs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlujlYoACgkQ0rTAlCFN
r3SmUA/+MtgTOozh5lPJ0yWVdoyxK+ojNkHSZOuPoqMSZJwQBqmCh0CwR0aIqoVE
XXqTDGXYQqCGDu+pfj3ik4KAf2aif/IS6ZgTqi7THKzgOyl8Gt1da2x3B0pxAPPp
yfgVhKa4QSrn1XWPw/E8LFQrGQz75qZgesaOOq6P7aZnXocz3lWF4yiAVA8JHPJR
WPpvqe5/4lTh6TgWKlOo22mlfapZQ2MjW/OisSyGMb1ltzqvHMBE8KepK+Yysu4N
W2DxlssWt0tT5O6uXfrG7lmbsV54cew0K4zVOda8ADzIsyl0gyZYcMzy6XtvGiqb
36bqshRrT8eVJ8sITeF7QCNirPQ7E5r9w7ocY2yEtd/d3WqBTM2fcvKEveMNPqND
TAPvjkRS2AfrvhL5A/OFimuQFW8TkAKQkUzoN+egakQnrAo0aFCnzw5BvOAkE74L
PJIU2cv/sTIIXdaXUCoPvwNSRM4gFrd4qbyeGb5C8367r12aq0yyCskb5we1sk7s
V25Dn0bsgh9axcEPkrZhgXbPTPVFAsdyVgCu4S1P9qQrOdSjvDKXXVt7HGjvvRiC
U3qfsg2PM0+V8nQwmFUPSKOVorcSD3fURcdk9CzyD2H0+j5v3euLW+poLl8cRBlz
FCnFmNFBu/m4YRRP7NxVcTx1cdkwIOOUyAVGOrC+snkMKRvFIZI=
=iJam
-----END PGP SIGNATURE-----

--75hr75ezvexduvs4--
