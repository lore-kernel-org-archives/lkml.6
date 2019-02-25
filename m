Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A592087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ne+3gz4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfBYCTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:19:14 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:10548
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfBYCTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJIwByVuXAh4v7dRSU5aApK7jpfPceQPXcp4Ds9UzSA=;
 b=Ne+3gz4mBkY+tnruC6mYg3fSYj68BCimansEqU2Dh5jrZRqnk6dOh2kSYy9lmwWtT2iWXIxR9erK9A5nAM7/s+O0TlAVIfeDJFnbN6gGPYDAJO+KC21ielDovjS5c8PSGBye/M8hp6UHEkEnN8/U7Em2Mc7kj8U6PBwWz4GnBLU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:18:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:18:54 +0000
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
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH V3 0/4] Add i.MX8QXP system controller watchdog support
Thread-Index: AQHUzLB0r5YVhKiES0eqmgM1XXhaBg==
Date:   Mon, 25 Feb 2019 02:18:53 +0000
Message-ID: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51fa5689-47d6-454e-5e95-08d69ac796ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3674;23:ROmQzD/16XKgVOtZUCuAJa/japmQ6QYlarKKF?=
 =?iso-8859-1?Q?XF7pKqe+/RGeqR1YxpLByPvz7h8BJg3gX0JV2SzVU3uNarcTLdxjTd/0ym?=
 =?iso-8859-1?Q?CvbdnJqmTszlFu6JLCoLkDGr4MenZpWr/mrSE08aigtN9tjOkixONyGiX9?=
 =?iso-8859-1?Q?sZIN6eTGg2qSzY/ua5p6EKXIS9JSXFZyF9SLcdT+6CHPEWrFDxdVVb9rwZ?=
 =?iso-8859-1?Q?CTiHQNqqKnOM+EuD35Qr3bKqX5XBIThxKgepfPideiWqAt0QzrD5Jj5fs3?=
 =?iso-8859-1?Q?e/Kni/AJpW1rwqutB4U88fML1wvrNcA8iBde+uBKOuTJ0khBg5JSxuvZGz?=
 =?iso-8859-1?Q?mp+KsYIADirxwOkexckz19LJoVx4foT/aUC+UG8QIsDVaOqt3/vL9I+pwL?=
 =?iso-8859-1?Q?uAaQ+yuEj7zZca0/dbh+s04jVrmGwFAm8s5zPxiTDViacw4uEgcobnb8Z6?=
 =?iso-8859-1?Q?q71boPA4MUXJol2mnZk4u9pOPbn4fiiUg2a0RYHpyKM1GtAYo110oiNlZ3?=
 =?iso-8859-1?Q?782XS3669X+qTLP/22pbv2x1x4E8bm8jU3VAAWFIcSTNB4QdEh//4jsWPC?=
 =?iso-8859-1?Q?YehuocOb2PTALoi4UDsG8x0Reh2H97sMwg7VXbPZnZZVfiFjau2wOqksFv?=
 =?iso-8859-1?Q?gFzU9EjrrVOKfRV1VONTd+00c/zczivvAYyfzpRAiLHwgYezUUpfnBMvyC?=
 =?iso-8859-1?Q?ZR8Sn6AEjr+GM8YJgQk2oYyF9HzbRnXzugX9p3FCQISHY0yMC9lbAevCxf?=
 =?iso-8859-1?Q?bC8VLQc6C/hRM8hJesj+y5H486rRbUvwhNfAqITY/3uWGE/OfSC+fUlqiv?=
 =?iso-8859-1?Q?p2lqqeiNmhN3TWI0BeKYmzXQVt5yzW2z5ltJLVxN0DkuIP+vfptW4UN+Cn?=
 =?iso-8859-1?Q?f7yEpqDOGb6n4wOVl+rPP/eXlHJgtU6+CYl/NGWo9qatiHoC2HYoxaE5XU?=
 =?iso-8859-1?Q?ZMgPo4zROrvO5CKbNJXhN72lu9MdQYr9MH1NwDg6ijz38IMKVbMlyZfniB?=
 =?iso-8859-1?Q?lvTsAO1vsxr1IkC2SXxMdQqzES0GJxHLLk6pXceCkLwrMIWRaqlNnMvqXX?=
 =?iso-8859-1?Q?Cm218nSiYpghUW5+FoNZfR3yJQ1pBTn3FXm0B6F3PFC2j79iSj6n/cFBbp?=
 =?iso-8859-1?Q?TKpudsPJRLpUcSL+Rgg9fhuObEHYbY6/ZqZXoanOWjGpOZFUapnzzRaCol?=
 =?iso-8859-1?Q?QJFU8YfgioZgFeKnyOgJT8HheehxNZj75bEWqOXizEbzW5zQNc5l62gST8?=
 =?iso-8859-1?Q?YdxM0ANy5JO9VjKMoqTvkjCz/iWPGdYh5mwUViRiEpiziJwhpwjXtTbJIq?=
 =?iso-8859-1?Q?pUkDFYgC53m9p9b0M6AfxPlm/?=
x-microsoft-antispam-prvs: <DB3PR0402MB36746920AD2A6D1C17246CB5F57A0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(54534003)(66066001)(305945005)(2201001)(52116002)(486006)(14444005)(7736002)(316002)(110136005)(256004)(476003)(50226002)(106356001)(2616005)(53936002)(86362001)(105586002)(99286004)(97736004)(7416002)(966005)(81156014)(3846002)(6116002)(478600001)(68736007)(6436002)(8936002)(186003)(2906002)(4326008)(25786009)(102836004)(8676002)(81166006)(36756003)(71200400001)(71190400001)(26005)(6486002)(5660300002)(6512007)(14454004)(6506007)(6306002)(386003)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WWeRo2OayiUs/pBIPSkz1KfnfQ8qwJtMpohKdh/qY719ZOtnvhivFehNfipMNS50L3Yrtt1wjVcUrPwpB3BNezkem/zwgjKlfhPHe0oS78wMqzNUJV8Q5B9msVrMVfXEeMstMpeePSwOBhHn6VBEPmm9eyIl1ovDACXsKXbBlDzBgdrcnLhtJC/L10bn5xgtTXzAIFAjhDTQm7z9h8pQeW3h1Y6vZ6wU/rSQK11tOCnkwpDWFON6nfZBZywwLzCW91Puz/tDUnPcsSfDpju5twTDrfwKd4dmuUm6RmmdtQ63+iTOMWKRc4cbHz9xM/cxZIoTpms8A5lzCZo74KssIK7df3WQUMzPv0HPG1+4Dfj1oF1mnBQa1h3CTPTG/aQH8GpP1F4V/8D2aTS5PMu4k1GpoqDBGUq1ncHYbxjzEHw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fa5689-47d6-454e-5e95-08d69ac796ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:18:45.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
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

This V3 patch series addresses all the comments from V2, and change log is =
inside
each patch of this V3 series.

Below are the patch dependency:

The dt-binding and imx8qxp.dtsi patch are based on my thermal patch series =
as below:
https://patchwork.kernel.org/patch/10827673/

Anson Huang (4):
  dt-bindings: fsl: scu: add watchdog binding
  watchdog: imx_sc: Add i.MX system controller watchdog support
  arm64: defconfig: add support for i.MX system controller watchdog
  arm64: dts: freescale: imx8qxp: add watchdog support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  12 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/watchdog/Kconfig                           |  13 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx_sc_wdt.c                      | 183 +++++++++++++++++=
++++
 6 files changed, 214 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

--=20
2.7.4

