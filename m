Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeEOQUv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:20:51 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:2548 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbeEOQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:20:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="asc'?scan'208";a="11554817"
Message-ID: <e2e23aa21b37754b0c84003e6d87c7cb7d5a17fe.camel@microchip.com>
Subject: Re: [PATCH] mtd: spi-nor: add support for Microchip 25LC256
From: Radu Pirea <radu.pirea@microchip.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Zhiqiang.Hou@nxp.com>, <pp@emlix.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>
Date: Tue, 15 May 2018 19:22:06 +0300
In-Reply-To: <20180504204013.254d90cf@bbrezillon>
References: <20180504155404.5285-1-radu.pirea@microchip.com>
         <20180504204013.254d90cf@bbrezillon>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="=-OvGm/Yi9uvs4n9kKBo21"
X-Mailer: Evolution 3.28.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-OvGm/Yi9uvs4n9kKBo21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-05-04 at 20:40 +0200, Boris Brezillon wrote:
> On Fri, 4 May 2018 18:54:04 +0300
> Radu Pirea <radu.pirea@microchip.com> wrote:
>=20
> > Added geometry description for Microchip 25LC256 memory.
>=20
> Same as for the dataflash stuff you posted a few weeks ago: I don't
> think this device belongs in the SPI NOR framework.
Hi Boris,

25lc256 memory is similar with mr25h256, the only difference is the
page size(64 vs 256). Because mr25h256 is already in SPI NOR framework
I added here 25lc256.

> >=20
> > Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> > ---
> >  drivers/mtd/devices/m25p80.c  | 3 +++
> >  drivers/mtd/spi-nor/spi-nor.c | 3 +++
> >  2 files changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/mtd/devices/m25p80.c
> > b/drivers/mtd/devices/m25p80.c
> > index a4e18f6aaa33..1e359d811261 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -372,6 +372,9 @@ static const struct spi_device_id m25p_ids[] =3D
> > {
> >  	{ "mr25h10" },  /*   1 Mib, 40 MHz */
> >  	{ "mr25h40" },  /*   4 Mib, 40 MHz */
> > =20
> > +	/* Microchip */
> > +	{ "25lc256" },
> > +
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(spi, m25p_ids);
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-
> > nor/spi-nor.c
> > index d445a4d3b770..6341c86be647 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1076,6 +1076,9 @@ static const struct flash_info spi_nor_ids[]
> > =3D {
> >  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048,
> > SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
> > SPI_NOR_QUAD_READ) },
> > =20
> > +	/* Microchip */
> > +	{ "25lc256", CAT25_INFO(32 * 1024, 1, 64, 2,
> > SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
> > +
> >  	/* Micron */
> >  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32,
> > SECT_4K | SPI_NOR_QUAD_READ) },
> >  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64,
> > SPI_NOR_QUAD_READ) },
>=20
>=20
--=-OvGm/Yi9uvs4n9kKBo21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEdoCq2H4M7urKoB6rrwWfQ+JrPx0FAlr7CS4ACgkQrwWfQ+Jr
Px2Ymw/6AxvaxE+EqKm1/B1QGobbmvfqqQctVNY2eLOcGtQ6/caB8ElIqrzSCg4v
5XYkz5tIKpKYqurSdExktYIKGO7B1yZI+XvAiRBL7R0Hrhh7QA0DMVGdNarE+1zv
KLfcsGtysYx0byvgQg70lgoI0GHAqQOUIhVwx4mMKS6sH9xl5/pURDuysaMlp68C
Sk1RiOCGmt+XbB5lf5mly8lvIx4kGiYeyDhy/3jezEBGU68eLRp6/U2iQpku6FN+
HHVuQSNW55D6gCZg30wIRx3D7rRw/9nmHi+psCPTiG+hMZcnJic1Pp9kCvp1gsK6
PuN4e2umNuBUrgexH1OJlYpVK1Xtc6v2AZLNmd5sGOq/WCP/2noNeZqW1+pZf+IK
Rp19p+u/rGQbyeGzcPbdI6pfyo6XAZJ68b4SmQKpi3FkNgHVf29YQBMeNSM0Sxw/
xXVoQ8DfjOtf+HrVCkkDTqNP0LgfYWUn23h8U2WeMgF8/2NZjBteXWHgDrqlGJUX
2OD37NGO8U0rshkEbzVXKiyNKscD4HbrgYE0fwPd4vnQFZPn1TWsliD/dl8TwZ4p
DoTsyPGX5s1HYLnRsmk4HBsRrw6+rIUEEFviAnT+pHoo71rMMhZY/ueFzf9PAD5t
p8Eu7UL4bHHgZQYwHnLdQm27w7KAZ9or7DnWr8jC9lr/T9UuJys=
=LBhb
-----END PGP SIGNATURE-----

--=-OvGm/Yi9uvs4n9kKBo21--
