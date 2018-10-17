Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F300214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZYm6S6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F300214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJQJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:47:23 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:21440
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbeJQJrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xynL04EH7vluLPvOalILjaXsiLpNU/P+d/5fEQNHqNM=;
 b=BZYm6S6XJgfIxl8rR9w0tw/7EFz6frGHixmm4Pa6D4vkuRP2AZf5foJIdWKw6iA6H4wi+JIMssFC2veojm2uxqxhnJhglpHpP6FQ3VpGyratqvKX86Z8PaehWsjhfHcAKURaReBOmXbZpeMjiD1rWyoIhxn4yyYjMK1Joaapmns=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1694.eurprd04.prod.outlook.com (10.164.85.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 01:54:02 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Wed, 17 Oct 2018
 01:54:01 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgAAmkYCAAAPVAIAA4qnA
Date:   Wed, 17 Oct 2018 01:54:01 +0000
Message-ID: <VI1PR04MB1038B7650F887549CA5EE22B99FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181016140411.3f06e449@bbrezillon> <20181016141754.38dfcf90@bbrezillon>
In-Reply-To: <20181016141754.38dfcf90@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [112.196.150.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1694;6:NsDMoVUb7a1IIVPInE3IaI3V6HI/2lAsbcQKPC8NGiZUfEzlCZxXjHQlRcAOlss/FZ9CZJyg32ZjsGVkuwI8NjT3qVV6jJKyRLthhjoCRtlPH+108GlnSxsafxKaHoeXkvVfFqam+5hqOkSPZVfU05F+IU0LeVvCofNS7oiH2Q54v7JPqdYKhzmAU85zzHIiP2G9YlGYYSw2Lm6asInqTVhCQAaiJuE4xbVjsMYt3XRPmBXIh54nw/N7a7rGt6wrF+QG+oAFwbTWjpvH/F1ZF5f38LLvK3g00Pua8rJ/gvhrEaHaFuyAmRHenOX4DoyWeOIDx5DZ/SqNDtJGzzJ7PZeL8G5XORoVY7pyAGJAuLSFS3Akmu4/8FeedCdxrNO5z6uDXDR+LMwinDqCZPxPmJIup2bsrFBvG7yWHxeIKHmlYsj+UGI8ZSon9OIWGp38U70mpxC3Cj0K+xP5GHg5sA==;5:bqWXbSYpkueS/64wm24KZBZDIXRkoYEzaBn9b5zzIv9UNQqICGD/AkdFuewsKj+hdZ9cLe8w8FClycx+ffblYKmphRHTlygCD9Av2dFYGsdJq5DX+YIT5QfTsJNYKxeKe5R6e4TjwbwfBKEikhHLXwXjjDeLUoFGab7CeF3mlUk=;7:QRFqj3ip+5EPnmm4rcEaP0foW6w5IzIBK+GiO9eHxzSLqAb0p/on+S/Ctn84TWMGg6ltfOIX4bsH0DZbO4ElQ5R0hhj1IAG2Cl7R/qIzF+ZX1SNZOzzX6RX4BaoV/nEeDVSCGoMlUsjaCVmfKgi2c0wKjww8KSYdFousT6424NYy7e19wHJ5Az7rNeB6/aiymR5UzK4deYgehiEofG6NzPVic4V3sHnfz5V7uOhMTeXIdsrpVaCrHKfroa9yT1hV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0095bd79-01af-4e1c-8831-08d633d36975
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1694;
x-ms-traffictypediagnostic: VI1PR04MB1694:
x-microsoft-antispam-prvs: <VI1PR04MB1694BC4A3DEAE37A32B67DF099FF0@VI1PR04MB1694.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991084);SRVR:VI1PR04MB1694;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1694;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(13464003)(217873002)(68736007)(33656002)(478600001)(2900100001)(305945005)(71200400001)(97736004)(7416002)(316002)(54906003)(71190400001)(5660300001)(3846002)(81166006)(5250100002)(2906002)(6246003)(4326008)(99286004)(9686003)(6116002)(7736002)(8936002)(39060400002)(93886005)(81156014)(8676002)(6436002)(76176011)(256004)(55016002)(105586002)(14444005)(66066001)(106356001)(53936002)(476003)(229853002)(446003)(102836004)(6506007)(11346002)(25786009)(53546011)(7696005)(86362001)(14454004)(74316002)(26005)(186003)(486006)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1694;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: beg6PA8Beu9Jf4H4X0rgrFB1Gt4jiWvtAL0bM+4p+UJMYt3aqi9xL4NcrwgXR4W1i9RlRUqsTvg3brxD8hYd6sv9Xoz5ySPVJvlVDcqhVG9NdzwKmduKGjOlMtq+ec2j7yQL4tY2uM4UooPMsjUzoOE8d8V7RQsQMX9/JJVmkK8ai+n1s5YGg3zuqUOAcPouwp5KIvXNzWC1tFFCFuOwZ2LR/nVB20Yecachy4Y6GGMTzU9bBFL/ohTfobMpD3L3Mk6xrwXn0HH0I/HmC3jiR7H7JOOu05CLwIxnMyBCpyqe+7oZIVxedvD7fjDKn621XYJbTrmO0ganHHiVaoufQ4ci/wzonp5GWsTjwDMO15Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0095bd79-01af-4e1c-8831-08d633d36975
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 01:54:01.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 16, 2018 5:48 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Tue, 16 Oct 2018 14:04:11 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>=20
> > On Tue, 16 Oct 2018 09:51:47 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > > Hi Tudor,
> > >
> > > This patch is breaking the 1-4-4 Read protocol for the spansion flash
> "s25fl512s".
> > >
> > > Without this patch read request command for Quad mode, 4-byte enable,=
 is
> coming as 0xEC i.e. SPINOR_OP_READ_1_4_4_4B.
> > > But after applying this patch, read request command for Quad mode is
> coming as 0x6C i.e. SPINOR_OP_READ_1_1_4_4B.
> > >
> > > This flash also supports non-uniform erase.
> > > Can you please check and provide some suggestion?
> >
> > Are you sure the regression comes from this patch? I suspect your bug
> > comes from 41fe242979e4 ("mtd: spi-nor: fsl-quadspi: fix read error
> > for flash size larger than 16MB").
>=20
> I guess you're testing with an fsl-qspi controller, right? Can you try wi=
th this
> patch?

I am testing nxp-flexspi controller and doing just read of small size 0x200=
.
Also 1-1-1 protocol i.e. spi-rx/tx-bus-width as 1 is working fine for this =
flash.

Without this patch read from 1-4-4 protocol is working correctly.

--
Regards
Yogesh Gaur

>=20
> --->8---
>=20
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-=
quadspi.c
> index 1ff3430f82c8..c47fe70c9f98 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -477,9 +477,6 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)  st=
atic int
> fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)  {
>         switch (cmd) {
> -       case SPINOR_OP_READ_1_1_4:
> -       case SPINOR_OP_READ_1_1_4_4B:
> -               return SEQID_READ;
>         case SPINOR_OP_WREN:
>                 return SEQID_WREN;
>         case SPINOR_OP_WRDI:
> @@ -490,8 +487,6 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 =
cmd)
>                 return SEQID_SE;
>         case SPINOR_OP_CHIP_ERASE:
>                 return SEQID_CHIP_ERASE;
> -       case SPINOR_OP_PP:
> -               return SEQID_PP;
>         case SPINOR_OP_RDID:
>                 return SEQID_RDID;
>         case SPINOR_OP_WRSR:
> @@ -503,7 +498,11 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8=
 cmd)
>         case SPINOR_OP_BRWR:
>                 return SEQID_BRWR;
>         default:
> -               if (cmd =3D=3D q->nor[0].erase_opcode)
> +               if (cmd =3D=3D q->nor[0].read_opcode)
> +                       return SEQID_READ;
> +               else if (cmd =3D=3D q->nor[0].program_opcode)
> +                       return SEQID_PP;
> +               else if (cmd =3D=3D q->nor[0].erase_opcode)
>                         return SEQID_SE;
>                 dev_err(q->dev, "Unsupported cmd 0x%.2x\n", cmd);
>                 break;
