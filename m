Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543CFC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F096220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3dga7ILP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F096220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeLMMt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:49:58 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:35895 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbeLMMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:49:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="24317955"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2018 05:49:54 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VDelNaYoZi06blo7DOytcYmGylaIR9j15XgJ0pLicE=;
 b=3dga7ILPGrMYF+if4KkDgYPCjzTwpbabEdr1ZhM/k6IibNhEDDHTP3fryIKKF5sMF3erhjyIHDfzvo3RrQRm6QCeTfapzct85j12ci8TB+sCAF9kKPpT0pp0VV4ImprR67SzJEJlBz81sopC4A2u4T3KgdhQapX5fJ4TaqJEImU=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:49:51 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:49:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 2/6] regulator: add documentation for regulator modes and
 suspend states
Thread-Topic: [PATCH v4 2/6] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUkuJW3a2QPjq8ykCtYQzHkUZEIg==
Date:   Thu, 13 Dec 2018 12:49:51 +0000
Message-ID: <1544703110-27161-3-git-send-email-claudiu.beznea@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0519;6:jhnthA35DSfQvi+XGCO3Ar+QWgHbWKcJh1Lafav8EEisgYLnCrOw8ZYflCIL3Bacv0vHqyZjq0lRW7636+loeOgubqkQV+oZBiIbyAhKIqusAcPUUcFYcQ7KTMXLasWWSH8RDHxL357a0HIMtupFhIgO/Sv9yOG9zz482u02ngSdMf3To0clMZUT+YZpXTF/t9Wg4wAlEY35JEERGnstL0JAQR0jKbcBrViPjIvr+oaidfo8v/Jai0x0McgHCey84uxo0vlHxMLRj9FPdbqd0qaKdKqWyCstpeT9Y3ik6AAgV3AzgvhH0O218ED2aWWahZq0SmKbmMaVeZruOAB0YrmNpgJ+UNUcjEeFrnCp3HFA9GFK6y7wqpGOCvriUky0snBZx8r2xElE/MfiUMAvsTwS7YDlBGELtsz8zeYPVJ0YV3c5AnDxJShC8jAC3DE4LHS02vNQE59D5XKLEOOUpjKsP/q/AAgdk2CjBuANUWc=;5:0wMdUDILyvszBIbMVHUX/LSQPe5+BCNX5DSpHJ5OZ9QlrqYTUxcEPd2LQlWwAjAsQoZSrLZdT/9P8QvbB6rySG2wc+2b6l2UgP8tKn5Zwd/f5KTV/Xi6NIDzxsMFUlX6xfAaZTnkA4excAEFoJRHQ4N5/TA2cmKwXtLS5JXSltY=;7:mgN1SwIrIfDk8bpEkq5dV06ZsKyaekOKogBmaocs9zPBC10FUCnNFN7gRkJTtyDUYt/NEis3k65cB94LtKtFZRQNo2mHaMYc12SZ6Auvjm7OhIeLnY/xswTMu2VwvYdlGkqToFtXdPB3eUeMmajL9g==
x-ms-office365-filtering-correlation-id: 447fad87-7922-4904-7044-08d660f97914
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0519;
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB05196456D0022DF070E70B7A87A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0519;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0519;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(76176011)(52116002)(6486002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(15650500001)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(2616005)(86362001)(486006)(446003)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(11346002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0519;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M2M5xLtntEhDYAhuZqJlWWEGIbjJhdGjC+hooS7oNmDexyx/3RZCuiyDeUG29FkkP3FgPLFlTxvScFpCyTupr0ZVVzrHaN++ObhvM9h5hgNcP2SX2LSTeBAbUoESBzXGT9eGE98o1HK+kHEIGqVPqMRhy4xdlzbkcjTJZ5emYqDKdibBNc0y420HEyAOUdpcjQOmIen3SqWxXfX4hVHwskSrqq7Zr1bU2NiSQOfZLA22r9nnthMnDkKjZk/kYaoL+YbH+7WcsPnfQcx22pBl+72NyTCtfWD4U31gREd5ISni+fImazwDjiNarffUSTwF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 447fad87-7922-4904-7044-08d660f97914
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:51.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for regulator modes and suspend states.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++=
++++
 .../regulator/active-semi,8945a-regulator.h        | 30 ++++++++++++++++++=
+
 2 files changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulat=
or.h

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator=
.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
index ac955dea00d1..4017527619ab 100644
--- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -15,11 +15,17 @@ Optional input supply properties:
   - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
=20
 Any standard regulator properties can be used to configure the single regu=
lator.
+regulator-initial-mode, regulator-allowed-modes and regulator-mode could b=
e
+specified using mode values from dt-bindings/regulator/active-semi,8945a-r=
egulator.h
+file.
=20
 The valid names for regulators are:
 	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
=20
 Example:
+
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
+
 	pmic@5b {
 		compatible =3D "active-semi,act8945a";
 		reg =3D <0x5b>;
@@ -32,6 +38,18 @@ Example:
 				regulator-min-microvolt =3D <1350000>;
 				regulator-max-microvolt =3D <1350000>;
 				regulator-always-on;
+
+				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-min-microvolt=3D<1400000>;
+					regulator-suspend-max-microvolt=3D<1400000>;
+					regulator-changeable-in-suspend;
+					regulator-mode=3D<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				};
 			};
=20
 			vdd_1v2_reg: REG_DCDC2 {
@@ -39,6 +57,14 @@ Example:
 				regulator-min-microvolt =3D <1100000>;
 				regulator-max-microvolt =3D <1300000>;
 				regulator-always-on;
+
+				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
=20
 			vdd_3v3_reg: REG_DCDC3 {
@@ -53,6 +79,14 @@ Example:
 				regulator-min-microvolt =3D <2500000>;
 				regulator-max-microvolt =3D <2500000>;
 				regulator-always-on;
+
+				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
=20
 			vdd_3v3_lp_reg: REG_LDO2 {
diff --git a/include/dt-bindings/regulator/active-semi,8945a-regulator.h b/=
include/dt-bindings/regulator/active-semi,8945a-regulator.h
new file mode 100644
index 000000000000..9bdba5e3141a
--- /dev/null
+++ b/include/dt-bindings/regulator/active-semi,8945a-regulator.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Microchip Technology, Inc. All rights reserved.
+ *
+ * Device Tree binding constants for the ACT8945A PMIC regulators
+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_ACT8945A_H
+#define _DT_BINDINGS_REGULATOR_ACT8945A_H
+
+/*
+ * These constants should be used to specify regulator modes in device tre=
e for
+ * ACT8945A regulators as follows:
+ * ACT8945A_REGULATOR_MODE_FIXED:	It is specific to DCDC regulators and it
+ *					specifies the usage of fixed-frequency
+ *					PWM.
+ *
+ * ACT8945A_REGULATOR_MODE_NORMAL:	It is specific to LDO regulators and it
+ *					specifies the usage of normal mode.
+ *
+ * ACT8945A_REGULATOR_MODE_LOWPOWER:	For DCDC and LDO regulators; it speci=
fy
+ *					the usage of proprietary power-saving
+ *					mode.
+ */
+
+#define ACT8945A_REGULATOR_MODE_FIXED		1
+#define ACT8945A_REGULATOR_MODE_NORMAL		2
+#define ACT8945A_REGULATOR_MODE_LOWPOWER	3
+
+#endif
--=20
2.7.4

