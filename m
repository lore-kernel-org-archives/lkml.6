Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeECOaS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:30:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56798 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeECOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:30:17 -0400
Date: Thu, 3 May 2018 16:30:15 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrea Bondavalli <andrea.bondavalli74@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v14 1/8] ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2,
 Mic Playback Volume
Message-ID: <20180503143015.txtwdbt5icpeq4u5@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-2-dannym@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6kf2zepmquszwjys"
Content-Disposition: inline
In-Reply-To: <20180502210800.1971-2-dannym@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kf2zepmquszwjys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 11:07:53PM +0200, Danny Milosavljevic wrote:
> Add MIC2 Pre-Amplifier, Mic2 input and Mic Playback Volume for Allwinner =
A10
> and Allwinner A20.

That's a general remark for all your commits here, but you should have
more context in your commit logs, for example to define what is the
usual use case for these microphones, if the playback volume applies
to all mic at once, or just a fraction of them, etc.

> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 9a3cb7704810..060a40b45ab0 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -64,6 +64,7 @@
>  #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
>  #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
>  #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
> +#define SUN4I_CODEC_DAC_ACTL_MICG			(20)
>  #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
>  #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
>  #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
> @@ -673,11 +674,16 @@ static const struct snd_kcontrol_new sun4i_codec_pa=
_mute =3D
>  			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
> =20
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450,=
 150,
> +			    0);
> =20
>  static const struct snd_kcontrol_new sun4i_codec_controls[] =3D {
>  	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
>  		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
>  		       sun4i_codec_pa_volume_scale),
> +	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
> +		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
> +		       sun4i_codec_micin_loopback_gain_scale),

This should probably go in a separate patch, it isn't directly related
to the rest of the patch.

Looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6kf2zepmquszwjys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrrHPYACgkQ0rTAlCFN
r3RrMBAAgiTZ5QPpaA3dIWexcylnVSMR3cFb9ADeEZ1OPmbmojywMrDEnS8Ob/W0
QcHUDsU27M77wb3VWASSvEhorX7oZMDym39koxoKxOau4Gq1hpQ8SrSgUXu/FlRq
zWxxH/5LRrmKld1tj3WKJ21J1Y32UUkM4oU9yVcqXlFkeOu9xToLLPjYbi+BawL/
GktRB4Z6jEZI6/Q8mSY6vVqDuVSgkP0rSvgxh5XH1FqI6SR8FcKJhN8VXmn77Jgm
rMyR4mQsgFGNlAN/XQYVBjklZdKiHMBknDB3EYb93BIRySt7DTP6W36Ac/C4vH3G
b/5/5v12zVeOr89FF6c7db46by7qHHEFflFRRxhVpPX15fAd33frn5cxHDBcZdBw
2ltIJfc0VA/CzJxMi7IYkdRnqQAZXNCrzavy//NhR5Y74kF+ZBqzc0zseKgbAy3E
0u9PM7Po7ATbpUpc079SmK27oXkBgV9Bg340S9IaRFl5vojEpILgGsTUNi8+ur7E
rQgYDyb97H9vUehTCAmlux/XfeUuWja2+9Pvg4CASI2SCAR/Jw2wS1wY6QacVVZk
ixmbdfTJ4ZKzV8nNEkfE7ba5WjURfNF+JKKISME87QiObGfUL921mxwhPST6Tqwx
Yx2HYopnCdXcSU5QWrfzPadoxvTEg64gK4TOF5smofAzHhQv86A=
=fymF
-----END PGP SIGNATURE-----

--6kf2zepmquszwjys--
