Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E064D21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfBZQHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:07:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43528 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:07:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AC5FA27FE77
Received: by earth.universe (Postfix, from userid 1000)
        id B913A3C0AE0; Tue, 26 Feb 2019 17:07:18 +0100 (CET)
Date:   Tue, 26 Feb 2019 17:07:18 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: cpcap: Constify omap4_regulators and
 xoom_regulators
Message-ID: <20190226160718.b2lk4cgtf2k2xxoe@earth.universe>
References: <20190226055230.25482-1-axel.lin@ingics.com>
 <20190226055230.25482-2-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="typcbne5zq4ulgal"
Content-Disposition: inline
In-Reply-To: <20190226055230.25482-2-axel.lin@ingics.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--typcbne5zq4ulgal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 26, 2019 at 01:52:30PM +0800, Axel Lin wrote:
> They should never change, make them const.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/regulator/cpcap-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpca=
p-regulator.c
> index c15ced1b5968..e7dab5c4d1d1 100644
> --- a/drivers/regulator/cpcap-regulator.c
> +++ b/drivers/regulator/cpcap-regulator.c
> @@ -334,7 +334,7 @@ static const unsigned int vaudio_val_tbl[] =3D { 0, 2=
775000, };
>   * SW1 to SW4 and SW6 seems to be unused for mapphone. Note that VSIM and
>   * VSIMCARD have a shared resource assignment bit.
>   */
> -static struct cpcap_regulator omap4_regulators[] =3D {
> +static const struct cpcap_regulator omap4_regulators[] =3D {
>  	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
>  		  0, 0, 0, 0, 0),
> @@ -410,7 +410,7 @@ static struct cpcap_regulator omap4_regulators[] =3D {
>  	{ /* sentinel */ },
>  };
> =20
> -static struct cpcap_regulator xoom_regulators[] =3D {
> +static const struct cpcap_regulator xoom_regulators[] =3D {
>  	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
>  		  0, 0, 0, 0, 0),
> --=20
> 2.17.1
>=20

--typcbne5zq4ulgal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlx1ZDYACgkQ2O7X88g7
+pq/dBAAj+7Ja6tKVQdRB4jmkb+uhRrSWMSyDYRWCZ5kr8Aa2IKveXCGuPx/+jKx
oW3eTtXGp9jsUqaalsdYRKTbHEY+aiUe1PMXLzO0fX6mNcaARVGKfeHgFhT8Tsme
b/gLZNiXF0swULp8nvc8BGt+itCxlTN2Zyu4XOVjnbdiO4SpwJWKGIf+2qoCX+qO
iqcHCNKHe/pZT4xnpSAhSqkNyz28M80OtSWwMh8kKYnY5SXJeQKa0cOlFaYzn42V
ZzX+TfTGdrioBw0/BuYiY3v7tLsxpLvVVUlr5UYfTLEhdY0wh4FVeLnNos+Pmo1/
4cNowYf8m8Qxk0bKgJeK3QY3zLeGDoZ+MpgmYUb5KLo+iSSqtTXRgFZC9+JeEAT4
2EESib6Sw540QkkbApupalSBoFPCLQ3+Fo3BhDK9rc7fA5O7pIbhWK0oI835HwOn
DDLnYC0ld3UAsqu0zUToKk8vuFcMMSGmIG02or0nv66qHWKb/XTgdIgHoz1n5kH0
LLjwFT/Q1LUCgfLRyT7g/NASJemyO+F6FMlQ6eb4vmzWFG+l2vERtrwC/tcBhFbN
roxygJv0tcdgZ7/+yuoeOnh+I9PySKZWvhPJ750g8Dn3WNnh8uB2G4Mb8P16xSBe
8lmWZNn+guR1UUhUjht+Itzz1EN+UqbPa2k4H0VMcAYE1GRQd8w=
=haN5
-----END PGP SIGNATURE-----

--typcbne5zq4ulgal--
