Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6B321872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/O56aJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfBNLos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:44:48 -0500
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:44830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfBNLos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkAJuVGwN5nHPN9VEIm8Jc+uNdErm4jgApurkTh/ZsU=;
 b=g/O56aJRDEAVIJPpeLEtimySuBDDWdm4/yQrLWZbrNfo44OTbzm0pt6q370x85v0qBk7IWfSwQNUgETp4wDA0BDlpi/SXMQ4T/qjSwBCRZvI8AarjS+qoSeSrT+5h9dqdcLCyoMxzijvWXeLYkyajPJmtqNxh7mrbawfZ71mQWw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 11:44:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:44:38 +0000
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
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
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
Subject: [PATCH 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH 0/4] Add i.MX8QXP system controller watchdog support
Thread-Index: AQHUxFqqpLhGqb77Ek6p04rL1RM8Xw==
Date:   Thu, 14 Feb 2019 11:44:38 +0000
Message-ID: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58206c2e-c404-4e27-a084-08d69271cc85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3676;23:v2e8GTwxeBI3hX38CQciFQkVBtc8eN0Xc+zAV?=
 =?iso-8859-1?Q?NPpXimfXMXQ78LNF8EfBjKJcBCMM/Ou6NDqZ39epG4XxK12BVZi7grmdBI?=
 =?iso-8859-1?Q?UIWB40VHHPRnfh+rCgl6vQTJqZpRDxSFq6GDy+oGuMlyOHtakDuytuwhfp?=
 =?iso-8859-1?Q?pHO+2QR7nQuAFCXLzPXc9iF5/RbQCb9vRTxEaZouV3IPip0VDfA4wylmFO?=
 =?iso-8859-1?Q?uiuNI5fuWv9jIvz8IkNvRkwttNBR8l8F6YiPcBd0FnEPCBmRuL2Od5mngh?=
 =?iso-8859-1?Q?WjeZV8ODzfZbIgmQIYjFCOlbhQI6hOmp6RdydjwFfZ36jDq+OftUo8WpcC?=
 =?iso-8859-1?Q?ntoXv3tgkOfvt4T5oe+sRWcQ9gyd33lnDu/q5KNonyKnDJE7WwaJfkQBJ5?=
 =?iso-8859-1?Q?g+GmB+SbdBmgNat7XF7QI+MYWanqrlBdJq08wvISwsB9LC8Vt+7FTJ/+TE?=
 =?iso-8859-1?Q?D0xnh6lZfuxlnoWfdudo+udum8YYOPTp2shTNnix0rS/FlOXNDQKVByb7L?=
 =?iso-8859-1?Q?obuRSbT3e0M8SZAVSTTzIsoep6HIQG1xu+fH3DtodJboDmJi6k2HbGqVNX?=
 =?iso-8859-1?Q?fps8Y8fhmKqFDmOOGB1g4lJV9B6waEhCQeIKm6naC96CvC8A59SFJRHDfq?=
 =?iso-8859-1?Q?B+ypDyz9DKXyF/7cTzCoW1hdITS0N5cgipL/8SB51UwjhBl2oJ3EXZld78?=
 =?iso-8859-1?Q?pS+jzMXWQ/wMBFNkSTv5iZbb5SkRscHu25SclLHGBOOIEKke+KUYP/j/hE?=
 =?iso-8859-1?Q?S7OHAS1E25X1nLJL4Pe/U+9AT6DOkrWI7lWklh1tqUqCBEpuTQLGu1AW1o?=
 =?iso-8859-1?Q?iBDlNYpTaUQH1xN6qNggRiXJ/+g296SbXF7lIvPkvAnVZihny72Y7dwpzi?=
 =?iso-8859-1?Q?jgHRHb6gMoylU1Kg3aimJg/+mEYnAZHWTi6xEJhI+DzVKxXgdFtE8/FucI?=
 =?iso-8859-1?Q?p7ZacNZAAU4YnNRNP1y03JyWfMuEuV+HnSPPdOqSTNY10avkTMySgDTpud?=
 =?iso-8859-1?Q?CkLQba0im5Z2XXq47VseIZ9fXqMjiwpLHC9oYqk6y+F3CbGCtcbz/8wAbD?=
 =?iso-8859-1?Q?9U2jRAUBcAlFjd1p+p5FiCzr3G1bH3lYNBOAmQrAyuWi1wkkLF5ao7Z91c?=
 =?iso-8859-1?Q?7KKpzHS0m/OWqiOEmBfftlvuqWGz6DbLf7yHRCBH72R+eEwBn4+ZIlo5Op?=
 =?iso-8859-1?Q?mlKQAqHORe3tAZDlNLhtXcaqWSK+5fQ04tU5yW7VDlBZEqRVhXh0gbg0dv?=
 =?iso-8859-1?Q?E/NuGDKz8xvEIVch6REWZt8ePujf2lly56veVcE8Q=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676DF7F068E6CAAF9A27FFBF5670@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(476003)(2616005)(486006)(2201001)(6436002)(36756003)(66066001)(106356001)(7416002)(25786009)(105586002)(186003)(6506007)(386003)(26005)(3846002)(6116002)(4326008)(102836004)(99286004)(256004)(8936002)(81166006)(81156014)(8676002)(2906002)(14454004)(7736002)(97736004)(14444005)(966005)(305945005)(71200400001)(2501003)(86362001)(316002)(50226002)(68736007)(6512007)(6306002)(478600001)(6486002)(52116002)(53936002)(110136005)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M+qv1ko9keUzbW60UYxAt56mOlNZuuFXAUy3PHl7WL5+9feTp30h59BXG6xFzOHczZA0M1NkmcwFFy0Z4sbr12Engw1tqLceAIeMjKpYbccsyzTGVltwWl04bTqmERVxfL7gV3C2b6fTRadZNudKksncpIKScH7v9GQpYDGq1U6s2jkIElbJbopveVQKmmXF1Skhi7zs3Ol6ZHCN9vE7Vo6UscDywX1baIigGfltrKa0UkredIkhHn5su6eMkYVmJVmedPzSpTcNEzXjzIHVq8m3KcGUhHbwmKKqEgmGVthyJw/aKbF6hu0U4R2Ck3IVj93GZk5cwfMjWaGqMDf+b3Sm31qZCQw1UeRb5JpbqTjKcGLpT1xtkCXb5SU4osuEMz1miENkP7Nqy/wHA5E91xZZYhNS8JMqgspzy6o3Vzc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58206c2e-c404-4e27-a084-08d69271cc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:44:29.8916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 Cortex-A35 SoC with a Cortex-M4 system controller insi=
de,
the system controller manages overall power, clock, secure RTC and watchdog
etc., so Linux kernel running on A35 needs to communicate with system
controller for watchdog operation, this system controller watchdog will
call SMC to trap to EL3 secure world ARM-Trusted-Firmware and then it will
request system controller to do the watchdog operation via IPC.

Below are the patch dependency:

The dt-binding and imx8qxp.dtsi patch are based on my thermal patch series =
as below:
https://patchwork.kernel.org/patch/10800699/

Anson Huang (4):
  dt-bindings: fsl: scu: add watchdog binding
  watchdog: imx_sc: Add i.MX system controller watchdog support
  arm64: defconfig: add support for i.MX system controller watchdog
  arm64: dts: freescale: imx8qxp: add watchdog support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  10 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/watchdog/Kconfig                           |  13 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx_sc_wdt.c                      | 210 +++++++++++++++++=
++++
 6 files changed, 239 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

--=20
2.7.4

