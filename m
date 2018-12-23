Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC4B21903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fDhcKk9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLWHDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 02:03:34 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:30784
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeLWHDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 02:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NAp17NNzhGayieLlIiR3z/p3asRkbUs4xjbeYbmkyY=;
 b=fDhcKk9T30MhKZU2xdkR0psdMs9/a7+/oM+a2vJRj5SmadF47DQ1Q5JEf9TGfCQp7NeELWLXd1T70XW5FGwm/RaMNw488z/8ennsxFu5jKRVdkd8FEPgIxs924dRTvlnO/GZxwFPrRM1G9NRlbXPB2T4269eTr6Id3NnyOXbQiQ=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3896.eurprd04.prod.outlook.com (52.133.29.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.25; Sun, 23 Dec 2018 07:03:30 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 07:03:30 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>, Jun Li <jun.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] phy: freescale: Break dependency on SOC_IMX8MQ for USB PHY
Thread-Topic: [PATCH] phy: freescale: Break dependency on SOC_IMX8MQ for USB
 PHY
Thread-Index: AQHUmo2cgx2cbWzjsEWmInIs0QcVSQ==
Date:   Sun, 23 Dec 2018 07:03:30 +0000
Message-ID: <1545548599-20534-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::29) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3896;6:OHWTqQMwvq56WDdI97fsVjWKTOgkOEFpXWDUr6t53sL7avGkKJE10noWXF0s7m3ovGKgNkadLtrhvRALdsZDn+xmWe6pMW6XceNwy9FZSQmjFzRfZa6pU6CV/VfuUuTys9v8U0VrZeYt9m0gG+HbyD1ny95Sh1NjgGe0vzr97J5M7udkNCAkwvH++oihezHnNSJCNn7UveDAVmkRIKH3ZpDzxrUtxsygxiR2m7YpYWgKBZPlCA7agdSQnjC/A4BZRcCxgiskgN+10nbjMoooVjitgP9MhqvFmI81w0KrH4nrneppXTToj6hrXmYACn1EzaulHiYWWKCmfKMP7D8LK42z5wT2tJMHt97FiR/VBgntFyQYxlR69LmM1Ix8dh5RFSw6AgZfWBH/iExhqKBSzHjZ6mQ0oKq6k6WvnHWXXuiKdth5m457g9tPhNQ4Cl5o3GKwTUGSXNLiNQGCiureWQ==;5:F+hMY+e2J927feMitIhk1g1J5K35tKkMIrJkSZwOr+aWhWXu9ZXJrUltV2B/tpnPWdOSrEIyfZPxAUSL1n6NfzexoTn+Tl1T8hMG0oZRWVcLrwLLn8eETTHRtUU2sWChkv21pHLBL/V5Dl6rIZj6S5GlsVt5GcyRurjaiDvILno=;7:gvkyerRRTcDtnhjtgHINqLfEqd0Ue24R4cLUWxv7eRlDTb3sYX6UIJHHFnCfWBskENMvHpGAAf9fjlSA8RVJQsLCPiVJhbxgOSxqDL6XKhqb6C4UlHC309/jaPPLqQlbPW7NEWgUqvDr3ofgUjGlDg==
x-ms-office365-filtering-correlation-id: ee230295-781e-46cc-75d0-08d668a4be7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3896;
x-ms-traffictypediagnostic: AM6PR0402MB3896:
x-microsoft-antispam-prvs: <AM6PR0402MB38960B20384B1AD7A9768E26F6BA0@AM6PR0402MB3896.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3896;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3896;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(3846002)(66066001)(6116002)(4326008)(486006)(102836004)(36756003)(106356001)(105586002)(44832011)(386003)(6506007)(25786009)(6512007)(5660300001)(86362001)(186003)(99286004)(54906003)(316002)(110136005)(26005)(256004)(53936002)(6436002)(14444005)(8936002)(97736004)(2906002)(68736007)(8676002)(478600001)(71190400001)(81156014)(476003)(2616005)(14454004)(52116002)(7736002)(81166006)(305945005)(71200400001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3896;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RO2OO1TL4FgUA/lJaAuLgr7JbSqD1eRQ4XK5UK1D4qQg9E2wUWUiBoPrgEP2eUBh2ATwGCigy7b9kvOW2uWWDHyGAnMUHPwWwZv5F2rEOwWrXYoznb43XjbuAHbiDuB6UV6vSHU8/bOB4h9655KRZWB32iQ/9g5rR05g5Glu9EoLtCOs8PXNxOR5LnqkcSGGmecNgbNkogU3X7LYT3Kd0eg7NewDcVNrDw975GfTNCrZ3EAfob3OsRMTARAlztXw0bDOO91pnMx0mkJWL0cSAAvMV6g1RkJGauN4aiGr425+cweP93YTEjJKSFGwSojC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee230295-781e-46cc-75d0-08d668a4be7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 07:03:30.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is going to be used on more SoCs than just i.MX8MQ,
make the dependency here more generic.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/phy/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index f050bd4..832670b 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -2,4 +2,4 @@ config PHY_FSL_IMX8MQ_USB
 	tristate "Freescale i.MX8M USB3 PHY"
 	depends on OF && HAS_IOMEM
 	select GENERIC_PHY
-	default SOC_IMX8MQ
+	default ARCH_MXC && ARM64
--=20
2.7.4

