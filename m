Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeEOFy6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:54:58 -0400
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:54120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752086AbeEOFyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:54:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: add imx8mq-cpufreq driver
Date: Tue, 15 May 2018 13:51:10 +0800
Message-Id: <1526363470-19707-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:11VTeWxvZf9gBdoJ+81liAKZMfyphZScCCzgZoMOXWtKatyxLf6B31MW8j94/3XzeSNJN+BoAJOnoD1Wuj+yn5twNlb42vpZ0O81TWFGeD7Usf5SxIf1TQOFZXYPh9HWrDZlqwm+HZWqtSfFv/cj8CIIcumQCiXmjf9KEJbauk1FXqGaerIi9YhheL4rvogKC/tzcF7/lTNGfmTkeShjoelOqf7n/zrjfl2fiCyr/LTHs2Fcy+gtCXE81J5krP0R;25:GtgzMqmfF5SZLsNpVZlud9k8HTCW5x6gQtHvZAo/ldYlAElfEwCgQOvI7AwjSORpxCIPiQpsEUKAhmkNbaI2x5vyqU4ufked37ftcEvLGog/fivlPU3V8fjox9tI5hhTVJFmu/P8WZCfRi9U0csZq6R89h1WAk0UKqzAWJGjEPMlpgwb0tbzAp0jYd20BaG6Vtp14Ixb4TEoO7TI57Ft1tk11jkSzrBqJ3al+RpWnnkkyL1/8C/fE4ZXYvHwYWSp5MbLU0ZocvhJmehOoSCMwjZ0Xir7o4Z0Z1QrmfuiXo0oy5cqe64aQ+WmLxtbW36/Fk5a9JCHavhBud/BFUF0tQ==;31:w+EeXX9EWgNv5beHQ+UPdfjUOmzea8SKEVZIBjk5tfAPEjVTznoloCFwfncfl0aV5gAH9EVjqlNEykGCzO7rykCbMhMWT7w8fU+aYBXIu0d8F7DHcsj2c/eX8NbsVGOftILR08wlsmJXrEAeV9qVqmMd4+Ur/B1esQpcWwa/VDQPCqjHt6ugx5/diUXb9ZdtaH8Itivvi4XgnKVLO3EUaMhzcULjonwoNihz7HA4+iE=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:G/hkxFZ79K0t2harHDSDCykOVEHXcFFbf/37xya88y7d9vQmAzA7oJtmwey3tlv9Fw1pTq5NQvCJIbkmWpHQMrrTqltbMaFcmctYVTcdDqCezf002W2dKdgSXwdiUz3X1JIDR8US9zWNwoWaEL5g+3wW/M6YWxrKCDhcsHYCMGxAxzV1KphFSOURHT0JwyJyyMIB8UCO7vVbPn0jlWNay6/JVcpR+sI0eqhrOsPlFa1Mp8i8IlLqjp0a7QieP74JAnw4Q5evVA2lWTapV25zQH976+q0D0yaP6pZdnzoDgiVpkHCk0hGadIO7F0yyBHeGBd+DrUSLC9WJtbfoBxc/pXhXSG498SWBi5uoyRCZHucZk0PhAc/Rv4SeP+fAGYvoWQDMykQPU+8fFKJjb+IEIawep8qDmf90yOyL3rvKoSEQEmbQaimdgnMBuMPokZxMivKntyNHyvzjfMgR4snZPktjJPkZC7BU4arPvZd4/q3ggQmPU8JQO40J8HRqXn9;4:fBKSBe+3D3lVO7cQh10Ahb5zCqI3ZUt6ZvfI7r+YvVoBTWnDDJeizbeXXXM2iC3E45Cx4oGmjS+1unv7rREpu3LgHRKIadmP0dA2axpRv7TEKbART3Ns2eS8i7SocT79C6bMe3MU2JwU3uSP62E4W424RYgLSNszulZRONpdpc//agdN9eYop+aGizRhQXiX8ahcDvaRPzzGxHuXvfEs2WjMt8ZhJoAAcmFX+RZyPw3qQuG3M9+55iw9rq960bQS2D6F0rYvm70PXMmbt5jtw5LER5LZEOTjzgOKCYF5c7nM1zkYlsfaxtKcjhVGwcgz
X-Microsoft-Antispam-PRVS: <AM3PR04MB13157682D543EEAA783C1C42F5930@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(189003)(199004)(8676002)(478600001)(305945005)(486006)(476003)(50466002)(50226002)(4326008)(25786009)(68736007)(8936002)(16586007)(53936002)(86362001)(6666003)(6512007)(81166006)(81156014)(7736002)(6486002)(316002)(6506007)(47776003)(386003)(97736004)(59450400001)(1857600001)(26005)(956004)(48376002)(66066001)(2616005)(105586002)(51416003)(3846002)(36756003)(186003)(2906002)(52116002)(16526019)(106356001)(6116002)(5660300001)(2004002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:KlLDvVFfwkBy0JQp7leCFXx2NfIUjtEaesi3UyB9N?=
 =?us-ascii?Q?0CQglomh4/w2uUMBr35Oh0npeBTz1/ZYwMouoTqib0FzQc+hL11MskHoV++O?=
 =?us-ascii?Q?Mt71dn6PwBqq5ragqKLWEKJDRMs3xoKUk8m/j6TqwuCUqYFBQVhypBGRY7xV?=
 =?us-ascii?Q?a5E1VGA/EsZM8XuVd9o7onwN0a1wf0xahmqPFZ1GOBp8eLmYqGYMQmtPZevE?=
 =?us-ascii?Q?H99U6k8VuGFgjT0cXK7BxLkGGu2xBVoU9/spwuJZwYnVnOPimMrxQluEY2rL?=
 =?us-ascii?Q?upCKsW/a+WfkCF/8v01SYohsWQJxIerGpw+fkK8Wp/Y9jsTt61K3Jm7y0Pxh?=
 =?us-ascii?Q?eiwQSvyDGKEYtSLFXtdmhHW1QTFF0xsNg2DRK1gt1GIsa8Lcs3CFHNRoLpEE?=
 =?us-ascii?Q?L3fx+abolRHDkESISkTnSu4tS34Fi+/cS83kXQjbL+v+t9iVjT6tJdF/+b7W?=
 =?us-ascii?Q?Iv2OFsvpLBaryRvQOy15pNOoPRfUm6K4F7w5jAcHqMoFu88mmJaVQichtuz4?=
 =?us-ascii?Q?Zqa7cDhf7Hel18DxtnxQHq3jLmL7jAxMzt//oKoLXcl6B4n6avN2gxbQBuK2?=
 =?us-ascii?Q?D24R02IMkM1bmP2JHi2DSkzffKIjRg78lWqTXkiBcioJhAEpIb2g1qtumjUi?=
 =?us-ascii?Q?7J0XlZmHunX/M8DBzvieHFbTbbVF6a9dWyqPRpw33RbluiME02E3uGF9Gtff?=
 =?us-ascii?Q?d3J/iM74KaKFRDrY/Sc4kRUYGuRSQoOmB91o82hzgQgNyHkc7vy5UrnNkNuS?=
 =?us-ascii?Q?JSauLq1Q+Lp3pUDScCmSAWx2w+YrsWiVTQhOxPUsw3gUZokJrWje4EOTLgK3?=
 =?us-ascii?Q?TorP6FLAJ51j555ZGO76qdQf7DyXzj6aq484OF+KyxRfyfD+tuHSenHkr+Yk?=
 =?us-ascii?Q?GFE3ikn9CFG6puVQqi4orey4oJym5l5qWkevbd4S2vWrrNj3ytCuLi/Pe+W+?=
 =?us-ascii?Q?SHuTzoOF8/n4iovYqttrYqMhGMuM/EJFbvXwiFEGmbNWgt03bDoZ8lfSv6YG?=
 =?us-ascii?Q?A/eYyw/tAGMkDNBYkLQQ+M9pdQ59aslCC5GlytiRBZP7r44f0tz6XOLDuv3a?=
 =?us-ascii?Q?QvdHgpXhcUp/IKMvPtkJAXGmokHNI+3A2qGCmW+iPGrVoE3ncRguuZYXp+I0?=
 =?us-ascii?Q?YILo3ax2s3p37quMeyl0o6GoduU4KnIHANysf8Olo7LE6Ahyy9yj99FISSEM?=
 =?us-ascii?Q?a9s3ByoawD7JyE=3D?=
X-Microsoft-Antispam-Message-Info: SwLhFqWTj8Z7AF0ldkUrgY6Za/y1Qru7gSQ9RZQRYwRBlmfTgsWfl9x97oLPF3ZW0j93/EPgjdQQuKqv2uSNVOcsQr1Yn3xUdhxSL7htxKyYe6DjD3dA+B47JLdoYwiCyjs8yrgytR7VY+amsLUhMqHitkXolRl2HnVwL2ox00Wk9VK97rbUOJa+ApWmYWe+
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:5LBQo1GGtuVdHz+r7EW6nMcAv5HOKhDRGRG37W7SGsONug5B5/e3iqnZZ/ZOhKHx4gaPlGIfQoAhUIdW5wBr2lbqrVbfkiJ6jxF9VUrglhGdWmKOUhgTvtOztzfcWtt+HYrf8JTc4xTp2g3d9yA3NMv76K5As9J/MIUaY8eBQykVDqSYKeob8XTKdEC7L0ghFlao3hKTsDmVHEEmrV+hdqBhUNakkOf1SIwA5LC6OsnHWCtDBXEMawqnRaKFmR7+pRiEMnatCN9jldApNd3X5LzbGHssYlTrhompBTOKfGM1bT01m52kGbpaQmBKrN4eVw4PkOOaBDwVtY91XjDxSvrd4PA3C85HDYJZ+XOkq4ef31MwrqjHnP1xfzK/Ixhc+iDZoGPfI3ho+2t+j9EsLSoIe3xo1x1pUxFyKa7DBjQU4bWZGJi7dQFxVHNsRJL/b0VZ17Pnw/kczO2s398oLg==;5:IPCCpzUlPEBj0jMsZ6IG10zuA5gOK291aBZgB7nK5MoxtooBXU2K3naQo4MdLEBeGaneHm0t8i+lDZ/+c9TOfWrg+XcJLQtE30EThytmLnAgpJrBacSWTf5W/oqnlU/z80KHkAkNeIU1389LvBMiFj3TbB9hsnY97gUvRyuQCQ8=;24:CaSdNXltfKB7o1ByFeHlc5AOJM/D7tUFJaMDIqLOosrjtnD4M3BMbgpEBcKIGd/VFsNp0u0dCrsTrjThm3AHHm5KG5BvGrf3jvHQXNFnCHQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:GeBVrTeHfNiYJTJJONenoi5M72ltC+a+eEpk68a0L5wnmLhjLNh96lgc7GhA7/z+Dz4XMJEbgvH/5sw9isFUEPDDYbyFniz1pfbHskNuPlKTPDLYUIhkwTmLsNWoekkP07dg34y4W7G9VsDx5w4FwC8oATqW3ILMENjzIa5W4IVJlKV01CRALrrUd2xP5rqZbT+TN31KRctNcAjS30Al+IjcsLnaxEuDG+anyJ5w9258f/vgxvz1MWQE/JXbza26
X-MS-Office365-Filtering-Correlation-Id: 269931a1-bfb4-4d75-6db2-08d5ba2860ad
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 05:54:49.0349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269931a1-bfb4-4d75-6db2-08d5ba2860ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8mq-cpufreq driver for NXP i.MX8MQ SoC to support the
hardware specific frequency and voltage scaling requirements.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/Kconfig.arm      |   8 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/imx8mq-cpufreq.c | 234 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/cpufreq/imx8mq-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 96b35b8..ea8e2b6 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -105,6 +105,14 @@ config ARM_IMX6Q_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_IMX8MQ_CPUFREQ
+	tristate "NXP i.MX8MQ cpufreq support"
+	select PM_OPP
+	help
+	  This adds cpufreq driver support for NXP i.MX8MQ SoC.
+
+	  If in doubt, say N.
+
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d24ade..a3bc61c 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IMX8MQ_CPUFREQ)	+= imx8mq-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
diff --git a/drivers/cpufreq/imx8mq-cpufreq.c b/drivers/cpufreq/imx8mq-cpufreq.c
new file mode 100644
index 0000000..2aee6049
--- /dev/null
+++ b/drivers/cpufreq/imx8mq-cpufreq.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+
+static struct device *cpu_dev;
+static bool free_opp;
+static struct cpufreq_frequency_table *freq_table;
+static unsigned int transition_latency;
+static struct thermal_cooling_device *cdev;
+static struct regulator *arm_reg;
+static unsigned int max_freq;
+
+#define IMX8MQ_CPUFREQ_CLK_NUM		5
+
+enum IMX8MQ_CPUFREQ_CLKS {
+	A53,
+	A53_SRC,
+	ARM_PLL,
+	ARM_PLL_OUT,
+	SYS1_PLL_800M,
+};
+
+static struct clk_bulk_data clks[] = {
+	{ .id = "a53" },
+	{ .id = "a53_src" },
+	{ .id = "arm_pll" },
+	{ .id = "arm_pll_out" },
+	{ .id = "sys1_pll_800m" },
+};
+
+static int imx8mq_set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct dev_pm_opp *opp;
+	unsigned long freq_hz, volt;
+	unsigned int old_freq, new_freq;
+	int ret;
+
+	new_freq = freq_table[index].frequency;
+	freq_hz = new_freq * 1000;
+	old_freq = policy->cur;
+
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
+	if (IS_ERR(opp)) {
+		dev_err(cpu_dev, "failed to find OPP for %ld\n", freq_hz);
+		return PTR_ERR(opp);
+	}
+	volt = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+
+	dev_dbg(cpu_dev, "%u MHz --> %u MHz\n",
+		old_freq / 1000, new_freq / 1000);
+
+	if (new_freq > old_freq) {
+		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
+		if (ret) {
+			dev_err(cpu_dev, "failed to scale arm_reg up: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	clk_set_parent(clks[A53_SRC].clk, clks[SYS1_PLL_800M].clk);
+	clk_set_rate(clks[ARM_PLL].clk, new_freq * 1000);
+	clk_set_parent(clks[A53_SRC].clk, clks[ARM_PLL_OUT].clk);
+
+	/* Ensure the arm clock divider is what we expect */
+	ret = clk_set_rate(clks[A53].clk, new_freq * 1000);
+	if (ret)
+		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
+
+	if (new_freq < old_freq) {
+		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
+		if (ret) {
+			dev_err(cpu_dev, "failed to scale arm_reg down: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static void imx8mq_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	cdev = of_cpufreq_cooling_register(policy);
+}
+
+static int imx8mq_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	policy->clk = clks[A53].clk;
+	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
+	policy->suspend_freq = max_freq;
+
+	return ret;
+}
+
+static struct cpufreq_driver imx8mq_cpufreq_driver = {
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = imx8mq_set_target,
+	.get = cpufreq_generic_get,
+	.init = imx8mq_cpufreq_init,
+	.name = "imx8mq-cpufreq",
+	.ready = imx8mq_cpufreq_ready,
+	.attr = cpufreq_generic_attr,
+	.suspend = cpufreq_generic_suspend,
+};
+
+static int imx8mq_cpufreq_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	int ret, num;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu0 device\n");
+		return -ENODEV;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		dev_err(cpu_dev, "failed to find cpu0 node\n");
+		return -ENOENT;
+	}
+
+	ret = clk_bulk_get(cpu_dev, IMX8MQ_CPUFREQ_CLK_NUM, clks);
+	if (ret)
+		goto put_node;
+
+	arm_reg = regulator_get(cpu_dev, "arm");
+	if (PTR_ERR(arm_reg) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		dev_dbg(cpu_dev, "regulator not ready, defer\n");
+		goto put_reg;
+	}
+	if (IS_ERR(arm_reg)) {
+		dev_err(cpu_dev, "failed to get regulator\n");
+		ret = -ENOENT;
+		goto put_reg;
+	}
+
+	/*
+	 * We expect an OPP table supplied by platform.
+	 * Just, in case the platform did not supply the OPP
+	 * table, it will try to get it.
+	 */
+	num = dev_pm_opp_get_opp_count(cpu_dev);
+	if (num < 0) {
+		ret = dev_pm_opp_of_add_table(cpu_dev);
+		if (ret < 0) {
+			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
+			goto put_clk;
+		}
+	}
+	free_opp = true;
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_opp;
+	}
+	max_freq = freq_table[--num].frequency;
+
+	if (of_property_read_u32(np, "clock-latency", &transition_latency))
+		transition_latency = CPUFREQ_ETERNAL;
+
+	ret = cpufreq_register_driver(&imx8mq_cpufreq_driver);
+	if (ret) {
+		dev_err(cpu_dev, "failed register driver: %d\n", ret);
+		goto free_freq_table;
+	}
+
+	of_node_put(np);
+	return 0;
+
+free_freq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_opp:
+	dev_pm_opp_of_remove_table(cpu_dev);
+put_clk:
+	clk_bulk_put(IMX8MQ_CPUFREQ_CLK_NUM, clks);
+put_reg:
+	if (!IS_ERR(arm_reg))
+		regulator_put(arm_reg);
+put_node:
+	of_node_put(np);
+	return ret;
+}
+
+static int imx8mq_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_cooling_unregister(cdev);
+	cpufreq_unregister_driver(&imx8mq_cpufreq_driver);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+	if (free_opp)
+		dev_pm_opp_of_remove_table(cpu_dev);
+	regulator_put(arm_reg);
+	clk_bulk_put(IMX8MQ_CPUFREQ_CLK_NUM, clks);
+
+	return 0;
+}
+
+static struct platform_driver imx8mq_cpufreq_platdrv = {
+	.driver = {
+		.name	= "imx8mq-cpufreq",
+	},
+	.probe		= imx8mq_cpufreq_probe,
+	.remove		= imx8mq_cpufreq_remove,
+};
+module_platform_driver(imx8mq_cpufreq_platdrv);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("Freescale i.MX8MQ cpufreq driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
