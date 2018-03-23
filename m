Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeCWLGm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:06:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55076 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeCWLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:06:39 -0400
Date: Fri, 23 Mar 2018 12:06:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Message-ID: <20180323110637.GA23810@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20180323103006.alymgb3ywftb4gek@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Any ideas?
> > >=20
> > > You probably did not enable the soundcard driver, that binds against
> > > "audio-graph-card" compatible and connects the codec driver with the
> > > SoC driver: CONFIG_SND_AUDIO_GRAPH_CARD
> >=20
> > Ok, that certainly changed things; I am now getting this:
> >=20
> > Mar 23 08:39:17 devuan kernel: [   11.633605] asoc-audio-graph-card sou=
ndcard: GPIO lookup for
> >  consumer pa
> > Mar 23 08:39:17 devuan kernel: [   11.644958] asoc-audio-graph-card sou=
ndcard: using device tr
> > ee for GPIO lookup
> > Mar 23 08:39:17 devuan kernel: [   11.656677] of_get_named_gpiod_flags:=
 can't parse 'pa-gpios'
> >  property of node '/soundcard[0]'
> > Mar 23 08:39:17 devuan kernel: [   11.669738] of_get_named_gpiod_flags:=
 can't parse 'pa-gpio'=20
> > property of node '/soundcard[0]'
> > Mar 23 08:39:17 devuan kernel: [   11.682617] asoc-audio-graph-card sou=
ndcard: using lookup ta
> > bles for GPIO lookup
> > Mar 23 08:39:17 devuan kernel: [   11.694427] asoc-audio-graph-card sou=
ndcard: lookup for GPIO
> >  pa failed
>=20
> That's not an error, but just some debug messages. Consider
> disabling CONFIG_DEBUG_GPIO to get rid of them.
>=20
> > Indeed the dts does not seem to contain any gpios
>=20
> It's optional and does not exist on Droid 4.
>=20
> >         soundcard {
> >                 compatible =3D "audio-graph-card";
> >                 label =3D "Droid 4 Audio";
> >=20
> >                 simple-graph-card,widgets =3D
> >                         "Speaker", "Earpiece",
> >                         "Speaker", "Loudspeaker",
> > 	                "Headphone", "Headphone Jack",
> > 	                "Microphone", "Internal Mic";
> >=20
> >                 simple-graph-card,routing =3D
> > 	                "Earpiece", "EP",
> > 		        "Loudspeaker", "SPKR",
> >                         "Headphone Jack", "HSL",
> >                         "Headphone Jack", "HSR",
> > 	                "MICR", "Internal Mic";
> >=20
> >                 dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
> > 	};
> >=20
> > Any more ideas? :-)
>=20
> Make sure, that the device was not proped properly (cat
> /proc/asound/cards) and post the real error? :)

Unfortunately, that are last messages from asoc-audio-graph-card

Mar 23 08:39:17 devuan kernel: [   11.694427] asoc-audio-graph-card
soundcard: lookup for GPIO pa failed

and no, it is not detected:

root@devuan:/home/user# cat /proc/asound/cards
 0 [H58006000encode]: HDMI_58006000_e - HDMI 58006000.encoder
                       HDMI 58006000.encoder
root@devuan:/home/user#

Hmm. Is it possible that EPROBEDEFFER is playing with me again?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq0370ACgkQMOfwapXb+vJrLACfcDaDljlGXEKaZIN/lqD9YFKT
GjsAnRvlmnPynTbw9v3ypUGOuTAm76nL
=wg8Y
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
