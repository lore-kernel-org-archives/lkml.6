Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B506C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC362073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfBFMUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:20:14 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:46131 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:20:13 -0500
X-Greylist: delayed 167939 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 07:20:12 EST
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DFD5C100004;
        Wed,  6 Feb 2019 12:20:09 +0000 (UTC)
Date:   Wed, 6 Feb 2019 13:20:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mmc: sunxi: Filter out unsupported modes declared
 in the device tree
Message-ID: <20190206122008.ykldbk7kcfjfjxtv@flea>
References: <20190205154225.14264-1-wens@csie.org>
 <20190205154225.14264-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6r42epslv3udyodi"
Content-Disposition: inline
In-Reply-To: <20190205154225.14264-3-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6r42epslv3udyodi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:42:24PM +0800, Chen-Yu Tsai wrote:
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
>=20
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
>=20
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
>=20
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6r42epslv3udyodi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQ+AAKCRDj7w1vZxhR
xVkkAP9N0HH9HJ0MV1En3HP7Ygb/UhglPAPAQA32AQ+OgFmxTAD9HB/mP3Wg05ux
a/NdR+KsNS6hOmibmoCOuF4ym3tNWAA=
=zFwy
-----END PGP SIGNATURE-----

--6r42epslv3udyodi--
