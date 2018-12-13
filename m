Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A763C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F6B2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mU6C0RXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F6B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeLMQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:17:08 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:42603
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727942AbeLMQRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmJAN4wtHXV/dUPVh8AOAa0trKBJo4xPO46NdtfRh1U=;
 b=mU6C0RXqRGLb+3fa0f7pjvVe/jhrODRCckJbMVoIiNNTk9ho1QyMTKhdWG1CmBt+z8rKD/Pl6TOUGFr8GGJbqL2LqA7LUQvXwO20eRx5/2f5jqnIpeOS8hd423rFvED6MKiAacNitcQ3ETWqKxxj3GES2e+sw+Wl26bgBaPXHLI=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 16:17:02 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 16:17:02 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Topic: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Index: AQHUkv9IB3KEsUBSeEGaC3/cu+N6Cw==
Date:   Thu, 13 Dec 2018 16:17:02 +0000
Message-ID: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::32) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:1C/wncVESe1HewFEHUPS52r9qXDpVmEbVIACds9u8bOLSMN1jaUXevM7QQIadYNC+4eI8FiISlMxkbNwvNPtCozbz07+4waAnpJRhWSoeAJZ64I9XNM4XFKVFugwo6AxC73Pn8z4MYHWoxYzUpIiMUUgcZ1jApvzJg2VfRL2NN/WzH2GO0BUV5zMdMdMMUnfaNg4NsxzocmjKV6gieEh8Fud0QyQ8E6O5KoepwCylufx0F8pmMKX+D6LqGxL/if4oZtqNuIWH4lHZguEB3gaaN61jyKvmEe4xMASPCGb1OQGAfgxCmKFSWrzw2Brimmsuxfe/24bNn0V/QypQeQZCnKggVAQuVlqqDEnsgDSJiVwwGU/1LKgpoaHj2/azVWQjEEjjepfB+oyRBZmy1tmw1+SZ1Bdcx+LLh9feqrxWhgnbQEC2YIGES5acCz943Ezy1Eo25f6VcFsNW7zKcDJhQ==;5:/CZ9KUayzXi5C077Y7lcjeV6nZ50lm0CSgbkYg8rD7NPo9lUT2zNMcKHIbzzuSYWqc2ZlmlJdaoHk0dps31sSu+dj9fZUt+njb7DJkFbe6zgGTqrTOkCWasbYcVrJxEhQleFMYQpBhuIGi5Qe1ce4DfQatSj3NzJTJbGgDHUcuQ=;7:NkCFlwIHyWvu1rq5YLySgonRY2iMfTVFg4o9LOytt6li0ktdKa+mGOvELhYpW1pF8GoGC6E33DSCArQipqLnJVGfw8zj0CPpsEFU5jmkN2+gAiN1QiCiaYvW/TaSG6bkfs8BohSQtyW4GkA+sUsBMg==
x-ms-office365-filtering-correlation-id: f9c98633-180f-48d6-754d-08d661166aa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB36597B536540A7F63B3E3E42F6A00@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(52116002)(102836004)(6486002)(6436002)(36756003)(186003)(6636002)(14444005)(256004)(6512007)(2616005)(486006)(99286004)(476003)(71190400001)(26005)(44832011)(71200400001)(66066001)(53936002)(8936002)(81166006)(86362001)(575784001)(81156014)(8676002)(4326008)(478600001)(7736002)(105586002)(97736004)(106356001)(14454004)(110136005)(54906003)(305945005)(2906002)(25786009)(386003)(6506007)(316002)(68736007)(5660300001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1rpAgoBNNPY5vVr2M7NKIQbmGHPNooi4kRN3EFRhujJu2EIvXyCUt6KpjyAhOX9qK8LLiAh4N3Z/ZK0EqgS3EaSvK5dVbR3PTgU6pZ5YN4m36ZsqPn3YN1g+oruRxZtd0pCz+7WkhEAo/D/cm8ZomFsgc5heEj4oh/+GBLOHHp0nLRJh59u8CLvO7FJYex3HOXLhQFzvutQr08zEK9XK3Uqx1FMWCyFh4e2xDeq2R09V4w8ocvUFxxZPHb6wfEssvldeYHsdtBX2Pix5YFA2HE7dg6PpwUL2cyiQ9hu1R6jJV0MMPHYkLsOgs3JIDEGb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c98633-180f-48d6-754d-08d661166aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 16:17:02.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dependency between the i.MX8MQ CCM clock driver
and the CONFIG_SOC_IMX8MQ and use CONFIG_CLK_IMX8MQ instead.
CONFIG_CLK_IMX8MQ depends on ARCH_MXC && ARM64.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/Kconfig      | 1 +
 drivers/clk/imx/Kconfig  | 5 +++++
 drivers/clk/imx/Makefile | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 2dc12bf..833353c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -293,6 +293,7 @@ config COMMON_CLK_BD718XX
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
+source "drivers/clk/imx/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
new file mode 100644
index 0000000..98ede6a
--- /dev/null
+++ b/drivers/clk/imx/Kconfig
@@ -0,0 +1,5 @@
+config CLK_IMX8MQ
+	bool "IMX8MQ CCM Clock Driver"
+	depends on ARCH_MXC && ARM64
+	help
+	    Build the driver for i.MX8MQ CCM Clock Driver
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 5c0b11e..01e5f55 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
-obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
+
+obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
--=20
2.7.4

