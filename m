Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13BC10F08
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387ED218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dsN0XeMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfBRCCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:02:05 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:20032
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbfBRCCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukxtYxgu0ncm0+Yg+920p6h9GWAB2CzYxokwxhUM4Ww=;
 b=dsN0XeMZMTaQk2JoMz/lwxi2f+pp5pZFWTHHNmy5GpipAwnTGsPuUd6H1m259Ql2G3RrOKaA3xUGg48iWrKF/AvwYK/iQGDRO/XVSCpiJyQ1JY7MZNGdhl6WVIFMGTCMn1BMvXoo+GWgcwe5PYdDmFi65Hs2O4FOABeh+76c1S8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 18 Feb 2019 02:01:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 02:01:28 +0000
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
Subject: [PATCH V2 2/4] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH V2 2/4] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHUxy3cX8egQlcqDUuJ9MQo0yDxPg==
Date:   Mon, 18 Feb 2019 02:01:28 +0000
Message-ID: <1550454997-4398-3-git-send-email-Anson.Huang@nxp.com>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6646b8e1-b32d-412c-9311-08d69544feb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3900;23:Mwvpt9Hywrhoh8GLtZGvnRR+Xp5BCbSmoBYtL?=
 =?iso-8859-1?Q?oREt85LloRxA5EGzrHoLDv/OMhG7rHVT533AItO1I0RUmvPEmMRQ4wgf5q?=
 =?iso-8859-1?Q?nSXAV1WoQSrUdPFgrH5ywIVR+uAsLUtGDgvFtP2+upjpApLrqt1SeaeI/v?=
 =?iso-8859-1?Q?OKvGFF3yN4JLFRNu+e9SieZz5Yoy5BWNzKDjlHX9zBlru0ykLJAqZGhWal?=
 =?iso-8859-1?Q?Zo0LgikYCAiK52YK2E0YAZwYcmVim5m36rCoCWDI8BJMhBLkLIJnv7URXE?=
 =?iso-8859-1?Q?IBnaentqBp1xJnxcLPMGNrbf9jflHEysdKfqH8VfirpY7WuKYSk0WCVXAL?=
 =?iso-8859-1?Q?3iQ8X5ki5N1yYCTqyT+lrJs8g7x2dKx0ImKd4Ei2gzr+73o22YBNFphRur?=
 =?iso-8859-1?Q?M9HVvedl93nCUi7d+sE2lqHLf4SwekynQkiuZZ8eKIIThti5YOl6TIjzJZ?=
 =?iso-8859-1?Q?/eubw1Pazynd2cn6Yi6sB5ZJMMJi1P9Rvp2onvk+fShdAjBjwa++Kp8fms?=
 =?iso-8859-1?Q?7zXOPDEoVdLmWT1rUFWt71y2q7tEpV+se8gAK/J/EAIWBenqJUdA7QfHyv?=
 =?iso-8859-1?Q?Yj04e1CuEhOtsMtS2da/uXGGGPns82FfCsKTZn25d5Wh2qkqXj5Fs+bTRT?=
 =?iso-8859-1?Q?osJecR4W2/Bn5cBNXaHevEcRvo8N9Dq5S1ZwlOwBWIasCFshR9s9h/qnVa?=
 =?iso-8859-1?Q?Q3W0LkM5hs2j9cKVs+YokQlNftx6xAz7u/ZX7+NK4D7WedWFjsL5yvCAKu?=
 =?iso-8859-1?Q?LSGgH6OU4IGFHWXANMIefjZDy5mGdQosBCmF0cRtmMFRR2DRL6g1cR6tVc?=
 =?iso-8859-1?Q?vPniRbYa4Oa8d/GXXBXCXtK2XRhaGpzwxsL5b5Z7qkTJ775Ns/F1CQcbMO?=
 =?iso-8859-1?Q?E+yvbRgWVrHWUm3ZCA9oLkOv/8RjUJwzOGtgCXmKzESCNpZkfwwve2Fx1q?=
 =?iso-8859-1?Q?TPsdUmXkonbymsl2IPtsdpxuCLPKQNew0wzGy8ScVGp81Lb63qsx73Rjvq?=
 =?iso-8859-1?Q?k4Rdzr44gxJbcsYHvVB/uyMH9q2i0GFwCMkajXC+jzIDXfy7o/4M9Kv4zw?=
 =?iso-8859-1?Q?WvSHmDKLMWEDuN562sEylMj10CMivNHcG98O5QCrds3U14bQ00H+L0JAGo?=
 =?iso-8859-1?Q?IjHdm2CQz00logLZsG8pKAOWDh0+m4feiSV2ZlzYk3pDPzwp3qRfF/fvSp?=
 =?iso-8859-1?Q?MSDIwUWh/Hy6rL2U7ljQrpGmgGBCm0vsFy0/ShQthyCJOJyro8rrUnmq4L?=
 =?iso-8859-1?Q?Cn4M46kSKtmxufLJ54IxR0MVIDuPXpqRtzgMVvHICkKYUcNOgXyTQR9haV?=
 =?iso-8859-1?Q?sygSWjnMlgg+0/b4hoe+Ias1q?=
x-microsoft-antispam-prvs: <DB3PR0402MB3900D5DD07E5906778C61D16F5630@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(7416002)(66066001)(81166006)(81156014)(8676002)(446003)(6512007)(11346002)(25786009)(3846002)(2501003)(8936002)(476003)(6116002)(2616005)(50226002)(68736007)(14454004)(478600001)(2906002)(2201001)(105586002)(6486002)(106356001)(110136005)(71190400001)(186003)(52116002)(76176011)(5660300002)(6436002)(14444005)(36756003)(486006)(256004)(386003)(26005)(71200400001)(102836004)(99286004)(7736002)(53936002)(4326008)(305945005)(97736004)(86362001)(316002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B2L2xhf4yXiuOfIdQvBBDhaSceBppZwRr2W6O8ihcMUVqDvxBGZtRhb0IadnkNE6hpG1QKq5T1aeh88LHRCzuwwdxuQOAYY/8v6y4FxjT9mvPYjH0cSegMCqzf/l6b7x1LhWZ1FPoVu0wXwyO7Sud0VdxYpyXoGkx6g7fXIkAJjO5lcwRHUGfBFO9ghrzZAMUTDFs5aE3/x9r8Ls0YMeFJWgiX7ON1TEgaK4zMnxIj37MAIl6A0NEPRduDftVmRnhffd8xLJpc403kOC/34PpKMhUlyuaNozbiPqFDqMFX7nPDOO22TP12K8LO7ajDfhftl0h9VzazP+yCuGgfN/wj4kQTOne9Bz9KZQK6AL+bHyxz5t+3cq+EtLP272lk+ITohCIwLYtIz3ylV8j103t8YwODlD+AZ35SmYwMq8sS4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6646b8e1-b32d-412c-9311-08d69544feb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:01:20.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
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
 drivers/watchdog/Kconfig      |  13 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 187 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 201 insertions(+)
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
index 0000000..5af6cf2
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,187 @@
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
+#ifdef CONFIG_PM_SLEEP
+static int imx_sc_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(imx_sc_wdd))
+		imx_sc_wdt_stop(imx_sc_wdd);
+
+	return 0;
+}
+
+static int imx_sc_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(imx_sc_wdd))
+		imx_sc_wdt_start(imx_sc_wdd);
+
+	return 0;
+}
+#endif
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

