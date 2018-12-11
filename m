Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59100C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BC72084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dnkNnegH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BC72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeLKQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:02:36 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:30590 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbeLKP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:58 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24239888"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 08:56:57 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 08:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGx4s/LDRaa5QeUMJ6ZlF/2JF6NivYXKwY3ZBvH/iYg=;
 b=dnkNnegHzXGWPamlbP4Aldv6r/7NTOek6N0YQWSlH67f1ksHaE6qUsFLC8CZgbFgFV1CyWT/SuXCSTsac75WVt4cueZbY76jaiOKul+d9IppTEuG+Rvu2p2gfkFIQdbIySTP8mZNb/5+xpGNsZWYHrgaS0UpE4rDhVAqknItATs=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:55 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 5/6] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
Thread-Topic: [PATCH v3 5/6] ARM: dts: at91: sama5d2_xplained: Add proper
 regulator states for suspend-to-mem
Thread-Index: AQHUkWojNt33A1ZmaEmet4DeQfrHFQ==
Date:   Tue, 11 Dec 2018 15:56:54 +0000
Message-ID: <1544543768-2066-6-git-send-email-claudiu.beznea@microchip.com>
References: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:D0OVWm0i7TnhlQJJ8DCMKw+HV/5EyNMYNXHiLBIigttOSngYMCbyik78gTQMHmgN/zhRPYa5cRbSYBLo8PymtP6G8fBQe5hx/8aRxFVoUZqwuBi+BLXkXlDbyDTrwoWgbhSv2Dhm6uVFuGOpqEOfprvWeuoucBgk1lQoLKG/JpjuGXwnqNkv0+jgLtKQdNr9cLAZ26ZtAYM+hHJqHOhyMYbtgWdreQlKn7HIQfEOx1VEs0SyzSupuJnMSJWo+4euxSwQJv0bIGAqlWJQvxInbnljSK3g/IngNZI1zWaKLtjr6wfZ5gn0z6sZkK//PBhnybuydvGuZyxjrmp0zPwK3SZt7pzUubBS0/jYUMxLC/34SzDmnMZbSnJDNAGExvJgPMORQwCl+GYYXAxnowb9wjGPmkVxvjeFSgg/SctQKx6Hs6rkbbQqgESuwMIQjMm1inP+2bh7RBokEa41xDFByg==;5:3SU8STKYYUz9iLRnPRWN+6KEqHMsavZ8woMkYEfeXAPhn9eZ17gJ+H4YQCP2Lso5AzpbsbHNcz82zeBchJ2z9+hlCGsLr9J9DHchV2gVpfQRltlUaAb7Q32qnYYXVqjtcA5ZS9TsXx6Op9rkggRvYybRiM7UjP5gKaDXTAz2bBE=;7:Z//cDQVIKkQ5xuQz4OfMmSWbys7pw/dggUz3KbROH2+gnkq+i3EiIu3we4koieKkUJAAMjrdy3gJZeFU8H9voZyL++XSShYNLGsi2m8wBfpg/itT7ThtYALE59ujUNWrB2EFDgduYXeS6AnHSOAo2Q==
x-ms-office365-filtering-correlation-id: 8b8d3ee0-1bb8-4bd2-78d9-08d65f8145c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB0792D42B3DCE43843584516D87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(4326008)(102836004)(486006)(15650500001)(81166006)(99286004)(8936002)(25786009)(186003)(3846002)(66066001)(26005)(8676002)(76176011)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(446003)(11346002)(6436002)(14444005)(105586002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NGQnd60+hzZkCm/JLJMCsQuGUzDjZBUiZ3JH2Wm6fKKXD+w7Sz6PVIh687CewJqOj8+74jwFFKMm1UrsiDdVJqIxwlpA6TGCcIi9YQEjhQG3zggix76bDLNMvF0Tu+OalQY2ifxK/JuDrh93xQjm7XKwEHUREc99f1IhM8hOnRlQuSLGRzaw/AtwmGpzDmBAvVKsAvUYRGdwGggWzY3qplRJwvKOPsJlXZODonMR7SXS0mYQ+ASmpyQFx0y4PT/aTJ9ys/D1pOe6UsiSsB0hrMczb5p8JICRbN7qZq/lAsQGd7MChunQHp12DqUgfXs4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8d3ee0-1bb8-4bd2-78d9-08d65f8145c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:54.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
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

