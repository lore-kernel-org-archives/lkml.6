Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B7C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE432064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtcM1ioT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE432064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeJVS55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:57:57 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:30944
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728388AbeJVS55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUZIyR+MQv+XqscMlWTNC9VhajZLtuBHcqH7bft7XqQ=;
 b=AtcM1ioTWD/ur6jTemMSVBWm3F5Ld3qyn6ps9jH/Jp97dbfNocWdpkbrdQFc6WKH/wCAtteq2cAmGmSC7kiF9cpfRe2UPakCFbUp2ACOba+T2FbnoXBYZGoUbyHmTHLyguJF5D6wWgv3O4vqWMLUgVDtISktPkBBAcBbrHmULtM=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1598.eurprd04.prod.outlook.com (10.164.84.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 10:39:49 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 10:39:49 +0000
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
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GA=
Date:   Mon, 22 Oct 2018 10:39:48 +0000
Message-ID: <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
 <20181022122659.0675942e@bbrezillon>
In-Reply-To: <20181022122659.0675942e@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1598;6:v8ZV2BnV/vQauiJ589aRU9TXi0EDlCY7Qn6dhrFsalQc63xmfGALLcj9qjdEJmYogDL+hrT+4wU9krgd2nFjFMvmZq0kXsBFcPu7TmsmRw8zlbZ9SdKX+pLDExAqrcmG9h4wjdrHcQlAqjZtbDOrWgW92FN1xSDOGgyJx/WIeAuBMCKm8Fy5N+wG6KKiru5xPidu98oBGbWCJIy0TsDq72HDN5lFqbuibmThG9rbOEjruGVu7VdJ3F8wKj2m4O0DoMuaVuM6JN3YAI5D3xfmS2IiJ8icMrQVN2lkIeFDk6SHEIiFYpi8j/EKyyHxqtDc3GdtV6Myjymghodjqljy4oRcJMdzLMq6E7FFm795islCR4jveqcKnvQ2nmy+j15QCuwkIPhkCcJRWb/6MN7E9Zc8FqGtkjUCjRQcJaASFzRAS6+Bgx0Xmu0Rj+OV7kAUKqhZCjwY416V7nyMsgBscA==;5:TX7o98Q5+x5eu63PZc9fGj5d/hxMomlF1/dN+fJxy25dtVzj8XeuTo+L1o1tZiCtmIx+BdeUVt+kJ770o82NTuSEWAcIZ4DscZSlyhUdnTQobKcW654XWsCqEIz6CTl8fzy1PmGve47fvMbbiil7sVXwo7NPyI0z7/Fy79RMtkw=;7:bnWxsEu93FluEvENSSVwyzI+SyhDgP7u7/Syz864XR/qRNExzNvBblxWdSr60kdaAEf6r5N+Cwem+qKssp8c5FUUCnoEz82wuoC4EW8NRUTEUMohIUrF1Z4vCcf/A1frkqsxRZ0R2ZgvPFipCmbFhHEomPYrV454mGAwXEcrFw2DN6nbvwuURr2i6RfsGowMtEWm1r6OAemnBcfR62yXv1c85EHaGGEmwxU/0OlVhquUEvxm31BOM6hmXH913jD5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d3741ecd-6463-432b-01df-08d6380ab115
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1598;
x-ms-traffictypediagnostic: VI1PR04MB1598:
x-microsoft-antispam-prvs: <VI1PR04MB159835A675B69A5144EC3F7799F40@VI1PR04MB1598.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1598;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1598;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(13464003)(81166006)(74316002)(7416002)(81156014)(8676002)(78486010)(53936002)(9686003)(11346002)(6246003)(68736007)(4326008)(54906003)(86362001)(25786009)(76176011)(316002)(66066001)(7696005)(2906002)(486006)(39060400002)(2900100001)(476003)(99286004)(102836004)(5660300001)(305945005)(106356001)(26005)(5250100002)(105586002)(8936002)(6506007)(478600001)(55236004)(186003)(6916009)(53546011)(6116002)(446003)(229853002)(55016002)(6436002)(3846002)(217873002)(97736004)(71190400001)(71200400001)(33656002)(7736002)(93886005)(256004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1598;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NUvsyWIH3/jLTb64VG0EsDnyEgzBBQ4so3OU3UVklBKQF4yUMCmH/qgr+vJXMvx00lbz6Oa2OKtm+dbsMUVcnDdueWSwEKKzvOmwP+hNa5soSmEDYYJrOLSdd+4V3We58+/y/L3vSa/eyPoCk8wNmGs2g5k/bt5dbDQEt6TFi+Npb5t9mmZ/ZnUdMXpxNbEjSdhR3+HugSjBWZWPPC9jbP52SE8wBxKAN+j27mDWtNqwobz3shsgexpCMwAcdD6qBioZs+LaVXBXV3JqLJFVypbA0/iL84DeW86yQ36zXuUCsP0e1Ywscq2jOa6X73LmOSxCFSLAnvKi+KaNHQI7DDNdhZ/e/SOSVn0LsRNDO4w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3741ecd-6463-432b-01df-08d6380ab115
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 10:39:48.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 3:57 PM
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
>=20
> 				   ^ i +=3D 2) {
>=20
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
>=20
> Drop the above line (i =3D i + 2).
>=20

[    1.632190] Start [addr_width:00000000, read_dumy:08, read_opcode:000000=
00]                                                  =20
[    1.639148] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc              =
                                                       =20
[    1.644451] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004              =
                                                       =20
[    1.649755] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc              =
                                                       =20
[    1.655057] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002              =
                                                       =20
[    1.660360] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd              =
                                                       =20
[    1.665662] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004              =
                                                       =20
[    1.670965] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe              =
                                                       =20
[    1.676267] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1              =
                                                       =20
[    1.681571] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4              =
                                                       =20
[    1.686874] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4              =
                                                       =20
[    1.692176] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe             =
                                                       =20
[    1.697566] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4             =
                                                       =20
[    1.702954] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4             =
                                                       =20
[    1.708343] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1             =
                                                       =20
[    1.713732] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff             =
                                                       =20
[    1.719120] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4             =
                                                       =20
[    1.724509] smpt[0]=3D[addr_width:00000000, read_dumy:08, read_opcode:00=
000065]                                                =20
[    1.731650] smpt[1]=3D[addr_width:00000000, read_dumy:08, read_opcode:00=
000000]                                                =20
[    1.738791] smpt[2]=3D[addr_width:00000000, read_dumy:08, read_opcode:00=
000065]                                                =20
[    1.745932] spi_nor_get_map_in_use:2911 map_id=3D0 smpt_len:16 i=3D:3   =
                                                         =20
[    1.752018] End [addr_width:00000000, read_dumy:08, read_opcode:00000065=
]        =20

Also, one more thing when we are returning from the function, we are over-w=
riting the values of addr_widthm read_dummy and read_opcode.
Is this correct?

out:
        nor->addr_width =3D addr_width;
        nor->read_dummy =3D read_dummy;
        nor->read_opcode =3D read_opcode;
        return ret;
}

--
Regards
Yogesh Gaur
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

