Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F2C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34582082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34582082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeKDVl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:41:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40475 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbeKDVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:41:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8B2BB8072F; Sun,  4 Nov 2018 13:26:34 +0100 (CET)
Date:   Sun, 4 Nov 2018 13:26:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
 bindings
Message-ID: <20181104122636.GX23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b2s+RKoBicgQlNJs"
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-4-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b2s+RKoBicgQlNJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:48, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/=
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> new file mode 100644
> index 000000000000..14385fee65d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> @@ -0,0 +1,24 @@
> +OLPC XO-1.75 Embedded Controller
> +
> +Required properties:
> +- compatible: Should be "olpc,xo1.75-ec".
> +- cmd-gpio: gpio specifier of the CMD pin
> +
> +The embedded controller requires the SPI controller driver to signal rea=
diness
> +to receive a transfer (that is, when TX FIFO contains the response data)=
 by
> +strobing the ACK pin with the ready signal. See the "ready-gpio" propert=
y of the
> +SSP binding as documented in:
> +<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
> +
> +Example:
> +	&ssp3 {
> +		spi-slave;
> +		status =3D "okay";
> +		ready-gpio =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
> +
> +		slave {
> +			compatible =3D "olpc,xo1.75-ec";
> +			spi-cpha;
> +			cmd-gpio =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
> +		};
> +	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--b2s+RKoBicgQlNJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve5XwACgkQMOfwapXb+vJx6QCdGqqNgkjNqR4djwsotKU86vIg
OmMAnjS8aSbF0gsMNHfYnF5fM5wl4Sfv
=CwE1
-----END PGP SIGNATURE-----

--b2s+RKoBicgQlNJs--
