Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA0620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HFi5205U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeK2Udv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:33:51 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2224
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbeK2Udu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUpzIs6/kFrFv30l5bKBymV8FZoqSSmGFlKz7L0/kCg=;
 b=HFi5205U0a7A0nz/hbJXXAgNql3I8TTiE5ajwFfFNzLiSwDq7QGgZdXbIDeEZXlGydDkGGTizafYt8U0zsXDviPPWeg857ZA8Bkow14sY2J55p4bm+3IFfTuIjzazKQwcEcXnqwOL/V6Sb/6h/DL5Lgga+0AdChU0IU1WbhsoMI=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3560.eurprd04.prod.outlook.com (52.133.19.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 09:28:59 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.032; Thu, 29 Nov 2018
 09:28:59 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v14 1/5] dt-bindings: Add binding for i.MX8MQ CCM
Thread-Topic: [PATCH v14 1/5] dt-bindings: Add binding for i.MX8MQ CCM
Thread-Index: AQHUh8Xlu5J2OfGSF0WCiKxc8govhA==
Date:   Thu, 29 Nov 2018 09:28:33 +0000
Message-ID: <1543483640-4585-2-git-send-email-abel.vesa@nxp.com>
References: <1543483640-4585-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1543483640-4585-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0032.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::45) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3560;6:AZe1LT0DN7J8Zf9H6cvcNytvJfrVnS6JfvXlXCzM7nIdcYRIFo4zxkD1fjRHrdMsv1/rkc8NVK0Rinsa3vn0jHlk1QT2SwGzcJ5uBjqw/CDfatZ6NfYLz0keZP5g42bd2ow+m8IU6UmhVQ6TgZ5JrHjr3/zw+PswFbPu+hnZ5jRSO30ovegNiBJiqo8LF7yDqZel6qVYoKm6Q/HtcZdBRlaA5qmmIKxX8ZF/swhyYLG7RTUyUVRjV8BAxyRIaf1GiV2hwOQnSUgGIQAHv8FW1HgTZRgnvY8wK4KfFdLDX7dvHpvsHKyW4QUODivguw8lv9yI5mDQeANGEtCURWa41NB4fru9lxmXm4zSZP6FIGsdbaM7dqsnP1g5MjL6nuJsEODXVYaU18UDZc2Bes7Me0B7u+apMsV3L1w8vKqJLTLUDOxl8Jq1clzW7hJHnlIWIjR4JsfLxIaJEKEF3KlGEA==;5:EZpy8zW8PR5yd/n2RaYZ+UcCT3q3gCwkfvCvLFkgWaTZ1tuiIrfvpX4EWMDDRoG8glTQpch14+3byexWpdJMNbmnO9jDV0cCcNXV6XXoNsJgIDuHANGdmbgFvGeQPaDDGGkBvXvu/P0EhfDmZ895LlqhPS971ntipZeJ3k7zpXE=;7:9qi62EBqNO0pS+VzcrCV7SsA9kBAC1zByyfHAaxw2D2F7FeNLEV0wLQhJ7zIpPbAqMxHIUJnU9LNmMOkcGdnX9JY/H7lVK9EafM6i9uH4X5ZuswMJzGQwwpm/BNURrxIXb3dm/ZX5qry08ShwPI8GQ==
x-ms-office365-filtering-correlation-id: 673d93e5-588e-4ea7-ab37-08d655dd0816
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3560;
x-ms-traffictypediagnostic: AM6PR0402MB3560:
x-microsoft-antispam-prvs: <AM6PR0402MB3560FB962530AA37185C5161F6D20@AM6PR0402MB3560.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3560;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3560;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(4326008)(105586002)(6486002)(26005)(478600001)(97736004)(106356001)(3846002)(14454004)(44832011)(2906002)(2616005)(5660300001)(71200400001)(7416002)(446003)(71190400001)(316002)(11346002)(66066001)(486006)(6506007)(81156014)(305945005)(7736002)(6436002)(25786009)(36756003)(81166006)(6116002)(8936002)(110136005)(256004)(8676002)(476003)(6666004)(102836004)(4744004)(54906003)(6512007)(76176011)(68736007)(99286004)(52116002)(186003)(386003)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3560;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OWmOHMDYbjnw6vf0ow4bVuPf6bM3t9BvG7F6Zh3qogddXoL/VjKK4tLmGTyO7/TObB33MzCLOA5ErhRahScWpv+d4F/lHMCsDS80dFORfcCgXkzJDhlwoMOWHfDH7ifZPwYLTcB+vjwz98/xZgZOtLTowWGFMW6YM5kPtAamGZJrqQ3Y1neBZa7Unno2L7Rbeo6PWta8hZzuIiOmCjO7bKlqURwJmjAd8KsWklRMEYdvKjAE5N23nEbnd11JhAFjlnfTiiGkEs6LjZVBBdMuiClFQX/MheSC4POG+V6ftTbsgPcUTHwYGV9xpUylD6XUJtbIWD+gdpA6p7Y/G12JtN+BAVYphEVaDYQTIB0hrvw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673d93e5-588e-4ea7-ab37-08d655dd0816
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 09:28:33.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the binding for the i.MX8MQ Clock Controller Module.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 +++++++++++++++++=
++++
 2 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.tx=
t
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx8mq-clock.txt b/Doc=
umentation/devicetree/bindings/clock/imx8mq-clock.txt
new file mode 100644
index 0000000..52de826
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
@@ -0,0 +1,20 @@
+* Clock bindings for NXP i.MX8M Quad
+
+Required properties:
+- compatible: Should be "fsl,imx8mq-ccm"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of clock specifiers, must contain an entry for each require=
d
+          entry in clock-names
+- clock-names: should include the following entries:
+    - "ckil"
+    - "osc_25m"
+    - "osc_27m"
+    - "clk_ext1"
+    - "clk_ext2"
+    - "clk_ext3"
+    - "clk_ext4"
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx8mq-clo=
ck.h
+for the full list of i.MX8M Quad clock IDs.
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
new file mode 100644
index 0000000..b53be41
--- /dev/null
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -0,0 +1,395 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX8MQ_H
+#define __DT_BINDINGS_CLOCK_IMX8MQ_H
+
+#define IMX8MQ_CLK_DUMMY		0
+#define IMX8MQ_CLK_32K			1
+#define IMX8MQ_CLK_25M			2
+#define IMX8MQ_CLK_27M			3
+#define IMX8MQ_CLK_EXT1			4
+#define IMX8MQ_CLK_EXT2			5
+#define IMX8MQ_CLK_EXT3			6
+#define IMX8MQ_CLK_EXT4			7
+
+/* ANAMIX PLL clocks */
+/* FRAC PLLs */
+/* ARM PLL */
+#define IMX8MQ_ARM_PLL_REF_SEL		8
+#define IMX8MQ_ARM_PLL_REF_DIV		9
+#define IMX8MQ_ARM_PLL			10
+#define IMX8MQ_ARM_PLL_BYPASS		11
+#define IMX8MQ_ARM_PLL_OUT		12
+
+/* GPU PLL */
+#define IMX8MQ_GPU_PLL_REF_SEL		13
+#define IMX8MQ_GPU_PLL_REF_DIV		14
+#define IMX8MQ_GPU_PLL			15
+#define IMX8MQ_GPU_PLL_BYPASS		16
+#define IMX8MQ_GPU_PLL_OUT		17
+
+/* VPU PLL */
+#define IMX8MQ_VPU_PLL_REF_SEL		18
+#define IMX8MQ_VPU_PLL_REF_DIV		19
+#define IMX8MQ_VPU_PLL			20
+#define IMX8MQ_VPU_PLL_BYPASS		21
+#define IMX8MQ_VPU_PLL_OUT		22
+
+/* AUDIO PLL1 */
+#define IMX8MQ_AUDIO_PLL1_REF_SEL	23
+#define IMX8MQ_AUDIO_PLL1_REF_DIV	24
+#define IMX8MQ_AUDIO_PLL1		25
+#define IMX8MQ_AUDIO_PLL1_BYPASS	26
+#define IMX8MQ_AUDIO_PLL1_OUT		27
+
+/* AUDIO PLL2 */
+#define IMX8MQ_AUDIO_PLL2_REF_SEL	28
+#define IMX8MQ_AUDIO_PLL2_REF_DIV	29
+#define IMX8MQ_AUDIO_PLL2		30
+#define IMX8MQ_AUDIO_PLL2_BYPASS	31
+#define IMX8MQ_AUDIO_PLL2_OUT		32
+
+/* VIDEO PLL1 */
+#define IMX8MQ_VIDEO_PLL1_REF_SEL	33
+#define IMX8MQ_VIDEO_PLL1_REF_DIV	34
+#define IMX8MQ_VIDEO_PLL1		35
+#define IMX8MQ_VIDEO_PLL1_BYPASS	36
+#define IMX8MQ_VIDEO_PLL1_OUT		37
+
+/* SYS1 PLL */
+#define IMX8MQ_SYS1_PLL1_REF_SEL	38
+#define IMX8MQ_SYS1_PLL1_REF_DIV	39
+#define IMX8MQ_SYS1_PLL1		40
+#define IMX8MQ_SYS1_PLL1_OUT		41
+#define IMX8MQ_SYS1_PLL1_OUT_DIV	42
+#define IMX8MQ_SYS1_PLL2		43
+#define IMX8MQ_SYS1_PLL2_DIV		44
+#define IMX8MQ_SYS1_PLL2_OUT		45
+
+/* SYS2 PLL */
+#define IMX8MQ_SYS2_PLL1_REF_SEL	46
+#define IMX8MQ_SYS2_PLL1_REF_DIV	47
+#define IMX8MQ_SYS2_PLL1		48
+#define IMX8MQ_SYS2_PLL1_OUT		49
+#define IMX8MQ_SYS2_PLL1_OUT_DIV	50
+#define IMX8MQ_SYS2_PLL2		51
+#define IMX8MQ_SYS2_PLL2_DIV		52
+#define IMX8MQ_SYS2_PLL2_OUT		53
+
+/* SYS3 PLL */
+#define IMX8MQ_SYS3_PLL1_REF_SEL	54
+#define IMX8MQ_SYS3_PLL1_REF_DIV	55
+#define IMX8MQ_SYS3_PLL1		56
+#define IMX8MQ_SYS3_PLL1_OUT		57
+#define IMX8MQ_SYS3_PLL1_OUT_DIV	58
+#define IMX8MQ_SYS3_PLL2		59
+#define IMX8MQ_SYS3_PLL2_DIV		60
+#define IMX8MQ_SYS3_PLL2_OUT		61
+
+/* DRAM PLL */
+#define IMX8MQ_DRAM_PLL1_REF_SEL	62
+#define IMX8MQ_DRAM_PLL1_REF_DIV	63
+#define IMX8MQ_DRAM_PLL1		64
+#define IMX8MQ_DRAM_PLL1_OUT		65
+#define IMX8MQ_DRAM_PLL1_OUT_DIV	66
+#define IMX8MQ_DRAM_PLL2		67
+#define IMX8MQ_DRAM_PLL2_DIV		68
+#define IMX8MQ_DRAM_PLL2_OUT		69
+
+/* SYS PLL DIV */
+#define IMX8MQ_SYS1_PLL_40M		70
+#define IMX8MQ_SYS1_PLL_80M		71
+#define IMX8MQ_SYS1_PLL_100M		72
+#define IMX8MQ_SYS1_PLL_133M		73
+#define IMX8MQ_SYS1_PLL_160M		74
+#define IMX8MQ_SYS1_PLL_200M		75
+#define IMX8MQ_SYS1_PLL_266M		76
+#define IMX8MQ_SYS1_PLL_400M		77
+#define IMX8MQ_SYS1_PLL_800M		78
+
+#define IMX8MQ_SYS2_PLL_50M		79
+#define IMX8MQ_SYS2_PLL_100M		80
+#define IMX8MQ_SYS2_PLL_125M		81
+#define IMX8MQ_SYS2_PLL_166M		82
+#define IMX8MQ_SYS2_PLL_200M		83
+#define IMX8MQ_SYS2_PLL_250M		84
+#define IMX8MQ_SYS2_PLL_333M		85
+#define IMX8MQ_SYS2_PLL_500M		86
+#define IMX8MQ_SYS2_PLL_1000M		87
+
+/* CCM ROOT clocks */
+/* A53 */
+#define IMX8MQ_CLK_A53_SRC		88
+#define IMX8MQ_CLK_A53_CG		89
+#define IMX8MQ_CLK_A53_DIV		90
+/* M4 */
+#define IMX8MQ_CLK_M4_SRC		91
+#define IMX8MQ_CLK_M4_CG		92
+#define IMX8MQ_CLK_M4_DIV		93
+/* VPU */
+#define IMX8MQ_CLK_VPU_SRC		94
+#define IMX8MQ_CLK_VPU_CG		95
+#define IMX8MQ_CLK_VPU_DIV		96
+/* GPU CORE */
+#define IMX8MQ_CLK_GPU_CORE_SRC		97
+#define IMX8MQ_CLK_GPU_CORE_CG		98
+#define IMX8MQ_CLK_GPU_CORE_DIV		99
+/* GPU SHADER */
+#define IMX8MQ_CLK_GPU_SHADER_SRC	100
+#define IMX8MQ_CLK_GPU_SHADER_CG	101
+#define IMX8MQ_CLK_GPU_SHADER_DIV	102
+
+/* BUS TYPE */
+/* MAIN AXI */
+#define IMX8MQ_CLK_MAIN_AXI		103
+/* ENET AXI */
+#define IMX8MQ_CLK_ENET_AXI		104
+/* NAND_USDHC_BUS */
+#define IMX8MQ_CLK_NAND_USDHC_BUS	105
+/* VPU BUS */
+#define IMX8MQ_CLK_VPU_BUS		106
+/* DISP_AXI */
+#define IMX8MQ_CLK_DISP_AXI		107
+/* DISP APB */
+#define IMX8MQ_CLK_DISP_APB		108
+/* DISP RTRM */
+#define IMX8MQ_CLK_DISP_RTRM		109
+/* USB_BUS */
+#define IMX8MQ_CLK_USB_BUS		110
+/* GPU_AXI */
+#define IMX8MQ_CLK_GPU_AXI		111
+/* GPU_AHB */
+#define IMX8MQ_CLK_GPU_AHB		112
+/* NOC */
+#define IMX8MQ_CLK_NOC			113
+/* NOC_APB */
+#define IMX8MQ_CLK_NOC_APB		115
+
+/* AHB */
+#define IMX8MQ_CLK_AHB			116
+/* AUDIO AHB */
+#define IMX8MQ_CLK_AUDIO_AHB		117
+
+/* DRAM_ALT */
+#define IMX8MQ_CLK_DRAM_ALT		118
+/* DRAM APB */
+#define IMX8MQ_CLK_DRAM_APB		119
+/* VPU_G1 */
+#define IMX8MQ_CLK_VPU_G1		120
+/* VPU_G2 */
+#define IMX8MQ_CLK_VPU_G2		121
+/* DISP_DTRC */
+#define IMX8MQ_CLK_DISP_DTRC		122
+/* DISP_DC8000 */
+#define IMX8MQ_CLK_DISP_DC8000		123
+/* PCIE_CTRL */
+#define IMX8MQ_CLK_PCIE1_CTRL		124
+/* PCIE_PHY */
+#define IMX8MQ_CLK_PCIE1_PHY		125
+/* PCIE_AUX */
+#define IMX8MQ_CLK_PCIE1_AUX		126
+/* DC_PIXEL */
+#define IMX8MQ_CLK_DC_PIXEL		127
+/* LCDIF_PIXEL */
+#define IMX8MQ_CLK_LCDIF_PIXEL		128
+/* SAI1~6 */
+#define IMX8MQ_CLK_SAI1			129
+
+#define IMX8MQ_CLK_SAI2			130
+
+#define IMX8MQ_CLK_SAI3			131
+
+#define IMX8MQ_CLK_SAI4			132
+
+#define IMX8MQ_CLK_SAI5			133
+
+#define IMX8MQ_CLK_SAI6			134
+/* SPDIF1 */
+#define IMX8MQ_CLK_SPDIF1		135
+/* SPDIF2 */
+#define IMX8MQ_CLK_SPDIF2		136
+/* ENET_REF */
+#define IMX8MQ_CLK_ENET_REF		137
+/* ENET_TIMER */
+#define IMX8MQ_CLK_ENET_TIMER		138
+/* ENET_PHY */
+#define IMX8MQ_CLK_ENET_PHY_REF		139
+/* NAND */
+#define IMX8MQ_CLK_NAND			140
+/* QSPI */
+#define IMX8MQ_CLK_QSPI			141
+/* USDHC1 */
+#define IMX8MQ_CLK_USDHC1		142
+/* USDHC2 */
+#define IMX8MQ_CLK_USDHC2		143
+/* I2C1 */
+#define IMX8MQ_CLK_I2C1			144
+/* I2C2 */
+#define IMX8MQ_CLK_I2C2			145
+/* I2C3 */
+#define IMX8MQ_CLK_I2C3			146
+/* I2C4 */
+#define IMX8MQ_CLK_I2C4			147
+/* UART1 */
+#define IMX8MQ_CLK_UART1		148
+/* UART2 */
+#define IMX8MQ_CLK_UART2		149
+/* UART3 */
+#define IMX8MQ_CLK_UART3		150
+/* UART4 */
+#define IMX8MQ_CLK_UART4		151
+/* USB_CORE_REF */
+#define IMX8MQ_CLK_USB_CORE_REF		152
+/* USB_PHY_REF */
+#define IMX8MQ_CLK_USB_PHY_REF		163
+/* ECSPI1 */
+#define IMX8MQ_CLK_ECSPI1		164
+/* ECSPI2 */
+#define IMX8MQ_CLK_ECSPI2		165
+/* PWM1 */
+#define IMX8MQ_CLK_PWM1			166
+/* PWM2 */
+#define IMX8MQ_CLK_PWM2			167
+/* PWM3 */
+#define IMX8MQ_CLK_PWM3			168
+/* PWM4 */
+#define IMX8MQ_CLK_PWM4			169
+/* GPT1 */
+#define IMX8MQ_CLK_GPT1			170
+/* WDOG */
+#define IMX8MQ_CLK_WDOG			171
+/* WRCLK */
+#define IMX8MQ_CLK_WRCLK		172
+/* DSI_CORE */
+#define IMX8MQ_CLK_DSI_CORE		173
+/* DSI_PHY */
+#define IMX8MQ_CLK_DSI_PHY_REF		174
+/* DSI_DBI */
+#define IMX8MQ_CLK_DSI_DBI		175
+/*DSI_ESC */
+#define IMX8MQ_CLK_DSI_ESC		176
+/* CSI1_CORE */
+#define IMX8MQ_CLK_CSI1_CORE		177
+/* CSI1_PHY */
+#define IMX8MQ_CLK_CSI1_PHY_REF		178
+/* CSI_ESC */
+#define IMX8MQ_CLK_CSI1_ESC		179
+/* CSI2_CORE */
+#define IMX8MQ_CLK_CSI2_CORE		170
+/* CSI2_PHY */
+#define IMX8MQ_CLK_CSI2_PHY_REF		181
+/* CSI2_ESC */
+#define IMX8MQ_CLK_CSI2_ESC		182
+/* PCIE2_CTRL */
+#define IMX8MQ_CLK_PCIE2_CTRL		183
+/* PCIE2_PHY */
+#define IMX8MQ_CLK_PCIE2_PHY		184
+/* PCIE2_AUX */
+#define IMX8MQ_CLK_PCIE2_AUX		185
+/* ECSPI3 */
+#define IMX8MQ_CLK_ECSPI3		186
+
+/* CCGR clocks */
+#define IMX8MQ_CLK_A53_ROOT			187
+#define IMX8MQ_CLK_DRAM_ROOT			188
+#define IMX8MQ_CLK_ECSPI1_ROOT			189
+#define IMX8MQ_CLK_ECSPI2_ROOT			180
+#define IMX8MQ_CLK_ECSPI3_ROOT			181
+#define IMX8MQ_CLK_ENET1_ROOT			182
+#define IMX8MQ_CLK_GPT1_ROOT			193
+#define IMX8MQ_CLK_I2C1_ROOT			194
+#define IMX8MQ_CLK_I2C2_ROOT			195
+#define IMX8MQ_CLK_I2C3_ROOT			196
+#define IMX8MQ_CLK_I2C4_ROOT			197
+#define IMX8MQ_CLK_M4_ROOT			198
+#define IMX8MQ_CLK_PCIE1_ROOT			199
+#define IMX8MQ_CLK_PCIE2_ROOT			200
+#define IMX8MQ_CLK_PWM1_ROOT			201
+#define IMX8MQ_CLK_PWM2_ROOT			202
+#define IMX8MQ_CLK_PWM3_ROOT			203
+#define IMX8MQ_CLK_PWM4_ROOT			204
+#define IMX8MQ_CLK_QSPI_ROOT			205
+#define IMX8MQ_CLK_SAI1_ROOT			206
+#define IMX8MQ_CLK_SAI2_ROOT			207
+#define IMX8MQ_CLK_SAI3_ROOT			208
+#define IMX8MQ_CLK_SAI4_ROOT			209
+#define IMX8MQ_CLK_SAI5_ROOT			210
+#define IMX8MQ_CLK_SAI6_ROOT			212
+#define IMX8MQ_CLK_UART1_ROOT			213
+#define IMX8MQ_CLK_UART2_ROOT			214
+#define IMX8MQ_CLK_UART3_ROOT			215
+#define IMX8MQ_CLK_UART4_ROOT			216
+#define IMX8MQ_CLK_USB1_CTRL_ROOT		217
+#define IMX8MQ_CLK_USB2_CTRL_ROOT		218
+#define IMX8MQ_CLK_USB1_PHY_ROOT		219
+#define IMX8MQ_CLK_USB2_PHY_ROOT		220
+#define IMX8MQ_CLK_USDHC1_ROOT			221
+#define IMX8MQ_CLK_USDHC2_ROOT			222
+#define IMX8MQ_CLK_WDOG1_ROOT			223
+#define IMX8MQ_CLK_WDOG2_ROOT			224
+#define IMX8MQ_CLK_WDOG3_ROOT			225
+#define IMX8MQ_CLK_GPU_ROOT			226
+#define IMX8MQ_CLK_HEVC_ROOT			227
+#define IMX8MQ_CLK_AVC_ROOT			228
+#define IMX8MQ_CLK_VP9_ROOT			229
+#define IMX8MQ_CLK_HEVC_INTER_ROOT		230
+#define IMX8MQ_CLK_DISP_ROOT			231
+#define IMX8MQ_CLK_HDMI_ROOT			232
+#define IMX8MQ_CLK_HDMI_PHY_ROOT		233
+#define IMX8MQ_CLK_VPU_DEC_ROOT			234
+#define IMX8MQ_CLK_CSI1_ROOT			235
+#define IMX8MQ_CLK_CSI2_ROOT			236
+#define IMX8MQ_CLK_RAWNAND_ROOT			237
+#define IMX8MQ_CLK_SDMA1_ROOT			238
+#define IMX8MQ_CLK_SDMA2_ROOT			239
+#define IMX8MQ_CLK_VPU_G1_ROOT			240
+#define IMX8MQ_CLK_VPU_G2_ROOT			241
+
+/* SCCG PLL GATE */
+#define IMX8MQ_SYS1_PLL_OUT			232
+#define IMX8MQ_SYS2_PLL_OUT			243
+#define IMX8MQ_SYS3_PLL_OUT			244
+#define IMX8MQ_DRAM_PLL_OUT			245
+
+#define IMX8MQ_GPT_3M_CLK			246
+
+#define IMX8MQ_CLK_IPG_ROOT			247
+#define IMX8MQ_CLK_IPG_AUDIO_ROOT		248
+#define IMX8MQ_CLK_SAI1_IPG			249
+#define IMX8MQ_CLK_SAI2_IPG			250
+#define IMX8MQ_CLK_SAI3_IPG			251
+#define IMX8MQ_CLK_SAI4_IPG			252
+#define IMX8MQ_CLK_SAI5_IPG			253
+#define IMX8MQ_CLK_SAI6_IPG			254
+
+/* DSI AHB/IPG clocks */
+/* rxesc clock */
+#define IMX8MQ_CLK_DSI_AHB			255
+/* txesc clock */
+#define IMX8MQ_CLK_DSI_IPG_DIV                  256
+
+#define IMX8MQ_CLK_TMU_ROOT			265
+
+/* Display root clocks */
+#define IMX8MQ_CLK_DISP_AXI_ROOT		266
+#define IMX8MQ_CLK_DISP_APB_ROOT		267
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		268
+
+#define IMX8MQ_CLK_OCOTP_ROOT			269
+
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		270
+#define IMX8MQ_CLK_DRAM_CORE			271
+
+#define IMX8MQ_CLK_MU_ROOT			272
+#define IMX8MQ_VIDEO2_PLL_OUT			273
+
+#define IMX8MQ_CLK_CLKO2			274
+
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	275
+
+#define IMX8MQ_CLK_END				276
+#endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

