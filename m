Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4311C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDB520879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDB520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeI3D11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 23:27:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55538 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeI3D11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 23:27:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42N1893GHwz1qwfQ;
        Sat, 29 Sep 2018 22:57:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42N1891Mj9z1qql4;
        Sat, 29 Sep 2018 22:57:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BqjcavGTqvGc; Sat, 29 Sep 2018 22:57:27 +0200 (CEST)
X-Auth-Info: x23sQdFs8U7Jl4jkSOzNm8oWLcprkKjatifNk+h4N8c=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 29 Sep 2018 22:57:27 +0200 (CEST)
Date:   Sat, 29 Sep 2018 22:57:16 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>,
        yogeshnarayan.gaur@nxp.com, richard@nod.at, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-spi@vger.kernel.org, albert.aribaud@3adev.fr,
        prabhakar.kushwaha@nxp.com, linux-mtd@lists.infradead.org,
        david.wolfe@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
        han.xu@nxp.com, computersforpeace@gmail.com,
        Fabio Estevam <festevam@gmail.com>, dwmw2@infradead.org
Subject: Re: [RFC/RFT PATCH v1 9/9] mtd: spi: Skip reading the Serial Flash
 Discoverable Parameters
Message-ID: <20180929225716.4da9790c@jawa>
In-Reply-To: <1a85becb-6cb0-ede4-be0a-2608e8532c9e@wedev4u.fr>
References: <20180926220739.620-1-lukma@denx.de>
        <20180926220739.620-10-lukma@denx.de>
        <1a85becb-6cb0-ede4-be0a-2608e8532c9e@wedev4u.fr>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wLhr5klBZJk09xPzDXUVnEx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wLhr5klBZJk09xPzDXUVnEx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Cyrille,

> Hi Lukasz,
>=20
> Le 27/09/2018 =C3=A0 00:07, Lukasz Majewski a =C3=A9crit=C2=A0:
> > The fsl-quadspi.c driver is not supporting SPINOR_OP_RDSFDP (0x5a)
> > read opcode - in the legacy driver we do read some garbage
> > data from AHB mapped area and then return on the first check =20
>=20
> If your controller reads garbage then spi_nor_parse_sfdp() fails and
> exists on the very first check: signature of the SFDP header. Hence
> everything should already go on as if the SPI_NOR_SKIP_SFDP flag is
> set.

Yes, this is the observed behaviour.

>=20
> So this patch doesn't change anything for your controller but
> prevents other controller from using QSPI protocols like SPI 1-4-4.
>=20
> This patch introduces a regression for other chips.

As stated in the patch series cover letter - this is to explicitly show
problems with qspi on vf610.

Thanks for your review.

>=20
> Best regards,
>=20
> Cyrille
>=20
> > (L2376 @ ./mtd/spi-nor/spi-nor.c)
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index 442102be174e..c79b8c33aeeb
> > 100644 --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1103,7 +1103,7 @@ static const struct flash_info spi_nor_ids[]
> > =3D { { "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K |
> > SPI_NOR_QUAD_READ) }, { "n25q064a",    INFO(0x20bb17, 0, 64 *
> > 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) }, { "n25q128a11",
> > INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> > -	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256,
> > SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> > +	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256,
> > SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ |
> > SPI_NOR_SKIP_SFDP) }, { "n25q256a",    INFO(0x20ba19, 0, 64 *
> > 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > { "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
> > SPI_NOR_QUAD_READ) }, { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024,
> > 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/wLhr5klBZJk09xPzDXUVnEx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluv5ywACgkQAR8vZIA0
zr1CtQf/UFnXEMZgjoow6gqhGbLF42wN6RzpWO8FcqlDHCBbdo6AjyBvT7Gm994R
/jHnDYdgtIB7W14dLPB1w4ZBnuTvKMxpLEydAAv7Ev3b8yuxmCKm3wyWWDRuRmir
ZxhONRo2rdpfDyVoJfCJljU8pww5i1/IrC9q2hahHLJ7o/ggF4rKNme+siGaXHY/
LZuUFnPVT97uzYZy/AfDxADLZcoggLEYefaDL0SLsM/Oe/B38O5YkteUAsAO+FQc
iJ9+CyuW0CU16LDYmts+A49JRpA+SWOvyaurhzt2pdBnrY+FD+HemRP41MdbtXx5
sV2RvJ/8ZqgtptOpDNnE+SY6xG+LCg==
=Uocv
-----END PGP SIGNATURE-----

--Sig_/wLhr5klBZJk09xPzDXUVnEx--
