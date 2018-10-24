Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6757D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dmo/vpJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJXTmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:42:18 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:51520
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbeJXTmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6RFQBN14js9hCmMPCvwAV6KjlMYwgH/qU74mFz0AMA=;
 b=dmo/vpJAL8gAPhyoFpoNIlRb4Ebllmi60vzupbV/96ORvNXgdIAtjxAS6zZ1/6NTo5q2aIr2IxHHOryeq4DGsBzGqdoIelVWezr6GGsJCwNckm9EWCJ49pqn1K/V1woW1h603ISWpI0hYve1qBcwzvPku7UTzIGuo9QYMpaYtDo=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4764.eurprd04.prod.outlook.com (20.176.233.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Wed, 24 Oct 2018 11:14:33 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 11:14:33 +0000
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
Subject: [PATCH V1 1/3] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Topic: [PATCH V1 1/3] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Index: AQHUa4q9ILUSRFdE4kCmy3L98c/r6Q==
Date:   Wed, 24 Oct 2018 11:14:33 +0000
Message-ID: <20181024111213.2724-2-qiangqing.zhang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4764;6:KMOTjOVMgbwAEKW8I2oiPpPy2/miKuKgExTnqZDsaj2YMl8vupc0KtCku5HyeAOBudBPTvBdzygvmgUyYGaes7Ah3GYJmyzZVQ61W7IJMp6x+hpr+R7iLha1BiquVKSRbKnigjccKgBZcNHEhxUTubjAhozjZ3v5Ks1QKmBf0FYGiaUDKK5ax1agI+aa/cuhB/i4aNHBRueb+DkGgO/RD/mYzhV9jtcQ3jJ2BMn+I5MPU7J+dIvKaZOcSfD18lCFqlHOGcYBp+SYMPDmIH9m3ToKym4rdToRQsbbjBVWz9qChsz84FxZ1b3n4VGCGbFSQTLK5fWatV+X99YLKLZFUEzZxUDa3feOBN/e56BkUKSjSPWhvDq/AQEqGq2cEmIMTn9Jm2rKEBMsLXT5VtuGcvByPCwQ5Xc4cHBfW8076A+QMDk1Kwq+NAbcWMscjtJCXNh5RHrtvxViijGkEVcbjg==;5:GIjVkrpSWxyo+mpJDBM7NGO/ZHTgoyt0a+vU8IvKkqy2ViZB7fx42mPXGrHUX3W/Qe8cqX0QAk2pOWfA/Qo1nD1tjdxKpBj7EwRbeHVpDimEiNJolGWpVYquOmP4Efx1vvKgjzD6nvOkmCRanp5zpMHj4LKPeXo4PgKEVOvxDo0=;7:CQjy0dFAYjFhYQDTq2/rskyXi9fxCRRqOTjz6dBsl2SjNPI/LuojVaPm7rFlzA7c7R38uQWW5XFRGOwZ9vn/vYmiGLfXhmnR91nC3XJHeaHWM3oIbmXgn/KtN6zv4hOlwa/3odfB3axHvOUq1ac43g==
x-ms-office365-filtering-correlation-id: bd9c4dcc-4cb5-456d-8ed4-08d639a1e00d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4764;
x-ms-traffictypediagnostic: DB7PR04MB4764:
x-microsoft-antispam-prvs: <DB7PR04MB476479188F66BA19E34DDFE3E6F60@DB7PR04MB4764.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4764;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4764;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(26005)(8676002)(575784001)(86362001)(53936002)(6486002)(2906002)(81166006)(81156014)(6512007)(68736007)(5660300001)(14454004)(186003)(25786009)(71190400001)(316002)(8936002)(71200400001)(4326008)(36756003)(486006)(256004)(386003)(6506007)(2900100001)(2616005)(476003)(97736004)(6436002)(99286004)(52116002)(3846002)(305945005)(66066001)(50226002)(11346002)(446003)(6116002)(110136005)(76176011)(54906003)(2501003)(102836004)(7736002)(1076002)(5250100002)(105586002)(106356001)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4764;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sE/HKKm7+WnLCNwmQk4il9u75/A4jPc/GvLoB7hZCauOI6QFFr2xcVWZlj5hNVOpqpj9nhU566VESmNirkNrTyxY4f6OasXvFOPNkB6ku4qavQRgqqSzLHo1KS/gdstr5skoBP4klTPRD4y0zoRJI9FFsUUTumUYTxCynZ0IdJCS5AQE+7tazA8kSkHijcPpNXg2HUq7DCxny61jBsqWAh6vMYUEhFGrtspGgDjCswkWxoG22AgBXMA59VBHQnYJxeamHLkWa5RwMI16O/bllpm3+nOCnI5bwQkNBJeyHHPLpr+xuopE/RcIQfxxlVkw26MR/7gALtCHu89gh8jNhlEVGRU5zqEmG7M/R+jujJs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9c4dcc-4cb5-456d-8ed4-08d639a1e00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 11:14:33.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

CAN transceiver is different on RevA and RevB board.
It's active high on RevA while active low on Rev B.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts | 12 ++++++++
 arch/arm/boot/dts/imx6sx-sdb.dts      |  5 ++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi     | 42 +++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6=
sx-sdb-reva.dts
index 9cc6ff206aea..d98dcf00b9c4 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -10,6 +10,18 @@
=20
 / {
 	model =3D "Freescale i.MX6 SoloX SDB RevA Board";
+
+	/* Transceiver EN/STBY is active high on RevA board */
+	reg_can_en: regulator-can-en {
+		gpio =3D <&gpio4 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		gpio =3D <&gpio4 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply =3D <&reg_can_en>;
+	};
 };
=20
 &i2c1 {
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sd=
b.dts
index 6dd9bebfe027..092b8de142a8 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -10,6 +10,11 @@
=20
 / {
 	model =3D "Freescale i.MX6 SoloX SDB RevB Board";
+
+	/* Transceiver EN/STBY is active low on RevB board */
+	reg_can_stby: regulator-can-stby {
+		gpio =3D <&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
 };
=20
 &i2c1 {
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-s=
db.dtsi
index 53b3408b5fab..4de2473293aa 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -138,6 +138,20 @@
 		regulator-max-microvolt =3D <5000000>;
 	};
=20
+	reg_can_en: regulator-can-en {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-en";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-stby";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
 	sound {
 		compatible =3D "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
 		model =3D "wm8962-audio";
@@ -204,6 +218,20 @@
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
 &i2c3 {
 	clock-frequency =3D <100000>;
 	pinctrl-names =3D "default";
@@ -399,6 +427,20 @@
 			>;
 		};
=20
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins =3D <
+				MX6SX_PAD_QSPI1B_DQS__CAN1_TX		0x1b020
+				MX6SX_PAD_QSPI1A_SS1_B__CAN1_RX		0x1b020
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins =3D <
+				MX6SX_PAD_QSPI1B_SS1_B__CAN2_RX		0x1b020
+				MX6SX_PAD_QSPI1A_DQS__CAN2_TX		0x1b020
+			>;
+		};
+
 		pinctrl_gpio_keys: gpio_keysgrp {
 			fsl,pins =3D <
 				MX6SX_PAD_CSI_DATA04__GPIO1_IO_18 0x17059
--=20
2.17.1

