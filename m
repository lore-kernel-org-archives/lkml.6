Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB367C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E232087A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K6UhNFIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E232087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJ3Rfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:35:51 -0400
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:10656
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeJ3Rfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6RFQBN14js9hCmMPCvwAV6KjlMYwgH/qU74mFz0AMA=;
 b=K6UhNFIZdpDWhAUffWxjQDvE++TOLX2z/QajIMaY1mTQOVuFG/ptTZA+LzCdVbkixIEF+GsOF316o6iF9KbiPFjeRueFVa4cvm/mLtqv/cT36XOhReyY0Lt8ZYqAgckIEz2CRu5GKmaSmIvfHo9ugfARKCraYjMav5b1d3Vtr4Y=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Tue, 30 Oct 2018 08:42:38 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 08:42:38 +0000
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
Subject: [PATCH V2 1/3] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Topic: [PATCH V2 1/3] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Index: AQHUcCyDhSho9jiNaEyC5yT7iVjQXg==
Date:   Tue, 30 Oct 2018 08:42:38 +0000
Message-ID: <20181030083954.26440-2-qiangqing.zhang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4538;6:WCbAzL4qBqLy04Y/b0R7LdsUDmjDmmWlLi0pQC1w8rwaUIBbh/IMB5YnH8XqprxQTLicazu60Ii8ZqYOfnF4Zq1YOGDAcHWiFUZssKo5pQcleuVauY1rEbjn10ptsgOXWdw1P3NTYG4VAXb6u2CPK9DSpyV+U5FRgmgKzvAs+5hjWKjJI0IRiA7eRGq1evdefQitqR/e8vaBWIVC6evSC9apBUck1VRZ736RxI3aSZNPkQgfPcCNQ3x/wWzGO7o8NwGSwLCCZSxj1PyTh2L2uBdkE9Q79MiSJmnWCgrKB3Mz7W9WBETQ2q/HICpOSx5257YgiQX6CVNQ9f9RldO6vbXJ6YxUOM/Ouw5g4zxKqZbffBoucU5DxskRRxQKAoTlkM/BcK60ITLEiaSc5tOsvMx3aUU9RuoAZaQr2OJ4Zeg7P7+NKk5fjwSp2sGtqt+Fmueg+Yj7n/CU4VqGdd6MYA==;5:Q1QFrn2KPFX55w94CHyiq+lAK4FuLEr84FUHrxxblmR8U8b1Pr0sUo1L/Vsb83uXleDJViC5YVltUK+qQHJwYX1KypQ9dynuSJl8EuXopA6G8NNCEDFrd3npgDlSaXb8XbM+fSmeVEEPNP9f1s2vWigQxRdRQFspokeqfYBEwTM=;7:7mOo2sjWzAncWGHFlogSOfB9t6tTM22QMfrmxHITHkMYqjopsbXDd/4QAZbyMMdEirjiG7wSV8jgkqgrwJOl/g3KIwJMyPXQBLJbRG0nTKO/Zx+m3f+RUr71kZ9F/sWfSoamCEUH6g4di+0SdcBIYg==
x-ms-office365-filtering-correlation-id: c95082cb-42f2-4628-4015-08d63e43a57e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4538;
x-ms-traffictypediagnostic: DB7PR04MB4538:
x-microsoft-antispam-prvs: <DB7PR04MB4538D3F4107D25D4A519AFF4E6CC0@DB7PR04MB4538.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4538;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4538;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(386003)(6436002)(81166006)(575784001)(446003)(110136005)(52116002)(26005)(53936002)(305945005)(1076002)(54906003)(50226002)(71190400001)(476003)(81156014)(7736002)(36756003)(4326008)(2906002)(486006)(14454004)(25786009)(2616005)(6512007)(5250100002)(66066001)(86362001)(316002)(11346002)(6486002)(256004)(3846002)(6116002)(71200400001)(97736004)(102836004)(2900100001)(8676002)(8936002)(186003)(76176011)(99286004)(2501003)(478600001)(106356001)(68736007)(6506007)(5660300001)(105586002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4538;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: witjaFbJ0A7Y4AF7RzuLrzSlLtMtOAIqP5Q+BTduAsyVopHPAZZMrzeAtSTObQMBkgZ4oa4C3ZEOQs0SMciSmbd2AfNJ2LWyaezUlIvHsOqH8YMvoAswhK/Ij3ikhM5wQ2wivuNmwo7p4lkouGb5alktD+iGuemkSiure1fjJR/J/aeWArTsV46zwf+8LfCxXnApbCNp1cDPuoc2ELZRpTcCDy9eZPtOetbjrwSLVXKBCQeSQWOLmtM5Y36qiF0DJf23taLe3uJ/FAbHdmBlsHhMe0BoUXeWO/A5sUA6JJkmTJAzjsbZfR23myoxqNXm7sqZxbXbflfvApPLis3KzZ859RULjEQjHp+gqxQxF18=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95082cb-42f2-4628-4015-08d63e43a57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 08:42:38.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4538
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

