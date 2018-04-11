Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDKLnn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:43:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59555 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:43:42 -0400
Date: Wed, 11 Apr 2018 13:43:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>, Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: simultaneous voice/data works (was Re: call/normal switch was
 Re: omap4-droid4: voice call support was)
Message-ID: <20180411114339.GA6021@amd>
References: <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com>
 <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
 <20180407081000.GB7818@amd>
 <20180407122233.GA11302@amd>
 <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
 <20180409140847.GP5700@atomide.com>
 <20180410105840.GA13697@amd>
 <20180410135029.GS5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20180410135029.GS5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-10 06:50:29, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180410 11:00]:
> > On Mon 2018-04-09 07:08:47, Tony Lindgren wrote:
> > > * Dan Williams <dcbw@redhat.com> [180408 02:46]:
> > > > On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
> > > > > I tried --location-enable-gps-unmanaged , but that did not work f=
or
> > > > > me.
> > > >=20
> > > > That requires a TTY that would spit out the GPS data; in this mode =
MM
> > > > only sends the start/stop commands, and what comes out the GPS TTY =
is
> > > > undefined (at least by MM).
> > > >=20
> > > > So unless you know that one of the 6600's TTYs does GPS and in what
> > > > format it does GPS, then no.
> > >=20
> > > There should be a NMEA port within the unknown port range ttyUSB[123].
> > >=20
> > > Is there some easy way to enable --location-enable-gps-unmanaged for
> > > testing so I can check if GPS gets enabled for one of the ports?
> >=20
> > This should be userful for testing:
> >=20
> > Just pass --pds-start-gps and you should get NMEA on stdout.
>=20
> Hmm maybe also try to check if enabling the GPS this way starts
> printing something out of /dev/ttyUSB[123]?

No, I did not find anything there :-(.

This combination seems to give me working gps:

sudo src/qmicli/qmicli -d /dev/cdc-wdm0 --pds-start-gps | nc -u 127.0.0.1 5=
000

/usr/sbin/gpsd -ND 4 udp://127.0.0.1:5000

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrN9OsACgkQMOfwapXb+vKVswCfaomrMvbr2rwKZnH0R0P8kRXZ
w+EAn268Psi+B2KKTywMG5Cr0g5LGewI
=wJyE
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
