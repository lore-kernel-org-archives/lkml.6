Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965034AbeEYHvx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:51:53 -0400
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:45696
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964970AbeEYHvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:51:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 3/9] clk: imx: add pllv4 support
Date: Fri, 25 May 2018 15:51:05 +0800
Message-Id: <1527234671-31755-4-git-send-email-aisheng.dong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:rb5MkoIaTEesVi5cOpCkKzuGNaUImimnFw/RlAyhhIk+ydRyTAQtB9eOIqpp+qgdb4vZczmF6zqd8RaB/155Liy/klg9GAGT/2yb6iXfcbZ3qCXzThD+dPqN0CTY3lOWGE+7RnDM5Ow3/dnlmGf3+1/ePDevM1qL5eu/amGkThPLubBbt5DDiuo6qEsp4+F75IyWWUAJWM7XfMQ33cI4OUtm3aS4daCIRLtwAXkwrmboWslC3EQl1TuFk7QlxCaA;25:bSZy8XERCOJpufCp5hMCsmkxbGb+VQ4Ia9okcZFDKgPwAA1Jmw3SxURDfGKrxJtkgN0cOfn6BQjFeUWUSxvvDfGHiTp3k3WjF2pn5i8AE/qoKWPrvyfg4sXxsaiKPHMCXHqta7Z1Klv55vvxEDaKCE3u8lEEbmHjELMcLrgUWtKSgpZiiV10Q0l4RQcaKyRqKgASmV2GpVa6aUA8nJ8q9cWUOc+Kc6ZBtX9pJf/IQgGbA/BNfzxc1wJWq8NnIguv+fgFk0D2/l0nIrMDn8I0bjpNk41XZLK47H9Br1pjskZbi68x231xL4GXnFLKEM6UqPg1WEbvq+Ixieb3suFgLA==;31:L40x6QmXUZX/rS+V8jOaM6lHbPt2EZ0eo6jiSw1sfennASTCqm56E33PTiTytMvOoukApFHgT9FgSF7sYg4i8/zgpAtT9/gCWX7gFCo122HgHEgbHSVsfgkHib76wqAq6L17kFw0dNDA0ZluDHEWLm/d2GpGOFKOKiJsIB5UbFpXevhKtjBwgqsd1OEkO9C8Opk2sk1UAT2FOR5W2p58ReJN0sALNO5mAh/GjC0S7w0=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:HMkeZdayqGotLT2LuQdKS12QyNJqOLbpVw0WzGHwGw63Wgj04W74SSZh5poUQIomvTSkoxC5GnzArPZaCYjThnSXe6ydcnHvykhnLc5ekJrjS2Why3szpvynqekf5xfFEFI2PXIrIDEEP1Jv13wT0GZzL73QvHcdpF0q3/uyjFsU2binGX5y00COD+M2KTZKLI4OeCwX2EVIi0KuAMGkhzsYqDKfmtTSPceNtk8CYMksqU1/HAtkeP/KHfclwBk6V8+z/ln6icBKArRzvIVi3HfIJTP3VqxtjiXKZTc9zcu+dyM8+V0LXwdCre0l0LOdzlbJegRuJAIfv3ko9wVixpvjUBxomzrlBXEYj/KJX1v8hjpDe5d1g8NQjeHXpM0946nDEC6luCW1aReqUOpaiUw1JC4xoei3wgPNV2UeSLn9Vs3cuxv6UrxCciSEM+oPoLK9u0M0zL5lJ2v8Hz0dnFrlR6V71fLSQxNNhhg7BgOhIohjKlqjDEW2ucCAer5Y;4:rTzKLMpxkbdXkFOeN+855JAGk5OZc1k00O9lcWpubzBc0yQT+iXoOpyibBqtiy6LVMz+vMgIkDOVx2QrPicO362Na//NNrZs4Ex8pZTaqncTfpcXZ3qyOaTAeD1N4gSfy0ijlZzOce/+F3PcS+d4DDEVEa2va8+rI8gM6HcQGRot2fl1e0yj/KdIgsNVBT74aLa60sHPLUh4sJ6FBpa4wd9wYR1uzmsjT4eDIQ0gkBh7r+S5wLIZOSUxI6WZNG2LHI6eM2caZuqRSOu6WjlfS2IRB302EvoJf5X6DzjR2S3XqTMrm1gYcneBi2H/Vufo
X-Microsoft-Antispam-PRVS: <AM0PR04MB4210A0C252D1EAF7BE5CAFF280690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:fHUHCYmafRT68ZU8zK9dWT+8sgEBT8ACXj9mJHsqc?=
 =?us-ascii?Q?nnKp93Jw326JWa/FiwBpkoiRy4q/2P1/rvlb8W4znL9zgi87kTI5gHPe+mXQ?=
 =?us-ascii?Q?BIUnWn+VHFI7QjiJ1g09IlGuowBCqfOSMRjkPkOBiyyN7PoxhTyRB0uKn51w?=
 =?us-ascii?Q?FSyZoX/AMqDdmE2Pa9Z66H5AqzgKbnYDxZXLrsF/dJP8TbLWkp/c9b15te5n?=
 =?us-ascii?Q?DlLv5SEtga7Hpt/ogd/jW15f9ofqC0R8ILcoJi6ioHjFYrWBveOGX3wtQBKg?=
 =?us-ascii?Q?LSBLfIp8HZ6zhSH2htHF2RwLOS2JKcAPMYTQjLdhVXA6FLUO9xFAAmvxegg7?=
 =?us-ascii?Q?HjeiTEESow0UZapT6yxo59F3qNuPzaFB8hP2pyKxbTlQ0fR+G9JVW47AtnMM?=
 =?us-ascii?Q?ioz4xlzpZiJf4mlxx3Ts2ktXk6X/DDROpvQubDf6wPhhnpKwCxKFpuGxfKgP?=
 =?us-ascii?Q?tV7ieNs1xHLO1jJknJLNYbaeFH9ydoggA4/6ZKEJBjAgM0jFSSt2TzGNII8Y?=
 =?us-ascii?Q?UpudsggNqlCliG/4Nkh6zextx2OM/zovbuHYUUUGAMwP3m4GRkzRfCwso6mu?=
 =?us-ascii?Q?GRO5bdGTiC8x1LGvBATrEjK9ktUvrLuJy7KqOi9E3TjoUqQ5mFLp+Ikrjk/g?=
 =?us-ascii?Q?SbpEfkDIMnix0qWCIQbyDI9CTbYPqte865NYEfAI97iRtXqoS0T6829YwblM?=
 =?us-ascii?Q?xQtAW4JHIIF6MGV8WCxiiCuYcDn1iyPVIxPpxBkeeeoxe2ebAJDEWdJ/lBxF?=
 =?us-ascii?Q?l3aECCmQYDLnyQo2HkhxKddXbflJHmZ5GfpNljgliISARISEmWi2gSfiYwAw?=
 =?us-ascii?Q?Cc4zrqfE7yOjqrvnnkGt/DnPjnaVj2P4rIizy8UXMVblp2jDPLILAdM483ZQ?=
 =?us-ascii?Q?m0KzBMK0HssJBqcxonNYm1ctfbnqRWlv+XROAxAegvV2xliYVOJqJpV8W3/H?=
 =?us-ascii?Q?+8GfLiHwN8L+0RO+NIGj7DMRllZvf5RMtQeSLbuq92o3CrHoNsq6SbBsZoSM?=
 =?us-ascii?Q?UWNaUICswcOSnxu4EskDDgabkIv74FZFfEf3v5cdek1ArGH9KZYAiNwYGy2G?=
 =?us-ascii?Q?y2O/oW98nm0vTxMYfbbsUAE57ccpaY8LRQLRwa94LF99p1vhnuyylmEPWC/M?=
 =?us-ascii?Q?wut3/ydNBuWKvrQskzzu1se2K1t+KdXsS/ymxXr/6UZGNNNxr6NA3yUFWt8+?=
 =?us-ascii?Q?SaoW7GN0CinzJOikotBdBHGtuPq2SgLe5V1w+H7ZGi/z+mKVqeua6m1lYnyz?=
 =?us-ascii?Q?QYVWtDO8567pHEvlPbznqxwtF+U97ZaQu1eLz55uCrOW7s7Z1i5l5HZ0qhpu?=
 =?us-ascii?Q?ax6s+AhRMP+79Ys3w+P4oM=3D?=
X-Microsoft-Antispam-Message-Info: lVyctNk4+MfEYozcTiYo4RJeb7hm3HR/Z6QSFrgmK4g9yBZRnZF9z98k6DF1ln4qhuT2XHGJZ7fiMRWwb8N6rcZoYn1W/A+fCGRodFoMKpdj2rXSyG+9jtmPUyoeLXbJYxgwzcMBbF+QL7sGDeXyFXOkGLyF8+NepxzsOUS9B+OrUTyL0ht+euAVIwUQUtp3
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:WR+CUdmhnnNxNLdpOgdG5/QfLvScKrWwBeVlSwchkA/fnCoLyqkISROC1MkvEcFysuD54vphtYA1bBKJ0A1V5gfQ34xzXk32UfUxSz2BDZPd762JD8PNPZpdW9+0oucbuRDrwVq+ckxH8C8K8SatQ+/ha4sVo9BwzHfKA7XIArhEDdklAKIWNqetybQLWxWvD/BbkAf26ovOKzDDWHXvvpAWFpoyaLZxx7NULag6fUXV0f6CFumYPJqFROCp+NA1ip/7WDPoo6SA3nmT3rS/DX5f3TwkD4hBDkPsUmMBvbpLyjFu5l1pv9CLnFp1OY9RXEcRcEUx1KAFQOr7pDJSdAY748StXT+91WpL0dBlyU4/6pXO4t46iuCPrMB1w63WAsCU5tEjufqYgW462FeDpNbTpMAxo0UGxMicdTIwWTtIo+EiosqfTLyCP/QnQroMGP3b9hoAQjjdMO0TkouV2w==;5:gaX2IdAzaITUMymAh4yOodK3TBzFqvUEZH7WjpQvMtZBHyCr5nPSlTSCFVsiDtU548E1PsfqdiQ8bRvwUd8Diu35+jCQxaxaIbnDfQ/8OuDstKkNJrLC5bk+rXhjUoQbed2444k2PeNQitTNqbW3diWMzobA9Z4d8wSCV3G/+ig=;24:GkV8GwTfqqxdtCGSJgeVS2m1fxNhOxO7t81BjcW6XUdN5fKDMOt8Muv0QEZw8/D5ycohapFAV3xW35PlMQ2ET1tTLU45jpN35dy1TaDb7uI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:rSgjZxMKRi1QTaXsSk/xAff37xwD4y1JknPalbhB7nO23/fPmUDlkVoZTjk79djxGH7JoSRksrjRofd+43SYcZptWhVwq7Ypmf7FSbHybrDXFw7q9EtMLpbjdvDeTzQ1tSy76IX+uKqMUpMFT15iBlbtml5pVs386mcdyDzopmnGgXcNz6+EtDthmbPYyt7Xr1WrOTjWKh7pJ+tyrwtIhEJg8xHymGRVNmxygjqivCB8lxm2B6DXdofppRX9fzEw
X-MS-Office365-Filtering-Correlation-Id: 341935b7-b3a7-49e0-b164-08d5c2145c5c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:40.9809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341935b7-b3a7-49e0-b164-08d5c2145c5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
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
 drivers/clk/imx/clk-pllv4.c | 182 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/clk/imx/clk-pllv4.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..bfe31bf 100644
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
index 0000000..67c64c7
--- /dev/null
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
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
+	if (!clk_pllv4_is_valid_mult(mult))
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
index 8076ec0..2fb4f1d 100644
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
