Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADD7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1983A206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b2AdHy6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfBWDTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:19:51 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:6192
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbfBWDTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mnV7v4J/R+9M2m+85MnLUCSizdkFnf5BiF8/3iY7MU=;
 b=b2AdHy6R4iTOTNZ9xz//Q6WwR/Q5YvUC6rzOfZwCEg83B+Rtt7G1RQqWWewcvrlbkBjHLuGnfnrMlBMZpPBLOMVRor28P+7oyGFrEC6t1NvN44sGj01SkZCXwj0ZQi86B0nBFjxuyYvr7p//ShP/2DIvqdGajJUJBuPt+/ES/2M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Sat, 23 Feb 2019 03:19:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:19:09 +0000
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
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/2] arm64: dts: freescale: imx8mq: add clock for GPIO node
Thread-Topic: [PATCH V2 2/2] arm64: dts: freescale: imx8mq: add clock for GPIO
 node
Thread-Index: AQHUyyaKrmPEmv52tkCys9RrGO55Gg==
Date:   Sat, 23 Feb 2019 03:19:09 +0000
Message-ID: <1550891665-29082-2-git-send-email-Anson.Huang@nxp.com>
References: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 793cc2fd-a82a-4df0-d91f-08d6993dacdd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:sjriJiI3Uk9ff/4ArC47OJMKir19nheMnMuHU?=
 =?iso-8859-1?Q?0wH9dKf+IejqAIy+NE+PYdpUrET1F90kdP3pN4SmD0erM4IYJFPVYOBofw?=
 =?iso-8859-1?Q?xeng75+PvzDLEW0k33HHmmf3W75ST9xf6QuM87U2h5JxuRXmgyc4tH1bGR?=
 =?iso-8859-1?Q?enb8RoFbarKcCSu4RA1pA+SHlv5N3C1MXHzZPzlJqgY783se9Qegh/mOLE?=
 =?iso-8859-1?Q?TNaUubwlGEKGmq8pkihj+zCaRc9tNbkSYYKddXQS0Id0wcXhTcNM0wtwh5?=
 =?iso-8859-1?Q?5Avzyn/KN9fd/OzwjOZUXwYSBbhreLNSDHU226b96/yxmEsW7F4zrZAUzB?=
 =?iso-8859-1?Q?2JYcn2XQ5Wxp4n/h3xgCSViMp/vMSb+Rp+ZUp/mtvPnQjPQddWjwmxITqw?=
 =?iso-8859-1?Q?iqo+m2FqA81JBtPZcm5s6NC0saEzE+F2fQuJVb7ulqLxj0onEiuqp5v+Sw?=
 =?iso-8859-1?Q?Mm3gLt4YGfW+67z1qorCfMCunK5papFJfQ4zX645KconDOMTE9Q4IqofSh?=
 =?iso-8859-1?Q?FiOHGB6btEibfXGz22Z3nGYrJ2dQ8bml/UYmpkL4/9qq29r9iFutUNgn8g?=
 =?iso-8859-1?Q?fIdaHuADmf6f9goSaYOg5o1Dxribc3sao3T1F3VF74/VorXzDEQQm19F9Y?=
 =?iso-8859-1?Q?smDw1fsUBKqBiyAjBY9FbasB9aXe+CNICPU/KL01vSKrSfvWLgnhkCn6B4?=
 =?iso-8859-1?Q?zFn/ZsWzEY6uLtAupFt2mdLem+oekkkWDLmaXKZRg52UJFHIPXdpvl/ScJ?=
 =?iso-8859-1?Q?BbajBEr0a1zZct0rAG4tJv0SK0YwvayzvQEYz8QIrvpA90sGzoTsk1MyHJ?=
 =?iso-8859-1?Q?VRgw/qMe4RMSNdJODSYo05SvpVjkJ0HnGjLD6L8hiZ+8+VfivM8zObKTt4?=
 =?iso-8859-1?Q?Qrz+lpIdrDmLWg+4p+Xm2fl8jjYzDX+OPZ+UeBF9EZsZ8G8dWN/AgDvdpB?=
 =?iso-8859-1?Q?MdLnqVEBos7I19RzlxZMxgUejF7uK+ksqneYtwm4XaYGcyFT4DmTS9r/56?=
 =?iso-8859-1?Q?zu+iXq11C54YJJsQFgCvdB3Wo7AsVXCAMXpL6fPv92+Q3pvl0ytA5KsMPw?=
 =?iso-8859-1?Q?Y6RCGG4ReWzxNhy/cqjtIsb2YaHzCxTiK4FwNhPdt1HQCTSdppRfGQqY4K?=
 =?iso-8859-1?Q?ejiF8kgAB3q5aBaV+43EEqm1dOrIO63auK+zwuMXsW0R12M1YDJn7VtKvL?=
 =?iso-8859-1?Q?wRM2lzaPk02eecgQJLtQOMDhsl7j6psACP+v0wd6Qps/exVQHHmPO8/a6B?=
 =?iso-8859-1?Q?URcH4iDKT2MUjj5oLouucQLaAXNzSsZ7rpuHKYX7AlKk0oD8S+Aw1lzYk+?=
 =?iso-8859-1?Q?YymoXqJG6Iiy4AYEds0KdRasS?=
x-microsoft-antispam-prvs: <DB3PR0402MB3659F8919989B8094649CD76F5780@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(478600001)(14454004)(36756003)(99286004)(26005)(186003)(25786009)(53936002)(7736002)(50226002)(68736007)(86362001)(386003)(2201001)(6512007)(6506007)(2906002)(66066001)(4326008)(76176011)(6436002)(106356001)(476003)(5660300002)(2501003)(2616005)(11346002)(446003)(8676002)(102836004)(81166006)(8936002)(97736004)(7416002)(6116002)(81156014)(256004)(71200400001)(3846002)(486006)(110136005)(316002)(105586002)(71190400001)(52116002)(305945005)(6486002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JbZMypRhc5Yvy5GKZDWO/1cHobKEn07KSuSU1VpLWMZ/v/Dr/vRCtqe7sXFAkIy7Kio8dyO/hQ8nCHXU/jXaQHIChOQhkjW6P6Fq3mZ0KH70Pkp1hapEgK5ixZH9oi8jjIHQMECEemTGJPIPXyRcT4kuhmN5RIQJriSZkJkl5Obh0Hp4fVEQLEtAfuYkF9QdoVRJq9MHxeAmdNRW6LYp6c1ca95/8QeDTFu2veKgXMyGX7uSjdPfIVUjdS2zVWgeph72HijCfUBi2fV9ksAtFBIAon6+qolBZ9kq7jNo09HHj9q5viC1QJJ3fcFLtvwX6RRZJeqb5r7+2kAd/bO/j42MMi52u8BtlZe87HegwOvYEtuq2+1QwCtR1cq7cmCmNm9HZnyCnrfS6763fZS97QXT1Ky06QXAiUCS33ATEtY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793cc2fd-a82a-4df0-d91f-08d6993dacdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:19:03.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ has clock gate for each GPIO bank, add clock info
to GPIO node for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V1, just drop 1 patch from V1 patch series.
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

