Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF093C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ABB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ABB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIFQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:17:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52582 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeIFQRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:17:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5B36020763; Thu,  6 Sep 2018 13:42:42 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 249AC206FF;
        Thu,  6 Sep 2018 13:42:42 +0200 (CEST)
Date:   Thu, 6 Sep 2018 13:42:41 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, lee.jones@linaro.org,
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
Message-ID: <20180906114241.zuesfnxuoovxiig6@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
 <20180906072429.7qjwbbqsjlbskk6v@qschulz>
 <c76e71bc-6bc5-f73c-2c7a-c9315cf2da31@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="md6uljqxnk54hfq3"
Content-Disposition: inline
In-Reply-To: <c76e71bc-6bc5-f73c-2c7a-c9315cf2da31@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--md6uljqxnk54hfq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 01:39:43PM +0200, Philipp Rossak wrote:
> On 06.09.2018 09:24, Quentin Schulz wrote:
> > Hi Philipp,
> >=20
> > On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
> > > Since we have now thermal trotteling enabeled we can now add the full
> > > range of the OPP table.
> > >=20
> > That's not the reason why they were not added.
> >=20
> > Please see commit 2db639d8c1663d7543c9ab5323383d94c8a76c63[1].
> >=20
> > Basically, you only want the OPPs which can work below or at the default
> > voltage of the CPU supply, because the CPU supply is specific to each
> > board.
> >=20
> > If you set your CPU to work at a given frequency and the voltage isn't
> > updated (saying opp-microvolt =3D <x>; in DT isn't enough, you need
> > cpu-supply to be provided and functional), the CPU might just crash.
> >=20
> > Without cpu-supply property, underclocking isn't effective in term of
> > thermal cooling or power saving. Overclocking is very, very, very likely
> > to make the CPU crash.
> >=20
> > It's not a very difficult thing to do to test if a given frequency work
> > well but it needs a specific test environment and it's a lengthy test,
> > you can have a look at those tools here[3] if you like. It's not because
> > it works in a given test case that'll work on the long term under heavy
> > load and constant frequency changes.
> >=20
> > For A83T, I already did it and the outcome is the patch in [1]. Same for
> > A33.
> >=20
> > So, if you want to use these three higher OPPs, you need to define them
> > in your board DTS and add the cpu-supply property. See what's done for
> > the A33 and more specifically the Sinlinx SinA33[2] as an example.
> >=20
> > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D2db639d8c1663d7543c9ab5323383d94c8a76c63
> > [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> > [3]http://linux-sunxi.org/Hardware_Reliability_Tests#CPU
> >=20
> > Quentin
> >=20
>=20
> Hey Quentin,
>=20
> thanks for your feedback!
>=20
> Sounds like we will never be able to run the A83T on its maximum frequency
> in mainline.
>=20
> I will do some testing, during the next weeks/months when I have time.
> With the old Allwinner kernel I was able to run the A83T with its maximum
> frequency without any problems since my board is very good cooled.

You definitely can, but I think Quentin's point was to do it on a
per-board basis, not for all of the A83t boards at once.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--md6uljqxnk54hfq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluRErAACgkQ0rTAlCFN
r3TZzA//XiBFSTS0dBqUPHtWmbDLosqBuvgCYGa3mUin0EddtIsyr1KCbHFn+jxa
cpmy0iF0izqCJEnIr1NGxbLandYh2RrXZy3TZ8TGcfG80MU1/sf/9PS7UU/xgl3Y
lYFNRE2Lpv9Dw+/wcCVIX2dB1dIc6+QcEWtXwUJSo1B4gsnhrvddi65ES7k3jCuG
XLXPxlkCbZMoRNTpV+mbln/AfEa5cwgYJrAakMBP1YnJYKD/v2pvBwEPv31sOKOO
Btd+JueAx3Wz6+hAVPtM/T+HAd3K/aKm++ROWSk2qkSwQVArRxm0mRE7VKIWbioG
vFLSFVtJRxEjn0MAG/ke5ZGKfg8bazcJ9klOlAmgBOAyHOmShvAruRgWoQpnUn5M
LDlDgDQMa6TNCRDbuTu0ZdEnUpSE0ACoXfen8y2NFf/ULAiANxUsfG2nfd2yeVCi
J9fbyxN057cPLkuhdsGeneT/NE3ZQxdC9ZBTCEovipTyKJQpTa6jH7+rO3nZKyV0
30azdbgv/YzX1KhyRgIbvM6S+o36rFbML6OW8yNdP7jhvQKbVbrKHq/TZUb4cQIU
18rynQwDZ6ALMPcQg0fCQr1/30BEuntCNTKXPnmjrClfKEJyGKoYtislWtkTkxPA
EknbONrnXQ27iB25bueLQDQw110yLvyaOfC73f+oZj3k4/9SyHM=
=OvqY
-----END PGP SIGNATURE-----

--md6uljqxnk54hfq3--
