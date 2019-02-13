Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDFF21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p/cRJGlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbfBMP7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:59:45 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:13280
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730572AbfBMP7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHXz2+FUS/VHeiWa/j+43jwzAD+MD+1EGqw+1btN3lU=;
 b=p/cRJGlNwkURcsk0FHUrbsCvrf5UqzjD+1q3OQOR5AFSwvy61rkkfAQ3AN3PVnvIpuBM9UDt/h/pEYEaQ+OLO41LeWIe1doeijUVUOujhzwRxIYbuP0Sg1jZku36hwJC3bVYRgstlr0dtSoo6g56HamPof4qrE1TXWpHJI4rnzo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 15:59:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 15:59:26 +0000
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
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V3 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUw7UYIapkzXxoY0C+x5/bBBNPUA==
Date:   Wed, 13 Feb 2019 15:59:26 +0000
Message-ID: <1550073243-11242-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cdcbfaf-bac9-4f49-d844-08d691cc3a28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:uAqxFrQMkzSq0O/qVADGaELb6HXCYgi/CkHAx?=
 =?iso-8859-1?Q?E4rDVHNItXIdGhBBPgRkV8GNIl9FKuqnFuN9B8HAhqC7ZA5qJpN3mecxM9?=
 =?iso-8859-1?Q?gshHeFTQaT6xkhLj1wSHv2e3GrJd+bp22PrilYOVeDW+ixMaS/msQUwB3R?=
 =?iso-8859-1?Q?+mPvki2/8ZIUXcpuApSdpK1dc90XjQ/ki75Y4Kt9QfdW+Gaw8YH6gVkVQp?=
 =?iso-8859-1?Q?/EA/CgPKLco4uQBom6fTp69siYrs5cTJgbaGg8eVusSUYQxPw5XYNhCexY?=
 =?iso-8859-1?Q?9e0R/2SqI0MaFAXqtrcfOfnaki621CdQ3pVgzCr+nM6sgzahS9q+/jfzmn?=
 =?iso-8859-1?Q?Fctr9UFObKDLEy2GA1ILa8AzUwaExJ4pxKfzlVcKpCEa/yNgo52scLgQjl?=
 =?iso-8859-1?Q?eo1Gzsxc664IWdjBlFvahH6ad7FODzEGmHnei/HVRp7eutLs1cR/MtuvbH?=
 =?iso-8859-1?Q?RApUHcOi4R+WthcwspjRoK89PfiUmqaF3IzjvY+3wYQUZ5IPxx26evbh/E?=
 =?iso-8859-1?Q?PgnRsGfZW0jLZmKLebj2MxITjiZ2P/lRawbqw76befVmyf7qnL50GZOiDR?=
 =?iso-8859-1?Q?zcOb5j3v7mwRB2DevZfWEwwu/fNBR2MFz2H3ixZAAuSC4/AFk4Zua8/0IR?=
 =?iso-8859-1?Q?WL4lrvoxMoG7Zm+aczjcyfGSbhTWk1bNmvTrMHbS31XGHwwoQ8YI+5H/Uj?=
 =?iso-8859-1?Q?wmTTPL1XfGAPW4t4q0ms6i9LV4GJkMyWFvyWJ8XYIX6c6ds/HgyRi8fKgp?=
 =?iso-8859-1?Q?BLY+Rd3b29eeh2WDx59J9x2tJ3oLLgqaML2s4kH/6nwlm8eYgbOcuhNaDs?=
 =?iso-8859-1?Q?VmxbWti5JLgtMM9tFZnUs8hoLUmeDiEh8ic+s5raSJHwiztboZ77wcw062?=
 =?iso-8859-1?Q?BHxSciaE6G2BjEWKPzYKZzu3KgqALDkw6Gvsg9KZ0jsnw92zvbKyeBU+N5?=
 =?iso-8859-1?Q?+qQrjfYD2mUCrSmpy/5P2ipDSWsOfe0JmYstCPXrSHnVBBZeRcIZIvCBzn?=
 =?iso-8859-1?Q?jvr6Pk18bzJSaJJw8us1gNq+sql3bGLVf1NyXBzyV9ygebXnb3+Di7uk+B?=
 =?iso-8859-1?Q?ls6q6qCNYhnLbpxJtoDHHPx7iClRCkr7FOWJWd8ZESglGjQq5Gmp/R7T7N?=
 =?iso-8859-1?Q?O4gJMg8kO/dWOAx4RxgcBbxJ8ukcEqLrKf1tkFKtJb5+UA1u6Pm3B/Espd?=
 =?iso-8859-1?Q?QNsvXpPwykbXeQthfWnTQm2sGu3YOyoSb1mBDKkzVDXepLav53GE2T0DOX?=
 =?iso-8859-1?Q?7Uir/w0HyChRxTN04+u?=
x-microsoft-antispam-prvs: <DB3PR0402MB3756BB362A3C7BA742A9771AF5660@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(102836004)(99286004)(26005)(386003)(2501003)(52116002)(256004)(2906002)(6506007)(110136005)(186003)(486006)(316002)(7416002)(14444005)(476003)(2616005)(105586002)(106356001)(8676002)(7736002)(8936002)(50226002)(81166006)(478600001)(81156014)(305945005)(14454004)(25786009)(36756003)(6116002)(66066001)(97736004)(3846002)(6512007)(71190400001)(71200400001)(53936002)(6486002)(2201001)(6436002)(86362001)(68736007)(4326008)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9vbcBWEjjKTNtTDMONWLOZLmQaevWIxw7dh0CG5IIyl+eMhpb/AkGJ83OnHtFPHEtBeoZdf1I2VKHwQDZmVfkrNx778skK2CU4iNPbi+ovuK7QY5RIvBJiDo0wuQlA1UawAv7X+mA7ax8sHQFeq/yUg68NZswU+ItuWwT2qaD6MXpb/xgV4f5k+CzGTtODlSJ6MLsM4ZlJ/fQpQnh4yfC4wYPWbHP7mKoxLFbJ70Cgeov9nPVAzc7F/8HuxtrQz6y4qsQWN9zEOlwpUqvKLNFf00mwJxwyF1pzz2Y8VEzW/w0awLyTVvnddELuqn9D6qDcaSGZnP9zq0fZJ1DMeL2HQlmCLCtORQXspqWHb/5Nu/Z5kv721UTis0lbNFLHtMbBGETx1y79zpvajepOeyel0IlhHEgivijadMFidwhMY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdcbfaf-bac9-4f49-d844-08d691cc3a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 15:59:20.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V2.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..1e08387 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,10 @@
 			reg =3D <0x0 0x0>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			clocks =3D <&clk IMX_A35_CLK>;
+			clock-latency =3D <61036>;
+			#cooling-cells =3D <2>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
 		};
=20
 		A35_1: cpu@1 {
@@ -42,6 +46,7 @@
 			reg =3D <0x0 0x1>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
 		};
=20
 		A35_2: cpu@2 {
@@ -50,6 +55,7 @@
 			reg =3D <0x0 0x2>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
 		};
=20
 		A35_3: cpu@3 {
@@ -58,6 +64,7 @@
 			reg =3D <0x0 0x3>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			operating-points-v2 =3D <&a35_0_opp_table>;
 		};
=20
 		A35_L2: l2-cache0 {
@@ -65,6 +72,24 @@
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

