Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7276C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A21920652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JruCMLC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBYNSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:18:31 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:2229
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfBYNSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/GJuXHT4XIx7pCYJY1Ujgy9cwKmpB+ZMhe29Tbs/Y4=;
 b=JruCMLC4KNXoHXGAHSfekelsNC3G+qldf+Nb+5u048fi/qCUvpyq2/Jh3e/7sZzTfyChT7FoaWGRd28k6HiE7Sy0bHcxouCymQ9ZvryDGYN62IjioCALfjhDsl6dIXPc5n6y8Bg28iRk/9fzb160R0iBJjXCXzzaNpI4ZrbFDHU=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:17:46 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:17:46 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzQx/QeEbizeFI0O2BFE6xP8gsg==
Date:   Mon, 25 Feb 2019 13:17:45 +0000
Message-ID: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0202.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::32) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcff3d63-4afa-420f-6ef1-08d69b23a1a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2895;23:WEuoqekieaqWlJHKS0y6BH0CFvFhcy+IpF8oL?=
 =?iso-8859-1?Q?sJpqAGiMrJGo71ZTcmZPOZb4PIqzOo1pMfyumKOVu92hAuEaQzrvferEPC?=
 =?iso-8859-1?Q?BKa00vPAi96E2c1Sk1iJkn9WZ/IR6WhxQFU4cr61LCVm2jOCISv93rJGNy?=
 =?iso-8859-1?Q?QlcVEnRK7ximCodABaQcHQ9xpcRDIOkpamRuSmA2JMlghqFtmWq3ojcFva?=
 =?iso-8859-1?Q?BB6msLkTN4ocF4PIl08EpmWGu56Hq2GEDFyU1/KxADThP/Ppvh3hBoLa6s?=
 =?iso-8859-1?Q?ijdlJijqj3l+iUki1YNIVMgogtPDdZSy3mU5R7WjVVzetUuqf2DRZny/do?=
 =?iso-8859-1?Q?bui0wWM1ncHYJnVHd+d/q7gjjdpOsWtTQJCTdzG3KI10MY2+Mgjz1e3q2Z?=
 =?iso-8859-1?Q?W+qICbzMxvuSyRYzOXvXkjiDTZbjbZyOW1NCvgYLzy+f5WR2ewYIvo0SLh?=
 =?iso-8859-1?Q?9UzuC7KesPZrkvr9KqdO+Yxnt0UWG/UzT+mEBavLGYvHR2OY7ra0xKrnco?=
 =?iso-8859-1?Q?90bpxoj8HhlDUER51BUfk2AnhZ8qdDykl+IeX8VcbvZHQlJV5oDHUY9rqi?=
 =?iso-8859-1?Q?nPcP2T0onyQvTV8kt2PBcYWOQhLCbiibbEdKel5wNPgTGfqFsgPStyjT+B?=
 =?iso-8859-1?Q?/kOKxuCAZj5Wi+DCmpyb7jFSfaCfEubrph4zwGJA82tExf9ygFTm7I49xD?=
 =?iso-8859-1?Q?Pve1OP7EENNa8HY6W/Aqsqc1GDEZwyNAb8Q82xurTv5BiiJk2TI+vQzeA6?=
 =?iso-8859-1?Q?JrMbmHr63auoSTjo/ZF6q28guBs6qyx8zERSeTjjGLMVg5ufpiD+rwnpz3?=
 =?iso-8859-1?Q?0mq/ygMyxqaRPW8t/j5A2xvejgEr3wqknM19HZL/Ram0N6MW5yCwZ3rYFj?=
 =?iso-8859-1?Q?AaNifeibxg8+BM7ZIhQ0pu/ZtXY80E3EzboE73uHy6OHVtfwinVw0k+hRk?=
 =?iso-8859-1?Q?y2TiKp95WKGr3+bGqUV04Pc6QYoKMjyX17ADHoqBTwnGFn9+RlR7OS+4LJ?=
 =?iso-8859-1?Q?+0zLi+hCndJ4KkGJfOQz+3xcSuSiEFEaff3nVusp93GAOmk6kkyKgWPVo3?=
 =?iso-8859-1?Q?P0TScVIANfoPKYj1uRbw+phSKurP6fli9A12m1Jrd2NTvT8DP+sKGBvsbB?=
 =?iso-8859-1?Q?ZHQY/S5P83XBVXdEq7rhITDzeyhs2hsFnuLDscwidjuqeJMH7lqaPEIP/e?=
 =?iso-8859-1?Q?dcDf/9oSKVm2XCp5ccJqrGliBatIJLPfs/lmI0g5APERlWrQmC5LaFr36d?=
 =?iso-8859-1?Q?rzyef0h0873ChqpJuJj3G79C8PMyMst8AysNu0CVtMYG+fBaFVnj6ZVqyV?=
 =?iso-8859-1?Q?JX0+U2i5vkoDND7BMwZAULyNLLmVvpYvLEYURPxiA9Ck1SZWUKSs3IS0Kb?=
 =?iso-8859-1?Q?anqIWFxw0Q=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2895DB597A02895DA5223497F97A0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(1730700003)(2351001)(81156014)(6486002)(6116002)(3846002)(2616005)(476003)(186003)(44832011)(36756003)(305945005)(486006)(7736002)(7416002)(106356001)(26005)(105586002)(14454004)(5640700003)(4326008)(6916009)(25786009)(256004)(14444005)(6512007)(97736004)(50226002)(2906002)(478600001)(386003)(8936002)(54906003)(102836004)(66066001)(71190400001)(71200400001)(316002)(1076003)(68736007)(6436002)(86362001)(99286004)(6506007)(5660300002)(52116002)(53936002)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BYcFVVdl2ISW3T2hEpbHt/fu7RjniXDpVuUDVVljaV+j2GuMyN56O4uerHP2ksJp2gOE9Mf/2h4L17crLPEKbbBBmmXsv8TKCmR0tcmQpo2TDmF+VLCw2f6d8V3sYG8QdCDD3fPnhh7i2mo0Vkdy1gZNHrjLURSKeLY85mzY2B4YDV32TZvnI392eJFzmv/ZDY7vD+4ZFqAgLsvObtFQG/6F8XVKiOK2VFphQMjScmy0M+7vdjFRb01H/xmk4T3JUfyJaAEeL+zIkFPLvWefITKIeoFOx1gaVcR3y+tONiMJViEZxRMmrh9YaIz3yZf3izOANESije8lhI700CeZ55tdc3OPBDhuQZm7sKj+Ax56sL70R2MHO6MxcqT8vKIjC1x4+wUoo+1GfGiwGU+yYD4ioH96evWznJkfV9xvJ10=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcff3d63-4afa-420f-6ef1-08d69b23a1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:17:44.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4784eb..87839c5c8a7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma2: sdma@302c0000 {
+				compatible =3D "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg =3D <0x302c0000 0x10000>;
+				interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible =3D "fsl,imx8mq-iomuxc";
 				reg =3D <0x30330000 0x10000>;
@@ -575,6 +586,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma1: sdma@30bd0000 {
+				compatible =3D "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg =3D <0x30bd0000 0x10000>;
+				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible =3D "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg =3D <0x30be0000 0x10000>;
--=20
2.17.1

