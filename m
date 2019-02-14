Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BF120835
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xaEk+8/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393237AbfBNJz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:55:58 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:15296
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392838AbfBNJz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aFI7o9PaamN2AU70fkmnBLQnt/J0ctj1ZKUp0I5VcA=;
 b=xaEk+8/1j6E3WyfexJR1P/d7lhARXfmJlEn3+iEjAOpoSDHqENyCWkB922lzA5FWaAkVJqKFsv9P6VtcNtu8Fbh07ocoyPGzY7xCnOAPuYGoP2pH0DN0yTmJgySxi2QUAs9VAWVW5a0Sg9Ng4GkOaVzO4n4BylUiqgduZC5HuME=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 09:55:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:55:51 +0000
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
Subject: [PATCH V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUxEt3Dyj538gXXEiBj85l935Pcg==
Date:   Thu, 14 Feb 2019 09:55:51 +0000
Message-ID: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b07ef332-4066-4210-0303-08d6926299f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3818;
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3818;23:Hh1E3ZI5pFwYhQht4yDif0/5FWxc8d2Pd2ckR?=
 =?iso-8859-1?Q?YZlNHzPWJ5PFbgyRNpR5eV++j/o+eK7bAeF25PUK7npJJkrzzq3LsyAvuW?=
 =?iso-8859-1?Q?kxLqkEwo4gKwNRHo7kw0IF+qH1BP4Gg4BeXiAfWH3MvpIVU1dROTSrCyFR?=
 =?iso-8859-1?Q?9qSZtwS3YoFXV6DdrQkKKc5zybOoz105Gr3Ix5Jv28ROzdA0syS/Im6Bn3?=
 =?iso-8859-1?Q?Xulh/ic5ONiK/sfH3uDNV0ObLLtyEK2ajTAK0kRW5tzxgz7U6qabIOGzbG?=
 =?iso-8859-1?Q?qiY/XSqs6/ubtm7LoQXGuphbePu2p55Dq+zTl1iJFeWTkwgf+c7vgr0C1y?=
 =?iso-8859-1?Q?uiaWUNUSsp1liIBGQ1zzBMUV3kZQwWHsSCsnSK6oqSTIyAeN71AQXoj0y/?=
 =?iso-8859-1?Q?KzaOYgyzXJfjyrqbJC1oOwhsrKq4YX/UUXAwgJxL3g5Q1J/tAlul5BT24+?=
 =?iso-8859-1?Q?2AbVEoV4rYCVHgTow6y3ujRmp6BrXzl+YSSBOdARxFcUWMUsZHhaBecPeO?=
 =?iso-8859-1?Q?+nFQrcA68LGDks+lBh4rObaUXKXSU4JtRQFGcXZaE6Yv2CEcvTl8nt/6ke?=
 =?iso-8859-1?Q?UEnOverrS8lRlHfoOIEyk8fJESjnqxjlhzvT18P7ZrwTKng8l/VQx2hpsa?=
 =?iso-8859-1?Q?H8PqEKanzh2Ziztb1S7RYcPxTqpCQzR0IZVvsm/D1NXN42uR2PYX1fPzHN?=
 =?iso-8859-1?Q?WNqCNQjtosjqHgCXmxYiEq7P/vG0+dgMLaIQ4EnLhaBS2PMB79CAH7vfb/?=
 =?iso-8859-1?Q?43pR5sehHY3JDDrT+qwI4xhBx2T3Q4L0FCqO1qUe6O/d8YpS2Bai8uVrWg?=
 =?iso-8859-1?Q?GXzuGAEedf0zk2S/RiVy+gQg8jPz2kdlk6wI+6UxQh7Ad+m9rzlAOSLUm1?=
 =?iso-8859-1?Q?y3FAtAHWWcppIC5434b0NQ31QIpo6AOXBD0ca7AoP7cCd5yMDAPnVECpXm?=
 =?iso-8859-1?Q?bYhJUfVY7uTJn3BhPJu3wgS8QY79RQOlwKCHVxdROB/dKf2LiU4yaonbGH?=
 =?iso-8859-1?Q?tU9LNsgYQ3mLgvm7Y28QbO9MzmN1nkD6CQY4EHuyBWnxRxKWixqemR19dH?=
 =?iso-8859-1?Q?I4OhAFujs6ilo/Kj7QxlnrH2Ve9EgbG94JG6Uz2Vr9IAiWvPzivcDj/0Pc?=
 =?iso-8859-1?Q?+ADIUQ1WhvNuMKGR2dQa3md+9pl4gl4SEu0DC2YLcgvMWr/C4XGDK/RMGl?=
 =?iso-8859-1?Q?Cmg+tpdEv63Oq1nJ7D1qHJuw0Kfu1emEdUQSwWkqeezBAv4xLmU9ysydL5?=
 =?iso-8859-1?Q?UW02GVBSV/DsbtUc+gI?=
x-microsoft-antispam-prvs: <DB3PR0402MB38183228B289763450D9C13EF5670@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(97736004)(71200400001)(8676002)(71190400001)(256004)(8936002)(7736002)(2501003)(81166006)(2906002)(81156014)(14454004)(52116002)(110136005)(305945005)(14444005)(53936002)(50226002)(6486002)(316002)(6512007)(68736007)(478600001)(2201001)(6436002)(486006)(476003)(186003)(2616005)(36756003)(6506007)(86362001)(386003)(26005)(106356001)(3846002)(4326008)(102836004)(6116002)(99286004)(7416002)(105586002)(25786009)(66066001)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ABKvUneXqX5+kVnxzIOwe54D1sd/SIW96DT437en/tYFvkVqxg+W6kJULFmZNLLaaWUi2o9xZkPU2HjeMJlLqUfBB9QXJYXNr/O1TFt7tO/8rSWQMiUSeO6dqf2YfPBJmsvl0jv/fxqhoXuiVwjhauL5zs/tYkqf0wdYAz9C2IIkfaO+zVX/Ymbs/oGXd8wrFL+ihVCbdcPNn3243EAnTY0AqpxhSB7Usdw6VpIfOwL51L+u02vGrwv7a995bbBpRcH/UrJfQNgoiHwHEuNSa6YVodJIPLcBuRv2AUN+kLO8XmK0dpu4FQmQbXPb0xWtqUTLOKe6BmUr0Db6gCwfXj0T+IXHANs5u+Ist6VS7uF2/vumYEfSMq4iafEBg034Tr6O5OGvr5/k4joNfM/FfeStK7XnIq0dwfutG6Qyw+c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07ef332-4066-4210-0303-08d6926299f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:55:45.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V5:
	- add clocks for all secondary CPUs too.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30 ++++++++++++++++++++++++++=
++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index aea6812..b5b2dc0 100644
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

