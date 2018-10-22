Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC494ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1920779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DBXcwJVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF1920779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJVQv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:51:57 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:2482
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbeJVQv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoHCpCaq97QrTXxduMPX60AAbJKvtYLCN+6Bk61kaRM=;
 b=DBXcwJVZenMLKseiWwonUF3wHLl2/w4qHjQN7jEijR/5jBlkgZUdAnpgFaTktyaWuYdZSYhw6VbXmQnmqr+VFSqc7Rv182LeyGvYL0KHuDPI+2q1NbjOjsEkRCh+18dfAURm6mm4dUdakSTiesUXDxM5HCm6eMjazVxQJvtmOM0=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1552.eurprd04.prod.outlook.com (10.164.84.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 22 Oct 2018 08:32:22 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 08:32:21 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
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
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAAjxACAAAfTkA==
Date:   Mon, 22 Oct 2018 08:32:21 +0000
Message-ID: <VI1PR04MB1038A95F9378AAEAC8D75CB399F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>    <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022100152.05da1b6c@bbrezillon>
In-Reply-To: <20181022100152.05da1b6c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1552;6:OVXdm1S0RNhR6xLJoXKoseNbry7QIIR1QYfLA719BV1p7bYGlGBvrEywaO3UE8Wjpg4n8ONVYMPW8LCA/emCNHfXIYS2onh1Ns9v0OwJh5fgs9+PlfYGL+tobTPuK8PamLEttAmwfa5HY+oDKvKvqNeD8QKFI906apVYnw4BO+S4JHlI8Sx2a0rIcs0EwFtCqxR+gOXwOBNIwV1/yBADx9ec7V1SWpLchv+VxG8Yo4iB3+iduwB4OJ0vTKFHvUVY2qLey0sLLT4DnVabaKW3C1CJrouBFiN874gZ6lBZPo+H2huMf5j1B3VGMIZpAyClF2HOQ1KQF6p5atiZxu5jb1R9515gy5LFY6+HooohHA4Tq8wjDPR0ZLf+42bGG4MO9xkFj+YQzDItpDIieCmiFcbpvT40+iDglQWSKB6o4AL9h11W5g86w6CAr2Dfc+lsBX0RPb56zhff6n+1BRXqUA==;5:z3ThDf/kqcPX3/L5MMXXXhrEDKJjZbou8bRuPo8eZ801QRtjOkGoiq+stITFqD3W+vt42USGv+Jg2uQ1m2JshFps47a0k70EQRrDGSL135GVLu5n9D5usNR4QpnXODIx6LaWisrRmDSv8/LTE2c3u2UiT1EEus2X0PKg7zylluA=;7:nX8FdzAb+suBkd9GHcGXLyo5EQrQUyj5yBlVPN+uqlXy1NMcHghilLDj94g83zDw7cB0AFPcCVA8OY/ny2YxtJIVcU0OipSlj9YiI4e/g3BFuR5nyeXDILWsFm/jmztlZJtcMO0AeljawDsR01nszX6HmtjK01yJuxYt4PYzoJQityNfxkhZEjtV+sKLdNKYJZqvIdoSPD2tgeVG+Xs4YduNCAHTPhy6uq6QozVGLrM2Wyqyc1koRkUOiGV+GQTF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50651400-6154-4793-cb78-08d637f8e2f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1552;
x-ms-traffictypediagnostic: VI1PR04MB1552:
x-microsoft-antispam-prvs: <VI1PR04MB1552D74D876916D74F3AC19399F40@VI1PR04MB1552.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1552;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1552;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(13464003)(189003)(199004)(86362001)(186003)(217873002)(25786009)(97736004)(6246003)(305945005)(7416002)(2900100001)(11346002)(5660300001)(102836004)(14454004)(54906003)(76176011)(26005)(53936002)(4326008)(9686003)(7696005)(256004)(6436002)(55236004)(53546011)(55016002)(39060400002)(6506007)(81156014)(8936002)(229853002)(6916009)(7736002)(78486010)(81166006)(105586002)(93886005)(8676002)(5250100002)(99286004)(3846002)(6116002)(446003)(66066001)(478600001)(486006)(71200400001)(316002)(71190400001)(476003)(2906002)(74316002)(106356001)(33656002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1552;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mcw1i2hH0oKfrnjRzafUPr28n6rUh5sp8ZZuueucB9RznDFyrN6CMKXKumr+Cyuj8Lmfe4kpofceP5oYAtxEx+bpb9sxyAuSV7bZvdonhMC/JXP9OimQX3GJiY4dLulD5u+QZB8h19lnwucEK+Sj0iyaW040kY1hl1oBxXlvmNJBvyyGFJRQ/FDUZZ8+rbS6GhdVsVpejWwv62J4M5x4G7/8ET/MdFwpWTQeQfvh2zqQE/YPDQL8HlslUtWJsMOojTdqr57d8TYcUOryq6vlbUwfuErBuGlZsDC9CazABPzIJ2pviX3VtGsYv3IxKtkJ0xyMnPJK1x6nK+QiBfM8k8gfCUoO316RBAhbbZaUdJg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50651400-6154-4793-cb78-08d637f8e2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 08:32:21.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,


> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 1:32 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
> <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; Cristian.Birsan@microchip.com; Mark Brown
> <broonie@kernel.org>
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Mon, 22 Oct 2018 06:04:13 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > -static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const
> > u32 *smpt)
> > +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const
> > +u32 *smpt, u32 smpt_len)
> >  {
> >         const u32 *ret =3D NULL;
> > -       u32 i, addr;
> > +       u32 i, addr, nmaps;
> >         int err;
> >         u8 addr_width, read_opcode, read_dummy;
> >         u8 read_data_mask, data_byte, map_id;
> > +       bool map_id_is_valid =3D false;
> >
> >         addr_width =3D nor->addr_width;
> >         read_dummy =3D nor->read_dummy;
> >         read_opcode =3D nor->read_opcode;
> >
> > +       for (i =3D 0; i<smpt_len; i++)
> > +               pr_info("%s:%i smpt[%d]=3D%08x\n", __func__, __LINE__,
> > + i, smpt[i]);
> > +
> >         map_id =3D 0;
> > -       i =3D 0;
> >         /* Determine if there are any optional Detection Command Descri=
ptors */
> > -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> > +       for (i =3D 0; i< smpt_len; i++) {
> > +               if (!(smpt[i] & SMPT_DESC_TYPE_MAP))
> > +                       break;
> > +
> >                 read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
> >                 nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i=
]);
> >                 nor->read_dummy =3D spi_nor_smpt_read_dummy(nor,
> > smpt[i]);
>=20
> Could you also print the ->addr_width, ->read_dummy and ->read_opcode her=
e?
>=20
It didn't showing any print messages here, did above line "         if (!(s=
mpt[i] & SMPT_DESC_TYPE_MAP))" also needs to be changes to "    if ((smpt[i=
] & SMPT_DESC_TYPE_MAP))"?

Below is the log, with the suggested change of modifying as
> +       for (nmaps =3D 0; nmaps< smpt_len; nmaps++) {
> +               if((smpt[nmaps] & SMPT_DESC_TYPE_MAP))

[    1.625992] m25p80 spi0.0: found s25fl512s, expected m25p80             =
                                                     =20
[    1.631681] spi_nor_get_map_in_use:2880 smpt[0]=3D08ff65fc              =
                                                       =20
[    1.636988] spi_nor_get_map_in_use:2880 smpt[1]=3D00000004              =
                                                       =20
[    1.642292] spi_nor_get_map_in_use:2880 smpt[2]=3D04ff65fc              =
                                                       =20
[    1.647596] spi_nor_get_map_in_use:2880 smpt[3]=3D00000002              =
                                                       =20
[    1.652898] spi_nor_get_map_in_use:2880 smpt[4]=3D02ff65fd              =
                                                       =20
[    1.658200] spi_nor_get_map_in_use:2880 smpt[5]=3D00000004              =
                                                       =20
[    1.663503] spi_nor_get_map_in_use:2880 smpt[6]=3Dff0201fe              =
                                                       =20
[    1.668806] spi_nor_get_map_in_use:2880 smpt[7]=3D00007ff1              =
                                                       =20
[    1.674108] spi_nor_get_map_in_use:2880 smpt[8]=3D00037ff4              =
                                                       =20
[    1.679412] spi_nor_get_map_in_use:2880 smpt[9]=3D03fbfff4              =
                                                       =20
[    1.684715] spi_nor_get_map_in_use:2880 smpt[10]=3Dff0203fe             =
                                                       =20
[    1.690105] spi_nor_get_map_in_use:2880 smpt[11]=3D03fbfff4             =
                                                       =20
[    1.695495] spi_nor_get_map_in_use:2880 smpt[12]=3D00037ff4             =
                                                       =20
[    1.700886] spi_nor_get_map_in_use:2880 smpt[13]=3D00007ff1             =
                                                       =20
[    1.706275] spi_nor_get_map_in_use:2880 smpt[14]=3Dff0005ff             =
                                                       =20
[    1.711664] spi_nor_get_map_in_use:2880 smpt[15]=3D03fffff4             =
                                                       =20
[    1.717053] spi_nor_get_map_in_use:2910 NO map_id                       =
                                                     =20
[    1.721777] m25p80 spi0.0: s25fl512s (65536 Kbytes)               =20

Didn't throw any return error.

--
Regards,
Yogesh Gaur


> > @@ -2894,18 +2900,35 @@ static const u32 *spi_nor_get_map_in_use(struct
> spi_nor *nor, const u32 *smpt)
> >                  * Configuration that is currently in use.
> >                  */
> >                 map_id =3D map_id << 1 | !!(data_byte & read_data_mask)=
;
> > +               map_id_is_valid =3D true;
> >                 i =3D i + 2;
> >         }

