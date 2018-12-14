Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A8C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7660A20643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UjlCrx+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbeLNOUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:20:38 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:13377
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729684AbeLNOUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gaQWIMpEiCoarHeeEfnIFeQgBJka3/9lnAXxdRZkgc=;
 b=UjlCrx+hbxgJQsgYJ6MBtGwf9kIgVjkurkbNLTL3jZcCLrIbQBXUbaXK3zVKEuiN3FIiwDJLf/sfJ7i26G5VCSTWySocKMSpmB2Xix/AHBkQiu0xx70CbHWQQMR5+tlQdUF5OdXouUHgcjlB3QJ7mdTpuN0hQirbTZW+XiD9JXw=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 14:20:34 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 14:20:34 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
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
Subject: [PATCH v2] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Topic: [PATCH v2] clk: imx: Make the i.MX8MQ CCM clock driver
 CLK_IMX8MQ dependant
Thread-Index: AQHUk7gtj2BLOwHD5kqejAfjSVm07Q==
Date:   Fri, 14 Dec 2018 14:20:34 +0000
Message-ID: <1544797224-26627-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:203:91::22) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3787;6:bxRryIA/F1pD/nh2cXgxZ3LJELpeBmK+GwqVtiBuoGYR8DWW5oJnD0us5GZg1xcvJpef8BX01XTo4fYsYxQ2gYL5+GdLwQQm0PH54ZmITWTupJcll+dPCx1jLqyYjn+ASohwvjqKDw8Lr7qzFxQ06YghFkp+VIZMgCoLgkepmu7fVFGeZVj+lV4c1xTwgws8vuGGYqJjvRk4uV+oenO1eB2qDmCcWOKCmvLs6P9JqOcMV6R+nwScVxNlOWgs0/sA3SYhm3HfJPJMioSRTsL/sxOPq70EaMP3X73ExeazaKFmAH14zq+0kwkEqiKfi0nzNp3tdoGsXRlo7XG53ZU/pdyRxWpDs4P2RPT2RVT7NtS0JHphydwD/tCYp0z1BHk0GFhpczqxbUSsuc0qcp7M6xZ85spC+HbOU7wGoyVfXg4RJ5wh6MC1Bjg3fPIo1HT45jQlM04g0go18C4C62SVEg==;5:BmjgBj+r73JVhB4jeqA0yqHwJfHQHdYaBlMhWxm8r33ZZJfki/NO7uE63/6UW/YhHDn5k9/bcxvbQJkMNzTxAtf3nyeFPltP76ophy1mSJWx6owtfQwJALNz6E4stWQLRzBtiVZknmmTXPC+Ss7hiHNoFzve5jIhDXht+joyXvs=;7:NYLcYwBcg73zpXW+r71vqyQo6KBBeG6yyGVCpfX//69UgBP31WITkVcl3/oNxs/4+WwAAeuPIAR5KfIjXLbseqj6APAdMQw7Zr/cwBtAgogWrSTlXECId6GcuZmx0u9AnWJJX09vIqhdKKnrtl44PA==
x-ms-office365-filtering-correlation-id: d8f458a5-59dc-4058-6ec5-08d661cf4f87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB3787DF53113C67200672A1BDF6A10@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3787;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3787;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(81166006)(478600001)(575784001)(14454004)(110136005)(106356001)(14444005)(6636002)(7736002)(105586002)(256004)(2906002)(6436002)(316002)(8676002)(81156014)(54906003)(99286004)(6116002)(305945005)(6512007)(6486002)(5660300001)(3846002)(36756003)(97736004)(66066001)(53936002)(2616005)(486006)(44832011)(71190400001)(71200400001)(386003)(6506007)(68736007)(8936002)(86362001)(4326008)(52116002)(102836004)(26005)(186003)(476003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pG7c5dMqLtx+WulC9mDv+FD8omI+FjV4jsCxhyYHRxqkytAQtU2SL1VZStWmHSrmAaJCTqYSq/IIhbhAcOmAhQa2mADKMUcWAVJETet8y3Z/7GxnzePNP1/0DH5LZy+JL2oT5xzt5EAfWAEn6uTz1zlFwXE2dQiu3hq0x6jVh++QyObRwaD/Osfs8rG4qcogUFGwYQnDv660asJhI9M2+2wiSf3bH3P8Nflrcbj705eHo/R3N5WExf9A3gKN0Hc9nyLUuw70yH4wmPdIvGCFgBYmVdmL32NHJyXsSPLEGTPM+6hfqj9Mx4N0n6TnIpwE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f458a5-59dc-4058-6ec5-08d661cf4f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 14:20:34.3957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dependency between the i.MX8MQ CCM clock driver
and the CONFIG_SOC_IMX8MQ and use CONFIG_CLK_IMX8MQ instead.
CONFIG_CLK_IMX8MQ depends on ARCH_MXC && ARM64.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * reordered the CONFIGs in clk/imx/Makefile as suggested
by Daniel and Shawn

 drivers/clk/Kconfig      | 1 +
 drivers/clk/imx/Kconfig  | 5 +++++
 drivers/clk/imx/Makefile | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)
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
index 5c0b11e..7e55a4b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -20,6 +20,8 @@ obj-y +=3D \
 	clk-pllv4.o \
 	clk-sccg-pll.o
=20
+obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
+
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o
 obj-$(CONFIG_SOC_IMX25)  +=3D clk-imx25.o
@@ -34,5 +36,5 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
-obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
+
--=20
2.7.4

