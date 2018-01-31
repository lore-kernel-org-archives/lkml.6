Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeAaRvM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:51:12 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53057 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbeAaRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:51:10 -0500
Date: Wed, 31 Jan 2018 18:51:06 +0100
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, icenowy@aosc.io, edu.molinas@gmail.com,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 04/16] iio: adc: sun4i-gpadc-iio: rework: sampling
 start/end code readout reg
Message-ID: <20180131175106.agrvwioaruioavqk@qschulz>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-5-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cjyxari4p6sh2f7e"
Content-Disposition: inline
In-Reply-To: <20180128232919.12639-5-embed3d@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cjyxari4p6sh2f7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:07AM +0100, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
>=20
> This commit reworks the code and allows the sampling start/end code and
> the position of value readout register to be altered. Later the start/end
> functions will be used to configure the ths and start/stop the
> sampling.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 44 +++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 03804ff9c006..db57d9fffe48 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -49,6 +49,15 @@ static unsigned int sun6i_gpadc_chan_select(unsigned i=
nt chan)
>  	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>  }
> =20
> +struct sun4i_gpadc_iio;
> +
> +/*
> + * Prototypes for these functions, which enable these functions to be
> + * referenced in gpadc_data structures.
> + */

Comment not needed.

> +static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
> +static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
> +
>  struct gpadc_data {
>  	int		temp_offset;
>  	int		temp_scale;
> @@ -56,6 +65,9 @@ struct gpadc_data {
>  	unsigned int	tp_adc_select;
>  	unsigned int	(*adc_chan_select)(unsigned int chan);
>  	unsigned int	adc_chan_mask;
> +	unsigned int	temp_data;

Does not really have anything to do with sample_start/end. I would have
made a different commit for it.

Otherwise,
Reviewed-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Quentin

--cjyxari4p6sh2f7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJacgIHAAoJEIS4mnU+4PGjPToQAImlXWgWDfZ7cayr5+jvTa8K
TF6aHRbAeVrYWFeuougtp3Tn9+JjevEWjNPk5u7rh1RvHqS2ElyGhbWmU2pGOUU+
SL+off7E4dqyc+QkBbnEResZRlbqEa6LuP/3itxj73DANKhwM9sClh4lamFXh1BW
COBuhVhRfchnytxrP+kbNeYaXk3sxs3mXAu2qjFTOhtT/c7lD35743oaa6wDOjI2
K60F7NTSgn1UfeGtGS1GxNHE74+IEa1HuBkKvpnsoXYZxs8XVe16p76G6o0flax1
e/shccmNP9c1Z8Uul5C70KGXOl6yTwdJcEbhwRuMyy/uUhedKc+2NXZewBvOVfmf
eCG1Jt/o9wBeR2yDyInEwtAuee1629c3texMknhOZpGB/V7fBK0haUWvQll4hFgx
/rWXtYYMwRilaP4nQ4UuQp8KdwV8qQmZp685CZVRWFhhIa5+d04G+SrM4lLpO9sy
YdOCtc3EWZ3E1c/9omu+g06eH8lyO1AjgZsuYbmfDYTusPNnVT+Hwa1j82VRC60E
pxx795vGyoyIDhjb16tNYsO4AqMrZleegTXirjM8imYihJmL/epscrIZPlOgGR8r
JluW3NbTW+UyA/KUe8G8C9YpjMdSjczjJZdmH5Qoae7gSIppNOrm0qLGWDsOatex
nlyBn9LhgFJCvoLT4jF8
=CT+v
-----END PGP SIGNATURE-----

--cjyxari4p6sh2f7e--
