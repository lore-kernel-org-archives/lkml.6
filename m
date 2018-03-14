Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeCNKpq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:45:46 -0400
Received: from mail-co1nam03on0041.outbound.protection.outlook.com ([104.47.40.41]:24288
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750934AbeCNKpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:45:44 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <nagasureshkumarrelli@gmail.com>
To: <boris.brezillon@bootlin.com>, <rogerq@ti.com>, <lee.jones@linaro.org>,
        <alexandre.belloni@free-electrons.com>, <nicolas.ferre@microchip.com>,
        <ladis@linux-mips.org>, <ada@thorsis.com>
CC: <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353 static memory controller
Date: Wed, 14 Mar 2018 16:14:34 +0530
Message-ID: <1521024274-30467-1-git-send-email-nagasureshkumarrelli@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.747-7.0-31-1
X-imss-scan-details: No--4.747-7.0-31-1;No--4.747-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131654979413756790;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(39380400002)(2980300002)(199004)(189003)(73972006)(36756003)(81166006)(8936002)(59450400001)(316002)(8676002)(356003)(77096007)(16586007)(81156014)(2876002)(55446002)(51416003)(110136005)(26005)(48376002)(54906003)(50226002)(82202002)(73392003)(105596002)(87572001)(336012)(86362001)(83322999)(2201001)(9786002)(86152003)(61266001)(63266004)(106466001)(498600001)(76482006)(4326008)(47776003)(575784001)(5660300001)(50466002)(305945005)(107886003)(2906002)(2004002)(107986001)(217873001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2636;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:FdXuIHBtz57X96lV1IPZMcmTvN/XyrVnc/puuFOndwi6U/jiCB1O6qZlLAVsvwJTws/GTVSfvefD4NsK6IegX4Z7qiY21k3ZpJ/6tZTGT4erNaZcW8lcgSDcNqMEApeY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6ae849-68e6-4481-e912-08d58998bb52
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM5PR02MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2636;3:vwbS2qUbQlRXAesCT6HX+oNSDWLuKYTFqdAgWtbzL1Y4g9KhdtndnQvjKnTRjHAOOgIdfU0W0mtk+JwMc5DlfqK1qanp5TFtXMWLwfFokbb3Q7XQ0CQN7P9WDRTbSmbsKOdOi0EZADVUCjyaZRW6RrrqbAqbiU1viD16QLm91+IVPmYxKLnPBFQ5BxpxJ1BUvKK1tIdvNDfwNxsxXlEd3sh8mW6wCc5wLCZEsVOFQSD0Nt8172QhM2GvqE7XIq8P8YkYTymm1t8gDS/zdXCVVYACmRM9c+JXWzjUB3UAHn3IVgZQ2rpjBq7/Ze3Pm3B44I3UBZCf2GSdB+w6OdJ9bGWnItRfctq6YAO/wrAanEc=;25:TPLn/dROh8PeMogjEFpZNMEcGW0YEzzi3Y+VE6EH0fktkUsR98JgeEW4hkkWrSd9N5jerKZD+wSboA3YNze7G5sWLJ3SPgFYGTAeD1r5lPiV1e8sqTbLtjNLo5GKsqZYmRpdW7W/gpzlcbGqLD0qLHJMvyarcyAFb5hBNbuwVmPYOoloFyXRCfTMUYZhPmlSXJtUoI9cKTYiudqWl74BUbmina2VUZyswCjoH+0rIzTjX0Zl2C4ydC1UzAL25b6eaI4M9sawa5c+X5codD8U3zq3J876zFNHQpSorsRenTnWD+dT4C27B6b2qRsO0K4BUltsXoiExWaMJglAB41Mfw==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2636;31:Z4ylBs1yTZ80iyeSzYfWDV9VD5+qos0vgVdt1nhrlHwbyMfFpr+x1PlSVlt9TpQLddNuBykIiL3lUASf3IXv75Sd5/eSBbU4cksDR2r+SLuh1t7MQPimoU6Ag9s5cXXXAfor0Kfe9OG1kW8ssQqhAUSD0CYtI5QXyOa6vLh50jPfqBuEHEKwd5OaVjN7SW+Qfy7DxSC8doqZ3Lg3Kv7/i0ti8/EcdpZvka0DGhCUdUg=;4:f34aHeHZLlD7RjfePyIwlhlC8bRqkipMXiZz2QCwD1GtcogeaDkZJtv3TohqeGh7u+FZIcnrf/h9YyyAmiRTphb5qzv1uDeoJA8/oij8EydtLVvHXq8Fke8opDptW84+4Z/gB+t5l6oLoxtHHwNW4MDwqv3CGkxTlFtHc11BEOoUVpAyXWFt1bx7H16dE7R/C8MISBJMEkrmFOoC+BVwr3ZEsCR5Zxe5cUOpRvONycU1qjmb57QMbxndtboeN0vPUhf/VuofHo/OUnBECKS4e2cydvcuvT23mAeu0sknyHJQOnQzxrx5Z5jHMabhHk1L
X-Microsoft-Antispam-PRVS: <DM5PR02MB2636956A4B77D01FB9B89D6CC6D10@DM5PR02MB2636.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123556025)(20161123565025)(20161123563025)(201708071742011);SRVR:DM5PR02MB2636;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR02MB2636;
X-Forefront-PRVS: 0611A21987
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2636;23:3evtHk+OIcCIy4KyGLJgXIF/mD7qMyh7j/MGkKn69?=
 =?us-ascii?Q?uCcAX9TFrbxIXOAtoE0S7lbyx0LfmCGgMaO1BqsLIeIIHU8Hw0nq/Wrw4/oc?=
 =?us-ascii?Q?heR7Q8L/sQ+5nrKGBQHVGpBl0ttu6wn25ufC4PoDk+XSi+j9FRCOndA+xU/1?=
 =?us-ascii?Q?4i8a50kihrq4qzXmCjjznlygshC1G+Z0kohFtytOoBkKvVa95c8ccMEiPrFJ?=
 =?us-ascii?Q?tycSbnZa0coFymPyVHmd3ZWlUhr1vm6Oc08ixjiW+dhY78HYwC0pqlqDbL+Q?=
 =?us-ascii?Q?AxkE01C1L7mHOoJumVFoIjshlJVZRyFLmHOUu8YAKeiA4cI8ymJJzN/4rldK?=
 =?us-ascii?Q?aS5B2HCzOHujHT4JJtmCKWvUtU0Y3LNSxCbi7mKX8YG7jOp2X2EDOqegsKpP?=
 =?us-ascii?Q?xnDCLJsqZ5xdmG0TLklGniIuKnaAaPfZCuZdWUts1Zo3EsLzxtkmH47a95k7?=
 =?us-ascii?Q?OJMylYDnWTV/bVVsBZ5CO8NHRTjweUstkQrzdXoIMz2X7mHi5kFt7bZEkkga?=
 =?us-ascii?Q?f5misO23MvES8JbGghPjKQ2LJfUuII4DgzfOR8MWoVUX+eLtIYFnPj4ruj8j?=
 =?us-ascii?Q?qU24lBwA+zGqAPeJYdLqiKJgrJwRC1bpyf/MaMAKkuHoZJ7FLFgEU2OleA0u?=
 =?us-ascii?Q?PnzrqjWi264EcyonKShmAohBsHP4McAi8Ig23RzGgSGE4qIPpXEl6WjkRSN3?=
 =?us-ascii?Q?x/4Qz2leABYqt3sy6ZBE1n3kQV9TBU8LjxHq54hJ0DOlFMRlfpDfzqFK0A+z?=
 =?us-ascii?Q?4po7j8Fg/RwCL7aHBzC6b3l9dXFCW26cfUayEhuc35nHdpVtWH2r8sM90ViT?=
 =?us-ascii?Q?TSjhxJuYS8m6Kq7v6HU7/5De+WMSpIxUQLeGco1ul96pRAWjTpBeU5cjLDBh?=
 =?us-ascii?Q?mFnvPOP1V+aLSm1KdbOhcnKFX6leC0hEDwspCLo6MXiyK6QPxxoQlMgZHhvG?=
 =?us-ascii?Q?n9pEVGpRvDfBplPz5Sqd+2T7Rj0gWU4E2oJxgr1yaDufsPduxkHh1Y1S4B6K?=
 =?us-ascii?Q?RXj3MluTreDVxVMGU/+ShkAcE6pq7Pmu6VupEXDU2UqZTo3Z84fZkBVUgt4c?=
 =?us-ascii?Q?ZrHL1KUVA0+3ivQsErqc4Jj4SMVsQ8Zs51Usd7V5mJG/+4Xh0u2JRzDNz7Qr?=
 =?us-ascii?Q?cTVjC+jW1o6fc8vpXTHoKjAIKzqazy0Qh4816hdyWqYiSx2m6Xon/QDjic5q?=
 =?us-ascii?Q?p2L3GWUWX/K2/QmLag+I3nmRpV8/6cpncwIhKBraRvYPdjrQ+lK3QR85i8CZ?=
 =?us-ascii?Q?DwlYKw18SMSTv9RP1SD8tIe8/BcLkMwuCUh8bvY?=
X-Microsoft-Antispam-Message-Info: fog716y/haiuROlIZwNEI+W2SfjMBiQ1BmTRljHGGw+iRmZ+5ZRfnMqVctu21i9I3Xou81w2jqO2EU6MNaq+MRsRKnHSY+dhBQkziio7AnhlT8udHLV8TIA2fDoWBywTMr8SWlP7hpqA/dH36g9F/jhXQvwPyLIYIHq43AuQKgvebi1obd6BZTH4hmshj6mn
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2636;6:i4N9qriz/A/dl/klBMFwaSQEFG7uBvMUR8rAt4o9pZ1Ieg9ZK9yXi39K04icsTHyNcUXfxRfjw8RKIvXjyl0gcjI0jTqA0z5AJ3JwlCpWntXOSK7JH6y6mSLLWFeXZnEgUhxsbBlBEwSqiljHXY452NaDYtqVBBQuqqMikZgNLDIDqUKveiTLPJQDq5MbUoBS/YGz4ZgQpUhOAVZRmNsxqlJ5M2wo0a19mgsjJnRB7QyL2b1yXLhzhpV+YvyRoiDpbvg9fKezSCo/+41HZKbdLCMqs65O33EgsdxMpWjOUAP93n62+MUbSHiEZfAIfEE/Fz+mM2oBG+jPAW11SyygB1cCCb4r8n4pDEeWaAjDck=;5:OR5yB54XMMH9+X2Y10bHTPHeeAOPnCQFlua05HKH10XgX+bF7Hl/1prH20Cbl4q4LtqhoI3avQ4GLpRmeSU0M1PTRzedRgZ1kzaLXJ2YqLplJ3H7M+JaAn62y+SjFRmxAxm5la1DdDd47c9zCNLsj918vvClERThlkefXTKIPUE=;24:0yV2hjSD+PTGX1/9Icmu6u+swcVKL4W+NIzw39ZIdRjNMVYNkwIhrAlR0evNK9rOFocpfc/V7FGk3nx3aVJkqKRyQiRPxQZDudwRG6VE+ho=;7:ULUac0xi6iPNlewUraTvYiDXwidScVtAUqmtJ8CxPnQrro/0st11K2mL95HlIIE7fNQYqQgvFvl/NWwxxIazGZOl7JaxrSJKTyukoQHE970eskHZ13lSNvugVN6FaQoZeVvhEzICx7FAnm7Ak3PvW27vJ5Xn2sdCYXpcMgw70SNGIjq4V+J9NHysVTfyGdQRENPSpUdE3QXowwQdj0C0Y6GPjbYpmxeKS/cDp6ivMgh9kb2OqR0TU96TffgbZH+B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 10:45:40.6412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6ae849-68e6-4481-e912-08d58998bb52
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

Add driver for arm pl353 static memory controller. This controller is
used in xilinx zynq soc for interfacing the nand and nor/sram memory
devices.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
Changes in v8:
- None
Changes in v7:
- Corrected the kconfig to use tristate selection
- Corrected the GPL licence ident 
- Added boundary checks for nand timing parameters 
Changes in v6:
- Fixed checkpatch.pl reported warnings
Changes in v5:
- Added pl353_smc_get_clkrate function, made pl353_smc_set_cycles as public
  API
- Removed nand timing parameter initialization and moved it to nand driver  
Changes in v4:
- Modified driver to support multiple instances
- Used sleep instaed of busywait for delay
Changes in v3:
- None
Changes in v2:
- Since now the timing parameters are in nano seconds, added logic to convert
  them to the cycles
---
 drivers/memory/Kconfig                  |   7 +
 drivers/memory/Makefile                 |   1 +
 drivers/memory/pl353-smc.c              | 548 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/pl353-smc.h |  34 ++
 4 files changed, 590 insertions(+)
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 include/linux/platform_data/pl353-smc.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 19a0e83..d70d6db 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -152,6 +152,13 @@ config DA8XX_DDRCTL
 	  This driver is for the DDR2/mDDR Memory Controller present on
 	  Texas Instruments da8xx SoCs. It's used to tweak various memory
 	  controller configuration options.
+config PL35X_SMC
+	bool "ARM PL35X Static Memory Controller(SMC) driver"
+	default y
+	depends on ARM
+	help
+	  This driver is for the ARM PL351/PL353 Static Memory
+	  Controller(SMC) module.
 
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 66f5524..58e794d 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
 obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
+obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
new file mode 100644
index 0000000..edbe07e
--- /dev/null
+++ b/drivers/memory/pl353-smc.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 SMC driver
+ *
+ * Copyright (C) 2012 Xilinx, Inc
+ * Author: Punnaiah <punnaiah@xilinx.com>
+ * Author: nagasuresh <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/platform_data/pl353-smc.h>
+
+/* Register definitions */
+#define PL353_SMC_MEMC_STATUS_OFFS	0	/* Controller status reg, RO */
+#define PL353_SMC_CFG_CLR_OFFS		0xC	/* Clear config reg, WO */
+#define PL353_SMC_DIRECT_CMD_OFFS	0x10	/* Direct command reg, WO */
+#define PL353_SMC_SET_CYCLES_OFFS	0x14	/* Set cycles register, WO */
+#define PL353_SMC_SET_OPMODE_OFFS	0x18	/* Set opmode register, WO */
+#define PL353_SMC_ECC_STATUS_OFFS	0x400	/* ECC status register */
+#define PL353_SMC_ECC_MEMCFG_OFFS	0x404	/* ECC mem config reg */
+#define PL353_SMC_ECC_MEMCMD1_OFFS	0x408	/* ECC mem cmd1 reg */
+#define PL353_SMC_ECC_MEMCMD2_OFFS	0x40C	/* ECC mem cmd2 reg */
+#define PL353_SMC_ECC_VALUE0_OFFS	0x418	/* ECC value 0 reg */
+
+/* Controller status register specifc constants */
+#define PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT	6
+
+/* Clear configuration register specific constants */
+#define PL353_SMC_CFG_CLR_INT_CLR_1	0x10
+#define PL353_SMC_CFG_CLR_ECC_INT_DIS_1	0x40
+#define PL353_SMC_CFG_CLR_INT_DIS_1	0x2
+#define PL353_SMC_CFG_CLR_DEFAULT_MASK	(PL353_SMC_CFG_CLR_INT_CLR_1 | \
+					 PL353_SMC_CFG_CLR_ECC_INT_DIS_1 | \
+					 PL353_SMC_CFG_CLR_INT_DIS_1)
+
+/* Set cycles register specific constants */
+#define PL353_SMC_SET_CYCLES_T0_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T0_SHIFT	0
+#define PL353_SMC_SET_CYCLES_T1_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T1_SHIFT	4
+#define PL353_SMC_SET_CYCLES_T2_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T2_SHIFT	8
+#define PL353_SMC_SET_CYCLES_T3_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T3_SHIFT	11
+#define PL353_SMC_SET_CYCLES_T4_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T4_SHIFT	14
+#define PL353_SMC_SET_CYCLES_T5_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T5_SHIFT	17
+#define PL353_SMC_SET_CYCLES_T6_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T6_SHIFT	20
+
+/* ECC status register specific constants */
+#define PL353_SMC_ECC_STATUS_BUSY	(1 << 6)
+
+/* ECC memory config register specific constants */
+#define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
+#define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
+#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0xC
+
+#define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
+				 (2 << 21))	/* UpdateRegs operation */
+
+#define PL353_NAND_ECC_CMD1	((0x80)       |	/* Write command */ \
+				 (0 << 8)     |	/* Read command */ \
+				 (0x30 << 16) |	/* Read End command */ \
+				 (1 << 24))	/* Read End command calid */
+
+#define PL353_NAND_ECC_CMD2	((0x85)	      |	/* Write col change cmd */ \
+				 (5 << 8)     |	/* Read col change cmd */ \
+				 (0xE0 << 16) |	/* Read col change end cmd */ \
+				 (1 << 24)) /* Read col change end cmd valid */
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+/**
+ * struct pl353_smc_data - Private smc driver structure
+ * @devclk:		Pointer to the peripheral clock
+ * @aperclk:		Pointer to the APER clock
+ */
+struct pl353_smc_data {
+	struct clk		*memclk;
+	struct clk		*aclk;
+};
+
+/* SMC virtual register base */
+static void __iomem *pl353_smc_base;
+
+/**
+ * pl353_smc_set_buswidth - Set memory buswidth
+ * @bw:	Memory buswidth (8 | 16)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_buswidth(unsigned int bw)
+{
+
+	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
+		return -EINVAL;
+
+	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
+
+/**
+ * pl353_smc_set_cycles - Set memory timing parameters
+ * @t0:	t_rc		read cycle time
+ * @t1:	t_wc		write cycle time
+ * @t2:	t_rea/t_ceoe	output enable assertion delay
+ * @t3:	t_wp		write enable deassertion delay
+ * @t4:	t_clr/t_pc	page cycle time
+ * @t5:	t_ar/t_ta	ID read time/turnaround time
+ * @t6:	t_rr		busy to RE timing
+ *
+ * Sets NAND chip specific timing parameters.
+ */
+static void pl353_smc_set_cycles(u32 t0, u32 t1, u32 t2, u32 t3, u32
+			      t4, u32 t5, u32 t6)
+{
+	t0 &= PL353_SMC_SET_CYCLES_T0_MASK;
+	t1 = (t1 & PL353_SMC_SET_CYCLES_T1_MASK) <<
+			PL353_SMC_SET_CYCLES_T1_SHIFT;
+	t2 = (t2 & PL353_SMC_SET_CYCLES_T2_MASK) <<
+			PL353_SMC_SET_CYCLES_T2_SHIFT;
+	t3 = (t3 & PL353_SMC_SET_CYCLES_T3_MASK) <<
+			PL353_SMC_SET_CYCLES_T3_SHIFT;
+	t4 = (t4 & PL353_SMC_SET_CYCLES_T4_MASK) <<
+			PL353_SMC_SET_CYCLES_T4_SHIFT;
+	t5 = (t5 & PL353_SMC_SET_CYCLES_T5_MASK) <<
+			PL353_SMC_SET_CYCLES_T5_SHIFT;
+	t6 = (t6 & PL353_SMC_SET_CYCLES_T6_MASK) <<
+			PL353_SMC_SET_CYCLES_T6_SHIFT;
+
+	t0 |= t1 | t2 | t3 | t4 | t5 | t6;
+
+	writel(t0, pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+}
+
+/**
+ * pl353_smc_ecc_is_busy_noirq - Read ecc busy flag
+ * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
+ */
+static int pl353_smc_ecc_is_busy_noirq(void)
+{
+	return !!(readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
+		  PL353_SMC_ECC_STATUS_BUSY);
+}
+
+/**
+ * pl353_smc_ecc_is_busy - Read ecc busy flag
+ * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
+ */
+int pl353_smc_ecc_is_busy(void)
+{
+	int ret;
+
+	ret = pl353_smc_ecc_is_busy_noirq();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
+
+/**
+ * pl353_smc_get_ecc_val - Read ecc_valueN registers
+ * @ecc_reg:	Index of the ecc_value reg (0..3)
+ * Return: the content of the requested ecc_value register.
+ *
+ * There are four valid ecc_value registers. The argument is truncated to stay
+ * within this valid boundary.
+ */
+u32 pl353_smc_get_ecc_val(int ecc_reg)
+{
+	u32 addr, reg;
+
+	ecc_reg &= 3;
+	addr = PL353_SMC_ECC_VALUE0_OFFS + (ecc_reg << 2);
+	reg = readl(pl353_smc_base + addr);
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_ecc_val);
+
+/**
+ * pl353_smc_get_nand_int_status_raw - Get NAND interrupt status bit
+ * Return: the raw_int_status1 bit from the memc_status register
+ */
+int pl353_smc_get_nand_int_status_raw(void)
+{
+	u32 reg;
+
+	reg = readl(pl353_smc_base + PL353_SMC_MEMC_STATUS_OFFS);
+	reg >>= PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT;
+	reg &= 1;
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_nand_int_status_raw);
+
+/**
+ * pl353_smc_clr_nand_int - Clear NAND interrupt
+ */
+void pl353_smc_clr_nand_int(void)
+{
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_clr_nand_int);
+
+/**
+ * pl353_smc_set_ecc_mode - Set SMC ECC mode
+ * @mode:	ECC mode (BYPASS, APB, MEM)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode)
+{
+	u32 reg;
+	int ret = 0;
+
+	switch (mode) {
+	case PL353_SMC_ECCMODE_BYPASS:
+	case PL353_SMC_ECCMODE_APB:
+	case PL353_SMC_ECCMODE_MEM:
+
+		reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+		reg &= ~PL353_SMC_ECC_MEMCFG_MODE_MASK;
+		reg |= mode << PL353_SMC_ECC_MEMCFG_MODE_SHIFT;
+		writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_mode);
+
+/**
+ * pl353_smc_set_ecc_pg_size - Set SMC ECC page size
+ * @pg_sz:	ECC page size
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz)
+{
+	u32 reg, sz;
+
+	switch (pg_sz) {
+	case 0:
+		sz = 0;
+		break;
+	case 512:
+		sz = 1;
+		break;
+	case 1024:
+		sz = 2;
+		break;
+	case 2048:
+		sz = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+	reg &= ~PL353_SMC_ECC_MEMCFG_PGSIZE_MASK;
+	reg |= sz;
+	writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_pg_size);
+
+static int __maybe_unused pl353_smc_suspend(struct device *dev)
+{
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	clk_disable(pl353_smc->memclk);
+	clk_disable(pl353_smc->aclk);
+
+	return 0;
+}
+
+static int __maybe_unused pl353_smc_resume(struct device *dev)
+{
+	int ret;
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	ret = clk_enable(pl353_smc->aclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable axi domain clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(pl353_smc->memclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable memory clock.\n");
+		clk_disable(pl353_smc->aclk);
+		return ret;
+	}
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(pl353_smc_dev_pm_ops, pl353_smc_suspend,
+			 pl353_smc_resume);
+
+/**
+ * pl353_smc_init_nand_interface - Initialize the NAND interface
+ * @pdev:	Pointer to the platform_device struct
+ * @nand_node:	Pointer to the pl353_nand device_node struct
+ */
+static void pl353_smc_init_nand_interface(struct platform_device *pdev,
+				       struct device_node *nand_node)
+{
+	u32 t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr;
+	int err;
+	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+
+	/* nand-cycle-<X> property is refer to the NAND flash timing
+	 * mapping between dts and the NAND flash AC timing
+	 *  X  : AC timing name
+	 *  t0 : t_rc
+	 *  t1 : t_wc
+	 *  t2 : t_rea
+	 *  t3 : t_wp
+	 *  t4 : t_clr
+	 *  t5 : t_ar
+	 *  t6 : t_rr
+	 */
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t0", &t_rc);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t0 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t1", &t_wc);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t1 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t2", &t_rea);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t2 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t3", &t_wp);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t3 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t4", &t_clr);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t4 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t5", &t_ar);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t5 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t6", &t_rr);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t6 not in device tree");
+		goto default_nand_timing;
+	}
+
+default_nand_timing:
+	if (err) {
+		/* set default NAND flash timing property */
+		dev_warn(&pdev->dev, "Using default timing for");
+		dev_warn(&pdev->dev, "2Gb Numonyx MT29F2G08ABAEAWP NAND flash");
+		dev_warn(&pdev->dev, "t_wp, t_clr, t_ar are set to 2");
+		dev_warn(&pdev->dev, "t_rc, t_wc, t_rr are set to 4");
+		dev_warn(&pdev->dev, "t_rea is set to 1");
+		t_rc = t_wc = t_rr = 4;
+		t_rea = 1;
+		t_wp = t_clr = t_ar = 2;
+	}
+
+	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
+
+	/*
+	 * Default assume 50MHz clock (20ns cycle time) and 3V operation
+	 * The SET_CYCLES_REG register value depends on the flash device.
+	 * Look in to the device datasheet and change its value, This value
+	 * is for 2Gb Numonyx flash.
+	 */
+	pl353_smc_set_cycles(t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr);
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+	/* Wait till the ECC operation is complete */
+	do {
+		if (pl353_smc_ecc_is_busy_noirq())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout))
+		dev_err(&pdev->dev, "nand ecc busy status timed out");
+	/* Set the command1 and command2 register */
+	writel(PL353_NAND_ECC_CMD1,
+			pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
+	writel(PL353_NAND_ECC_CMD2,
+			pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
+}
+
+static const struct of_device_id matches_nor[] = {
+	{ .compatible = "cfi-flash" },
+	{}
+};
+
+static const struct of_device_id matches_nand[] = {
+	{ .compatible = "arm,pl353-nand-r2p1" },
+	{}
+};
+
+static int pl353_smc_probe(struct platform_device *pdev)
+{
+	struct pl353_smc_data *pl353_smc;
+	struct device_node *child;
+	struct resource *res;
+	int err;
+	struct device_node *of_node = pdev->dev.of_node;
+	const struct of_device_id *matches = NULL;
+
+	pl353_smc = devm_kzalloc(&pdev->dev, sizeof(*pl353_smc), GFP_KERNEL);
+	if (!pl353_smc)
+		return -ENOMEM;
+
+	/* Get the NAND controller virtual address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pl353_smc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pl353_smc_base))
+		return PTR_ERR(pl353_smc_base);
+
+	pl353_smc->aclk = devm_clk_get(&pdev->dev, "aclk");
+	if (IS_ERR(pl353_smc->aclk)) {
+		dev_err(&pdev->dev, "aclk clock not found.\n");
+		return PTR_ERR(pl353_smc->aclk);
+	}
+
+	pl353_smc->memclk = devm_clk_get(&pdev->dev, "memclk");
+	if (IS_ERR(pl353_smc->memclk)) {
+		dev_err(&pdev->dev, "memclk clock not found.\n");
+		return PTR_ERR(pl353_smc->memclk);
+	}
+
+	err = clk_prepare_enable(pl353_smc->aclk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable AXI clock.\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(pl353_smc->memclk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable memory clock.\n");
+		goto out_clk_dis_aper;
+	}
+
+	platform_set_drvdata(pdev, pl353_smc);
+
+	/* clear interrupts */
+	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
+		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+
+	/* Find compatible children. Only a single child is supported */
+	for_each_available_child_of_node(of_node, child) {
+		if (of_match_node(matches_nand, child)) {
+			pl353_smc_init_nand_interface(pdev, child);
+			if (!matches) {
+				matches = matches_nand;
+			} else {
+				dev_err(&pdev->dev,
+					"incompatible configuration\n");
+				goto out_clk_disable;
+			}
+		}
+
+		if (of_match_node(matches_nor, child)) {
+			static int counts;
+			if (!matches) {
+				matches = matches_nor;
+			} else {
+				if (matches != matches_nor || counts > 1) {
+					dev_err(&pdev->dev,
+						"incompatible configuration\n");
+					goto out_clk_disable;
+				}
+			}
+			counts++;
+		}
+	}
+
+	if (matches)
+		of_platform_populate(of_node, matches, NULL, &pdev->dev);
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(pl353_smc->memclk);
+out_clk_dis_aper:
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return err;
+}
+
+static int pl353_smc_remove(struct platform_device *pdev)
+{
+	struct pl353_smc_data *pl353_smc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pl353_smc->memclk);
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_smc_of_match[] = {
+	{ .compatible = "arm,pl353-smc-r2p1" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pl353_smc_of_match);
+
+static struct platform_driver pl353_smc_driver = {
+	.probe		= pl353_smc_probe,
+	.remove		= pl353_smc_remove,
+	.driver		= {
+		.name	= "pl353-smc",
+		.pm	= &pl353_smc_dev_pm_ops,
+		.of_match_table = pl353_smc_of_match,
+	},
+};
+
+module_platform_driver(pl353_smc_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("ARM PL353 SMC Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/pl353-smc.h b/include/linux/platform_data/pl353-smc.h
new file mode 100644
index 0000000..a37ec18
--- /dev/null
+++ b/include/linux/platform_data/pl353-smc.h
@@ -0,0 +1,34 @@
+/*
+ * ARM PL353 SMC Driver Header
+ *
+ * Copyright (C) 2012 Xilinx, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LINUX_MEMORY_PL353_SMC_H
+#define __LINUX_MEMORY_PL353_SMC_H
+
+enum pl353_smc_ecc_mode {
+	PL353_SMC_ECCMODE_BYPASS = 0,
+	PL353_SMC_ECCMODE_APB = 1,
+	PL353_SMC_ECCMODE_MEM = 2
+};
+
+enum pl353_smc_mem_width {
+	PL353_SMC_MEM_WIDTH_8 = 0,
+	PL353_SMC_MEM_WIDTH_16 = 1
+};
+
+u32 pl353_smc_get_ecc_val(int ecc_reg);
+int pl353_smc_ecc_is_busy(void);
+int pl353_smc_get_nand_int_status_raw(void);
+void pl353_smc_clr_nand_int(void);
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode);
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz);
+int pl353_smc_set_buswidth(unsigned int bw);
+
+#endif
-- 
2.7.4
