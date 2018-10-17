Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BCBECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE63D21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d+NQWr8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE63D21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJQPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:41:03 -0400
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:1835
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbeJQPlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ1Wq63gJsVKpycnJPQuVOjWS7DAlLuLY/XAUCS7CpY=;
 b=d+NQWr8tGIWjOmQJ7dSGCj7d0t9kB6uqkl7lBfa6FWCfouf51SVEHUDOS/kPWzwGKtWW5DMyPFYgBXCmYmluRnDDB17/U+5Mh8LdmcHpv5LZHOsCBeKnKthx/4TxAHoM29/6al2hhIfW6v0B7Zx5naiVCz+YtUoWNRpwXHA7bGA=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4992.eurprd04.prod.outlook.com (20.177.49.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 17 Oct 2018 07:46:31 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 07:46:31 +0000
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
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9A=
Date:   Wed, 17 Oct 2018 07:46:30 +0000
Message-ID: <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>    <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
In-Reply-To: <20181017092941.3658bd9a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4992;6:Jc+yNAzW8hi1hWYgKxwn71h6OvI+K6gqBIqihFQPXFTWpU/VUvPv0XGAazkR5Hg+CjU9gI3Jb+BE8JGqo7JaC5XNypRbJYRjAtuUMjy2bnvENG0rFHuHOLTuTFu06PWIVAVO8AoUn3Vp309H3OREyaAru/7O50nlBjEIgsZdeXiwg3OQKMTPNdyG+itlEZqdDhZwgUna1zqretSH1HfdxHtsIpNrthgb9CM66WEmvepteWcffw0SH50OlDGcNsH/gC7wjm2hKVVSwhNb0yi0V2HjRiG7KTSw/tnqtN/X/8Ie7VqdIWdbtezmPzKGr9XbqJlxg2oKnJp4Uu18Tpoc8O/8u4O/hDDRq3y9Us/HamfBXsGz/hMFMLPdQiwN//1FV0qOEsqmWrY82xPOBbHTNaTzWZQUKDgD3U7UEdIcQj2AVBIKb0DE8VHVGG/C4SRLy6RlvVyYMtSz8w+lhmKyWA==;5:0/HlKWMdJe1YYcifdSdhRqaXUnyPKP8Qg2j+IsI9bmk1eL+TFbj0u1JS4MzEM7YC95x6Up+k5Xe/rA4fmQdMJ0NrCN5QyODqcw0VpY2CvuNtxpPreEWTTWLuY23zhDst5gGbN6zgWsnERjXam9H/8TNrRwv74UXCbOEu5WGxdJM=;7:L+39mKUpkM3mf2we8pf+bzwej3EwoHV2EFxKuZy2LNNUeBlmuzlxubQCsGrprDJw3zrTOyXn+aJCPDsSIYPTAn0RXiWKaD6tAWV5BPJVQg7ciD5Mw8IW0GP1iZLZZ5pepVARLP192LOuOFHW9fwPKH4SMcRhZ8psc+SLIFlHXHbQi3hIob3pYcn003/Mo37ZyLEw01QRnkNCJe9G1yh+ER6KN0EtKiogcGBj1RmzMijfp2ed2mTbIZVLFmSHH/Yz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8501140-5560-4c21-d15d-08d63404a75d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4992;
x-ms-traffictypediagnostic: VI1PR04MB4992:
x-microsoft-antispam-prvs: <VI1PR04MB49922B6B2EADF1D3814BFCFC99FF0@VI1PR04MB4992.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4992;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4992;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(13464003)(199004)(189003)(478600001)(305945005)(486006)(476003)(55236004)(53546011)(6506007)(7736002)(78486010)(186003)(54906003)(446003)(11346002)(102836004)(5250100002)(55016002)(6436002)(7416002)(93886005)(26005)(9686003)(229853002)(86362001)(6116002)(76176011)(3846002)(99286004)(71190400001)(33656002)(256004)(7696005)(14444005)(14454004)(66066001)(316002)(217873002)(2906002)(71200400001)(6246003)(25786009)(39060400002)(5660300001)(81156014)(68736007)(8936002)(8676002)(97736004)(6916009)(74316002)(53936002)(2900100001)(4326008)(81166006)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4992;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aFL5k/9mq3Y0IxwdobStDcedUlt6/wgqyvmaQHHZpUPaugWIowhyNx7hm6Fra0mN9KwGp7jdHCsN5zVbs3r3clOCvdBQlnGx5NDkZZVjb0/56bBuXgu/Z8kaVDKDEkXNi6l266z1FfPkfys1IN3+VrohwQ88A5kuVllNpCnCYgkOCTRYRjXINwKTlphk7KUomXjFqB6cHGqaBjAsXXjLtXi9U553bE8E+U8h4MXtvvPXBwUPtX4WYczzaA076uPeh00VIEoA8kMsnbS1IKJnBi9vELwb1pm2ZJxz2gqSc9IEfa/axO1Mlc3ZIeR07rP4PNNIn2NXpZJ7EypQh8qvjOCLA8fp9v1u91qVAogoit0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8501140-5560-4c21-d15d-08d63404a75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 07:46:31.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Wednesday, October 17, 2018 1:00 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
> <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Wed, 17 Oct 2018 09:10:45 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>=20
> > On Wed, 17 Oct 2018 09:07:24 +0200
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> >
> > > On Wed, 17 Oct 2018 02:07:43 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > > > >
> > > > Actually there is no entry of s25fs512s in current spi-nor.c file.
> > > > For my connected flash part, jedec ID read points to s25fl512s. I
> > > > have asked my board team to confirm the name of exact connected
> > > > flash part. When I check the data sheet of s25fs512s, it also
> > > > points to the same Jedec ID information. { "s25fl512s",
> > > > INFO(0x010220, 0x4d00, 256
> > > > * 1024, 256, ....}
> > > >
> > > > But as stated earlier, if I skip reading SFDP or read using 1-1-1
> > > > protocol then read are always correct. For 1-4-4 protocol read are
> > > > wrong and on further debugging found that Read code of 0x6C is
> > > > being send as opcode instead of 0xEC.
> > > >
> > > > If I revert this patch, reads are working fine.
> > >
> > > Can you try with the following patch?
> > >
> >
> > Hm, nevermind. The problem is actually not related to 4B vs non-4B
> > mode but 1-1-4 vs 1-4-4 modes.
Yes, that's only I have stated in my first mail that instead of 1-4-4 mode =
read opcode is being sent for 1-1-4 mode.
> >
>=20
> Can you try with this patch applied?
>=20
With suggested patch, read for protocol 1-4-4 working correctly.

	[    1.625360] m25p80 spi0.0: found s25fl512s, expected m25p80            =
                                                      =20
	[    1.631094] m25p80 spi0.0: failed to parse SMPT (err =3D -22)          =
                                                        =20
	[    1.636661] 261 8c4c780 opcode(read:eb, pp:2, erase:d8)                =
                                                      =20
	[    1.641878] 266 8c4c780 opcode(read:ec, pp:12, erase:dc)               =
                                                      =20
	[    1.647200] m25p80 spi0.0: s25fl512s (65536 Kbytes)        =20

Without this patch, param_headers are getting freed and restoring previous =
erase map i.e. opcode related to 1-1-4 protocol.

--
Regards
Yogesh Gaur

> --->8---
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c index
> 9407ca5f9443..cf33d834698c 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -3132,6 +3132,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>                 switch (SFDP_PARAM_HEADER_ID(param_header)) {
>                 case SFDP_SECTOR_MAP_ID:
>                         err =3D spi_nor_parse_smpt(nor, param_header);
> +                       if (err) {
> +                               dev_warn(dev,
> +                                        "failed to parse SMPT (err =3D %=
d)\n",
> +                                        err);
> +                               /*
> +                                * SMPT parsing is optional, let's not dr=
op
> +                                * all information we extracted so far ju=
st
> +                                * because it failed.
> +                                */
> +                               err =3D 0;
> +                       }
>                         break;
>=20
>                 default:
