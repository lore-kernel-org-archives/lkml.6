Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33AC2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q5PrVge/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33AC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeIEOgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:36:45 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:53536
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbeIEOgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKcJkTnwk7ZCztZkUBJZIUF376LctxpAYK7YJdRE+YQ=;
 b=q5PrVge/lwk8P75uYatxUTQMqq869B8uHwVI0l2gfMH/MsxdluaXklFGogMQaSuDWBMElgfUZH/VCYMcfu/w0Lpx2XqETvh/Xbw5jZ1qLe3EO2k3EPPJo4uIhHdTmU59dSBts0FPJlcQZ15/I5Aczm2mtC7R9qVQ8ND3pLgc9/I=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 10:07:10 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5%6]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 10:07:10 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
Thread-Topic: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI
 controller
Thread-Index: AQHUQRXg7xCIqf0FokqnnQfU8ng4SqTgPV4AgAExaGA=
Date:   Wed, 5 Sep 2018 10:07:10 +0000
Message-ID: <VI1PR04MB1038CE65EF4E98ACBEA9990B99020@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180904165842.774ed960@bbrezillon>
In-Reply-To: <20180904165842.774ed960@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4845;6:dyt6rsnyQcMzukJvrEAXtZIz79924jJ3psujKfd6RkjCYyRF+6mgWuq5izpBMOCyHxBCoNZvvZh8+t3qviRI04QwB8qGPLM/43uS7MOuP3u7PBkl7GZOUjBzjBiJWcv/VRUllrQHpqAttSofV4tcYAI2p6z3uwBgZ24Yo42ig3P1mbU/zsYoCCKxxJkJw47ReWD6TJt4+OMoe5ilqMtKHWksjSVbAdr5ze3N1U/FfNpgcXeS5PoM7TTBv6IQZd/IrRkCwluBPkxOkSAi0Fh8wKTGxjEb6hTSohtnKbi3pCotPVSGyki5BiJR+mFYHcKYMwBykC+DJmbGJ7pzphnfq2DBVLQCkEzI0SNMMfLYbPZdWnvoIaAOv6/3PccvM2UiH4qZtyi6ZKDjAfVi7uOuhiWOdoYuuULydAonPxxHTxiOPbOcjEapKAfaPWBDJ7pq0f9EZmlq2BUUDABX33BwuA==;5:w0L6khFwZc/GPOW95LyB+WqHf0SawCgMZUtxJbPChj6yrPI0Hnoa5VF/CAo5OqR2HG7v3o7Xebk+9BiPtEQMZiaGgvgWrgETdPfmw4NaHwuFYpt5yRhLUWhyh/ORJVW6+QHGJKcO/4w3fpN19FIU4HLeIy0d5GX1R15SN+CihDU=;7:gqLfv12BobOebVVD2AFCyaC/hx6RPtZDtgd8/F9mkdJWmx0869IFGnTq16RU7TgDRq+QfgyCoZTolULob5pyKixHUix8JMFbGAW8lIdu2eXxI50yxagXG88JEigVMrLkB5JB066Gr4hAqmqM5o8XNeJlnNZzD0PV77f5lKX0n5yPGVpbLVuwHB4Qr6/udeimET7ncH7k8Odvn4NZ43KIvmRJu74c0IGxXZdTNVz3Z9/2r/UEEInHoo+Su1aFsdh0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1ee3ee49-1682-4768-8869-08d613175815
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4845;
x-ms-traffictypediagnostic: VI1PR04MB4845:
x-microsoft-antispam-prvs: <VI1PR04MB484598D2D8872A78B3B9B10C99020@VI1PR04MB4845.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(264314650089876);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR04MB4845;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4845;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(189003)(199004)(81156014)(55016002)(4326008)(2900100001)(25786009)(6506007)(53546011)(54906003)(5660300001)(229853002)(6436002)(316002)(33656002)(305945005)(6916009)(7736002)(74316002)(76176011)(7696005)(99286004)(39060400002)(7416002)(6246003)(68736007)(26005)(86362001)(478600001)(5250100002)(476003)(486006)(3846002)(6116002)(966005)(106356001)(186003)(105586002)(9686003)(97736004)(11346002)(2906002)(53936002)(66066001)(55236004)(81166006)(256004)(14454004)(8676002)(14444005)(102836004)(6306002)(8936002)(446003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4845;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tEwrsYKqA33ASdICVPgFFos1/5MYdOoG9wzmQY+s1ot7z7nU6Wjt4Z08JvQQBDmnC4fMaLmwUYeRVAwZHFq1cwGY10MVTJ4nQLpdlZYbwxnUIzEKvOCHeIAF1l3DJrAz7Z9WwvDSlaAyX1DX4FzOjC6bXEaJSw5AZaNcVmnxnOR9MkhmsbD53YHyWQjhjeASuteEuaJfXdX6MQsbcIm0wSjoKTmtvrjjFLOVID+zS2Uqq2LPmoMjwk+AEqdXo/kdgToM6j9HQxL2LQ7h6ZhxVQDKD48uXyCxMLgTXVsRSgfjujnT5MzM7V2FdXZXgk2LyV/78IU1QBTVmErIRuQzWREtjQqmP9YTsPkOOn4rsmc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee3ee49-1682-4768-8869-08d613175815
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 10:07:10.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, September 4, 2018 8:29 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI contr=
oller
>=20
> Hi Yogesh,
>=20
> On Fri, 31 Aug 2018 16:00:00 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > - Add a driver for NXP FlexSPI host controller
> >
> > (0) What is the FlexSPI controller?
> >  FlexSPI is a flexsible SPI host controller which supports two SPI
> > channels and up to 4 external devices.
> >  Each channel supports Single/Dual/Quad/Octal mode data  transfer
> > (1/2/4/8 bidirectional data lines)  i.e. FlexSPI acts as an interface
> > to external devices,  maximum 4, each with up to 8 bidirectional data
> > lines.
> >
> >  It uses new SPI memory interface of the SPI framework to issue flash
> > memory operations to up to four connected flash chips (2 buses with
> >  2 CS each).
> >  Chipselect for each flash can be selected as per address assigned in
> > controller specific registers.
> >
> >  FlexSPI controller is similar to the existing Freescale/NXP QuadSPI
> > controller with advanced features.
>=20
> Yep, I had a quick look at the code and they really look similar. Why not
> extending the existing driver instead of creating a new one from scratch?
>=20

FlexSPI is different controller not related to the QuadSPI controller in it=
s working behavior
Both these controller are having
* Different registers name, registers address, registers functionality etc,=
 section 30.5.2[1]
* Different programming sequence for initialization of the controller, sect=
ion 30.8.1[1]
* Different programming sequence for performing Read and Write operation us=
ing IP, section 30.7.9[1] and AHB mode
* Different programming sequence for checking controller current state like=
 busy or not=20
* New mechanism to program for the connected slave device i.e. flash access=
 mode and flash memory map 30.7.4[1] and 30.7.5[1]
* New entries added for FlexSPI controller for LUT_XX mode for various comm=
ands, section 30.7.8[1]

There are few similarities between these two like LUT programming logic is =
same
i.e. LUT needs to be programmed in same sequence of 'INSTR  PAD  OPCODE', b=
ut again LUT register address and LUT command mode values are different.

Creating common driver for both FlexSPI and QuadSPI controller, would invol=
ve creation of one more layer between driver/spi/spi-xxx and the actual con=
troller driver, this layer would going to have less functionality like doin=
g LUT creation programming and then would re-direct calls to the respective=
 controller driver functionality to perform desired programming sequence.

> >
> > (1) The FlexSPI controller is driven by the LUT(Look-up Table)
> > registers.
> >  The LUT registers are a look-up-table for sequences of instructions.
> >  A valid sequence consists of four LUT registers.
> >  Maximum 32 LUT sequences can be programmed simultaneously.
> >
> > (2) The definition of the LUT register shows below:
> >  ---------------------------------------------------
> >  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
> >  ---------------------------------------------------
> >
> >  There are several types of INSTRx, such as:
> >  CMD     : the SPI NOR command.
> >  ADDR    : the address for the SPI NOR command.
> >  DUMMY   : the dummy cycles needed by the SPI NOR command.
> >  ....
> >
> >  There are several types of PADx, such as:
> >  PAD1    : use a singe I/O line.
> >  PAD2    : use two I/O lines.
> >  PAD4    : use quad I/O lines.
> >  PAD8    : use octal I/O lines.
> >  ....
> >
> > (3) LUTs are being created at run-time based on the commands passed
> > from the spi-mem framework. Thus, using single LUT index.
> >
> > (4) Software triggered Flash read/write access by IP Bus.
> >
> > (5) Memory mapped read access by AHB Bus.
>=20
> Do we really want to have this level of details in the commit message?
> I mean, this is something you can document in the driver, but not here.
>=20
> BTW, you might want to have a look at [1]. I think we can get rid of the =
->size
> field you're adding if this driver implements the dirmap hooks.
>=20

I need size information for the connected device to program the controller =
register FLSHXXCRO as Flash Chip select is determined by flash access addre=
ss and Flash size setting in register FLSHXXCR0[FLSHz], section 30.7.9[1].

Link for reference of the driver implementing dirmap hooks was missing in m=
ail, please share.

> >
> > (6) Tested this driver with the mtd_debug and JFFS2 filesystem utility
> > on NXP LX2160ARDB and LX2160AQDS targets.
> >  LX2160ARDB is having two NOR slave device connected on single bus A
> > i.e. A0 and A1 (CS0 and CS1).
> >  LX2160AQDS is having two NOR slave device connected on separate buses
> > one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >  Verified this driver on following SPI NOR flashes:
> >     Micron, mt35xu512ab, [Read - 1 bit mode]
> >     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
>=20
> Ok, that's good to have in the commit message.
>=20
> >
> > - Add config option entry in 'spi-nor/Kconfig' for FlexSPI driver.
>=20
> But this one is useless. If you add a new driver, you have no other choic=
e but to
> add a new entry in the Kconfig file.
>=20
> >
> > - Add entry in the 'spi-nor/Makefile'.
> >
>=20
> Ditto.
>=20
> Before you re-send a new version, I'd like to understand why you think yo=
u need
> to create a new driver, and I want you to try to implement the dirmap hoo=
k and
> check if you can get rid of the ->size field when doing that.
>=20
> I also seem one extra benefit to having a single driver for both FlexSPI =
and
> QuadSPI IPs: you'll help Frieder debug the last remaining problems you re=
ported
> on the new QuadSPI driver :-P.

Regarding testing of the QuadSPI driver on spi-mem framework, I have alread=
y given suggestions to the Frieder and my local changes using which flash c=
onnected at CS0 and CS1 starts working for read/write/erase commands on ls1=
088ardb target.

Current v2 which has been shared, data operation for the slave flash device=
 connected at CS1 is not working.
I have to make changes for the calculation of flash base address for the re=
quested chip select and changes in address remapping the buffer in AHB read=
 case for CS1 access to work.

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf

--
Regards
Yogesh Gaur

>=20
> Thanks,
>=20
> Boris
