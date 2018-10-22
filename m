Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DBC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FC72088F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipf/k16R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FC72088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeJVTVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:21:25 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:52159
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728566AbeJVTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qz4AfjHxqDIwoo9DjvmnSZU1FwKWzHP430jnpSLT5U=;
 b=ipf/k16RtoDUU1U5bzuVaiimrc+NcszfgSToOuEnS+hc4sNXNNNZLEZzQLlJsxL29PaFs3FgkL4DsUgNEoFp/yu9IDhmmcRVw5g41gbm83dlMoEjJxgRObFSEf8pydgMLvE+95MaqDnRWw8XSgs3yO4+DCsb3NNXz6XPDxWMS38=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4973.eurprd04.prod.outlook.com (20.177.49.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 11:03:10 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 11:03:09 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
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
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYA=
Date:   Mon, 22 Oct 2018 11:03:09 +0000
Message-ID: <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
        <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022124627.2c6c3b93@bbrezillon> <20181022125259.42df83ea@bbrezillon>
In-Reply-To: <20181022125259.42df83ea@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4973;6:v+w28xUgSEzEaZHvnPLbvjNvqPXwMoMh3b4Gw8fS7Vi6oy/RFU4NFtW+55GQv9eZLk8RyaDRMs1uxHNnnNQpblbOxz49zDt6WPX6dViUTMVmrnNLd1nGCkBacHRETF7WtVEIREuwH1IMnvfGMYq8XbULe5hskhSWp8ZC+sKtOazhcjtbQ4KFcqf4XPRlRfpeHBFNVhzIo0zKkSgQRDlNe0N2yZJBbmY2M0Q+Hxinu+5f1e5kX3BVa515Ie1tEGTO3/LLWzlMRVCpHv/O+GqEJ6CK0ulgjmMJfdDOl5oiXgPWu2ArTU4BYRzk/zBwXlz2CoApjUKo6tIF68RaOlGQBiO73DZWhsLYM2FCgpxYtbnsGqvSjXlOAB/zuguqk1KwdvRIgZO77BeyDjG1FTI10QoL6pJStVI0r9ycrC1oIMoZDsZ1YhB1Acvgnw5bxB9xHCp1plXtJntPUBtsANOpyA==;5:9Rmqe0130A1vTDxb2EhraFHwT+OH0RDvqSlJW8DrnEXtH5lwzcyOYWoM7mYw8cFuLdbm4MUZfEmvGHlwtYR5fdiaJF5UUP7hhDxMP3A/bKmJ3Kji+iUiJwCDkLNyJaSKD10Zc5R7huEklnS+4Q9/6gTj5ov9X/XmXpIMk879O24=;7:uukfT3+o+ScilUJuoL24+eYS0qYdsvezt2QB7ptF0nkxaGfvdrU2R+JdfR8rAK6kU6WpiQ10VI0RC7IOyJsXccsVhHabZKpnrne/oQU6peJfM83bQSG/bTNFZoRujNvEKkBT8l+mZM+RgH96tXv6kD7EMSip8OY2qyex8ejIn3bvqdoFYuxUjovsKEyD9vdKWorazqt5+D1Rf8mB4GwjcQRahDiEYPP4RadcATRMycAYRVe5DGvIvj54rTmL8zfe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dc62d715-e2f3-4ab0-16d2-08d6380df409
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4973;
x-ms-traffictypediagnostic: VI1PR04MB4973:
x-microsoft-antispam-prvs: <VI1PR04MB49733F93F6AF1F9B9B47F2C099F40@VI1PR04MB4973.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4973;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4973;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(13464003)(189003)(199004)(86362001)(54906003)(9686003)(217873002)(81156014)(93886005)(33656002)(71190400001)(53546011)(53936002)(71200400001)(99286004)(186003)(7416002)(14454004)(78486010)(486006)(97736004)(8936002)(316002)(2900100001)(81166006)(55236004)(6506007)(105586002)(106356001)(2501003)(5660300001)(39060400002)(8676002)(478600001)(66066001)(4326008)(110136005)(256004)(102836004)(11346002)(476003)(446003)(6116002)(3846002)(76176011)(7696005)(2906002)(6246003)(68736007)(25786009)(26005)(5250100002)(229853002)(55016002)(305945005)(74316002)(6436002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4973;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HcBfO5Fg/cqk/7A19UhjKU40MdDCsFKV7jIDVCRnxmDc+wyxZj6buKgueu/JoUaHNqlZ9ETIEWbQg74XKBZQtOOPjqznd+FWQIqqfepvzQV+l0J4nerVgUNpBQ/82Bjy3aq3Y7MzGD/h9/XkENS0gznifqfQAPqfZH6Vm/VJOkZHh+02yNlTUmwspCVhpHYOWbtzB04/cN8QGuzOucCvMEOEVZjfm2a4TFabfgsV7iCdFtI1WiIjOaXrSoV6pQNbXZXKnE7NHC6o+CmwJaE5ny2WuG8sGCdW3BW34yLl3SEAKjArdnsqhg0WscDnp44gdp58MB8rilcrqVPVo4rGnzfv9sHBtKuPsv3NSPaOArM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc62d715-e2f3-4ab0-16d2-08d6380df409
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 11:03:09.7639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 4:23 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> Cristian.Birsan@microchip.com
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at; Mark
> Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; Cyrille Pit=
chen
> <cyrille.pitchen@wedev4u.fr>; computersforpeace@gmail.com;
> dwmw2@infradead.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Mon, 22 Oct 2018 12:46:27 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>=20
> > On Mon, 22 Oct 2018 10:39:48 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > >
> > > [    1.632190] Start [addr_width:00000000, read_dumy:08,
> read_opcode:00000000]
> > > [    1.639148] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc
> > > [    1.644451] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004
> > > [    1.649755] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc
> > > [    1.655057] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002
> > > [    1.660360] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd
> > > [    1.665662] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004
> > > [    1.670965] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe
> > > [    1.676267] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1
> > > [    1.681571] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4
> > > [    1.686874] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4
> > > [    1.692176] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe
> > > [    1.697566] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4
> > > [    1.702954] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4
> > > [    1.708343] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1
> > > [    1.713732] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff
> > > [    1.719120] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4
> > > [    1.724509] smpt[0]=3D[addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> > > [    1.731650] smpt[1]=3D[addr_width:00000000, read_dumy:08,
> read_opcode:00000000]
> > > [    1.738791] smpt[2]=3D[addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> >
> > You still don't print read_dummy correctly: %0x8 -> %08x.
> >
> > Can you add
> >
> > 	if (!nor->addr_width)
> > 		nor->addr_width =3D 3;
> >
> > After the
> >
> > 	nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i]);
> >
> > line.
>=20
> And you should also try to force ->read_dummy to 8, because according to =
the
> spec, the default read_latency is 8 for this chip. With that in place, yo=
u should
> get an map_id of 1, 3 or 5.
>=20

Below is the log output.
I have forced the read_dummy as 8 and addr_width is programmed as 3.

[    1.625176] m25p80 spi0.0: found s25fl512s, expected m25p80             =
                                                     =20
[    1.630875] Start [addr_width:00000000, read_dumy:00000000, read_opcode:=
00000000]                                            =20
[    1.638352] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc              =
                                                       =20
[    1.643658] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004              =
                                                       =20
[    1.648963] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc              =
                                                       =20
[    1.654266] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002              =
                                                       =20
[    1.659569] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd              =
                                                       =20
[    1.664872] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004              =
                                                       =20
[    1.670175] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe              =
                                                       =20
[    1.675477] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1              =
                                                       =20
[    1.680782] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4              =
                                                       =20
[    1.686084] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4              =
                                                       =20
[    1.691391] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe             =
                                                       =20
[    1.696782] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4             =
                                                       =20
[    1.702171] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4             =
                                                       =20
[    1.707561] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1             =
                                                       =20
[    1.712951] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff             =
                                                       =20
[    1.718340] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4             =
                                                       =20
[    1.723731] smpt[0]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065]                                          =20
[    1.731393] smpt[1]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000000]                                          =20
[    1.739056] smpt[2]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065]                                          =20
[    1.746721] spi_nor_get_map_in_use:2914 map_id=3D0 smpt_len:16 i=3D:3   =
                                                         =20
[    1.752807] End [addr_width:00000003, read_dumy:00000008, read_opcode:00=
000065]                                              =20
[    1.760125] m25p80 spi0.0: s25fl512s (65536 Kbytes) =20

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
                if (err)
                        goto out;

--
Regards
Yogesh Gaur.

> >
> > > [    1.745932] spi_nor_get_map_in_use:2911 map_id=3D0 smpt_len:16 i=
=3D:3
> > > [    1.752018] End [addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> > >
> > > Also, one more thing when we are returning from the function, we are =
over-
> writing the values of addr_widthm read_dummy and read_opcode.
> > > Is this correct?
> >
> > Yes, that's correct.
> >
> > >
> > > out:
> > >         nor->addr_width =3D addr_width;
> > >         nor->read_dummy =3D read_dummy;
> > >         nor->read_opcode =3D read_opcode;
> > >         return ret;
> > > }
> > >
> >
> >

