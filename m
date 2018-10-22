Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63068C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0336A20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pZA4r2ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0336A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeJVUJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:09:33 -0400
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:15648
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727669AbeJVUJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJvrrt/pJ7orQuX7qf9X2JvSINdcwlT9dVoPmGp0anM=;
 b=pZA4r2ceZvBUs62I+1u3+6LvtC9CTiS7cYG9b1QQIHPyveOqqYgP4r3G5kamCrh1yek4y+gxhRl/bvbv/zZtO0MCyMEVQ7SzEDlmlNkgNoVw4E1di1TiKmAQRA6t3WcL3cafFbt30tBEnq1YtE0PFXN5ErC65qou1SopqoOWmdI=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB3216.eurprd04.prod.outlook.com (10.170.227.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 11:51:14 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 11:51:14 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUYVGd5DVkmoaJwk6a/YXF+Itp3qUrNb6ggAACaYCAAAA1sA==
Date:   Mon, 22 Oct 2018 11:51:14 +0000
Message-ID: <VI1PR04MB1038664FB0B2AF911593137099F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR04MB1038034CFABEE936C6892D7D99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022135015.1b13cdbd@bbrezillon>
In-Reply-To: <20181022135015.1b13cdbd@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3216;6:hRHqd8Bf8HnwC1A3wTnSJW2BoErsfnjqX3p+8JVTNXTOlGQBq37CiMEOJ/8qUs3xCYRfmuECmI6MQUSA0vXBuw/HIm7FjiTgf13maqy7hdwy4S3nShk1OShOJfsJzZI4T9syIaO02Z1bz+ghiEh7swa9vXcLPN1x4L8HfkOXztpqtk81CqIuDwOkzymNFr6sZTAAjpgv3n/rzsa+oJMxKXgEgJyfZtSW+VABBCSWhnruljwRd1cbA80qv7Xyh04yJW6wCRpzqdcu9DZ+k6RFVUIPibxLQ898n4dTjjm3Y/ES+a1t9/8TI7e2diIsmDU4oNYQO18LTwuuCrBU7rxa9yPHo6VplPvDs3xBnZ5l7BAXMZLsMX1YajsHUB79FxBEMyrGrsVDuVP0G+4fkCZZfOCwL1YAbry+T0BF4TQZxrsAYVdpTzntNg80Axpav/65VK8WPky4fiNJ5XMWs2EPBA==;5:lPDEvjVuxxtX1ta76uC92MsJnu4hCMVegpIM4wnmZ2cGUM4NPJRMzMRqKSbfc3oZYCTW+x+s7zG4LxBMSwyu7aGp6ReS6IZ/AlCDiNvrXet4f+KLKmKPGTX5Ztmr77ct6IgE7I88UfIjs92QQc5KgdYtQQsR22+oMnsCkwdSNJ4=;7:Vg6+10TYjUYBnhIkHqDGyk+IMEXoVYCOhMkYDnQrRWCUmeFuCr0/tXYHrnUru1IBRQeFdEyegt1fmw1X7PQgRG3eBiwZk29MVJTOugPZ02HFkdS/U+8iL3McsElII6S7OP/PtFKU7QDPkvKEkMGE5E7Cj7pyhvMR2et5tuDf6ZSewY1ApAUWHON9L2OTNrVs7iBppt0Ns/gU5Oo/hWfVMr+OlRegbOjJQYW/64cqcJD45G3YSWPJki+I1UKjYFg9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 40e41f01-755c-49fd-b68f-08d63814ab48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3216;
x-ms-traffictypediagnostic: VI1PR04MB3216:
x-microsoft-antispam-prvs: <VI1PR04MB3216DB85024B26C358A02D5099F40@VI1PR04MB3216.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(9452136761055)(180628864354917)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3216;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(13464003)(199004)(189003)(102836004)(71200400001)(55236004)(53936002)(6916009)(53546011)(446003)(8936002)(4326008)(6246003)(966005)(33656002)(39060400002)(6506007)(14454004)(68736007)(2900100001)(5660300001)(25786009)(6116002)(3846002)(478600001)(45080400002)(256004)(78486010)(106356001)(105586002)(7736002)(26005)(305945005)(5250100002)(66066001)(97736004)(2906002)(54906003)(7416002)(9686003)(7696005)(76176011)(186003)(6306002)(99286004)(86362001)(55016002)(229853002)(74316002)(316002)(11346002)(71190400001)(81166006)(81156014)(6436002)(486006)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3216;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tgkVLrAqbgmmPNqzMVHdl9P6WmFldw084OaVDPD8SDjqxm9Uqk5RKxCBiOAVwhvtgMSpCXeLab5Slrk9rsitIWzlGvrrZG/cJQkJ/YZB39WT98YTnusOyS/+1/7JLPZ79/uI21F+GbF4dCMmljsO2zeu5w4CehFjUU4mwIigNC9Jtj4ANjfRMpvywgYEsbSC6sjUFQ+NBq2YRhuH0JyKhQiSGP6aNxyoUbTbgHU+N7gOrIPl1EaRYRBaG3D5yAoVz+xrxjMI+BdNWmuoEeZQsUPU3/o06asRwn/MhojtvDO1fg7q+9cOUy7NrKVkNBEdPBPSy28ROYhCPr1SA3+XfPsPW3r9m87P5GS99k/jAZ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e41f01-755c-49fd-b68f-08d63814ab48
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 11:51:14.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 5:20 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; Mark Brown
> <broonie@kernel.org>; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> On Mon, 22 Oct 2018 11:43:40 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > + Mark Brown
> >
> > Complete patch series[1]
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
t
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D70210&amp
> > ;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a816c9049d3d
> 49b08d
> >
> 638148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636758058
> 298796
> >
> 837&amp;sdata=3DbRHDHAFzwrbeATicJUpv2WpFnxaeAD%2BnVHLAmsXKbKI%3D
> &amp;res
> > erved=3D0
>=20
> Please resend the patch series with a "PATCH RESEND v4" prefix and explai=
n why
> you resend it in the cover letter.
>=20
Ok, sure.

Thanks

> >
> > --
> > Regards,
> > Yogesh Gaur
> >
> > > -----Original Message-----
> > > From: Yogesh Narayan Gaur [mailto:yogeshnarayan.gaur@nxp.com]
> > > Sent: Thursday, October 11, 2018 4:30 PM
> > > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org
> > > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > linux- arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> > > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
> > > controller
> > >
> > > - Add driver for NXP FlexSPI host controller
> > >
> > >  FlexSPI is a flexsible SPI host controller [1], Chapter 30 page
> > > 1475,  which supports two SPI channels and up to 4 external devices.
> > >  Each channel supports Single/Dual/Quad/Octal mode data transfer
> > > (1/2/4/8 bidirectional data lines)  i.e. FlexSPI acts as an
> > > interface to external devices, maximum 4, each with up to 8  bidirect=
ional
> data lines.
> > >
> > > - Tested this driver with mtd_debug(Erase/Write/Read) utility and
> > > JFFS2 filesystem mounting and booting on NXP LX2160ARDB[2] and
> > > LX2160AQDS targets.
> > >  LX2160ARDB is having two NOR slave device connected on single bus A
> > > i.e. A0 and A1 (CS0 and CS1).
> > >  LX2160AQDS is having two NOR slave device connected on separate
> > > buses  one flash on A0 and second on B1 i.e. (CS0 and CS3).
> > >  Verified this driver on following SPI NOR flashes:
> > >    Micron, mt35xu512aba[3], [Read - 1 bit mode]
> > >    Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> > >
> > > [1]
> > > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
w
> > > ww.nxp.com%2Fdocs%2Fen%2Freference-
> manual%2FIMXRT1050RM.pdf&amp;data
> > >
> =3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a816c9049d3d49b08
> d638
> > >
> 148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636758058298
> 8068
> > >
> 45&amp;sdata=3DHpuTjqfMqDvobNPD5Ww3zIaotrBXFKgOIh2%2BQ%2BGSE1o%3
> D&amp;
> > > reserved=3D0 [2]
> > > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
p
> > > atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Flist%2F%3Fseries%
> > >
> 3D26689&amp;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a
> 816c
> > >
> 9049d3d49b08d638148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C
> > >
> 636758058298806845&amp;sdata=3Dv1d%2Fe91xeDzhAUvz8X5ousbEPwwgMFxY1
> CBkc
> > > Dpuf70%3D&amp;reserved=3D0 [3]
> > > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
p
> > > atchwork.ozlabs.org%2Fproject%2Flinux-mtd%2Flist%2F%3Fseries%3D70179
> > >
> &amp;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a816c904
> 9d3d
> > >
> 49b08d638148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636
> 7580
> > >
> 58298806845&amp;sdata=3DvE%2FRQW9B4dU9rJqY2RZlNB1uH8smVKsCrGyEOs7
> 50Yk%
> > > 3D&amp;reserved=3D0
> > >
> > > Yogesh Gaur (5):
> > >   spi: spi-mem: Add driver for NXP FlexSPI controller
> > >   dt-bindings: spi: add binding file for NXP FlexSPI controller
> > >   arm64: dts: lx2160a: add FlexSPI node property
> > >   arm64: defconfig: enable NXP FlexSPI driver
> > >   MAINTAINERS: add maintainers for the NXP FlexSPI driver
> > >
> > > Changes for v4:
> > > - Incorporated review comments for
> > >   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > > - Incorporated binding file review comments.
> > > Changes for v3:
> > > - Incorporated review comments for
> > >   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > > Changes for v2:
> > > - Incorporated Boris review comments and drop below patches as per
> > > the comments.
> > >  - Patch 'spi: add slave device size in spi_device struct'
> > >  - Patch 'spi: add flags for octal I/O data transfer'
> > > - Incorporated DTS and Binding file review comments of Shawn Guo and
> > > Rob Herring.
> > >
> > >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
> > >  MAINTAINERS                                        |    6 +
> > >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
> > >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
> > >  arch/arm64/configs/defconfig                       |    1 +
> > >  drivers/spi/Kconfig                                |   10 +
> > >  drivers/spi/Makefile                               |    1 +
> > >  drivers/spi/spi-nxp-fspi.c                         | 1158 ++++++++++=
++++++++++
> > >  8 files changed, 1249 insertions(+)  create mode 100644
> > > Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > >  create mode 100644 drivers/spi/spi-nxp-fspi.c
> > >
> > > --
> > > 2.7.4
> >

