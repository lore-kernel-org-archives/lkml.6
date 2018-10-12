Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F68C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFBE2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XS/8SoBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFBE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJLOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:05:44 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:22465
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbeJLOFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzkGKAEJaQ9hZKES0DALFl+8UgDw5VoakUaMSqwbaAo=;
 b=XS/8SoBfS8wqJlMUQpNuK0OScKM7dF65kPfsa64yO7CvYWMJqjNmvMZk7vsssk3zBDHfMDTAQiGssEF/eoTuLayCjQ6Awafnr3Hf9axjkjxSVSeAII7EffC4Mr3mfsq/Vtgm4w6O6X7qRs+xBbJD8up3TYB/ipF7so4s12iu73Q=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4096.eurprd04.prod.outlook.com (52.133.14.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Fri, 12 Oct 2018 06:31:51 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Fri, 12 Oct 2018
 06:31:51 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Index: AQHUYdKDjlmkWwN6/UiXD412Qj9EqaUbIC2AgAAAseA=
Date:   Fri, 12 Oct 2018 06:31:51 +0000
Message-ID: <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181012080753.2a59b75c@bbrezillon>
In-Reply-To: <20181012080753.2a59b75c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [112.196.150.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4096;6:T7nOxVrqf8G5ockWfkN18f8hA7oloT7puu3js5b4OyxQWzs0XjEu8iPI7SbUrgv+tfupdIRvpwfikCm9tDdMaNEKtU6PhXlAl6anUGcUWIbfUdBTs90JePP7dO4Mv4ozCAG7au9OAOK/vELIpkqMEJSnJ2VXmi5e7pxNJBA98o0b3bJgGJF11nI1GblAskqyP4kzT/xg08YyDVnOzjtjrU84GXisfv8+Uq8qCbSiuJd/Xm3wzbT/FWMpu+DVTKRTGjVcJpTKE7/cQqnWZAEH2aUNYnJY8giZtHvGQfYyUiWON5DYMzmD162sNkoZRp97jcexbFDN5YXPp8wTYdLwaxqulHc9z293DGJrYnJzRVeloSany+2XLcjOhJvOgB0O0bO1G12xXxh6x31Ch7nuEBkbw4bIe4Kt1th8yMT+Pzy+Nm2u3ylr+IPh3fzubijZTE1bAsNaTStMgc+dYQKh5w==;5:e0td/NJSMkdjIbeCq+cmMY3mz90LcRDzFWkoMq9bufZlcNzasnOs8735q7+nR0CNqwGjVWa6GSz51NoIAEo8sn/pQ7Eu74nmtKJ96UbNFUsPilPoXC2ibnULgmMB5TTjrdATXbmdLt//E7pcho78lCnbrIdaJ5LAr7p5fK3SLUw=;7:eq8Kv5sxfSjPJU6awj+Jma0v4qolSiWiidSnWbmX7FNXWwYizdr4zZcKmKpPR2hUrx3d9wFfJFTFNc2AY3/UDR3rmjYnlucmRiYq3olWjZn2siYjKyvMYc/ZL2TGS9Ly0lgbO4G+HcwcUIo7fozpiwtStZHI2JazGtFVaTq/AJQ08neMpifORPwu/P1zOVYGOQnADtJO3W22NyS+rnbM8jf9ODn+Wzh6vk9ssa5u7hgt7biTJBP9n5LCjVTYCQ85
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 42772834-f4f3-429f-f619-08d6300c656d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4096;
x-ms-traffictypediagnostic: VI1PR04MB4096:
x-microsoft-antispam-prvs: <VI1PR04MB4096EF545BA14CD6D022B24299E20@VI1PR04MB4096.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(85827821059158)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB4096;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4096;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(13464003)(189003)(199004)(6506007)(6916009)(5660300001)(8936002)(6116002)(53546011)(3846002)(25786009)(316002)(97736004)(478600001)(53936002)(81156014)(8676002)(305945005)(54906003)(476003)(229853002)(486006)(39060400002)(6436002)(7736002)(33656002)(9686003)(55016002)(76176011)(6246003)(99286004)(7696005)(81166006)(74316002)(102836004)(186003)(26005)(5250100002)(14444005)(4326008)(575784001)(256004)(86362001)(106356001)(446003)(11346002)(2906002)(66066001)(71200400001)(71190400001)(105586002)(14454004)(2900100001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4096;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rTwdoghB9JRctUsDDqMHjQrFaVTxevw8q1INIePJucTFuSro81h0BeH2l8cmTPfyJfPAF83sMQcOP8TzEooPoM0Uu+E/+C6fqJnWgc+IHuF6JFoIZYK4Z2z3ZWLGa7xX94gLA/ZUrKwBABomJbJWskOCkAjxIiP6vgvUs6P91Jn8Jb6CqeZJ1w4RYFlgs/tyJkC0fMZhxdZ/EED2yObPKE5HhaKznvyKOVpj/Qa8KdzAb+LIsUjVbwx69KcTxXZNz5xCcDLm8B6WpzmfdqN6eTWjXG2MbbEuntmGHwNoj+M9CNvhbMfqkvLN3EgM+pFU2te90Oh/acan46KK2LQJBCSRPgLeSSUmPJLma3ResFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42772834-f4f3-429f-f619-08d6300c656d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 06:31:51.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Friday, October 12, 2018 11:38 AM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; linux-spi@vger.kernel.org;
> tudor.ambarus@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@wedev4u.fr; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON fl=
ash
>=20
> On Fri, 12 Oct 2018 02:23:08 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Some MICRON related macros in spi-nor domain were ST.
> > Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> >
> > Added entry of MFR Id for Micron flashes, 0x002C.
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> > Changes for v3:
> > - None
> > Changes for v2:
> > - None
> >
> >  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
> >  include/linux/mtd/cfi.h       | 1 +
> >  include/linux/mtd/spi-nor.h   | 3 ++-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index 9407ca5..b8b494f 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -284,6 +284,7 @@ static inline int set_4byte(struct spi_nor *nor, co=
nst
> struct flash_info *info,
> >  	u8 cmd;
> >
> >  	switch (JEDEC_MFR(info)) {
> > +	case SNOR_MFR_ST:
> >  	case SNOR_MFR_MICRON:
> >  		/* Some Micron need WREN command; all will accept it */
> >  		need_wren =3D true;
> > @@ -1388,7 +1389,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd=
,
> loff_t ofs, uint64_t len)
> >  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
> > SPI_NOR_QUAD_READ) },
> >
> > -	/* Micron */
> > +	/* Micron <--> ST Micro */
> >  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K |
> SPI_NOR_QUAD_READ) },
> >  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64,
> SPI_NOR_QUAD_READ) },
> >  	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64,
> SPI_NOR_QUAD_READ) },
> > @@ -3223,6 +3224,7 @@ static int spi_nor_init_params(struct spi_nor *no=
r,
> >  			params->quad_enable =3D macronix_quad_enable;
> >  			break;
> >
> > +		case SNOR_MFR_ST:
> >  		case SNOR_MFR_MICRON:
> >  			break;
> >
> > @@ -3671,8 +3673,9 @@ int spi_nor_scan(struct spi_nor *nor, const char
> *name,
> >  	mtd->_resume =3D spi_nor_resume;
> >
> >  	/* NOR protection support for STmicro/Micron chips and similar */
> > -	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
> > -			info->flags & SPI_NOR_HAS_LOCK) {
> > +	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ST ||
> > +	    JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
> > +	    info->flags & SPI_NOR_HAS_LOCK) {
> >  		nor->flash_lock =3D stm_lock;
> >  		nor->flash_unlock =3D stm_unlock;
> >  		nor->flash_is_locked =3D stm_is_locked;
>=20
> Are you sure ST and Micron NORs work the same way WRT locking, 4-byte
> addressing mode and Quad enable?

Have checked for the Micron flash, MT35x wrt locking, 4-byte addressing mod=
e.
For Macronix and Spansion flash there is special handling required for quad=
 mode but not needed for ST flash.
This flash didn't support quad mode and have checked that other Micron flas=
h also didn't need special handling for quad mode.
--
Regards
Yogesh Gaur.
>=20
> > diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h index
> > 9b57a9b..cbf7716 100644
> > --- a/include/linux/mtd/cfi.h
> > +++ b/include/linux/mtd/cfi.h
> > @@ -377,6 +377,7 @@ struct cfi_fixup {
> >  #define CFI_MFR_SHARP		0x00B0
> >  #define CFI_MFR_SST		0x00BF
> >  #define CFI_MFR_ST		0x0020 /* STMicroelectronics */
> > +#define CFI_MFR_MICRON		0x002C /* Micron */
> >  #define CFI_MFR_TOSHIBA		0x0098
> >  #define CFI_MFR_WINBOND		0x00DA
> >
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index 7f0c730..8b1acf6 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -23,7 +23,8 @@
> >  #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
> >  #define SNOR_MFR_GIGADEVICE	0xc8
> >  #define SNOR_MFR_INTEL		CFI_MFR_INTEL
> > -#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron
> */
> > +#define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
> > +#define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
> >  #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
> >  #define SNOR_MFR_SPANSION	CFI_MFR_AMD
> >  #define SNOR_MFR_SST		CFI_MFR_SST

