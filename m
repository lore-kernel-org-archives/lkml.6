Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529782081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="luFT8/n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529782081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeK1VA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:00:28 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:55712
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbeK1VA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28RoQ+52tmoammCgl5RA0ZX3xKbOayvya6Nd6u7Qliw=;
 b=luFT8/n4OyEv9nVDRIre3t8mb1XxQXTTHxvD8nQhs08+KEbnrhbKmk2FGxgi1zxh5kzW2j2cPbGq0Y2CqsHkCqv7DS/Kx1KgZFu+Xb+6M83dfJR+WKLcEhsej7RGmg1zUWg8JDNq7L6wEN0J2FqnMjgyVQSNlisWR5cmKOttig4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 28 Nov 2018 09:59:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:59:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUhwEFnqV0j+fw70ymIbu2TIHD8g==
Date:   Wed, 28 Nov 2018 09:59:15 +0000
Message-ID: <1543398783-3185-5-git-send-email-Anson.Huang@nxp.com>
References: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:JBCxLrYrxchniAgla3jWu2LWrFZUvPlYGdlZHCPoocHbDfY4djaUmoamo+kD9vVfNPAlmMR9k8b4e2wtkWnTKrzxThnq0XPYryqtF93amG/8XeBp1G/FkgmA8e3uRo7S69RGuNbDeT9Wv3sXlBJa3+MffSVk04onOHEEaPOO3+5cQXYDikX1cieAI8B2c3NXofdHIps3E6T+82FRueuygzr+GV0UIZOnB5V09b/dEb1peJvi+nxmkOy8PIpFIeQ5hZVzz62i7uFabbteEqe53qdeATKp0yBv1pFSwXFd+JZcuY4gbwePbMRtZBLjgyIPa/0qHl5K/sdslhC22fH6tXMermHNax3Wb3IU3bRqRjFTraVtzjCMC3p0uv5gy8vo/n3UxfKXCeoqIrdT04Ykn4tYqJj1hBzwFL4xHI9oBTTD7zQI6lCfwdBs2AfSiRFyXWqWT+irew/kMzVh2+HDJQ==;5:o/giq9qSV6cdTlKR2sQ2AhyUrnr9cNoYNsp34Kvq+j2U2xjHTFR0zYSyEtPHRuuqxa6Tzg0t5fP17Vu3gkL4kao8vdStIMJ0EV9l73h+XD1LAsHhfBbnSUQgAFFyvacSO5fbF2gWGttmQRSxjBIIE0moVU4onWquutH4J9dwghw=;7:LZODrBynIavZX0icVQmIT00NXFYoOjPFob8P4ZHcBWJO0MWBwiHix0nDE+Jm1f9rVkHGaYOjTwUQ4mtS8EJbuBV9FQGYT6R6y9nsKBI8IqoZjjZVIA1GzH3Ot/x50VdZioxwapqhWnqNhz433i/YSA==
x-ms-office365-filtering-correlation-id: 26f3de04-f5e0-401f-335f-08d6551827cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB36599B3CAED6268FF42F2511F5D10@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(110136005)(4326008)(97736004)(186003)(6486002)(102836004)(52116002)(53936002)(25786009)(2501003)(8676002)(2201001)(26005)(8936002)(39060400002)(76176011)(7736002)(386003)(6506007)(86362001)(50226002)(478600001)(81156014)(6436002)(81166006)(7416002)(476003)(36756003)(11346002)(6116002)(99286004)(66066001)(3846002)(316002)(2906002)(106356001)(68736007)(105586002)(486006)(2616005)(71200400001)(71190400001)(305945005)(256004)(14454004)(6512007)(446003)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AfndrFD1/2PsF95QzxlT/kMTeh680kVOolVMV6mFpeRsg/SeliePUr+eK6edaltt27XFNro2B2WvRtIlt2mTt7xUPiQcrluuOZoZbXmhsdtdA1LSfIvKZnYCf8cNejfKwrk7mpHlyDJRwDwfCdDaTY7hKWldagdQCKi+dkSyWxFFxk4KCsjo9ONINOq4mmIY21ObUyhbtZzD3tG7ybglyQupOvC6mkOdrnTBZRaRSr70xOfEKobpg84EiVcdmtOY1Iyc15qLi803nr3ePl3oTc9EKiITYo/0bXiCmfK+qq950dYP9AW5NnKm7PJEBTk8nL92mVaLlSgr44TxCrGq9TLSwpogDzSsZ3bngeI24Aw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f3de04-f5e0-401f-335f-08d6551827cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:59:15.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V2.
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 ++++++++++++++++++++++++++=
+
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 5e8b554..ef57db6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/thermal/thermal.h>
=20
 #include "imx8-ca35.dtsi"
=20
@@ -85,6 +86,32 @@
 		};
 	};
=20
+	tsens: thermal-sensor {
+		compatible =3D "nxp,imx8qxp-sc-thermal";
+		tsens-num =3D <1>;
+		#thermal-sensor-cells =3D <1>;
+	};
+
+	thermal_zones: thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <2000>;
+			thermal-sensors =3D <&tsens 355>;
+			trips {
+				cpu_alert0: trip0 {
+					temperature =3D <107000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+				cpu_crit0: trip1 {
+					temperature =3D <127000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+	};
+
 	adma_subsys: bus@59000000 {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
--=20
2.7.4

