Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC1Jgq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:36:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58784 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC1Jgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:36:44 -0400
Date: Wed, 28 Mar 2018 11:36:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180328093641.GA17774@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180328090031.GA17300@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20180328090031.GA17300@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I can talk to the modem and start a call.
> >=20
> > Doing an AT query is the easy part :)
> >=20
> > > Then something like this (untested!) is certainly needed.
> > > Probably more...
> >=20
> > I intentionally left this part out. The CPCAP codec has two DAIs
> > and not 3+. The code you just added is a hack from Motorola. Their
> > driver is full of hacks and it's obvious its author(s) did not
> > fully understand the ASoC APIs.
> >=20
> > My understanding is, that we only need to replace the audio-graph-card
> > driver to something more complex. The VOICE DAI needs to be configured
> > differently based on the use case:
>=20
> Does the voice part work for you? I configured all the mixers to
> voice, and then am using

I tried with 8kHz, 8-bit, too:

user@devuan:/my/tui/rweb$ arecord -D plughw:CARD=3DAudio,DEV=3D1 -t wav
--max-file-time 30 mon.wav
Recording WAVE 'mon.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
arecord: pcm_read:2103: read error: Interrupted system call
user@devuan:/my/tui/rweb$ aplay -D plughw:CARD=3DAudio,DEV=3D1 -t wav
mon.wav
Playing WAVE 'mon.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...

Recording works okay, but playback produces ugly noise (not white this
time). If I copy mon.wav to PC, it playes back in pretty acceptable
quality.

So summary

HIFI DAI works
VOICE DAI recording is ok
VOICE DAI playbacks plays noise.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq7YikACgkQMOfwapXb+vLxNwCdE/Fragqrz7l3vrPSiD4kZkYU
mkgAnjYnKZqJYm5pviMW9kjZfIIfJ++H
=xgf1
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
