Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AF7217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/HYEVit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfBRGyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:54:36 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:47456
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728539AbfBRGy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMF6mfksn3469BaI3W2QlVEM3a4LL5OsTA571XEYlek=;
 b=O/HYEVitOT6IFHgB0CEOXcTuGl1YVR4TWaxuFFxsMy+J5dKffZ5tkzPx3Ua6IelSso8c0c5surl8sqMTo/mjZe+I77vEtv8Y8h4PamFHtYtfEA6dgi1F9KXmMuubhZ7t86B7SIev6lGJsy+kG8StxOTq/l3x1+G2l38fLuIV8+8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:54:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:54:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V2 4/4] arm64: dts: freescale: imx8qxp: add watchdog
 support
Thread-Topic: [PATCH RESEND V2 4/4] arm64: dts: freescale: imx8qxp: add
 watchdog support
Thread-Index: AQHUx1bE/VGkGSoFAkyRycenototrQ==
Date:   Mon, 18 Feb 2019 06:54:17 +0000
Message-ID: <1550472539-16590-5-git-send-email-Anson.Huang@nxp.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4800fac1-7676-49c2-1898-08d6956de66e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:5ZkZ4jJ8vEONpyEH1vNfqYLIOW8pbsmnSgpRD?=
 =?iso-8859-1?Q?UePm5QJYj3YjprfPnM40DWG555RTT0C+ybSsP0ftvHuTDaGAOTcZUKP2OV?=
 =?iso-8859-1?Q?HYvZZghYA+aCc4Z/X5yHt0TUkIkQZmIqZLdXXZCA2LyBuuNUnv0j2kBvRf?=
 =?iso-8859-1?Q?kTOlmKyhSdQ+uzhoBFfQIklDmB8dnHHk2POF0R/vlV7Ra8NLGng3krj97/?=
 =?iso-8859-1?Q?vzypNGFeaL2dllwxk36v088SjM7kc97Lvj6DbW4/5PAyQht0KBjMVrNdkg?=
 =?iso-8859-1?Q?OWSh8gseuuqAOufYuoJJHmF5aVOhvnAsNklyxjO+93BjpvvNb451ZH/PA6?=
 =?iso-8859-1?Q?Fasq/z9ykQEpU3Bl4oJsexU/yiOvgkARtrDt+JB2H4+SVbgAaUwfECFHRD?=
 =?iso-8859-1?Q?jDsDYj3oWU6MZR4S2n8H0XCXC6+HOCCA2ZFMKmGuG2aXeA2baDoYmtRQuW?=
 =?iso-8859-1?Q?cL5HswEKmTnnhtczfA0VGkt1rYVoioRtrIkg0/4qJWpEaYut9HjiQyAfVB?=
 =?iso-8859-1?Q?chTZSnrpslMga/lazTsrnHjugdokRXZBfJrzLyapna7uVdiXLwJweZG7qM?=
 =?iso-8859-1?Q?HNLmDd/sLz574rCe28KvtVWEO5cNlKtRvJw7UR/Ote0SLdsGV9oiuFa7rF?=
 =?iso-8859-1?Q?u3oyFd8R+0iBAoeNdhg72TZe3nRb4BNIT7ZZLLO3dLaEuOFh+yYgahGYW1?=
 =?iso-8859-1?Q?p9t01py4vUhWUqYOKK+G7olD5WkM1a+My2UGrlOa8s+x55GqXEBSGpsdhg?=
 =?iso-8859-1?Q?KnpHR9db4xMpC0Kqvr7xHzO3GOtpDjnKMxiHB/5i8ifriWOP4W6aLTgNal?=
 =?iso-8859-1?Q?VGjJpaXe0jav3exkRr0mFCMDfpk5O3UtakTvOh00Xb3OGeDI1rwM+HRRzb?=
 =?iso-8859-1?Q?otNGM3YQ2HfxL9R5rtSgDGobgYQyvYDPYvhHbZ8HkFrQoZEAhJGNuKUurz?=
 =?iso-8859-1?Q?l/uLQX1WALaT/gZlzZ2TBfI2Q2YDmzecKMu82kaFkhjsO2eEH6sGo60idp?=
 =?iso-8859-1?Q?WsZUkfUbelGLOFM5rnN7UQlJfY9IQNIi6jJgSeCZ5czycgyBknxxfOl8MO?=
 =?iso-8859-1?Q?3rWxdwEOaIbym0ZY3ekdoweYgiIG29nTUiC5Ga3ZqEaQXzbT/LSwwGJzt1?=
 =?iso-8859-1?Q?fhfcOqXsmN8KGdrNKvQh6oB6uRQseWcAvodFGYRUGJNRT3tAXMWYmjPiGy?=
 =?iso-8859-1?Q?+7rQIDH/W2eEQC/b5f9nTnDnw+OnJOpmPUCYcUj9B8cEZNgR9JaperFRIo?=
 =?iso-8859-1?Q?KAHVAvhNkArPuEYyjYrwm8IcwptsuxrXG0ChU4UQz8+4acxJTY+3Upb1q7?=
 =?iso-8859-1?Q?ED3nSy08Q3wAKS8CXRbOuYYESLtUj0VNlgNI+THdzGcVDUwHYZp6A3DT3j?=
 =?iso-8859-1?Q?RPweuDGHnY=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707D4DE56802D6D00E0A8D4F5630@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(305945005)(71200400001)(71190400001)(217873002)(256004)(76176011)(5660300002)(4744005)(105586002)(4326008)(7736002)(25786009)(476003)(2616005)(106356001)(53936002)(8676002)(11346002)(7416002)(316002)(110136005)(66066001)(2501003)(446003)(486006)(6116002)(3846002)(86362001)(81166006)(6436002)(8936002)(68736007)(81156014)(2201001)(6512007)(50226002)(102836004)(2906002)(6486002)(26005)(478600001)(36756003)(97736004)(386003)(6506007)(52116002)(186003)(14454004)(99286004)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jgsbUitUZErGQbuEmIzRxYRmSMSI9xhaw0l27s2GUs/ucYqNwgMjzviq6y8ar8566aHRLLJpi0Elnges+X/3JAlD6pivv7Wbn7NCAY2IFOGqHfSU4I6HchJR6yrkU8fDKFAyOU7ucXjjLE4daB9GbxeT7AnA+fxwaPb10bZLoOQCDv+e+PNyBrDwKSYOQTy/H6EfhqLV695K1YN65e2Cc/Rjh8/UO5R6AYZgDPvVd6E8PdEvrS7FvG0XNG8wkkOxz3gx6cIENXMdKg7Yp1FNZJbGMz7xhTwX2B9IFf38RKuLTn5sHqDvZEbfh3cj3pcBw+7k3GrPykXCgXH7s4GtsYkr7LJWiCLBhCimvUmUSPFAa6jZQrKUuQqCG+w7u4moc+ybx6HJVuxCGhJoncoDchbN4tJEVxcyyrFFzgZA2RM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4800fac1-7676-49c2-1898-08d6956de66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:54:08.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller watchdog support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use watchdog instead of wdog.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 88eb04b..bfb77a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -123,6 +123,10 @@
 			tsens-num =3D <1>;
 			#thermal-sensor-cells =3D <1>;
 		};
+
+		watchdog: watchdog {
+			compatible =3D "fsl,imx8qxp-sc-wdt";
+		};
 	};
=20
 	timer {
--=20
2.7.4

