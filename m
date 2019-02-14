Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A07C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A39021904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vqIlewmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392478AbfBNByr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:54:47 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:49376
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfBNByq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzOiSwPPqH3kRb3bgLzh3GF5LAazsOKoCdDasjtZHh4=;
 b=vqIlewmARyphyCu0c3zFhe9EF6oEg3RJTDXFqAPxxzqobfVcWKkluHNn8PcG4Il4BgfvahZ5+j5f7TGkLhwSdwnMP4mb0ON9JBwivv0GXJVx08yw8PSEYe84v83MpYoW50Kcz4BzrQmi95ykzsy9NlTzaWmWodmY0kBxomkY3Fw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 01:54:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 01:54:01 +0000
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
Subject: [PATCH V4 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V4 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUxAgoEGMMDf+QVUa0wIDEs6tvwg==
Date:   Thu, 14 Feb 2019 01:54:01 +0000
Message-ID: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 846dab60-e264-41e7-f493-08d6921f4a69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3850;23:6VWDYLLiWShfTLjYqaT7anv8mn74de5ifqPa3?=
 =?iso-8859-1?Q?kSRRZSCpl/6EzFpmMTO47neOb2UXfAM4NWOJ4F2b9/HZE00Icye3ctPV8c?=
 =?iso-8859-1?Q?lmrQP1w0RN/Wf1H2GdBRKXgM0fI6B9XkYTyNQO2F4QClVqcXXaEkZeUa4I?=
 =?iso-8859-1?Q?47Gv+W3fwqyCVGJnVBnK2yKhJM38LcyZg9IXC04BJtbk7LmRYO3BCO1jo6?=
 =?iso-8859-1?Q?IQkoOal9gYJ0fj1stiByp7ISWBJEah3zC2QIo3ut6Wg7y3Qf/BeXWZFWaG?=
 =?iso-8859-1?Q?/DRnF6JPdEPtD9K7p86IOiDIhN2/pwegJ6JV07tC6cdKuUBjHnzdjk3/H+?=
 =?iso-8859-1?Q?FhLypMP3/4ep38XcWM5fgGifyMjWN6ZZd5gG+jaE+YEdgipzYqF0/HCfiq?=
 =?iso-8859-1?Q?5Y9nRb8tf6LTbNrhnVG4DFCIUGV8LSwWzqDdCrWfxclmtiBbCxaNJGSTyw?=
 =?iso-8859-1?Q?D3V6GgcNERvkAk3HwN8PxSG5WcCFA2obHc0ndBzpy8ADxb8TdWz7YZ1KEZ?=
 =?iso-8859-1?Q?Kiu/yrjRmv6T2/H3WfdtXSALdnsVFV3ktF0E8IKhyaPu3xZri4wn8HQgVY?=
 =?iso-8859-1?Q?cS/TpOy8Bcgz1xuxCsJ70JVhkTXbTr6rZwei9DFU3JO51UUsQOi1WZPqfz?=
 =?iso-8859-1?Q?Rj+qq36C14KHXEEdfB0B8/lFvSVbvNSnwh6DJysjZZ2sYm3sH2MGHNL1R5?=
 =?iso-8859-1?Q?yuRFY/mtbzH0ePimsfyHrsFO8dKcbdFzFjCJ8nvJCCOaWVfkm+MRDHBjin?=
 =?iso-8859-1?Q?2bVjBQVkqhrZAcF/C3vBvy2WF5fvXMpL682bp+zl0GRZ5gdS1MyLQqdthn?=
 =?iso-8859-1?Q?D5iumWfwK81nt6sryj+XkJ1dASJvDAzrt+G75cg48BfGcqA5Rgft17Tn2O?=
 =?iso-8859-1?Q?sxyOmh2XwTUuBNkQPz9+x4D76ZyWa2vz/b7EcvcheCtaobhbxtrVsMEGaU?=
 =?iso-8859-1?Q?+Tn9Jt2TyGmKqXlGHFXJ97+sG5rckLmRMRwcKfHFFbMm7qfQFLf/atz5Je?=
 =?iso-8859-1?Q?BvbNsPPj+OsCRad04vPsBNuVn3CIfAD6aykNd6e5Bmk7O4++KK+A98cbmh?=
 =?iso-8859-1?Q?Fvbmphw6EIGcXYE11LQtjN8sGfkURSN1S3CSQWsQdADDchW5vMeq59EILN?=
 =?iso-8859-1?Q?SufJhrXrgLMPXzF9d13XgNhSQhoVmF8cmFGLVAxsDqLTjbV42g/8/PRybC?=
 =?iso-8859-1?Q?xgI4zxSDH726T1ZqekdVyGCs+mtSARYVZTwg/dx1k516NTLqTh+H2OysRR?=
 =?iso-8859-1?Q?IjYmAI0EtdSJNX8lmtVCSs2ddbrmR9Sn8w4uS9IFA83uHUwl+aPFCyTStu?=
 =?iso-8859-1?Q?UGl49FyV8UKso3NqPpQZt8mjWHjPTQqipH3wp5hoLpYdh0FWvcavAxk7kH?=
 =?iso-8859-1?Q?MeW41feyUw=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3850778F492DDFE05DE6FCCEF5670@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(256004)(71190400001)(52116002)(6506007)(7416002)(99286004)(6436002)(2501003)(14444005)(6486002)(6512007)(4326008)(26005)(71200400001)(14454004)(386003)(102836004)(478600001)(305945005)(2906002)(2201001)(36756003)(105586002)(3846002)(486006)(81166006)(476003)(97736004)(66066001)(106356001)(7736002)(86362001)(186003)(8676002)(50226002)(53936002)(110136005)(8936002)(316002)(81156014)(2616005)(68736007)(25786009)(6116002)(921003)(32563001)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xrxe4mDLi1Yyisk42/jJa4bO/4/c8vU1re+HywOf4Gqx2qjm42QJdb67ua84wuqPremnCBgqoz3C+FuJ+yWM+5UczZGz03N3dcHWW6mmG7JlrMbNL2kaN7TTN/c74Y2m6HGORyO+d9V1i0QuKjJ/hNSNkzdr7kmRYlSD8RJtG2C3jE1SVKlk5asg3O3aPLsFnlhR0ayyKXZZWGqTXdwB6w87knP7o4KwrhtyiUKUgoruVAnmow2gW8k5C1VAlh+yPizOTqDOHn8SqefgYS5XBvRSmuokJRom+FJ7TPRNfZrtPB09m6NmWZOoQg73PUE3EJqkYf6tBNzqeYGXpTt0Qpopoda3qPVGrCZuwK1lB838L0PlHSnOfiz3ztiR2uv/h+1GYZp5MbPZiR7Mqb31IzGBr1FXTqDDbB8IS9GanLw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846dab60-e264-41e7-f493-08d6921f4a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 01:53:54.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V3.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4021f25..593e2db 100644
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

