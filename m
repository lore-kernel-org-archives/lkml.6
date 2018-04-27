Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757963AbeD0KUj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:20:39 -0400
Received: from sauhun.de ([88.99.104.3]:48152 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757810AbeD0KUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:20:36 -0400
Date: Fri, 27 Apr 2018 12:20:33 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 20/61] input: keyboard: simplify getting .drvdata
Message-ID: <20180427102033.msrr5sourxrtypg7@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
 <20180426191947.GC162443@dtor-ws>
 <20180426200401.lvqiy4gnchkwr4qw@ninjato>
 <20180426212327.GB210716@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ro7fbsqyzfs5cg2h"
Content-Disposition: inline
In-Reply-To: <20180426212327.GB210716@dtor-ws>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ro7fbsqyzfs5cg2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> > Isn't it actually the other way around? platform_get_drvdata() is a
> > convenience function to access driver_data which is embedded in struct
> > device?
>=20
> I guess it depends on how you read it. I always considered it separate
> because none (?) of the bus implementation assert this in comments to
> XXX_get_drvdata().

Well, even in the case somebody will implement a custom driver_data for
platform_devices, this person will need to convert all current users to
'dev_get_drvdata(&pdev->dev);' first in order to avoid regressions, I'd
think. This is what my patch does right now (but merely for overhead
reasons). Or?

> > > in the future, so I'd prefer keep using the proper accessors for the
> > > objects we are dealing with.
> >=20
> > Exactly. I'd just argue, the object we are dealing with, declared in the
> > PM functions, is a struct device.
>=20
> No, the driver does not create a generic device, it actually creates a
> platform device, or i2c client, or spi, or something else. The fact that

True.

> suspend and resume routines have generic device as their argument has
> more to do with the language limitation rather than reflection of true
> type of the objects we are dealing with.

Ok, can be argued. I'd personally still go for the gain, but I won't
push harder than this mail.

Regards,

   Wolfram


--ro7fbsqyzfs5cg2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlri+W0ACgkQFA3kzBSg
KbaA8RAAkAc1/BldRxZwTtZe+wdvyAJeqmAvEr0Q89w3mD9zRSGiUy6fyUziggtI
xxWfsOlzCQFr2d1Q8oqiyrqC3S5VrvmNinOfdRVcFbkAwlwoprNlnLT9EIYJBQND
09oEqYv+SfaZMOGNjSBwL6udRJtN9UHxs+/s5xtox9xz0qLUla/iqn+mJ24FTQ6K
qQ4GabIU8iRCUfIUaYozZisNJD/+6ikCVGBPQu/0kqYgSrFmdZupXHvVZ5IeAq7U
cU+sBsz0SGEniPV6Q/GevnpJpfz4wrnU3l6c+kz82iGGoJmJu4Rg1vsj5krlXNx7
KMy/JZQ7lAQmChsSVHgSHw5qtxXKYQmlywDWf8TJeA6ELRdQKa69SjVo5jW4aWTX
Ni73xwSWxZGTueM23JYw33lYzP+OtCE4I6DwnT25skqzT8GHEHL/xMzYrWgiCpXL
TWcIA28A3WW44PPCD2xS9rlSOhWjQIoETUZ1SVOkfxrXfCfGagZAtRc5NLU1MGSa
JszHEFYSzi8pxVraoc+eZRgGtU5fnZrHwicRkNsouXqI/j6J37OUzs8VSnGNTmuS
LRoEOQ5Y4zbw5ChRi13olVYuOmIa9oOnMk++4i/k8wMqjer+dDV9qtaZzs+Q+Tjp
qkZMUdEdW6ggDX+Hzcgb3d5wFIts2aNQb1S8D0aY+MAk5EG9p3k=
=rOVE
-----END PGP SIGNATURE-----

--ro7fbsqyzfs5cg2h--
