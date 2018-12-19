Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C14921852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wlQ6x8au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeLSFlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:41:37 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:51363
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeLSFlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dyc1Tn6ytunnpbrR4rC5ZamakDhV6ZVgDJsfJ/u66A=;
 b=wlQ6x8auWbyyE4M8x8oNwZRcyNVZtyNuFcbG66Ql0qzmbpveA9vIpKO1P8i4iUpIGldY/r3xo5MwdgnKVt8S3PafcevuGUcMR774UHte8mv1jAAFFebGxjvfwxfDgkXv6k9Rn0wr7ijLasCIxJrwVLvPv/K1LppMXcG8KL1DmQM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 05:41:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 05:41:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Thread-Topic: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Thread-Index: AQHUl11+amh7uXSlqkCpQPqjHNiM7g==
Date:   Wed, 19 Dec 2018 05:41:31 +0000
Message-ID: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3850;6:n9SAJ3dStDmboF5vGxOeNP/xTzo6ixIHqM/Xr7L73+p7cyi4hmvQxmqqwz2DrDA7cG7jWExla+PQJThfMggIfuxhCwkfyQqOG6yKVMnE0HkSfGAnAO/gG71n31yGp44Q7HyNaSD7V3FUE0rbeFZUVdQ6PFJ0XrR2U4Z6cjsJ5CM8SgO9+MT6YTUc2UsX2vfzP5/SJahzTPcGWvZ2Mx0eqD0AXlroV6IaadwdUkzJYBDmqMUNSxx/o1qRdTeB8G1rIKB7m9cA60Wi6inW5VLPH9eieuH00J/6cs968QOV2feYBwCmt6M5l/lzPlH3RYot0d4Lph/ZblkCoQPCgMuXHMNlvHlYQaFq7XTaOXpUZiuy4F3jVbtFyaYn496W/pCKkTuoO8TUMPrPvQlmHSlM6SRR0Td7NS930nkxumiGQTT/l9ty0RIOVfUNPYDB/RSfwa4iDuFQhNVK1vGoo4/W9Q==;5:QfchUaNhX87sJnWDUz1S7vdTpO7EmQIvWGQeO680Q8ZF1Oocuw1lI3sjUWB3gGf8Ccxj+qd32G40DZdev1sOuc8waOxkutcZZqOg+0DdCQKe7lWHhCSfjwR27NWR9uckj+WBUbBoWDTwbrrzCRzejetmFoJS5CG9gcbAPCk2wb4=;7:AgPsr16mr0gZGx8mCEYgXc7D3ZM0DyHEqxg7MXMpxrg9qT5gBzWE408L1fwHhKIl6JtHXPQTj0OtxqsegikteUetBlbjt4Mkkk6BLmqm5PFn+IufKDYL3vs9Rf6uVlZAO9PwSHv3s1i2IV5J7OWWPQ==
x-ms-office365-filtering-correlation-id: 7d5ccf52-afa8-4c0b-fb89-08d66574a0e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB38504243FDC249292E3AC465F5BE0@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3850;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3850;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(39860400002)(366004)(376002)(396003)(189003)(199004)(102836004)(186003)(386003)(6506007)(4326008)(26005)(53936002)(6512007)(8936002)(316002)(110136005)(86362001)(99286004)(71190400001)(71200400001)(7736002)(81166006)(8676002)(2201001)(25786009)(81156014)(305945005)(52116002)(6436002)(476003)(2616005)(36756003)(6486002)(486006)(50226002)(105586002)(106356001)(5660300001)(2906002)(14454004)(68736007)(14444005)(478600001)(256004)(66066001)(97736004)(2501003)(6116002)(3846002)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9WwDoD67TZCW5rfZ9W+yGvRFsKNEUauwqundoBBzfxIEKnkPLzpaybAbdHbhqNHi1G04Sa+teRQsF+CHMIef0xazsBevlcV/YATeM0GYP/ABrjxQpKMON9ktOziZMbmueKsyMzeXIBoPaph/QdQR/neCIAJCeDBX+dhE2/vvjbt36SzC34R1xIKoYXw0cUBZBuy3WkwCklz2VH336nluzKydffyRhbqOn3wAd0LtrlkBrYM4ETGU9U7+cTUXW8ikJRRjRsr0IPUJC43uBddp4qp0Dc0veBIKadXCPFSxnHXYLJkIP16wuoRfIIycxpLl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5ccf52-afa8-4c0b-fb89-08d66574a0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 05:41:31.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From i.MX6SL Reference Manual, the PWMx's ipg clock
for registers access is from perclk, correct them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index e7524e7..4b4813f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -338,7 +338,7 @@
 				compatible =3D "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg =3D <0x02080000 0x4000>;
 				interrupts =3D <0 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SL_CLK_PWM1>,
+				clocks =3D <&clks IMX6SL_CLK_PERCLK>,
 					 <&clks IMX6SL_CLK_PWM1>;
 				clock-names =3D "ipg", "per";
 			};
@@ -348,7 +348,7 @@
 				compatible =3D "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg =3D <0x02084000 0x4000>;
 				interrupts =3D <0 84 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SL_CLK_PWM2>,
+				clocks =3D <&clks IMX6SL_CLK_PERCLK>,
 					 <&clks IMX6SL_CLK_PWM2>;
 				clock-names =3D "ipg", "per";
 			};
@@ -358,7 +358,7 @@
 				compatible =3D "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg =3D <0x02088000 0x4000>;
 				interrupts =3D <0 85 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SL_CLK_PWM3>,
+				clocks =3D <&clks IMX6SL_CLK_PERCLK>,
 					 <&clks IMX6SL_CLK_PWM3>;
 				clock-names =3D "ipg", "per";
 			};
@@ -368,7 +368,7 @@
 				compatible =3D "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg =3D <0x0208c000 0x4000>;
 				interrupts =3D <0 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SL_CLK_PWM4>,
+				clocks =3D <&clks IMX6SL_CLK_PERCLK>,
 					 <&clks IMX6SL_CLK_PWM4>;
 				clock-names =3D "ipg", "per";
 			};
--=20
2.7.4

