Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F92DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13734218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lnzY0m9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfBRCB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:01:57 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:20032
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbfBRCB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkAJuVGwN5nHPN9VEIm8Jc+uNdErm4jgApurkTh/ZsU=;
 b=lnzY0m9zrLyINP86QUAQqDjCGOT4yulhphT7HbKvzQjnjuwWZdE+L8KE+6O003Um6jTWzLXe2n8y/fPVC7Z7v9TpWoQ0VPX6y60dY/6WXtzRaXTiZORK3Ym5GPa2QCEGYK+b9OXUydOsBeJC67hBuSnd076fdGlW9acAqUuml1E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 18 Feb 2019 02:01:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 02:01:11 +0000
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
Subject: [PATCH V2 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH V2 0/4] Add i.MX8QXP system controller watchdog support
Thread-Index: AQHUxy3SjzHfKLwYjUOtmItPpKm1yA==
Date:   Mon, 18 Feb 2019 02:01:11 +0000
Message-ID: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9f9851e-b602-4421-5486-08d69544f424
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3900;23:YDQHBy7oREmN76FBisT10bn6rgF8MrDSz+WuR?=
 =?iso-8859-1?Q?t3CCw6NoxarNUbvD+8pxCAnb4P1XQqfYPxxSFRd3H2WXO+0AX6iWPz9kZ/?=
 =?iso-8859-1?Q?6TxmPQg99LMBqPB711+kqKkEF63GaNeuSGZNle/rzHIQjOs8r7agVrB0Ml?=
 =?iso-8859-1?Q?rUiZIbl8Bkie8UA7xbr4kOB/dYyeYzO+stIT5R7n2jGreN9rwBtGd0660a?=
 =?iso-8859-1?Q?yifnrOzIOJFcZj0FjM/b2tzz3kjqVUEj8h0DG9yttkRFIaWGtJtMIqRx9Y?=
 =?iso-8859-1?Q?7KduxyqXrQLdEDvO++XZFIfYa096Nay7Z2UIh4KlMObujxgZ16G48zN5hL?=
 =?iso-8859-1?Q?0v5nwQbACX5kMz4n/DcfAlIJmZf1dVtGJCNjp2bbzv1vFxxbesK9ZuZNoM?=
 =?iso-8859-1?Q?K0zpIqQQNJO5OpQT2Yh5Kj/HthlmO4kOyNCHIs53A0oYRh/NPYB+9gW/h4?=
 =?iso-8859-1?Q?H/7WKvZP5EjJ0X09VH0fqw5xQuiAo8nsFA0gOq74R4gzIcxILktYCY6tEm?=
 =?iso-8859-1?Q?rYDQoiUhSMMvmfBNuQ9FVQGHKhngs0wll5RUhGT5pjZSpimQIKQnbhWdRk?=
 =?iso-8859-1?Q?VpLicKt/8djjfxvRNbhER0zrb4zstJRdrNsq/uJWiJTPTGW9RvAdV6gckZ?=
 =?iso-8859-1?Q?cfpYV9lxMaXYdxu0Ow2msKrnhnWt/VFSg+eSzbWOC2BlUSkMml7s2A1335?=
 =?iso-8859-1?Q?O+rrOova+QoMqu0/2x3tQFK4369FFYV4z97s9Hxg9uQiG7k4QuFruWq8hf?=
 =?iso-8859-1?Q?ieuiVz1o34IkRiWaUOoQ2Kop5KzK6Ge7Lwll6P77hWmi13g2B9k2MUEK4J?=
 =?iso-8859-1?Q?BJqQNs4Wtdxb21iyQ9eChupaHzVmXVK/+qyk3j8SQyRzR5ZlhB0Q9Pw3B/?=
 =?iso-8859-1?Q?PMK7Ou2tQgEi7ZEuetctb1sZQ9Mjqaz0DRffVpk9Nr25hq/riQyzyE3o4Z?=
 =?iso-8859-1?Q?YvjFueftl4E2yo1aJUcDQ8XELQYc/Ifl39VITfZVnNx2WdIunX5AlUjhIc?=
 =?iso-8859-1?Q?SqypF1///haBbDpxux1Yqf1cgPLrscfAxW7eZRphCWOyCZYeZboqsQj3u2?=
 =?iso-8859-1?Q?/tnifQLz4bdzkJVxG5bxvAjwZr7KgkB5b4GRbFYI5rrbKBWxu7HEjxwExu?=
 =?iso-8859-1?Q?YlomLfSR5vZeSB1Y5dsB4ruV4sr7tctP2VOITp8VF3fDrsihyLkrdZMPTa?=
 =?iso-8859-1?Q?kyrzBR67XJJiC8P6mI2QkTZYPMyjtE+Q42oXIMGq+JdBJ8h3RKnXCfrogO?=
 =?iso-8859-1?Q?ZV0vWVD7bt+WHN55BlSukryN3KOahXPOc/XqrFdo31MhUsQ7+N0Ytz7Z6K?=
 =?iso-8859-1?Q?wXOU=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3900E2CD23820A810C7AF639F5630@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(6306002)(7416002)(66066001)(81166006)(81156014)(8676002)(6512007)(25786009)(3846002)(2501003)(8936002)(476003)(6116002)(2616005)(50226002)(68736007)(14454004)(478600001)(2906002)(2201001)(105586002)(6486002)(106356001)(110136005)(71190400001)(186003)(52116002)(966005)(5660300002)(6436002)(14444005)(36756003)(486006)(256004)(386003)(26005)(71200400001)(102836004)(99286004)(7736002)(53936002)(4326008)(305945005)(97736004)(86362001)(316002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e51Xsp+pf8SYVyi6aX1Ujb1S+bUFzL9dc+5dIY0z+GEwW/ke7F8Zm1Xm6dFWyeu+sPCkqf1reuYd7riMh0RsjPQmym8tgRKzy2PjC/b2XgaAOMzXZpishBxavR+o+AYABM9qZutSm22hGXgLShPwb7+1Vz4q71q6BHwVxsqxyN91sl0yJ3KzKJRx5uqNE0j4YV8T8rrX24SFjF4czi0sKE4cpspKWMh+hiUOCrB7/msLrT1oprkOhSoqOJe5Z25ouZEGbhdomItZjKJCJA8Xwg11NdpDvSjDTtRJ0Sa4tIoKqs+O60sfjZ8j42p3kzi/CCYbJkqalfLWMid4BeTqoKTQvRlMelr2KLrwlli2WQbToHrJFEoWYBXlZFWotoamxE5dPGWpXXPvizqr4UeZDGPFxRET8vhv+Cr6iEYw81Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9851e-b602-4421-5486-08d69544f424
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:01:02.5873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
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

