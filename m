Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeBXVrb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 16:47:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55009 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeBXVqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 16:46:19 -0500
Date: Sat, 24 Feb 2018 22:46:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        afd@ti.com
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
Subject: regression v4.16 on Nokia N900:/dev/input/event6 aka AV Jack support
 disappeared
Message-ID: <20180224214617.GA22619@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In v4.16, AV jack support disappeared.

This one is suspect:

commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057
Author: Andrew F. Davis <afd@ti.com>
Date:   Wed Nov 29 11:13:59 2017 -0600

    ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

    The correct DT property for specifying a GPIO used for reset
        is "reset-gpios", fix this here.

    Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X
    support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

How was it tested? It reverts polarity of reset pin, but
sound/soc/codecs/tlv320aic3x.c treats those as aliases:

 ret =3D of_get_named_gpio(np, "reset-gpios", 0);
 if (ret >=3D 0) {
    aic3x->gpio_reset =3D ret;
 } else {
 ret =3D of_get_named_gpio(np, "gpio-reset", 0);
 if (ret > 0) {
    dev_warn(&i2c->dev, "Using deprecated property \"gpio-r\eset\", please =
update your DT");
    aic3x->gpio_reset =3D ret;


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqR3SkACgkQMOfwapXb+vKArwCfU1sALPGd+Be9AcXOY3fYdiSn
7T4AnidKF80FJYtN+KRr7C4tHi9OsrYB
=tU/B
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
