Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F012214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfAJP0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:26:35 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfAJP0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:26:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 51858209BC; Thu, 10 Jan 2019 16:26:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1FEA5206A6;
        Thu, 10 Jan 2019 16:26:32 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:26:32 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Increase size of regulator array
Message-ID: <20190110152632.hdlo3h4e7yzzjtug@flea>
References: <20190110082633.6321-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kli3jxp2tgsklhtl"
Content-Disposition: inline
In-Reply-To: <20190110082633.6321-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kli3jxp2tgsklhtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 04:26:32PM +0800, Chen-Yu Tsai wrote:
> On the A80, the pin banks go up to PN, which translates to the 14th
> entry in the regulator array. The array is only 12 entries long, which
> causes the sunxi_pmx_{request,free} functions to access beyond the
> array on the A80 and the A31 (which has pin bank PM). While the
> accessed data is still valid allocated data within the same driver
> data structure, it is likely not a pointer.
>=20
> Increase the size of the regulator array from 12 to 14. This is a simple
> fix. While we could have the code take into account the fact that R_PIO
> pin banks start from PL, or maybe even dynamically allocate the array
> based on the last pin of the pin controller, the size reduction probably
> isn't worth the additional code complexity.
>=20
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I definitely overlooked the R_PIO case, sorry. I guess the proper fix
would be the first alternative one you suggested, and we should take
the pin_base into account. There's no need to store twice such a large
array for this case.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kli3jxp2tgsklhtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDdkKAAKCRDj7w1vZxhR
xVZ/AQCpt6hSufv7rqxoHZMaPfZNZtvAXgWIk+QzGqSQcNg/dwEA2m6KUm8jKcn+
y9C35x9106A+jIfECwW6uRGQcTCwhwY=
=vK/T
-----END PGP SIGNATURE-----

--kli3jxp2tgsklhtl--
