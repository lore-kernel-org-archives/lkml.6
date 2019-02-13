Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4454AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B221222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NydT448l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392487AbfBMTFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:05:39 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:5779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388368AbfBMTFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryoutEEDsQ7ONGVrPA8KXCePme9FGu1zZRqpQ/4RG4w=;
 b=NydT448lUqZxv+eDqZi8wkW4xLtQNjWC8iZjLR3AorMu6ptJNHMA02TG/DZQ4K3i449I0Ml0rgvN4CigXycDMZfzlTFmsq4lstVC5FmzRrCzNy2a1KAAAlnhMcyfnIYET/F+cxYKLWNw9fVwQ81/w0gI/r56hrX9+Qgr0XFkqEM=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:18 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:18 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the cpu-supply
 nodes
Thread-Topic: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
Thread-Index: AQHUw88PEadq5tNj9UipD3QjqB4ZgA==
Date:   Wed, 13 Feb 2019 19:05:17 +0000
Message-ID: <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bd6f982-d307-42f6-d16a-08d691e63157
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4515;
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4515;23:meddIC+CMEV2zyUzNGlJumSa9tl3veOpFwL5777?=
 =?iso-8859-1?Q?5uR9cO5WzOGMgRkyPAk6ICWnaCoCfUADSSIK4K2zlaQlg06NJ6haEDNSEz?=
 =?iso-8859-1?Q?/zQLHK2Dq810okFiW2RtyYTnbO9j/0k9zjDHsiAmvifNo2lcsvg/Wqr0N1?=
 =?iso-8859-1?Q?64wWRZHHIXIGC0wug6vFv3tnL5WjkYKOiFfBI5HmVWTOIeacD73nUbgYNL?=
 =?iso-8859-1?Q?GyyadIYXhAqiOTGfTzLEs87VnskTUuxi41uvOei2mP42Vfv4npjq7fCo6t?=
 =?iso-8859-1?Q?reE6ywLOD9mhSLZsoW1qr9aypqsDjDoZGYSQT3SHG7GkbNp7suUEzLPXVK?=
 =?iso-8859-1?Q?TFREJN+QEZ4O0gwWviuKEc2ESB7ipVNg08mmLwFCYXFS4E0dKkyIEY+Iwb?=
 =?iso-8859-1?Q?KB5VS5O2iD7qoMn8Hn452IuMorEdi2GaoOlXbJLSH5vU3J4yKhuKgevl1J?=
 =?iso-8859-1?Q?4jwMjOlrxxnwDr2utuggPVJEFjdTlNyeSf0jtDTst8bI8PB3JXeT9CSboo?=
 =?iso-8859-1?Q?tPm4lab1KNCMRbBVtoL9vWbFD0CvpC2oIs24rVfL3BDiozrHCg4lfT2kLU?=
 =?iso-8859-1?Q?9wtDCdVZEZ+D3ZK1Ugk3qxZmgTPpRRC6sFlNBgzVbsSKjSn33kj1k0Oq2g?=
 =?iso-8859-1?Q?nTbhiMMry1CrReObBs7V6qpJEa9RXtNXUZy+pkXwcWk4se2/AzKgjE3WEz?=
 =?iso-8859-1?Q?w32KqdIFX9wJAKnP30vHFZs2mVWox4AAv0rZduqnJ+Phpot4KeWoUsEXd1?=
 =?iso-8859-1?Q?doxI4wZQezP+el0DBVPgmHiDB0jdIS8MX1ooTtJzr0iyPA1J+9vWNVE3kH?=
 =?iso-8859-1?Q?cUIoJUebunroCADIlwplG738UezS9IDegjYvImA/xL5Md1CzR+6r6HTjf9?=
 =?iso-8859-1?Q?/ciss11x+foK0e9wTZ4pypGU4AUbuzb7v41WOEsfkZYUZksvCNDhYniAzj?=
 =?iso-8859-1?Q?cDoWAxbzPm/h4mvH0X7MY29d21hjHc0EXGR4SZWXeoc0MmzzQJXKwPZAhz?=
 =?iso-8859-1?Q?It3IanJtsbWK8RdTc4LrffHYyB1olkUPsc5/GoKVIoln4vNm1tFWy5dIui?=
 =?iso-8859-1?Q?mH656bTAWKOsCdTUdeSvG+oQ6H10/Bf2t/D2+5ifnZRA0ImuuiZvbR6vLe?=
 =?iso-8859-1?Q?oS+40JOIOcUoUBljFhvXXKDnqy5BguAnlrlEJAygRPuR+3zWrKvljyppd2?=
 =?iso-8859-1?Q?oiZ6SrbGKg/9Zq/LgRVALm+LU7iufgE+3lyDPkjY9GfiMEuohbmM7b9HvO?=
 =?iso-8859-1?Q?vM7zVWZuopmI/XDwJFdDid/96/FfyBSuUhC175L+h7v7PGwgfKXTBS8OZD?=
 =?iso-8859-1?Q?S43gMuiA81YSGxRQFqEYq/X?=
x-microsoft-antispam-prvs: <AM0PR04MB4515A4FEA456D6463B632687F6660@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(6636002)(3846002)(6116002)(99286004)(106356001)(105586002)(7736002)(305945005)(25786009)(97736004)(14454004)(66066001)(53936002)(8676002)(81156014)(81166006)(68736007)(36756003)(8936002)(478600001)(6486002)(6436002)(6512007)(50226002)(110136005)(54906003)(316002)(486006)(186003)(2616005)(476003)(14444005)(256004)(26005)(102836004)(11346002)(446003)(71200400001)(71190400001)(7416002)(6506007)(76176011)(86362001)(386003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4515;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o6NNvcAg7s7zi7N+1J7Rse41wT/BRqbeStJFuBuKSOX1oVmXMnR1SAltLM8vbqfL4gk8Sphcu1mrQ2K2gAYYjhApCANoGLmKJTQgE766wZkVz0wobaUT/4b5yqe+h5XSIKi/iz0O7qNakJITGLqBPYAvLtq/8x59bO4KWOW2oils9bZQ6b20JxZ6gKWuu2e/G+VwiNqo72RLyR3jS0nbNgGOfDUz+OenpO/VwPtRxFUzwMMpX0Vp+ppBA5RLQMApn8ZcbDIR5GkWJiBaIZqFLdD5ArBy4N4qrfvFWW/uA0vuOxK/qMAvgkh4jFgC0YXeLus36VEDhwR7AHTq5/k6zOW3bxIchQq07VpcJ5lYWBLz9Zvbif49szw/xlkM/QPhtA+Aq4V6JYJjxnGwU0zpqylS8/WcZqZZ6wmK1xaKJCM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd6f982-d307-42f6-d16a-08d691e63157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:16.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the opp table containing only non over drive opps.
Also add the cpu-supply nodes for the A53 cores in the EVK board.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf..114359e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,23 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+};
+
+&A53_0 {
+	cpu-supply =3D <&sw1a_reg>;
+};
+
+&A53_1 {
+	cpu-supply =3D <&sw1a_reg>;
+};
+
+&A53_2 {
+	cpu-supply =3D <&sw1a_reg>;
+};
+
+&A53_3 {
+	cpu-supply =3D <&sw1a_reg>;
 };
=20
 &fec1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 1a89062..89b2d5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -91,6 +91,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_1: cpu@1 {
@@ -101,6 +102,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_2: cpu@2 {
@@ -111,6 +113,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_3: cpu@3 {
@@ -121,6 +124,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_L2: l2-cache0 {
@@ -666,6 +670,25 @@
 			status =3D "disabled";
 		};
=20
+
+		a53_0_opp_table: opp-table {
+			compatible =3D "operating-points-v2";
+			opp-shared;
+
+			opp-800000000 {
+				opp-hz =3D /bits/ 64 <800000000>;
+				opp-microvolt =3D <900000>;
+				clock-latency-ns =3D <150000>;
+			};
+
+			opp-1000000000 {
+				opp-hz =3D /bits/ 64 <1000000000>;
+				opp-microvolt =3D <900000>;
+				clock-latency-ns =3D <150000>;
+				opp-suspend;
+			};
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x38800000 0x10000>,	/* GIC Dist */
--=20
2.7.4

