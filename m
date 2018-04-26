Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756951AbeDZUEV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:04:21 -0400
Received: from sauhun.de ([88.99.104.3]:44024 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756871AbeDZUEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:04:04 -0400
Date: Thu, 26 Apr 2018 22:04:01 +0200
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
Message-ID: <20180426200401.lvqiy4gnchkwr4qw@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
 <20180426191947.GC162443@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ue3i4hheqebajblj"
Content-Disposition: inline
In-Reply-To: <20180426191947.GC162443@dtor-ws>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ue3i4hheqebajblj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> > We should get drvdata from struct device directly. Going via
> > platform_device is an unneeded step back and forth.
>=20
> I consider the fact that platform device's driver data is accessible via
> device driver data being implementation detail that may or may not change

Isn't it actually the other way around? platform_get_drvdata() is a
convenience function to access driver_data which is embedded in struct
device?

> in the future, so I'd prefer keep using the proper accessors for the
> objects we are dealing with.

Exactly. I'd just argue, the object we are dealing with, declared in the
PM functions, is a struct device.

Thanks for the comment,

   Wolfram


--ue3i4hheqebajblj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlriMK0ACgkQFA3kzBSg
KbaSAQ/+J0GQoNKASnC4aHI+yQlS055LEKJU1zAt79xAcepud8GupA7hLnkfweqc
hPzTjzNvV6KzpHM/kqp2nORkTr9alb0bhWjeSp52J3ihawsHC37FHgZy51yjdabo
HNcrOwmz/NuZqQVUwk+SYwUy+amKbuZSqjG71qqUKV6cOUyp2FLiKyWMZPviVv3R
MpXzvF9upPhqA/z/Ls6I7D3f2Jraun/NWFGnE4IpWhngjrBtCQ7aQZb93YKy5r4/
MxDpQZ5xHdJjy/QLSZJjajnP1J13DcyAspriE8jdhwEi2QSgJB7dz50Q0zYxU9bZ
N8nPnrTrIg2Zapwp8EISovruTrC8rjry4G0Ace5QkWi9JSXnL1DyfHUejyeRpUw5
bP/XW0RPsoDg4jEvVlbEYOZSQGriO+CWK2IxayJq1HVVyKrE3syTZWJYqOVVBX8Z
40y+Hsug2fDtmSlKM8jErlFjXYhdcb9XYVlBSioTPeMRmBVr6O7PInm2nVNZm+wQ
333O2th9GH84FaPxYzTlCFb8p65BqnYJZjCpvUw+eUbNANiFi9B6dRPhDpltCW6G
/3s5yTsRoNbMNxUZlq7GFuHWnGxRM0agaZhYZoSf5Lxd4RTFjxJH0rUJAP59r84E
rJnCM3PzZFzqzQE+y56fyhE1nZRTM+D1l3VtbFDE2tJB1DEAWmE=
=aN5S
-----END PGP SIGNATURE-----

--ue3i4hheqebajblj--
