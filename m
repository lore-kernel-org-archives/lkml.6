Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbeENOFn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:05:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50158 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753422AbeENOFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:05:41 -0400
Date: Mon, 14 May 2018 16:05:30 +0200
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
Subject: Re: [PATCH v14 2/8] ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2
 Boost Volume
Message-ID: <20180514140530.bnedijfm6hvnpyq4@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-3-dannym@scratchpost.org>
 <20180503143319.4vyh2y5sluatssnv@flea>
 <20180505090513.7e3f02c2@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6p7tq4lwuvkohwp"
Content-Disposition: inline
In-Reply-To: <20180505090513.7e3f02c2@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6p7tq4lwuvkohwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 09:05:13AM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
>=20
> On Thu, 3 May 2018 16:33:19 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > > +struct sun4i_codec_quirks {
> > > +	const struct regmap_config *regmap_config;
> > > +	const struct snd_soc_component_driver *codec;
> > > +	struct snd_soc_card * (*create_card)(struct device *dev);
> > > +	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
> > > +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> > > +	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
> > > +	bool has_reset;
> > > +	const struct snd_kcontrol_new *controls;
> > > +	unsigned int num_controls;
> > > +};
> > > +
> > > +static int sun4i_codec_component_driver_probe(struct snd_soc_compone=
nt *codec)
> > > +{
> > > +	const struct sun4i_codec_quirks *quirks;
> > > +
> > > +	quirks =3D of_device_get_match_data(codec->dev);
> > > +	return snd_soc_add_component_controls(codec,
> > > +					      quirks->controls,
> > > +					      quirks->num_controls); =20
> >=20
> > Why not just extending the sun4i_codec_controls to add it, and create
> > a duplicate one for the A20?
>=20
> Because sun4i_codec_controls has five controls shared between A10 and A20,
> and only two not shared.
>
> And if we extended sun4i_codec_controls, we'd also have to duplicate
> sun4i_codec_codec in order to use sun4i_codec_controls vs. sun7i_codec_co=
ntrols,
> which really contains exactly the same data otherwise.

What I don't really like is that with this patch we have two variants
of the same mechanism: one to add the controls that are mostly shared,
and one to add the controls that are not shared, without any clear
definition of when you should add a new control to one list or the
other.

So far, we had one mechanism, it was easy to understand and to know
what to do about it. And the code was simple as well.

> The quirks here are just for two controls, Mic1 Boost Volume and
> Mic2 Boost Volume, and there not even for the names or anything -
> just for some reason the register moved away.
>=20
> The simplest way was to add it to the quirks - which already have a
> variant selection etc.

Actually, I think that having to do add a new control explicitly to an
A10 and an A20 list is a feature if the two controls set aren't
exactly the same. It makes you explicitly think about what you're
doing, and hopefully double check if it is actually shared or not,
instead of exposing a control because one didn't pay attention that it
was shared.

Chen-Yu, any opinion on this?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--a6p7tq4lwuvkohwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5l6kACgkQ0rTAlCFN
r3SWZw//abRI9OE2fDIEEJpKrOcj8UwhvkXOubxrvM3fDVnqCHHVYP82AZwOdbUW
7lOzZSzz5McmfhthMrLCLgR7c2upUn2youAVUtpEwwehEKM2rV+nM3oR4V6SlXJK
XIjNyLuLHM+NaBuEKclQG+loE+Vmo0/m9IQXwW+H2lUZC17r7sEpbLQp3GhUfFBL
OI69LhvsVYtkHqe0xRixlcLc6oGQOAP3qwJYaKuD2hRPHe7v9BsqBtTagybiK0iq
J4aG74VyWNmM0lA90YBnxOP5DdHGSo8+fdYBgo77dJlH3U4aVv+rWf/gTYEhGGD9
pMP+9s3NRqEfD2MgGuOBUnJjAk8NnYcx6IORUBcxLtkmzwoJKylgtoCPcqgvnWv/
P+KAGvMwDHmWkyfUmhDyHBQhLV4hfXosjyHQ2OWsFlAuHpqFGrZNhOj/VJbMae0W
Wf2YVGEjOTHALg9ReXQY08cdJeG7kS2yy57IIl6/tfgcP918rL9lc4C5PEIRRVNl
xfNiPmklL4dgUQsRFUNMrHqLuHZGX8YNGTnZtb734jes0qoUytB0Q3J+GGHYkVRb
6t38IgiNbS7vPZC/ugIrz8Yemfu/b8ytm+vINnNeTPwq+47xn0gCMVtj4Xu5CnVZ
cSc2T+P21wymZa6bjcwpG7SPCk06Jo2rG4UzeBnTfcm244ck094=
=HsIE
-----END PGP SIGNATURE-----

--a6p7tq4lwuvkohwp--
