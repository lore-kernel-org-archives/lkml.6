Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C08C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF1F2147D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Fm8gz236"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF1F2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeKUHv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:51:57 -0500
Received: from mail-eopbgr00123.outbound.protection.outlook.com ([40.107.0.123]:24551
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbeKUHv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmghLTXpMFZDFi54LKltCKw0pdkPCHCfptZOIWDvxU8=;
 b=Fm8gz236fHVv7uxSJg7SLJzsRGOTtDSyEgTTcy7aODQbJupBtR7HN6Lj7Mopm/UWHys1LXXVBYffBifXSI5Hf68RJ3zpLm4Hu0s24XyicaIhyd4lRwtlsEHGq32HS4USuGbv/PnDidjltn+t09kcoZnXdbiZ0771WKIUN3kGmyw=
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com (10.169.244.8) by
 AM5PR0201MB2369.eurprd02.prod.outlook.com (10.169.243.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 21:20:44 +0000
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a]) by AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a%3]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 21:20:44 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH] ARM: dts: at91: nattis: initialize the BLON pin as output-low
 early
Thread-Topic: [PATCH] ARM: dts: at91: nattis: initialize the BLON pin as
 output-low early
Thread-Index: AQHUgRbl56Lu3OHuPEaHJ4EotnaBGQ==
Date:   Tue, 20 Nov 2018 21:20:43 +0000
Message-ID: <20181120212036.22497-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:7:67::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0201MB2369;6:rJ6ZhOfAhm3ThvCGDdY78KeQnoNOGb0N5Lj9WXTGUsqpnbtMXFPH3dMrgJR6X/oLgmPWORjK9UY+IqsDOm5EvDQZDrIxDVLO09y57xSv8g6iELJvur+ATTzDd1E7qY1dHyBYsTrfQZ18X5hGHUP+4fO/UtJgC9N+k81+alxM0yZamuTl8Suwt+8yF/QCNno92AMaG1xV/aTU3d8TcY40oIs4PWZc1vwDRvppe1Wf0R/7uZL1tD/OGdTVT6F9JLQxmMxCJYYANyzrbAqznTtq/mQlKCi2E7pDEnFWNIXZBQ+m4mTAk0+ZU/wpNAXmi1ZHrEFcsm/Mo9gkTvSSbTmIIwGWtLKLZVviKuVw2qKqWwksRPo5HxB4oxbm3f4nqnH2gGzHPjD0IIqISz1KKiHfX+3DFxOl+eBq0WeGL8P3KsKTI+BFT9lfCrsrHEJqKiZGQA435Wg3so3WdYIzZkJ8eg==;5:dTXMIXJaFqo9O754D6bGkAraRFopSmTwYjNRnVAeMuJjnUWCuJDq4vThKV3y9p8r27Vvx5VhA4CyTmjMDzLTCyJvLGtwI1bcy3MAoDGZicFYhxSiFYfJJjxxoT8lsfAnzavi0Htm0MmFiQAwXQlCV3K9Ndjaa8OalgWwOX/K9xk=;7:x+fzmxnrc0DUyiU5/K7VcbUCbMxkZIPHNgiV7Dt6hgkhlxj8ElkK4c3heNoB32nkDYIrxCMHYOQ6yBDGiP1mcyF5oyx1MXAaoZ0n73ERYkjGaJ0bSOV65ETx0z7J8hcYHzAfEiKFImb0Ggc8cexLMg==
x-ms-office365-filtering-correlation-id: f559a445-34da-4ff2-bdff-08d64f2e0784
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2369;
x-ms-traffictypediagnostic: AM5PR0201MB2369:
x-microsoft-antispam-prvs: <AM5PR0201MB2369F429112AD1523319FF6DBCD90@AM5PR0201MB2369.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM5PR0201MB2369;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2369;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39830400003)(396003)(136003)(199004)(189003)(99286004)(2351001)(6916009)(102836004)(386003)(14454004)(6506007)(476003)(52116002)(486006)(2616005)(6436002)(6486002)(6116002)(256004)(3846002)(86362001)(186003)(26005)(66066001)(54906003)(1857600001)(105586002)(508600001)(25786009)(106356001)(2900100001)(7736002)(5640700003)(6512007)(5660300001)(53936002)(8676002)(81156014)(81166006)(4326008)(316002)(2906002)(305945005)(50226002)(8936002)(36756003)(68736007)(97736004)(74482002)(71200400001)(2501003)(1076002)(71190400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2369;H:AM5PR0201MB2451.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3QLtlNflqXtIV5XQ2tljM8snc+fQmGPfhcHBqeI1FsZSJ4Di1JZFzl25KiZhyovI5Et3V89xEJEYMSUwoLy7tix+mfgx5iZr1z06PH9X1JVuBcUu+++q3efCLL2EBQZvRKClsCYFYilZGGp9gPyEAd41vn6wQaWkxU91u07jvbIxE1YFDwMtcKO3wOI1EkemuWfQlKU9wlc7nmvO3bSOLG2Uoj8x3qY+sntWTTnjo8JPd5AeEpR8LE61oIbp3SmdoHTrFcW3MkVHoUQBAc7ssynSm0Bfdzyl/VqS1A1a/mh8qwQx2qWHg+Sa3ZuVRVx6A8md0RwiNCMk15jeTgqz0SqppPsdKP2f5LW4Qfld7w4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f559a445-34da-4ff2-bdff-08d64f2e0784
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 21:20:43.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwm-backlight driver initializes BLON (the enable gpio) to
output-high if the gpio is input on probe. Initializing the gpio
to output-low before the driver probes prevents this action by
the pwm-backlight driver and gets rid of a nasty blink of full
backlight with an uninitialized panel.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dt=
s/at91-nattis-2-natte-2.dts
index 911d2c7c1500..0f6d335125e2 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -60,6 +60,8 @@
=20
 		power-supply =3D <&bl_reg>;
 		enable-gpios =3D <&pioA 20 GPIO_ACTIVE_HIGH>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_blon>;
 	};
=20
 	panel: panel {
@@ -164,6 +166,12 @@
 				      (AT91_PINCTRL_OUTPUT |
 				       AT91_PINCTRL_OUTPUT_VAL(0))>;
 		};
+
+		pinctrl_blon: blon {
+			atmel,pins =3D <AT91_PIOA 20 AT91_PERIPH_GPIO
+				      (AT91_PINCTRL_OUTPUT |
+				       AT91_PINCTRL_OUTPUT_VAL(0))>;
+		};
 	};
 };
=20
--=20
2.11.0

