Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B9C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB53206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB53206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeI3W4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:56:17 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38667 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeI3W4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:56:17 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42NW0S6N9dz1qvNV;
        Sun, 30 Sep 2018 18:22:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42NW0S4c7Lz1qqkM;
        Sun, 30 Sep 2018 18:22:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FmLixtt2Gq_R; Sun, 30 Sep 2018 18:22:30 +0200 (CEST)
X-Auth-Info: oQOn4N+pI/s4EhRNswDvBDS6EvxRroYxSoP0JsSdd70=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 30 Sep 2018 18:22:30 +0200 (CEST)
Date:   Sun, 30 Sep 2018 18:22:20 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Fabio Estevam <festevam@gmail.com>, prabhakar.kushwaha@nxp.com,
        han.xu@nxp.com, Mark Rutland <mark.rutland@arm.com>,
        yogeshnarayan.gaur@nxp.com, richard@nod.at,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-spi@vger.kernel.org, albert.aribaud@3adev.fr,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>, david.wolfe@nxp.com,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: [RFC/RFT PATCH v1 0/9] mtd: fsl: quadspi: Fixes for
 fsl-quadspi.c driver (vybrid HW)
Message-ID: <20180930182220.30d0ccf3@jawa>
In-Reply-To: <20180930073927.001c16d2@bbrezillon>
References: <20180926220739.620-1-lukma@denx.de>
        <20180929000359.34fe18ae@bbrezillon>
        <20180929230240.1c8d844d@jawa>
        <20180930073927.001c16d2@bbrezillon>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gQ0Z.Lv4IK3bPj90mSrGgqu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gQ0Z.Lv4IK3bPj90mSrGgqu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> Hi Lukasz,
>=20
> On Sat, 29 Sep 2018 23:02:40 +0200
> Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > > Talking about that, can you try to port your fixes on top of
> > > Frieder's patchset? I'm pretty sure some bug fixes are irrelevant
> > > after the migration to spi-mem (patch 1, 3, 4, 5, 6, 7 and 9
> > > should be dropped I think).   =20
> >=20
> > The problem is that Frieder's patch is using IP command mode for
> > transfers smaller than AHB RX fifo size.
> > This according to the comment in the current driver is broken in HW
> > for Vybrid (so this is a regression). =20
>=20
> Why not fixing that in the new driver?

I did not say that I will not fix it in the new driver :-)

The problem is that I'm waiting for NXP's community reply - to get some
more info regarding the bug.

>=20
> >=20
> > I'm also wondering if other users of vf610 based boards experience
> > issues with QSPI? =20
>=20
> Are you sure the 4 I/O lines are wired on your design?=20

This is a somewhat special case.

There are two identical SPI-NOR memories: one with QUAD lines connected
and second only for DUAL due to HW design decision.

> Anyway, if it's
> a bug that only hurts vf610, you should mask quad modes in ->hwcaps
> (or patch fsl_qspi_supports_op() in the new driver), not change the
> SPI NOR definition.

Yes, this was also pointed out by Cyrille - and yes, I do agree that I
shouldn't mask it.

>=20
> >=20
> > In my case, after running the UBI/UBIFS tests (on the original and
> > new driver without those "fixes") I cannot mount the volume after
> > creation as the header is wrongly read. =20
>=20
> I'm not denying this fact, I'm just saying, now that you've found
> where the issue comes from, you can also port the fix to the new
> driver.

Yes, as the old driver is now in a "good enough" shape (though I don't
know the exact HW bug reason) - the code can be ported to the new
driver.

>=20
> Regards,
>=20
> Boris
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/gQ0Z.Lv4IK3bPj90mSrGgqu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluw+D0ACgkQAR8vZIA0
zr146Af/dhtgZ/5O+ftarCkoh9hIJfxK8FtCQq5b7Hkn1jTcXEMBLGfANjyJdI1Y
Xttr/TthJg3CiP39pT5gzwUKb8d+UtAEqsDY1NXCob13frFBTQp/n6o5vLgBaZxr
byMwlDs/BaITsof0O6c2yq6j3OHVEWg28wXd8usK4R9V3N6w9YZmAVPPpvsDGfmY
egeGAeQc3TjZItMdNLme8sCz4hmXJaXsiHoNY2Gf/nG4XRe+y2oO2nG01dwpjxae
xGjwngWsgizShYrlWUAU7gMxkcH3PZ8F+68esDjFzzvXHNAeGSpqzxcIISw8uYtU
chcHEIFwQY5J8yd3BN//yobEPW0hfA==
=jIv+
-----END PGP SIGNATURE-----

--Sig_/gQ0Z.Lv4IK3bPj90mSrGgqu--
