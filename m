Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E44CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EE72084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IaXzOQKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EE72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeLJL0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:26:41 -0500
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:42443
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeLJL0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iifPecrc5rcI9plxnmpcWAC9fBqBKmozW/pDurNwLnQ=;
 b=IaXzOQKsN0MHsCAXjkWGMKhsNLZrH++Ul+doEdywAD+nagvNdhzC4BKgARjxNZ/+pLUMBbB46vaVpaijRTA38/NTvzE00ndXCse1dz9DflYY0pjiHwQQIQ0ys6hZyfB6l6khWsuZb1UY9kkJR67o7vVKH6Clww3OPtTaoS87CTw=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB1312.eurprd04.prod.outlook.com (10.162.121.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 11:25:55 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 11:25:55 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUfZ10PwLsFrd7X0a81BAspcUxiKVxj0sAgAZCwzCAABZKgIAAALyggAAH5ICAAAC6EIAABLGAgAADIQA=
Date:   Mon, 10 Dec 2018 11:25:55 +0000
Message-ID: <VI1PR04MB57269A32C1FF1592F117B97799A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210111909.35384eee@bbrezillon>
        <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210115001.6c7af1d7@bbrezillon>
        <VI1PR04MB5726F0DDAC84F1AEC20B56DF99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210120925.3c6336f6@bbrezillon>
In-Reply-To: <20181210120925.3c6336f6@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1312;6:3DwW/KgV+umXoiZBJkXGl+7Vt93nEv2BB3FbVmfyCxxH+CftHVbPbnbpSMW4UDsMkzwQzvA1PL8IB8vlqnnW/TuKGOpirS+39ZgpfDfAL0kibYRH0WXVvh4lESLacAB436QRC7HZWSQKb2l/QwqR0hpEYlNg8+BkcJDxg9lNPkaU/jGN6gkpcgV5P9tdUwVfDE/99IDS5lmMqM7oaAWv91NIBv7ymYd0AfsReEFt1mtij7fQxTikssKbga5CbVOojq9mn1p5rw+5qCSPvczhN/tvGhu8c7O31lSpR/eg2Irq+S0LTgLg5SxorS48j4GRRpR+rEarGucdsiA42tYUag2W9ZGDGj9/0XXgLxVe63bhsGAOdUSB42vPCWyPxGmmCSnimbhdLhK5IayyJR/hETkUl6qhYdKGQ7v7Sx5RKbBstmS7adqvfeFIsvjYrsTCnhOTxXywlecuoWEkU63+70kQOnZ/yq+U1g7RKjZfbl0=;5:QU1WcahuZ3v25i0QO0R6uXoCob/rDWEwbNiH4uFRRs9z7rQZQIPjeGBJz4zB8w9RXVRKkxy3rnCSioowzY710vjV9cNqxproSIGyr7wNrdXV1utEqABUaEsNBzjgwRxxj2dro3wOt7H7GYktj1ZLzeJKyTpvJAceGTBsbdBN96o=;7:f8mY0yKcmzoojqiRd/oyqkBeqo6h164n9IAKzk5lskHHEVRhue//KYMDhXBTcM8v5XaLYcTfizDzyxBgD7B1AzudjP7SUo+uMbwMkvcDcOpqhJoi6p2T4zqfNq5CAgHTUCVsjF6F7IfaK9gZebW2PA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 621f0ad3-b3e4-4c85-e63b-08d65e924030
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1312;
x-ms-traffictypediagnostic: VI1PR04MB1312:
x-microsoft-antispam-prvs: <VI1PR04MB131242E7338A8DB34F19166899A50@VI1PR04MB1312.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1312;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1312;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39860400002)(346002)(13464003)(189003)(199004)(5660300001)(2906002)(33656002)(93886005)(229853002)(6916009)(76176011)(7696005)(446003)(11346002)(99286004)(14454004)(68736007)(78486014)(25786009)(6116002)(186003)(55016002)(3846002)(8936002)(8676002)(81156014)(81166006)(55236004)(26005)(6436002)(6506007)(53546011)(102836004)(74316002)(39060400002)(106356001)(6246003)(478600001)(316002)(4326008)(86362001)(9686003)(53936002)(54906003)(7416002)(105586002)(305945005)(71190400001)(71200400001)(486006)(7736002)(66066001)(476003)(97736004)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1312;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LtAa9nW95tatN0l59/JO4EW+DzX7Xhp4Igd5Py980cUs8SyVfAQvwwRaMKe37TdNCqz4jO6yH/TjaXKaco+QbtLf7ZfT0HXhkY3l0D6F+df+nIH2QTWZAFVJy2QdTrdMyuncb42XxrxKsLVxhDQXueReum0NaJsx4UVUn/bwj5qpcSgdlnt1jkzUT9vbbcRK66dYMISnzaOSul3tyojRX+JNkzBdnWlc2hBXnF+qkBcv5j5jmtW92wyio6DAgriZoOxUwVLWzd4tbeX9HktokPD2UvlttLEe4mSYf0o4gPVWU1/74qH+Rql87cVIOYYY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f0ad3-b3e4-4c85-e63b-08d65e924030
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 11:25:55.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 4:39 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; broonie@kernel.org; linux=
-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> On Mon, 10 Dec 2018 10:59:54 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Monday, December 10, 2018 4:20 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; linux-
> > > mtd@lists.infradead.org; marek.vasut@gmail.com; broonie@kernel.org;
> > > linux- spi@vger.kernel.org; devicetree@vger.kernel.org;
> > > robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > linux-arm- kernel@lists.infradead.org; computersforpeace@gmail.com;
> > > linux- kernel@vger.kernel.org
> > > Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
> > > controller
> > >
> > > On Mon, 10 Dec 2018 10:43:56 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > > > > > Thus, in LUT preparation we have assigned only the base address=
.
> > > > > > Now if I have assigned ahb_buf_size to FSPI_FLSHXXCR0 register
> > > > > > then for
> > > > > read/write data beyond limit of ahb_buf_size offset I get data co=
rruption.
> > > > >
> > > > > Why would you do that? We have the ->adjust_op_size() exactly
> > > > > for this reason, so, if someone tries to do a spi_mem_op with
> > > > > data.nbytes > ahb_buf_size you should return an error.
> > > > >
> > > > Let me explain my implementation with example. If I have to write
> > > > data of size
> > > 0x100 bytes at offset 0x1200 for CS1, I would program as below:
> > > > In func nxp_fspi_select_mem(), would set value of controller
> > > > address space
> > > size, memmap_phy_size, to FSPI_FLSHA2CR0 and rest all FSPI_FLSHXXCR0 =
as
> 0.
> > > > Value of memmap_phy_size is 0x10000000 i.e. 256 MB for my
> > > > LX2160ARDB
> > > target.
> > > > Then in nxp_fspi_prepare_lut(), I would prepare LUT ADDR with
> > > > address length
> > > requirement 3/4 byte for NOR or 1/2/3/4 bytes for NAND flash.
> > > > Also for LUT_NXP_WRITE would program data bytes as 0.
> > > >
> > > > Then inside func nxp_fspi_do_op(), set register FSPI_IPCR0 as the
> > > > address offset i.e. 0x1200 and in register FSPI_IPCR1 program the
> > > > data size to write i.e. 0x100
> > > >
> > > > If, as suggested if I tries to mark value of register
> > > > FSPI_FLSHA2CR0 equal to
> > > ahb_buf_size (0x800), then access for address 0x1200 gives me wrong
> > > data. This is because as per the controller specification access to
> > > flash connected at CS1 can be performed under range of FSPI_ FLSHA1CR=
0
> and FSPI_ FLSHA2CR0.
> > >
> > > Don't you have a way to set an offset to apply to the address
> > > accessed through the AHB? And if you don't, how will it work if your
> > > mapping is smaller than the flash size?
> >
> > Write operations are triggered using IP commands instead of AHB command=
.
> > For Read AHB command is used and in this we are adding the offset when
> performing memcpy_fromIO operation
> >       memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val),
> > len);
> >
> > AHB/IP operations are independent of the way how CS got selected. CS
> selection depends, e.g. CS1 on the value of register FSPI_FLSHA1CR0 and
> FSPI_FLSHA2CR0.
> >
> > Mapping can never going to be smaller than the connected flash size as =
per
> discussion with the Board design team and if it's possible by user manual=
ly
> changes the non-soldered part then flash area beyond complete mapping is =
not
> accessible.
> > On LX2160ARDB, with mapping of 256MB, for now we are having 4 flash
> devices connected with size as 64 MB. If user wants he can have only one =
single
> flash with flash size of 256MB.
>=20
> Given that the dirmap interface has now been merged and the MTD side of
> things is soon to be merged, I'd recommend you to implement it in your
> v6 and only use non-AHB accesses for the ->exec_op() implementation.

This would going to be performance hit if I would use non-AHB accesses for =
->exec_op().
In read in v5 I am using AHB mode for read if read data size is greater tha=
n rxfifo size and if its less than rxfifo then use IP mode for read.

--
Regards
Yogesh Gaur
