Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59016C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37052075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37052075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIFQlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:41:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53891 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:41:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0376222B08; Thu,  6 Sep 2018 14:06:30 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 737DB22B01;
        Thu,  6 Sep 2018 14:06:19 +0200 (CEST)
Date:   Thu, 6 Sep 2018 14:06:17 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and
 CPUfreq
Message-ID: <20180906120617.gp6yswusnbgsm2eg@qschulz>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
 <20180906072429.7qjwbbqsjlbskk6v@qschulz>
 <c76e71bc-6bc5-f73c-2c7a-c9315cf2da31@gmail.com>
 <20180906114241.zuesfnxuoovxiig6@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2viiwc2ql2s45nb"
Content-Disposition: inline
In-Reply-To: <20180906114241.zuesfnxuoovxiig6@flea>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a2viiwc2ql2s45nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime, Philipp,

On Thu, Sep 06, 2018 at 01:42:41PM +0200, Maxime Ripard wrote:
> On Thu, Sep 06, 2018 at 01:39:43PM +0200, Philipp Rossak wrote:
> > On 06.09.2018 09:24, Quentin Schulz wrote:
> > > Hi Philipp,
> > >=20
> > > On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
> > > > Since we have now thermal trotteling enabeled we can now add the fu=
ll
> > > > range of the OPP table.
> > > >=20
> > > That's not the reason why they were not added.
> > >=20
> > > Please see commit 2db639d8c1663d7543c9ab5323383d94c8a76c63[1].
> > >=20
> > > Basically, you only want the OPPs which can work below or at the defa=
ult
> > > voltage of the CPU supply, because the CPU supply is specific to each
> > > board.
> > >=20
> > > If you set your CPU to work at a given frequency and the voltage isn't
> > > updated (saying opp-microvolt =3D <x>; in DT isn't enough, you need
> > > cpu-supply to be provided and functional), the CPU might just crash.
> > >=20
> > > Without cpu-supply property, underclocking isn't effective in term of
> > > thermal cooling or power saving. Overclocking is very, very, very lik=
ely
> > > to make the CPU crash.
> > >=20
> > > It's not a very difficult thing to do to test if a given frequency wo=
rk
> > > well but it needs a specific test environment and it's a lengthy test,
> > > you can have a look at those tools here[3] if you like. It's not beca=
use
> > > it works in a given test case that'll work on the long term under hea=
vy
> > > load and constant frequency changes.
> > >=20
> > > For A83T, I already did it and the outcome is the patch in [1]. Same =
for
> > > A33.
> > >=20
> > > So, if you want to use these three higher OPPs, you need to define th=
em
> > > in your board DTS and add the cpu-supply property. See what's done for
> > > the A33 and more specifically the Sinlinx SinA33[2] as an example.
> > >=20
> > > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3D2db639d8c1663d7543c9ab5323383d94c8a76c63
> > > [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> > > [3]http://linux-sunxi.org/Hardware_Reliability_Tests#CPU
> > >=20
> > > Quentin
> > >=20
> >=20
> > Hey Quentin,
> >=20
> > thanks for your feedback!
> >=20
> > Sounds like we will never be able to run the A83T on its maximum freque=
ncy
> > in mainline.
> >=20
> > I will do some testing, during the next weeks/months when I have time.
> > With the old Allwinner kernel I was able to run the A83T with its maxim=
um
> > frequency without any problems since my board is very good cooled.
>=20
> You definitely can, but I think Quentin's point was to do it on a
> per-board basis, not for all of the A83t boards at once.
>=20

Yes, exactly. That's what we did for the Sinlinx SinA33. Just take
inspiration from it.

You can run the CPU at max frequency with the old Allwinner kernel
because it most likely updates the CPU voltage. Let's say overheating is
not an issue, you still need to have a way to overclock AND overvolt to
the values in the OPP you're targetting. Your CPU won't be stable with
just overclocking without overvolting it, trust me, I've been there.

It can even be possible that the Allwinner BSP is only stable in your
use case.

The CPU voltage is specific to every board (cpu-supply property). So we
do not declare the CPU frequencies that require overvolting since we
cannot be sure a board will define the cpu-supply property and thus, be
able to overvolt the CPU.

So, though thermal throttling is an important feature because
overheating the CPU too much will shut it down on the hardware level
(among other consequences), it does not make the higher OPPs magically
work without a valid and working cpu-supply.

The link I gave you is an important piece of software to test the
stability of a system under heavy load and a lot of frequency changes.
It's important to know that because it works for you in your use case
doesn't make it work in any use case. Testing with these pieces of
software helps to cover more hardcore use cases but isn't perfect of
course. That's a start though.

Quentin

--a2viiwc2ql2s45nb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluRGDkACgkQhLiadT7g
8aMnORAApDZcH+3ZY9PD7YAmeQ36va67+W1yL0BemFB39N9dWe8XF3SmdWAvv/uA
fZIcFDvVHTlaSAqHBM2QIPooH17198fw7NmOepGdQvdi/oHS3fvzRnbsVjBz4g2d
8Z57jHmliSDkOOICuuY5ZIxSvJ7SvRjoDikWRRAyMSu/SNHvjY5BgVbOGpI4gbL6
KNz/nO1ttcMqJ9FzWR9A4HOBOuZ3/iQEqBl71G2Vm0nSUvGk1HmJepdDSWOZ+asq
D2zsPPZjVMta8OQD63AHuGoYQ0QGzWb9aXp/lSjL12I95q9qwPHyXOkYZZPyYg9N
H3unsasX3er/BaVqYau9p28xdjWXCNUxkom89c+HUlziD0XAvoVG/duab6iW0pBw
1MLacnEC7TBO14JxqAzdJStcNq/A5iMPk47RKkiWd5n9FAXNJDaS4CRQToZhsJ0A
xhXj93edPze7x5L+HOyCCjMFEEpkTmAzySPmcPqL5++WvyyLIu/L0GMSi68vbzr4
30GTV28WMPGt1r5iVB9/acCcXugYBvA8QveYBuofwCOqXH5tJyjhFTFFGlGeTLV4
gJBLORNPoMsiqw+17R3+X++u/KeY0KAqf1jq7k+YWCBucU4MRyj/DKK0i4jZEDhC
dtuUv1opdO5+j6MSohi0AZ3cOMr37NCiM0oSKh9e+A1igDZCwHk=
=YQbm
-----END PGP SIGNATURE-----

--a2viiwc2ql2s45nb--
