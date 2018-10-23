Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31BBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47516207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J9IWSX0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47516207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeJWRVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:21:55 -0400
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:58192
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbeJWRVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvrVg3OADGgZ1R4fpQuDOwluJOg3+gO/hC0MDrozoKo=;
 b=J9IWSX0ppgBe7iyBLF5H1yT3Tl8vf9q9BTmf4/xguOWkf7HuOFjvGNTiP2rGD8vbMCHawq8ijG7X+WgFB4yxumZMyHN2QxmWRu85L+2REeOwC94B41qfyqPpntIkUvYRxK76oyU8r1k+snhEidrl0/YtSOrjXptXMv3HOgQ4mxE=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1149.eurprd04.prod.outlook.com (10.162.120.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:59:22 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:59:22 +0000
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
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYCAAAvpAIAAAL7QgAABtoCAARoEIIAAEEQAgAAqy8CAAAnsgIAAAmJg
Date:   Tue, 23 Oct 2018 08:59:22 +0000
Message-ID: <VI1PR04MB1038AB2711EF5C639E5139BF99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
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
        <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181023104827.77e7775b@bbrezillon>
In-Reply-To: <20181023104827.77e7775b@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1149;6:5OcwuuAUygDXjX0wnVQoi2XMZmi2HLwDUWPuWnhoR3UKPcOdSXwCvSeBpEcMzOyONf9+7bxsQmydHAfKSQ1qhOGp6xwe62bpCcz0ml9o5CX40ilFHp53Y2UKOdLjPMmpUqmGDfOCE075KdvbrRDNAvRT0NDPb0XOUYb/0Ov/wWYUNGRYEQiy0Ln0ZnzfjZbkpmcHovXLXL3j3pbaiSpmkox6fHOM2dgAyK09kgfVcCDUn/g9ZtgjJdK4swVxLdUXpqQmXJvqJxXuy++GKDmi0SKOIEDxLXB/nQtBHuBHBkSeBzsdzVr6qf5inb9wQ2oaKgbPirgAdHunbuyiiVzEWDO4ktMdKlW5j26KHs3Bu926liHSMX15+jN7WPgS6F6MOvkopLgk3M6WpYopxUQdjK76hwwT/JRNUZxSQKHeQNIGmNLEEIqDdrfQ4FxsG1QXK4TDRYdEKZIV2SLPjLDHvQ==;5:rWVV5/i64HuS9ifX8Tmbys+jleh0LHE/pDcALaU67EluV8ZdWjDCoX/oI+cF2m4u/+JnJ28geUdBR1cGqevrLY094tFnM80CXMtxxTlMYL/gtIEN65NFChopAoFOwp/3Hs7+7KXCnDUW6oPHqSAeQK8HyESpr6YXsoSfScH0GFg=;7:XylWN94EBCfkRLBJOolWbwjTsQLxdZ7lBEnGDd2EwU60k8A8/DTdHRzVSHKcZHuAdUlWeLyYFUzy9DdK856JdI6C+zMeDfpHqP/6KIObZ3fieh45L6gFa4xgk52RnntkdDcb8x8aKrq6QX66/V57ONZMecaCZp9YGhhoP/dSKn0MFlQmOC9+RdidGK4ndocStuhYO4oXEUAHcpqClkXVzREv8rEvV+/dZoAWx7guTrLiKfxTWUZdiclGKV+SCKD9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc26df4e-cc4d-4862-dd65-08d638c5d340
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1149;
x-ms-traffictypediagnostic: VI1PR04MB1149:
x-microsoft-antispam-prvs: <VI1PR04MB1149029E9C2B5C48A0D75DAF99F50@VI1PR04MB1149.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1149;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1149;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(13464003)(68736007)(86362001)(6116002)(3846002)(71190400001)(105586002)(54906003)(7416002)(78486010)(5660300001)(106356001)(81166006)(229853002)(74316002)(2906002)(7736002)(8936002)(71200400001)(305945005)(33656002)(478600001)(316002)(93886005)(8676002)(81156014)(25786009)(6916009)(55016002)(2900100001)(476003)(217873002)(4326008)(39060400002)(6246003)(53936002)(486006)(14444005)(66066001)(6436002)(99286004)(7696005)(9686003)(14454004)(76176011)(97736004)(5250100002)(186003)(256004)(11346002)(446003)(26005)(55236004)(53546011)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1149;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nyn8TL+/UKLzA4rPmangN3sB5H+FXPx8KWQbEJ524UVNOoMIdGgO7c/DiBN5sd0A1yLc2pcwXdXMWOt0i0ALPTvFuxqEZer+APgx1bz7B/ddfDhafmMifM/OpYqeiLP8lYEdbaI1RGXx/mS3Od/E+hl/+bSPqK7WG7sBFb6yrmrJm7Li6e9fGPqW8VrclirhoARrlgTm3rOJmMzHB10LX9T2PHAdaRDWooErQlzR62Oc11+cWX4o42L2doENQDKzTkX9lYdAGukqYvFQhY/M8wyAaqLlKCzbcBOsQYTvipkNXuUyFU8WknrPE6+9tvy6gi57XHQ/WuV8Nm0fdpAtW+GFRnh8Wi3aOXuRPju4MtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc26df4e-cc4d-4862-dd65-08d638c5d340
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:59:22.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 23, 2018 2:18 PM
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
> On Tue, 23 Oct 2018 08:18:35 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> >
> > I have added the prints in m25p80_read() and in flexspi controller prep=
are_lut
> and read_rxfifo() func.
> > In these have added prints for data variable of struct op and data whic=
h being
> read by the controller from the flash.
> >
> > [    2.091467] smpt[0]=3D[addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065, data_mask:00000008]
> > [    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003,
> dummy:00000008, len:00000001
> > [    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:=
3,
> bwidth:1]
> > [    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,
> nbytes:1]
> > [    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4,
> nbytes:3, bwidth:1]
> > [    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]
> > [    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> 1:24003008      2:0     3:0]
> > [    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > [    2.151004] smpt_read[1] addr[00000004], data_byte[00000000]
> err:00000000
> >
> >
> > [    2.157782] smpt[2]=3D[addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065, data_mask:00000004]
> > [    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003,
> dummy:00000008, len:00000001
> > [    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:=
3,
> bwidth:1]
> > [    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,
> nbytes:1]
> > [    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:2,
> nbytes:3, bwidth:1]
> > [    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]
> > [    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> 1:24003008      2:0     3:0]
> > [    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]
> > [    2.217319] smpt_read[3] addr[00000002], data_byte[00000002]
> err:00000000
> >
> >
> > [    2.224098] smpt[4]=3D[addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065, data_mask:00000002]
> > [    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003,
> dummy:00000008, len:00000001
> > [    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:=
3,
> bwidth:1]
> > [    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,
> nbytes:1]
> > [    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4,
> nbytes:3, bwidth:1]
> > [    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]
> > [    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> 1:24003008      2:0     3:0]
> > [    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > [    2.283634] smpt_read[5] addr[00000004], data_byte[00000000]
> err:00000000
> >
> >
> > [    2.290412] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16 i=3D:=
6
> > [    2.296496] End [addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065] ReturnVal:00000000
> > [    2.305444] spi_nor_parse_smpt:3065
> > [    2.308924] m25p80 spi0.0: failed to parse SMPT (err =3D -22)
> >
> >
> > >
> > > Next thing you can do is read the CR2NV reg (using the RDAR command)
> > > and check the RL (Read Latency) and AL (Address Length) values.
> >
> > Please let me know how to read CR2NV register.
>=20
> Actually, RDAR is already what you use to read the map_id, and we need to=
 use
> it to read the register that contains the number of dummy cycles and the =
number
> of address bytes to use for RDAR operations. Looks like we have a chicken=
 and
> egg situation here :-).
>=20
> Let's try something else:
>=20
> 1/ create an u8 array of 16 entries named data_bytes
>=20
> for each loop iteration (the first for loop):
> 2/ set ->addr_width to 3 and ->read_dummy to 0 3/ call spi_nor_read_raw(n=
or,
> addr, ARRAY_SIZE(data_bytes), data_bytes) 4/ dump the data_bytes buf 5/ s=
et -
> >addr_width to 4 6/ call spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_byte=
s),
> data_bytes) 7/ dump the data_bytes buf
>=20
> If the SPI driver is working correctly, we should be able to figure out t=
he right
> value for ->addr_width and ->read_dummy.
>=20

Ok, I would try with the suggested change.
But till the point we not able to figure out actual failure reason can we h=
ave below changes pushed-in

@@ -3139,6 +3177,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
                switch (SFDP_PARAM_HEADER_ID(param_header)) {
                case SFDP_SECTOR_MAP_ID:
                        err =3D spi_nor_parse_smpt(nor, param_header);
+                       if (err) {
+                               dev_warn(dev,
+                               "failed to parse SMPT (err =3D %d)\n",
+                               err);
+                               /*
+                                * SMPT parsing is optional, let's not drop
+                                * all information we extracted so far just
+                                * because it failed.
+                                */
+                               err =3D 0;
+                       }

--
Regards
Yogesh Gaur.
=20
> Thanks,
>=20
> Boris
