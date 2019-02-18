Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B01320675
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CWDaSyWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfBRGyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:54:14 -0500
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:48436
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfBRGyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8TF9WIo7x4SgieQnORJxV6b2SE4yII0H3vPD0PAKCw=;
 b=CWDaSyWlBJRoyde6UhvlzR3kGdiWjtm6L75HOBCv9tbfKFhnhOdzjL+CmcDefLus/WGB2Q2ZhnUTzE78YIW0iU1fClCPob3zQFTxNf+UjI46a81UOBs5SSp8Tmj3EKZyl9M3m/+nUB3lEOIJ054YZR9hHCE1JatMTN9gnhbdXRQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:53:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:53:58 +0000
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
Subject: [PATCH RESEND V2 2/4] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH RESEND V2 2/4] watchdog: imx_sc: Add i.MX system
 controller watchdog support
Thread-Index: AQHUx1a4PxtK/N3SxEaVy25sTLSrIg==
Date:   Mon, 18 Feb 2019 06:53:58 +0000
Message-ID: <1550472539-16590-3-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: ad245a8f-26b5-46af-ee43-08d6956ddb0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3738;23:k0UaM7zriSON2xGE0zcx+ds/4npHlZgeb3Eok?=
 =?iso-8859-1?Q?E1Dwo3rb5gKkhaXldxZk5sAV9VNzhR3naMKu9YnHTnIUnv8ThGvJiVBhbh?=
 =?iso-8859-1?Q?v/g9FzO0PzhRftUQSftA2ZGO9huP+HjkMkiQ9jBb5Z9pMnOflNezDBM54I?=
 =?iso-8859-1?Q?azxOSs5zOmTZccdSv5tEqeOaZBbusDYUEXDbQ+YFPz4uONtRW7objQSG0i?=
 =?iso-8859-1?Q?xj8KIywuA1EvXYLRi659n6PuITA9jO8yqyu3x22rHYwoaE5Ddd9kYAmkbV?=
 =?iso-8859-1?Q?1+aopJBnQLA0Ku82CKvcSqruX5Yo4lEwOQ+Z7w57zMxzVSUHkfuia0tYYu?=
 =?iso-8859-1?Q?folJ0IRULHl80f/nDZy35N2lbho1JnWQZ08PB9d8fVzjaJjcASYFuYC1ZT?=
 =?iso-8859-1?Q?8wdjnbXq4Lmn0t5U4dwQZY6gZKvw8ugrVYdL5URgatyPwHESeYHXV6UD1z?=
 =?iso-8859-1?Q?Fi+QYh8ETnND/wCc7FnjFEV/WmvrjRph8MRwchN1javGAH692bavX1KEM4?=
 =?iso-8859-1?Q?UUjwgkhJ+qqY8oQbBuo707DpxhvFysSeGPeDgtAN6ILXhNaHn5SD0j3bbt?=
 =?iso-8859-1?Q?AE/GKcD/GhWzubrd111wDSOJiexqmPhTqPfajBrZmdlY4ahIrnE5nIUo3T?=
 =?iso-8859-1?Q?yq3QtjulIuakklUHFhaMQf4o2eD1ohzr+FuoXdhet9pmuG+QjT/LEkpfzA?=
 =?iso-8859-1?Q?+uUgrNqZ9wx7nmaWbORL0oT6WWkxw4OTK8Qt9vK1+I4K9p1aliDV8JVFWp?=
 =?iso-8859-1?Q?o1utC0OQf89nHMzboMP7jt9iKsT/SGSQjVR/KF872aaj11j0zvjvwbemEi?=
 =?iso-8859-1?Q?PRxUOaAyg/U83QAryvBppRUcRrzwi/IJVuYYTgLyyV23D/ahXl+VqpMhZh?=
 =?iso-8859-1?Q?22tNVT40gpTb9ORlOhfhBCSOC1KWSndY5TGpleKc/4/HXi3ILWV7cdjpSu?=
 =?iso-8859-1?Q?wm2sfC+bgPis2hBC0ZT0kUMoXt7zGkB136yPenvU7SO3wcLm7YgDPO/oWd?=
 =?iso-8859-1?Q?JZnMDRzGROH4W4ds6gsHONH52+iE4eEhNbCjnhr5MMYlJoBBqlbXIGLKDM?=
 =?iso-8859-1?Q?JPuhU9BPIx4DXixnlrRNWBq0oL1IuaT4alYHsgiiRdBN+ByMdCfN0N7t3e?=
 =?iso-8859-1?Q?d5j8Ogb39q8n4VIRR0DlN03XtuaKAJOilCdY1Jq1oiBlDnK7cKFfFEsdDj?=
 =?iso-8859-1?Q?llcNYzNrqIrcBYaKXQNBLYY0iMw2NIW1wEemsrl9dz9rOjE+VlTB5NIa1Z?=
 =?iso-8859-1?Q?lyT3TzhqDWnS5mdWcz/0bsbizNePu+fnKODyILy8TBDczkgbP+i2Lhz+W0?=
 =?iso-8859-1?Q?eYCnGzTYkf+PRG0PYMW8rU6apHB9XdmAuVKMmgdNY6bWK3w=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37383D907BFF67118E904230F5630@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(97736004)(86362001)(5660300002)(71200400001)(71190400001)(36756003)(106356001)(66066001)(50226002)(4326008)(105586002)(76176011)(53936002)(99286004)(476003)(110136005)(81166006)(81156014)(6506007)(8936002)(25786009)(6486002)(386003)(14444005)(6512007)(2616005)(256004)(6436002)(316002)(486006)(102836004)(6116002)(446003)(3846002)(11346002)(7416002)(2906002)(7736002)(478600001)(14454004)(68736007)(2501003)(26005)(2201001)(217873002)(52116002)(186003)(305945005)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zqdF1pIhUdBTMyeZ/+RjmRBU6iVP1c7oDumtJa7Xb/hNWYTjvAb2tP2uRD3CsaZlMCvs0sDaPILPRaLwCFPb3G1aotxVnUYuN52O7UTHR8c70O6t12FD49XkayURp+rfPKz9znY+kzVFoVG9BgI8QS4PoSyG4taFJriTXWBs2xIE1xMUmc/h33bQ/6Gp9IUotYECP6v4wbd45XqWkcQANlieIiZk5AgL6SVTHzgFbgSkGslo6JZITn1Nf6yn0VyUzQ2s93A0wflG1A1fNNHiUmMHcQ+TLK8/2fPCXRmFnvKwFqc8Y4i9Q458cmYxUo1OsPRMBQ9ntOhiXbjV4fmuSP/OsSnweLFgqtBt9Luyn9Zx6tZAZiBPbxq/l6T9st1m9e8vbYY3uoXccUMaNrnR4H7ls6CjcqbC26xYaYAmJQg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad245a8f-26b5-46af-ee43-08d6956ddb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:53:49.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and watchdog etc..

This patch adds i.MX system controller watchdog driver support,
watchdog operation needs to be done in secure EL3 mode via
ARM-Trusted-Firmware, using SMC call, CPU will trap into
ARM-Trusted-Firmware and then it will request system controller
to do watchdog operation via IPC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
        - use watchdog_active() instead of comparing watchdog status direct=
ly;
        - use devm_kzalloc instead of using static variable;
        - remove unnecessary wdog set driver data in .probe;
        - use watchdog_stop_on_unregister() instead of .remove callback;
        - use watchdog_stop_on_reboot() instead of .shutdown callback;
        - use SIMPLE_DEV_PM_OPS() to simply the PM code.
---
 drivers/watchdog/Kconfig      |  13 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 185 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 65c3c42..5c5b8ba 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -625,6 +625,19 @@ config IMX2_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx2_wdt.
=20
+config IMX_SC_WDT
+	tristate "IMX SC Watchdog"
+	depends on ARCH_MXC || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This is the driver for the system controller watchdog
+	  on the NXP i.MX SoCs with system controller inside.
+	  If you have one of these processors and wish to have
+	  watchdog support enabled, say Y, otherwise say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx_sc_wdt.
+
 config UX500_WATCHDOG
 	tristate "ST-Ericsson Ux500 watchdog"
 	depends on MFD_DB8500_PRCMU
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 4e78a8c..0c9da63 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
 obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) +=3D ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) +=3D imx2_wdt.o
+obj-$(CONFIG_IMX_SC_WDT) +=3D imx_sc_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) +=3D ux500_wdt.o
 obj-$(CONFIG_RETU_WATCHDOG) +=3D retu_wdt.o
 obj-$(CONFIG_BCM2835_WDT) +=3D bcm2835_wdt.o
diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
new file mode 100644
index 0000000..a234a0c
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#define DEFAULT_TIMEOUT 60
+/*
+ * Software timer tick implemented in scfw side, support 10ms to 0xfffffff=
f ms
+ * in theory, but for normal case, 1s~128s is enough, you can change this =
max
+ * value in case it's not enough.
+ */
+#define MAX_TIMEOUT 128
+
+#define IMX_SIP_TIMER			0xC2000002
+#define IMX_SIP_TIMER_START_WDOG		0x01
+#define IMX_SIP_TIMER_STOP_WDOG		0x02
+#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
+#define IMX_SIP_TIMER_PING_WDOG		0x04
+#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
+#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
+#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
+
+#define SC_TIMER_WDOG_ACTION_PARTITION	0
+
+static bool nowayout =3D WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0000);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (defau=
lt=3D"
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static unsigned int timeout =3D DEFAULT_TIMEOUT;
+module_param(timeout, uint, 0000);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=3D"
+		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
+
+static int imx_sc_wdt_ping(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int imx_sc_wdt_start(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return res.a0;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
+		      SC_TIMER_WDOG_ACTION_PARTITION,
+		      0, 0, 0, 0, 0, &res);
+	return res.a0;
+}
+
+static int imx_sc_wdt_stop(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
+				unsigned int timeout)
+{
+	struct arm_smccc_res res;
+
+	wdog->timeout =3D timeout;
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
+		      timeout * 1000, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static const struct watchdog_ops imx_sc_wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D imx_sc_wdt_start,
+	.stop  =3D imx_sc_wdt_stop,
+	.ping  =3D imx_sc_wdt_ping,
+	.set_timeout =3D imx_sc_wdt_set_timeout,
+};
+
+static const struct watchdog_info imx_sc_wdt_info =3D {
+	.identity	=3D "i.MX SC watchdog timer",
+	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT,
+};
+
+static int imx_sc_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *imx_sc_wdd;
+	int ret;
+
+	imx_sc_wdd =3D devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
+	if (!imx_sc_wdd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, imx_sc_wdd);
+
+	imx_sc_wdd->info =3D &imx_sc_wdt_info;
+	imx_sc_wdd->ops =3D &imx_sc_wdt_ops;
+	imx_sc_wdd->min_timeout =3D 1;
+	imx_sc_wdd->max_timeout =3D MAX_TIMEOUT;
+	imx_sc_wdd->parent =3D &pdev->dev;
+
+	ret =3D watchdog_init_timeout(imx_sc_wdd, DEFAULT_TIMEOUT, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to init the wdog timeout:%d\n",
+			ret);
+		return ret;
+	}
+
+	watchdog_stop_on_reboot(imx_sc_wdd);
+	watchdog_stop_on_unregister(imx_sc_wdd);
+
+	ret =3D devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register watchdog device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx_sc_wdt_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx8qxp-sc-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
+
+static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(imx_sc_wdd))
+		imx_sc_wdt_stop(imx_sc_wdd);
+
+	return 0;
+}
+
+static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(imx_sc_wdd))
+		imx_sc_wdt_start(imx_sc_wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
+			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
+
+static struct platform_driver imx_sc_wdt_driver =3D {
+	.probe		=3D imx_sc_wdt_probe,
+	.driver		=3D {
+		.name	=3D "imx-sc-wdt",
+		.of_match_table =3D imx_sc_wdt_dt_ids,
+		.pm	=3D &imx_sc_wdt_pm_ops,
+	},
+};
+
+module_platform_driver(imx_sc_wdt_driver);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

