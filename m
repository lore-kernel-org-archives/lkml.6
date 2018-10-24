Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAF7C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4372082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="thfgh/7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4372082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJXSwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:52:47 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:34960
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeJXSwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubY1J+RCyjHjo1W6mKImqtM4Cj1ub8opkExO4JB+pGc=;
 b=thfgh/7GunXn36TDxPmeY9ttty7g93OMZBxAY0MmUNxwjgLPFRo7jVFGF+onAoXzAchmAyxSPLgzkwQiqmuxIuC/67WzKPw4m0PxFJpFrJoqz/CAPBAGLfPxcGx2A2Rp2JtL8580aNoNAyc0/J4q/qiRbky1naPbWhGgaz/jkes=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4539.eurprd04.prod.outlook.com (52.135.138.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Wed, 24 Oct 2018 10:25:12 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 10:25:12 +0000
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
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1] ARM: dts: sabreauto: Remove reg property from fixed
 regulator
Thread-Topic: [PATCH V1] ARM: dts: sabreauto: Remove reg property from fixed
 regulator
Thread-Index: AQHUa4PYxBfjeKJfWkiAQ3msareFHw==
Date:   Wed, 24 Oct 2018 10:25:12 +0000
Message-ID: <20181024102255.25640-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4539;6:mQH0O9dKmNixmsxpNr6SVWOS0T8u0115eaXo0ofR7l4CE3JBi85KWFJsDyjCT/N5k+m5Ay5XyLOvR7EqQiNvbvjCWJqKTesHrt/NomZF8ss8IYSorlvhCvIDQsPfnH0wNIJTyUerluYzunKrCPwrdR7M7vCnY5MNBfLydEY0BCyztBGtpw7+Yg5xpD4BhqwKLjG5uph4OZTtvCgJz9LWJfFskmxviHuipvYr/8ASi1a4idUiEGkQ8E/HttBQNoYPBUwMffy82gh1vgHZaI/WmnZTSo0J0gyi0FaA8bKmRfSbTOW9FdMiYBXjlPJEmmfBePUQly0jFsvcGJXpo3n3Pu4NaNsJr9I9w+QqQZ2WEeOHJkUE9sBtNhsf1/XW19WKqzbZcFJC/qrAPXhdOzA4MNBaRP0169bgneFZK61QSgYB8kbmXx0OE+uXbRymjFvF4nh+eiyMYLQ9AJzDQryWEA==;5:k7iVI6qs3tGGFDbverCHWCOOI+zsVJwN5X6/N/s1q8NWciLhUYv0AOH3H0YZGxNlmQM8+EiYALAnaZXfkmqYSwnQQqN5jzK97/KL2WHKgR0qCu6KRM5fahi5AHu/XxnwrOl100ANnqQW1SNOEyM5gmP9JsLiECfzpRbpktK/XnM=;7:5FuZMQ/KNpd+sOZYA7bVqcx1C+gGk+zWapiKNRr42B1VxsBn4PW3B90NNQOJLOcbcByHJT5ZU8PhB1cVyW031AiHwYUqlZ0Hga+SsPo08h4CSYGk3jU8r5YTcxSwneMVzdX3kFvjA/PQJt6ayxHTVw==
x-ms-office365-filtering-correlation-id: 2c5c28e6-eb7d-4483-89e5-08d6399afae9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4539;
x-ms-traffictypediagnostic: DB7PR04MB4539:
x-microsoft-antispam-prvs: <DB7PR04MB453907221DE6302D3B9D9147E6F60@DB7PR04MB4539.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4539;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4539;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(105586002)(316002)(66066001)(54906003)(36756003)(110136005)(486006)(2616005)(476003)(71190400001)(6512007)(26005)(52116002)(99286004)(71200400001)(4326008)(186003)(102836004)(386003)(6506007)(97736004)(2900100001)(6436002)(6486002)(53936002)(14454004)(478600001)(2906002)(81156014)(106356001)(68736007)(81166006)(50226002)(8936002)(5660300001)(2501003)(575784001)(5250100002)(305945005)(3846002)(6116002)(7736002)(86362001)(256004)(1076002)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4539;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: obitfutNtqc+PYaMocA8u8mt57BtA5mAH6AbCrWQ47GKRLwsVPx6uV8VZ+bY0O7iAflQ+eKuDUGdOHEK8yE9eJG3rpvA8VlV8P+G79GGF2UQg9axbG3CXW9ndjP8/BlzgPAaAd4IZRRzC//EAtxaR5lXcF4TQ+AzY5tuRe15quqUy8d/ErXz3vKKdAGXSoT3CVaGi9krDnlpwmZuVb7Mhz0Uk7jd9Y4/rzndYV6g/lVNTm0jH4Yi/ZJsXHj9lRZ19lDwdquLlKK1yu31elHzuj6qqyjsJbjYIkJrL8o14mRIMwcLUDD/Jt5wrDIm4b2T4cblnQq7cw/FwgbWXlJWCoQc6NTT5b2t3JMwdqRYsEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5c28e6-eb7d-4483-89e5-08d6399afae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 10:25:12.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reg property from fixed regulator as upstream has no longer
needed this property.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 53 ++++++++++--------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/i=
mx6qdl-sabreauto.dtsi
index a6dc5c42c632..a10f0ad0bfb1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -75,39 +75,30 @@
 		};
 	};
=20
-	regulators {
-		compatible =3D "simple-bus";
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
+	reg_audio: regulator-audio {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "cs42888_supply";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-always-on;
+	};
=20
-		reg_audio: regulator@0 {
-			compatible =3D "regulator-fixed";
-			reg =3D <0>;
-			regulator-name =3D "cs42888_supply";
-			regulator-min-microvolt =3D <3300000>;
-			regulator-max-microvolt =3D <3300000>;
-			regulator-always-on;
-		};
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "usb_h1_vbus";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		gpio =3D <&max7310_b 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
=20
-		reg_usb_h1_vbus: regulator@1 {
-			compatible =3D "regulator-fixed";
-			reg =3D <1>;
-			regulator-name =3D "usb_h1_vbus";
-			regulator-min-microvolt =3D <5000000>;
-			regulator-max-microvolt =3D <5000000>;
-			gpio =3D <&max7310_b 7 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
-
-		reg_usb_otg_vbus: regulator@2 {
-			compatible =3D "regulator-fixed";
-			reg =3D <2>;
-			regulator-name =3D "usb_otg_vbus";
-			regulator-min-microvolt =3D <5000000>;
-			regulator-max-microvolt =3D <5000000>;
-			gpio =3D <&max7310_c 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "usb_otg_vbus";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		gpio =3D <&max7310_c 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
=20
 	sound-cs42888 {
--=20
2.17.1

