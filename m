Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeECVw6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:52:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33486 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECVw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:52:57 -0400
Date: Thu, 3 May 2018 23:52:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, Tomas Hlavacek <tomas.hlavacek@nic.cz>
Subject: Re: led: hw-trigger, global brightness and multi-colored leds
Message-ID: <20180503215255.GA13829@amd>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <20180502212105.GA9869@amd>
 <69651d45-7566-95ad-2a83-53dd76e5680e@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <69651d45-7566-95ad-2a83-53dd76e5680e@kleine-koenig.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > "Native mode" is quite common. We have it for example on Nokia N900
> > here (charger has hw option to automatically control the LED).
>=20
> git grep -i n900 -- drivers/leds doesn't yield any output. Do I miss
> anything?

Try grepping arch/arm/boot/..*.dts :-).

drivers/leds/leds-lp5523.c

But the hardware/software switch is pretty well hidden. In the charger
code, probably. Aha, here:

echo 0 > /sys/class/power_supply/bq24150a-0/stat_pin_enable

That one influences R and G channels of the RGB LED.

> >> Another feature of the LED device is that there is a global brightness
> >> register that influences all LED's brightness (if on) independent of t=
he
> >> operating mode.
> >=20
> > We can't describe that easily.
>=20
> Given that I can give an RGB value (i.e. 3x 8 bit) for the LED, I can
> change brightness per LED. Have to play around a bit.

Ok, so do we need global brightness support at all?

> >> Further the color of each LED can be set to an RGB triplet.
> >=20
> > We normally handle RGB LED as three independend LEDs, like
> > notify::red, notify::green, notify::blue. Again, example is Nokia N900
> > or Motorola Droid 4.
>=20
> I cannot find source code for LEDs on the Droid 4 either.

That would be

arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
motorola,cpcap-led-red

> An ugly property here is that the hardware trigger only operates on all
> three colors at once. Hmm, will think a bit about the way to go.

Fun.

So... it would be nice to treat RGB LED as one LED, not three. I even
made some patches in that direction, but I went to HSV colors and that
did not work well.

Sorry, I should sleep.

Good luck,
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrrhLcACgkQMOfwapXb+vKqkwCdFI5SYTsRvn1vvSSleBlYX/qn
wcQAnj+1pjS+C0pIBcU1Fai9I47yuBQv
=XJeP
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
