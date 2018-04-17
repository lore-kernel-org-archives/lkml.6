Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeDQOUs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:20:48 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:62520
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752221AbeDQOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:20:45 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Robin Gong <b38343@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/2] mfd: pf1550: add pf1550 mfd driver
Date: Tue, 17 Apr 2018 17:20:18 +0300
Message-Id: <1523974819-8711-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:4:8f::21) To HE1PR04MB1611.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1611;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;3:TmJ76/7NLcHgoubLmysQ8cyyNE4rB9oJiEIqL+UWDmwBoMVwlJ9h+O0O80AV7/aCxp2TmjHIdhPHrNAvEnrMfQNS/bKVyskR1yV67V3+GnoExEK8z9ZUMrlOuwEwOKoWtHxN3WBwaqwLoFA4Tt9t4kvEjZroBLA4abMsUC0T9hVoZ0UvlKqrewx2W4u+lThT1AQ49zBZ04O4XmC7Qn+FUy2/YQJ2xUo1wcKnBNaZXvaEAoXlSrPd823pKJkLn/6h;25:6VX3CJFQ9q9aXpFKc/X1mmOuWAW+aO4LjFsOTJebURq4bhFfuWouzWswo9y9hbIQebfohuyHkGHOs8pF4XXLFELBR+RHUesPYRIlzAfCHNnXkf8V+RTspfOB1CBraKg54aeOjagpDMt/203eu/5wZV8lsPceG/CirE7nK/gBg9Yt1qHm2ROJQSsBoyVsyNEvou7khmYQHHzc5+vB8SXaokJs1XQLCvIo5cGvCSM5TeSPI0Du9corRzTBbY7sttMWRBhhRfpu3X17YBwxheEbIcCNjyUfeSZ/troYMmHQpZmUmchh82WHiWMMl1iDmILsyqZQ7PiG3uSl9+bHW5Hr2Q==;31:YAHTnvzQTxlYcBYYOpRxrjRsQo6CY+ODU2fFcgv5HYUcG8c1S/m+81oLYe1ZDoJp5FBkm1UjuvJ/0bgu3pGBCJZV2HCFrqVskCxhak3Vkbn+XzWTnhGG+TV2XrWlMKJmnpiLPboCf+7BHea3rH6IS3K2/Iz1h4xsTia8Jtv0Rja8Km7b6x8TtsvCtRH9PUGAz+Qkzx6H7hXWO4GQqn9iQ7nIs6NpBJ7BHXZAskMbwws=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1611:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;20:5ngWIeXVEwZc9KyBLBGZDLOyqiogNUlJgUtHZ49oqik/sZgunrhmc1QoYqdWcMENHC0bffRGCgs3wmST5TEVnVZvcxOPIzuskwPB/01zhRU9uS8tk0iRE7+gLlhDxp07QS4epHrcSwECebFtxP8pWcwp4RFwkx9HRaQvJXLTqt7AS+IEe5JgFusEfWPMLTXBJ05ZnhIyNIK5UsG6g+s75boLSo4GjKZmDxMcGIor2qdG7y89Ue++ElPOFp5xAJ4CfcH8b8Wzhmp8PWl8W78YNfJxNyahG0GhH5XbcV0Mw+6nh2DuWw3uw5lO8IrLpqC/d2SZyT7xk/EvHrOhA/3P1gf+llRczOMqEb8dwXY9ZC+1BeHKjuHwQ9hKOuirFoYus6dpkIlv4+RJZuchBoWnIbtgG0ceotQq4yLlYKuIiES128NOsfIG1TwVNP6y9cF99SMNmAZgGE5Ilo48GU7JOKQ04Fzrxb4T8vfrmR0qm/h383lftglQ7CItKy+np602;4:al+rovxdXRp7yjepVIPTuZCMaU0A+eKVcOrZBiarLOwrmzEsyyvj6L+ysf9Bw8NKuLQcS0SC+04Z6+eHiPUyTqvp3OcMs+vjEYjPedZyyZG2S/wGKwjznEccTLYH2YKq2ojzd3TZ+nSGQ/Zm0pB3+li7t0uMMELrTCzzgc2bl2A2Tv8X1hvt+u055s1sxsgu4KHwvXTFkz0euF9Lgcb0/8PRxWfveE61KE26kdWDMnLvlCeo6Y8cRRR3sQEa06yKVb8iZcby8RGtmZQwiNNIO9/WIbW6ieL8UYj1Jfxv066xXTG/XOs3owGCceXJ+JQnN9tmX+uhEmhaD0Iq6M0ZhFmKjKv0S1LSPH5IzPgq/PA=
X-Microsoft-Antispam-PRVS: <HE1PR04MB16116B188A8C1228A4E7450FF6B70@HE1PR04MB1611.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1611;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1611;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(396003)(376002)(346002)(199004)(189003)(386003)(6506007)(54906003)(110136005)(956004)(59450400001)(476003)(478600001)(44832011)(2616005)(25786009)(53936002)(6636002)(6666003)(36756003)(316002)(3846002)(6512007)(16586007)(6116002)(97736004)(4326008)(305945005)(486006)(5660300001)(575784001)(81166006)(8936002)(51416003)(86362001)(68736007)(81156014)(8676002)(2906002)(66066001)(106356001)(47776003)(50226002)(48376002)(52116002)(6486002)(26005)(186003)(50466002)(16526019)(7736002)(105586002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1611;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1611;23:cWeY7Xv0yJC9N5h1scOkt9qxVASHmdZ4Fj73haCWV?=
 =?us-ascii?Q?lgLSToRebYvZxPGDNkj1/LvL/gMeXqS7mLZAYBwf+a0rauEWCxlugDRflrjg?=
 =?us-ascii?Q?kPcNp3huzPxUkEZl9wHjItepfKkRioZzUfnGmG4k5uFgOT171CfF7PJDzU5G?=
 =?us-ascii?Q?gEPAJgP94gieFj+TU2lXm+9TYGg1EVs/gKxohMyx3rIFz6ukCL5AUx9PRNEK?=
 =?us-ascii?Q?XTQwrvSyENPq0Pqb2PoCGh1w7rGrFyGpRO07O6KLf6q3dwbDFIW8hmsFSnz7?=
 =?us-ascii?Q?Hhd8dSGPcs9BEdmekzzihR9NhRI9FKxFUe3gOhHYyMrHFsODy7cDUkZA+6sc?=
 =?us-ascii?Q?nGgc0FNgR2fj27aWoowAYSBFjrSa23hGMbWuNRV4FZvzY9iluwChq7z/2223?=
 =?us-ascii?Q?1egbOW9jlSM2mUUHMF5w20vCIbXBW4kZhSY5U4LgNaguFeabNyL7GQ8BgNZ0?=
 =?us-ascii?Q?gd+oXs6kzYC+BKFmu7gggpf6btWl+1psbxFjg5hCj3eFbvDeAUIUX29K22U6?=
 =?us-ascii?Q?I5VQ3hdTl3O8B9EohlaSrdn1x2e44ZwwuXnJEy1fCK+cRzpPX+1/rt8hFNMc?=
 =?us-ascii?Q?xOxGa+2rmWE5roHUDUPfC6L0CI4O6TktNLLRmJZaGHo/TTPAsi7WiGVrVqD9?=
 =?us-ascii?Q?dpTjjKzle4Cyo141uvD8+4LG30eEhj4pzvgpl2NgYMN3J5AWf66uCIrdCoWY?=
 =?us-ascii?Q?MLfair6yguR0j3udM21upiciQKtaryxtNySquKEMim+FlZiZMb0zB88eIRgR?=
 =?us-ascii?Q?fsC39dRAGI9kxv8ppAtL7lG6KJWaKN6M2c5jkBUILtNwNjIkwJnYxRkTet36?=
 =?us-ascii?Q?K4Ep1PBRQbpV6cGGkA4n5+1kPybuXsFRfdxCiUCFVCu9Dy31aCa5t6WGIHrR?=
 =?us-ascii?Q?x7M9Knk7tRUM4i/99aNXCPqYnkKJYTWk2Hh/moRg+Yr1kSKGdnLwMEXVGd0N?=
 =?us-ascii?Q?rjzszU40EgvyOJxORXrNikkHiyEBpNHXlvoz1m9y0uiR83o3C7/QqJtB448A?=
 =?us-ascii?Q?ZGv1SRT3XhShffD6ap/78qce0biA2igodJ9q2Ioni7YDhp22mnT3JbvR8Ao+?=
 =?us-ascii?Q?roiW3ePCF/p9IH8yqzld7VM//COEpN9cTSilK4k4PVE9WA/dTjuwCk6+e1V2?=
 =?us-ascii?Q?5g4xHev0Fmcxcll5TtwSy58COphTP/wS/G51mTgfh1vyArJ1vkKRbb7ojVp4?=
 =?us-ascii?Q?hWRQdGW68iZRtiXE6ME6bGf4Rpr76NywS6n3Dij29q/7p1CboErcvu+SG9dg?=
 =?us-ascii?Q?sH+boakrCHfVuzoOtk=3D?=
X-Microsoft-Antispam-Message-Info: SZgnLYX4KLMv7G8BAf7ouTyOC6dHBU1WzCmpCjK+ecqJnA1iPXiZo8rL0UCZwdHhLx0z0V6F9Bt6A+57c/sK2TzOKHaHZmK/JcwttR9o6nRso56vnkMmnLCEoXLH54J1R05EswhFTAlBdVjch1e9sEfH/pDdyN/xYviWFwGY1XVsaaJDv9ZHCP7NlaJCMFIY
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;6:5d1FkzNC7+dFKBbHTmEMcZgfUMCQUyb5ld9IfXzJZe69huqJHA8ZmJiU6F4BwG5rbjacYy00iZIglPybIys22X71evKTBE+rS9EGS10CobsCzcuTGI6HtbGWottojQY6EVcpFmpRyytgs/HzFI1QDusFu7UG5gA6bdUIV5IjIleGiMEyM+aEO1ut3ksBVafsAYHah45selmluhwEGyaEeyOAIa7/afNip6RtFZNDBdXeXspp2oDfXT3igNg/GJieQJ1yahjuyddv0W0FVox63Q/aL1o5HV4Uuv76U9FUQqA/uK4HlbiliQ1Gi5FVYIirqb/7VVgPZYRNgcPvjyVLbXiqbo7k0ElzmydlrxTxiyjPj4ByGLuJo5iDKszH8zBEMYSt/KCnciOCZgnMudnK9smtt6ewTh9aPwuq8JAVVXLqjX5ea481ZD87IYVrg4fGqnQoSKDvp7bX+K1ohaL8gA==;5:2Qar5aZksSw/QkfI5S8UDiMp2+Jvf+lica785Lp6TleENS9gPb9hvwt0I4/kOn3Otk+rqdFQdKZkNDKrLHFsZNZyQu7pLdqwiQAwvecMx2BKf8CadDlgnF1c1MCXW/G93gvMWzx1es85J5mULid1MU+MNtPpeJqSG6v00FL0LFw=;24:b6Br09Q/YBRYb09mn8Z3MzCgz552d41f+uPAhjAh2Hes1qYHf5XqBNsJJkg2nsj4EdCRX9PhNZmslsY6JGGclyjX5jJVvWdUw8i4sOo+sXI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;7:MVo0ur4I9QolcgXrI8Ra6CEGzXbRVhrNOykECxHJ/HaXlXhG4o6W0tXZr9SJ+haZauijKx4b2akvsN35wL536wXYVHGGJgXvct+2tawQ5qVDhwlrgy6Dsl/5VEveHF9EsOtvyT01wV+OWRyh9MpwI6s4JLivaJkouWbzdH9gWLBhyND+UlzCcp2BeQgmoUpvBM8jOjCJVkGQLdGSwqJQyyzGkR+L0GS2O1jvLm7bcFYql5NrGnKpdFxtSjlWLK1o
X-MS-Office365-Filtering-Correlation-Id: f22747ba-84b3-48b0-a3ef-08d5a46e6652
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:20:40.1280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22747ba-84b3-48b0-a3ef-08d5a46e6652
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <b38343@freescale.com>

Add basic pf1550 mfd driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/mfd/Kconfig        |  14 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/pf1550.c       | 282 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/pf1550.h | 241 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 539 insertions(+)
 create mode 100644 drivers/mfd/pf1550.c
 create mode 100644 include/linux/mfd/pf1550.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5..5acd239 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -404,6 +404,20 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_PF1550
+	tristate "Freescale Semiconductor PF1550 PMIC Support"
+	depends on I2C=y
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for Freescale Semiconductor PF1550.
+	  This is a companion Power Management IC with regulators, ONKEY,
+	  and charger control on chip.
+	  This driver provides common support for accessing the device;
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20d..b8ac19b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -97,6 +97,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
new file mode 100644
index 0000000..70817ef
--- /dev/null
+++ b/drivers/mfd/pf1550.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pf1550.c - mfd core driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This driver is based on max77693.c
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell pf1550_devs[] = {
+	{
+		.name = "pf1550-regulator",
+		.of_compatible = "fsl,pf1550-regulator",
+	},
+	{
+		.name = "pf1550-onkey",
+		.of_compatible = "fsl,pf1550-onkey",
+	},
+	{
+		.name = "pf1550-charger",
+		.of_compatible = "fsl,pf1550-charger",
+	},
+};
+
+static const struct regmap_config pf1550_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PF1550_PMIC_REG_END,
+};
+
+static const struct regmap_irq pf1550_regulator_irqs[] = {
+	{ .reg_offset = 0, .mask = PMIC_IRQ_SW1_LS,		},
+	{ .reg_offset = 0, .mask = PMIC_IRQ_SW2_LS,		},
+	{ .reg_offset = 0, .mask = PMIC_IRQ_SW3_LS,		},
+
+	{ .reg_offset = 3, .mask = PMIC_IRQ_SW1_HS,		},
+	{ .reg_offset = 3, .mask = PMIC_IRQ_SW2_HS,		},
+	{ .reg_offset = 3, .mask = PMIC_IRQ_SW3_HS,		},
+
+	{ .reg_offset = 16, .mask = PMIC_IRQ_LDO1_FAULT,	},
+	{ .reg_offset = 16, .mask = PMIC_IRQ_LDO2_FAULT,	},
+	{ .reg_offset = 16, .mask = PMIC_IRQ_LDO3_FAULT,	},
+
+	{ .reg_offset = 22, .mask = PMIC_IRQ_TEMP_110,	},
+	{ .reg_offset = 22, .mask = PMIC_IRQ_TEMP_125,	},
+};
+
+static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
+	.name			= "pf1550-regulator",
+	.status_base		= PF1550_PMIC_REG_SW_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_SW_INT_MASK0,
+	.mask_invert		= false,
+	.num_regs		= 4,
+	.irqs			= pf1550_regulator_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_regulator_irqs),
+};
+
+static const struct regmap_irq pf1550_onkey_irqs[] = {
+	{ .reg_offset = 0, .mask = ONKEY_IRQ_PUSHI,		},
+	{ .reg_offset = 0, .mask = ONKEY_IRQ_1SI,		},
+	{ .reg_offset = 0, .mask = ONKEY_IRQ_2SI,		},
+	{ .reg_offset = 0, .mask = ONKEY_IRQ_3SI,		},
+	{ .reg_offset = 0, .mask = ONKEY_IRQ_4SI,		},
+	{ .reg_offset = 0, .mask = ONKEY_IRQ_8SI,		},
+};
+
+static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
+	.name			= "pf1550-onkey",
+	.status_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_ONKEY_INT_MASK0,
+	.mask_invert		= false,
+	.num_regs		= 1,
+	.irqs			= pf1550_onkey_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_onkey_irqs),
+};
+
+static const struct regmap_irq pf1550_charger_irqs[] = {
+	{ .reg_offset = 0, .mask = CHARG_IRQ_BAT2SOCI,		},
+	{ .reg_offset = 0, .mask = CHARG_IRQ_BATI,		},
+	{ .reg_offset = 0, .mask = CHARG_IRQ_CHGI,		},
+	{ .reg_offset = 0, .mask = CHARG_IRQ_VBUSI,		},
+	{ .reg_offset = 0, .mask = CHARG_IRQ_DPMI,		},
+	{ .reg_offset = 0, .mask = CHARG_IRQ_THMI,		},
+};
+
+static const struct regmap_irq_chip pf1550_charger_irq_chip = {
+	.name			= "pf1550-charger",
+	.status_base		= PF1550_CHARG_REG_CHG_INT,
+	.mask_base		= PF1550_CHARG_REG_CHG_INT_MASK,
+	.mask_invert		= false,
+	.num_regs		= 1,
+	.irqs			= pf1550_charger_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_charger_irqs),
+};
+
+static int pf1550_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct pf1550_dev *pf1550;
+	unsigned int reg_data = 0;
+	int ret = 0;
+
+	pf1550 = devm_kzalloc(&i2c->dev,
+			sizeof(struct pf1550_dev), GFP_KERNEL);
+	if (!pf1550)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, pf1550);
+	pf1550->dev = &i2c->dev;
+	pf1550->i2c = i2c;
+	pf1550->irq = i2c->irq;
+
+	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
+	if (IS_ERR(pf1550->regmap)) {
+		ret = PTR_ERR(pf1550->regmap);
+		dev_err(pf1550->dev, "failed to allocate register map: %d\n",
+				ret);
+		return ret;
+	}
+
+	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
+	if (ret < 0 || reg_data != 0x7c) {
+		dev_err(pf1550->dev, "device not found!\n");
+		return ret;
+	}
+
+	pf1550->type = PF1550;
+	dev_info(pf1550->dev, "pf1550 found.\n");
+
+	ret = regmap_add_irq_chip(pf1550->regmap, pf1550->irq,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_FALLING, 0,
+				&pf1550_regulator_irq_chip,
+				&pf1550->irq_data_regulator);
+	if (ret) {
+		dev_err(pf1550->dev, "failed to add irq1 chip: %d\n", ret);
+		goto err_regulator_irq;
+	}
+
+	ret = regmap_add_irq_chip(pf1550->regmap, pf1550->irq,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_FALLING, 0,
+				&pf1550_onkey_irq_chip,
+				&pf1550->irq_data_onkey);
+	if (ret) {
+		dev_err(pf1550->dev, "failed to add irq3 chip: %d\n", ret);
+		goto err_onkey_irq;
+	}
+
+	ret = regmap_add_irq_chip(pf1550->regmap, pf1550->irq,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_FALLING, 0,
+				&pf1550_charger_irq_chip,
+				&pf1550->irq_data_charger);
+	if (ret) {
+		dev_err(pf1550->dev, "failed to add irq4 chip: %d\n", ret);
+		goto err_charger_irq;
+	}
+
+	ret = mfd_add_devices(pf1550->dev, -1, pf1550_devs,
+			      ARRAY_SIZE(pf1550_devs), NULL, 0, NULL);
+	if (ret < 0)
+		goto err_mfd;
+
+	return ret;
+
+err_mfd:
+	mfd_remove_devices(pf1550->dev);
+err_charger_irq:
+	regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_charger);
+err_onkey_irq:
+	regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_regulator);
+err_regulator_irq:
+	return ret;
+}
+
+static int pf1550_i2c_remove(struct i2c_client *i2c)
+{
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	mfd_remove_devices(pf1550->dev);
+
+	regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_regulator);
+	regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_onkey);
+	regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_charger);
+
+	return 0;
+}
+
+static const struct i2c_device_id pf1550_i2c_id[] = {
+	{ "pf1550", PF1550 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
+
+static int pf1550_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(pf1550->irq);
+		disable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static int pf1550_resume(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(pf1550->irq);
+		enable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops pf1550_pm = {
+	.suspend = pf1550_suspend,
+	.resume = pf1550_resume,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id pf1550_dt_match[] = {
+	{ .compatible = "fsl,pf1550" },
+	{},
+};
+#endif
+
+static struct i2c_driver pf1550_i2c_driver = {
+	.driver = {
+		   .name = "pf1550",
+		   .owner = THIS_MODULE,
+		   .pm = &pf1550_pm,
+		   .of_match_table = of_match_ptr(pf1550_dt_match),
+	},
+	.probe = pf1550_i2c_probe,
+	.remove = pf1550_i2c_remove,
+	.id_table = pf1550_i2c_id,
+};
+
+static int __init pf1550_i2c_init(void)
+{
+	return i2c_add_driver(&pf1550_i2c_driver);
+}
+/* init early so consumer devices can complete system boot */
+subsys_initcall(pf1550_i2c_init);
+
+static void __exit pf1550_i2c_exit(void)
+{
+	i2c_del_driver(&pf1550_i2c_driver);
+}
+module_exit(pf1550_i2c_exit);
+
+MODULE_DESCRIPTION("Freescale PF1550 multi-function core driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
new file mode 100644
index 0000000..9721929
--- /dev/null
+++ b/include/linux/mfd/pf1550.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pf1550.h - mfd head file for PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_MFD_PF1550_H
+#define __LINUX_MFD_PF1550_H
+
+#include <linux/i2c.h>
+
+enum chips { PF1550 = 1, };
+
+enum pf1550_pmic_reg {
+	/* PMIC regulator part */
+	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
+	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
+	PF1550_PMIC_REG_SILICON_REV		= 0x02,
+
+	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,
+	PF1550_PMIC_REG_SW_INT_STAT0		= 0x08,
+	PF1550_PMIC_REG_SW_INT_MASK0		= 0x09,
+	PF1550_PMIC_REG_SW_INT_SENSE0		= 0x0A,
+	PF1550_PMIC_REG_SW_INT_STAT1		= 0x0B,
+	PF1550_PMIC_REG_SW_INT_MASK1		= 0x0C,
+	PF1550_PMIC_REG_SW_INT_SENSE1		= 0x0D,
+	PF1550_PMIC_REG_SW_INT_STAT2		= 0x0E,
+	PF1550_PMIC_REG_SW_INT_MASK2		= 0x0F,
+	PF1550_PMIC_REG_SW_INT_SENSE2		= 0x10,
+	PF1550_PMIC_REG_LDO_INT_STAT0		= 0x18,
+	PF1550_PMIC_REG_LDO_INT_MASK0		= 0x19,
+	PF1550_PMIC_REG_LDO_INT_SENSE0		= 0x1A,
+	PF1550_PMIC_REG_TEMP_INT_STAT0		= 0x20,
+	PF1550_PMIC_REG_TEMP_INT_MASK0		= 0x21,
+	PF1550_PMIC_REG_TEMP_INT_SENSE0		= 0x22,
+	PF1550_PMIC_REG_ONKEY_INT_STAT0		= 0x24,
+	PF1550_PMIC_REG_ONKEY_INT_MASK0		= 0x25,
+	PF1550_PMIC_REG_ONKEY_INT_SENSE0	= 0x26,
+	PF1550_PMIC_REG_MISC_INT_STAT0		= 0x28,
+	PF1550_PMIC_REG_MISC_INT_MASK0		= 0x29,
+	PF1550_PMIC_REG_MISC_INT_SENSE0		= 0x2A,
+
+	PF1550_PMIC_REG_COINCELL_CONTROL	= 0x30,
+
+	PF1550_PMIC_REG_SW1_VOLT		= 0x32,
+	PF1550_PMIC_REG_SW1_STBY_VOLT		= 0x33,
+	PF1550_PMIC_REG_SW1_SLP_VOLT		= 0x34,
+	PF1550_PMIC_REG_SW1_CTRL		= 0x35,
+	PF1550_PMIC_REG_SW1_CTRL1		= 0x36,
+	PF1550_PMIC_REG_SW2_VOLT		= 0x38,
+	PF1550_PMIC_REG_SW2_STBY_VOLT		= 0x39,
+	PF1550_PMIC_REG_SW2_SLP_VOLT		= 0x3A,
+	PF1550_PMIC_REG_SW2_CTRL		= 0x3B,
+	PF1550_PMIC_REG_SW2_CTRL1		= 0x3C,
+	PF1550_PMIC_REG_SW3_VOLT		= 0x3E,
+	PF1550_PMIC_REG_SW3_STBY_VOLT		= 0x3F,
+	PF1550_PMIC_REG_SW3_SLP_VOLT		= 0x40,
+	PF1550_PMIC_REG_SW3_CTRL		= 0x41,
+	PF1550_PMIC_REG_SW3_CTRL1		= 0x42,
+	PF1550_PMIC_REG_VSNVS_CTRL		= 0x48,
+	PF1550_PMIC_REG_VREFDDR_CTRL		= 0x4A,
+	PF1550_PMIC_REG_LDO1_VOLT		= 0x4C,
+	PF1550_PMIC_REG_LDO1_CTRL		= 0x4D,
+	PF1550_PMIC_REG_LDO2_VOLT		= 0x4F,
+	PF1550_PMIC_REG_LDO2_CTRL		= 0x50,
+	PF1550_PMIC_REG_LDO3_VOLT		= 0x52,
+	PF1550_PMIC_REG_LDO3_CTRL		= 0x53,
+	PF1550_PMIC_REG_PWRCTRL0		= 0x58,
+	PF1550_PMIC_REG_PWRCTRL1		= 0x59,
+	PF1550_PMIC_REG_PWRCTRL2		= 0x5A,
+	PF1550_PMIC_REG_PWRCTRL3		= 0x5B,
+	PF1550_PMIC_REG_SW1_PWRDN_SEQ		= 0x5F,
+	PF1550_PMIC_REG_SW2_PWRDN_SEQ		= 0x60,
+	PF1550_PMIC_REG_SW3_PWRDN_SEQ		= 0x61,
+	PF1550_PMIC_REG_LDO1_PWRDN_SEQ		= 0x62,
+	PF1550_PMIC_REG_LDO2_PWRDN_SEQ		= 0x63,
+	PF1550_PMIC_REG_LDO3_PWRDN_SEQ		= 0x64,
+	PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ	= 0x65,
+
+	PF1550_PMIC_REG_STATE_INFO		= 0x67,
+	PF1550_PMIC_REG_I2C_ADDR		= 0x68,
+	PF1550_PMIC_REG_IO_DRV0			= 0x69,
+	PF1550_PMIC_REG_IO_DRV1			= 0x6A,
+	PF1550_PMIC_REG_RC_16MHZ		= 0x6B,
+	PF1550_PMIC_REG_KEY			= 0x6F,
+
+	/* charger part */
+	PF1550_CHARG_REG_CHG_INT		= 0x80,
+	PF1550_CHARG_REG_CHG_INT_MASK		= 0x82,
+	PF1550_CHARG_REG_CHG_INT_OK		= 0x84,
+	PF1550_CHARG_REG_VBUS_SNS		= 0x86,
+	PF1550_CHARG_REG_CHG_SNS		= 0x87,
+	PF1550_CHARG_REG_BATT_SNS		= 0x88,
+	PF1550_CHARG_REG_CHG_OPER		= 0x89,
+	PF1550_CHARG_REG_CHG_TMR		= 0x8A,
+	PF1550_CHARG_REG_CHG_EOC_CNFG		= 0x8D,
+	PF1550_CHARG_REG_CHG_CURR_CNFG		= 0x8E,
+	PF1550_CHARG_REG_BATT_REG		= 0x8F,
+	PF1550_CHARG_REG_BATFET_CNFG		= 0x91,
+	PF1550_CHARG_REG_THM_REG_CNFG		= 0x92,
+	PF1550_CHARG_REG_VBUS_INLIM_CNFG	= 0x94,
+	PF1550_CHARG_REG_VBUS_LIN_DPM		= 0x95,
+	PF1550_CHARG_REG_USB_PHY_LDO_CNFG	= 0x96,
+	PF1550_CHARG_REG_DBNC_DELAY_TIME	= 0x98,
+	PF1550_CHARG_REG_CHG_INT_CNFG		= 0x99,
+	PF1550_CHARG_REG_THM_ADJ_SETTING	= 0x9A,
+	PF1550_CHARG_REG_VBUS2SYS_CNFG		= 0x9B,
+	PF1550_CHARG_REG_LED_PWM		= 0x9C,
+	PF1550_CHARG_REG_FAULT_BATFET_CNFG	= 0x9D,
+	PF1550_CHARG_REG_LED_CNFG		= 0x9E,
+	PF1550_CHARG_REG_CHGR_KEY2		= 0x9F,
+
+	PF1550_PMIC_REG_END			= 0xff,
+};
+
+#define PF1550_CHG_PRECHARGE		0
+#define PF1550_CHG_CONSTANT_CURRENT	1
+#define PF1550_CHG_CONSTANT_VOL		2
+#define PF1550_CHG_EOC			3
+#define PF1550_CHG_DONE			4
+#define PF1550_CHG_TIMER_FAULT		6
+#define PF1550_CHG_SUSPEND		7
+#define PF1550_CHG_OFF_INV		8
+#define PF1550_CHG_BAT_OVER		9
+#define PF1550_CHG_OFF_TEMP		10
+#define PF1550_CHG_LINEAR_ONLY		12
+#define PF1550_CHG_SNS_MASK		0xf
+
+#define PF1550_BAT_NO_VBUS		0
+#define PF1550_BAT_LOW_THAN_PRECHARG	1
+#define PF1550_BAT_CHARG_FAIL		2
+#define PF1550_BAT_HIGH_THAN_PRECHARG	4
+#define PF1550_BAT_OVER_VOL		5
+#define	PF1550_BAT_NO_DETECT		6
+#define PF1550_BAT_SNS_MASK		0x7
+
+#define PF1550_VBUS_UVLO		BIT(2)
+#define PF1550_VBUS_IN2SYS		BIT(3)
+#define PF1550_VBUS_OVLO		BIT(4)
+#define PF1550_VBUS_VALID		BIT(5)
+
+#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK		0x3f
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT		6
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK		0x3
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT	2
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK	0x3
+
+#define PMIC_IRQ_SW1_LS		BIT(0)
+#define PMIC_IRQ_SW2_LS		BIT(1)
+#define PMIC_IRQ_SW3_LS		BIT(2)
+#define PMIC_IRQ_SW1_HS		BIT(0)
+#define PMIC_IRQ_SW2_HS		BIT(1)
+#define PMIC_IRQ_SW3_HS		BIT(2)
+#define PMIC_IRQ_LDO1_FAULT	BIT(0)
+#define PMIC_IRQ_LDO2_FAULT	BIT(1)
+#define PMIC_IRQ_LDO3_FAULT	BIT(2)
+#define PMIC_IRQ_TEMP_110	BIT(0)
+#define PMIC_IRQ_TEMP_125	BIT(1)
+
+#define ONKEY_IRQ_PUSHI		BIT(0)
+#define ONKEY_IRQ_1SI		BIT(1)
+#define ONKEY_IRQ_2SI		BIT(2)
+#define ONKEY_IRQ_3SI		BIT(3)
+#define ONKEY_IRQ_4SI		BIT(4)
+#define ONKEY_IRQ_8SI		BIT(5)
+
+#define CHARG_IRQ_BAT2SOCI	BIT(1)
+#define CHARG_IRQ_BATI		BIT(2)
+#define CHARG_IRQ_CHGI		BIT(3)
+#define CHARG_IRQ_VBUSI		BIT(5)
+#define CHARG_IRQ_DPMI		BIT(6)
+#define CHARG_IRQ_THMI		BIT(7)
+
+enum pf1550_irq {
+	PF1550_PMIC_IRQ_SW1_LS,
+	PF1550_PMIC_IRQ_SW2_LS,
+	PF1550_PMIC_IRQ_SW3_LS,
+	PF1550_PMIC_IRQ_SW1_HS,
+	PF1550_PMIC_IRQ_SW2_HS,
+	PF1550_PMIC_IRQ_SW3_HS,
+	PF1550_PMIC_IRQ_LDO1_FAULT,
+	PF1550_PMIC_IRQ_LDO2_FAULT,
+	PF1550_PMIC_IRQ_LDO3_FAULT,
+	PF1550_PMIC_IRQ_TEMP_110,
+	PF1550_PMIC_IRQ_TEMP_125,
+
+	PF1550_ONKEY_IRQ_PUSHI,
+	PF1550_ONKEY_IRQ_1SI,
+	PF1550_ONKEY_IRQ_2SI,
+	PF1550_ONKEY_IRQ_3SI,
+	PF1550_ONKEY_IRQ_4SI,
+	PF1550_ONKEY_IRQ_8SI,
+
+	PF1550_CHARG_IRQ_BAT2SOCI,
+	PF1550_CHARG_IRQ_BATI,
+	PF1550_CHARG_IRQ_CHGI,
+	PF1550_CHARG_IRQ_VBUSI,
+	PF1550_CHARG_IRQ_DPMI,
+	PF1550_CHARG_IRQ_THMI,
+};
+
+enum pf1550_regulators {
+	PF1550_SW1,
+	PF1550_SW2,
+	PF1550_SW3,
+	PF1550_VREFDDR,
+	PF1550_LDO1,
+	PF1550_LDO2,
+	PF1550_LDO3,
+};
+
+struct pf1550_irq_info {
+	unsigned int irq;
+	const char *name;
+	unsigned int virq;
+};
+
+struct pf1550_dev {
+	struct device *dev;
+	struct i2c_client *i2c;
+	int type;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data_regulator;
+	struct regmap_irq_chip_data *irq_data_onkey;
+	struct regmap_irq_chip_data *irq_data_charger;
+	int irq;
+};
+
+#endif /* __LINUX_MFD_PF1550_H */
-- 
2.7.4
