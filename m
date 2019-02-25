Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE449C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46FD2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iSt9d5fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfBYCTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:19:25 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:10548
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728436AbfBYCTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtCKCEy+l5+96LtxS7wdhzYBjEa1U9FG/WQ/dDsFi54=;
 b=iSt9d5fk02aIXP1oc9AiD6Ss5ModgiEkU2b9umQYHfM5UovE7IjdG97vGutF6EgWEPsU12AChopFLgRjIexqVkQyJCNCzvhBrr4LbmVBLL3ILgmGyhsW/QFf5P70/bszYOusxDcEgxv81yEDpW1PfuhXG6nqwC1Uel0VmgH9sF8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:19:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:19:19 +0000
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
Subject: [PATCH V3 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V3 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHUzLCDjbhEkgrG90e68kFB31wfeA==
Date:   Mon, 25 Feb 2019 02:19:19 +0000
Message-ID: <1551060850-22553-4-git-send-email-Anson.Huang@nxp.com>
References: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2578f509-0b0e-4056-a9c3-08d69ac7a5e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3674;23:Dd0pNWipzNNNlZkJHgXXmeU+CsoCZv4tLIfjm?=
 =?iso-8859-1?Q?SVHXSTCfsDdsNuUwXf55C6KjC6xNhv+TeVYS+HWJxBFUrvux2TFUdS4kZi?=
 =?iso-8859-1?Q?es7FsM+6kU1WF8HP4lq8UH7Fr9sO3chvXKyQLB4GzfD/vtVuo6OTcbq5or?=
 =?iso-8859-1?Q?r2E+bifJOsnYs/t75IwWLM9ivTjDorGQtn5yZ5Pm19TIoXTJ+QUQ10g6yl?=
 =?iso-8859-1?Q?Tv699eJB7jzkW42jaDsyG3JFvjNoKH2nsYSyMZpmC1nuyFgDuESUhhs2R8?=
 =?iso-8859-1?Q?cFdVI6+YrLgZ7YkaJQaUAamF7Bi7sN+rmuUyy5WCmS5vgLkGbcOVi2/QfB?=
 =?iso-8859-1?Q?iIFrnV47AScpGRXhKGqIhsXxVEHhyANjWZScMjs+u9LwPnCjghrDdM5hRw?=
 =?iso-8859-1?Q?HrnhEXAYVfKM59wcsHZK+BSkHAnsYHOahr/orlvVXCxk3oOoo8WQQPR92v?=
 =?iso-8859-1?Q?WlFRPR1+3JDg3lwBbO9b5H5wmb28qdifCH5v83HQWLMfRaFGR3VujY+Nol?=
 =?iso-8859-1?Q?TOxPCDLdlulsw6rR/nhQUWDLgdj3hoIrNSr8T1qK8p5DsXJ4MUPp2yglmG?=
 =?iso-8859-1?Q?n0IxqPQ15N5XqZjMM3gsGHusIN+mQUP5+LQXcEIBaSePw8ut82aN1kgiIR?=
 =?iso-8859-1?Q?42G0AOAp86ftGnqvm2xRvbZPwwrqfPv0P7AYWbUYAsKq8CAxMDoOMadSF7?=
 =?iso-8859-1?Q?TNMVW1L3/WT5Y3O34ReD0ZJO8tq4/4Mib6OlUtHgt9TSQesX0ovqQCGO8Q?=
 =?iso-8859-1?Q?bZD3NXRu7Z+ru1dVMDhVYYbd8988dN0+kdrYy6iZGCrypqrJNs3mXASsTX?=
 =?iso-8859-1?Q?/WppX71NHVUYpZntFR+9WmgQnIBXUEI35KoXpvWodw0lvP2zEs/yQQn2yB?=
 =?iso-8859-1?Q?mSVa7R7JkVppI8bqz+A3NNZA5C8Mu8iHFCw8nUKjJ1cSZHSMRBk8qIlCVP?=
 =?iso-8859-1?Q?uLJK1/pG2UyZ+PF76KQhufN01vtVE5Upx5qolcP3nU15dSqbdD1C9ag/a0?=
 =?iso-8859-1?Q?59dxKdPsfCY690+7Qu//2g0GtLxgTiFLLYKEJpJVIi7vjHrjZ4rXUR55Vx?=
 =?iso-8859-1?Q?EQebiT+pdifg8L7pXvAkAo/yMLbfWbrMpu4/qQ3QKuujm7mHWUbtKlfZEg?=
 =?iso-8859-1?Q?qy/ahkdH7vzsxFOYrSjixPV02ECfoy/SHNY03BJafsZX3/Cr5P2DXtWftN?=
 =?iso-8859-1?Q?MK2m2fKoUy+3dr+ZbUFzmur+5UE2ixTzFMmQC2V8bVGizufmxOOejudz4y?=
 =?iso-8859-1?Q?c+Hk7DZSisF1nr349avvP6a1p//CGc6JRj5uzA83z/kDNfY7eCmS0IgBKU?=
 =?iso-8859-1?Q?hWgU1OSor/x08EQivki/2lqod?=
x-microsoft-antispam-prvs: <DB3PR0402MB3674BB8F51D384E5E8F94CE8F57A0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(66066001)(305945005)(2201001)(52116002)(486006)(7736002)(316002)(110136005)(256004)(476003)(50226002)(106356001)(2616005)(53936002)(76176011)(446003)(86362001)(105586002)(99286004)(11346002)(97736004)(7416002)(81156014)(3846002)(6116002)(478600001)(68736007)(6436002)(8936002)(186003)(2906002)(4326008)(25786009)(102836004)(8676002)(4744005)(81166006)(36756003)(71200400001)(71190400001)(26005)(6486002)(5660300002)(6512007)(14454004)(6506007)(386003)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9aik7230D+S1RMuLFfaj3BAPIBwZy7gn/z7O/lSnFVBvwGGPITxrOtPtJqpxrH95/zweyrdOg94qXcawVtpShQf7GjauKDOKDTW12HH2U60UhnyuXwcQACHXQ6vKlnsZD/xksR4XKu5bP+J+sDNc6l4QMJlFSCvgxx6V9PWjQzTJ8sQ1oysmFvc19ayRw+vo33sx9goHQ9mEJy4wC3B54SIu0161ZGMD+wGI4dycIqBXfXRuAx0gaFPrKhuMH9Zr/C9PVG55C/SUXCriTcWaBzi/HsSsrw8aCib9YnCglmf6bVrVVcybz1/iQAzwlX+4ncNEBEDn/rtmXLGJGUQtJeI+4a/tmsse/AYfRee5t99qsEtZG8+CMu8fj/kT9WjhNDBVz86seWV/mvt1ETm7kB20MuoQrMLNdZra829tI+Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2578f509-0b0e-4056-a9c3-08d69ac7a5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:19:11.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V2.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 52d503e..c3d4607 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -428,6 +428,7 @@ CONFIG_WATCHDOG=3Dy
 CONFIG_ARM_SP805_WATCHDOG=3Dy
 CONFIG_S3C2410_WATCHDOG=3Dy
 CONFIG_IMX2_WDT=3Dy
+CONFIG_IMX_SC_WDT=3Dm
 CONFIG_MESON_GXBB_WATCHDOG=3Dm
 CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_RENESAS_WDT=3Dy
--=20
2.7.4

