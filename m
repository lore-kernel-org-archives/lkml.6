Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4330CC07E85
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F000520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pkIHysTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F000520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeLFBmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:42:49 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:25960
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbeLFBmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89xNcAqovqw5+M2DbWfyA10H1Q/CUmS2ZGqbtip0d1E=;
 b=pkIHysTkWI7ApGiMKQ2YTykflHL0tJENdC67/tZBACaVLNEFZDkIPVhVY4xIxN0eiP5tF8Ve0TNbnGLK21+xfIlJR7VfTEf2ODhzfzHJlAINXGru6c1XHOTeArA4HjoVepFRcfR2OB2SBC7JoMaYNWkklh4bVTP67CXNpOro+68=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 01:42:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:42:42 +0000
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
Subject: [PATCH V2 4/4] ARM: dts: imx6qdl-sabresd: add accelerometer sensor
 support
Thread-Topic: [PATCH V2 4/4] ARM: dts: imx6qdl-sabresd: add accelerometer
 sensor support
Thread-Index: AQHUjQT6jp0MxWVwiEyvybKsPfEv8w==
Date:   Thu, 6 Dec 2018 01:42:42 +0000
Message-ID: <1544060203-22163-4-git-send-email-Anson.Huang@nxp.com>
References: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3947;6:cmIBZ1YRfecf0LrlUnKoDWRemThR6do5YsAC2S2BZk0OkXKC1rfyvbs/eAt5PgzipDEdKilQRFBo1kmatNvHf4jIy+FO/nW/lmQAolfecsz6FVaBOae7FuPJnGT/Gx0RwSMcgOp4l5iKQm0W/vSdmaOCMI6pMq6FtLtmoCCBgqtmeNfEjOxD5eHzEEUCO3kLA8uLh9oUtK+ekT82BbNfic/HWuTL1lyTI6Y09ZMuU2h/RaSf0LTPWzSnF4kV67njNMhIoTdIRZFlnFJ3ursdqZoUFOfG7jiV/k+kAYm7el+Olxp/uh9Zbug8L66DM9Dovg5vl91umr0dZ8usA8q9OXxjmGwWyT1Sb8csDOU+cHvJPSAiN3L/2xJPebrnHPxxWLics75oKf1Xt/JhagoZr+VtXezP1VZ7oVG2UFPwlnfONeYWyKW4E6pNIbZifZovpH+eDEvz3a64WbvH4xC30A==;5:S0S5rsHovtXeUIjp9tPyShoCW7bOJBRGiXOPktUnqmNv+9yZU6QNj+as/TAbxSmMCRCUdMslKIbITNGN6Df2uav6B51dhXyL2t+c0MVSjhqSAiSN2MHfkcJDW8sepXObyq1YgaLnVbyN86RCKsCvChi37lESaPC8sHXuuwPGLfw=;7:NUu7NRNcfF+KJgxAYKZjyh/JErTP+rWwp2ONo3pKNfJeWyOMCnmP2UASznhkW6wWCNoWIBjDfArSbAf1ttvd1GhuxaCommkVicKXTLkYWQH0fZ5Pgt/4k2HPjvkYZ9MpmJxZi1ENVTiSoZWtdEfQ+w==
x-ms-office365-filtering-correlation-id: 93f475e3-19f1-40b0-5140-08d65b1c1cd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB39471F51CEA2EE2D43DBADF9F5A90@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3947;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3947;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(102836004)(86362001)(2501003)(76176011)(11346002)(6486002)(97736004)(386003)(52116002)(6506007)(99286004)(3846002)(476003)(6436002)(575784001)(256004)(2906002)(26005)(446003)(486006)(6116002)(186003)(110136005)(106356001)(2616005)(14454004)(2201001)(105586002)(305945005)(478600001)(7736002)(4326008)(66066001)(25786009)(8936002)(50226002)(81166006)(81156014)(71190400001)(71200400001)(5660300001)(6512007)(68736007)(53936002)(36756003)(8676002)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v/JeRKVn7urgxd2lJhlMugwsO43jLFHdS2velxsHtqLw86b4jHegbu8Lo1v+79PBqkL4mEW7412ZGRelvuEQklrw8Zf0BlKsr5pnqMdk4WIbhaDEPf6OwKG5+hMnRO7A4kzqWhz6OE850pGvxxeUENxhl7wpNoZ8oUG6QVVabxPfuBRS2gJdIkiSoTDTkQZF/TMIAuVWRULLGCFVcYwrHwhTBCstIOTUQx3IV8FojGD2H5+RPgA3krU3a9+hFAKAdnyiAK8PISbyhKVPXyvH+kIFcdzxnKsYb/LcF8ESW75G6FVdqY6k7xlcx6cgCq6ycLvQEdcpVCQ/PSFoAN9EboCTvlDEqRwzkTkTkfhVN7M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f475e3-19f1-40b0-5140-08d65b1c1cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:42:42.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add accelerometer sensor mma8451 support on i2c1 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index b8a2fd8..174db44 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -242,6 +242,15 @@
 		>;
 	};
=20
+	accelerometer@1c {
+		compatible =3D "fsl,mma8451";
+		reg =3D <0x1c>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2c1_mma8451_int>;
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <18 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	ov5642: camera@3c {
 		compatible =3D "ovti,ov5642";
 		pinctrl-names =3D "default";
@@ -521,6 +530,12 @@
 			>;
 		};
=20
+		pinctrl_i2c1_mma8451_int: i2c1mma8451intgrp {
+			fsl,pins =3D <
+				MX6QDL_PAD_SD1_CMD__GPIO1_IO18		0xb0b1
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
--=20
2.7.4

