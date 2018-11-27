Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DF2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4627A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="31M/baU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4627A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeK0WzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:55:05 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15663 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbeK0WzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:55:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="23257452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Nov 2018 04:57:24 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 04:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGx4s/LDRaa5QeUMJ6ZlF/2JF6NivYXKwY3ZBvH/iYg=;
 b=31M/baU+mzg6a11VOUO95D4ez2UMZNE48pWRfNtDDQV9pStVregod2o73tk373xA0+q6wCe8pDo/EqG6oTYDpMY0TDiuKY7S8NXf9S47e/RY39ZKfiQ62lfAp5NRjuSFnu5sdKhkX03/UqVq6lnNVb3v9ZEgBlvNn/AeY61BxtM=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0646.namprd11.prod.outlook.com (10.163.159.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Tue, 27 Nov 2018 11:57:21 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 11:57:21 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 4/5] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
Thread-Topic: [PATCH v2 4/5] ARM: dts: at91: sama5d2_xplained: Add proper
 regulator states for suspend-to-mem
Thread-Index: AQHUhkhaVA5mZsvYqUiE/iw7Chw5hQ==
Date:   Tue, 27 Nov 2018 11:57:21 +0000
Message-ID: <1543319801-19100-5-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0646;6:XFoKjgeljsPZhJHNdKnYC2J0G8ljW7m8SHWn/Mniqbc2eZNEJe53kfcp676VpR6IHWQnLywyh/r+N1S3lWuoJ+za1kFKiJd+KKy07+QF0835BleN1gNOkt/rQXuem1m6AOrj15npitVN8LZ9zPh4fnAVmN0FLQjYBj+CE+y2Gjp9LP70obyUVYIpsLCO2zv3TLW/aXXfntgyZY9xRgJQkZ5mtqxl7l8TEGef/jlX4oltpCpfrcap35YCvSxEpSFx14ByIhqFHylLhXwZzJ+BQSKbfRRZzbXnVHxpK9bhL/h3T791LwRaFMZ68AT/00qnaMUG8E+XXy7uBL70/tDbKo2KXObsnelSlO0jExsdSj9Bafe2dN0ZpgaHIYaHucge8c/mmUEhlvy/lX/SvssT+oGkvwvKmTzTYDSKvCwrnUkESFIioaiRxLpDEzl89LsXR/U/1xaM+W55hDM9d7Su2A==;5:/GQZMTrWE3V2zyC9WL2gRpdq8qPud8esEjcppWxJlwlVeMscG5bkkGAaw3Dhh7wUwr3m/XWIzyZx6GEbzSoExX9LePfJjVDErJFUObcC86A0qeRKLrU4z/G5/zBECqlVqfrBO6oA9Vj0J/lw/7Du4XWlrSNuuisrzcjNQK+AyNs=;7:oM/b6txXHWOUYFsPTyJntuz/Pwy9wL11dMRBQQ2o0HfRncwCljonvs8Ppt3LioMe3nMRGi27K7agOeIPGkOKh2ajZ+SNRwpuinCCGjV1V1meiurMTdzS5CaHoyDSwygHJ8bbhLMTUMKSnsOJJgrhsw==
x-ms-office365-filtering-correlation-id: 5a07ebbb-c385-4d6b-e6cf-08d6545f7c82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0646;
x-ms-traffictypediagnostic: BY2PR11MB0646:
x-microsoft-antispam-prvs: <BY2PR11MB06465BE8F474A609CE6582D187D00@BY2PR11MB0646.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0646;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0646;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(3846002)(72206003)(76176011)(305945005)(106356001)(6486002)(52116002)(6506007)(386003)(316002)(110136005)(54906003)(14454004)(478600001)(66066001)(6436002)(99286004)(2906002)(105586002)(15650500001)(68736007)(7736002)(6636002)(39060400002)(476003)(11346002)(107886003)(2616005)(256004)(4326008)(36756003)(5660300001)(14444005)(8936002)(53936002)(6512007)(486006)(102836004)(26005)(97736004)(81156014)(81166006)(25786009)(71200400001)(8676002)(71190400001)(186003)(446003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0646;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IiTVZFWOn8yGM3jGv2Xc4NkOZJEu2irziDDqFhHTibcwkztoTIk1mRt5R5cxYHrnAN9vVcKpw1fQDm/Qj3xj4JBjryyd6lLVlct0ZBhXvakFDP4WLnOkc4Ib0En60OVfqMHZm6h5Y2AvOyel+EOWy161GG+z7AsR9xUpMVHjExBfDNQ6/hCP+9sxDGWUVwGD5Rjpudi3TxkcE91V4awILTqojhde8CSJp4NX0IZ1Nq8XUZ4tfs4IQSxsFoIOgtMissS5COZoOGzLAIuM/ZqbIwzOuGQoXNB/Ic5jlSoo3OjUvCGaWLeOPL7Xv9GRL8dQY79sNOG/jkxSq8uo9Myd6MeKBIwcVLXTaX/2Asmva3U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a07ebbb-c385-4d6b-e6cf-08d6545f7c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 11:57:21.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0646
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

When entering suspend-to-mem, all PMIC outputs are disabled except
VDDIODDR which is put in power saving mode, and whose voltage is
increased (probably to counter the poor accuracy of power saving mode).

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea@microchip.com: use regulator-changeable-in-suspend,
 regulator-suspend-max-microvolt, regulator-suspend-max-microvolt,
 use macros for regulators' states, add regulator-inital-state]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 54 +++++++++++++++++++++++++=
++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 518e2b095ccf..438e6576cf7c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -47,6 +47,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
=20
 / {
 	model =3D "Atmel SAMA5D2 Xplained";
@@ -181,49 +182,102 @@
 							regulator-name =3D "VDD_1V35";
 							regulator-min-microvolt =3D <1350000>;
 							regulator-max-microvolt =3D <1350000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-on-in-suspend;
+								regulator-suspend-min-microvolt=3D<1400000>;
+								regulator-suspend-max-microvolt=3D<1400000>;
+								regulator-changeable-in-suspend;
+								regulator-mode=3D<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							};
 						};
=20
 						vdd_1v2_reg: REG_DCDC2 {
 							regulator-name =3D "VDD_1V2";
 							regulator-min-microvolt =3D <1100000>;
 							regulator-max-microvolt =3D <1300000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_3v3_reg: REG_DCDC3 {
 							regulator-name =3D "VDD_3V3";
 							regulator-min-microvolt =3D <3300000>;
 							regulator-max-microvolt =3D <3300000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_fuse_reg: REG_LDO1 {
 							regulator-name =3D "VDD_FUSE";
 							regulator-min-microvolt =3D <2500000>;
 							regulator-max-microvolt =3D <2500000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_3v3_lp_reg: REG_LDO2 {
 							regulator-name =3D "VDD_3V3_LP";
 							regulator-min-microvolt =3D <3300000>;
 							regulator-max-microvolt =3D <3300000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_led_reg: REG_LDO3 {
 							regulator-name =3D "VDD_LED";
 							regulator-min-microvolt =3D <3300000>;
 							regulator-max-microvolt =3D <3300000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_sdhc_1v8_reg: REG_LDO4 {
 							regulator-name =3D "VDD_SDHC_1V8";
 							regulator-min-microvolt =3D <1800000>;
 							regulator-max-microvolt =3D <1800000>;
+							regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 					};
=20
--=20
2.7.4

