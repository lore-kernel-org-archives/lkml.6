Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965195AbeBMO4e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:56:34 -0500
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:56362
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965125AbeBMOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V3 9/9] clk: imx: add imx7ulp clk driver
Date: Tue, 13 Feb 2018 21:28:14 +0800
Message-ID: <1518528494-25723-10-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073428877387;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(54534003)(36756003)(316002)(6306002)(8676002)(2906002)(50466002)(450100002)(81156014)(81166006)(498600001)(106466001)(68736007)(50226002)(4326008)(48376002)(97736004)(8936002)(356003)(47776003)(59450400001)(85426001)(336011)(51416003)(104016004)(105606002)(53936002)(16586007)(6666003)(26826003)(6916009)(2950100002)(26005)(76176011)(5660300001)(86362001)(305945005)(966005)(77096007)(54906003)(2351001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB465;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD025;1:pyNnKpFafKUov9lM9VDVXMYEJLbEBEQUEEgohv1XZbCUUym0DWM8CzUSyc8I8j4dv5XqkguPNVhnde1Ad5gwtMcQC91FfV2s1YjJtsw9id7eEE05bRs12TpWQ8CGhYNF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8900d85-8d9d-4d64-d281-08d572f1dadb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BL2PR03MB465;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB465;3:xCmoSRb6NjunpAqY5QwQahs7eQMPdI50CktgYIUx3XKmcKfxQ6gYj8i5a9lkS+c5bUC+1dtpYWvjnHgMdupznQJNwvtMvrQ16H1vhwUZXynNpiQxn0jDQs2Ly9mMY3C3Ezh6IrH0hhCYgYINB6ZibVeuVTiKUauAvg1LY0R6Nb1SL2RPkHcu48J4PGhuK+UQ9aFCUvI5j31gIv75LesjowbZx1e9EQcixSuh++T1fouzr+PkiNu4ZPyeVkSFoLR/gX9xuqsKKOSF6eH+l2a6k270vTYkn0sgCNFgq9ZVrJ6RVpwZhTXE3ivkmqJ3jX6DRM2Yx7C98EFf60/rnuONSrlpUhLApWu+DQIYrVfD0ZI=;25:QyA47Lum5FuZdizLbW/jFvJ7ZCcnzIG1sssZEydPelqoSZlu3ME45wBHQrcalmxDgGZ8hON8Vj0Y0OdsAHc9AtC2G7S5ipXaDUpjHdeEFq3e2p2+D5/nwoddEezxArfPoKqKC3bKuyt43gihMwpA4xof6fP5g5K6IxiaLoeHr/63dXNcbpjtS/xXzi+skAcpMunkiZmGyQOdRC9CH3RC2qYjVVpcsJnhhKHsoyFfYyuGCP0vLNy8cRG5Pm/wQzaQwlRAZ234Gro/7dcrX3Vv0IpZpUgoA+sl2/55L7LcO2EtzqhEQnvCjS6SGp8Zlbeh9wb3TWSrEP7koVuNyXuDWw==
X-MS-TrafficTypeDiagnostic: BL2PR03MB465:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB465;31:kEydYJZZL2Lf0duYObzi+gFb1acTSXvJnii/siewJ7pVm0BOZ+ja3erZKeJB9RlnfztETsVH9MYZ3+3f1xxBAHLWYWwpjz/iOjKWzn4+pkjYm7vsQ0IVOIr/aqh7vapMjhnFovULgkFY3HpuFcT9beUjee+4VOZLQ/fc0o7Hi4Pu/S+oi86pOa8p+v2ZCcX7uRusQfAs2BmjMmvOBjrswQshy2ZjOTK0v1QEaViLHEs=;4:OuBx/NivZLXYs9n5ANcWQKV6m3Nxui4Cvqo1oKyG0cUI8iWQgHoXmqHhQt+5F+/QbY5jR17dgfBigBGeJeAG/VSE//UNMJsiljUDrK1gFgCdXjgmwVzVMjsNGoXf36hEmiCE+Rls+//WBbxPr4bCp8Xn3d8M1zaNTLfv72pW22/EHoozTCNcpgJ6f2UBgEQX5F5wEH2oNwDGDHWuvBSdag9q0KXi6dCLHoaDCedHfiwOAgR5I50Z8KaFL2BYHkJ9Kp1rCGzgzq2ZNwVrMNbHp6g1arDP2EFszu+nSctGEjsNdVfIs+zeoOuvqzq/Kg98yrHZEc8widqnWLIou5Mbl5Rp+ssPO9EQ036xys4Fr0Abnn6/5G+ZLbt4pGUwc2sK
X-Microsoft-Antispam-PRVS: <BL2PR03MB465C8008E7DFF5292A0373280F60@BL2PR03MB465.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(3002001)(10201501046)(6055026)(6096035)(20161123561025)(20161123565025)(20161123556025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(201708071742011);SRVR:BL2PR03MB465;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB465;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB465;23:nqRrbDtxsfr/V9zZ+gGzFE93fBOCdoys84LvRAWDfJ?=
 =?us-ascii?Q?25i/RzCdra3sGk9vW1GakzfNbMmAiapkQWPzf2k/cDurDmY8G5L7jtXQJWlJ?=
 =?us-ascii?Q?RaesDSzQH9iK6ssfRAvbF6qiJNcCwQ6XrUxyxYRjlg6za4iQRlCrRlwG5Le/?=
 =?us-ascii?Q?0MueZhBRb9Qnh2OPhMd/w4MHJg53VmN4n6Gmg8C6hzHgNnGwuvBtWzP1VJeW?=
 =?us-ascii?Q?mSfpKyzV672EOdYnmwIfBoyDPEIF3DyixFAe7GxuPEMzjYQGtjQGvuh7aYh5?=
 =?us-ascii?Q?TM8+quhCvYYLxBSwd1luGkQrqJDdIT8HxGPgjqCEb6mtJ4A3eMExbMnA3Zgr?=
 =?us-ascii?Q?Yru5I8YYcjav1JNBPeRySmHtGSzPpp+PKUTjmcBnSde2RDvpKf5QDIK+0dV6?=
 =?us-ascii?Q?iFJjX1yNnfxdPt4jd7svyxMlUezlxLLLn+3IjF/l7qUAyzBnIzkbcuuPdh2G?=
 =?us-ascii?Q?z/RWm2z7Ta93v+kV5JWTga++GLj5LRFZhDwZre5igfGciOt4wuLvFPkZyv7c?=
 =?us-ascii?Q?vaBgYuKhv3FVx/apN8cZI+aKoPPTnfE3UhREkpT+zsxWPcA3ZIEH4wBURsuf?=
 =?us-ascii?Q?+Hh+9OHHc7riAhuUPizSLK6tibaiRPQa9j2rnSgMq763fJt+KMKhlvNHceZ7?=
 =?us-ascii?Q?IMcDkQw6J0Em67ireu+3hw9EiM8bWShfV1mInbMNRzsyLxIVcr/f0iAextOb?=
 =?us-ascii?Q?RmIU4kgwzlZC3bM39xDI4rB2sibnSQsjzzrLoiW+ndCbqOAn+nmNvkijee1o?=
 =?us-ascii?Q?9b4T5Q2/9zOFgt5CagJsKDrlpUhMR6bWI6MZlJoIjUhZG7BEiq0DgWgyQAWR?=
 =?us-ascii?Q?dO57F7twErUOnr64ih8RQvSkUL/5+EOv7Ct9zXU6xkzQu0BE8aEmv+QE5VKV?=
 =?us-ascii?Q?kb0WKfoMW+9qCs/Jpo5Aax4KlpagMt87Tn84oeoufgA4pvaEa4ofRj8lttI/?=
 =?us-ascii?Q?ZpySf+sVY717qYLrNHWFxVdLfuuLZjS/jad8owKAtUrx8zxd9jMhvrwob7Xz?=
 =?us-ascii?Q?FTonJgA3eXdWENeCmgocHqLv4m4nUNkFgw6uLlGcN4Cy+7xGStZCBrJIX9CP?=
 =?us-ascii?Q?e8TtrzxA/xEyouOi4AglP9+usfEcjwSGEm8yAG59WBccoCsXg/KSqg2wApQf?=
 =?us-ascii?Q?Ja5SuUSvuRNyJ+kT6ZYq41RG3lzXBFXQbkB0w8RbJoQy9nbXa5NZiX2NcTAV?=
 =?us-ascii?Q?n4wJWA+sdzMm4DcuruHbYOpx0dKUb9VSIMrFtA8vNoLHftf+Osc3+JOQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB465;6:/aQV+osc7jK545+4CSUIdFVkAXbVUTHlPoiKObgDyGcuNZ+93OD1fpkOoOU72vuXSWrX81bncY133d6OY4WhIubDKWddc5XAhbxPjmP8iB+mg8V7i2YubmS7jNx485xbkQ+PfOTRq40mA1sR9O3+QsxVRlZXOta6UZlX0kYmEIUPple7gyZvKJXmomZC0QwQPsgBzQ/7T6WoPgbPF8pYWRct455jbqL7piog69uiLkkEChOorxkcsIAKfk5sA1afLSj4M1MIfSAjXO6CoBBPyN7plfI1a48DjXmOu/HFDTHHVHUvlbClvm059OKeMwYlkXMz9i+2URAlPwLfSgVpmdMiecdU9OCfgNMcwiT6AI0=;5:EbOWxaYVdpBiy0EQmQkJud5oW1WzCB+7d4ID829fZJB/4zofwZ1ew9ZuYbV8Pn+8269HmOj3oivqNoaVGaVuoiTFOzQ6ZMjRv0dXbWW3mJUbqCyKcp4DWdNliIsZ0YkThXQ8EW7QNFICGLpQYt4SJ4Ai088LkSXk9CB+hfRSQ78=;24:N7prWV9uFJYliMOONTk9rWVR5dumZUW7U2bsikFPKI1c5iUBdEo8TshqO+ftxApFcFulqYfz/no7NH+2M9RpJU3bSFOz8P0ZZIpXKGxNJew=;7:ot+5a+TSIjGMf7LTgo8ytYQYtE8wfV+5kho6G/LGX8+RGLakce8ULfn1yvOfw+IqSjozjby5xlvRt69Of46c4dibuRYXG0g6/TtsPzGwsKtIIFRSwBWpQiVFYlFiJOW8V1NzIYeGl1isk/RuGuaCBZuP0l9YZ2Px1tlSAj+XvOwj9+xniuBTzZ2E91Bs467UTzNK4g2lP5RD/ElK9sLeBMza/S5FTnsVOmqv18O+a1eqohc2onnakHlLj2tHEN7/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8900d85-8d9d-4d64-d281-08d572f1dadb
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB465
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

This driver only adds clock support in A7 domain.

Note that most clocks required to be operated when gated, e.g. pll,
pfd, pcc. And more special cases that scs/ddr/nic mux selecting
different clock source requires that clock to be enabled first,
then we need set CLK_OPS_PARENT_ENABLE flag for them properly.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2:
 * use of_clk_add_hw_provider instead
 * split the clocks register process into two parts: early part for possible
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.
---
 drivers/clk/imx/Makefile      |   1 +
 drivers/clk/imx/clk-imx7ulp.c | 232 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index eab606c..f5ff925 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -28,4 +28,5 @@ obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
+obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
new file mode 100644
index 0000000..1245efc
--- /dev/null
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -0,0 +1,232 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+static const char * const pll_pre_sels[]	= { "sosc", "firc", };
+static const char * const spll_pfd_sels[]	= { "spll_pfd0", "spll_pfd1", "spll_pfd2", "spll_pfd3", };
+static const char * const spll_sels[]		= { "spll", "spll_pfd_sel", };
+static const char * const apll_pfd_sels[]	= { "apll_pfd0", "apll_pfd1", "apll_pfd2", "apll_pfd3", };
+static const char * const apll_sels[]		= { "apll", "apll_pfd_sel", };
+static const char * const scs_sels[]		= { "dummy", "sosc", "sirc", "firc", "dummy", "apll_sel", "spll_sel", "upll", };
+static const char * const ddr_sels[]		= { "apll_pfd_sel", "upll", };
+static const char * const nic_sels[]		= { "firc", "ddr_clk", };
+static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
+static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
+
+static struct clk_hw_onecell_data *clk_data;
+
+static void __init imx7ulp_clocks_early_init(struct device_node *scg_node)
+{
+	struct device_node *np = scg_node;
+	void __iomem *base;
+	struct clk_hw **clks;
+
+	clk_data = kzalloc(sizeof(*clk_data) +
+			   sizeof(*clk_data->hws) * IMX7ULP_CLK_END,
+			   GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num = IMX7ULP_CLK_END;
+	clks = clk_data->hws;
+
+	clks[IMX7ULP_CLK_DUMMY]		= imx_clk_hw_fixed("dummy", 0);
+
+	clks[IMX7ULP_CLK_ROSC]		= imx_obtain_fixed_clk_hw(np, "rosc");
+	clks[IMX7ULP_CLK_SOSC]		= imx_obtain_fixed_clk_hw(np, "sosc");
+	clks[IMX7ULP_CLK_SIRC]		= imx_obtain_fixed_clk_hw(np, "sirc");
+	clks[IMX7ULP_CLK_FIRC]		= imx_obtain_fixed_clk_hw(np, "firc");
+	clks[IMX7ULP_CLK_MIPI_PLL]	= imx_obtain_fixed_clk_hw(np, "mpll");
+	clks[IMX7ULP_CLK_UPLL]		= imx_obtain_fixed_clk_hw(np, "upll");
+
+	/* SCG1 */
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	/* NOTE: xPLL config can't be changed when xPLL is enabled */
+	clks[IMX7ULP_CLK_APLL_PRE_SEL]	= imx_clk_hw_mux_flags("apll_pre_sel", base + 0x508, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_SEL]	= imx_clk_hw_mux_flags("spll_pre_sel", base + 0x608, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
+
+	/*							   name		    parent_name	   reg			shift	width	flags */
+	clks[IMX7ULP_CLK_APLL_PRE_DIV]	= imx_clk_hw_divider_flags("apll_pre_div", "apll_pre_sel", base + 0x508,	8,	3,	CLK_SET_RATE_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_DIV]	= imx_clk_hw_divider_flags("spll_pre_div", "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
+
+	/*						name	 parent_name	 base */
+	clks[IMX7ULP_CLK_APLL]		= imx_clk_pllv4("apll",  "apll_pre_div", base + 0x500);
+	clks[IMX7ULP_CLK_SPLL]		= imx_clk_pllv4("spll",  "spll_pre_div", base + 0x600);
+
+	/* APLL PFDs */
+	clks[IMX7ULP_CLK_APLL_PFD0]	= imx_clk_pfdv2("apll_pfd0", "apll", base + 0x50c, 0);
+	clks[IMX7ULP_CLK_APLL_PFD1]	= imx_clk_pfdv2("apll_pfd1", "apll", base + 0x50c, 1);
+	clks[IMX7ULP_CLK_APLL_PFD2]	= imx_clk_pfdv2("apll_pfd2", "apll", base + 0x50c, 2);
+	clks[IMX7ULP_CLK_APLL_PFD3]	= imx_clk_pfdv2("apll_pfd3", "apll", base + 0x50c, 3);
+
+	/* SPLL PFDs */
+	clks[IMX7ULP_CLK_SPLL_PFD0]	= imx_clk_pfdv2("spll_pfd0", "spll", base + 0x60C, 0);
+	clks[IMX7ULP_CLK_SPLL_PFD1]	= imx_clk_pfdv2("spll_pfd1", "spll", base + 0x60C, 1);
+	clks[IMX7ULP_CLK_SPLL_PFD2]	= imx_clk_pfdv2("spll_pfd2", "spll", base + 0x60C, 2);
+	clks[IMX7ULP_CLK_SPLL_PFD3]	= imx_clk_pfdv2("spll_pfd3", "spll", base + 0x60C, 3);
+
+	/* PLL Mux */
+	clks[IMX7ULP_CLK_APLL_PFD_SEL]	= imx_clk_hw_mux_flags("apll_pfd_sel", base + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PFD_SEL]	= imx_clk_hw_mux_flags("spll_pfd_sel", base + 0x608, 14, 2, spll_pfd_sels, ARRAY_SIZE(spll_pfd_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_APLL_SEL]	= imx_clk_hw_mux_flags("apll_sel", base + 0x508, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_SEL]	= imx_clk_hw_mux_flags("spll_sel", base + 0x608, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+
+	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	= clk_hw_register_divider(NULL, "spll_bus_clk", "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	/* scs/ddr/nic select different clock source requires that clock to be enabled first */
+	clks[IMX7ULP_CLK_SYS_SEL]	= imx_clk_hw_mux2("scs_sel", base + 0x14, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
+	clks[IMX7ULP_CLK_NIC_SEL]	= imx_clk_hw_mux2("nic_sel", base + 0x40, 28, 1, nic_sels, ARRAY_SIZE(nic_sels));
+	clks[IMX7ULP_CLK_DDR_SEL]	= imx_clk_hw_mux_flags("ddr_sel", base + 0x30, 24, 1, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+
+	clks[IMX7ULP_CLK_CORE_DIV]	= imx_clk_hw_divider_flags("divcore",	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_DDR_DIV]	= clk_hw_register_divider(NULL, "ddr_clk", "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
+								  CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	clks[IMX7ULP_CLK_NIC0_DIV]	= imx_clk_hw_divider_flags("nic0_clk",		"nic_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_DIV]	= imx_clk_hw_divider_flags("nic1_clk",		"nic0_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	= imx_clk_hw_divider_flags("nic1_bus_clk",	"nic1_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	= clk_hw_register_divider(NULL, "sosc_bus_clk", "sosc", 0, base + 0x104, 8, 3,
+								  CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	= clk_hw_register_divider(NULL, "firc_bus_clk", "firc", 0, base + 0x304, 8, 3,
+								  CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	/* PCC2 */
+	base = of_iomap(np, 1);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_LPTPM4]	= imx_clk_composite("lptpm4",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPTPM5]	= imx_clk_composite("lptpm5",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPIT1]		= imx_clk_composite("lpit1",   periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+
+	/* PCC3 */
+	base = of_iomap(np, 2);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_LPTPM6]	= imx_clk_composite("lptpm6",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	clks[IMX7ULP_CLK_LPTPM7]	= imx_clk_composite("lptpm7",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+
+	clks[IMX7ULP_CLK_MMDC]		= clk_hw_register_gate(NULL, "mmdc", "nic1_clk", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+							       base + 0xac, 30, 0, &imx_ccm_lock);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(scg_node, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE_DRIVER(imx7ulp, "fsl,imx7ulp-clock", imx7ulp_clocks_early_init);
+
+static const struct of_device_id imx7ulp_clk_dt_ids[] = {
+	{ .compatible = "fsl,imx7ulp-clock" },
+	{ /* sentinel */ }
+};
+
+static int imx7ulp_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct clk_hw **clks = clk_data->hws;
+	struct resource *res;
+	void __iomem *base;
+
+	/* PCC2 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scg1");
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clks[IMX7ULP_CLK_GPU_DIV]	= imx_clk_hw_divider("gpu_clk", "nic0_clk", base + 0x40, 20, 4);
+
+	/* PCC2 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcc2");
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clks[IMX7ULP_CLK_DMA1]		= imx_clk_hw_gate("dma1", "nic1_clk", base + 0x20, 30);
+	clks[IMX7ULP_CLK_RGPIO2P1]	= imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk", base + 0x3c, 30);
+	clks[IMX7ULP_CLK_DMA_MUX1]	= imx_clk_hw_gate("dma_mux1", "nic1_bus_clk", base + 0x84, 30);
+	clks[IMX7ULP_CLK_SNVS]		= imx_clk_hw_gate("snvs", "nic1_bus_clk", base + 0x8c, 30);
+	clks[IMX7ULP_CLK_CAAM]		= imx_clk_hw_gate("caam", "nic1_clk", base + 0x90, 30);
+	clks[IMX7ULP_CLK_LPSPI2]	= imx_clk_composite("lpspi2",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
+	clks[IMX7ULP_CLK_LPSPI3]	= imx_clk_composite("lpspi3",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C4]	= imx_clk_composite("lpi2c4",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
+	clks[IMX7ULP_CLK_LPI2C5]	= imx_clk_composite("lpi2c5",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
+	clks[IMX7ULP_CLK_LPUART4]	= imx_clk_composite("lpuart4", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
+	clks[IMX7ULP_CLK_LPUART5]	= imx_clk_composite("lpuart5", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
+	clks[IMX7ULP_CLK_FLEXIO1]	= imx_clk_composite("flexio1", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
+	clks[IMX7ULP_CLK_USB0]		= imx_clk_composite("usb0",    periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
+	clks[IMX7ULP_CLK_USB1]		= imx_clk_composite("usb1",    periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
+	clks[IMX7ULP_CLK_USB_PHY]	= imx_clk_hw_gate("usb_phy", "nic1_bus_clk", base + 0xD4, 30);
+	clks[IMX7ULP_CLK_USDHC0]	= imx_clk_composite("usdhc0",  periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
+	clks[IMX7ULP_CLK_USDHC1]	= imx_clk_composite("usdhc1",  periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
+	clks[IMX7ULP_CLK_WDG1]		= imx_clk_composite("wdg1",    periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
+	clks[IMX7ULP_CLK_WDG2]		= imx_clk_composite("sdg2",    periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
+
+	/* PCC3 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcc3");
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clks[IMX7ULP_CLK_LPI2C6]	= imx_clk_composite("lpi2c6",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	clks[IMX7ULP_CLK_LPI2C7]	= imx_clk_composite("lpi2c7",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPUART6]	= imx_clk_composite("lpuart6", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPUART7]	= imx_clk_composite("lpuart7", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_DSI]		= imx_clk_composite("dsi",     periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
+	clks[IMX7ULP_CLK_LCDIF]		= imx_clk_composite("lcdif",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
+
+	clks[IMX7ULP_CLK_VIU]		= imx_clk_hw_gate("viu",   "nic1_clk",	   base + 0xa0, 30);
+	clks[IMX7ULP_CLK_PCTLC]		= imx_clk_hw_gate("pctlc", "nic1_bus_clk", base + 0xb8, 30);
+	clks[IMX7ULP_CLK_PCTLD]		= imx_clk_hw_gate("pctld", "nic1_bus_clk", base + 0xbc, 30);
+	clks[IMX7ULP_CLK_PCTLE]		= imx_clk_hw_gate("pctle", "nic1_bus_clk", base + 0xc0, 30);
+	clks[IMX7ULP_CLK_PCTLF]		= imx_clk_hw_gate("pctlf", "nic1_bus_clk", base + 0xc4, 30);
+
+	clks[IMX7ULP_CLK_GPU3D]		= imx_clk_composite("gpu3d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	clks[IMX7ULP_CLK_GPU2D]		= imx_clk_composite("gpu2d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+
+	pr_debug("i.MX7ULP clock tree init done.\n");
+
+	return 0;
+}
+
+static struct platform_driver imx7ulp_clk_driver = {
+	.driver = {
+		.name = "imx7ulp-clock",
+		.of_match_table = imx7ulp_clk_dt_ids,
+	},
+	.probe = imx7ulp_clk_probe,
+};
+
+static int __init imx7ulp_clk_init(void)
+{
+	return platform_driver_register(&imx7ulp_clk_driver);
+}
+core_initcall(imx7ulp_clk_init);
-- 
2.7.4
