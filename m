Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeBHVuo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:50:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38540 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBHVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:50:42 -0500
Date: Thu, 8 Feb 2018 22:50:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        craig.mcqueen@innerrange.com.au, Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        Dan Murphy <dmurphy@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Alan Mizrahi <alan@mizrahi.com.ve>,
        Vadim Pasternak <vadimp@mellanox.com>, David Lin <dtwlin@google.com>,
        Joel Stanley <joel@jms.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Willy Tarreau <w@1wt.eu>, Andrew Jeffery <andrew@aj.id.au>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] led: core: Fix race on software blink cancellation
Message-ID: <20180208215041.GA31216@amd>
References: <1516223562-3837-1-git-send-email-jacek.anaszewski@gmail.com>
 <57a6d1f7-c1d0-3871-fed8-84d094dd079f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <57a6d1f7-c1d0-3871-fed8-84d094dd079f@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Any comments? I'd like to have some acks before applying
> this patch.

I can't say I like it.

> > Commit d23a22a74fde ("leds: delay led_set_brightness if stopping soft-b=
link")
> > made a modifications to the LED core allowing for led_set_brightness() =
to be
> > called from hard-irq context when soft blink is being handled in soft-i=
rq.
> >=20
> > Since that time LED core has undergone modifications related to additio=
n of
> > generic support for delegating brightness setting to a workqueue as wel=
l as
> > subsequent fixes for blink setting use cases.
> >=20
> > After that the LED core code became hard to maintain and analyze, espec=
ially
> > due to the imposed hard-irq context compatibility. It also turned out t=
hat
> > in some cases a LED remained off after executing following sequence of =
commands:
> >=20
> > 1. echo timer > trigger
> > 2. echo 0 > brightness
> > 3. echo 100 > brightness
> >=20
> > The reason was LED_BLINK_DISABLE operation delegated to a set_brightnes=
s_work,
> > triggered in 2., which was handled after 3. took effect.

Could we wait for delayed work to be done before setting the
brightness to fix this one?

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp8xjEACgkQMOfwapXb+vKOgwCfTpRWZLkbGGeybizNwEKC23WT
aJMAn0HP9kj0FkByS6tIJwoPMKg2Z+Fs
=KqXd
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
