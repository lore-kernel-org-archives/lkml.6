Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E813BECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BD42086E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2AqwqrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BD42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeJUVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:40 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbeJUVZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihnECjKpYMB0/LH1/rie+Gi3QQZ9y/mNhZUiPJKGeLY=;
 b=f2AqwqrLBB8pfou6SJMDaxB8Xc/wit893jR1aEiS/82iKxl9g7Ay95CAD3PCtkRs/HHLgG82JSkQQYv3n7EvOuMKPBgAyNvEZ4yGEYLIrhgvYEhaJEYB9CD3zrM529zbbr2Xp6cI0a1haBVBL5KG5r4S0DWL2ZWvOOe38wQnN10=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:11:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:11:09 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock binding
 doc
Thread-Topic: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
Thread-Index: AQHUaT+I20/8Q3iJLk2UPqnv4RdOrw==
Date:   Sun, 21 Oct 2018 13:11:09 +0000
Message-ID: <1540127173-21346-7-git-send-email-aisheng.dong@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:nL74VvMBFwMod7dZ4Bm3x99FBavITBWJpuR+oq9EbHcOsSnB6s/kd+VJ/eRfe5Rdb/ODU3wEOu6BuoYtzfUgLOqU9md8ZpE26C+TT91PwdM3EPvAwnO5GUNU7Ofb6hQXUYkWrY4KZA5OH1Hi9bj6arn3aDxThyOfaiyn1lAAyd7r0hchGDSfGx08iFrhSXC0AZp23Y0MKAkFOtLwwEFzZjwHCXY4GMdvar7Ag04UaeRwYrM10RCz2hvxfs2SEgxZpKSf5vrDzyvl4sRTfPpbRarMwZML1EoNL5XrUR93vmeHdGa/4gLjNqnGMsZCOHXZrNybn4iyBNiOdn7Udmz2P5ZiP3WYbDbPOkSHKUtctNe4uImX63s/20wI0n/MP39uLKqH0I1pBhqeUUiqbJZAaxsO3SoGbSAb3MJkL16BYnB7Qz3XMHgtCqGw8w2CMFNBOgkxR6eqe3HY5ZJrj4CEMQ==;5:XCIiFKmf7HKpUkw4TLxjYBJT6pQOWKP91RqAZqHeklKdCA+FI4B3o6mvx1vdGRzDDiIR0PVs8H5+DxRfSIoyUeczFJOaW3LeYE9tbfVOSDLsSBv7Xq3pWWEWJRC4lOQBmmnYRKtVuZ5JHkjVg1/AcOphvv8KAsKpXmnD9FWSHAc=;7:c4Q6dXPkKNRY4uqJJVsf4E7quilfdZoleYdXPmnTzMx24oWlQscO+XxomrtV7egyAx0a5P7l6YvZWs3Boh+wxkfCBXuA5RBO1MDcGBAC9XBTAS/s1jeXSH5y2RbN7yFSg0uBMChwxWj2j/p7addkuQWBs1iid7NZs7Sn970z5/EYTbZBxqu5jzhs6LnEXI9Els0+UO80S/si8B3UJwJmbpMCgi9lcPK2zFmXIbuF/fcH4c7TMGjqEOfbr/kry++8
x-ms-office365-filtering-correlation-id: dee27dd7-c598-4485-5980-08d63756aabc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB458006BCB359A0C784342D6A80FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(269456686620040)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(11346002)(446003)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(76176011)(50226002)(86362001)(106356001)(256004)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(7416002)(6512007)(53936002)(2351001)(6486002)(36756003)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2RbNFn3mjtB1KtLUUI/APj2g6Aw3jBMbkDgqxtE9cKtoOHAeUqJzzS4yV0oFTokj9jFQcxSdbIXJZzD3HecpdWQk8Ylyf6+nl/2QYDxAn5sEBmFPGFMwKcYJuw4r137U4DqBdBd3oB0fHFojAZz6X8u5BH+d42Hx4xVN2+qgBr++Kouou7iKDySUV5e8Iw0WVq9MEcFByViBeqe0xEy06k4l0Co6eqOHNpvoOY90rg4fd2NdBu3/yaJHX09Of2h+N6jmz+ywy3mguGQzwipAE3twuR6SbPEWAScuW4p78JP0dixMFvXOcD2HnOfZMYe61jdCJYS6idGGbU8QykEyq9WgzqfD7iVZQnaPV7whoMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee27dd7-c598-4485-5980-08d63756aabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:11:09.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

Note IMX7ULP has two clock domains: M4 and A7. This binding doc
is only for A7 clock domain.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * make scg, pcc separate nodes according to Rob's suggestion
v2->v3:
 * no changes
v1->v2: no changes
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 ++++++++++++++++
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++++++++=
++++
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.t=
xt
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Do=
cumentation/devicetree/bindings/clock/imx7ulp-clock.txt
new file mode 100644
index 0000000..2239383
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -0,0 +1,87 @@
+* Clock bindings for Freescale i.MX7ULP
+
+i.MX7ULP Clock functions are under joint control of the System
+Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+modules, and Core Mode Controller (CMC)1 blocks
+
+The clocking scheme provides clear separation between M4 domain
+and A7 domain. Except for a few clock sources shared between two
+domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+and and the Fast IRC clock (FIRCLK), clock sources and clock
+management are separated and contained within each domain.
+
+M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+Note: this binding doc is only for A7 clock domain.
+
+System Clock Generation (SCG) modules:
+---------------------------------------------------------------------
+The System Clock Generation (SCG) is responsible for clock generation
+and distribution across this device. Functions performed by the SCG
+include: clock reference selection, generation of clock used to derive
+processor, system, peripheral bus and external memory interface clocks,
+source selection for peripheral clocks and control of power saving
+clock gating mode.
+
+Required properties:
+
+- compatible:	Should be "fsl,imx7ulp-scg1".
+- reg : 	Should contain registers location and length.
+- #clock-cells:	Should be <1>.
+- clocks:	Should contain the fixed input clocks.
+- clock-name:   Should contain the following clock names:"rosc", "sosc",
+		"sirc", "firc", "upll", "mpll".
+
+Peripheral Clock Control (PCC) modules:
+---------------------------------------------------------------------
+The Peripheral Clock Control (PCC) is responsible for clock selection,
+optional division and clock gating mode for peripherals in their
+respected power domain
+
+Required properties:
+- compatible:	Should be "fsl,imx7ulp-pcc2" or "fsl,imx7ulp-pcc3".
+- reg : 	Should contain registers location and length.
+- #clock-cells:	Should be <1>.
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See include/dt-bindings/clock/imx7ulp-clock.h
+for the full list of i.MX7ULP clock IDs of each module.
+
+Examples:
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+
+scg1: scg1@403e0000 {
+	compatible =3D "fsl,imx7ulp-scg1;
+	reg =3D <0x403e0000 0x10000>;
+	clocks =3D <&rosc>, <&sosc>, <&sirc>,
+		 <&firc>, <&upll>, <&mpll>;
+	clock-names =3D "rosc", "sosc", "sirc",
+		      "firc", "upll", "mpll";
+	#clock-cells =3D <1>;
+};
+
+pcc2: pcc2@403f0000 {
+	compatible =3D "fsl,imx7ulp-pcc2";
+	reg =3D <0x403f0000 0x10000>;
+	#clock-cells =3D <1>;
+};
+
+pcc3: pcc3@40b30000 {
+	compatible =3D "fsl,imx7ulp-pcc3";
+	reg =3D <0x40b30000 0x10000>;
+	#clock-cells =3D <1>;
+};
+
+usdhc1: usdhc@40380000 {
+	compatible =3D "fsl,imx7ulp-usdhc";
+	reg =3D <0x40380000 0x10000>;
+	interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+	clocks =3D <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
+		 <&pcc2 IMX7ULP_CLK_USDHC1>;
+	clock-names =3D"ipg", "ahb", "per";
+	bus-width =3D <4>;
+};
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-binding=
s/clock/imx7ulp-clock.h
new file mode 100644
index 0000000..008c5ee
--- /dev/null
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H
+#define __DT_BINDINGS_CLOCK_IMX7ULP_H
+
+/* SCG1 */
+
+#define IMX7ULP_CLK_DUMMY		0
+#define IMX7ULP_CLK_ROSC		1
+#define IMX7ULP_CLK_SOSC		2
+#define IMX7ULP_CLK_FIRC		3
+#define IMX7ULP_CLK_SPLL_PRE_SEL	4
+#define IMX7ULP_CLK_SPLL_PRE_DIV	5
+#define IMX7ULP_CLK_SPLL		6
+#define IMX7ULP_CLK_SPLL_POST_DIV1	7
+#define IMX7ULP_CLK_SPLL_POST_DIV2	8
+#define IMX7ULP_CLK_SPLL_PFD0		9
+#define IMX7ULP_CLK_SPLL_PFD1		10
+#define IMX7ULP_CLK_SPLL_PFD2		11
+#define IMX7ULP_CLK_SPLL_PFD3		12
+#define IMX7ULP_CLK_SPLL_PFD_SEL	13
+#define IMX7ULP_CLK_SPLL_SEL		14
+#define IMX7ULP_CLK_APLL_PRE_SEL	15
+#define IMX7ULP_CLK_APLL_PRE_DIV	16
+#define IMX7ULP_CLK_APLL		17
+#define IMX7ULP_CLK_APLL_POST_DIV1	18
+#define IMX7ULP_CLK_APLL_POST_DIV2	19
+#define IMX7ULP_CLK_APLL_PFD0		20
+#define IMX7ULP_CLK_APLL_PFD1		21
+#define IMX7ULP_CLK_APLL_PFD2		22
+#define IMX7ULP_CLK_APLL_PFD3		23
+#define IMX7ULP_CLK_APLL_PFD_SEL	24
+#define IMX7ULP_CLK_APLL_SEL		25
+#define IMX7ULP_CLK_UPLL		26
+#define IMX7ULP_CLK_SYS_SEL		27
+#define IMX7ULP_CLK_CORE_DIV		28
+#define IMX7ULP_CLK_BUS_DIV		29
+#define IMX7ULP_CLK_PLAT_DIV		30
+#define IMX7ULP_CLK_DDR_SEL		31
+#define IMX7ULP_CLK_DDR_DIV		32
+#define IMX7ULP_CLK_NIC_SEL		33
+#define IMX7ULP_CLK_NIC0_DIV		34
+#define IMX7ULP_CLK_GPU_DIV		35
+#define IMX7ULP_CLK_NIC1_DIV		36
+#define IMX7ULP_CLK_NIC1_BUS_DIV	37
+#define IMX7ULP_CLK_NIC1_EXT_DIV	38
+#define IMX7ULP_CLK_MIPI_PLL		39
+#define IMX7ULP_CLK_SIRC		40
+#define IMX7ULP_CLK_SOSC_BUS_CLK	41
+#define IMX7ULP_CLK_FIRC_BUS_CLK	42
+#define IMX7ULP_CLK_SPLL_BUS_CLK	43
+
+#define IMX7ULP_CLK_SCG1_END		44
+
+/* PCC2 */
+#define IMX7ULP_CLK_DMA1		0
+#define IMX7ULP_CLK_RGPIO2P1		1
+#define IMX7ULP_CLK_FLEXBUS		2
+#define IMX7ULP_CLK_SEMA42_1		3
+#define IMX7ULP_CLK_DMA_MUX1		4
+#define IMX7ULP_CLK_SNVS		5
+#define IMX7ULP_CLK_CAAM		6
+#define IMX7ULP_CLK_LPTPM4		7
+#define IMX7ULP_CLK_LPTPM5		8
+#define IMX7ULP_CLK_LPIT1		9
+#define IMX7ULP_CLK_LPSPI2		10
+#define IMX7ULP_CLK_LPSPI3		11
+#define IMX7ULP_CLK_LPI2C4		12
+#define IMX7ULP_CLK_LPI2C5		13
+#define IMX7ULP_CLK_LPUART4		14
+#define IMX7ULP_CLK_LPUART5		15
+#define IMX7ULP_CLK_FLEXIO1		16
+#define IMX7ULP_CLK_USB0		17
+#define IMX7ULP_CLK_USB1		18
+#define IMX7ULP_CLK_USB_PHY		19
+#define IMX7ULP_CLK_USB_PL301		20
+#define IMX7ULP_CLK_USDHC0		21
+#define IMX7ULP_CLK_USDHC1		22
+#define IMX7ULP_CLK_WDG1		23
+#define IMX7ULP_CLK_WDG2		24
+
+#define IMX7ULP_CLK_PCC2_END		25
+
+/* PCC3 */
+#define IMX7ULP_CLK_LPTPM6		0
+#define IMX7ULP_CLK_LPTPM7		1
+#define IMX7ULP_CLK_LPI2C6		2
+#define IMX7ULP_CLK_LPI2C7		3
+#define IMX7ULP_CLK_LPUART6		4
+#define IMX7ULP_CLK_LPUART7		5
+#define IMX7ULP_CLK_VIU			6
+#define IMX7ULP_CLK_DSI			7
+#define IMX7ULP_CLK_LCDIF		8
+#define IMX7ULP_CLK_MMDC		9
+#define IMX7ULP_CLK_PCTLC		10
+#define IMX7ULP_CLK_PCTLD		11
+#define IMX7ULP_CLK_PCTLE		12
+#define IMX7ULP_CLK_PCTLF		13
+#define IMX7ULP_CLK_GPU3D		14
+#define IMX7ULP_CLK_GPU2D		15
+
+#define IMX7ULP_CLK_PCC3_END		16
+
+#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
--=20
2.7.4

