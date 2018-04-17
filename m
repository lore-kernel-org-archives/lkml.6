Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeDQOVB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:21:01 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:62520
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752261AbeDQOUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:20:47 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Robin Gong <b38343@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/2] power: pf1550_charger: add pf1550 charger driver
Date: Tue, 17 Apr 2018 17:20:19 +0300
Message-Id: <1523974819-8711-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523974819-8711-1-git-send-email-abel.vesa@nxp.com>
References: <1523974819-8711-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:4:8f::21) To HE1PR04MB1611.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1611;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;3:7Awxsf98Q5WXU1biVX10ZkLJTzuZ1ekDJbTj22uHD6w/sEbYPE8JvFOCp0Ro6Cnw6OeSOLqhksl5SJtkhGXFTxiiyigB38cXx7Dx778J5+4VRUkGh6Rgc97gMg2sOQ/Yr1T17XS+HIsq0HlCtsVR5jllVhsGTDhjdS0GycXnNosYAObh6/KAGENVXb6f75mZuhRy67etekLIFXkjIFWW6O1PjFPWOyp+xT9NohPhDhHFLEbICg2fKGlO/YXXVA70;25:OHwE/t3NyoJGrVf4K7l2DhgFXC1jca+/Speu1LO4XQR8OFbA6ljhzF6Ou9Fu+IWFS5ZHcvAO9Nf8lgMGtD6361mAQgs/jGXJELSisa/W/q7uY/YoIRW5kYoh1GFJFXg0i7Ky3li9c0l8b5ivL7BcILvGQ6wz6LmOPllz/XcN5TmR2eBsBPCVY7DlbsegSwJbb9kU0RHsVKB4eEVBP5TjFCoG48/2/KotEN6LBj+5Km1z3+g4pT75m6j/CznHnzDAZh8McDjS+zmb7a/LXbv+ehBVwmDp0G4JMZ8+2a5v4FZpR40kMs42GjhjObpALm8Q9/L64k+ILkmUZfxxmitWpA==;31:ppM1bUFufyY0sb2KMYTF7uGLtZXlGVjnQL1rTLLXGbML3pwVZnVtVr4Iay8TDjAgxY067thq0Ykw+aoUhQOOrrBL5Jknm0VXRitI1faWyqH2/VNlFLT33Auh2gH2+HAUzrXYow+cZ1VdnUtJfYJEHvzWyS3dVuxsk5aQdHItQwAmSOAwKa3qaQ/CNZurXuKMFEAW1GuA6FnDQfSO8GUBoxms4opYmK4f3nyZp2uVurk=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1611:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;20:zvAiialpVAYp3WKtFQm5SCfrfMtycQQLg7s1tmNCfay/qFBcVJfxPQGjHh+Oc7sAdexRxxE+u4o5IJbPi1YoPmeChIcq6aL9u4HdYJOYhlOHH6VTfW21M+Rkzz+zGkfbMWWxI1eIxtnoKZdQRRF0OmLE2rwBDoTHaqbvoEZasZXwAlVUnctpyYhzHLwg7dhX88jZOC8pLQmF8vtKfQdcOwDaGk1bw13Cp+zBa6CAUwUZGtPaKzmjoK4c3S3PFCOpm8RoANgRzRi3VWtdYIoBjTv4qvxoXJNx/cv1hLUzMovuZSI6gxOHOQgLIRs9Mf6uxOAP5pOYErtCDjl43ZD8VxRoEyMOuGEchLT9ifovvDrxbEv6Fo1Cqf3d7gmM6h9dRp7v//PVIiq08DAofJIaiLCJc1nw9zpNlWJW4kNdB4pmjyD5SiGe/vsKPU+lh6BoRiNMuEUTtNt8ntwZIpsf8WZgCG1JNX3rwLL/qDtIWmg/7H2MpScXTUy0HhaEN4iY;4:M8RQ5IwmHrUS/3O3tsZiSsgevDfPmiuldeBAnWE6Ez6Isoji+KAcJu7QcsWcaGNyu+1+KFFA+P13Gs8qAklnvbpMF0epipcdqAfumZPdkNoBDuZeqSYKNfrN6u71XSVPgwOt9oBYIVjCM4Qx7bLDzGY+DhelQE4ldXrURh34IVLBQs0+10/rXL29AdOdG5X73JR1rxLzl+K6+xRK/dZv/ZkF8vEHR1K3tu1qJDRP12e4Q+MIgiVqTwUR8UqSCl7uTnQIFQNSxK3BOhQWGTlBJMmommoMpMX30VB64TKHVV1KUwXDS7rW2ZTWvK6Zu6CWdJEJtbP3QHvCXCWgsp6e+G96XWfKZJQ+UmAasK2h8sY=
X-Microsoft-Antispam-PRVS: <HE1PR04MB1611BBA675308430D985E831F6B70@HE1PR04MB1611.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1611;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1611;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(396003)(376002)(346002)(199004)(189003)(386003)(6506007)(54906003)(110136005)(956004)(11346002)(59450400001)(476003)(478600001)(44832011)(446003)(2616005)(25786009)(53936002)(6636002)(6666003)(36756003)(316002)(3846002)(6512007)(16586007)(6116002)(97736004)(4326008)(305945005)(76176011)(486006)(5660300001)(575784001)(81166006)(8936002)(51416003)(86362001)(68736007)(81156014)(8676002)(2906002)(5890100001)(66066001)(106356001)(47776003)(50226002)(48376002)(52116002)(6486002)(26005)(186003)(50466002)(16526019)(7736002)(105586002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1611;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1611;23:fbo/xyKLrxVZjmLCOK59EwfrXyFDguciwCT0nb0W9?=
 =?us-ascii?Q?6olJaHWlxtFBU0P2F/ad76wbI1hmqgLvpnIKFm5BYEGDM5XvYun4aS1DuiZN?=
 =?us-ascii?Q?Ci/RW+d2+xgXDIrA9KK16bFwNadNM+JXlCOt6Qvckj8j+9FzTzZNbh0pTYxm?=
 =?us-ascii?Q?AgN30YTqHiLlOO5pA1KVCVszqrwSO02O07WmF8Q0/3kbs6xWVjeo9P7PSOAK?=
 =?us-ascii?Q?t1O2LMviTD8FUhXmAmiHqOcUg5+/qIykjce0XTGuKFcZYsHQ/RRU2YM7BDcx?=
 =?us-ascii?Q?nL35rAT6wk//EKykZRlOlKN930lKnsZJUL/DY5voXfnVijVj2FsmOo2S6hSi?=
 =?us-ascii?Q?/nAcIHn6BstXw+jNdLB2FBbAUfno/vUK+FJTJSImHCo5+MDH5xRBtA/5TblL?=
 =?us-ascii?Q?h2/Lox2IAq2CLvpMeEMm4T0xxZQFkKgykGOABoQgNpqIOPFq80R+5IsIGCQ3?=
 =?us-ascii?Q?/eMm+9lGdHYsRJZ5tTOtypjyjhPFRAEDLaTzPL7KVUOOrGw9MOHGJPwoH7uu?=
 =?us-ascii?Q?L3FXWomGMAVY9t2rHxWKj8DoEYT1cU2QPCmu0ufyRVj2tTHCltGCsliC1e2b?=
 =?us-ascii?Q?ilbHs/bFVNyCeXBlUBWFKTc0PMvRTrCdKoBc4Rwe8ZPU884gkg2+Qg7SNOLc?=
 =?us-ascii?Q?7ncd2l6cZjJjBN53sCG513GM2GrJqVDI/Kq26/fa/w/YJRAG5WekLuF4hwkT?=
 =?us-ascii?Q?FTSS0v7E0N7RcJVrSb6BMylg489mv6QXDFdogB/GADu4C77M81ksfjQ/38RB?=
 =?us-ascii?Q?3MPi+LJJQ+M9L3aSeL2f1GSYK031Kb/tOcbLYJ0n/N0q19PykHYAitV5qJgj?=
 =?us-ascii?Q?8I+U1SmrG9vESLWmPWjuwtjsgvuIDpQ97SaB7gog1IWITwJmOvDj0wfLsR75?=
 =?us-ascii?Q?NoEPKiXXqJTwIC3l37WBe9ItlUJNhGK0y6WftwtZycYlSulOtaJf/mg2kjO5?=
 =?us-ascii?Q?xF2OZueqZ4veISp7EgcJgOT39XlPTBg+/gwsN1vsvTszNgxBR5G20ZmkP1pd?=
 =?us-ascii?Q?AW/fClPHoS7FBZ0PaB6MauRz259Gm6TXTCZbZyV+DVeTwxX3OvGaODuFmQPV?=
 =?us-ascii?Q?SoNwWYVQ6Fd4xXx3gdEBbcD8Ci61QKxTQouYhC6ibII0RBA+3qkhM1+upp38?=
 =?us-ascii?Q?d7tGy6Flwglf701sFcJRQ1Rt9I8f3xOA/zPQI7jK+nklr2SiCl64R8h/nuFC?=
 =?us-ascii?Q?JviJ/tupzZvStmxNSJE7WOLfqpLkfpjkZJ5iWTRYrhAw47D0FzLTyHFWT/K6?=
 =?us-ascii?Q?4xORn3UPcYwOBbI7XcJg1iByIXGWHmYwivDYA51teGfSCk8bbVK/ez0a1AfS?=
 =?us-ascii?Q?J2jJT35zEVe/ZP2JuBquC9b4JygamD9/ymJSSlj3nsz?=
X-Microsoft-Antispam-Message-Info: NS7r5qViEyXnInIcKj5iCvk1IFe0WSYGR2AANuVJxDgtPXyACMMeEGEUoMCglCJ54tT6ha1lZcYUYJOCKJt1zHTeOe4528UkkUSTA47mGC8oc78AQk+LobKMhHlcrli1BkK0VLlDgSkjcLfY8PEDBplqo7nCOIWJaYNqstwOr5dPhCrRX69JW6ymq0vDMWsj
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;6:YMrOVpkTQ9y28PWw8ZUYbZHW/Pi7HUAiGZjsO+iNSaL0wD1LI9h3QwepPeJwyPO6hBMHPG2ownbMQHPppFev1rShyfYyEv55dnXr9RDLdZWJ5d+D6Kr6sfTGICo9PqA9t1lz9+mznmLO02S2dohKNiCfSEtfXFB2V8YF2uJGVhmbYH29Pk7s2cfqkBhJw/OU7+pZcpPhiHhJNh5V0uHHMp9KSS2+J8A77wOgZCb73/AkSZtFYXOlHIpzO9rPfCgYEHQRtHZEhjF1YR910CUzWkzx2PjfdtjotNeFequm0CA2/C3HOzqzA0/G7bizYaDn/v69I4/aTyZo7b/3TnuysnmovoqTgwvsWxSXkKHgWVuom+zg3uUTi41UqLR5QpFPNjAqRZpiJMDI9rwYImWcT19BucIo/LuIV0EvkacXFTyOUUmbtV6fPtYLAiMCBI8TaHTdYUSQygqp5zJFjjShuQ==;5:sHzX/GuedqEtJg5u3I8cEC5jNK1TcSoGuR6ywPrdKPMb711Garnk29/ceAXYKUbTag/gQsqzQLV6xkEctK0c4ivjc2JVVO0TqHYwy2j6G2XomoXVXv/Xe1bxWcJ5VCT8iUXJSHawBgzu8pndPONMyjJphmjn3h+WIo2zdrr0f6I=;24:kWfdSLatpGA3rKZquVQICtE7Bu3UjnBJfZ01cYX0fv655Z+XZL7beyPHho7r18XszOibSE/GH0RL9wsABytTNZX3vzlpjxfqFYLA8aTGT7A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;7:l6bHRnHVuXlOsS3YB+8UKB4/fuMUs/KIff8aVVLok8cKqalMgOR9bfqw+kRfNzkvKJ+Tx6w9mXnN56Jq//waHTTIRJ+CULnkSJxlH0sG4MW4SyR7PqLKaxPasTWIzfBPtz7wqUgW7CXm65jwJAKo6cEDmm5l+ZA5MVP3heDld7R051c9sM7FkUyUWUpDdCX+F87hpO9qgQVguT9OCsRBxlyWXSxEQgFLciFjDvQxjUzGg0qdxMK7Omzjrf2UQJlb
X-MS-Office365-Filtering-Correlation-Id: baf41a23-e557-4384-9798-08d5a46e6788
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:20:42.1124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf41a23-e557-4384-9798-08d5a46e6788
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <b38343@freescale.com>

Add basic pf1550 charger driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/power/supply/Kconfig          |   6 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/pf1550_charger.c | 660 ++++++++++++++++++++++++++++++++++
 3 files changed, 667 insertions(+)
 create mode 100644 drivers/power/supply/pf1550_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 428b426..2ebd38c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -380,6 +380,12 @@ config CHARGER_PCF50633
 	help
 	 Say Y to include support for NXP PCF50633 Main Battery Charger.
 
+config CHARGER_PF1550
+	tristate "Freescale PF1550 battery charger driver"
+	depends on MFD_PF1550
+	help
+	 Say Y to enable support for the Freescale PF1550 battery charger.
+
 config BATTERY_JZ4740
 	tristate "Ingenic JZ4740 battery"
 	depends on MACH_JZ4740
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index e83aa84..0b2e424 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
+obj-$(CONFIG_CHARGER_PF1550)	+= pf1550_charger.o
 obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
diff --git a/drivers/power/supply/pf1550_charger.c b/drivers/power/supply/pf1550_charger.c
new file mode 100644
index 0000000..c5e0c55
--- /dev/null
+++ b/drivers/power/supply/pf1550_charger.c
@@ -0,0 +1,660 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pf1550_charger.c - regulator driver for the PF1550
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
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/mfd/pf1550.h>
+
+#define PF1550_CHARGER_NAME		"pf1550-charger"
+#define PF1550_DEFAULT_CONSTANT_VOLT	4200000
+#define PF1550_DEFAULT_MIN_SYSTEM_VOLT	3500000
+#define PF1550_DEFAULT_THERMAL_TEMP	75
+
+static const char *pf1550_charger_model		= "PF1550";
+static const char *pf1550_charger_manufacturer	= "Freescale";
+
+struct pf1550_charger {
+	struct device *dev;
+	struct pf1550_dev *pf1550;
+	struct power_supply *charger;
+	struct power_supply_desc psy_desc;
+	int irq;
+	struct delayed_work irq_work;
+	struct mutex mutex;
+
+	u32 constant_volt;
+	u32 min_system_volt;
+	u32 thermal_regulation_temp;
+};
+
+static struct pf1550_irq_info pf1550_charger_irqs[] = {
+	{ PF1550_CHARG_IRQ_BAT2SOCI,		"BAT2SOC" },
+	{ PF1550_CHARG_IRQ_BATI,		"BAT" },
+	{ PF1550_CHARG_IRQ_CHGI,		"CHG" },
+	{ PF1550_CHARG_IRQ_VBUSI,		"VBUS" },
+	{ PF1550_CHARG_IRQ_THMI,		"THM" },
+};
+
+static int pf1550_get_charger_state(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_CHG_SNS_MASK;
+
+	switch (data) {
+	case PF1550_CHG_PRECHARGE:
+	case PF1550_CHG_CONSTANT_CURRENT:
+	case PF1550_CHG_CONSTANT_VOL:
+	case PF1550_CHG_EOC:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case PF1550_CHG_DONE:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case PF1550_CHG_TIMER_FAULT:
+	case PF1550_CHG_SUSPEND:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case PF1550_CHG_OFF_INV:
+	case PF1550_CHG_OFF_TEMP:
+	case PF1550_CHG_LINEAR_ONLY:
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int pf1550_get_charge_type(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_CHG_SNS_MASK;
+
+	switch (data) {
+	case PF1550_CHG_SNS_MASK:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case PF1550_CHG_CONSTANT_CURRENT:
+	case PF1550_CHG_CONSTANT_VOL:
+	case PF1550_CHG_EOC:
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case PF1550_CHG_DONE:
+	case PF1550_CHG_TIMER_FAULT:
+	case PF1550_CHG_SUSPEND:
+	case PF1550_CHG_OFF_INV:
+	case PF1550_CHG_BAT_OVER:
+	case PF1550_CHG_OFF_TEMP:
+	case PF1550_CHG_LINEAR_ONLY:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	default:
+		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/*
+ * Supported health statuses:
+ *  - POWER_SUPPLY_HEALTH_DEAD
+ *  - POWER_SUPPLY_HEALTH_GOOD
+ *  - POWER_SUPPLY_HEALTH_OVERVOLTAGE
+ *  - POWER_SUPPLY_HEALTH_UNKNOWN
+ */
+static int pf1550_get_battery_health(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_BAT_SNS_MASK;
+
+	switch (data) {
+	case PF1550_BAT_NO_DETECT:
+		*val = POWER_SUPPLY_HEALTH_DEAD;
+		break;
+	case PF1550_BAT_NO_VBUS:
+	case PF1550_BAT_LOW_THAN_PRECHARG:
+	case PF1550_BAT_CHARG_FAIL:
+	case PF1550_BAT_HIGH_THAN_PRECHARG:
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case PF1550_BAT_OVER_VOL:
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		break;
+	default:
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int pf1550_get_present(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_BAT_SNS_MASK;
+	*val = (data == PF1550_BAT_NO_DETECT) ? 0 : 1;
+
+	return 0;
+}
+
+static int pf1550_get_online(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_VBUS_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	*val = (data & PF1550_VBUS_VALID) ? 1 : 0;
+
+	return 0;
+}
+
+static void pf1550_chg_bat_isr(struct pf1550_charger *chg)
+{
+	unsigned int data;
+
+	if (regmap_read(chg->pf1550->regmap,
+			PF1550_CHARG_REG_BATT_SNS, &data)) {
+		dev_err(chg->dev, "Read BATT_SNS error.\n");
+		return;
+	}
+
+	switch (data & PF1550_BAT_SNS_MASK) {
+	case PF1550_BAT_NO_VBUS:
+		dev_dbg(chg->dev, "No valid VBUS input.\n");
+		break;
+	case PF1550_BAT_LOW_THAN_PRECHARG:
+		dev_dbg(chg->dev, "VBAT < VPRECHG.LB.\n");
+		break;
+	case PF1550_BAT_CHARG_FAIL:
+		dev_dbg(chg->dev, "Battery charging failed.\n");
+		break;
+	case PF1550_BAT_HIGH_THAN_PRECHARG:
+		dev_dbg(chg->dev, "VBAT > VPRECHG.LB.\n");
+		break;
+	case PF1550_BAT_OVER_VOL:
+		dev_dbg(chg->dev, "VBAT > VBATOV.\n");
+		break;
+	case PF1550_BAT_NO_DETECT:
+		dev_dbg(chg->dev, "Battery not detected.\n");
+		break;
+	default:
+		dev_err(chg->dev, "Unknown value read:%x\n",
+			data & PF1550_CHG_SNS_MASK);
+	}
+}
+
+static void pf1550_chg_chg_isr(struct pf1550_charger *chg)
+{
+	unsigned int data;
+
+	if (regmap_read(chg->pf1550->regmap,
+			PF1550_CHARG_REG_CHG_SNS, &data)) {
+		dev_err(chg->dev, "Read CHG_SNS error.\n");
+		return;
+	}
+
+	switch (data & PF1550_CHG_SNS_MASK) {
+	case PF1550_CHG_PRECHARGE:
+		dev_dbg(chg->dev, "In pre-charger mode.\n");
+		break;
+	case PF1550_CHG_CONSTANT_CURRENT:
+		dev_dbg(chg->dev, "In fast-charge constant current mode.\n");
+		break;
+	case PF1550_CHG_CONSTANT_VOL:
+		dev_dbg(chg->dev, "In fast-charge constant voltage mode.\n");
+		break;
+	case PF1550_CHG_EOC:
+		dev_dbg(chg->dev, "In EOC mode.\n");
+		break;
+	case PF1550_CHG_DONE:
+		dev_dbg(chg->dev, "In DONE mode.\n");
+		break;
+	case PF1550_CHG_TIMER_FAULT:
+		dev_info(chg->dev, "In timer fault mode.\n");
+		break;
+	case PF1550_CHG_SUSPEND:
+		dev_info(chg->dev, "In thermistor suspend mode.\n");
+		break;
+	case PF1550_CHG_OFF_INV:
+		dev_info(chg->dev, "Input invalid, charger off.\n");
+		break;
+	case PF1550_CHG_BAT_OVER:
+		dev_info(chg->dev, "Battery over-voltage.\n");
+		break;
+	case PF1550_CHG_OFF_TEMP:
+		dev_info(chg->dev, "Temp high, charger off.\n");
+		break;
+	case PF1550_CHG_LINEAR_ONLY:
+		dev_dbg(chg->dev, "In Linear mode, not charging.\n");
+		break;
+	default:
+		dev_err(chg->dev, "Unknown value read:%x\n",
+			data & PF1550_CHG_SNS_MASK);
+	}
+}
+
+static void pf1550_chg_vbus_isr(struct pf1550_charger *chg)
+{
+	enum power_supply_type old_type;
+	unsigned int data;
+
+	if (regmap_read(chg->pf1550->regmap,
+			PF1550_CHARG_REG_VBUS_SNS, &data)) {
+		dev_err(chg->dev, "Read VBUS_SNS error.\n");
+		return;
+	}
+
+	old_type = chg->psy_desc.type;
+
+	if (data & PF1550_VBUS_UVLO) {
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+		dev_dbg(chg->dev, "VBUS deattached.\n");
+	}
+	if (data & PF1550_VBUS_IN2SYS)
+		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
+	if (data & PF1550_VBUS_OVLO)
+		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
+	if (data & PF1550_VBUS_VALID) {
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+		dev_dbg(chg->dev, "VBUS attached.\n");
+	}
+
+	if (old_type != chg->psy_desc.type)
+		power_supply_changed(chg->charger);
+}
+
+static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
+{
+	struct pf1550_charger *chg = data;
+
+	chg->irq = irq;
+	schedule_delayed_work(&chg->irq_work,  msecs_to_jiffies(10));
+
+	return IRQ_HANDLED;
+}
+
+static void pf1550_charger_irq_work(struct work_struct *work)
+{
+	struct pf1550_charger *chg = container_of(to_delayed_work(work),
+						  struct pf1550_charger,
+						  irq_work);
+	int i, irq_type = -1;
+	unsigned int status;
+
+	if (!chg->charger)
+		return;
+
+	mutex_lock(&chg->mutex);
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_charger_irqs); i++)
+		if (chg->irq == pf1550_charger_irqs[i].virq)
+			irq_type = pf1550_charger_irqs[i].irq;
+
+	switch (irq_type) {
+	case PF1550_CHARG_IRQ_BAT2SOCI:
+		dev_info(chg->dev, "BAT to SYS Overcurrent interrupt.\n");
+		break;
+	case PF1550_CHARG_IRQ_BATI:
+		pf1550_chg_bat_isr(chg);
+		break;
+	case PF1550_CHARG_IRQ_CHGI:
+		pf1550_chg_chg_isr(chg);
+		break;
+	case PF1550_CHARG_IRQ_VBUSI:
+		pf1550_chg_vbus_isr(chg);
+		break;
+	case PF1550_CHARG_IRQ_THMI:
+		dev_info(chg->dev, "Thermal interrupt.\n");
+		break;
+	default:
+		dev_err(chg->dev, "unknown interrupt occurred.\n");
+	}
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT, &status))
+		dev_err(chg->dev, "Read CHG_INT error.\n");
+	if (regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT, status))
+		dev_err(chg->dev, "clear CHG_INT error.\n");
+
+	mutex_unlock(&chg->mutex);
+}
+
+static enum power_supply_property pf1550_charger_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int pf1550_charger_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	struct pf1550_charger *chg = power_supply_get_drvdata(psy);
+	struct regmap *regmap = chg->pf1550->regmap;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = pf1550_get_charger_state(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = pf1550_get_charge_type(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = pf1550_get_battery_health(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = pf1550_get_present(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = pf1550_get_online(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = pf1550_charger_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = pf1550_charger_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int pf1550_set_constant_volt(struct pf1550_charger *chg,
+		unsigned int uvolt)
+{
+	unsigned int data;
+
+	if (uvolt >= 3500000 && uvolt <= 4440000)
+		data = 8 + (uvolt - 3500000) / 20000;
+	else {
+		dev_err(chg->dev, "Wrong value for constant voltage\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(chg->dev, "Charging constant voltage: %u (0x%x)\n", uvolt,
+			data);
+
+	return regmap_update_bits(chg->pf1550->regmap,
+			PF1550_CHARG_REG_BATT_REG,
+			PF1550_CHARG_REG_BATT_REG_CHGCV_MASK, data);
+}
+
+static int pf1550_set_min_system_volt(struct pf1550_charger *chg,
+		unsigned int uvolt)
+{
+	unsigned int data;
+
+	switch (uvolt) {
+	case 3500000:
+		data = 0x0;
+		break;
+	case 3700000:
+		data = 0x1;
+		break;
+	case 4300000:
+		data = 0x2;
+		break;
+	default:
+		dev_err(chg->dev, "Wrong value for minimum system voltage\n");
+		return -EINVAL;
+	}
+
+	data <<= PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT;
+
+	dev_dbg(chg->dev, "Minimum system regulation voltage: %u (0x%x)\n",
+			uvolt, data);
+
+	return regmap_update_bits(chg->pf1550->regmap,
+			PF1550_CHARG_REG_BATT_REG,
+			PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK, data);
+}
+
+static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
+		unsigned int cels)
+{
+	unsigned int data;
+
+	switch (cels) {
+	case 60:
+		data = 0x0;
+		break;
+	case 75:
+		data = 0x1;
+		break;
+	case 90:
+		data = 0x2;
+		break;
+	case 105:
+		data = 0x3;
+		break;
+	default:
+		dev_err(chg->dev, "Wrong value for thermal temperature\n");
+		return -EINVAL;
+	}
+
+	data <<= PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
+
+	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
+			cels, data);
+
+	return regmap_update_bits(chg->pf1550->regmap,
+			PF1550_CHARG_REG_THM_REG_CNFG,
+			PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK, data);
+}
+
+/*
+ * Sets charger registers to proper and safe default values.
+ */
+static int pf1550_reg_init(struct pf1550_charger *chg)
+{
+	int ret;
+	unsigned int data;
+
+	/* Unmask charger interrupt, mask DPMI and reserved bit */
+	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
+				0x51);
+	if (ret) {
+		dev_err(chg->dev, "Error unmask charger interrupt: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
+				&data);
+	if (ret) {
+		dev_err(chg->dev, "Read charg vbus_sns error: %d\n", ret);
+		return ret;
+	}
+
+	if (data & PF1550_VBUS_VALID)
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+
+	ret = pf1550_set_constant_volt(chg, chg->constant_volt);
+	if (ret)
+		return ret;
+
+	ret = pf1550_set_min_system_volt(chg, chg->min_system_volt);
+	if (ret)
+		return ret;
+
+	ret = pf1550_set_thermal_regulation_temp(chg,
+			chg->thermal_regulation_temp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pf1550_dt_init(struct device *dev, struct pf1550_charger *chg)
+{
+	struct device_node *np = dev->of_node;
+
+	if (!np) {
+		dev_err(dev, "no charger OF node\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(np, "fsl,constant-microvolt",
+			&chg->constant_volt))
+		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
+
+	if (of_property_read_u32(np, "fsl,min-system-microvolt",
+			&chg->min_system_volt))
+		chg->min_system_volt = PF1550_DEFAULT_MIN_SYSTEM_VOLT;
+
+	if (of_property_read_u32(np, "fsl,thermal-regulation",
+			&chg->thermal_regulation_temp))
+		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
+
+	return 0;
+}
+
+static int pf1550_charger_probe(struct platform_device *pdev)
+{
+	struct pf1550_charger *chg;
+	struct power_supply_config psy_cfg = {};
+	struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
+	int i, ret;
+
+	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return -ENOMEM;
+
+	chg->dev = &pdev->dev;
+	chg->pf1550 = pf1550;
+
+	platform_set_drvdata(pdev, chg);
+
+	ret = pf1550_dt_init(&pdev->dev, chg);
+	if (ret)
+		return ret;
+
+	mutex_init(&chg->mutex);
+
+	INIT_DELAYED_WORK(&chg->irq_work, pf1550_charger_irq_work);
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_charger_irqs); i++) {
+		struct pf1550_irq_info *charger_irq =
+						&pf1550_charger_irqs[i];
+		unsigned int virq = 0;
+
+		virq = regmap_irq_get_virq(pf1550->irq_data_charger,
+					charger_irq->irq);
+		if (!virq)
+			return -EINVAL;
+
+		charger_irq->virq = virq;
+
+		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
+					pf1550_charger_irq_handler,
+					IRQF_NO_SUSPEND,
+					charger_irq->name, chg);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed: irq request (IRQ: %d, error :%d)\n",
+				charger_irq->irq, ret);
+			return ret;
+		}
+	}
+
+	psy_cfg.drv_data = chg;
+
+	chg->psy_desc.name = PF1550_CHARGER_NAME;
+	chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	chg->psy_desc.get_property = pf1550_charger_get_property;
+	chg->psy_desc.properties = pf1550_charger_props;
+	chg->psy_desc.num_properties = ARRAY_SIZE(pf1550_charger_props);
+
+	chg->charger = power_supply_register(&pdev->dev, &chg->psy_desc,
+						&psy_cfg);
+	if (IS_ERR(chg->charger)) {
+		dev_err(&pdev->dev, "failed: power supply register\n");
+		ret = PTR_ERR(chg->charger);
+		return ret;
+	}
+
+	ret = pf1550_reg_init(chg);
+
+	return ret;
+}
+
+static int pf1550_charger_remove(struct platform_device *pdev)
+{
+	struct pf1550_charger *chg = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&chg->irq_work);
+	power_supply_unregister(chg->charger);
+
+	return 0;
+}
+
+static const struct platform_device_id pf1550_charger_id[] = {
+	{ "pf1550-charger", 0, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
+
+static struct platform_driver pf1550_charger_driver = {
+	.driver = {
+		.name	= "pf1550-charger",
+	},
+	.probe		= pf1550_charger_probe,
+	.remove		= pf1550_charger_remove,
+	.id_table	= pf1550_charger_id,
+};
+module_platform_driver(pf1550_charger_driver);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_DESCRIPTION("PF1550 charger driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
