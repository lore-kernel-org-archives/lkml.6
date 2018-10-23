Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA9CC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26EE207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="moCu0rIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26EE207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJWQlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:41:04 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:37255
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbeJWQlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jV6pMJMO3uBBDlLbnkqzt8zpG+4USSa4K+OYGdvN/8=;
 b=moCu0rIvXtoMSScZSkAFrLwAArQw8CN6OZwBDpxXyln9tQrBCUzbl0wJBV//Im1W+3i9zDWWjSm77kwEpdEv83+OZuJQLVjEjQ/8DDyKaLNz/ci116+ZTAnm1GZk8aN0T3FpQ/QU8ifE3Vm1nT/yrztzGJ9n8fkE7dQf6vI1m6s=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB0925.eurprd04.prod.outlook.com (10.161.106.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:18:37 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:18:36 +0000
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
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYCAAAvpAIAAAL7QgAABtoCAARoEIIAAEEQAgAAqy8A=
Date:   Tue, 23 Oct 2018 08:18:35 +0000
Message-ID: <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20181017091045.124e0266@bbrezillon>    <20181017092941.3658bd9a@bbrezillon>
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
        <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181023073946.138b287e@bbrezillon>
In-Reply-To: <20181023073946.138b287e@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB0925;6:9jT9iswFh10Uo8dCvo1bUK9JvHoDfpQk2tDyTPffZU1lIXKCI6MhgdVHQvU7hyXm8l2Vd9BeD579YYD3PBAu+BZIu0rtTpZn+tzwFORfrdpJGZCev/wg2tcZGm0iDgRaSmuSjuQ4jEhl1ShZhWkXE2yOfV4peXH47J2Ol3JpukciJKWjM4O5/0FKz9l8ot6wxXq3WzwNxNJ29zePn3zJuv6DQ51/bkR8BEMWP2NdoWrjhC4AC0ClC3K9R9U0qbcH07k2mM+TwLMuRnEHg2PINht4UyX+XFdVCuWybd26q+2VusWkDigrL1lhmdMXrMiE+CFvIWaKXMx4hdbjhBkVwanhtwp+MgpXmCYbF4iw+EgcAbhNIYJjLj6mOUT1NRtTpFrWJcA5ip7qKUR052Nd10otCM5OV6L7/W8vh9xDfv0ml/lJ8Y2X5F4FYEOrTW3eV68UBXpZf1m3Do9fMdv08A==;5:keWiufRQExYw35RQrR3lYT8jB+BKUcFt9tyRcPxZZTCIe0ckjWGpw7x+eiKfOu67kIBUC/WVZR3GAXMs+f41uu3zMPuMRToRtpu5tnA+A7dKbCCPzmc6lEURpt6EX4pkzI89BNcvi3ulM8wcF1+qMtukDpUZYLNo04T9y4B3lGk=;7:qmZwKbrXnG5ZqUcHmhFsNkqEc3a0rLuBnzrF0T1n+lQZ+UM/GxFdX+G56ObkPk48BH3/daIpZtX3xCpYzjfCDLNM7Yi5prifuwYoi8aopr9jwyXFTPQF/sLoPJ9IoZuKh7VTqtr7TzrsGbq+ZWsPQH3W39zAo3df+pzjGktXaOIpB1TG/szXDCobSziZU6nSzIXeDa++RHJGwHBEWNZa91ReBSdsWLvZW0lRiDHb6O7o2J9PwkHagUzn0pRcaq22
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 958ffeb6-d378-45ba-376b-08d638c0212f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB0925;
x-ms-traffictypediagnostic: VI1PR04MB0925:
x-microsoft-antispam-prvs: <VI1PR04MB0925BE4C72711A5F3149DE5C99F50@VI1PR04MB0925.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB0925;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0925;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(13464003)(5660300001)(7416002)(54906003)(2906002)(66066001)(97736004)(316002)(476003)(71190400001)(74316002)(217873002)(81166006)(8676002)(6436002)(11346002)(81156014)(486006)(186003)(76176011)(9686003)(55016002)(93886005)(7696005)(99286004)(86362001)(39060400002)(6246003)(4326008)(33656002)(6506007)(14454004)(68736007)(8936002)(229853002)(71200400001)(53546011)(6916009)(446003)(53936002)(55236004)(102836004)(106356001)(256004)(5250100002)(305945005)(2900100001)(7736002)(78486010)(26005)(105586002)(25786009)(3846002)(6116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB0925;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uJW9fm7pgCwJzjqD+jqlipTvGghAo+mQ9wrQgDq7j7mJ2Kslt5tvUj9Htf3CJ7EJ6ur9bquD1zqIAfeArXzICFvVVyjbofUYgk7aebygS/9T3rvU1J0lMzmFpTizAmSa8Vbbaf/CgFudLd0aON7BAkH+SB5tAjvZtdGAbmPtD+HPj7QTjbG3bMZFbz0XGr4i/p5Lu/LYTqC6TqWxzkWOahYS68gqYvDSsAPrrNbfBf6NxBsRAP+iwpJ5jvXQDHIwz6SAeYvR7/FWpGhRiKpdhh7wW4GvWZ2BThtEgCoPkPE9AhV+sENNu3hnUJayKwBLx+kgDhszAa2DqmeKELF0JQhg+FrCjgOpZV3i9kqBcns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958ffeb6-d378-45ba-376b-08d638c0212f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:18:35.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 23, 2018 11:10 AM
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
> On Tue, 23 Oct 2018 04:47:33 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi,
> >
> > > -----Original Message-----
[....]
>=20
> Ok, so now the opcode and address are matching the values in the spec.
> Can you check what's sent to the SPI controller side (in your
> ->exec_op() implementation), just to make sure the m25p80 propagates
> the information correctly? When you do that, make sure you also print the
> buswidth of each element (op->cmd.buswidth, op->addr.buswidth,
> op->dummy.buswidth and op->data.buswidth).
>=20
> Can you also print the read_data_mask value here.

I have added the prints in m25p80_read() and in flexspi controller prepare_=
lut and read_rxfifo() func.
In these have added prints for data variable of struct op and data which be=
ing read by the controller from the flash.

[    2.091467] smpt[0]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065, data_mask:00000008]         =20
[    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:0000=
0008, len:00000001                      =20
[    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, b=
width:1]                                =20
[    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:=
1]                                      =20
[    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nby=
tes:3, bwidth:1]                        =20
[    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]     =
                                        =20
[    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:=
24003008      2:0     3:0]              =20
[    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]                 =
                       =20
[    2.151004] smpt_read[1] addr[00000004], data_byte[00000000] err:0000000=
0  =20

                                                 =20
[    2.157782] smpt[2]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065, data_mask:00000004] =20
[    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:0000=
0008, len:00000001                =20
[    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3, b=
width:1]                      =20
[    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:=
1]                                    =20
[    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:2, nby=
tes:3, bwidth:1]                  =20
[    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]     =
             =20
[    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:=
24003008      2:0     3:0]      =20
[    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]                 =
          =20
[    2.217319] smpt_read[3] addr[00000002], data_byte[00000002] err:0000000=
0                                                    =20


[    2.224098] smpt[4]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065, data_mask:00000002]                =20
[    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:0000=
0008, len:00000001             =20
[    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, b=
width:1]                    =20
[    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:=
1]                    =20
[    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nby=
tes:3, bwidth:1]           =20
[    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]     =
                              =20
[    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:=
24003008      2:0     3:0]        =20
[    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]                 =
                   =20
[    2.283634] smpt_read[5] addr[00000004], data_byte[00000000] err:0000000=
0                =20


[    2.290412] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16 i=3D:6   =
                                                         =20
[    2.296496] End [addr_width:00000003, read_dumy:00000008, read_opcode:00=
000065] ReturnVal:00000000                           =20
[    2.305444] spi_nor_parse_smpt:3065                                     =
                                                     =20
[    2.308924] m25p80 spi0.0: failed to parse SMPT (err =3D -22)           =
                          =20


>=20
> Next thing you can do is read the CR2NV reg (using the RDAR command) and
> check the RL (Read Latency) and AL (Address Length) values.

Please let me know how to read CR2NV register.

--
Regards,
Yogesh Gaur

>=20
> > [    1.767710] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16 i=3D:=
6
> > [    1.773794] End [addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065] ReturnVal:00000000
> > [    1.781092] spi_nor_parse_smpt:3065
> > [    1.784573] m25p80 spi0.0: failed to parse SMPT (err =3D -22)
> > [    1.790153] m25p80 spi0.0: s25fl512s (65536 Kbytes)
> >
> >
> > Code:
> >         for (i =3D 0; i< smpt_len; i+=3D2) {
> >                 if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> >                         break;
> >
> >                 read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
> >                 nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i=
]);
> >                 if (!nor->addr_width)
> >                         nor->addr_width =3D 3;
> >
> >                 nor->read_dummy =3D 8;
> >                 nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
> >                 pr_info("smpt[%d]=3D[addr_width:%08x, read_dumy:%08x,
> > read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy,
> > nor->read_opcode);
> >
> >                 addr =3D smpt[i + 1];
> >
> >                 err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
> >                 pr_info("smpt_read[%d] addr[%08x], data_byte[%08x] err:=
%08x\n",
> (i+1), addr, data_byte, err);
> >                 if (err)
> >                         goto out;
> >
> >                 /*
> >                  * Build an index value that is used to select the Sect=
or Map
> >                  * Configuration that is currently in use.
> >                  */
> >                 map_id =3D map_id << 1 | !!(data_byte & read_data_mask)=
;
> >                 map_id_is_valid =3D true;
> >         }
> >
> >         if (map_id_is_valid)
> >                 pr_info("%s:%i map_id=3D%d smpt_len:%d i=3D:%d\n", __fu=
nc__,
> __LINE__, map_id, smpt_len, i);
> >         else
> >                 pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> >
> >         for (nmaps =3D 0; i< smpt_len; nmaps++) {
> >                 if(!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> >                         i +=3D 2;
> >                         continue;
> >                 }
> >
> >                 if(!map_id_is_valid) {
> >                         if (nmaps) {
> >                                 ret =3D NULL;
> >                                 break;
> >                         }
> >
> >                         ret =3D smpt+i;
> >                 } else if (map_id =3D=3D SMPT_MAP_ID(smpt[i])) {
> >                         ret =3D smpt+i;
> >                         break;
> >                 }
> >
> >                 /* increment the table index to the next map */
> >                 i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
> >         }
> >
> >         pr_info("End [addr_width:%08x, read_dumy:%08x,
> > read_opcode:%08x] ReturnVal:%08x\n", nor->addr_width, nor->read_dummy,
> > nor->read_opcode, ret);
> >
> > --
> > Thanks
> > Yogesh Gaur.
> >
> > > Thanks,
> > >
> > > Boris

