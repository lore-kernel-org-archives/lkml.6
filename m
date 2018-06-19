Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB37C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD272083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KPsRcFPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD272083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755844AbeFSHKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:10:43 -0400
Received: from mail-ve1eur01on0060.outbound.protection.outlook.com ([104.47.1.60]:1056
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750961AbeFSHKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR9FK6clt3/GgRQo+ZyvCwYIWsWNiw9x+KoUbHFCUP0=;
 b=KPsRcFPoLbchXmORBnng/Cdela/o7d5nSLY036Pq4FJTl+V9HwYYOVkR9avokPyzHGC8erfSbEM7c8snykF8rZAF1DAvd7aFp0veXDzxDTwQ8dQSSCT+Y3W7RjplLaMzPdebbARGWNJdI8u/swWHqZ3ziQgOs48KpSgWg7aVXpI=
Received: from VI1PR0402MB2845.eurprd04.prod.outlook.com (10.175.23.138) by
 VI1PR0402MB3869.eurprd04.prod.outlook.com (52.134.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 07:10:37 +0000
Received: from VI1PR0402MB2845.eurprd04.prod.outlook.com
 ([fe80::ec9c:93f4:5969:7adb]) by VI1PR0402MB2845.eurprd04.prod.outlook.com
 ([fe80::ec9c:93f4:5969:7adb%4]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 07:10:37 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSwgAFUQ+CAAAoIAIAAGBOggAT9CYCAAATqYIAADVmAgASumwCAAGHGAIAAwy3A
Date:   Tue, 19 Jun 2018 07:10:37 +0000
Message-ID: <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615155541.4f43e9bb@bbrezillon>
        <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180618211536.0bf44f55@bbrezillon>
In-Reply-To: <20180618211536.0bf44f55@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3869;7:1TKtUK6JGTHByga6TDodUVy5aQylMPXzMRTvDa5sB8R8dNPoskduPXja5fi6qG1CvtuDYMlPa/+m0ohJAJvp6x0fan1kYUHiRM9DjE1HEetXCMWZ2/IRx1O5nSwWqblRF7SuN6hy1ZlJPx1/0TOZLDUbpgLnWCtIUDINZeqBhyAw/t/Wpi5QdR2rtCOH3BWkGk3HQiWEf8aTUXsyaGowyptBO5py7kHfBtpJ16CoZmXLYWt66KKNi1cja5um0AVG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ba306319-60da-47fe-810e-08d5d5b3c203
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3869;
x-ms-traffictypediagnostic: VI1PR0402MB3869:
x-microsoft-antispam-prvs: <VI1PR0402MB38698BFF80239090751754B599700@VI1PR0402MB3869.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(264314650089876);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0402MB3869;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3869;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39380400002)(39860400002)(396003)(376002)(13464003)(189003)(199004)(316002)(33656002)(551984002)(105586002)(106356001)(3280700002)(7736002)(6436002)(74316002)(6116002)(3846002)(305945005)(81166006)(8676002)(54906003)(486006)(446003)(476003)(11346002)(186003)(8936002)(229853002)(81156014)(3660700001)(99286004)(93886005)(2906002)(4326008)(7696005)(59450400001)(6506007)(53546011)(55236004)(26005)(97736004)(102836004)(76176011)(14454004)(55016002)(25786009)(39060400002)(53936002)(9686003)(6246003)(478600001)(6306002)(5660300001)(966005)(7416002)(6916009)(5250100002)(68736007)(86362001)(66066001)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3869;H:VI1PR0402MB2845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WVwNEDXJoareSHqg6qWIHVxQYFldsTp5NrnA3soK7RfAmyFBTx6YJYKcTwWqwLWdMfSfpKGf0+0oNbgRlF5rdzIJkrSvwbph4IYh5/POk7S3FlZ41y+NR41kYld9BWFd8vp+8HY1ntNvFUuXwN5v3KwHaAqdD9mH2Rh63tbd21Y/1jhJeG8ryXjqy8kDlZEpGSYBCWLZ5zEa2YoNsYNZD9bvH8uC3Crf7js90l13cJw6/VsBU+L9KDR8QkOXLyI+U48ehd7I7ucPLZcAMvbmu2Kek1zzLEjzHdLT8noM3Ilw/B53AdK73SoglfMdsZPRHDdGoxKFm5GxcLTBmdIOgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba306319-60da-47fe-810e-08d5d5b3c203
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 07:10:37.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Tuesday, June 19, 2018 12:46 AM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com=
>; dwmw2@infradead.org; richard@nod.at; Prabhakar Kushwaha <prabhakar.kushw=
aha@nxp.com>; Han Xu <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-=
spi@vger.kernel.org; marek.vasut@gmail.com; Frieder Schrempf <frieder.schre=
mpf@exceet.de>; broonie@kernel.org; linux-mtd@lists.infradead.org; miquel.r=
aynal@bootlin.com; computersforpeace@gmail.com
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

Hi Yogesh,

On Mon, 18 Jun 2018 13:32:27 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Friday, June 15, 2018 7:26 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Fabio Estevam=20
> <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>;=20
> dwmw2@infradead.org
> Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>;=20
> Han Xu <han.xu@nxp.com>; linux-kernel@vger.kernel.org;=20
> linux-spi@vger.kernel.org; marek.vasut@gmail.com; Frieder Schrempf=20
> <frieder.schrempf@exceet.de>; broonie@kernel.org;=20
> linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com;=20
> computersforpeace@gmail.com
> Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP=20
> QuadSPI controller
>=20
> On Fri, 15 Jun 2018 13:42:12 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Boris,
> >=20
> > I am still debugging the issue.
> > With some analysis, able to check that proper values are not being writ=
ten for QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD register.
> >=20
> > In current code, value of map_addr are being assigned to these register=
.
> >              map_addr =3D q->memmap_phy +
> >                         2 * q->devtype_data->ahb_buf_size;
> >=20
> >      qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
> >=20
> > But instead of "q->devtype_data->ahb_buf_size" it should be flash size.=
 =20
>=20
> No, because we're only using 2 * ->ahb_buf_size in the direct mapping for=
 each device, and we're modifying the mapping dynamically based on the sele=
cted device. Maybe we got the logic wrong though.
>=20
> Yes, for register QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD, we need=
 to save starting actual address from where this flash is getting started.
> Thus, if my first flash size is 64MB, then register QUADSPI_SFA2AD=20
> would have value of q->memmap_phy + 0x4000000 i.e. (QUADSPI_SFA1AD + size=
of First Flash) If second flash is of size 32MB, then register QUADSPI_SFB1=
AD would have value of value of QUADSPI_SFA2AD + sizeof second flash.

Again, no, that's not what I'm trying to do, and the fact that it worked fi=
ne with CS0 makes me think you don't need to map the whole device to get it=
 to work, just 2 * ->ahb_buf_size per device.

>=20
> > For my case flash size is 0x4000000 and with this hard coded value I am=
 able to perform Write and Erase operation.
> > One more change, I have to do is adding the flash_size when writing the=
 base_address in SFAR register for case when "mem->spi->chip_select =3D=3D =
1"
> > 	qspi_writel(q, q->memmap_phy + 0x4000000, base + QUADSPI_SFAR);
>=20
> I don't want to expose the full device in the direct mapping yet (that's =
part of the direct-mapping API I posted here [1]). What this version of the=
 driver does is, map only 2 time the ahb_size so that we can bypass the int=
ernal cache of the QSPI engine.
>=20
> To perform any operation on second flash, we need to provide it's base ad=
dress should be saved in SFAR register for this particular operation.

That's what we tried to do, we tried to make all CS start at 0 when they ar=
e used and declare unused CS at having a size of 0.

So, say you're trying to access CS1, you should have the following
ranges:

CS0: 0 -> 0 (size =3D 0)
CS1: 0 -> 2 * ->ahb_buf_size (size =3D 2 * ->ahb_buf_size)
CS2: 2 * ->ahb_buf_size -> 2 * ->ahb_buf_size (size =3D 0)
CS3: 2 * ->ahb_buf_size -> 2 * ->ahb_buf_size (size =3D 0)

now, if you're trying to access CS3:

CS0: 0 -> 0 (size =3D 0)
CS1: 0 -> 0 (size =3D 0)
CS2: 0 -> 0 (size =3D 0)
CS3: 0 -> 2 * ->ahb_buf_size (size =3D 2 * ->ahb_buf_size)

maybe this approach does not work, but that's not clearly stated as 'not su=
pported' in the datasheet.

> Exposing only 2 time of ahb_size is design decision but value in SFAR reg=
ister should be correct.
>=20
> >=20
> > Thus, there should be mechanism or the entry in structure where we can =
have the information of the size of the connected slave device. =20
>=20
> Because that's exactly the kind of thing I'd like to avoid. What if the d=
evice is bigger than the reserved memory region? What if the sum of all dev=
ices does not fit in there? Here I tried to support all cases by just mappi=
ng the portion of memory we need.
>=20
> So IMO, there should be mechanism to have value of start address of each =
slave device. This might can be done from DTS entry of each slave device co=
nnected to the controller.

Let's not put that in the DT. If we really can't re-use 0 as the start addr=
ess and make some ranges 0 in size, then let's reserve 2 *
->ahb_buf_size per chip, and be done with it.

This should leave us enough space in the AHB mem range to then support temp=
orary direct mappings through the direct mapping API.

Let us take below layout of memory address space map.
QuadSPI Controller can access range from 0x2000_0000 - 0x2FFF_FFFF i.e. 256=
 MB address space reserved and it is having 4 slave devices connected.
These slave devices[of size 64MB, 64MB, 32MB and 64MB ] are connected at be=
low address
0x2000_0000, 0x2400_0000, 0x2A00_0000, 0x2C00_0000
i.e. there is gap of 32MB from 0x2800_0000 to 0x29FF_FFFF.

As per my understanding of the controller, flash XX top address, register s=
hould have below values:
  QUADSPI_SFA1AD - 0x0
  QUADSPI_SFA2AD - 0x400_0000
  QUADSPI_SFB1AD - 0xA00_0000
  QUADSPI_SFB2AD - 0xC00_0000
And Register QUADSPI_SFAR should point to the range for the flash in which =
operation is happening.

Please check Table10-32, page 1657, in [1] for more details on flash addres=
s assignment.

But say if I assign address to register QUADSPI_SFA2AD as "0 + 2 * ->ahb_bu=
f_size" then this address value is not correct as per the value range expla=
ined in above mentioned table.

Regards
Yogesh Gaur.

Regards,

Boris

[1] https://www.nxp.com/docs/en/reference-manual/VFXXXRM.pdf

