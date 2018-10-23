Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D10C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC2B20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="owYnKa1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC2B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeJWSDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:03:06 -0400
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:64976
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728439AbeJWSDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz53o3LE4vZ/aSzVvsamHhvLrQcyVq43K0ptOP/1BhQ=;
 b=owYnKa1z42jj4iiEkWj8zRwmhaCIXEm5962f2eRALDQcp93c9plFOMt4aHTj6xlsOa2Trpy7AqyMGtoDBYUySIOf72+L9jf+DntvZv5FSzjWB/ZRKFK298eXz7khaay5LYQyO8YyxpE1+9FqMbh3QKsJdTvFAvx1eUNZ0DoE4l8=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:39:25 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:39:25 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Index: AQHUYdKDjlmkWwN6/UiXD412Qj9EqaUbIC2AgAAAseCAEXYtAA==
Date:   Tue, 23 Oct 2018 09:39:25 +0000
Message-ID: <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181012080753.2a59b75c@bbrezillon>
 <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:4rXwnETOpiAcjULcfUu5Ijbjh81iqrjA+Z3WQpQcvUycHFbnxrDjRPBYjCLsYtFHWyOOM7gnzaM8eM/KkreTsoSu/DxwcF2YLTB8amKGq2t9YfWAKcyrU18Ke8FZ3aZpFyGeN24LmkRCfABhSnHX7NR+zOaNchUCA0xFp/yaYYE4337fvuTRdFi17nTzFOPMt906+73s2MLAmoDM1Fz0Vfx8J51RiL8qIeKZGUkE3BS9i4j+vzh9DpSjYFBy8SMdn0/AsjzOXA4trJAATWLw98FaEfWgNw3rhrQbDcB2AXmW6Dw3xbPYfQ3FPiU+jbcX52Bgc3M6Kl4/kHFahpKDNNs9Qkq+Wm9ioxp/CRVgZx529RYbR9LKqOM/2YyQSFrJ6AyQv0+0bVn2psbQ+8OWlBOWLlzCWUMS9nL3/7f2yJee6HDi8eT+5Lx/Kte1T9sPZ6gDb6LGOJ+UCAlkkNhWoA==;5:Wm5iK+qHVn+3nr3TGphdcp/TY3RdA3v2442vx8kGehnGOrSYuldkeqVhBYri/HNxv7YxQmWkq7LPQp3uUR44nYTe9aG9B4xrTQBlWpH1zL2ngAA0Qu63Dg02ipWxATzYz+248yeVUwwWCxWGzULxKYZ+sq0Pu2Riqvru/ahnSq0=;7:UdijoGsYe9VUiSVBbGF5Cgrwt7U2SFi3P0QDqainz7rA7xG/NobURxoe1ffjOCnY7AgHFRFDcAYy+PAQsBQE0lXb9l0ZpNXa5UWLNYtWCZU3J0ZF8ZvXi8aEUfGyu6SkZ79aY5VXuTaunx2Qf7ZMf4k2fmb6VpSgEcBCvPXnq4Io0I7UdBr6E/S1AfTcrxLRKV467Y0hldxSdEEby1F5d5TpyAQNwpe6uPJ6EYOBz3obJ267rQOUKrHw5ITduNdL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5dd604d1-8f0e-4a2d-196c-08d638cb6b77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB502240DA607C18C75CC68BD499F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(85827821059158)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(13464003)(8936002)(256004)(106356001)(102836004)(446003)(55016002)(53936002)(71190400001)(575784001)(4326008)(71200400001)(9686003)(6246003)(54906003)(2906002)(26005)(55236004)(229853002)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(33656002)(86362001)(186003)(6506007)(53546011)(2900100001)(7696005)(78486010)(93886005)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(74316002)(97736004)(5660300001)(39060400002)(316002)(76176011)(5250100002)(14444005)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y1wwIWucn/mxeAroYHZ0qli655v/73NUb0ulQm3qIXL/M02M7d5a2BN2M0UqoNanXXwHSRKgDmUGOaznIXfHerv8HIvXEe1qwc9BJ04R8jxWaBiEreodf/9YOxo1SzIl/23l06pHwEvIdorWWVyU4bjYhlHe8SKU3oHUGRudm/DXz3ET8YF/+friP6zDiElO/h9F/XS6tlLDZiLdzflpBdA8ZmX0NLcXECd6x40ScIKqZcIu3nkH0+XRXQE8H+ddq6gwhbT1SrG8kRjei+oLalDoZgGr9G8Zme/gwxcUX3UHa7ZfGAlfEWj3TMjLAvyEZl3KchnR7GbfxzAeyUXe2qmgEI/alUrYAJLk8avGJsg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd604d1-8f0e-4a2d-196c-08d638cb6b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:39:25.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Did we have have any comments or remarks about this patch-series,  if not p=
lease apply.

Both patches in the series been reviewed by Tudor.

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: Yogesh Narayan Gaur
> Sent: Friday, October 12, 2018 12:02 PM
> To: 'Boris Brezillon' <boris.brezillon@bootlin.com>
> Cc: linux-mtd@lists.infradead.org; linux-spi@vger.kernel.org;
> tudor.ambarus@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@wedev4u.fr; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON fl=
ash
>=20
> Hi Boris,
>=20
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Friday, October 12, 2018 11:38 AM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: linux-mtd@lists.infradead.org; linux-spi@vger.kernel.org;
> > tudor.ambarus@microchip.com; marek.vasut@gmail.com;
> > cyrille.pitchen@wedev4u.fr; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON
> > flash
> >
> > On Fri, 12 Oct 2018 02:23:08 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > > Some MICRON related macros in spi-nor domain were ST.
> > > Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> > >
> > > Added entry of MFR Id for Micron flashes, 0x002C.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > ---
> > > Changes for v3:
> > > - None
> > > Changes for v2:
> > > - None
> > >
> > >  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
> > >  include/linux/mtd/cfi.h       | 1 +
> > >  include/linux/mtd/spi-nor.h   | 3 ++-
> > >  3 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > > b/drivers/mtd/spi-nor/spi-nor.c index 9407ca5..b8b494f 100644
> > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > @@ -284,6 +284,7 @@ static inline int set_4byte(struct spi_nor *nor,
> > > const
> > struct flash_info *info,
> > >  	u8 cmd;
> > >
> > >  	switch (JEDEC_MFR(info)) {
> > > +	case SNOR_MFR_ST:
> > >  	case SNOR_MFR_MICRON:
> > >  		/* Some Micron need WREN command; all will accept it */
> > >  		need_wren =3D true;
> > > @@ -1388,7 +1389,7 @@ static int spi_nor_is_locked(struct mtd_info
> > > *mtd,
> > loff_t ofs, uint64_t len)
> > >  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K |
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > >  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
> > > SPI_NOR_QUAD_READ) },
> > >
> > > -	/* Micron */
> > > +	/* Micron <--> ST Micro */
> > >  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K |
> > SPI_NOR_QUAD_READ) },
> > >  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64,
> > SPI_NOR_QUAD_READ) },
> > >  	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64,
> > SPI_NOR_QUAD_READ) },
> > > @@ -3223,6 +3224,7 @@ static int spi_nor_init_params(struct spi_nor *=
nor,
> > >  			params->quad_enable =3D macronix_quad_enable;
> > >  			break;
> > >
> > > +		case SNOR_MFR_ST:
> > >  		case SNOR_MFR_MICRON:
> > >  			break;
> > >
> > > @@ -3671,8 +3673,9 @@ int spi_nor_scan(struct spi_nor *nor, const
> > > char
> > *name,
> > >  	mtd->_resume =3D spi_nor_resume;
> > >
> > >  	/* NOR protection support for STmicro/Micron chips and similar */
> > > -	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
> > > -			info->flags & SPI_NOR_HAS_LOCK) {
> > > +	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ST ||
> > > +	    JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
> > > +	    info->flags & SPI_NOR_HAS_LOCK) {
> > >  		nor->flash_lock =3D stm_lock;
> > >  		nor->flash_unlock =3D stm_unlock;
> > >  		nor->flash_is_locked =3D stm_is_locked;
> >
> > Are you sure ST and Micron NORs work the same way WRT locking, 4-byte
> > addressing mode and Quad enable?
>=20
> Have checked for the Micron flash, MT35x wrt locking, 4-byte addressing m=
ode.
> For Macronix and Spansion flash there is special handling required for qu=
ad
> mode but not needed for ST flash.
> This flash didn't support quad mode and have checked that other Micron fl=
ash
> also didn't need special handling for quad mode.
> --
> Regards
> Yogesh Gaur.
> >
> > > diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h index
> > > 9b57a9b..cbf7716 100644
> > > --- a/include/linux/mtd/cfi.h
> > > +++ b/include/linux/mtd/cfi.h
> > > @@ -377,6 +377,7 @@ struct cfi_fixup {
> > >  #define CFI_MFR_SHARP		0x00B0
> > >  #define CFI_MFR_SST		0x00BF
> > >  #define CFI_MFR_ST		0x0020 /* STMicroelectronics */
> > > +#define CFI_MFR_MICRON		0x002C /* Micron */
> > >  #define CFI_MFR_TOSHIBA		0x0098
> > >  #define CFI_MFR_WINBOND		0x00DA
> > >
> > > diff --git a/include/linux/mtd/spi-nor.h
> > > b/include/linux/mtd/spi-nor.h index 7f0c730..8b1acf6 100644
> > > --- a/include/linux/mtd/spi-nor.h
> > > +++ b/include/linux/mtd/spi-nor.h
> > > @@ -23,7 +23,8 @@
> > >  #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
> > >  #define SNOR_MFR_GIGADEVICE	0xc8
> > >  #define SNOR_MFR_INTEL		CFI_MFR_INTEL
> > > -#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <-->
> Micron
> > */
> > > +#define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
> > > +#define SNOR_MFR_MICRON		CFI_MFR_MICRON	/*
> Micron */
> > >  #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
> > >  #define SNOR_MFR_SPANSION	CFI_MFR_AMD
> > >  #define SNOR_MFR_SST		CFI_MFR_SST

