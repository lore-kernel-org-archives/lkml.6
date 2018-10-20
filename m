Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C00ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 02:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768CE214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 02:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2w017HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768CE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJTKo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 06:44:28 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:29650
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbeJTKo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 06:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si20bu0FS/EgXmWytJV/QwH1zZnsYffKRB2hHk63EHM=;
 b=l2w017HVPJY13Ogugrgv1mQBELHnlQO+OsSNSbmCjXt7+5cZqNBvf/QJfgWtxHEywbGHCPHrgIBRqiNDzz8OIiDgQkhOYqOyDFo966K3JoqXD4PMBZsuTR3cA9V5Dp9EiPfWW/AKVchIYxL9crSgVLUcMLe50jaZi/r7DLtU/uM=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4729.eurprd04.prod.outlook.com (20.176.233.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Sat, 20 Oct 2018 02:35:37 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2%4]) with mapi id 15.20.1228.035; Sat, 20 Oct 2018
 02:35:37 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH v2 1/1] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Topic: [PATCH v2 1/1] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Index: AQHUaB2VYQ1JQcngik6D0IChUp8mZg==
Date:   Sat, 20 Oct 2018 02:35:36 +0000
Message-ID: <20181020023318.21663-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0104.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::30) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4729;6:teWJm1HptOu1mLPAwn3IRZ0p07IVjtkSSSCopLW0UpU1n/atzjmpbzbJvDn1L+Sje69SdnF6FGGXi93TYmnJgl01alR5ZlY1va3n4NpHdcLhiRsXXAO1BNJGVoiX9510F9qnu8CE9//7k/MRU6eoJ8Gf04xsXBOD0kLrRuXMQCAu0YbZDowAL7ZbX43TPNqeBVGkBCSpp0Gdu23NJFXC5i1u0ewnlYy2/GVZMpWAkvmLk9OHX3VdcN9TGGASJBanJpqu/R5vUdWVkCwT1pEe2z2fa215bBgWx5Lp48DQiGpDGpKtBPUiHbx5+6p9MK7ULhhFGlSKd0nk/85kXn4fDwUnQKWE6mm6OZ3eXH/q9F+9CklwYZNDa3Oy8lyJUONQ6W1BFaayLFn8Wm7cvQL+pf5M9BYWxTlgDQaCzlP5Mu2lRubrWkpXn80ZVt1V+LL9TELcbPJCpOQ6nMdIIxr/jQ==;5:f5BENkl9c0eGuaUBCJSAFG5/DX/n3lXx6x022uvEoHC/yDiecl21Se726v9xd4EfhptHX5IlQVXzvFaBD/aI/IYh6Am047gZnpHBR3FIs2RidS8Rj0KmHGYADzv10a2rc2U8C+z6FQTmdJFgdpF4JYiy6uQ/weSGGWTE6rPN+mg=;7:H9zSchX1pfJY1fNXQYHkkN+lyeS8pn5rt+2LZwWADEkARTXRdbS/xcq1HARqZN1oA4AgqPqly0HHuAbGgf20uhubck5mkeGLnN4YTiPnIxbbdomXx1sD0tZg84VvsKZlRLFYZSwf9gaTtmJv19K7aYPQS79K5osSe5rcApNqlafTROfFGlfgrt8eTpnfDQeDZx2nXprupA/PifkHKRvftSoDsa2AZlHL3KhTuTkSBaBdGHnRzHmG83CwZ9RJJqdZ
x-ms-office365-filtering-correlation-id: 4c1414bd-00a1-4e9f-98e2-08d63634b76f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4729;
x-ms-traffictypediagnostic: DB7PR04MB4729:
x-microsoft-antispam-prvs: <DB7PR04MB4729209C2FF9E1A9AD65377DE6FA0@DB7PR04MB4729.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4729;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4729;
x-forefront-prvs: 0831C25939
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(2906002)(476003)(97736004)(102836004)(186003)(54906003)(99286004)(6506007)(386003)(6486002)(26005)(6436002)(52116002)(486006)(2616005)(305945005)(7736002)(316002)(2900100001)(66066001)(14454004)(1076002)(256004)(5250100002)(478600001)(6116002)(71190400001)(71200400001)(53936002)(4326008)(25786009)(6512007)(3846002)(2501003)(110136005)(86362001)(106356001)(105586002)(575784001)(8936002)(2201001)(8676002)(36756003)(81166006)(5660300001)(81156014)(68736007)(50226002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4729;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hYaQzxwH9gPk2czcMiHDCXAPIUazMWUzvyApX1HSFC9m4+XWzHtAVPxPqBJJY3dGQKgbKrq2CqIa5606/RnBDaWiq0qdCBcb6vJJgPqxEUzuY5+oT3+85fXjbED/s8kczRlx+X54M/CMFdpgBrx1MZpCEC2TQxzRGUpJWjh+H1q5NOlJZysQeAnw6qifSkLtgxkWAbpxC975XjNGfsttdetY99lqgqoFX7N+70q801bSgKsz6i8YcDBVSUlkP306CJgYBauCWF96UvC1eyY2mNpkIWvfHJMMjG2EsJLyrHfrqB9Xw9gyQWJQZQ3jjlKGsmB9HRp4M4c+WgFkuGR1K+Wq/mukQ+07uRzfXHE4y2s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1414bd-00a1-4e9f-98e2-08d63634b76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2018 02:35:36.9091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4729
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
index f8f31872fa14..e37ec4b396a2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -136,6 +136,20 @@
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
@@ -202,6 +216,20 @@
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
@@ -397,6 +425,20 @@
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

