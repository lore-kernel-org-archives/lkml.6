Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936011AbeEYHwj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:52:39 -0400
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:39616
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935914AbeEYHwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:52:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 9/9] clk: imx: add imx7ulp clk driver
Date: Fri, 25 May 2018 15:51:11 +0800
Message-Id: <1527234671-31755-10-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:XiY43mkE7jo8D/Zatroa/lCHr+uufRhjZw132I4yg3YAQeYOqYMGMfq3JgrzEBDGfGNus5t1Jw4DNtUM3e0StKH1qIHWf+an3bAlnVOaQkd6yFq5B+zuVGC/MKgMvVwwOpJyIwkOxZ00UZnjj2GGnIvAiYGb4geJ6HkaC6jc7JkT0VHx/U4sErMx+USYvuE8q2LmDCWZF9zaOEqnuatyipO1yHQ3nUmeOaQ3yL4N694EIKxWEfGE/mzZxZqCR6G0;25:JTBEZqeo5+MPuRTuuQ7gbWrqY/jQWU2URCp88tLBdrZkW3lOxAoJhSvJBF5TsdBcy+YlHBp60jVMfqGyObBCxDe2ELUTZmyYITyl1RD92GW3tl7D2u6gD+Yzf4CSAS/bntgw+J+9GTH1/uUXHVyQsirBkwb0CcA2AUVbZsaWYO11XtHewhqxDooakAMNay+eptoqBrIjBKxj5lVYPgVXdVTatQs58rr7We6+U98rKHdJJRqN4LFeYxBb9Y1TV8SWii/55oYzSdRCAZFM+DVdf+U8e/nRL+z9/flbJErg31xDSbPT8OyT/5bXCtAZ8AUmhJAp48MjwzXUYCaBiK4Pdg==;31:2tFUFQ9rpRKVzapEpX0CxDubkPS5MXdpVGl/VPQqDIwcdBsADVPIey/kQsfyixXsAJk7u4dnbbcP1YvI1DThfy10l2G8C5uwtnX9leovbZIIDVxr+fIK2md+IqUT0tKERFJ3RR8oXEc+L1CIcG6IXF+dOxNBE+7XVZ4xFnRKh2qsGpDQve+u37pujNLveeaFsbrycZIu2qhj+r3HXuItAO+QHQgDG8GuntGAiS5VSKo=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:TvokxJm22g9lMNuSnsviIDBsfFxOsxS4LLWy/6vhQi1ZEGQCT20NT48BT+qzF14wMMYjTWfRauUEQD/f3YMbijQlIwCTGaz1Ob1lsgUDWBfO85ielFqEuftpmz5bT4/la0+6L+dhxSSA5BihgoILGrYgC1oZCdQrHBGBRTA74tdePWE/yL5Yhp4GIqxbk4PD96or4gcJrg0PN8Z3cyjCvQp2/SGxK/a22bwKT6tcB4ZWOXSWiTrsE+QKKmxElm1x+BNmbhphGOIKkdndjMe2woZMOd2HRrieXnr3XzqhyZj3rfyNwPpR9Vp9B55W+drMAPOJUkWm+3bs3WQ041xOimIldrdc086mYxg4BPLgNfynZxUz4Tpu8QSFzQo91CtYYPmnIQ9KX/nKUiuHfzlh6HCbg/h2Hkg8K4nZ/vs1OcM+jMHXRyNnekeKE7Whh3AvBhS9PGb3NNEVmOOHLttn+mCyWqCT9mG4CFT+qeN8fxAktQgnRaWoizvO3Is0BQl4;4:w/4pcgBNeSneQwzK6nP0qTBhzfnPujReWIwE5Icx2XwAH33S6M+nntUTHq7a4iuOxHoInsG0TJFt/T5M3hAA6EZFXC/uZT1El0OtUo+tWpaLEIrTwYpvCgb45z2SD1TVEcmNFxfiuX6DTWgseYqGp8zHmPAbKRHkmDJimYJtfooPuEacgS6d8v1mMBltiRIwJpkLlqdqvM3MtVYwPVelZ2DNIGacJ8q8ehic88LPsbiFVS055luQ5CCQIEoWzckprl7oRpEZZuqRpYpqwlxpm57Q/Drr2tonqfC+Iljy7AtJOZX9h48PSB8r36N577B7
X-Microsoft-Antispam-PRVS: <AM0PR04MB4210D8CA653C3F2AF6D857A080690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(575784001)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:TP4ySeCGghtJuIG1lpYTRkh89pgAsi561zo/ynG4T?=
 =?us-ascii?Q?ZUWruxnP2+T8kJQPAIUYA1+xMT+dKfJWjWLBzAjq3JLOSGD4w4DY4RiouVmW?=
 =?us-ascii?Q?5huDC/X6WH6i5kaafpYu7pGDDV2uDnrdpsqGpI6n8LcT6xs3BZABoSqtY+ov?=
 =?us-ascii?Q?gGDeaanKTPNjThPHbfrG7cORNj4HHV6nV6l2KuwLOuVzcLEmxyeAFRyh2iS2?=
 =?us-ascii?Q?dXApS4HHuUHwVKnPz2XKWSU+CxqXxcbXohLVpLU6zabt5xn66zM5CFrCG/ef?=
 =?us-ascii?Q?GQsVAyJWX2XBHjhx5eKnqYc5x7cvU1zqgxWpTjgXRtUPNgfkS5GXgS93JFyL?=
 =?us-ascii?Q?KgUEbJnOM8fLgaVnQmXUux0YEvekUFK8xeRsKCSw84Ftg7+zGJp3aPlHJMPa?=
 =?us-ascii?Q?qlcTt0s2f4a8WJfVeJnfHKG5GfvPV4n3Wg3aBm5sT+a1eWHMhrWwSCe5sddp?=
 =?us-ascii?Q?06RiDdKBluLXoSUFUDuIvS21t/MftPa71MBtl4Bx5q2D6cK4gbuLQ9Dd8v4e?=
 =?us-ascii?Q?XDWzhyhruE1XusqPH24WSzxarvmCP8+1hz+iUFqCenRdfsgagCtbDlrA8uEF?=
 =?us-ascii?Q?nIn9MhKvmqyp8rqP1ZyUQ1e6IyW/ImyvNxHe8hj91UBONY4NZHk9SqF9Ovzx?=
 =?us-ascii?Q?15pxvskM9BuEbg9AGHo4lxizw3LVqcYpEgGh4N8FmrJ6Gy6c+T+4fVKVKF70?=
 =?us-ascii?Q?9o1n5p1JPBkBO7bYcf6Ss/Esxz9465pJNsKjUX6646mgnHi73xWxPdFIiWbp?=
 =?us-ascii?Q?LZ2R+ioFKq35T4mCdhcAwMsFe0i2B6O86ulT6mme0kJE2ESgGrtX0FgwVkpC?=
 =?us-ascii?Q?3R0S3H4KPj9YBQdJdGNcxCi+NkMj+qDOEme8KLJI3D4Mwr5Od0UyKZipmYpT?=
 =?us-ascii?Q?xPo9XqDSDW4wl68idTyllUJVRfuC44tKSnf9jAtR6K4W4wJCxicA0ZNTQECn?=
 =?us-ascii?Q?T9I1Vzj2P2uno1rtAz0PNz0X7Pt6wkJSIl2g+AGISdA1EoTqomAiUZSPekVj?=
 =?us-ascii?Q?CfN3OV0d42NcIkZJPamthhzdSV4SyPTjni9TvKnzUFYsuEaFmC19zcOsbcbN?=
 =?us-ascii?Q?tNlY3UDiob7h3VUhFwb3qEU5/BgwncXfsDWylgPX2aEG/yoeM7katc3U8/Ni?=
 =?us-ascii?Q?j+Ds2Nu+ur3CodaBTvz2sicY/j59n5zsbupuQVzfvkj68hgUMsg+kP0rCXp4?=
 =?us-ascii?Q?uM4+RMbv1jIbUw3A8y7hyCMN+p3gaa8jlQqcjspuXKE+0pF5J9NAFiWjFqP/?=
 =?us-ascii?Q?GcS3JIj/P8zwpNFjn1LE0JKKUHwNTojDEvGCDfF/odPVVImcL50CnHbVpi0K?=
 =?us-ascii?Q?dfgzZ90MlCkcNOI+2lx9J+RPahErEM2cpZSxcHotv5g?=
X-Microsoft-Antispam-Message-Info: yZcR/Ctuep5BoHzGemMR2bw+ZiH6ne4hIORnpOHscdqvsEdiO+5zA4jH/HzUIAybzzMXcfN+Xy2LM5UeZcuDqs90RcAftArr3gpJhviYF+77iR2+2WcD5yUnDJnsSLRBSQyQ9H1exq4l2peLFbV5jsIQz8RqoKG+mdxNL+chqKCmZTT0TtFsKGT+71VrFPCc
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:AvHXDVDchp9JlxcHrdRDHFK+IYPsaiO5g8E30d+DRb+uR3ELWd8up9BZIbljp3wlB0qQVZD3qprBlLoORx/nmD3p3clSuswzT7MsjMT2cfSjzjobhzvd3zZX+eI1VAu3w1k4KVvnTzJASNimobVwQu1zGQkNl3H/RgCyn6wW+FLFfrV/BsBGYKe0k+drNuwY9uZgE1eTMXvboXuosz57eFqK+dHTjdDueH/lWxof5y+rdMon24RjcFSehkekBkSBuZ2iZU0rYVP6P39ZvQ8Cd5XGnpp5xX6hPUDYFjFPKnzQwfiofRq305/8wQthmbWIYy8XthZPE06ZDXWorBrfWfxJtsLqJv6xD22YgUmOqZZ/W8MzXgCxV4y+nx80LkqhCjG2o96leP2E+Zqa1zX4heTma9qW9byP+3NMjthf1gQUkH5oRzf3Vx3kBbBdeW+eiI2KqRsmmbXF3kr2E5fwZw==;5:YbVA5UlR1HL1168i6o3KTO2OsVEXSCnHQam9Q8p9elyodibJZZF8rr3Tao+g9WIPToQm4UUf7xPWN9b7AASDu2Iq97ZPuSDql5qa7LbyBffKjYiuaw4yKHwjl73nCNY9CPm+QLHSKRpt62jTsqPdNnIJWka1HTjubh8kynipv1w=;24:oH1RP2lyinZhxS+z3YyXUxWaRJP3ZPaX/m2MqgNgHdoRUUi3SksL3cWyWqjeN+qchRj0CE/E8cPSSYHMb5Rst0YYkLi2277mSW7qU9XzPgU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:GnelepmovP1w1UdieyyVwzpmCt6D4NsH5beVRdvysxELH8aMhty+4NvYitiXA7SLO673QKbmSeX5jy3SFp5ePsmYN6skAEW5xa/CNPagI4T/pSZGGbRfLUfFk0RVi5iBbAY5ll9ZZvnV4LwCLrs+VsFtIHjZtNu0FV41DLpFFDAtRXLnuaRK5qhgnQdonREPfHYp9duHlrrFFBTOSyNHuo+7AtAvh4EAa2btqhaxBfhkfcLD/pJ1PAnfEa12Iwa4
X-MS-Office365-Filtering-Correlation-Id: 41e50187-a3e9-4609-18c5-08d5c2146af1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:52:05.7538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e50187-a3e9-4609-18c5-08d5c2146af1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
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
 drivers/clk/imx/clk-imx7ulp.c | 227 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f4da12c..983c0a5 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -29,4 +29,5 @@ obj-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
 obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
+obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
new file mode 100644
index 0000000..bbeaa0f
--- /dev/null
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
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
