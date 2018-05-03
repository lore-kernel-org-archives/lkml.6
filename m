Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeECOqg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:46:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57393 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeECOqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:46:30 -0400
Date: Thu, 3 May 2018 16:46:19 +0200
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
Subject: Re: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls
Message-ID: <20180503144618.oojhvmey44dtg5fa@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-4-dannym@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vpntmtxfbglbi65s"
Content-Disposition: inline
In-Reply-To: <20180502210800.1971-4-dannym@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vpntmtxfbglbi65s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 11:07:55PM +0200, Danny Milosavljevic wrote:
> Since it's now possible to have a DAPM mixer control with multiple channe=
ls,
> use it to cut down the total number of controls.
>=20
> Keep "Left Mixer Left DAC Playback Switch" and "Right Mixer Right DAC Pla=
yback
> Switch" name & layout the same as before for compatibility.
>=20
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 4af286f44a67..b62af407967f 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -715,15 +715,15 @@ static const struct snd_kcontrol_new sun7i_codec_ex=
tra_controls[] =3D {
>  		       sun7i_codec_micin_preamp_gain_scale),
>  };
> =20
> -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] =
=3D {
> -	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> -			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> -};
> -
> -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] =
=3D {
> -	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> -			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
> -	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] =3D {
> +	SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> +			1, 0),
> +	SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_RDACRMIXS,
> +			1, 0),
> +	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
>  };
> =20
> @@ -759,11 +759,11 @@ static const struct snd_soc_dapm_widget sun4i_codec=
_codec_dapm_widgets[] =3D {
> =20
>  	/* Mixers */
>  	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
> -			   sun4i_codec_left_mixer_controls,
> -			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
> +			   sun4i_codec_mixer_controls,
> +			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
>  	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
> -			   sun4i_codec_right_mixer_controls,
> -			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
> +			   sun4i_codec_mixer_controls,
> +			   ARRAY_SIZE(sun4i_codec_mixer_controls)),

Doesn't that mean that the controls will be shared between the right
and left mixers now, which wasn't the case before? And also, wouldn't
the controls be called "Left Mixer Left Mixer Left DAC Playback
Switch" (for the first one) now?

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--vpntmtxfbglbi65s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrrILoACgkQ0rTAlCFN
r3TWvw/+OdojCTMHIDnyXC2gE1Kd8V6SyYMWF7uF0xVOwS3fGk4FS3qZEGJtqEZ/
v/h57ZzyYPiRZDtg9g3RhYuaefne6kC9EIFuUWkC4I2956UTubynKDFFUSufFIyC
7+E6M0BEe9mtThsBhdOg6Tdj8seoMSqO30rihY8fAcLPnnUN3X2Hpjnn8speCG48
4sDX79tEYMYk5Ih6zxeLe3wtu3P/mCWX5cuNKun2peUgjmVKLzatzL8WpxL6bZiJ
nHRT0/uy1Jz6EVgYcZ1aIZEqkC0kgRcXf61veRY9i7FUPmD2qbN4hbV2iQNFaAsd
yb4987dc/pwdEWphwuStfjm6Z4rYdqXpKxwIvGGl2Ho1csjczPPSipBiNbe2h9xQ
8CQgZFmAqIh7vh1cKATvj/3sAFWsuEvLZs88sSau1ip0e/0NnIuF69BU537L0pxk
wAMlx5PkpXfrJTV51p2izkw2dkmiLWDcy2U6eG/WrHYd8EU1CM53QxGpm570Z4DC
X+KBC7l6a+WGgc+OhLMS+g88WOAM81iNLdQCFVzvhbIi7DVitcjzeXyR3RXIHWH8
YMb100EsW0oh1pIkMo86TQYCfMID297S8kU2WZznAoMQpNYnOnG7quJpRUIadKzU
3Byh6cDmcj1bsQqSX0+aVMvAig+FLgY3egOu0iiBNAbWGvYuqZw=
=/x6S
-----END PGP SIGNATURE-----

--vpntmtxfbglbi65s--
