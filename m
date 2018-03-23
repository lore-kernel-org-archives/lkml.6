Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeCWOJv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:09:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59813 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeCWOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:09:50 -0400
Date: Fri, 23 Mar 2018 15:09:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Message-ID: <20180323140947.GA23658@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20180323103006.alymgb3ywftb4gek@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> That's not an error, but just some debug messages. Consider
> disabling CONFIG_DEBUG_GPIO to get rid of them.
>=20
> > Indeed the dts does not seem to contain any gpios
>=20
> It's optional and does not exist on Droid 4.
>=20
> >         soundcard {
=2E..
> > 	};
> >=20
> > Any more ideas? :-)
>=20
> Make sure, that the device was not proped properly (cat
> /proc/asound/cards) and post the real error? :)

Thanks, it is indeed a config problem. When I disabled "unrelated"
options, these got disabled, too:

They can be only selected, and there's nothing to select them in Droid
4 case.
								Pavel

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 2772414..7860b6e 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -4,13 +4,13 @@ config SND_OMAP_SOC
 	select SND_DMAENGINE_PCM
=20
 config SND_OMAP_SOC_DMIC
-	tristate
+	tristate "dmic"
=20
 config SND_OMAP_SOC_MCBSP
-	tristate
+	tristate "mcbsp"
=20
 config SND_OMAP_SOC_MCPDM
-	tristate
+	tristate "mcpdm"
=20
 config SND_OMAP_SOC_HDMI_AUDIO
 	tristate "HDMI audio support for OMAP4+ based SoCs"






--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq1CqsACgkQMOfwapXb+vLSDwCghk3dZdFbR9pu8uaRU01YmIYo
qysAnjtWSfv1hxtyzr9DK8wj7ELMbzi4
=y7SA
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
