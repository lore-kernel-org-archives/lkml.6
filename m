Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D017B20834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rBMILYMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D017B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeLEBO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:14:29 -0500
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:36000
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbeLEBO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4XOjFifUY2xrguCmulcNei47uIRvW7WFcKGuytwRQ4=;
 b=rBMILYMz1mzZWpVuW1Ss4tqqu2c2ldx+aSNmI+OfiGTxIylpf1nFf7Zef1ZfPOJ5h3Gtd72b4cBdRfUNQilfU1yRfCtMlicPc9cd1IiZfbi6tLJHnE+1w3P0pinJYWaVvlYXuBTFaKI/LwtjPQnqrbYJRZY3A4bdZu136wOKs6M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 01:14:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 01:14:25 +0000
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
Subject: [PATCH V2] ARM: dts: imx6qdl-sabresd: add egalax touch screen support
 on i2c2 bus
Thread-Topic: [PATCH V2] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
Thread-Index: AQHUjDfcag5OHPiJuEKRmx7mg1SAuA==
Date:   Wed, 5 Dec 2018 01:14:25 +0000
Message-ID: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:203:52::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3785;6:YoAJsspGk84aDFCjGVRUEwF6AXCA3TIJJL7jwpBoPC6s8kc7/ZRT1UYS0MKCc6o0Vqz9JWEvn8jBUWzxHMpYtwraukiV3aqETcV1y0/xW7uVMBQ/kR3AWvrBTj8Ziiu7HqlYKdIw/p2yDo7bzF51ksf7g2wCnfFgBVsKYNQ0ncUS8JTx6h/2m2JfNP3/NCcfHDtKrkKvr7NRK4K3cjkcpa8KlQbLHmbsKGEX8Xm0/jH5OrbWTtgXOzuMeZRMlS6F1jutrL/RiWAXGK8b0bbjJYVYIrpUd6u+rxiSyPHwD4cxShefkf1d60cvB7IwfzcwtXN8YMLI+7WUlnhqu0x2ENrrSD/+3G4Pritf2FPqGgSfjO5Vxm69ZLAzD81e/vw8aVBvoOl2za60XgqSIuA3iere7mN/aRlXV2t0mo18axY/CUFBRoakFi/exISO0n3QgrfEDyF6kzgclBAwrUoB4A==;5:vk8YpElN9TN9zLJ37LDU/zENhdfkzKewoLNBvMtnYaixFHdKbimFBwfnoJ5VsfPEU9et/5hPTPJWQ8Nz6xkMvTJMdq3lXRKbFjNlcIvnbx9NeXrInytBLMWp+zM4gt6kLUPyHrBEct4jjfqorB4YthbZWuoipAkUC3o0d0Z3iBE=;7:2ur1wx64tY56+Jw+/xr8M734LpLiOSshxvwjEZOH4UTV4MeMbyz4T6LiKmBT41r0eNGZzcP8rnC8e1silJdmYeO6BjkI5dexY4xUAX1HNOBqV52fEHwv9vnLpR9jABTvxJQiiURXbLjtYDSA0k4GLQ==
x-ms-office365-filtering-correlation-id: 0eefcf5a-7201-463b-bcb3-08d65a4efebd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-microsoft-antispam-prvs: <DB3PR0402MB3785B6FC642A1E135CA28B6EF5A80@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501517)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3785;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3785;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(39860400002)(396003)(189003)(199004)(5660300001)(36756003)(105586002)(186003)(486006)(6486002)(66066001)(106356001)(99286004)(53936002)(386003)(6506007)(26005)(68736007)(110136005)(7736002)(52116002)(6512007)(305945005)(97736004)(3846002)(6116002)(2501003)(86362001)(102836004)(2201001)(575784001)(316002)(478600001)(71200400001)(71190400001)(256004)(2906002)(6436002)(476003)(2616005)(81166006)(81156014)(8676002)(4326008)(25786009)(8936002)(14454004)(50226002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6OX/tOqoKgiTbFPbcix7qOef0R7Kea3ptbNoxmXftxK6jkywkoKI1/ZzqwRH2OU5EAFEPDJj34J7sbGWfrO6jRzFVpBR+5Q+kdBIHvJygfJFfQZ/ktp/OR3dYXAeThzjj2sXtcgIYv3SAwF9Gc71dEgNQJYscq6cF0QALym52Zwke4YoaRox1O7HG9YkK4gNjdowNflXV0+rOHFF0PdN1hSF+xGermAooyihk8O2iFw49UYyj5FvwO1MDNsDewhVRYVoaaNlkGu1m7F03OKufZCOKdq/NMt0D0jT7Igb7AVqajH/lKkGOs2gJ9+pm6dq4Xffhv39QAoFNZei7O/KqVqFJVDiRBr16XFUIHhM2GY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eefcf5a-7201-463b-bcb3-08d65a4efebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 01:14:25.4085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add egalax touch screen support on i2c2 bus, it is connected
to LVDS0, while the existing one on i2c3 bus is connected to
LVDS1.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 6e46a19..d7389b5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -272,6 +272,16 @@
 	pinctrl-0 =3D <&pinctrl_i2c2>;
 	status =3D "okay";
=20
+	touchscreen@4 {
+		compatible =3D "eeti,egalax_ts";
+		reg =3D <0x04>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2c2_egalax_int>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <8 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios =3D <&gpio6 8 GPIO_ACTIVE_HIGH>;
+	};
+
 	ov5640: camera@3c {
 		compatible =3D "ovti,ov5640";
 		pinctrl-names =3D "default";
@@ -498,6 +508,12 @@
 			>;
 		};
=20
+		pinctrl_i2c2_egalax_int: i2c2egalaxintgrp {
+			fsl,pins =3D <
+				MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x1b0b0
+			>;
+		};
+
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
--=20
2.7.4

