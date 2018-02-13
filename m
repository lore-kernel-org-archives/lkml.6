Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965180AbeBMOz4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:55:56 -0500
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:56362
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965113AbeBMOzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:55:51 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V3 3/9] clk: imx: add pllv4 support
Date: Tue, 13 Feb 2018 21:28:08 +0800
Message-ID: <1518528494-25723-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073427105980;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(54534003)(36756003)(316002)(6306002)(8676002)(2906002)(50466002)(450100002)(81156014)(81166006)(498600001)(106466001)(68736007)(50226002)(4326008)(48376002)(97736004)(8936002)(356003)(47776003)(59450400001)(85426001)(336011)(51416003)(104016004)(105606002)(53936002)(16586007)(6666003)(26826003)(6916009)(2950100002)(26005)(76176011)(5660300001)(86362001)(305945005)(966005)(77096007)(54906003)(2351001)(2004002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB465;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD037;1:JNH38BkG3TJGxOd1PzJsR57u4kfH9uuueZEZpFE/0IBvQIPugLzF2laae654eNT1MvZ+AFPvbRJOaAN9TXBemNsJSVLL9Rx4piemYSuKImp5U0f71uTgdh9TRsAv39Ws
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e276afc-9905-415e-375c-08d572f1dad6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BL2PR03MB465;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB465;3:6+bajpCcLu+vKhltiSbxYFTVJtftKiO7TpjKE7tQw+gF7OhIkVxkeiGxtSwnQXKknfCHIX7b5K4Hy0MYKQZL0Vw7qqYXUt9+F9vEdtypxUomfUW2SVL/mfD1ImJC6QnLUFO6yMyP26xbRgIDMj8XG7TX6fq7Erj/kc2T/Dupw3FoPu+stlWdeqIuIJxhPu7nzqL3VP1NXcn4Ym+mlEdODv2yl1R0scTbnId1630bIVirIjr/egzMeN8GVGO3rg8vmp7VWys/F4HWSIbx045DUd/y3KpSJ+HyphLerT84lz9A3xn2Z696cPsZJC/DRIXkaeQtqq2027zHW99Y8Alz/RT+zUCrGptdn1Wk+yOyipg=;25:GyZMXrKQ53h+N1HYnPVUT6EvaypZPZpAF6duZC8GrSJXDsz7MNOKvjvzCDgQoQ+LgiXYER3ZMcYSwJV0WAocS0wRWQSYnT/ol/gjInDkD3zF9p2wFcf9iUSjdcG8lZNN3A+bHWtMejAlnF7NDzVsVm8yFKe2q4n59Q5Hg/TXL0ubg/UakNAUsAnDY+uptcywSnWnK3MIRty0ZQotyqptFEvYCw1XA8mdR1iTUgsqf9SCdYMlpITckzG5NY/D6s4jaEy2pJyRIrnFKtLAVA+CUIyYtI2ukypX/DFp/RO7ckzR7wBt5tQ7soEC5s72ZyBAnu/O8vGjr7FytBpxrxqRaA==
X-MS-TrafficTypeDiagnostic: BL2PR03MB465:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB465;31:2BHSvudBsJmpMXkZjvhwQeisxCBxt7edOKR8Met8FsvW1l4VCg8JfJ5kjxiIjrcOQcu5guor11/JBxaYK4y1Kmq8qfyRUoP1B3L1WXW1xZFx95gIIJoiqZC0djiHCOpSwK6nZODdmq/Id13qtW3O6VUzCpJUTwPJ/Mlkf2eWwcfEW5an0zQ5qJrmJF5Kx1NYyT+TuOY+BJ2sgF6bJHwGksOWZjRSTQVtGVAXVlzpDps=;4:uhne/wcSx+mzA7BKABh7l45vsAxd4s+EXYIejr9UmpbYoHjTOOH8S6LoNSwPuupWlxwaoFVErEsnjnuJznWMFXedwibnUs/oeD2UrjuGAQw943BClhVgufXVceXg/D8nHMBWkkNBm9e8ZUPf4xmZzGWlbGb17Q6uBU4AuGihyTRNsLb7r13KmDrjJ5ktNGoI21Z8ierd5Os1Rs60aABeczmRoteL4OXXqGQnTocNh9KJ+9rdYtBooPNBllKEBJihZTbLWUtbRtx5ID4X3S1Yrjo/ubB0EugRCTOQNzrxQClOZ2XsXoAGBY4zkvtrNAk6XTL36IbaBgIpiy+TEk0Gsf8tYvc1ezyRdu36HM/C3qNGXAQ18eubYOJCAUp8k5hK
X-Microsoft-Antispam-PRVS: <BL2PR03MB465BB97469A7E0A51A3A0E480F60@BL2PR03MB465.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(3002001)(10201501046)(6055026)(6096035)(20161123561025)(20161123565025)(20161123556025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(201708071742011);SRVR:BL2PR03MB465;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB465;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB465;23:EbO3nco5Bh2QXA81o0LzD1P+KD/naNHK/RVCcXaCFy?=
 =?us-ascii?Q?MzPpz+QGCeNtUWae5QYf0h056Pz0059LHsSW/Z5qS+i/KQQd/Jxcf5eGS3zU?=
 =?us-ascii?Q?T1sa8jVleOXz1YBjdf33Z7im9x7QgRQfgaLTIXxdmkRf0TuB3wFChmhZUtWZ?=
 =?us-ascii?Q?VJyN0enRAbZJzDhrYsEYm7cJIlI+rI/8jnJyxxU/g+18WnEe9P6JUvFFZ2oO?=
 =?us-ascii?Q?LpHwY8RQ3OPHPPTF788+cOZjE4BIDY/M+b5yj+zUhzCZ0lLSvMf/13J6Ub8l?=
 =?us-ascii?Q?Va228l1EQeXWGp+yc4qFSzTzsYTb8r67o6OdmUaiQy4vTV6wRjsWjEQkZ3OU?=
 =?us-ascii?Q?yWcEL9g2pau1qhJ8xOnAdqIFx1Ei3bDrfgNkeJUCls25rM0tXMqK8vil7eXG?=
 =?us-ascii?Q?uaYZZrgGnpX8bAgrisGmdsTY5za5sW/25XyxcZW/Lq1rp8xQeRoeZA0WdPPk?=
 =?us-ascii?Q?9B6X5pq7KvIgOBEFtXgw4dyZABadMx4uu2mR2s27BT+0K82n0FNwBQe2Pmqz?=
 =?us-ascii?Q?72D0b5zVd1//NVJQNg/YXWwaLBax5SmY+CKoKj1eQYRD+oEXweLefe7xkmrW?=
 =?us-ascii?Q?HRGo3cetOzp14K5GUBKwrm0vRtInSbyaQRwQICGjRv7tOFKY6qHQSq2X96lR?=
 =?us-ascii?Q?rBMvRToEiugN2NQx6erB7cihepobFxuASZp/4QfEImbhIn3KY/ODCPlaecy/?=
 =?us-ascii?Q?37+bCtfNyJllgFdVvqZ93hPO2iVXjSFd9OYBXxJM6OUjkI9S5m26vLOAyYor?=
 =?us-ascii?Q?w1rY+4Ysm4DvhaYKFL2VaUMYh3jCQS85IVLeDCMaDPOdKDKxbFCCUFzvF460?=
 =?us-ascii?Q?j0cXcK6xfzsBBcuxKGeDLL2DpK+gqG27UyFGdNat/BW59e+vTj8/BJUtoH1L?=
 =?us-ascii?Q?PSvJYL3JB1XsxgHDTPuG+/yAIMmUoaXG2r5JdoVrzbeQw/FBWiyxatx0doHQ?=
 =?us-ascii?Q?ZEz2Qs9A1u7/ltYdTA29LwM9kMxA/NXOD5+W5+zPb85MUpAULR6Ba47PtoKl?=
 =?us-ascii?Q?kL3zodzWM4M/wzsvFKzhNrxV1QdiQO1qcoU9Jl9VsFq7XK9Y0Sc9IUR7S8qa?=
 =?us-ascii?Q?HyoEmp6cnuWe+li94gkvZQkyjADbSDh/6/8d0uN7Is9JasY2Uc6QoHjEJVpf?=
 =?us-ascii?Q?757I2HuTuiCI/Xkh2hOdAaoY+dutrZjJO8LbJU//xKNvY4L3d0Y8suzr2H0X?=
 =?us-ascii?Q?oLgYFPryE6yMthlZDAmLqwyuJTI32P9k3XQ9pK4s3K9zdJ7oNS2am0gFg4q0?=
 =?us-ascii?Q?+q/tYutBSkPUdb3cY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB465;6:DlUFy3AoqD6tOBrXLs4G/9qQHEqgf734omlcSAbik2ZMc/QeN0dlgdFA+9LfCyxbAIi9JSEKMY+5W2fSw8YSItP2m1kUVIe3RpqWLTuI8vNr3hQrbm58L+aa6vhBQizxqX0FbrcfdxHje3KQYEL/4XGh20YQBFkS0zSCZDmT77cgep3qQLp92HiPzco3BUnWhXiLp6Nbqml5G1ZwyKF0i94Pnsg3phSIHsJ/gwVQ0hsDYJbpD37PCbGlKUGWLG19H1vh5eR+kX36PvJXO2wJDQunkP7fd+WlVCEPFza1Jvn/3D164y2nErC0E6YV6sHJhdGcuri6K4nsh5DQ/MHz+wObNbPgVjKzyTxUUhhPhns=;5:BkgRJhF/YkRuWLfgsiQzaWKOW8NEceoUptsL/M8FfLSFxwO8t+i6as6Fc1jWukQXKPgIw862pQzhp9gNtS9xzX2iSl7GL8EsvqgwVlYaOEh0FLGqRrSZokiCcOcXlDUzHSOBlc1gPTd7z9bzEKJxdKHx5pQmf9kmGXm0IT4b3Is=;24:3w0kNfPGJ7bXeSWQ7nexEbRXnMH45MViQ05iLmVLU/gtESkv2k2YFLO0fM91oxWjrejk4IaLo5ki+QWMPp5cD2RvvRRWPKqfkC1MVktcDTI=;7:T5z5/Jar51LkWOpQba9xvYEj/16D1eV+SRQsVGkPA+i0kOqdYOM+44fy375DCSL4II/h5mR6ZXEwhw4o/hQEYJSACidsGnubFtrw/y4WaPr4bdB/PxLiKWHHNNjhk2Oq+soz83c01PZ/MNVmfA9KrVXVJoMceOsSyDEit/KiQkOCAYOUYAjkQzeCMm0REps4dlyGdjLXCS/q8hibHlF2u0bBGlt07bjydMZngjGhtOOLe83TCffxmpldEURGdp5b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e276afc-9905-415e-375c-08d572f1dad6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB465
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pllv4 is designed for System Clock Generation (SCG) module observed
in IMX ULP SoC series. e.g. i.MX7ULP.

The SCG modules generates clock used to derive processor, system,
peripheral bus and external memory interface clocks while this patch
intends to support the PLL part.

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
 * remove clk_pllv4_is_enabled() check in set_rate, instead it will
   be handled by core later.
 * use readl_poll_timeout
 * use clk_hw_register instead of clk_register
 * other minor changes
---
 drivers/clk/imx/Makefile    |   1 +
 drivers/clk/imx/clk-pllv4.c | 188 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/clk/imx/clk-pllv4.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f91f2b2..2f00b03 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -11,6 +11,7 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
+	clk-pllv4.o \
 	clk-pfd.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
new file mode 100644
index 0000000..47e4d1c
--- /dev/null
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -0,0 +1,188 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+
+/* PLL Control Status Register (xPLLCSR) */
+#define PLL_CSR_OFFSET		0x0
+#define PLL_VLD			BIT(24)
+#define PLL_EN			BIT(0)
+
+/* PLL Configuration Register (xPLLCFG) */
+#define PLL_CFG_OFFSET		0x08
+#define BP_PLL_MULT		16
+#define BM_PLL_MULT		(0x7f << 16)
+
+/* PLL Numerator Register (xPLLNUM) */
+#define PLL_NUM_OFFSET		0x10
+
+/* PLL Denominator Register (xPLLDENOM) */
+#define PLL_DENOM_OFFSET	0x14
+
+struct clk_pllv4 {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+/* Valid PLL MULT Table */
+static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
+
+#define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
+
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static inline int clk_pllv4_wait_lock(struct clk_pllv4 *pll)
+{
+	u32 csr;
+
+	return readl_poll_timeout(pll->base  + PLL_CSR_OFFSET,
+				  csr, csr & PLL_VLD, 0, LOCK_TIMEOUT_US);
+}
+
+static int clk_pllv4_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+
+	if (readl_relaxed(pll->base) & PLL_EN)
+		return 1;
+
+	return 0;
+}
+
+static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+	u32 div;
+
+	div = readl_relaxed(pll->base + PLL_CFG_OFFSET);
+	div &= BM_PLL_MULT;
+	div >>= BP_PLL_MULT;
+
+	return parent_rate * div;
+}
+
+static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	unsigned long round_rate, i;
+
+	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+		round_rate = parent_rate * pllv4_mult_table[i];
+		if (rate >= round_rate)
+			return round_rate;
+	}
+
+	return round_rate;
+}
+
+static bool clk_pllv4_is_valid_mult(unsigned int mult)
+{
+	int i;
+
+	/* check if mult is in valid MULT table */
+	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+		if (pllv4_mult_table[i] == mult)
+			return true;
+	}
+
+	return false;
+}
+
+static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+	u32 val, mult;
+
+	mult = rate / parent_rate;
+
+	if (clk_pllv4_is_valid_mult(mult))
+		return -EINVAL;
+
+	val = readl_relaxed(pll->base + PLL_CFG_OFFSET);
+	val &= ~BM_PLL_MULT;
+	val |= mult << BP_PLL_MULT;
+	writel_relaxed(val, pll->base + PLL_CFG_OFFSET);
+
+	return 0;
+}
+
+static int clk_pllv4_enable(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+
+	val = readl_relaxed(pll->base);
+	val |= PLL_EN;
+	writel_relaxed(val, pll->base);
+
+	return clk_pllv4_wait_lock(pll);
+}
+
+static void clk_pllv4_disable(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+
+	val = readl_relaxed(pll->base);
+	val &= ~PLL_EN;
+	writel_relaxed(val, pll->base);
+}
+
+static const struct clk_ops clk_pllv4_ops = {
+	.recalc_rate	= clk_pllv4_recalc_rate,
+	.round_rate	= clk_pllv4_round_rate,
+	.set_rate	= clk_pllv4_set_rate,
+	.enable		= clk_pllv4_enable,
+	.disable	= clk_pllv4_disable,
+	.is_enabled	= clk_pllv4_is_enabled,
+};
+
+struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+			  void __iomem *base)
+{
+	struct clk_pllv4 *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+
+	init.name = name;
+	init.ops = &clk_pllv4_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	pll->hw.init = &init;
+
+	hw = &pll->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bb..52f7c9d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -42,6 +42,9 @@ enum imx_pllv3_type {
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		const char *parent_name, void __iomem *base, u32 div_mask);
 
+struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 struct clk *clk_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
-- 
2.7.4
