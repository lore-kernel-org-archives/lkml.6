Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeDDG2D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:28:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37065 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeDDG2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:28:01 -0400
Date: Wed, 4 Apr 2018 08:27:59 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] spi: sun4i: add DMA transfers support
Message-ID: <20180404062759.6iplyaezcppahrpu@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-7-ssuloev@orpaltech.com>
 <20180403081711.rqsp77mgnuvlnzt5@flea>
 <19d5907c-f081-21ce-1b72-7c0a331eb073@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nhlxsoo76i3tt5tr"
Content-Disposition: inline
In-Reply-To: <19d5907c-f081-21ce-1b72-7c0a331eb073@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhlxsoo76i3tt5tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 04:03:32PM +0300, Sergey Suloev wrote:
> On 04/03/2018 11:17 AM, Maxime Ripard wrote:
> > On Thu, Mar 29, 2018 at 09:59:07PM +0300, Sergey Suloev wrote:
> > > +static int sun4i_spi_dma_setup(struct device *dev,
> > > +			       struct resource *res)
> > > +{
> > > +	struct spi_master *master =3D dev_get_drvdata(dev);
> > > +	struct dma_slave_config dma_sconf;
> > > +	int ret;
> > > +
> > > +	master->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
> > > +	if (IS_ERR(master->dma_tx)) {
> > > +		dev_err(dev, "Unable to acquire DMA TX channel\n");
> > > +		ret =3D PTR_ERR(master->dma_tx);
> > > +		goto out;
> > > +	}
> > > +
> > > +	dma_sconf.direction =3D DMA_MEM_TO_DEV;
> > > +	dma_sconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > +	dma_sconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> > I guess that would depend on the size of the transfer, right?
>
> no
> "this is the width in bytes of the source (RX)register where DMA data sha=
ll
> be read. If the sourceis memory this may be ignored depending on
> architecture."
> AFAIK is should be 1 byte for SPI side and seems to be ignored for memory
> side, but as soon as I don't know what should be correct value for memory
> side I just put 1 there too.

I meant the number of bits per word, sorry. That width would only
apply if you have 8 bits per word, but that seems to always be the
case. So nevermind.

> > > +	dma_sconf.dst_addr =3D res->start + SUN4I_TXDATA_REG;
> > > +	dma_sconf.dst_maxburst =3D 1;
> > > +	dma_sconf.src_maxburst =3D 1;
> >
> > And a burst of 1 seems sub-optimal here.
>
> I did some tests before with 3/4 FIFO size but it didn't work and I got
> stuck with 1 byte.
> It seems like 1 byte is the correct value because in SPI protocol we can
> only send 1 byte in 1 burst.

That's not about the SPI burst, it's about the DMA burst.

> >=20
> > > +	ret =3D sun4i_spi_dma_setup(&pdev->dev, res);
> > > +	if (ret) {
> > > +		if (ret =3D=3D -EPROBE_DEFER) {
> > > +			/* wait for the dma driver to load */
> > > +			goto err_free_master;
> > > +		}
> > > +		dev_warn(&pdev->dev, "DMA transfer not supported\n");
> > Saying why it's not supported would be great.
>
> I can put more info in this log
> but there is already a message printed from sun4_spi_dma_setup() if any
> error occurs

Then you don't need both.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nhlxsoo76i3tt5tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEcG4ACgkQ0rTAlCFN
r3QqkBAAlyZ6TmUCUympCkIuX4YGYN6ZlBabfQvToqyNtS1FmGl/lZi/zFRNQPR/
NfjP1l8mv6gK7p5XrdVGa3WAduYLVwfO90pkB1jdE5UDXkZUTzQfmDPJ3ji+bLl4
JYD7IdyC1W06CgZmTza1o9MQhrVnuBpvSRxERGhcDcntOExOn+O59TI2McVfQu6w
aTpMpvieM78k+jXGGGP3Wln+5lBFvm2ufMgdMRuzkWA7mpWKc5QzOigQxKOqK48l
oly401C58JVi0RusLwifNoN0tjaG+mzooHtNGFhvhY+r5pS2+ilj9pLqOEgmbKho
Zs+WylSKeXL87aaKt1LppRIewFFFgDD44IqhT4gYEyfsDn1JXQNRTmW04dlfrOCx
okHutHExWSH/PcpN9gj2cLADyg8AYu8ZW4LHgoc0SeOMvBGo6B7ZqriKsO59p6t5
d+f/VqQNbKNeC6BFreZtpbd8F4EmNGQkoRIEyJNITCOjCFY5XTe4NaVKk+YlCR1l
mD8S9gs4eg9jZtoE6euSbv/LowHDy5ogY4eig+KFLCN5Vl7RD3vBf5RPb2/H4Fj2
TcK9g8jUpoSGEJWnpfyDR1C7z3pLHPmEPeUPPtLC9x0nLuZP5vykgFa8NxKjbkzH
FyFdmoHqILe4C9BIfSIrzpC0LN+dDauz8Sq0phqcmj7jFsX0BGI=
=whQm
-----END PGP SIGNATURE-----

--nhlxsoo76i3tt5tr--
