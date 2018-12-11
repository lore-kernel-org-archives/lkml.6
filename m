Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE38C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB4C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="AcI23OJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB4C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeLKQDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:03:21 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38774 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbeLKP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="25108923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 08:56:38 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 08:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxxT2pAFXr1RN0I4DvwXHu2JGBntIzG2YdAm/5jxx/g=;
 b=AcI23OJYnKlDQiaNZhoNYZ/26Hsb74n+7Lj7Fku4LT1uOL6hbgkUJ0oL4+R497vuzMOHmkfyMc41U13r+TNrnehuPfI5GPEgg7p/adUhgdIJLSEw2P1gNCKvPZBJOq2r6eQUuZnM/0hODB7gl3GGpWejznWE7hbM9RiTiGADAng=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:36 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 1/6] regulator: act8945a-regulator: unlock expert registers
Thread-Topic: [PATCH v3 1/6] regulator: act8945a-regulator: unlock expert
 registers
Thread-Index: AQHUkWoY+8nYZNARYUK38xFwQAMZJQ==
Date:   Tue, 11 Dec 2018 15:56:36 +0000
Message-ID: <1544543768-2066-2-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:+QcASwWJLEoE/rxEoRVjOvIk3C8yw5pr8Yyx9gCS/leHn0fmk+4gvMR9KMjKEvGWywQTKH8ITxI5LrFSrNKZAX38uXH5TjdM4Yv/oqA6nzb7a2bcCcDEoPIrGA9+uKaZH0f4NfDg27dkNo28sS7Od62gE/48z2ls4dbD0nmGvciWxIV9USHT4y2O8iOpflEC3PlRm9PRl26laRbjsuZ8Y3IDFENmLZdPxXZ705nl1KCr9a42s9+dQdy0ns5eDAl/J9O/U+hVNdIlBTNaQ54B3lp7vsVlhNxoSXrgYgpE3lewVCdTQwsPbwPsPKZtBRBRM6MLl8p+Lh/PJOinPpvunTpHDTnGU/MNIwTcdTmncQqcdznTq9XWd7y7Uu1v0erLZ7ERHRzCxsUrg1mX6jaCN6G1etbb2Dg2cs2FMZY0P1HOY1csq/oCq0jT4vNYiBtfLDKnzA9M0EbNWhPTsigNTg==;5:204SZDKBTI/HMpBsKe7meYNm1fr3gAR9bUj8+Y13jCkoSzNMNmfQo4IL36WXAYaWNkzRHFcjMeZJIFQlOTkUiWDo6XVPfXv822AcbQcmr3zqLKV9q0gjLqRVglIt4xqpk70OYsE3LTqw1GvXeQk8yBJITlAkR4cumrqW0JYSopU=;7:rvlFC6uxgfzGfIof8u/BvVm2Uaa+rNvo8CHTIhjA0z9WxSsv5ET2L8/IaUY9LNav0IePNtg/ev9n8lFVRlN7RY0TMP5W89kpVbxGM7ZsSBpZPfJwcT3LdfnYTI2iYUWCMal/oz8tyh8Yer5xMxXELw==
x-ms-office365-filtering-correlation-id: 32532900-a33a-4962-a49a-08d65f813ae8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB07923779117FE3309B37BF8B87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(966005)(4326008)(102836004)(486006)(81166006)(99286004)(8936002)(25786009)(186003)(6306002)(3846002)(575784001)(66066001)(26005)(8676002)(76176011)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(446003)(11346002)(6436002)(14444005)(105586002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lZeHu9x7CVQoVNBQin6SYOrdkLKq5T/oJ7mO3rABl4UwRWjAIk8bbMSAk4kOlPmTEU9+dR10AsyZCGcxgsxuq1JIErJ1PEIlQA34wv/vC+L9L6scrjEW674dKr2nUUHVfKCZimi6Pbvf8ONBHIJnd4fH/Vie57iML3xJj79X2eSoktas8wcRVYZQx2BSA2aMQpgycWNT03dXkP9biQDZMXPm9I4P7XZ8nIpcZsYM+o/vzx1MHgRJjUmda8FpDa9CQ6EUo9hjVip5tcPMkQ/jRM56o4sHYTU2CpY1Y1Nz82lHX0Ixhn+76/jFjN18Znkp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32532900-a33a-4962-a49a-08d65f813ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:36.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Unlock expert registers for act8945a.
This is based on orginal work of Boris Brezillon at [1].

[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index 43fda8b4455a..8d71d9893d0d 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
=20
@@ -23,6 +24,7 @@
  */
 #define ACT8945A_SYS_MODE	0x00
 #define ACT8945A_SYS_CTRL	0x01
+#define ACT8945A_SYS_UNLK_REGS	0x0b
 #define ACT8945A_DCDC1_VSET1	0x20
 #define ACT8945A_DCDC1_VSET2	0x21
 #define ACT8945A_DCDC1_CTRL	0x22
@@ -123,9 +125,17 @@ static int act8945a_pmic_probe(struct platform_device =
*pdev)
 	struct regulator_config config =3D { };
 	const struct regulator_desc *regulators;
 	struct regulator_dev *rdev;
+	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
=20
+	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev,
+			"could not retrieve regmap from parent device\n");
+		return -EINVAL;
+	}
+
 	voltage_select =3D of_property_read_bool(pdev->dev.parent->of_node,
 					       "active-semi,vsel-high");
=20
@@ -149,7 +159,8 @@ static int act8945a_pmic_probe(struct platform_device *=
pdev)
 		}
 	}
=20
-	return 0;
+	/* Unlock expert registers. */
+	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
=20
 static struct platform_driver act8945a_pmic_driver =3D {
--=20
2.7.4

