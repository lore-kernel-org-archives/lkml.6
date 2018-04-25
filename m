Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755529AbeDYQNZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:13:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755242AbeDYPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:50:34 -0400
Date: Wed, 25 Apr 2018 16:50:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>, ldv-project@linuxtesting.org,
        sil2review@lists.osadl.org
Subject: Re: [PATCH v3] spi/bcm63xx-hspi: Enable the clock before calling
Message-ID: <20180425155028.GF24769@sirena.org.uk>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
 <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
X-Cookie: MS-DOS must die!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 03:47:30PM +0200, Stefan Potyra wrote:

> +	ret =3D clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate =3D clk_get_rate(clk);
>  	if (!rate) {
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

Isn't this just showing the same problem with not enabling the pll_clk
before getting the rate that you're trying to fix for the main clk?

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgo8MACgkQJNaLcl1U
h9C3mAf9E2wT1z6BVSR3pGjn8VkIqjK8tF4v/fW0OUJoRejY519N0LtV6wkA2ikU
H5eCOr7VNNu345uaFdzIXqKWR4jEyPCWkzHj7baall1kwb9wSA1tfMoFG36FW38G
Kbg2hDQXS/vuIvfBcaNh8XtAftIuKxyWv0W0HnvoKfAJyntdkgCyamRzMgraTNrQ
oHziqpj2Nzkm8wwtk7HnjyvvnfW8ErCT92pTjcoki5MWeVExDYpgqHseEyXYm+QR
Oeg8Gch4CHPQfJcvL3njThXkqFIGHqZl4xddXSi/kM/1xOtTY0ibY48GkmSUjjNX
+4hRjKR2e+ZLj3Jmnbg5tOCwi0IcBw==
=PbX0
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
