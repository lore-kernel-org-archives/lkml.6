Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E756C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F8220836
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TmGS8qEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBVCcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:32:10 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:36352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfBVCcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdV7Qhfg2wpF9TiAkSAHH4TP7FJ9bu9kcip9QUpmxYA=;
 b=TmGS8qEG+ABxjeqCAq6hDg9cSYIOnfmJqyS7XY/Lomr+5J1Sde3tMOHRoDiV83aTsiBBURDAigXwqzeLUx/SMNbGIPaQTgJwWdtQUbxcV6JQ8t4HX19ER2FzoxEE5Yw0S7SBHAPUJ01VSXKAoH/Zx0Gufyu4FSHSXz080b8MQ8I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 02:32:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 02:32:05 +0000
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
Subject: [PATCH RESEND V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp
 table
Thread-Topic: [PATCH RESEND V6 1/2] arm64: dts: freescale: imx8qxp: add cpu
 opp table
Thread-Index: AQHUylbM3dkepF7MlU6VPQE3muhucA==
Date:   Fri, 22 Feb 2019 02:32:05 +0000
Message-ID: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4daa63-7ae0-41a7-494e-08d6986def47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3771;23:FPZcchUY63NaYzORTau38ebAZvs+5m5x3OurN?=
 =?iso-8859-1?Q?DgKgvbRvutAmUfRMLR8/1287nPdbJLphah6Laf/j/BLme3o5p87bPVZbH+?=
 =?iso-8859-1?Q?ay/aGbbUSy3/5b8cfhfQguJ+0HP/L41DSBRmJRE8YddjFm3JBZwJX+R3tL?=
 =?iso-8859-1?Q?kH+1xS8U+Pv68gfLvD0qWJylcmXoVp6qFjTcZN1jZyNnxLXznMyOe+W6C4?=
 =?iso-8859-1?Q?lGvgDrTGTRxAYDTS1G2iXaBKygsH31p/sOBE5Z8OWrjwxJIgKu7xUidt+U?=
 =?iso-8859-1?Q?k9yFmoDXIjQG7ssVriS+3+Z1PDov0GzW5xiii7/xo0wN8XcSV1HQ7FYQex?=
 =?iso-8859-1?Q?bej0PakCa4Qjaw6QGx+d6M5hOpjj2m58GaPlsTFdius2FzZFw5NJC32z5+?=
 =?iso-8859-1?Q?y8K86GJSaZFidtwmqRU6RngXXqWF7XNAw6TSnHzvj3dDPRccDqlSPhSw02?=
 =?iso-8859-1?Q?aGzXf3ZNlnYRPyQXSn9MmvvXzXdZL+JMaFtsIcDpDg8WaamlAgBzIuxqxh?=
 =?iso-8859-1?Q?Ays0gZJy3Yp3PDGKpzGmPf1jW4ZrJ+jUW7uNAdD9G81222VeFK6MNI89dZ?=
 =?iso-8859-1?Q?EFt+c0FEBhx2E1Mq6ci+9D/GS7MhrzEOUF7T/LSGi0Rg/75beYLlfC7YIo?=
 =?iso-8859-1?Q?SJfQfD4MREnMcTfwoZw/rUNyKZ0BUkmAhM9fwwH9hplCdIlP7OpTT7li7C?=
 =?iso-8859-1?Q?x/F5uCu4qttuQkcD67Z5KcwuLi0wivhhdIvQOdYHoERzwxKZmuSOfI4iVX?=
 =?iso-8859-1?Q?+fZ+W24Db31yAouQhG84Plw51L4g5h67ZpsplLzydHc3MJn9Sh1sxuYuIj?=
 =?iso-8859-1?Q?hlpTocRVTR1sSEKz+c2lIUQqhn+3foLVyy8XSmldLRj14ChJgaRJcL31e8?=
 =?iso-8859-1?Q?kkKvOWEh3xzaeqWtvgMFgHg34ZKk4S2tkobK+a846gNJ6apzvZCRLQNQTI?=
 =?iso-8859-1?Q?wzCmpyNZqZRUU8JFsteZ0J166m2jXCMyqHmusbNkjUvDPOhmjeE9kAIpFe?=
 =?iso-8859-1?Q?UFFI3Jnro/SIKZLV3iFafqeSo1UeLvq0909SKG3p9D+rW4Tl1I/Q8XZ7Td?=
 =?iso-8859-1?Q?ECWiQscC+NKFylUtGcCb6r/FPmpW8bC6yKCKKHIFpqJS+jczkvNul5nK5H?=
 =?iso-8859-1?Q?bZwOyrvIycIaGBqdB1Iyce2aoDruDNAMjxp11VGw3ABJna71pI4IVvK6Z4?=
 =?iso-8859-1?Q?TxSFlJ4OyqeMuhLs5iRFhDfFWySuKL6pgmOUmVsUVWCuFyQN6YO2JHkY12?=
 =?iso-8859-1?Q?yeFMsADyIQrNSorrf0bkFn8aNHdh04SjZaK2VWWOhOhEioO3h8M6Ivy45e?=
 =?iso-8859-1?Q?TN2c=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37716A1C309791EBD9F813BCF57F0@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(105586002)(7736002)(53936002)(486006)(7416002)(97736004)(2616005)(66066001)(26005)(476003)(305945005)(71190400001)(106356001)(71200400001)(8936002)(81156014)(8676002)(2501003)(81166006)(36756003)(6506007)(386003)(50226002)(186003)(102836004)(2906002)(52116002)(6116002)(14454004)(6512007)(5660300002)(68736007)(2201001)(14444005)(110136005)(6486002)(316002)(86362001)(6436002)(99286004)(256004)(3846002)(4326008)(25786009)(478600001)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uryskZ0ctKZlKyhN5GutheaZPsWmJBySJGvvFoHVxmipoy3X9/4S3TaeTXSfoWoshr2rN2lt7l0yr4pGbWkwhe06y4AhtdeohHOZf5mmAEaRrK1D625DThEjWazOXNJP6aFyny0DD4BZUAlKil7M6hGD2woLmTs0qzMavi+PVCSm+WkN1UrMABdcb3YjV7qUkFWIdheky0Y9FbzeEtOfcrLaIMX23MnuZic16gARmFQBqJ8TfdgEeNpm6qzPFz8Rzy3JJ67wfb62JooXzmnBP85iVOK6MZoT8X4cQQNyJBRKSKJI07VWJFZoK6bhoPCxyNHBdRrqOBzu5nLsZVArTdn9OKD14jkW/wZJfHxrw0fbwrQ90vnPiIDN7ib/sxuxY5w+LZm8HbDeD5yCz9VFH6+UiCP8bDUbqcywfc9MWj8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4daa63-7ae0-41a7-494e-08d6986def47
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 02:32:00.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes.
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

