Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755959AbeDYR2W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:28:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58440 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755891AbeDYR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:28:20 -0400
Date: Wed, 25 Apr 2018 18:28:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>, ldv-project@linuxtesting.org,
        sil2review@lists.osadl.org
Subject: Re: [PATCH v4] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().
Message-ID: <20180425172816.GI24769@sirena.org.uk>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
 <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
 <20180425155028.GF24769@sirena.org.uk>
 <20180425164904.GA30349@er01809n.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline
In-Reply-To: <20180425164904.GA30349@er01809n.ebgroup.elektrobit.com>
X-Cookie: MS-DOS must die!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 06:49:06PM +0200, Stefan Potyra wrote:

> Additionally, prepare/enable the pll_clk before calling clk_get_rate()
> for the same reason.

I don't see this change in the code:

>  		struct clk *pll_clk =3D devm_clk_get(dev, "pll");
> =20
> -		if (IS_ERR(pll_clk))
> -			return PTR_ERR(pll_clk);
> +		if (IS_ERR(pll_clk)) {
> +			ret =3D PTR_ERR(pll_clk);
> +			goto out_disable_clk;
> +		}
> +
> =20
>  		rate =3D clk_get_rate(pll_clk);
> -		if (!rate)
> -			return -EINVAL;

Did you forget a git add?

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrguq8ACgkQJNaLcl1U
h9AsQQf/eb4QMlqdeZw5IBQeEG+aa+JJHHr3zw0WmnYW9tUnMCZTrUnU8F5kxYlU
mzKhZ7nLND8AxG8cr9mlcCd8P9A4pPsx2ARLh0Ji+yj8LznKUf8qAhiamgFD3k0+
SIMyDteMB9ckbiU8bZWk96QpHg7Kjl2shmth5YCDwugnnjhruBzs9vnjAuLuPuVG
j/7uk9mj5QNDd5P5lpNh4iXm2fK4HMLi/1OIm4uFwEL3TfNte96ahh1yLVZ/1lxn
1HFrJmjYus8NduYAOpEF02sXvzj63n3t83019NOVi3Twsrc5385I0czNeE7J87F+
o30is95xtenYwHjGvoJLfhnSMNI2MQ==
=l/Yu
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
