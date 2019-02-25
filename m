Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2931FC00319
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36BF21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5NmcGNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfBYCTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:19:22 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:10548
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfBYCTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XigVW4CSxHO1iC23nQW/SmrXIytuM/SX2Dl8+lFJB3g=;
 b=j5NmcGNEmEysTTsLORLmDOidihc2xspW+Dzx/gF5bBbywyOnXFTU8d+8SoQOUFKH+CrMKlOLE85qbzjMG+Gcx2SNdeKVlATCp97KFZ6rP2r7y6KiCUv4eTRX6vWbD/F65r2cBwbbnGvHvTb27Banm8x5BHwjKt7VhYwap/oz2Ww=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:19:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:19:10 +0000
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
Subject: [PATCH V3 2/4] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH V3 2/4] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHUzLB+XKm5X9ztkUqZJErtEDwU0Q==
Date:   Mon, 25 Feb 2019 02:19:10 +0000
Message-ID: <1551060850-22553-3-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: d2597c9f-cef4-4d31-ace5-08d69ac7a0d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3674;23:4r6e0J51Yai4ldtp2EED2GdC1H+N7qxbNN+/F?=
 =?iso-8859-1?Q?0kVvqj4/VtQTF7Tcf7q4C3fgntBB1zFEZGNNUuKYQABIbJYd6Cn/beB4kK?=
 =?iso-8859-1?Q?eZa8ZmcHzVVKPrtVx1aEr75jmBVQ3AhgRyfF1VMPkhyleZxbD2xoAVpDDo?=
 =?iso-8859-1?Q?EFIfxSkhytyuaCsW42/yoKXTbKTpgZGlZYJZu/ukypoar/yTt1mYrFmYIO?=
 =?iso-8859-1?Q?EvPwJd1iHi3Il8ZQX9RcNLh/0CypHligUwI/DNb+tluEnU1ZnKA07Fb0AU?=
 =?iso-8859-1?Q?d5eGXIDhq7ikqF79SLElSd+N54AtYDlr2P/RJ2iWzgQOJVlzcRGaB5drXA?=
 =?iso-8859-1?Q?e2qCOxfGtAUcxbou7glh0m5JzJi8GwERYogiR6in8bKilFL0zzq95PrlOn?=
 =?iso-8859-1?Q?CSKLdEBMSPkvv94AMpaB3g0MltLIQjdbEFngvKXQlcZ9Hnz2+7uWMZn93m?=
 =?iso-8859-1?Q?BDixuh5jUqN6mYxdlXC4bYUggE0IkdSQVZX4ql4ICU7pQbDCypMWGC4B3e?=
 =?iso-8859-1?Q?jeCQ+lYMAYYrV22jhMCsDz3kKeLZeq4Tk7Z7iqU1TtrQOfz84uNcBNv+SF?=
 =?iso-8859-1?Q?tu4vuaDBc3yoHnaUvntafTC7XCARyJhPBpvuxjx64rlMlro91rUnprReT9?=
 =?iso-8859-1?Q?BK49tys8XSbjgr8X1NyuQnMvqQaY4QLTdxfp19bmJQNRYLfj3KoHQMSopL?=
 =?iso-8859-1?Q?GtLe5LFE9u+J0GJc3QQSzdSRvetgAU3y6yn1wbLD2xJl0Uua7XWccK3Nas?=
 =?iso-8859-1?Q?OTMi0AD0qbLJzlxx30ho3J/5HaywD6rKeTBbL4Scgh7Ksj21Wc1HmqOSj3?=
 =?iso-8859-1?Q?0u2/ptbOVAeNkkMAvc0dozF9JTgwowYvKxxhClhfoPopXUCHbrH0EliKjK?=
 =?iso-8859-1?Q?HmT5jpJHu59iElWrQ6BlPYkakC6GJ4n+IY38zIfbl5MO+2j1yJVQdvWw5K?=
 =?iso-8859-1?Q?4Vz0Zbu9RHeuRjDCGO1Ds3lWPD3HhiUk4b8NDiHtk8XvxJzV3tD9tWnrwK?=
 =?iso-8859-1?Q?FN9ol9krfHzWYD2vWIYq0eCkezjatRNTGfqPNQwCVwVcKe3Lw/MAkgcP40?=
 =?iso-8859-1?Q?YF2oHa4inNQgk5ezNUT6AaPRqhTgx/nPSxVBGA+EeE5U6so4QYVo/lSiH2?=
 =?iso-8859-1?Q?Vj2rbDQEJWggAUOh2sva8PIQnDLFccag0cd7USYXWhOJZnBo04duZ7m0B5?=
 =?iso-8859-1?Q?7tn1jMUVTux7UOnPseOpLRMnZGIESnmQPcU979ZLmKRtfUvhm6lBRJ+WZS?=
 =?iso-8859-1?Q?jjh0n/6ay0Yqmp/UtoTCQz2DZJPoz2d31tdIXRiy1JqbVyJi4+w8Wrb0W4?=
 =?iso-8859-1?Q?HIkDkme/tPEN7GFNbtOVggal9?=
x-microsoft-antispam-prvs: <DB3PR0402MB367454BF97E75CE5258253D9F57A0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(66066001)(305945005)(2201001)(52116002)(486006)(14444005)(7736002)(316002)(110136005)(256004)(476003)(50226002)(106356001)(2616005)(53936002)(76176011)(446003)(86362001)(105586002)(99286004)(11346002)(97736004)(7416002)(81156014)(3846002)(6116002)(478600001)(68736007)(6436002)(8936002)(186003)(2906002)(4326008)(25786009)(102836004)(8676002)(81166006)(36756003)(71200400001)(71190400001)(26005)(6486002)(5660300002)(6512007)(14454004)(6506007)(386003)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TOMNOXYkTQdNXdzX/0PqsnO0p9y/SL8926j5qI5vbotmKVPa6dSwoNEI3qG2wEaU5swmz81vHzECJxajRb1TSbXdepBij2OQ0jeXK6VCoEmGQmWBYr/KQX+bMpRk9dEfaDPv68vV8KBu6u1bpIuX9uggZ0oQqhw8wRCHiFx4whY8XjH9KcV0A+KC0gNA2MZCHaIMduxzXTiDKGiEnK3EnLbZTfIS5EvyR7R7Yfq/xGI1NYkdo69UMnCZMtwrzeozRNhdEy+032tNqRMGRoKDG4QZR5e7w28ER5XjHjJ6grm56iMmKYTLwo6AEKIASP7KgZL/oI9QzO7t5qtQCMFsrvNOhW7Z05eY2+ErVD5p1HvTy0nEYbGIabJ6hQEwccXTzJ5HDIatoJ62pNIit7KADw9ER+RwAUEQ9KKblEs4lBY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2597c9f-cef4-4d31-ace5-08d69ac7a0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:19:02.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
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
Changes since V2:
	- improve watchdog_init_timeout() operation and error check, setting it
	  via module parameter "timeout", if it is invalid, roll back to use defau=
l
	  timeout value DEFAULT_TIMEOUT;
	- change compatible string to "fsl,imx-sc-wdt" to make driver more generic
	  for all i.MX platforms with system controller watchdog inside.
---
 drivers/watchdog/Kconfig      |  13 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 183 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 197 insertions(+)
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
index 0000000..7b22575
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,183 @@
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
+	imx_sc_wdd->timeout =3D DEFAULT_TIMEOUT;
+
+	ret =3D watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to set timeout value, using default\n");
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
+	{ .compatible =3D "fsl,imx-sc-wdt", },
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

