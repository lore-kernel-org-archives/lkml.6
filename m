Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCDC0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D920883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jP7wJkD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7D920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKKAT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:19:57 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:3671
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbeKKAT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wURNXrBVZe/eiBqtAm264ILqAE3qpwsODccZaYNpUwo=;
 b=jP7wJkD7/AlmQU+BHdF8wmA2Bg6G1YupVX857atJuuh6uMMCRMobhA1eyQtUFkqVTN+KeI+t4b2aDsv7d0IGC5GPRVKChkKZtTxBtmRYA5tkr5jWZH+rbDXlVYFIgfEt85AhsqiKW865fwg8c3QvNT+aUCHkte3XfsozbY28SPU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:38 +0000
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
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V5 6/9] dt-bindings: clock: add imx7ulp clock binding doc
Thread-Topic: [PATCH V5 6/9] dt-bindings: clock: add imx7ulp clock binding doc
Thread-Index: AQHUeQKC2yvPHaNl7U650livqq9u3g==
Date:   Sat, 10 Nov 2018 14:34:38 +0000
Message-ID: <1541860165-401-7-git-send-email-aisheng.dong@nxp.com>
References: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:sC721aiRoBOcdYISx5IZo7RcOQ5/iO5AwSB/sdxgs//Ug2GPOcs43MfST5nuBZzf0HIgbZKwkyDbq+HTSjRvILnpDJ6pf5wcy0PjPjZVTGDak6DYphTLthmdCYMELsr+jgTAQDlWKZUwymuQaDjwsnvd5iLcux5O0/d1r+z0JsD/KcGhSooaMeBG5VC8GML/ZYId83abVvTDbygihi9X8MKl1KWd8iNKULt5SaprezIIVw45V2jeX7SAY0SAj4nwTsMPT80IH2ZMUnUqhpvv2+v3E+mDliEdT5bXz7LSBmfQwAmtAEumsa8jYrzZU0TUbOwX92AjljsgnKLYt38Z1oI6Fv6L1H+r3YIecETg4OSvCmeFxNDBxoKLmlBi51yY0hRuiE+C1mwvp+3aPraQTll/vyTR6dASM34A860qpn8E36JK+nLSrvXlxvmoZDjk6geEW9Rw85QaquraQLuR+w==;5:C2+TpjqzZwuP8E9Psl2OU9w7q6GtiZJRuxhQvZud+fhgfeU853WdI9c0sYKjSFVUh07eFzCPdDkHnUSfWzLpjwrv65Ienob86wG9ws9NCDxY2xD/GlUvoHuRIH2JGnSuLrJaAZ91tPLLUcWiKITMN6g61/u7WMbYA3HsfQqVTng=;7:2Fiv9v0ujEMiRa9vVlGi/ptnvy01zxabqJ55hKOPMMsjPONFD000dgrwJWbrLih0CJHTTu9UXbGHg1wfbYy5pCRfumY+6dBt5w2ggQSABjT2kt9swKJfRuCItoWsGT6ZLQmhTN3x8GXge6vHT1mxeA==
x-ms-office365-filtering-correlation-id: 7f794f7e-0f90-4d6e-a821-08d64719a4d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB440258BA129765A2C75CB52B80C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TrI/i+PF/1xuoMFuPPL0etC9jx6GnduslaJ6LJTCOwtolZrNhVZu29fpDj33mRxbDCX3K08suw/XSWbAETHI/XefKxokSGUVJIQ5OjZQkb0hcdbqZNg6MAUhtl4p9ZIIpYYIbhI18s64Qnx2/Zj3lHvYmUkVMNxIvNFF6sJc5KNqnJVMz1+1EIEhkdgeCsbTAa9zWCV5bagN4lpGJgq+x+P7t/ZOz67w+deCFqv0wwnG0GSzG8v/kMiRH6++lBnZ2hTlML6O3Fxr45Gd3447f+Jj53LXpiK4GQyfEGCFRWYicL05+z2NPq/zN2MT776wUf4QoZWSKcJjOpMaCXbF62j5veErGymyWfm3czHpuXo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f794f7e-0f90-4d6e-a821-08d64719a4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:38.7019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
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
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v4->v5:
 * fix a typo that clock-name -> clock-names
 * one compatible string per line
 * add input clocks for pcc2/3
v3->v4:
 * make scg, pcc separate nodes according to Rob's suggestion
v2->v3:
 * no changes
v1->v2: no changes
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    | 104 +++++++++++++++++=
+++
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++++++++=
++++
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.t=
xt
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Do=
cumentation/devicetree/bindings/clock/imx7ulp-clock.txt
new file mode 100644
index 0000000..a4f8cd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -0,0 +1,104 @@
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
+- clock-names:  Should contain the following clock names:
+		"rosc", "sosc", "sirc", "firc", "upll", "mpll".
+
+Peripheral Clock Control (PCC) modules:
+---------------------------------------------------------------------
+The Peripheral Clock Control (PCC) is responsible for clock selection,
+optional division and clock gating mode for peripherals in their
+respected power domain
+
+Required properties:
+- compatible:	Should be one of:
+		  "fsl,imx7ulp-pcc2",
+		  "fsl,imx7ulp-pcc3".
+- reg : 	Should contain registers location and length.
+- #clock-cells:	Should be <1>.
+- clocks:	Should contain the fixed input clocks.
+- clock-names:  Should contain the following clock names:
+		"nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2",
+		"apll_pfd1", "apll_pfd0", "upll", "sosc_bus_clk",
+		"mpll", "firc_bus_clk", "rosc", "spll_bus_clk";
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
+	clocks =3D <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
+		 <&scg1 IMX7ULP_CLK_DDR_DIV>,
+		 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
+		 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
+		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
+		 <&scg1 IMX7ULP_CLK_UPLL>,
+		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
+		 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
+		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
+		 <&scg1 IMX7ULP_CLK_ROSC>,
+		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
+	clock-names =3D "nic1_bus_clk", "nic1_clk", "ddr_clk",
+		      "apll_pfd2", "apll_pfd1", "apll_pfd0",
+		      "upll", "sosc_bus_clk", "mpll",
+		      "firc_bus_clk", "rosc", "spll_bus_clk";
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

