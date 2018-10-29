Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0769B21019
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0769B21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ2V4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:56:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34642 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeJ2V4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:56:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EBD1320795; Mon, 29 Oct 2018 14:07:57 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 91BA620714;
        Mon, 29 Oct 2018 14:07:57 +0100 (CET)
Date:   Mon, 29 Oct 2018 14:07:57 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Rob Herring <robh@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Message-ID: <20181029130757.m5okrfvusjl5fu5m@qschulz>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
 <20181024135633.GA342@bogus>
 <20181028154011.04efdecf@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d247wavwh5lwf5wa"
Content-Disposition: inline
In-Reply-To: <20181028154011.04efdecf@archlinux>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d247wavwh5lwf5wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Oct 28, 2018 at 03:40:11PM +0000, Jonathan Cameron wrote:
> On Wed, 24 Oct 2018 08:56:33 -0500
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > > The AXP803 ADC is compatible with AXP813 ADC, but add
> > > specific compatible for it.
> > >=20
> > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >  =20
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> This doesn't seem to have any dependencies with the other patches
> so applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to ignore.  However I am a little curious to know
> why we would add the ID and then not use it (that I can see)?
>=20

Sometimes with Allwinner (and X-Powers), two IPs seem identical until we
discover something that is slightly different. When this happens, we
have to add a compatible to differentiate both. However, we would also
need to change the Device Tree to change the compatible. We would need
to handle the driver behaviour for both Device Trees.

So better anticipate a possible difference so that we don't have to do
some hacks in the driver to handle the device correctly.

As always, Chen-Yu or Maxime may know better so I'm just stating what I
seem to recall.

Quentin

--d247wavwh5lwf5wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvXBiwACgkQhLiadT7g
8aNGohAAqGgoY6iEBWbxr5CUbqS3mda6QQ8HkBcE9EqDT/JpjKiQmRay4qZyJ6pC
u54eWJFzyZOyOmzhVUhP9TTa6yt0+A/tmyOtEUwkH2rU4IPqmwrjJ4PAnk4aFLw5
EsPN25o9Zk60y9bhvclDkw1MHldvPJER6ejygP90zOcwqIc5DjrQfY4aPnImnRZ1
+Cs/zct/IVUScTCOMdqvOT5mff/8OkKRmbw6+Ukr/11RPIm2zly61i0XWoyXslkv
xZhhP+Fs7G3+Zs7cUmxkTNliyJ4wHkHD9p00fSB2DKWB0Xj+SeYziWvLZF/tVV1J
zhcfRy1yVI3gU5Uvf9kd5/ONHQt06yNVtSusEpmV19WKznoJqrn9IFLmXqJC2ayv
8mVHDSRP3ci0k4hVC3kpQF3SkVe/kYpxdzea7u+d+Lv6xg2j9QRqsJN/IL9sY0Ss
JFrQVxrhEolYScRpEoORWU7e5phhrGxK2W9wFO2iHVbH5M3vVZnWa3L4RZf5NiwR
Zadjk2idbdpn3FBMmOi3QKtT7xlsPHauv8vCr2BVEnQFIJMqvNt9Ny0t+ZDLfw5h
/JaVZs1pOcKwzvJvtch1wtbrCPTgzHJLEU2gO7bWWXolBnYx28PYKjgtRgl/RLvM
m0taZizWks/8EqaYlGFYpoUoBYTNnYRivcoJV602PQk1gmzcvYk=
=YFs6
-----END PGP SIGNATURE-----

--d247wavwh5lwf5wa--
