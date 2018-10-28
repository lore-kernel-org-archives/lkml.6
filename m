Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B61C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DBA20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2b7iHMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DBA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJ1XkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ1XkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:40:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F7520831;
        Sun, 28 Oct 2018 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540738520;
        bh=iozTR/dugiwiAktLlfR31FTBeCfgR9pHqCElDjUAK6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e2b7iHMc0Y2/syY0Q14aia+UCnURsKShz3D6LgWj19PIngyOyJ6l/Af986t50AS1Z
         y4jusAO61a2NQSlQhqZGXFU20cmJH0T0sr04WbxrPXu9ARJ52JI8I0UBORwh01s/eP
         MFSPf4DLjWP4DbOacpAUHdUtYP42MuubIPnn5HAs=
Date:   Sun, 28 Oct 2018 14:55:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] staging: iio: ad2s1210: Add device tree support.
Message-ID: <20181028145515.03c03d5b@archlinux>
In-Reply-To: <20181027154903.GA1582@x220.localdomain>
References: <cover.1540489369.git.nishadkamdar@gmail.com>
        <1dc6fdf4626e7cf1ca4933fe3008cb3cd267149b.1540489369.git.nishadkamdar@gmail.com>
        <20181027154903.GA1582@x220.localdomain>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018 17:49:03 +0200
Slawomir Stepien <sst@poczta.fm> wrote:

> Hi
>=20
> On pa=C5=BA 26, 2018 18:55, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID
> > and support for retrieving platform data
> > from device tree. =20
>=20
> So maybe you should make 2 commits?
>=20
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++++-
> >  1 file changed, 42 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/=
iio/resolver/ad2s1210.c
> > index 93c3c70ce62e..9fd5461c4ed0 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > =20
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -669,6 +670,27 @@ static int ad2s1210_setup_gpios(struct ad2s1210_st=
ate *st)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_OF
> > +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device =
*dev)
> > +{
> > +	struct device_node *np =3D dev->of_node;
> > +	struct ad2s1210_platform_data *pdata;
> > +
> > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return NULL;
> > +
> > +	pdata->gpioin =3D of_property_read_bool(np, "adi,gpioin"); =20
>=20
> Why here you are adding "adi", but you are not adding it to the gpios in =
prev
> commit?
>=20
> I've also seen this: https://patchwork.kernel.org/patch/10355839/. Howeve=
r I do
> not understand why adding vendor id to props is needed...
This is not standard ABI, hence we define it as being under the scope of
a particular manufacturer (and hope they use it consistently ;)

So this should have a the prefix, as should the gpios now you mention it.

We have gotten that bit wrong a lot in the past in IIO.  If the gpio is
standard, i.e. reset or similar it doesn't need it, but for very much device
specific gpios like these it should have the prefix
(similar reasons to any other property - different manufacturers might
use the same name for different things).

Jonathan

>=20
> > +
> > +	return pdata;
> > +}
> > +#else
> > +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device =
*dev)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> >  static int ad2s1210_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -682,7 +704,19 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  	st =3D iio_priv(indio_dev);
> > -	st->pdata =3D spi->dev.platform_data;
> > +	if (spi->dev.of_node) {
> > +		st->pdata =3D ad2s1210_parse_dt(&spi->dev);
> > +		if (!st->pdata)
> > +			return -EINVAL;
> > +	} else {
> > +		st->pdata =3D spi->dev.platform_data;
> > +	}
> > +
> > +	if (!st->pdata) {
> > +		dev_err(&spi->dev, "ad2s1210: no platform data supplied\n");
> > +		return -EINVAL;
> > +	}
> > + =20
>=20
> Why not just use only device-tree here? The ad2s1210_platform_data has no=
w only
> one entry... In that case remember to add "depends on OF" in Kconfig.
>=20
> >  	ret =3D ad2s1210_setup_gpios(st);
> >  	if (ret < 0)
> >  		return ret;
> > @@ -724,6 +758,12 @@ static int ad2s1210_remove(struct spi_device *spi)
> >  	return 0;
> >  }
> > =20
> > +static const struct of_device_id ad2s1210_of_match[] =3D {
> > +	{ .compatible =3D "adi,ad2s1210", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
> > +
> >  static const struct spi_device_id ad2s1210_id[] =3D {
> >  	{ "ad2s1210" },
> >  	{}
> > @@ -733,6 +773,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
> >  static struct spi_driver ad2s1210_driver =3D {
> >  	.driver =3D {
> >  		.name =3D DRV_NAME,
> > +		.of_match_table =3D of_match_ptr(ad2s1210_of_match),
> >  	},
> >  	.probe =3D ad2s1210_probe,
> >  	.remove =3D ad2s1210_remove, =20
>=20

