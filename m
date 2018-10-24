Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB6DC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1DD2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l1y2W0oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1DD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJXTmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:42:23 -0400
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:27103
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbeJXTmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9GqyAisrbuNufVweRRTSNW/9x8O55fsLoAE21gnzJ0=;
 b=l1y2W0oKh/fGk1AapaMmyrRYFCWg7vfXQY4XRmRAzSJ5IMmcGE4xd/enn83HX0YGtKRWIcTAi95thaAtbz68oLZtG2yg0WUjvPAgJOYavlFn9MhBoxwQbS9RL1ijfFKE7i5Q04PNNEhlGbkgavmYCgorgX92da8A+mRxRj8jVqY=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4764.eurprd04.prod.outlook.com (20.176.233.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Wed, 24 Oct 2018 11:14:37 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 11:14:37 +0000
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
Subject: [PATCH V1 2/3] ARM: dts: imx6sx-sabreauto: Add flexcan support
Thread-Topic: [PATCH V1 2/3] ARM: dts: imx6sx-sabreauto: Add flexcan support
Thread-Index: AQHUa4rA+nS/J5zBRU+nq1fsDV78nA==
Date:   Wed, 24 Oct 2018 11:14:37 +0000
Message-ID: <20181024111213.2724-3-qiangqing.zhang@nxp.com>
References: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0098.apcprd06.prod.outlook.com
 (2603:1096:3:14::24) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4764;6:sstEUs9OSnhIF6Qo5764Fv1LHzN3V2cERWuDq/fVOb0jwXNawo+celeFeLPGeDSAB9DnVqIbsfX5ht8hAr1e/T8OHdWjaTzhCxG+5BcsviN6M7ofsPWVUyebuZJC7JUXB0KXhWhEuGnujvIhPPbHlO9lhx/zoRcX4maag3OgDQeuF6qXy+PvTu15MhpwEVPl7cDqpwdzOw0r2yO9FZ95W8PMzjJ3MVv8da3XD1xosGbvsShNNDZBm23uEEdePwxmDdzFA5HbizWRsluQoTHFrqoVCnDf8zcQ0lG6HP7+8WIreqy/mwFHbCwOMYyEmf/CcES9zVLqidkpRWe3cn8AzSAnpxgWLUMqeVj9f/SWy/BzzAKwIq8UvIIkD+hW77b4sjHXuUo2Gazi3ZU3FAYCsv6qPTkcvPsFDjnRrIonTJxCOFXkZWIk7IyolTRWw+2b4NRIxYxGTFhoyJTj2U5fkg==;5:Tag9tHJqhWxXlr0D5QD52PcCjPv+Fh+dlKpEe27VgSgVoRCTyo2SkjpAzeLOwwrIZf1BYA+GPJ/A6hSR1WnYf9Tqy6Wqs78CiMQ6OXYwR8neUxT45b25vPtgbAM8l8Nf/m1IkBE40Zw7JqqEUB2pseUxjm25F7MCBuO/Cj4dRpI=;7:WQ+Z+ih0Ysnyfv3W2xKSW2iwmNZV26WJo+ZktJ0C9mEqCnajiTgLFvgiU4Ds2tCbN4iiy5qE1MtywbTSOflyefrWsyA3rxR2vEv8inGborVufLPtkA6E1yHvDEI8ebEOTTUuclPlzQT8Lm2XlPGaYg==
x-ms-office365-filtering-correlation-id: 118d98f6-8c3a-4e14-fc89-08d639a1e2a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4764;
x-ms-traffictypediagnostic: DB7PR04MB4764:
x-microsoft-antispam-prvs: <DB7PR04MB4764A111F5FB0B9156055318E6F60@DB7PR04MB4764.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4764;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4764;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(26005)(8676002)(575784001)(86362001)(53936002)(6486002)(2906002)(81166006)(81156014)(6512007)(68736007)(5660300001)(14454004)(186003)(25786009)(71190400001)(316002)(8936002)(71200400001)(4326008)(36756003)(486006)(256004)(386003)(6506007)(2900100001)(2616005)(476003)(97736004)(6436002)(99286004)(52116002)(3846002)(305945005)(66066001)(50226002)(11346002)(446003)(6116002)(110136005)(76176011)(54906003)(2501003)(102836004)(7736002)(1076002)(5250100002)(105586002)(106356001)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4764;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mBkqDnHNizvV6aIVi/8rE1iSPsLqJVLDOIH/ilyN5eH5+L57LZoPKca0V0UStEXmv5CP3zTVzMc+YWYM3LnMucbhN00Y/V81rr4tG7p7pd0oVTiMnN9Z2IdR/psHEMFGqAJ52cpaiHhC8vWC5e+QuV+DP4GyaFvWRxGsgOLRVCH1F+xDDXg0OxkE/oDUQYHBd9ksOvnf7guQkFT8HwNXMV5TZGI3tnbGwzTIq+x6NsfoeFsoVP7OLDMj8AaumEjdnEtHccOZkESsoG2qPalaC1HyMLY5k0L/dWTvFOrlu66+fno5L4meVlx9J07JeQC4ShMyz+1Y+Hx2ZMC47AV9bNuGVTYcgf6fLWaoF/r7en4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118d98f6-8c3a-4e14-fc89-08d639a1e2a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 11:14:37.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4764
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

