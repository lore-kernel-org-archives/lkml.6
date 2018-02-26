Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeBZNFn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:05:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49405 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbeBZNFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:05:41 -0500
Date: Mon, 26 Feb 2018 14:05:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Keep returning EPROBE_DEFER when we should
Message-ID: <20180226130529.ljgnerrz72wyy6mm@flea.lan>
References: <20180221081100.17662-1-maxime.ripard@bootlin.com>
 <CACRpkdYkT7TJrhyQoJr=ZK7w8+KY=_fgjrJeaZCsLHA_6WbZbg@mail.gmail.com>
 <20180221091623.4accxa2qglmo3scl@flea.lan>
 <CACRpkdb1=H-KqZyB50k9gUSUJXtGqeYA8w05Q_P8Jod-2wmWpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ayq5bpsw2tdwuotn"
Content-Disposition: inline
In-Reply-To: <CACRpkdb1=H-KqZyB50k9gUSUJXtGqeYA8w05Q_P8Jod-2wmWpg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ayq5bpsw2tdwuotn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 11:24:35AM +0100, Linus Walleij wrote:
> On Wed, Feb 21, 2018 at 10:16 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Wed, Feb 21, 2018 at 09:17:15AM +0100, Linus Walleij wrote:
> >> On Wed, Feb 21, 2018 at 9:11 AM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >>
> > This is slightly embarrassing, but that patch doesn't actually fix
> > anything. I tried to be smart and rework it to look nicer, and
> > obviously failed.
> >
> > Can you squash
> > http://code.bulix.org/z1vkt1-286673
> >
> > in the commit?
>=20
> This site is down.

Sorry :/

> Can you send a new version of the patch or just reply with the
> change inline here?

Here it is:

---------8<----------------
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index c92847ff5d0a..ae70f679459c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -241,8 +241,6 @@ struct gpio_desc *of_find_gpio(struct device *dev, cons=
t char *con_id,
=20
                desc =3D of_get_named_gpiod_flags(dev->of_node, prop_name, =
idx,
                                                &of_flags);
-               if (!IS_ERR(desc) || (PTR_ERR(desc) !=3D -ENOENT))
-                       break;
=20
                /*
                 * -EPROBE_DEFER in our case means that we found a
@@ -256,6 +254,9 @@ struct gpio_desc *of_find_gpio(struct device *dev, cons=
t char *con_id,
                 */
                if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -EPROBE_DEFER)
                        return desc;
+
+               if (!IS_ERR(desc) || (PTR_ERR(desc) !=3D -ENOENT))
+                       break;
        }
=20
        /* Special handling for SPI GPIOs if used */
----------8<-----------------

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ayq5bpsw2tdwuotn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqUBhgACgkQ0rTAlCFN
r3RmHg//QtBiGBcZm3VElyPxlMMMHfg6bMuBoBBOAp48TY0sfy0yq/8m+IoBPRwP
TM7FPwsTK70JeDAmR1USGUSbTM1sfh2CvHDB58Xzsv25yVyOgHtKz+RxU29ubAyC
CT1OwrGOb9DOTtgd2k8k9+mU7Xsg+dmv5mf/kucmVe6xKZ5un9gAGC/vs103zTwG
+zVCmIRKpnCMEEf4AXpJAsSWLZiRVNLW+ktSCyVPz5rguMFd5pFo9di7FDcoWPIq
qrzMu1juz5HAAdYpsT52yY5LETdJmerUFffyQsnvC7/2rgxSsQ0XDaxxhbF2VmQA
HRYz0Mz6BiHToxGlxpm+3C+9o4URJ6kH5nhoVNbEUTKun0lwyig6dpyP6uWWcI0S
kI/qMNuJyyDgv39+MeBjRvrOISXH20yqcyvGKQfesz2z53Ymgiz3Cr7L0HVU5jjN
zyhJtQkauO/cocqsn5FU4CUgdQEYAmobXZ8lpoGzGGZ6/zqgnPD/UZDZf7EDQJFf
SmyTMdUnNsRR3SKALsDS4pJJ78lcHTiUQ5ni+aLjWnelVIXIEOaIWfwfL3oArh4n
6Cwnyvy0kL20Q6SuTnV+tqGJrH0ILWXsGiYOWFY4iApFH3tlxKzeX8Cpmc/KB1cD
Cj54zv6PECi3kd1lOPlNjTJk/77JQ6L2gXnNg4wsRbePOc8hEvk=
=OyxW
-----END PGP SIGNATURE-----

--ayq5bpsw2tdwuotn--
