Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470F5214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfAIVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:34:18 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41595 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfAIVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:34:18 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Zj7V03jNz1qvvq;
        Wed,  9 Jan 2019 22:34:13 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Zj7T409kz1qsnb;
        Wed,  9 Jan 2019 22:34:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EFE5J8Ig04fG; Wed,  9 Jan 2019 22:34:11 +0100 (CET)
X-Auth-Info: /1myA6UqGGngO3gwo96P8GCOTZIi4dwQnhUYvkg0o1A=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  9 Jan 2019 22:34:11 +0100 (CET)
Date:   Wed, 9 Jan 2019 22:34:01 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20190109223401.32a957c3@jawa>
In-Reply-To: <33797571-8456-0b18-087b-71330901f3a8@kontron.de>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
        <20190109155630.3ec34c60@jawa>
        <33797571-8456-0b18-087b-71330901f3a8@kontron.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1tZn.EhU2u0toM7wDxle.ut"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1tZn.EhU2u0toM7wDxle.ut
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

> Hi Lukasz,
>=20
> On 09.01.19 15:56, Lukasz Majewski wrote:
> > Hi Schrempf,
> >  =20
> >> On 08.01.19 10:24, Yogesh Narayan Gaur wrote: =20
> >>> - Add driver for NXP FlexSPI host controller
> >>>
> >>>    FlexSPI is a flexsible SPI host controller [1], Chapter 30 page
> >>> 1475, which supports two SPI channels and up to 4 external
> >>> devices. Each channel supports Single/Dual/Quad/Octal mode data
> >>> transfer (1/2/4/8 bidirectional data lines) i.e. FlexSPI acts as
> >>> an interface to external devices, maximum 4, each with up to 8
> >>> bidirectional data lines.
> >>>
> >>> - Tested this driver with mtd_debug(Erase/Write/Read) utility and
> >>> JFFS2 filesystem mounting and booting on NXP LX2160ARDB[2] and
> >>> LX2160AQDS targets. LX2160ARDB is having two NOR slave device
> >>> connected on single bus A i.e. A0 and A1 (CS0 and CS1).
> >>>    LX2160AQDS is having two NOR slave device connected on separate
> >>> buses one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >>>    Verified this driver on following SPI NOR flashes:
> >>>      Micron, mt35xu512aba, [Read - 1 bit mode]
> >>>      Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> >>>
> >>> [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> >>> [2]
> >>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=
=3D182097
> >>>
> >>> Yogesh Narayan Gaur (5):
> >>>     spi: spi-mem: Add driver for NXP FlexSPI controller
> >>>     dt-bindings: spi: add binding file for NXP FlexSPI controller
> >>>     arm64: dts: lx2160a: add FlexSPI node property
> >>>     arm64: defconfig: enable NXP FlexSPI driver
> >>>     MAINTAINERS: add maintainers for the NXP FlexSPI driver
> >>>
> >>> Changes for v6:
> >>> - Rebase on top of v5.0-rc1. =20
> >>
> >> Your patches don't apply to v5.0-rc1. It seems like you have
> >> instead rebased onto the for-5.1 or for-next branch of the SPI
> >> tree. I guess this is okay, but you should have pointed that out
> >> correctly here. =20
> >=20
> > If I may ask for a few (1-2) days, so I can test this code on vf610
> > NXP SoC.
> >=20
> > As fair as I remember there were some issues when I tested it a few
> > months back. =20
>=20
> You're probably mixing that up. This series is about the FlexSPI=20
> controller in the Layerscape SOCs.

Thanks for the explanation - I've indeed mixed up things a bit :-).

I was of course thinking about the QuadSPI driver - as in [1].

>=20
> The QuadSPI driver is already in linux-next to be merged in 5.1 [1].
> The issues with vf610 existed in the old SPI-NOR driver and probably
> still exist in the new SPI driver. You are welcome to test the new
> driver and come up with some fixes.

I've posted some questions on NXP community, but no reply so far.=20

>=20
> Sooner or later, there will probably also be other changes coming up,=20
> such as implementation of the dirmap API.
>=20
> Thanks,
> Frieder
>=20
> [1]:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/spi?h=3Dnext-20190109&id=3D84d043185dbe0d1b4f6db575bd91c834d37e2f=
78
>=20
> >  =20
> >> =20
> >>> - Incorporated review comments for
> >>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> >>> - Updated s-b tag in all patches.
> >>> Changes for v5:
> >>> - Rebase on top of v4.20-rc2
> >>> - Incorporated review comments for
> >>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> >>> Changes for v4:
> >>> - Incorporated review comments for
> >>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> >>> - Incorporated binding file review comments.
> >>> Changes for v3:
> >>> - Incorporated review comments for
> >>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> >>> Changes for v2:
> >>> - Incorporated Boris review comments and drop below patches as per
> >>> the comments.
> >>>    - Patch 'spi: add slave device size in spi_device struct'
> >>>    - Patch 'spi: add flags for octal I/O data transfer'
> >>> - Incorporated DTS and Binding file review comments of Shawn Guo
> >>> and Rob Herring.
> >>>
> >>>    .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
> >>>    MAINTAINERS                                   |    7 +
> >>>    .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
> >>>    .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
> >>>    arch/arm64/configs/defconfig                  |    1 +
> >>>    drivers/spi/Kconfig                           |   10 +
> >>>    drivers/spi/Makefile                          |    1 +
> >>>    drivers/spi/spi-nxp-fspi.c                    | 1095
> >>> +++++++++++++++++ 8 files changed, 1188 insertions(+)
> >>>    create mode 100644
> >>> Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt create mode
> >>> 100644 drivers/spi/spi-nxp-fspi.c =20
> >> ______________________________________________________
> >> Linux MTD discussion mailing list
> >> http://lists.infradead.org/mailman/listinfo/linux-mtd/ =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/1tZn.EhU2u0toM7wDxle.ut
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlw2aMoACgkQAR8vZIA0
zr318AgAzCL/X8/xbMQ3yo2gDaKHZoKn7yVT7V8l2rP7yPLmzzt5idLkSovh7rHW
DBIAfYaE4ZXoUDC1MkzMn+fjxkuRWXFAmy59wrfQC/QvEfxpEAxORwuQ3jDUYBJ1
QpXS/mOTk81ltTAu7igDd5ngSeeObUbcIE0xlI7g4+vzTezhsBUdygawpMCGMdGO
gEGTmZ0d1pJDStgAsSscKNtvhqFPH55C7PYhXTobMfPWfBZwYhLSUj+wWrIOdGhk
wMDtduklwxS4Zl+KNcU02CeTSiRQY4tF04zJIPjqxqac1PRpgBC07REmK8Jpyeb/
sS850q9fMLipJNVHVqZMw0gczf83tg==
=no86
-----END PGP SIGNATURE-----

--Sig_/1tZn.EhU2u0toM7wDxle.ut--
