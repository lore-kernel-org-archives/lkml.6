Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB407C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80794217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5hQz9mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfBRGy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:54:27 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:47456
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfBRGyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrM9BCm9y7Y1cuUfJyUAeEJToBuXD9iRMdPf1FUA2rM=;
 b=X5hQz9mHzddw2lgPlisgFarS1yfUDkoCKREkcwVHJUmB7lxpt5f7bzndLkLb4quowHIF4G8Q/fjy21oZR5HeneiXT+VhFfoA5NHunLZr1zR3mLHpKq9TEMufwzSBjDXWwiyXsj9bUHMe0JYo+Nf4UgyK4sefFZ7JvA40nmg+cOg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:53:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:53:39 +0000
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
Subject: [PATCH RESEND V2 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH RESEND V2 0/4] Add i.MX8QXP system controller watchdog
 support
Thread-Index: AQHUx1atSP6lSFBBKUe5Cz27IkPE+g==
Date:   Mon, 18 Feb 2019 06:53:39 +0000
Message-ID: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: f380aa6f-73d3-4fec-21c4-08d6956dcfd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:RBuINAoncevKsKcqWFPkOm1449Zw1S4eVpBXl?=
 =?iso-8859-1?Q?CQyO8vDm+GvmWn6xj/PFvn4aOinmjUrGX9kbMcxfEcLcTVWdahr0PJSxG1?=
 =?iso-8859-1?Q?QZLJibtv+FGtcYYAWHIyqG4wjL713hZzzffwCGVDVg1WE8Frzx0OnExDJ5?=
 =?iso-8859-1?Q?S7+6qvz3OiKhppYP1S/XP1xGXK1CQgcH/Vm85UXPjxbLxy6l1NzoPKU0Dn?=
 =?iso-8859-1?Q?rqY78fcvD0sGWjLAImq0D6+BS3esqQ55KyOjz3UxpcgwGGjYmseAVgz70s?=
 =?iso-8859-1?Q?RtjQu9fHy/miEw/fJhFUfQvudzTOdFKXDSRO2SjFAn1PY+c602hPh7F3in?=
 =?iso-8859-1?Q?1/JbW8SpIbcWE309I/fww46zZB1UhXnsltSv5iS/cdfqmjEWGreOWwgP10?=
 =?iso-8859-1?Q?RbHbkG/VQHdzX8oi7mSN5OlNtm6pMkIiArA2/55d0V+8DT27m73fLf0jpo?=
 =?iso-8859-1?Q?AM0swvI/vJ3zy8FSKpICxU9dsA+rcYeZ0IhDMLlM7s6mWjn8Sjw5a9z96Q?=
 =?iso-8859-1?Q?/XPaCxX3E5VXCG+Fn7bjVt7E0IJifK+Y6+tv4KYEbEzRiXOKjnuFuSnV0x?=
 =?iso-8859-1?Q?HzI+nlrdva+GUfJ/fl3OV3XXtvxk2Xcs91Ilc3nil/OmwUOnTRv/Jot+Fo?=
 =?iso-8859-1?Q?LkPPUGDda7OrDDoE8aUvIjf4MbQNS+soztS8xFTcC9ZbPelBYoSRldTulx?=
 =?iso-8859-1?Q?5SjMiqU8Pv48+KxWbLhyAS7R0CiiOU2+2YfxAUdLY46odP4HVH71v77t7c?=
 =?iso-8859-1?Q?voB6m3FTvyb2CCGEL9Xs53Rzh0WNE2AdZzJK5VBYUjxEXjPnaaw1VdgWN+?=
 =?iso-8859-1?Q?ey5feWD8nmOBtRrQ5XDh3iUHINBZzmtOZBaxlKqNk0GkEqbcRws6ZlprGR?=
 =?iso-8859-1?Q?lkWhzoX0udHQ/ijgq6KxWgXofdNlhBHjki/Dyy3gY4z7ZOJaHwv0ZQWScl?=
 =?iso-8859-1?Q?f8LAiOkRQQHgq7NBqj0cGqiDzp6hIKPdwN13dnjEp5b6hbvI23uXcrXbwM?=
 =?iso-8859-1?Q?7OZHh7mGsGDZE3V/5uFYf7OImlafZqSkGyeTgpPeE4y2UZGPFdRcukFfjh?=
 =?iso-8859-1?Q?BtMpwSHyVZ7GCYhpmiW0W0WJLWiN6dypBgyJRSKCj8Daj6hEv+e08kf9To?=
 =?iso-8859-1?Q?T8dEzcEgWLB88L0BS9fkgh7GOpOsl31kGXmoEhaHtS4Ht1xEGh0eOOGKM2?=
 =?iso-8859-1?Q?JfhGP7R0y9ohg1aFaJ1MQeciGQJSvr3mN5wyVeJo7w3+dDoeD3oM67yPgH?=
 =?iso-8859-1?Q?KbGldj4eUf5x1hOlwAPYhXDAmSKCLKXpP2S2P3TBW+gWIxyYPji7petZQ1?=
 =?iso-8859-1?Q?nDBVI178ZVl9y31OZSSwaWL1I+6p3i+mcY+OdSI8F7Tb+gQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37076B11FC1845C473D630DCF5630@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(54534003)(199004)(189003)(305945005)(71200400001)(71190400001)(217873002)(256004)(5660300002)(14444005)(105586002)(4326008)(7736002)(25786009)(476003)(2616005)(106356001)(53936002)(8676002)(7416002)(316002)(110136005)(66066001)(2501003)(486006)(6116002)(3846002)(86362001)(81166006)(6436002)(8936002)(68736007)(81156014)(2201001)(6512007)(6306002)(50226002)(102836004)(2906002)(6486002)(26005)(478600001)(36756003)(966005)(97736004)(386003)(6506007)(52116002)(186003)(14454004)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D8DWC7z2VCMd0kU6lxwCNfKX6bmc8jeMgVmXCWrNC3bfYJkfg/n0Ck/Y/S+sHwA9pnYU106HM8wGiicDNQzrOff7/CwJoJ99qZg4trVs5ltz2SKd3PI8KlWKskEGmpyH6NfUVOfq7+TNLTTHpTw/98MXq+q7pBm8XO6T7akjGLhsaEyUhpWIN1S1Ig5RxKS80wFMTgDXuWYh6UU5O8NSpPIoQoUKSY/A0G9eRgO80QgujwYcD+60FpnIXlo2MiJsRg8GWB2I4FaEdJgHXpGwd4wbmVwRfnM2Gsg1eKMu8mUNpd3KBGBF9E0wz1Z/20gdDap6QmVXbpa1vZ6U/ZxxBlUxirg/6LQEao8KDVoHnR2yrE4UmfzwBap5w8zkJtGYfaq+CJ5BUkRAKZR2OIYEbrrGsZwLVgjGWVBJUrFHf6s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f380aa6f-73d3-4fec-21c4-08d6956dcfd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:53:26.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
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

This V2 patch series addresses all the comments from V1, and change log is =
inside
each patch of this V2 series.

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

