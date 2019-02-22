Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB50C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110732086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KZhrfaFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBVJnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:43:12 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:15277
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfBVJnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iKpc9yRBAzhARgiyXgkj/ZdJ+x7vfoYDTjIqZzQK4E=;
 b=KZhrfaFrt0MQ2AvjR+iy8Ibg6IgQZLHt+01dB7Nm6X/+sElc3ndBijRI0gHmWJAr3RdNiD3VM+Fy5cyh37RqGqyq16UxsAr9U1tqUXXzTDvURXcrbLuEbc1K6FXvohXt/aNXFO/+UxILpm3pE0546Y46liLaiOCF/mY7JL3Xl6w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 09:42:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 09:42:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] arm64: dts: freescale: imx8mq: add clock for GPIO node
Thread-Topic: [PATCH 3/3] arm64: dts: freescale: imx8mq: add clock for GPIO
 node
Thread-Index: AQHUypLvYpTr0WOl/0agwG8jcR0eEA==
Date:   Fri, 22 Feb 2019 09:42:33 +0000
Message-ID: <1550828264-9962-3-git-send-email-Anson.Huang@nxp.com>
References: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd7cbe98-7dc4-410b-b2ba-08d698aa122c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:RYcwoF1ybpkRfxJGoD8ZjevcR8OYAxtx3d6WN?=
 =?iso-8859-1?Q?VxK/buarBFWvz12JepDSowPS8d5QdwFbRuF7dBOculxzv3lZJ4jPuPoJD6?=
 =?iso-8859-1?Q?NBB7HLne+YG0YrTuCD8p5LnsTs0fT2QbVGAPgZqTx+xqMcKrxJ8pp/mBg+?=
 =?iso-8859-1?Q?ARhLdilv+DggId42tPH3aRLJX/oztlZeMc/DABffk1sHJFfvr+ycxwETLo?=
 =?iso-8859-1?Q?aVVT+iILDX7LAriwwnfm1sgNqEJc/j06vknvy3cA308VWYcP3t061JZluO?=
 =?iso-8859-1?Q?0qTfuKAnu6Qz2uRyKmuY7jOVUe/qBUKbX4h7q4OuHE+CuqlvBm83n++ANZ?=
 =?iso-8859-1?Q?nlxwufDuKNpE/a7oOkIxBj8jZoLYvPyczNxLrTXH7cF1J1TEUS2htSbpnY?=
 =?iso-8859-1?Q?psOSkFR7Mxn0kl428MWfiUb/h0ewx8DzsmFH7nAqfX0ywXyvqLMfZ7LMfD?=
 =?iso-8859-1?Q?+6p7k5muugrqZxp5vNYaS2s8Fyfs01hd5H86I4pVzpRZojaDymO5B7YdrC?=
 =?iso-8859-1?Q?gHt3V6Fwpt5XlzYFduR6juobILz72tCtOcgVBxBdsa0WCxsK8SSbelxnF8?=
 =?iso-8859-1?Q?xedsSjTo+g5DjOqzaEYeXtkqn17ViJjUvfMRmt8HiFxSIxFbpgPxamfHWN?=
 =?iso-8859-1?Q?w9cTi+Yntxt65RBAYXs7YenBKSEZmn/+iEQ4P6rYNnCsIAQPIVhOgkcvbp?=
 =?iso-8859-1?Q?eRGM90NHZgMToy8BQlDvEf2u4MCYZaDjsWwIVfZ6PqgkpTkDlcJzEQu4Hv?=
 =?iso-8859-1?Q?mtq1X7ErTEF2ALkNklw/56MHOIA2el/R39J12qYYXOu2fcOVEzFz/E/93L?=
 =?iso-8859-1?Q?rwFMMMp8CLc/sxwq+gwHdSDy7aNyWHAtIdskxsp0d+BQLb6l8PRoT+f5a4?=
 =?iso-8859-1?Q?vAyV8I9oVnFue7z/5w0Pvl25FP0cNj9zd7xBTnG8XlvfTrxiYQy+UQ79iG?=
 =?iso-8859-1?Q?P7BRYrXh4UF1W01+ANRbEyY1FBA+oJE+O0E+CbKYnGTOoGtWHSHxiSxdOo?=
 =?iso-8859-1?Q?81PNJ+CHbaISpSpYZptkl2JIuVbMGZEFFlArNhu9P7OdUJk7342UjeUZ5S?=
 =?iso-8859-1?Q?H5FXSyv3pJnCeTahDchyXavLp6NuCbsod/+yqNxX5AQq+T/GyZN895kw1K?=
 =?iso-8859-1?Q?PdRCKT/3thhcGax8jKieFmxuBulEsFYmsuf4DUZbOF6reZIIWI/Oawsbki?=
 =?iso-8859-1?Q?TJL6zUjAXQaJARj9/KLr3cc8B/FEyVY0qs2/AYKj5n3rknNwbG3FPrwdzw?=
 =?iso-8859-1?Q?PyHjg4h/LVbXeB7DfItRj5MRGU4u4kmBTECduqGGDB/MXVd6hzneWP6J6W?=
 =?iso-8859-1?Q?JKWrbtDnjoomCtSf3i4dC9i19?=
x-microsoft-antispam-prvs: <DB3PR0402MB3756094115F37E288C1CEB97F57F0@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(476003)(14454004)(102836004)(106356001)(478600001)(486006)(186003)(316002)(2616005)(446003)(99286004)(386003)(105586002)(76176011)(6506007)(52116002)(26005)(2501003)(66066001)(2906002)(110136005)(68736007)(97736004)(36756003)(11346002)(7416002)(5660300002)(8936002)(256004)(50226002)(25786009)(6486002)(71190400001)(71200400001)(86362001)(6116002)(53936002)(3846002)(305945005)(6436002)(81166006)(81156014)(8676002)(7736002)(6512007)(4326008)(2201001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +V6hW2Mrm0plOlXfrYnxfVRXpDFZRvv2Q6jT5HeuDZo5PR7L3ziyevtZsAVXME2FTI3mkdzXlKXPrWcpl1O0HqGkCTrS34Q5AjBdlBeA1nWHjIwGnh9kQmGTYd/Nzh0lW3P8yRkjvpb65DkvKEGx2NgITuF5Y/Y1QU3JHWYcs7GgKjyFuoWSZGn1RloagiHSQTzX7QR5wXgdFimdu20V2+ylNkRoZ7d1SR1yXGjo9xOdLxtQ8LkhumouTcNLVc6ZRcZ/1tgxJVkM5LklWW5UbJ/ELrOWiaZY25kyl6TGwz26YGQ4nm/STzBh87H49f/xsWzISs7CkO++ebzzCsJBQq9sVfv7KcLRbJvnvemOzpwrWHNYs/+iHr3GV9ERkg0M/bQva4ftW2Gk9/QeRQG8iIv1uuQtSPleKDuCR1X2Mis=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7cbe98-7dc4-410b-b2ba-08d698aa122c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 09:42:28.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ has clock gate for each GPIO bank, add clock info
to GPIO node for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4..4c1fca9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -160,6 +160,7 @@
 				reg =3D <0x30200000 0x10000>;
 				interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_GPIO1_ROOT>;
 				gpio-controller;
 				#gpio-cells =3D <2>;
 				interrupt-controller;
@@ -171,6 +172,7 @@
 				reg =3D <0x30210000 0x10000>;
 				interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_GPIO2_ROOT>;
 				gpio-controller;
 				#gpio-cells =3D <2>;
 				interrupt-controller;
@@ -182,6 +184,7 @@
 				reg =3D <0x30220000 0x10000>;
 				interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_GPIO3_ROOT>;
 				gpio-controller;
 				#gpio-cells =3D <2>;
 				interrupt-controller;
@@ -193,6 +196,7 @@
 				reg =3D <0x30230000 0x10000>;
 				interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_GPIO4_ROOT>;
 				gpio-controller;
 				#gpio-cells =3D <2>;
 				interrupt-controller;
@@ -204,6 +208,7 @@
 				reg =3D <0x30240000 0x10000>;
 				interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_GPIO5_ROOT>;
 				gpio-controller;
 				#gpio-cells =3D <2>;
 				interrupt-controller;
--=20
2.7.4

