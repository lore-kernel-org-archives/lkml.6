Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0197214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FzViMpqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0197214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeKURhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:37:04 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:2609
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbeKURhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57CpxbVIez743VY6DNXhoOyFV+wA4u1PWruxv3MQiSk=;
 b=FzViMpqXjO6isiq3lymsGOHDH+MvOH18AoQg/khI8v9CiEzPQ5LSqsdULuX9OqI3uPwvYMTR3ePg13IIPksX3klXizAJAX6onosyq+1b4Mvxqvxj350D07gviMBJAjT1xYxOSCQQiMyAivG9fMspzOtSLHEe9v8ezU6tLKoceOY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 07:03:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 07:03:44 +0000
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
Subject: [PATCH] ARM: dts: imx6sll-evk: add debug LED support
Thread-Topic: [PATCH] ARM: dts: imx6sll-evk: add debug LED support
Thread-Index: AQHUgWhXHZckUhe/r02CTCvNkt/KZg==
Date:   Wed, 21 Nov 2018 07:03:44 +0000
Message-ID: <1542783500-19546-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3836;6:PgWgO3QVAoNjtw59lQPUS0SsbdFB0XZHyNOAdtZwcpNNMp+DYxkLOcZqH4SiXpFESfPfSpJpK9RKWHpRmnmMwquHAJzqppZglJRrwpaGrNliykUx+SWP7ntf0qXgXGZ02yIbLASKQb+Df44hVNZdPOoN5eSaVGvjQRdgzl0eTHgXkSJN93sFbbZ8BgBiDGoVG2EatcGaBrxl4ItLIRXW6DDRpKBnhNfEb5D5PC4TbCekxl+Zgs2xT3v50mP1T9sNDDPStVPC80TELzs5Hol/ayWFXF3/aB7kJUAUJk/I+oJdNqJv9IKG3n2ZzqMUtbcqFcZVsZL46gc8Wyext/CcVkmvekLgnJHpg3MK2mGJr1EjZYk7o0vFmisO62TLCUgBDyKDxvUY0gLejoZTMoevDwRa+T5zwLTvxV72TaumL0SAB+O3MB+jRs2xZGsGdBq3dSEguAFvoHaOA7JFeLroPA==;5:6oZjPPWCvJZkZijjm2iy8MsaAF7XYzT5deW0Y/orB5UdiFCSg6j4Ug7h37jL1w7jBWYs13DK7JztyeyzLUG44W2QRehfEoICVRKPuKyGveM+enaD6lEAyjGTVwmBMU3QhT6bgnZ4NPTKrZwg0PH/VmVKobcxKprnRKqUcq+SBFM=;7:Q/FEhOd2u3vcRntdhiQ/GELR/UBg1B0o3ERUunX6w9xP+A8V02QbS8DyOAmnNjFqFh9gzsTuUDAjns08OBhbM6ZEa6qgN7MOX6CiPTn9n/dlchrAMHm4nV9PMXRAlgOYeN+3+BsVEAJFnl8MjPI5Bg==
x-ms-office365-filtering-correlation-id: e6e512fb-e016-4914-d4da-08d64f7f79a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3836;
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-microsoft-antispam-prvs: <DB3PR0402MB38368CAF09A1FF44E00AA78CF5DA0@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3836;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3836;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(189003)(71190400001)(71200400001)(6116002)(3846002)(50226002)(6512007)(68736007)(2201001)(14454004)(97736004)(2906002)(316002)(2616005)(4326008)(6436002)(8936002)(110136005)(6486002)(5660300001)(66066001)(105586002)(102836004)(81166006)(8676002)(305945005)(7736002)(256004)(36756003)(478600001)(2900100001)(26005)(53936002)(81156014)(106356001)(86362001)(1857600001)(25786009)(186003)(386003)(6506007)(52116002)(2501003)(99286004)(486006)(476003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZfE/N26tOoSi/mK69wXXjUEAZbBilcNGtKNDF//L2s0Mt52uZVMaRh2k9KeM7w0AGXj7R0EXoOudFwqD9Lk6sPBEopi2SmwZSEqFEKZn0I2QeOzZHp3Uz+CsCFT6DVHkkxyhuQzqyiVDtxhmpP8/n5aomG3qBVEp/Kn1mmx7mn3UN1sqN8fYqKnNGTvP99rMUxP9b12p91kzqFyX1DwE7fbl06rpK1Kj9J+fSCgze2TA1KD3V2C/vqkPeq64U09h3KbYNwbwHLSCmf7K3NSV8CCAOJH2AohFLsLEHB38jRiiA32XcpNjsKotNMdFaMiHFtp86W48Fj02gmQ/ud8VSoCuhvNd7hi6gkZO7iYTtsA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e512fb-e016-4914-d4da-08d64f7f79a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 07:03:44.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, there is a debug LED controlled
by MX6SLL_PAD_EPDC_VCOM1__GPIO2_IO04 pin, add support
for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-=
evk.dts
index c8e1155..9c90cbd 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -31,6 +31,18 @@
 		status =3D "okay";
 	};
=20
+	leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_led>;
+
+		user {
+			label =3D "debug";
+			gpios =3D <&gpio2 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "heartbeat";
+		};
+	};
+
 	reg_usb_otg1_vbus: regulator-otg1-vbus {
 		compatible =3D "regulator-fixed";
 		pinctrl-names =3D "default";
@@ -455,6 +467,12 @@
 		>;
 	};
=20
+	pinctrl_led: ledgrp {
+		fsl,pins =3D <
+			MX6SLL_PAD_EPDC_VCOM1__GPIO2_IO04	0x17059
+		>;
+	};
+
 	pinctrl_pwm1: pmw1grp {
 		fsl,pins =3D <
 			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
--=20
2.7.4

