Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0305CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA09420665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tocPT+xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA09420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJWNJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:09:19 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:6080
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeJWNJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqbAnFFl0fDdmMKSW4wJrGQbVWlb5V2A4dR5E2i8+fs=;
 b=tocPT+xkV6ILsrroG+Gc0W6w0V7IZZCH7TeTBcK9MN/wYU52t5Lb8otfy+AY1FWK05NbeYyp4yc43dKRh8iDebc8RmM7UtJ94VVjk+FaqwswMNXmmgiQuPpw9cnmdrk9QR3hqRy/AxM5LIIHyvEHu2x2lhrvnxMOn2ulXrHtsAo=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4816.eurprd04.prod.outlook.com (20.177.48.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Tue, 23 Oct 2018 04:47:34 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 04:47:33 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYCAAAvpAIAAAL7QgAABtoCAARoEIA==
Date:   Tue, 23 Oct 2018 04:47:33 +0000
Message-ID: <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>    <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022111543.2a607efc@bbrezillon>
        <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022122659.0675942e@bbrezillon>
        <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022124627.2c6c3b93@bbrezillon>    <20181022125259.42df83ea@bbrezillon>
        <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022134324.2c1bd248@bbrezillon>
        <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022135211.1978c25d@bbrezillon>
In-Reply-To: <20181022135211.1978c25d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4816;6:XQES+uIEuRV82q0GEFw1ibWVdowLghQvzayDt2SoG8g+i1ZNx3oybyxxh+bXvt5OIM4EaQv9GZN+DmAWtQtKiTZv9drIQEAH3nVOdCHphvESPEmHbp9Csrq2VWK1xBxNRVVi9KBh7c4ArLhTRYxhd4UQcLHptuhazIzP4/MMEaO+YLbRoCyJcG+v4oynurIQhL90MNxFxWD8wndwVfNXVStXqVvm3zDcIDBMnOtxGBg4Jj/tqoW8lWqy6us+cfugsx8dTCe6KrstRNTG96PgeFDqMvKd590bEOyHvPHR6Sz0pTOQifLCd+C37EaKZBVUUTl/fypmhgOcF8qQgR+bBhUUdM76g2p5XRUJ9AsZg2465eLpXrAUCQhy4f6Qe0HLz7PVIP8MEBWcOgFxDpwnFJn1rx7eDSwmDmxzhLfKY9Ow5Mc/EeDgmN/DWLqbVSuaRRH8SuzxlisriaDA/jdGEA==;5:s8sRLDHJUbXiL1EdXoLiYYDH3rPckLmFa8mOYrWk02qqb3SktH9hHqcSJeX6rjjvgLdykW3pTQTPESfOXhYOtXptoExSFjwsP5bb5gTO9hIwYkhVcCWtrUIale/HYIVr5jLVheW2vzJKNKz6NvYYTu3CWi+NDzwUgTx0kKWszw4=;7:CsshrfoG0u6god9pVtrkbFXZi4cnehh5ceKmwqn5J0iKC26/iH8lXkaTS/EHnQ88J4HgTaFC7NjqHqNTUnZfK1V1q3AF4AnXrygzaw/a8KVsci5CeU33AaGzwPhmz/RXnbO4DpIxCsbyxONHMqyq2VMuFO+hqmdl/MvKbIiu5O9akjpvYJzXyYKXlAtuQeiEQo00Q07zJEj03lqFigopMqxe9L2034zCfOFlvD1EZM5rVE9DlgBGTA5ToL9pCt4a
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df324273-5761-441d-1a8f-08d638a2a5b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4816;
x-ms-traffictypediagnostic: VI1PR04MB4816:
x-microsoft-antispam-prvs: <VI1PR04MB4816954FEC92DA4CA2DDDC1399F50@VI1PR04MB4816.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4816;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4816;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(13464003)(66066001)(14454004)(478600001)(93886005)(81156014)(8936002)(54906003)(105586002)(316002)(8676002)(217873002)(68736007)(6246003)(6916009)(229853002)(53936002)(39060400002)(6436002)(9686003)(2906002)(2900100001)(78486010)(7736002)(71190400001)(3846002)(6116002)(4326008)(446003)(33656002)(97736004)(106356001)(25786009)(81166006)(5660300001)(74316002)(476003)(71200400001)(55016002)(305945005)(5250100002)(76176011)(486006)(26005)(7416002)(55236004)(256004)(6506007)(99286004)(102836004)(186003)(7696005)(86362001)(11346002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4816;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H0Sb/H4BffstLhoHmyUil7pFYzNSj2InGGaelLjpjGEnG0Tx4+RHjs8GJmi9x5m5T9IfFD5MVMwC+2yAkP6l8FnOdU3VZDi87kLYBW2uKhHY+ueGqBrRTDO0zsb9RJ+c416Me9oteqMsf1ErXI6WQOpTjQ5ClqGDUN5mEZkSI6zutzsrlOIjYyJO93J8WyknUSAgb4Gtq9BpFeHseKLmr9SsvtaFepAMGfrPUvMZwD20YJkTSpJlSpkHPtPPnTsgNZnAjgOtb0D67imu0/leh9H9HiEmjTJFJSyuEa7pqS2un8sZIXb8lI9tSDgFQOtFOnb6mSyT754lNxno2uBMsQjGd0thPn4/ABSfl/yTV9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df324273-5761-441d-1a8f-08d638a2a5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 04:47:33.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4816
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 5:22 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; Cyrille Pit=
chen
> <cyrille.pitchen@wedev4u.fr>; computersforpeace@gmail.com;
> dwmw2@infradead.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Mon, 22 Oct 2018 11:46:55 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Monday, October 22, 2018 5:13 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> > > <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> > > <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > computersforpeace@gmail.com; dwmw2@infradead.org;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > SFDP SPI NOR flash memories
> > >
> > > On Mon, 22 Oct 2018 11:03:09 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > > Sent: Monday, October 22, 2018 4:23 PM
> > > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> > > > > Cristian.Birsan@microchip.com
> > > > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at;
> > > > > Mark Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > > > computersforpeace@gmail.com; dwmw2@infradead.org;
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to
> > > > > non-uniform SFDP SPI NOR flash memories
> > > > >
> > > > > On Mon, 22 Oct 2018 12:46:27 +0200 Boris Brezillon
> > > > > <boris.brezillon@bootlin.com> wrote:
> > > > >
> > > > > > On Mon, 22 Oct 2018 10:39:48 +0000 Yogesh Narayan Gaur
> > > > > > <yogeshnarayan.gaur@nxp.com> wrote:
> > > > > >
> > Patch used
> >
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -2863,26 +2863,39 @@ static u8 spi_nor_smpt_read_dummy(const struct
> > spi_nor *nor, const u32 settings)
>=20
> >         /* Determine if there are any optional Detection Command Descri=
ptors */
> > -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> > +       for (i =3D 0; i< smpt_len; i++) {
>=20
> See, you should have i +=3D 2 here, not i++.

Ok
>=20
> > +               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> > +                       break;
> > +
> >                 read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
> >                 nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i=
]);
> > -               nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i=
]);
> > +               if (!nor->addr_width)
> > +                       nor->addr_width =3D 3;
> > +
> > +               nor->read_dummy =3D 8; //spi_nor_smpt_read_dummy(nor,
> > + smpt[i]);
> >                 nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
> > +               pr_info("smpt[%d]=3D[addr_width:%08x, read_dumy:%08x,
> > + read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy,
> > + nor->read_opcode);
> > +
> >                 addr =3D smpt[i + 1];
> >
> >                 err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
>=20
> And add a trace here to print data_byte and addr.
>=20
Logs:
[    1.625840] m25p80 spi0.0: found s25fl512s, expected m25p80             =
                                                     =20
[    1.631536] Start [addr_width:00000000, read_dumy:00000000, read_opcode:=
00000000]                                            =20
[    1.639013] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc              =
                                                       =20
[    1.644317] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004              =
                                                       =20
[    1.649621] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc              =
                                                       =20
[    1.654924] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002              =
                                                       =20
[    1.660229] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd              =
                                                       =20
[    1.665532] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004              =
                                                       =20
[    1.670836] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe              =
                                                       =20
[    1.676140] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1              =
                                                       =20
[    1.681444] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4              =
                                                       =20
[    1.686748] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4              =
                                                       =20
[    1.692052] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe             =
                                                       =20
[    1.697441] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4             =
                                                       =20
[    1.702830] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4             =
                                                       =20
[    1.708220] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1             =
                                                       =20
[    1.713608] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff             =
                                                       =20
[    1.718999] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4             =
                                                       =20
[    1.724388] smpt[0]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065]                                          =20
[    1.732050] smpt_read[1] addr[00000004], data_byte[00000000] err:0000000=
0                                                    =20
[    1.738830] smpt[2]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065]                                          =20
[    1.746491] smpt_read[3] addr[00000002], data_byte[00000002] err:0000000=
0                                                    =20
[    1.753270] smpt[4]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065]                                          =20
[    1.760930] smpt_read[5] addr[00000004], data_byte[00000000] err:0000000=
0                                                    =20
[    1.767710] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16 i=3D:6   =
                                                         =20
[    1.773794] End [addr_width:00000003, read_dumy:00000008, read_opcode:00=
000065] ReturnVal:00000000                               =20
[    1.781092] spi_nor_parse_smpt:3065                                     =
                                                     =20
[    1.784573] m25p80 spi0.0: failed to parse SMPT (err =3D -22)           =
                                                       =20
[    1.790153] m25p80 spi0.0: s25fl512s (65536 Kbytes) =20


Code:
        for (i =3D 0; i< smpt_len; i+=3D2) {
                if ((smpt[i] & SMPT_DESC_TYPE_MAP))
                        break;

                read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
                nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i]);
                if (!nor->addr_width)
                        nor->addr_width =3D 3;

                nor->read_dummy =3D 8;=20
                nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
                pr_info("smpt[%d]=3D[addr_width:%08x, read_dumy:%08x, read_=
opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);

                addr =3D smpt[i + 1];

                err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
                pr_info("smpt_read[%d] addr[%08x], data_byte[%08x] err:%08x=
\n", (i+1), addr, data_byte, err);
                if (err)
                        goto out;

                /*
                 * Build an index value that is used to select the Sector M=
ap
                 * Configuration that is currently in use.
                 */
                map_id =3D map_id << 1 | !!(data_byte & read_data_mask);
                map_id_is_valid =3D true;
        }

        if (map_id_is_valid)
                pr_info("%s:%i map_id=3D%d smpt_len:%d i=3D:%d\n", __func__=
, __LINE__, map_id, smpt_len, i);
        else
                pr_info("%s:%i NO map_id\n", __func__, __LINE__);

        for (nmaps =3D 0; i< smpt_len; nmaps++) {
                if(!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
                        i +=3D 2;
                        continue;
                }

                if(!map_id_is_valid) {
                        if (nmaps) {
                                ret =3D NULL;
                                break;
                        }

                        ret =3D smpt+i;
                } else if (map_id =3D=3D SMPT_MAP_ID(smpt[i])) {
                        ret =3D smpt+i;
                        break;
                }

                /* increment the table index to the next map */
                i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
        }

        pr_info("End [addr_width:%08x, read_dumy:%08x, read_opcode:%08x] Re=
turnVal:%08x\n", nor->addr_width, nor->read_dummy, nor->read_opcode, ret);

--
Thanks
Yogesh Gaur.

> Thanks,
>=20
> Boris
