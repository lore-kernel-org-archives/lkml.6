Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF5C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD02420658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EDD9d15G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD02420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeJVSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:35:58 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:56460
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbeJVSf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PY1BfkJUbHNLULRV+Dt1J/o/cyIp/vnfqSlGpROKFQ=;
 b=EDD9d15G+3krdDefTg4isRo3/QYluzqef48kFb2SCchnL1OHKWkRDZwKXCQYojNpmV1FjJHv1kc8t9UnfomVfWfYecpeFig/t2xE7bthJgj6wbkOPWuSfTlBDWcJjPN8jQeIQ1Ox03idijvOWFMlOt+W1du+bJuMslMuNhS0cJQ=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5216.eurprd04.prod.outlook.com (20.177.51.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 10:17:58 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 10:17:58 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAAArAAgAABtyA=
Date:   Mon, 22 Oct 2018 10:17:58 +0000
Message-ID: <VI1PR04MB10383A3C1381532DF0C18F8699F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
        <20181022111543.2a607efc@bbrezillon>
        <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022121044.24039f40@bbrezillon>
In-Reply-To: <20181022121044.24039f40@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5216;6:pesIM91rftT5Z4EMwUeH3i9hXKtJZksQ0Kk1bBgNllb2leg3gVZvjOgJNHV04FR3w8dE8+cvTJXXIB8y92ksMwOK7mlLP1vVGLBASswX/9PXE/T5u9erTBQjrxrtMp6GTDUjXzjJOpxSnFVnIXpXAHInqoTmC9++D+x56LvxhTjL3fVNf+yw0pt5b4x1364Kpbxl6VzwYIyX3HQHzjyXZj/sKdtSsWrd1upeuO+pR/z36F8lCHJLoXQnpu9k0CkED2esEq+RfBWZr/s4aAOxFkKgvfLdK1XXP8MT68pwMtlRWyVoj8VVXHgK06lmteUYqZldUS5KChk8e5/TWN0HrJYE4/q6yOBArFMd6QUU8oo88m+6Dt0WaeI8hq52Ma4piQP7bYdf4spLeAtaguuh+dZpxgfT9WwM/yQ52nM2jaajoIM1tBjg6bfb+7tQtUHZmhMiz3yesx/5Vb6GF7iwfw==;5:lwzCXdEQ09itIugC9WjmSwk8ldSlgxsPj/8+Dve/pQNnaRuRL7YbzIuV/dwwo/UxI/lOanZGpQqwzWIg6EiPsBbMy1s62T41wQgTdJRKYiZm0uEpEQO+z0SIAdjO3jCYsuTpeUcwjOW3UrwkOGkl4PdMG7eues5wrw+qZxifbGs=;7:/YzfGXxWDLvOiJjlAisOa7DQ9OtzLoFlUJxDxudwa4nGb/eci+LjBmh7y4AELP8kEfWw2sEO7BIEXNSxvepdLFcm/tAyrcKyzNQ6BRyz90BjZvCymCZq+IKUVRSHslDHD86Z3CmGJ+1Vk+tdLmkZG3nzRSemc0FKFxv0xTK3H0l9U8WNG46NOwqi9pj6MOGIlRDGWtdZ3o9+6suxbIhGSJEG5R0kwAIybWT2Dsi+uEbwai/SxVLmtBfQq5qi8vBz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 317ac973-5b56-403a-0788-08d63807a3f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5216;
x-ms-traffictypediagnostic: VI1PR04MB5216:
x-microsoft-antispam-prvs: <VI1PR04MB521634DBEA23F1C2A90BED3A99F40@VI1PR04MB5216.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5216;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(13464003)(199004)(189003)(53936002)(66066001)(11346002)(446003)(6246003)(6916009)(2900100001)(476003)(39060400002)(25786009)(4326008)(55016002)(217873002)(486006)(97736004)(256004)(53546011)(55236004)(102836004)(6506007)(5250100002)(186003)(26005)(9686003)(99286004)(6436002)(76176011)(14454004)(7696005)(71200400001)(71190400001)(5660300001)(54906003)(3846002)(7416002)(6116002)(78486010)(105586002)(106356001)(86362001)(68736007)(81166006)(81156014)(316002)(93886005)(8676002)(229853002)(2906002)(478600001)(305945005)(74316002)(7736002)(8936002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5216;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wOO5hEntUQLJEGxJpqDlYLVMm5/NR+y1UXbjpxBN/3gbS3Xi3UKmzzDR0NiB+6cTsGWKRFwIZMr3r2W5wS4/Ks414RQ99MxJBIK7FrdgdWlNZ8NRdMCelzhJxtcQkkQqZ/GgLndVJ7wFteIaKoffnum2vdtLYAb0x9lKsw9JO2+a9z6PkuH2WCGP9M5GNxEjtlyEKfl6FO0aSGB3Av+mNG3Ixk8qUUQGcAzQ5tq1RzlRoYdovndaxTdx3nhzqM9Enhr00thhk1R/fX3ZLlyHkIEMHZTbe5e5t36bSOfnfhBtNW2mfoSHcO6ZJv8k1wapn20alFYqwiK625tmcH+CcZnbnkndljGKS89uTml/xwc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317ac973-5b56-403a-0788-08d63807a3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 10:17:58.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 3:41 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at; Mark
> Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> Cristian.Birsan@microchip.com; Cyrille Pitchen <cyrille.pitchen@wedev4u.f=
r>;
> computersforpeace@gmail.com; dwmw2@infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Mon, 22 Oct 2018 10:03:55 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi,
> >
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Monday, October 22, 2018 2:46 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at;
> > > Mark Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > Cristian.Birsan@microchip.com; Cyrille Pitchen
> > > <cyrille.pitchen@wedev4u.fr>; computersforpeace@gmail.com;
> > > dwmw2@infradead.org; linux-arm- kernel@lists.infradead.org
> > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > SFDP SPI NOR flash memories
> > >
> > > On Mon, 22 Oct 2018 06:04:13 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > >
> > With below patch, it gets stuck in for loop of "+       for (nmaps =3D =
0; i< smpt_len;
> nmaps++) {".
> >
> > [    1.624684] m25p80 spi0.0: found s25fl512s, expected m25p80
> > [    1.630377] Start [addr_width:00000000, read_dumy:08,
> read_opcode:00000000]
> > [    1.637335] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc
> > [    1.642641] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004
> > [    1.647945] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc
> > [    1.653248] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002
> > [    1.658551] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd
> > [    1.663855] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004
> > [    1.669158] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe
> > [    1.674461] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1
> > [    1.679766] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4
> > [    1.685070] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4
> > [    1.690375] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe
> > [    1.695768] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4
> > [    1.701158] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4
> > [    1.706550] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1
> > [    1.711940] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff
> > [    1.717330] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4
> > [    1.722720] smpt[0]=3D[addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> > [    1.729861] spi_nor_get_map_in_use:2912 map_id=3D1
> >
> >
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -2863,26 +2863,36 @@ static u8 spi_nor_smpt_read_dummy(const struct
> spi_nor *nor, const u32 settings)
> >   * @nor:       pointer to a 'struct spi_nor'
> >   * @smpt:      pointer to the sector map parameter table
> >   */
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
> > +       pr_info("Start [addr_width:%08x, read_dumy:%0x8,
> > + read_opcode:%08x]\n", nor->addr_width, nor->read_dummy,
> > + nor->read_opcode);
> > +
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
> > +               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> > +                       break;
> > +
> >                 read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
> >                 nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i=
]);
> >                 nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i=
]);
> >                 nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
> > +               pr_info("smpt[%d]=3D[addr_width:%08x, read_dumy:%0x8,
> > + read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy,
> > + nor->read_opcode);
> > +
> >                 addr =3D smpt[i + 1];
> >
> >                 err =3D spi_nor_read_raw(nor, addr, 1, &data_byte); @@
> > -2894,18 +2904,36 @@ static const u32 *spi_nor_get_map_in_use(struct
> spi_nor *nor, const u32 *smpt)
> >                  * Configuration that is currently in use.
> >                  */
> >                 map_id =3D map_id << 1 | !!(data_byte & read_data_mask)=
;
> > +               map_id_is_valid =3D true;
> >                 i =3D i + 2;
> >         }
> >
> > -       /* Find the matching configuration map */
> > -       while (SMPT_MAP_ID(smpt[i]) !=3D map_id) {
> > -               if (smpt[i] & SMPT_DESC_END)
> > -                       goto out;
> > +       if (map_id_is_valid)
> > +               pr_info("%s:%i map_id=3D%d\n", __func__, __LINE__, map_=
id);
> > +       else
> > +               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> > +
> > +       for (nmaps =3D 0; i< smpt_len; nmaps++) {
> > +               if((smpt[i] & SMPT_DESC_TYPE_MAP))
> > +                       continue;
>=20
> Try to Replace the above if block by:
>=20
> 		if (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> 			i +=3D 2;
> 			continue;
> 		}
>=20

It works,
[    1.628162] m25p80 spi0.0: found s25fl512s, expected m25p80             =
                                                     =20
[    1.633854] Start [addr_width:00000000, read_dumy:08, read_opcode:000000=
00]                                                  =20
[    1.640811] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc              =
                                                       =20
[    1.646117] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004              =
                                                       =20
[    1.651421] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc              =
                                                       =20
[    1.656724] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002              =
                                                       =20
[    1.662028] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd              =
                                                       =20
[    1.667331] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004              =
                                                       =20
[    1.672635] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe              =
                                                       =20
[    1.677937] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1              =
                                                       =20
[    1.683240] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4              =
                                                       =20
[    1.688542] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4              =
                                                       =20
[    1.693845] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe             =
                                                       =20
[    1.699234] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4             =
                                                       =20
[    1.704625] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4             =
                                                       =20
[    1.710014] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1             =
                                                       =20
[    1.715403] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff             =
                                                       =20
[    1.720791] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4             =
                                                       =20
[    1.726180] smpt[0]=3D[addr_width:00000000, read_dumy:08, read_opcode:00=
000065]                                                =20
[    1.733320] spi_nor_get_map_in_use:2912 map_id=3D0 smpt_len:16 i=3D:3   =
                                                         =20
[    1.739406] End [addr_width:00000000, read_dumy:08, read_opcode:00000065=
]                                                    =20
[    1.746204] m25p80 spi0.0: s25fl512s (65536 Kbytes)                     =
  =20

-       /* Find the matching configuration map */
-       while (SMPT_MAP_ID(smpt[i]) !=3D map_id) {
-               if (smpt[i] & SMPT_DESC_END)
-                       goto out;
+       if (map_id_is_valid)
+               pr_info("%s:%i map_id=3D%d smpt_len:%d i=3D:%d\n", __func__=
, __LINE__, map_id, smpt_len, i);
+       else
+               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
+
+       for (nmaps =3D 0; i< smpt_len; nmaps++) {
+               if(!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
+                       i +=3D 2;
+                       continue;
+               }
+
+               if(!map_id_is_valid) {
+                       if (nmaps) {
+                               ret =3D NULL;
+                               break;
+                       }
+
+                       ret =3D smpt+i;
+               } else if (map_id =3D=3D SMPT_MAP_ID(smpt[i])) {
+                       ret =3D smpt+i;
+                       break;
+               }
+
                /* increment the table index to the next map */
                i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
        }

-       ret =3D smpt + i;
+       pr_info("End [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n"=
, nor->addr_width, nor->read_dummy, nor->read_opcode);

> > +
> > +               if(!map_id_is_valid) {
> > +                       if (nmaps) {
> > +                               ret =3D NULL;
> > +                               break;
> > +                       }
> > +
> > +                       ret =3D smpt+i;
> > +               } else if (map_id =3D=3D SMPT_MAP_ID(smpt[i])) {
> > +                       ret =3D smpt+i;
> > +                       break;
> > +               }
> > +
> >                 /* increment the table index to the next map */
> >                 i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
> >         }
> >
> > -       ret =3D smpt + i;
> > +       pr_info("End [addr_width:%08x, read_dumy:%0x8,
> > + read_opcode:%08x]\n", nor->addr_width, nor->read_dummy,
> > + nor->read_opcode);
> >         /* fall through */
> >  out:
> >         nor->addr_width =3D addr_width;

