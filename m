Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9538C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C67A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C67A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeIFQ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:26:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52912 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeIFQ0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:26:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EDCE220763; Thu,  6 Sep 2018 13:51:15 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id BDB74206FF;
        Thu,  6 Sep 2018 13:51:15 +0200 (CEST)
Date:   Thu, 6 Sep 2018 13:51:15 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     Emmanuel Vadot <manu@bidouilliste.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
Message-ID: <20180906115114.inc6dhqhy47obo25@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rljnkw73rbwcnsnn"
Content-Disposition: inline
In-Reply-To: <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rljnkw73rbwcnsnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
> On 04.09.2018 18:46, Emmanuel Vadot wrote:
> > > +			/* Data cells */
> > > +			thermal_calibration: calib@234 {
> > > +				reg =3D <0x234 0x8>;
> > > +			};
> >   You are declaring 8 bytes of calibration data but to my knowledge it's
> > only 2 bytes per sensor, so 2 bytes for H3.
> >   Am I missing something ?
> >=20
> >   Thanks,
>=20
> Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes for
> H3, but the thermal calibration data field is on all chips 64 bit wide - =
so
> 8 bytes. So I'm reading here the complete calibration data field.

Having one cell per channel would make more sense I guess.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rljnkw73rbwcnsnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluRFLIACgkQ0rTAlCFN
r3SK7A/9HHs8riJMWJuEK4lOkAN25L+2cl05aTvCJpFx7qjiEPX60y/87Yw01MSR
Qw7phAtGmtek3ZKI5xctpXKEHkPCFgR4FTODgToQQAWe51zgz+9Zg9OW1sD/qJe5
7rZahu8SnbX8TdVM3dRjZUSQmKcZOMR0g9yUfk0IhX5FsOun3+pH3D7Ueri69JIy
kQAA6fQiVE94aqI7kxDf50jl+tcKAEbl3qOutONv4khwvk/vWKuLxuDAJ9iz9UDF
qGDqkR8qs/uB5BweD8DgR4iupKKsSKoVg97WDO4NAzFdSqwmGyJpsLklnR/R/fyI
7A16T24O68wVZl47sS0pWh3u0b4LuWX8ARQGJdeQMnGjCePbHi3+Md/9QiCuz6wV
XJGH/+HnzPS/sshVtyZ3lyLShtVmApZG+4XMM1lxVLuuwPJbsx/wqEcrE14lUd3T
jdXUQ6CqmmAGRJDx36v19L30MQ9y1LKsoGU2YyMYTsfFVJo7/Atephi2xjGlYW56
3QgUKQejGaBY8ysnRyZAO9MHrzU30JNQZy+f53NK14RqJ575P+LS13q0vFLU3/L5
ATbNAZXSONVArVCDDmbJnrlSkOZdueYN7Z50XGbJUCcasK/5vkM/VPSxjY4oE8sQ
+A69pLTV5rJx2erMZXtgqtmLajlFxRV7lgmcrclHTf9HNz0SPfA=
=KpkB
-----END PGP SIGNATURE-----

--rljnkw73rbwcnsnn--
