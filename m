Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeDJOFS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:05:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50094 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753118AbeDJOFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:05:16 -0400
Date: Tue, 10 Apr 2018 16:05:04 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180410140504.i7kszskwxuoygt5s@flea>
References: <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
 <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
 <20180409113603.2iexkqvyeqmysp5e@flea>
 <0e2fefa5-b6e7-5e42-cf6e-8fc921f972dd@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b4q666t6sgvco2sh"
Content-Disposition: inline
In-Reply-To: <0e2fefa5-b6e7-5e42-cf6e-8fc921f972dd@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4q666t6sgvco2sh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 02:59:57PM +0300, Sergey Suloev wrote:
> > > But as soon as sun4i SPI driver=A0 is correctly declaring
> > > max_transfer_size then "smart" clients will work well by limiting a
> > > single transfer size to FIFO depth. I tested it with real hardware,
> > > again.
> > This is really not my point. What would prevent you from doing
> > multiple transfers in that case, and filling the FIFO entirely,
> > waiting for it to be done, then resuming until you have sent the right
> > number of bytes?
>
> Because it makes no sense IMHO. I can't see any single point in allowing
> long PIO transfers. Can you find at least one ?

I'm probably going to state the obvious here, but to allow long transfers?

> I think we should reuse as much SPI core code as possible. The SPI
> core can handle an SPI message with multiple transfers, all we need
> is to have max_transfer_size =3D FIFO depth and restrict it in
> transfer_one().

There's not a single call to the max_transfer_size hook in the SPI
core in 4.16, so that seems a bit too optimistic.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--b4q666t6sgvco2sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrMxI8ACgkQ0rTAlCFN
r3SbrQ//TFFVHDCIE9JtIeazfWuz9k4LebEYXhTIiMcUGLUWvJojjRVlmrR14rZA
R9JmR0ytUic7r/v4lBBP/P/JSlY/ljcR8XGNfxYe0GnhOGYYB9ety/xu8jHfJ92W
d6zsgUuhOLkjuP3u7Ox9w7d5Qv0itLkic7n8DMjnwVsqLPt4gQLYp4s6QVZ86cKA
1viXDzJwrM+e2y1/Mhi8/9dtkoyylyTSzU7ILl9jWQPM7ARDgNJlxq4bSl6mhmkz
CBIFZBoXm3RlnHk7THdCypTG8eA3ouJD/Z8X6DxmNOcLIz/7tA/+eGX9IqbnBgwn
nMwMB0jFAU/h8yABmpCzduvDdMO1nJY+EQl93/dLR+YiXAqbZIfZj+eZaTb/A3Bv
/kskvfzYcywAecX30RISteepIQiHWpjDObZ0fhxAym/MiwNGJFKFtKtM6R0bqk88
mHaxo6nRjr8+0RCjw9+coQY1sHmf3pFkLvK60GDmO7eGENlMmIBN1UCowXDI/Uem
YoIiEDFnpnyDz6j3yjhOJYbfKa8xM971Z6RCu2kLcVJ8iVYaA1/bfQHE/WX4EKd9
eEqiDAsXzbekbDsISIoxohzYP+NSN+NRbFcZypzQGICVF+F8S68yx0R4v3ls6lgH
WzxFLGS/norkO1WEsB88+KMocXz1KyIUHFPTDMynO7ErJUAdblk=
=bs5n
-----END PGP SIGNATURE-----

--b4q666t6sgvco2sh--
