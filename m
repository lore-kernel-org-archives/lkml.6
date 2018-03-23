Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756263AbeCWKaN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:30:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeCWKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:30:10 -0400
Date: Fri, 23 Mar 2018 11:30:06 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Message-ID: <20180323103006.alymgb3ywftb4gek@earth.universe>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wclpdisi2oc4c4yr"
Content-Disposition: inline
In-Reply-To: <20180323100930.GA21644@amd>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wclpdisi2oc4c4yr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 23, 2018 at 11:09:30AM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > # CONFIG_SND_OMAP_SOC_RX51 is not set
> > > # CONFIG_SND_OMAP_SOC_N9 is not set
> > > CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dy
> > > CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dy
> >=20
> > That's not needed (but does not hurt). The Droid 4
> > has no TWL companion chip and uses CPCAP instead.
>=20
> Aha, thanks. I was doing wild experiments to get something that
> boots... I turned them off.
>=20
> > > Any ideas?
> >=20
> > You probably did not enable the soundcard driver, that binds against
> > "audio-graph-card" compatible and connects the codec driver with the
> > SoC driver: CONFIG_SND_AUDIO_GRAPH_CARD
>=20
> Ok, that certainly changed things; I am now getting this:
>=20
> Mar 23 08:39:17 devuan kernel: [   11.633605] asoc-audio-graph-card sound=
card: GPIO lookup for
>  consumer pa
> Mar 23 08:39:17 devuan kernel: [   11.644958] asoc-audio-graph-card sound=
card: using device tr
> ee for GPIO lookup
> Mar 23 08:39:17 devuan kernel: [   11.656677] of_get_named_gpiod_flags: c=
an't parse 'pa-gpios'
>  property of node '/soundcard[0]'
> Mar 23 08:39:17 devuan kernel: [   11.669738] of_get_named_gpiod_flags: c=
an't parse 'pa-gpio'=20
> property of node '/soundcard[0]'
> Mar 23 08:39:17 devuan kernel: [   11.682617] asoc-audio-graph-card sound=
card: using lookup ta
> bles for GPIO lookup
> Mar 23 08:39:17 devuan kernel: [   11.694427] asoc-audio-graph-card sound=
card: lookup for GPIO
>  pa failed

That's not an error, but just some debug messages. Consider
disabling CONFIG_DEBUG_GPIO to get rid of them.

> Indeed the dts does not seem to contain any gpios

It's optional and does not exist on Droid 4.

>         soundcard {
>                 compatible =3D "audio-graph-card";
>                 label =3D "Droid 4 Audio";
>=20
>                 simple-graph-card,widgets =3D
>                         "Speaker", "Earpiece",
>                         "Speaker", "Loudspeaker",
> 	                "Headphone", "Headphone Jack",
> 	                "Microphone", "Internal Mic";
>=20
>                 simple-graph-card,routing =3D
> 	                "Earpiece", "EP",
> 		        "Loudspeaker", "SPKR",
>                         "Headphone Jack", "HSL",
>                         "Headphone Jack", "HSR",
> 	                "MICR", "Internal Mic";
>=20
>                 dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
> 	};
>=20
> Any more ideas? :-)

Make sure, that the device was not proped properly (cat
/proc/asound/cards) and post the real error? :)

-- Sebastian

--wclpdisi2oc4c4yr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq01ysACgkQ2O7X88g7
+prnDg/+LGaVDPLF7MPDA6/WIjavBjoe9IzCdj+IWIhs1Es/EJgMHhTzIqTQIxUl
Shu/8BHjo/9wx7uodRFhnE1xacTnnGWOv1VlwAxNZY7HA/bT1aGOZJDWfej7Zs6M
doRbkr4xDiMT5sxCYFhfT8R7lfzmDTXVimBtY2Y7rq09MrRYyVMnQqYgB/A4lM3t
g64OYpVyNjVGqefShoA3DoT9hQtNHa2qqFck/thpR3x1hVODLA4kbt9rLoaxKh0Y
aS/VmJnlLtnfBlb/M+Zl8fTeB2D2NnSqnaFjf3q7CibU/ybmnB7l1A+oEQKfqFRa
LDOo+KKEvGUoJJ7KpjlsKN8IfqY5sWd5k2VZwMlXJKGNpZ0SYvlqxnfqoMA9CeTN
EA2qSQwrEUo49/KkP5dIvEVuo6LysT2RZP36aEs7aECiu+2LJOOpcNlCHAX8HvRj
6s4youyIof5ahDU9H3rEUAiYyo2LdSiEGTZc4HdsndvZCNUYHpwkSJr3MB7Bk+fn
6/Hr1e5X2zCUaR8KUzL86IdbBn+xeeWgs52C33reVMSgDFmEw/Kg+1ZiyXfaaXMx
cKvwIz4qMu3dwR09LbUZljygb1u3bms49+/hvV+bv23ckoY4H9GA2vbsnGW2shGH
FCSv5ipBZd+7PaCcZvAiZiZu18xc9uVeuxIJLqY74UQJkRQKT28=
=Q0yt
-----END PGP SIGNATURE-----

--wclpdisi2oc4c4yr--
