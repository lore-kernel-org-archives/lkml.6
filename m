Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D2ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B187B20854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B187B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeKDVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:05:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39547 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeKDVFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:05:09 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 328CA80960; Sun,  4 Nov 2018 12:50:22 +0100 (CET)
Date:   Sun, 4 Nov 2018 12:50:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/8] Input: olpc_apsp: depend on CONFIG_OF
Message-ID: <20181104115023.GJ23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-6-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:25:01, Lubomir Rintel wrote:
> This is a device-tree enabled driver. Moreover CONFIG_OLPC is specific
> to the x86 platform code, while the driver is for an ARM-based laptop.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index d90d9f1098ff..a4f70021b53e 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -254,7 +254,7 @@ config SERIO_APBPS2
> =20
>  config SERIO_OLPC_APSP
>  	tristate "OLPC AP-SP input support"
> -	depends on OLPC || COMPILE_TEST
> +	depends on OF

I'd keep "|| COMPILE_TEST".

Otherwise

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve3P8ACgkQMOfwapXb+vKT0gCfT8Pch4W0XPavm2ciaCnum+bE
oT4AmQFBtD02YCRcdIkkO7KPoqPrgKNb
=NMGF
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
