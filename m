Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62932C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A920779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeICOkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:40:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57272 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeICOkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:40:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 635E620799; Mon,  3 Sep 2018 12:20:33 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 30E9F203DC;
        Mon,  3 Sep 2018 12:20:23 +0200 (CEST)
Date:   Mon, 3 Sep 2018 12:20:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Philipp Rossak <embed3d@gmail.com>, mark.rutland@arm.com,
        geert+renesas@glider.be, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, linux-sunxi@googlegroups.com,
        clabbe.montjoie@gmail.com, pmeerw@pmeerw.net, lee.jones@linaro.org,
        lars@metafoo.de, quentin.schulz@bootlin.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org, arnd@arndb.de,
        vilhelm.gray@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org,
        arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
        lukas@wunner.de, knaack.h@gmx.de, eugen.hristev@microchip.com,
        jic23@kernel.org
Subject: Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Message-ID: <20180903102022.fkxfkxadkt4vpbmb@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
 <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="572ywfuqjxaaxz76"
Content-Disposition: inline
In-Reply-To: <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--572ywfuqjxaaxz76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 05:51:41PM +0800, Icenowy Zheng wrote:
> Personally I suggest to leave out all SID or calibration related
> patches here.
>=20
> Currently we seems to be wrongly converting SID to big endian, however,
> the orgnization of the THS calibration data on H6 shows that it's
> surely little endian:
>=20
> It consists a temperature value in 1/10 celsuis as unit, and some
> thermal register readout values, which are the values read out at the
> given temperature, and every value here (the temperature and the
> readout) are all half word length.
>=20
> Let the temperature value be AABB, the two readout values be XXYY and
> ZZWW, the oragnization is:
> BB AA YY XX WW ZZ ** ** .
>=20
> When converting the SID to big endian, it becomes:
> XX YY AA BB ** ** ZZ WW ,
> which is non-sense, and not able to do sub-word cell addressing.
>=20
> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
> whether it will break compatibility.)

This is exposed to the userspace, so no.

Maxime
>=20

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--572ywfuqjxaaxz76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluNCuUACgkQ0rTAlCFN
r3TJ2w//el4NVxPq4OpMbyzUfcul9GaG/NaAQItiR7kRrUtBBHzdsaOyUtn8TJd1
BWTbQRlOhE81VRZak/RPpOe1r7YTHQQehbuUgbxR7Zeys3Fx3JR+xTjGze5vXCNs
0sBgu13YW1elL8XCHTNbWfZOo8VVC9EzYOviuGPo1zkMa1w72pM58laCzMR5MoOK
JimfZ/+UM/kIbY6mt8U/+0YSMG4S5STYOrScbJ5QdlRmPU3MLVl8LHwqqAYwbbV+
pP7J/B268S/GWa1jY/pDzWV/Gbq0vE+Cv8/iHFP5XesE0ixTzb1aRbC3K2vpawvC
rMFVZCa6j5BS2Mx0NSwbpp9JNEmiuIfbBeu+7Eiz/6dXNGsaTFhN7vOUcKEg2TAo
OsGgxFR0kgHwLOtTggBWGKEtYK6umCkKdMP+yy2RQWT6GYK91fx5e93jfQR9Vhvr
0pvmSPuXcdXHJtTyasq/tF7ZPD7rjLWkFCFQSzXDDmG9qczJEJZZ1k0oLfPi78u6
ZiRaaN5qLsp6HlnLGODI5jewkDZ9JwlzoPasrSJHlChya5KB/QbAN6fhwkLJcRJe
ZEvqJxezEi+apkfMpWGhdI9D0ODGuNBuvQv+NqPLU/seQw1XJJvi0Zy2Bw9K6vnd
PHRBUt/aPeR/Vr3ps4/93z3VJFcQws3dQYyxVj3J9FYy5jo4oYg=
=IEeZ
-----END PGP SIGNATURE-----

--572ywfuqjxaaxz76--
