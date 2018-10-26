Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0E2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="N3znAKR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E0E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJ0A5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:57:35 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45093 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeJ0A5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:57:33 -0400
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="20187342"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 09:19:55 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 26 Oct 2018 09:19:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFpec7d+H8qSbC6xHNglY4ZwbeCcEKuwdvW9jn83O2g=;
 b=N3znAKR56Zdjr3Hu6myX5LfWILMe1556ShgmLvrvsDRx+HOObx11hQZfXZmYJ1bnGkgp2c79T8r+Cs5chUfFuod4f288O0dw02ztZj9LYRaOkEVKh9tkG/NXo81G++Ygi0Gfo6CdTUkHbDCfKTjoRPcIWcYYkA/pDOmwG9jPb6I=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 16:19:52 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1273.021; Fri, 26 Oct 2018
 16:19:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <boris.brezillon@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
Thread-Topic: [PATCH 2/2] ARM: dts: at91: sama5d2_xplained: Add proper
 regulator states for suspend-to-mem
Thread-Index: AQHUbUe5yUP2uUy8PEKK5rCQy8syxQ==
Date:   Fri, 26 Oct 2018 16:19:51 +0000
Message-ID: <1540570753-16370-3-git-send-email-claudiu.beznea@microchip.com>
References: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:YEmziRQ9BWjIz0RIwMY1dY3cD2gx9YDDjbveGEN9D3G5k4kYVPlOesoHpVMrRq6XytodQNvB4tRNXPShUXc0rHSkVVj8dsqoQmSzGiVENs2G/e9yIKbC3FicrrNzGaMv4eczk55iZFDkwojadTUprGtKsu5pNX1YYGylNe1O06N4v1ve+/VVK3NdlJZmo9iAJtPHLOgrGVsj9QXfEwEUgbWTJI+SxXmBuExYpgO9SJz1bDXYptN2gMHoZ82Ro1CNyIkTakylZ1vn4zCL5AQAM8w6aiwS0Di3jEoa6y91Mm3Pm44Tumafh3cQwpcLdHvqhLmuvqoYsFVKlTE7Hw/g60/V1UE0JHSTfW3kulrOTycrkLTFc16DmWuo/xpbAC7f5cEt+nf8ZY3BG6wII4j12M8IK4xMoN5I9QWXOl2oUpU85C+F4CKCm1WG88LBOExd3hvxo0LE/vkuM3Wq8ZaAKg==;5:5FtD9KA+UTGJBznBJeb9hNXnvj2j8lbQy1Ps665iJ8UarFTKtflExyO1wFsaCefbOHh66jbTnQZxavKBMJncX2Fqb/9aEww2SFJGfJidGxrhq/o5egnm4u96PiLEHREblcuvVM04GSW0JCrTsxxun0nPQ7ZhtIK31zXaY57k3FY=;7:oWwyKMhBobO0QPfbCmDvhK4du8BEkT6CvpwTMHJD2cryxnXVcSAkewK47xU7qQlERZFX2RyjRolEE7UYT97IkF7Ql2AzXA10w8hXpyb1+cOA6kSQhgcdPqYyyHfPEzP3ucRRU4y7zA51NXGRmch1qA==
x-ms-office365-filtering-correlation-id: e9f17f42-c787-4cc1-0619-08d63b5edb7d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB0792CCAFCA8E3599A21ABDF087F00@BY2PR11MB0792.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39840400004)(199004)(189003)(52116002)(256004)(2501003)(11346002)(76176011)(6486002)(99286004)(66066001)(3846002)(105586002)(81156014)(6116002)(71190400001)(25786009)(107886003)(8676002)(39060400002)(7736002)(15650500001)(305945005)(2616005)(476003)(446003)(68736007)(4326008)(5660300001)(36756003)(478600001)(2906002)(5250100002)(110136005)(54906003)(2900100001)(53936002)(14454004)(72206003)(316002)(26005)(81166006)(15760500003)(6512007)(386003)(6506007)(86362001)(106356001)(186003)(71200400001)(14444005)(486006)(8936002)(6436002)(102836004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Tc8jH7LtaF2RLOg2kJEPeBPhwPn7GFR4NfuIVJ61Fn2jGQdutz2E1TQAg1oPN2TpdHB4MifDgWtT6o/TMqr0NiDYRJlHjZg6Qp12tI29Ag2z0vVCvXe3WREe75uvRR5F8N6h9fz9X8JRwa6VMwU5wa+JXyx1AYdyVW8uRGfcUP9Oxzo48PgYmS0nYgJpP/u8w0KPF/3cJwU6EiHh78mKNoQ/9wgNjHqGllhR7lospp1jXvtqXnQsYDL5H61Cv1zKtVi5xRQWSCZtrJgPRwIrbFVAozRHPU1vcX1pdN4UD9zvwU0x53FtSfozy8jFg+QkUKD0fahCwfmGi64urO+iGQBKhxMqNPEiyhp0s+u3d/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f17f42-c787-4cc1-0619-08d63b5edb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 16:19:51.8295
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
 regulator-suspend-max-microvolt, regulator-suspend-max-microvolt]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 33 +++++++++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index fcc85d70f36e..0137d7432834 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -182,6 +182,15 @@
 							regulator-min-microvolt =3D <1350000>;
 							regulator-max-microvolt =3D <1350000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-on-in-suspend;
+								regulator-suspend-min-microvolt=3D<1400000>;
+								regulator-suspend-max-microvolt=3D<1400000>;
+								regulator-changeable-in-suspend;
+								/* Power saving mode. */
+								regulator-mode=3D<0>;
+							};
 						};
=20
 						vdd_1v2_reg: REG_DCDC2 {
@@ -189,6 +198,10 @@
 							regulator-min-microvolt =3D <1100000>;
 							regulator-max-microvolt =3D <1300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_3v3_reg: REG_DCDC3 {
@@ -196,6 +209,10 @@
 							regulator-min-microvolt =3D <3300000>;
 							regulator-max-microvolt =3D <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_fuse_reg: REG_LDO1 {
@@ -203,6 +220,10 @@
 							regulator-min-microvolt =3D <2500000>;
 							regulator-max-microvolt =3D <2500000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_3v3_lp_reg: REG_LDO2 {
@@ -210,6 +231,10 @@
 							regulator-min-microvolt =3D <3300000>;
 							regulator-max-microvolt =3D <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_led_reg: REG_LDO3 {
@@ -217,6 +242,10 @@
 							regulator-min-microvolt =3D <3300000>;
 							regulator-max-microvolt =3D <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
=20
 						vdd_sdhc_1v8_reg: REG_LDO4 {
@@ -224,6 +253,10 @@
 							regulator-min-microvolt =3D <1800000>;
 							regulator-max-microvolt =3D <1800000>;
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

