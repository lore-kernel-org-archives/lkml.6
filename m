Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CB920831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fpMr1ubV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CB920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeJ3RgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:36:01 -0400
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:55035
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbeJ3RgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9GqyAisrbuNufVweRRTSNW/9x8O55fsLoAE21gnzJ0=;
 b=fpMr1ubVqD5bH3W9UUbmHWvHT2zusSxmo2Mpa/KBT1uqyT/g8LFySOdb8lx5hQtsK09pVEOAB6Ut2agZ8e7vWpROvbhCdnVjqj54UXBTTJ3AVe0qv6pomDeTugAJ4yiA3F7JrEjoEV1LiKlyHn5StonScUrtRLx6mVpaPTC3wb4=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Tue, 30 Oct 2018 08:42:42 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 08:42:42 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 2/3] ARM: dts: imx6sx-sabreauto: Add flexcan support
Thread-Topic: [PATCH V2 2/3] ARM: dts: imx6sx-sabreauto: Add flexcan support
Thread-Index: AQHUcCyFiwbWkW8X2EeXMrS7m4w22g==
Date:   Tue, 30 Oct 2018 08:42:42 +0000
Message-ID: <20181030083954.26440-3-qiangqing.zhang@nxp.com>
References: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:3:2::32) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4538;6:ujsTp1AaF7wlVAVe7FPL87D0T9nNFhPWxw/Itux+F/9tcG5SihgJkr8gIkl6kQ7dvIVUqQI5CxUbbNlB5nnnk6R0WsUcRWKYzWeAHdC9zG4fT1tl5G3YUESgboNdoz/JJSdOjwsaXDv+IBATq5oGCwnQ92Eh5Zv5FK3eyOm//gSVCRWG0DsFWoz4OdKXqZ5FpOZ3VteZRQHTTk0VWOQjVRmv+Y+LSw74Hl8Q7NHUORf0PTB++zUW0hjQf3ZZ15uL+VEzswRoHXA7oCngusLtWa/cYeRqIqMBMEsU+EnInpVfWrJlti4J2wFYVh4Q/gYLy4LN3mtN+0HG3qhhgCEZsWRxoFtGLvPnj7JnqotKNPRBRI9s6c6hoipCvec8YqBhzBDLEB0sybgFGOYvgrB7s57AVvTagHba58xB57IlaM/Da+uDEwrBtHNIy+CiWMdHgiwr/EIvC1f8L+dURbtBQQ==;5:O2vP3GAZmNLdR6/lTvM4rg3y2h9LQN95YTBHlApU0YjZKSH7vyJlWAdWoyu/TX5dHEwVFoccmCFgzMLTaBaF0pNpmoQbORY12fP06gLj3sEnLT3XvQTsgX8cNkfehSlpLvauCSFzlhz1J/GsqwnlFziN9Sjdd0zLGWrsYISvLcc=;7:sJEreRgQdFQj49Lq1D38iOYkNBgsJHwfYFlK/9RK2Vr7306s0zO+bAGujN8YeErHH7s8fJe2Q78Y53FAm8ilxwctk9ihHaVGpcccjwYo2d6DzwPuk0Hn7T1eEd00WBZbOlZx3CtMQ/yatysSaOqwBQ==
x-ms-office365-filtering-correlation-id: c85e76f0-cdda-46ef-320d-08d63e43a812
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4538;
x-ms-traffictypediagnostic: DB7PR04MB4538:
x-microsoft-antispam-prvs: <DB7PR04MB4538F524A306A633BB4DD18DE6CC0@DB7PR04MB4538.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4538;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4538;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(386003)(6436002)(81166006)(575784001)(446003)(110136005)(52116002)(26005)(53936002)(305945005)(1076002)(54906003)(50226002)(71190400001)(476003)(81156014)(7736002)(36756003)(4326008)(2906002)(486006)(14454004)(25786009)(2616005)(6512007)(5250100002)(66066001)(86362001)(316002)(11346002)(6486002)(256004)(3846002)(6116002)(71200400001)(97736004)(102836004)(2900100001)(8676002)(8936002)(186003)(76176011)(99286004)(2501003)(478600001)(106356001)(68736007)(6506007)(5660300001)(105586002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4538;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YG4e50dgxqOQIcwI/7Ij8Je4iMymmGFpVEr29CmwdqYfCym1mUcwZqdH/+5xadSAasGOJr9ctL/53llx3P55HgVe5foFF/XWMxQdgy9eyepWML9t67k1CPZ+tvnm6xYOVDpAYtswZu1G+jb4UY+WXJmrkoO/c37splWF86tpH5T70Y93Lv5voGG3RHNkhIM3iRAFx4IZW8OSoM3auitTQisw9LkDAflMxljHG1MufaI+ecDV7fGoVNPtZxNi5zR06knohkgIGB0CxhkS5Xngu6QVJLefTB5mfMnBQjbEMMUfhUZPjviRw/aIF5DlqGf5++6/Wx4rP6xzoUyGCX5JXxGzluw3qxkcixsvkg+j6WU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e76f0-cdda-46ef-320d-08d63e43a812
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 08:42:42.6361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4538
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The CAN transceiver on MX6SX Sabreauto board seems in sleep mode
by default after power up the board. User has to press the wakeup
key on ARD baseboard before using the transceiver, or it may not
work properly when power up the board at the first time(warm reset
does not have such issue).

This patch operates the wake pin too besides stby/en pins by chaining
them together in regulator mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx=
6sx-sabreauto.dts
index 841a27f3198f..8f3319e7692f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -36,6 +36,35 @@
 		gpio =3D <&gpio2 11 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_can_wake: regulator-can-wake {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-wake";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&max7310_b 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can_en: regulator-can-en {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-en";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&max7310_b 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply =3D <&reg_can_wake>;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-stby";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&max7310_b 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply =3D <&reg_can_en>;
+	};
 };
=20
 &anaclk2 {
@@ -75,6 +104,20 @@
 	status =3D "okay";
 };
=20
+&flexcan1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	xceiver-supply =3D <&reg_can_stby>;
+	status =3D "okay";
+};
+
+&flexcan2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	xceiver-supply =3D <&reg_can_stby>;
+	status =3D "okay";
+};
+
 &uart1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_uart1>;
@@ -149,6 +192,20 @@
 		>;
 	};
=20
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins =3D <
+			MX6SX_PAD_QSPI1B_DQS__CAN1_TX   0x1b020
+			MX6SX_PAD_QSPI1A_SS1_B__CAN1_RX	0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins =3D <
+			MX6SX_PAD_QSPI1B_SS1_B__CAN2_RX 0x1b020
+			MX6SX_PAD_QSPI1A_DQS__CAN2_TX	0x1b020
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =3D <
 			MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
--=20
2.17.1

