Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B446C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036220700
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RebF4Osu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4036220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeJWKbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:31:10 -0400
Received: from mail-he1eur01on0059.outbound.protection.outlook.com ([104.47.0.59]:33616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbeJWKbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dwPLxt6CIZb4Tbvg6A5d7Ksw4i4/Yeto1xpJbXePIA=;
 b=RebF4Osuj/ipaY9I1Boux/fsbByKuVZufcXnT5nQeaiCwfAdFtFm89vUKzsSwzq6Am9xA9cnm4sc1Uyo6bH8uyw4JIRdCWb963inLc6+STI7mMS1BqI1PscG03gRX34ZAQ5ViwWcJus2trG95VEt44QgGsWZST9oLwnhFsHwxEs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5171.eurprd04.prod.outlook.com (20.177.42.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Tue, 23 Oct 2018 02:09:53 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 02:09:46 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
Thread-Topic: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
Thread-Index: AQHUaT+I20/8Q3iJLk2UPqnv4RdOr6Ur10+AgAA58zA=
Date:   Tue, 23 Oct 2018 02:09:46 +0000
Message-ID: <AM0PR04MB4211C2A2273C4B7C4673B62380F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <1540127173-21346-7-git-send-email-aisheng.dong@nxp.com>
 <20181022221639.GA31408@bogus>
In-Reply-To: <20181022221639.GA31408@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5171;6:x+hP8+FtIXJfKXPlrW9BRBB9Xz5b7DJETxBv0oo+vD2WxSzC2WqVob+5WbXgiTfU4AAlcTvTgF7f6h1LLnA7Xgv/YwGyvtNHPnYTzwkY+s3NOyvcXHbmOjRIoj2cOrIiCSiPMN/1LXnJcC60/lU6arXYwIi1suRyVB2nuuSnqBLv2eNGoF2Kj8Ueje5RGfyHc+1HLr8eIhg8Mk8Tdv1OILwa3DlgKSF/TrNd4juqxHtHuhsvU8XczjgzxOA+AezvloKIjyGREcS3qYsF+QUgdr2IA5gu79cEVHzM4DMpFr95cBjMaKU2nwmDH7Kfu6KcQGRu2APytDB04AJ9aeoHf5sHEiPcvxNbmNmrflnxozIGlfUIA3B39oM7DTDJ2D34WXoo++tlfhkyGtb91l4VxJ4NOu/jLpEiuLGocmVlbAhuyshz467rbmum3QgSFlJ+q5s+wKyYZ2icgR2CPZjT5Q==;5:eExOM96+2TvHE7/Obg6yBCS+OTX3cXX4Fcp1sBo3mGgi5t67vubJ+bvaWqh6oTqT2oaO790rp1szWQbNW9E0xnYEWcN2qK/18qFvFpRz23oHTosNBKoSIQONZrHmg/DV1i+1y/THpHBVLtf/5pLpUSKoxyySHzR07tp33RTyg3I=;7:RL4PcABvsrD/GHMLZIBVyEJ4zH8ZbkNvf5/S5yecoGN5CYxdJj8neMdSOcEsxyZy9LzRMgug5MeZjnsWmvYuJ3Gg7XzTX5n/VQlmXVL7DTz5wKvmDWSwofjjSWjdXeKJRb6xJ0mY2toNkpg9LDHBscFzG3NcHDHwLQ6rqufvnT3KKCeJYUm4lBQUvC7+uIT7d5GKw7BLAU3Wxu11NMGQIZyc2aYRPn5/O2NnokPgNC2LeEGKwD7PYpCKhob/EwZv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d01d55a7-0f71-49b0-a07a-08d6388c9b28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5171;
x-ms-traffictypediagnostic: AM0PR04MB5171:
x-microsoft-antispam-prvs: <AM0PR04MB5171F42199C77BC4C5F8C3C880F50@AM0PR04MB5171.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(269456686620040)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5171;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5171;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(54534003)(13464003)(6346003)(7736002)(229853002)(217873002)(5660300001)(6506007)(6436002)(6246003)(102836004)(14454004)(71200400001)(76176011)(105586002)(8936002)(106356001)(81166006)(71190400001)(33656002)(8676002)(81156014)(68736007)(478600001)(2900100001)(54906003)(99286004)(316002)(5250100002)(3846002)(66066001)(25786009)(6916009)(305945005)(2906002)(6116002)(256004)(7416002)(476003)(186003)(26005)(486006)(11346002)(446003)(9686003)(4326008)(97736004)(86362001)(74316002)(7696005)(55016002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5171;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-message-info: ZXWomw81CgxE0+AVUEmd9aBrvsSJI+a1WvFaTLtD0olTl1bQKWIS8p0/12oeE6ESYqrXa5Qqt3WwRLRtMQI0NdMoeZmGOS9uqejMZEqnMAhKIIJZCVQfoafbkvdX0cH8cIlXiB4IxssP/PssaOsLvJrg15XPxoOFLGRZ6EqQ7fRuKFSVOo/IAqMoe8pcJN4/vpnozAiYtlIzla0kntnJbrGKCvJGox/KdVJtpLcUbiDnMLQVlgM/YbxTKVQqkQqzdK9/RumDqyoiyplAwKj/uJv9H8gPzoL2sGTuA7vKbwmSuyBj2xsfAtDFvX4tTzbZTv2xGh/Bc7tx/oDIMrAuTBF8BpRTC0VV3rwaaRPEcjE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01d55a7-0f71-49b0-a07a-08d6388c9b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 02:09:46.8274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, October 23, 2018 6:17 AM
[...]
>=20
> On Sun, Oct 21, 2018 at 01:11:09PM +0000, A.s. Dong wrote:
> > i.MX7ULP Clock functions are under joint control of the System Clock
> > Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > Core Mode Controller (CMC)1 blocks
> >
> > Note IMX7ULP has two clock domains: M4 and A7. This binding doc is
> > only for A7 clock domain.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Anson Huang <Anson.Huang@nxp.com>
> > Cc: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > ChangeLog:
> > v3->v4:
> >  * make scg, pcc separate nodes according to Rob's suggestion
> > v2->v3:
> >  * no changes
> > v1->v2: no changes
> > ---
> >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87
> ++++++++++++++++
> >  include/dt-bindings/clock/imx7ulp-clock.h          | 109
> +++++++++++++++++++++
> >  2 files changed, 196 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> >  create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > new file mode 100644
> > index 0000000..2239383
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > @@ -0,0 +1,87 @@
> > +* Clock bindings for Freescale i.MX7ULP
> > +
> > +i.MX7ULP Clock functions are under joint control of the System Clock
> > +Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > +Core Mode Controller (CMC)1 blocks
> > +
> > +The clocking scheme provides clear separation between M4 domain and
> > +A7 domain. Except for a few clock sources shared between two domains,
> > +such as the System Oscillator clock, the Slow IRC (SIRC), and and the
> > +Fast IRC clock (FIRCLK), clock sources and clock management are
> > +separated and contained within each domain.
> > +
> > +M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > +A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
>=20
> Where's the CMC1 binding?
>=20

CMC module is more related to low power control, so did not put in
clock series. But yes, it's missed in early series, will add it in next Arc=
h
patch series.

> > +
> > +Note: this binding doc is only for A7 clock domain.
> > +
> > +System Clock Generation (SCG) modules:
> > +---------------------------------------------------------------------
> > +The System Clock Generation (SCG) is responsible for clock generation
> > +and distribution across this device. Functions performed by the SCG
> > +include: clock reference selection, generation of clock used to
> > +derive processor, system, peripheral bus and external memory
> > +interface clocks, source selection for peripheral clocks and control
> > +of power saving clock gating mode.
> > +
> > +Required properties:
> > +
> > +- compatible:	Should be "fsl,imx7ulp-scg1".
> > +- reg : 	Should contain registers location and length.
> > +- #clock-cells:	Should be <1>.
> > +- clocks:	Should contain the fixed input clocks.
> > +- clock-name:   Should contain the following clock names:"rosc", "sosc=
",
>=20
> clock-names
>

Got it
=20
> > +		"sirc", "firc", "upll", "mpll".
> > +
> > +Peripheral Clock Control (PCC) modules:
> > +---------------------------------------------------------------------
> > +The Peripheral Clock Control (PCC) is responsible for clock
> > +selection, optional division and clock gating mode for peripherals in
> > +their respected power domain
> > +
> > +Required properties:
> > +- compatible:	Should be "fsl,imx7ulp-pcc2" or "fsl,imx7ulp-pcc3".
>=20
> Please format one per line.
>=20

Got it

> There's some register layout difference between PCC2 and PCC3?
>

Yes, they're for different clocks and the layout may be slightly different.
For example, some clocks support rate setting (with dividers) while
some of them not.
=20
> > +- reg : 	Should contain registers location and length.
> > +- #clock-cells:	Should be <1>.
>=20
> No input clocks to list?
>=20

Sorry for missing them, should add it.

Appreciate for the review.

Regards
Dong Aisheng

> > +
> > +The clock consumer should specify the desired clock by having the
> > +clock ID in its "clocks" phandle cell.
> > +See include/dt-bindings/clock/imx7ulp-clock.h
> > +for the full list of i.MX7ULP clock IDs of each module.
> > +
> > +Examples:
> > +
> > +#include <dt-bindings/clock/imx7ulp-clock.h>
> > +
> > +scg1: scg1@403e0000 {
> > +	compatible =3D "fsl,imx7ulp-scg1;
> > +	reg =3D <0x403e0000 0x10000>;
> > +	clocks =3D <&rosc>, <&sosc>, <&sirc>,
> > +		 <&firc>, <&upll>, <&mpll>;
> > +	clock-names =3D "rosc", "sosc", "sirc",
> > +		      "firc", "upll", "mpll";
> > +	#clock-cells =3D <1>;
> > +};
> > +
> > +pcc2: pcc2@403f0000 {
> > +	compatible =3D "fsl,imx7ulp-pcc2";
> > +	reg =3D <0x403f0000 0x10000>;
> > +	#clock-cells =3D <1>;
> > +};
> > +
> > +pcc3: pcc3@40b30000 {
> > +	compatible =3D "fsl,imx7ulp-pcc3";
> > +	reg =3D <0x40b30000 0x10000>;
> > +	#clock-cells =3D <1>;
> > +};
> > +
> > +usdhc1: usdhc@40380000 {
> > +	compatible =3D "fsl,imx7ulp-usdhc";
> > +	reg =3D <0x40380000 0x10000>;
> > +	interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +	clocks =3D <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
> > +		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
> > +		 <&pcc2 IMX7ULP_CLK_USDHC1>;
> > +	clock-names =3D"ipg", "ahb", "per";
> > +	bus-width =3D <4>;
> > +};
> > diff --git a/include/dt-bindings/clock/imx7ulp-clock.h
> > b/include/dt-bindings/clock/imx7ulp-clock.h
> > new file mode 100644
> > index 0000000..008c5ee
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> > @@ -0,0 +1,109 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + *
> > + */
> > +
> > +#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H #define
> > +__DT_BINDINGS_CLOCK_IMX7ULP_H
> > +
> > +/* SCG1 */
> > +
> > +#define IMX7ULP_CLK_DUMMY		0
> > +#define IMX7ULP_CLK_ROSC		1
> > +#define IMX7ULP_CLK_SOSC		2
> > +#define IMX7ULP_CLK_FIRC		3
> > +#define IMX7ULP_CLK_SPLL_PRE_SEL	4
> > +#define IMX7ULP_CLK_SPLL_PRE_DIV	5
> > +#define IMX7ULP_CLK_SPLL		6
> > +#define IMX7ULP_CLK_SPLL_POST_DIV1	7
> > +#define IMX7ULP_CLK_SPLL_POST_DIV2	8
> > +#define IMX7ULP_CLK_SPLL_PFD0		9
> > +#define IMX7ULP_CLK_SPLL_PFD1		10
> > +#define IMX7ULP_CLK_SPLL_PFD2		11
> > +#define IMX7ULP_CLK_SPLL_PFD3		12
> > +#define IMX7ULP_CLK_SPLL_PFD_SEL	13
> > +#define IMX7ULP_CLK_SPLL_SEL		14
> > +#define IMX7ULP_CLK_APLL_PRE_SEL	15
> > +#define IMX7ULP_CLK_APLL_PRE_DIV	16
> > +#define IMX7ULP_CLK_APLL		17
> > +#define IMX7ULP_CLK_APLL_POST_DIV1	18
> > +#define IMX7ULP_CLK_APLL_POST_DIV2	19
> > +#define IMX7ULP_CLK_APLL_PFD0		20
> > +#define IMX7ULP_CLK_APLL_PFD1		21
> > +#define IMX7ULP_CLK_APLL_PFD2		22
> > +#define IMX7ULP_CLK_APLL_PFD3		23
> > +#define IMX7ULP_CLK_APLL_PFD_SEL	24
> > +#define IMX7ULP_CLK_APLL_SEL		25
> > +#define IMX7ULP_CLK_UPLL		26
> > +#define IMX7ULP_CLK_SYS_SEL		27
> > +#define IMX7ULP_CLK_CORE_DIV		28
> > +#define IMX7ULP_CLK_BUS_DIV		29
> > +#define IMX7ULP_CLK_PLAT_DIV		30
> > +#define IMX7ULP_CLK_DDR_SEL		31
> > +#define IMX7ULP_CLK_DDR_DIV		32
> > +#define IMX7ULP_CLK_NIC_SEL		33
> > +#define IMX7ULP_CLK_NIC0_DIV		34
> > +#define IMX7ULP_CLK_GPU_DIV		35
> > +#define IMX7ULP_CLK_NIC1_DIV		36
> > +#define IMX7ULP_CLK_NIC1_BUS_DIV	37
> > +#define IMX7ULP_CLK_NIC1_EXT_DIV	38
> > +#define IMX7ULP_CLK_MIPI_PLL		39
> > +#define IMX7ULP_CLK_SIRC		40
> > +#define IMX7ULP_CLK_SOSC_BUS_CLK	41
> > +#define IMX7ULP_CLK_FIRC_BUS_CLK	42
> > +#define IMX7ULP_CLK_SPLL_BUS_CLK	43
> > +
> > +#define IMX7ULP_CLK_SCG1_END		44
> > +
> > +/* PCC2 */
> > +#define IMX7ULP_CLK_DMA1		0
> > +#define IMX7ULP_CLK_RGPIO2P1		1
> > +#define IMX7ULP_CLK_FLEXBUS		2
> > +#define IMX7ULP_CLK_SEMA42_1		3
> > +#define IMX7ULP_CLK_DMA_MUX1		4
> > +#define IMX7ULP_CLK_SNVS		5
> > +#define IMX7ULP_CLK_CAAM		6
> > +#define IMX7ULP_CLK_LPTPM4		7
> > +#define IMX7ULP_CLK_LPTPM5		8
> > +#define IMX7ULP_CLK_LPIT1		9
> > +#define IMX7ULP_CLK_LPSPI2		10
> > +#define IMX7ULP_CLK_LPSPI3		11
> > +#define IMX7ULP_CLK_LPI2C4		12
> > +#define IMX7ULP_CLK_LPI2C5		13
> > +#define IMX7ULP_CLK_LPUART4		14
> > +#define IMX7ULP_CLK_LPUART5		15
> > +#define IMX7ULP_CLK_FLEXIO1		16
> > +#define IMX7ULP_CLK_USB0		17
> > +#define IMX7ULP_CLK_USB1		18
> > +#define IMX7ULP_CLK_USB_PHY		19
> > +#define IMX7ULP_CLK_USB_PL301		20
> > +#define IMX7ULP_CLK_USDHC0		21
> > +#define IMX7ULP_CLK_USDHC1		22
> > +#define IMX7ULP_CLK_WDG1		23
> > +#define IMX7ULP_CLK_WDG2		24
> > +
> > +#define IMX7ULP_CLK_PCC2_END		25
> > +
> > +/* PCC3 */
> > +#define IMX7ULP_CLK_LPTPM6		0
> > +#define IMX7ULP_CLK_LPTPM7		1
> > +#define IMX7ULP_CLK_LPI2C6		2
> > +#define IMX7ULP_CLK_LPI2C7		3
> > +#define IMX7ULP_CLK_LPUART6		4
> > +#define IMX7ULP_CLK_LPUART7		5
> > +#define IMX7ULP_CLK_VIU			6
> > +#define IMX7ULP_CLK_DSI			7
> > +#define IMX7ULP_CLK_LCDIF		8
> > +#define IMX7ULP_CLK_MMDC		9
> > +#define IMX7ULP_CLK_PCTLC		10
> > +#define IMX7ULP_CLK_PCTLD		11
> > +#define IMX7ULP_CLK_PCTLE		12
> > +#define IMX7ULP_CLK_PCTLF		13
> > +#define IMX7ULP_CLK_GPU3D		14
> > +#define IMX7ULP_CLK_GPU2D		15
> > +
> > +#define IMX7ULP_CLK_PCC3_END		16
> > +
> > +#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
> > --
> > 2.7.4
> >
