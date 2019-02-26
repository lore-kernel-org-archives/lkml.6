Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0F1213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lV4tPH4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfBZFSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:18:37 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:10304
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfBZFSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD7wqpx2+ZsSaSB6C4jsjF+MZN8GpZOBM5yy35QdDAI=;
 b=lV4tPH4eCnv52og8EF7LusDwjrCWSnEcZ6Yq5q7/9M3YCpCo2IXonPc0UqC4BowZ6HYdqMoM1HUbkhxIL7qAm3qKKQkBKZ5KUiL4mdGp6+yijB4rJCMS6Ru581NpBMGpudGOMdPlpa/fOMU3LFqgOqBhrL0iDuMzx3AcNFE6dgE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 05:17:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 05:17:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUzZKTh0f7Vnjj2USCuQHnsmV9dw==
Date:   Tue, 26 Feb 2019 05:17:31 +0000
Message-ID: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e754e663-9e6f-4183-cdbc-08d69ba9b55c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3849;
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3849;23:MawrSe7Fxma6l3NR8hhek90bDYKgqPLMQrIfy?=
 =?iso-8859-1?Q?3whE/r6IFWBSk+pirls0EKFMDjaTbJIOwps9y1MAOQ/vRsH9fRWxmKKtgp?=
 =?iso-8859-1?Q?myn9Mo25XDunNIj03YBttHB6/gdjIAyG/eaPeewV4hbJWXsl321rgy6065?=
 =?iso-8859-1?Q?Q1dUWAgGmndn3A93BT5feD+0ki8eNBX87XSG9wBxgNU3tFZW1pdNr7jhNu?=
 =?iso-8859-1?Q?rzAcFYQLQwcMiI3+AQBhkltp/6d8UdvFMuHkHPKTPsCkaLVkzJJM0hu1Q3?=
 =?iso-8859-1?Q?vlxxySxhgOOVJlLqDIZGPJSPpVRshO6NQvyArvnk4ejga1SBPwqsD95dXS?=
 =?iso-8859-1?Q?tHBbgV0BtV41F3g9jhnjHUSKvetcuWfFtM2ZOkK0HmzJ9QVqqDC+9mGTHx?=
 =?iso-8859-1?Q?Sj648MOdg71vw6//5NHTPurNbg494wfJ6yMWEhDKyEGn/ALpHL1qNKWCeN?=
 =?iso-8859-1?Q?kXydUIw4Q+omBIwyJcFtjEw9yntVI24rSViUzEKRvraMrBLQLf/yi/qG8o?=
 =?iso-8859-1?Q?P+Bzj9H1QWHmIfYBWTgMmJLb1QNU+2IDdf+cmSHVrXNyg5coL/KErsOQcn?=
 =?iso-8859-1?Q?/8JTfPv/Zc8aEtTRQPjYeHA5vgoe1r7rCePHTgqgvayj90bYZ5bbJRtbc9?=
 =?iso-8859-1?Q?KLzErgQMlq5/8CsDGbjlAD2FSo3zjlS+ofulBhr2st2WJetOnpZgKWIqpq?=
 =?iso-8859-1?Q?V+ahwveKcMxRG+Z9Avk2Rue/o0wcXWeFu1F1LKEZPH2s6VN8eusRq7edzb?=
 =?iso-8859-1?Q?mjxply/Y0rspqG/6G5GkzU/eUUN1ETI2jez0n5XtZyLjBHCM4VXu8hPzmF?=
 =?iso-8859-1?Q?JFCc1w/LBlZ7RdwAKeSibnviL08+aXAabxRVvboWbck2gQCIeewswHyPnq?=
 =?iso-8859-1?Q?EBlfQTiedw6fDMJaBbNesvTh9MBYtQQzuNG6OP8DBNGROJvUw1MaMS9JZ1?=
 =?iso-8859-1?Q?ckc66/WK8MtiQ5LFYf/AHCqgXuOdNPdXH6WG8Zt50BONfbjSoie0LS+pmX?=
 =?iso-8859-1?Q?Vu4bhQLMxr3thknX5MMtrutIPHHpzvsXt84BlqxU8BvhrLjs/lIdUPb5+y?=
 =?iso-8859-1?Q?m/++c6SqEvbYb0JvjBCz6LKrtalpsI/s7L5dyGywiF10RgTJkz3V9pVYgz?=
 =?iso-8859-1?Q?8qx8pcOrDWWzd6wTpIpzkdhwgI8zVbfXe2mlX2LHJKxfBCXSMnXzASNvkH?=
 =?iso-8859-1?Q?/NTjBIZywzUksd6Rdnnv4O8XUnL5A4shjtsOIQ46kadrJ2r3VjEroom6d/?=
 =?iso-8859-1?Q?vvlzlD0QLhCZUQLFJRFKoSPvF5y5aA8aovfmi73fanBsV03HkvlweaJXp6?=
 =?iso-8859-1?Q?1fKu/SmbZ6sXw5P/MChXOO9PR/2Qk8+qn0OzEg1Nuq1xRK38kv0LwdtHbe?=
 =?iso-8859-1?Q?Rkv20I+k0jFjPdzLkE5F+TuNQdznse4?=
x-microsoft-antispam-prvs: <DB3PR0402MB38491B6266E84CA777057F18F57B0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(6512007)(476003)(6486002)(186003)(2616005)(102836004)(26005)(52116002)(4326008)(2501003)(86362001)(14454004)(81166006)(6436002)(8676002)(81156014)(305945005)(2201001)(5660300002)(106356001)(97736004)(71200400001)(71190400001)(7736002)(105586002)(8936002)(486006)(7416002)(110136005)(99286004)(50226002)(36756003)(66066001)(68736007)(386003)(6506007)(478600001)(3846002)(6116002)(53936002)(14444005)(256004)(316002)(25786009)(2906002)(32563001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3849;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wB2kLxqhvJJWzZAhstvGe+MrSpwtHkuADF8uoMkWpYXaVpp9a3qqRqqn5o0dmhy8mjODKqiMf9qr/g3y17MbL30xpw03L9tp67Je5uhki+YrICsyzTL5u4MUwT2myf56iMlP9AA4lFjUy0Eq+bL1esxliZbT3x0I1c4JNhlL9UYf/wDrcvVNQ+6GQPx1aGngro/W65mDMq+6ej0Je8LyA9xZ+QIuf/h4kzNiBOqq1vsIYZbybJj+TzwJC1W9mZmbAUl9KrdL1oLf37g5xuJ07ZIuj29g6z3q0gFS6OL8gg7KNWAq9/ZwC0jGrKHSlCPSLfJKBqomqBsnj9UUS2vB9xNpnqaHqHu5jG/gyqEkzmCaN7Qd6cDmoPCDgmMqE8K67AO9c256Q5Pc0iYbuqKbGKVyh4p33Q9fd4E8dMRAOxc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e754e663-9e6f-4183-cdbc-08d69ba9b55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 05:17:26.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes since V6.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30 ++++++++++++++++++++++++++=
++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..41bf0ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,9 @@
 			reg =3D <0x0 0x0>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			clocks =3D <&clk IMX_A35_CLK>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
+			#cooling-cells =3D <2>;
 		};
=20
 		A35_1: cpu@1 {
@@ -42,6 +45,9 @@
 			reg =3D <0x0 0x1>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			clocks =3D <&clk IMX_A35_CLK>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
+			#cooling-cells =3D <2>;
 		};
=20
 		A35_2: cpu@2 {
@@ -50,6 +56,9 @@
 			reg =3D <0x0 0x2>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			clocks =3D <&clk IMX_A35_CLK>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
+			#cooling-cells =3D <2>;
 		};
=20
 		A35_3: cpu@3 {
@@ -58,6 +67,9 @@
 			reg =3D <0x0 0x3>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			clocks =3D <&clk IMX_A35_CLK>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
+			#cooling-cells =3D <2>;
 		};
=20
 		A35_L2: l2-cache0 {
@@ -65,6 +77,24 @@
 		};
 	};
=20
+	a35_0_opp_table: opp-table {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		opp-900000000 {
+			opp-hz =3D /bits/ 64 <900000000>;
+			opp-microvolt =3D <1000000>;
+			clock-latency-ns =3D <150000>;
+		};
+
+		opp-1200000000 {
+			opp-hz =3D /bits/ 64 <1200000000>;
+			opp-microvolt =3D <1100000>;
+			clock-latency-ns =3D <150000>;
+			opp-suspend;
+		};
+	};
+
 	gic: interrupt-controller@51a00000 {
 		compatible =3D "arm,gic-v3";
 		reg =3D <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
--=20
2.7.4

