Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965226AbeBMO4k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:56:40 -0500
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:10368
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965124AbeBMOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH RESEND V3 5/9] clk: imx: add composite clk support
Date: Tue, 13 Feb 2018 21:28:10 +0800
Message-ID: <1518528494-25723-6-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073428804067;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(39380400002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(54534003)(336011)(450100002)(77096007)(26005)(4326008)(86362001)(48376002)(85426001)(97736004)(105606002)(498600001)(50466002)(26826003)(51416003)(53936002)(2906002)(966005)(16586007)(6306002)(2351001)(316002)(356003)(54906003)(68736007)(106466001)(305945005)(47776003)(6666003)(2950100002)(81156014)(81166006)(50226002)(8676002)(6916009)(104016004)(5660300001)(76176011)(36756003)(8936002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB466;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD047;1:8y0s6gjG7ta222FKQaB048fy5Cisb5WgHhP7Ih1SnJKvHC5lNVLkmCZeUwEgagM2EmjByFYSGwRGjo5piL6m5PTZFkSA2ADiZNjPjeVQQFbajbEwpB/coVPevAm36yBL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 787ccafe-6e40-41f5-15b0-08d572f1dadd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BL2PR03MB466;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB466;3:osipvBYFSUoZ80jfMNi7BCH/bj0f8I6j8h8XEERMmzEYar8/qQGbVAN2CcoSJEMrHeEtz+6X4mgSd4ixHKRqyg4H8h+CCf0SNPSi9IlCzNVHdN1LqCc/yGuhqWr9VSt0Uyc+OjUpdxoAx9hEgR0ZrQxrHMniNtTg73Hl82pCDkZYri2zISPxbwMkPiY4y0pff7MtCLG6sTLf6Ek2J2WZEcLaOm0F3IOYwOBYAE7fnOAQ+dkF49ryFuqvsfpB0mEL4BVQiVBfs2lo6fAtoHwOYaU1+IJjYHrYWkskHgcOQxxid+UBOXxQ26ntbxGzrC7ueuw/GM6mxSEv/UCDnZMpmwkol1SdfofH5rwx7j34qKY=;25:281z9znZtC1Q5+HSlyjFGeqaS4r6/7Kvf075ViV99tMZXxAaUwbjIA/8ZtY4IZ/Yj8H6GBZfgkKxyDNZhSJRmMO3YPrFifaoRWCAjWO6DS/dkJ2yyaMuUctplGJ7oARfuhBnoUqQiclDulKi56rtYP8ClpFpfRH3mmzHhU3A9RXdus5suIBL9iA/ZpLoqjqh3QQev20XMy0Bqsls/xjOR0gEl4Yg9xKrL9BoUZtMLYTVhJbyiqMDvfiiw9FPti1ZnFT6+huv7aKKdMEsER/O95TvwiaK+F+GqGHChPftZGvVwZik/gpGzkYVsULbel7U5igmLCUMLBceqwlbedXrTw==
X-MS-TrafficTypeDiagnostic: BL2PR03MB466:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB466;31:WRHejS72bRSXOFlr8XrOibGLGd99GgVL4CTY5KjQwgIQXx5XZi7r/uufCA4RWnAxzKIe1Nnwtumd6FtObjCR4Tj6KRSjigcfcdA0jjGXYZU1Vwfwvi++Qh+IFEZzVUufyQsDWz9rp2ss2PeWFHX8dTzvrm5cvw2fvcwn/Nuk60lQlAnlKeWvLPI4lIIw9lDNs4rdh6kjcZK7A8/AdT6bKAUnkh2YF8i+hCmmL1wXaig=;4:l+o+fL0veIl4Bimxre0w0DNgsI9PEEzaj3vpiANgoG33MCT0xyWBOyNnHL0PGYEnKlnh2KJS8VheUiokQKvYK6ERfZslS7v0rYq5TLvRaxr9HfDcVoqPIYxKMBJSIuJz0N+D7h0D4FiP8S3Rx9xBJl5z6x3v56BKX6uCGYvzYKMhV+Ixi1m186AGV8aRKJcDzYDtFLGMQCz21En69cNnDsps8oYIeOqaUyqK079eOlYt1T6mBtby/OWyFJ/6v7HCEP9N73yLVg4wmoZWpIcsF3U04rfbKYHYR6qeBC8ZL2Lthz1bP7MXI1oE+3YkHQX68yau05Mi5N4B5z5r1F4SNuPsDP/oo72+gC0lPPMJNEksO0vZapwPvGAeBJzuUoE9
X-Microsoft-Antispam-PRVS: <BL2PR03MB46673C5B024467FB01BE3D380F60@BL2PR03MB466.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123565025)(20161123556025)(20161123563025)(20161123561025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BL2PR03MB466;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB466;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB466;23:wOzOMEQgS2hanMOgsxMmNfqP+XTiPxpZkFecxe4WMg?=
 =?us-ascii?Q?oUlyFym7kt/H7nyfW15g0vj7VKPHSEs0SPd5lr4u9yRKK+DIlqIhuixXzExT?=
 =?us-ascii?Q?sxOyEFDDTJbDCxPQFLsxE85YxAw2AhOTbMRCExLh9mBn4PqlTZtcQmru+1hO?=
 =?us-ascii?Q?I3DEF1Q0O3ZpVZewEKW+tG3zLPOPLrPaOe31eG2a3eSmQa9qpt/rK6vBvl9U?=
 =?us-ascii?Q?BwsAqR4hRc41YONuW0FrFtznGiQIct4dsHYaK69pJ+a5i149sq8+9VBkc9ZA?=
 =?us-ascii?Q?w5QZ1s1UgtC+d42WZOMmTacr35B3WKuc69Wtmu07wH4wsIHdNFzo48Hsv+Yn?=
 =?us-ascii?Q?nUP/+AXUb4VCZ6x76jfTt6Tx4IZxHGdnhyyGvddVaYNhodA91PHcdLPH9LKP?=
 =?us-ascii?Q?u0rQSS6a8LPzxA5Fcl2mLK9rAQnTw/gQsKhVpfsgGQfKQPE89QEqC589JNq/?=
 =?us-ascii?Q?q4+/zYMQSd8Y8KhShvHbZ2UJDe5dZqOPidcUplq7Y1A5rRWGFe7U5RIybTFy?=
 =?us-ascii?Q?lhlfS1dwuCmlXMBVrDnR5zvPFspdyi3aVmrram+5A5nUjOXBPpfzPSDfQb0y?=
 =?us-ascii?Q?akn5BD4ThMCC8m45OnVBxIv7YXiwkSUmBRbDOZr46FC+5M29iM7N8fTG8rBg?=
 =?us-ascii?Q?9PACPOWG+mlVU3q48wkmcO7HoMo38lFfaXs2bTJCC9vqu1hSkX2Yi0nYpKHz?=
 =?us-ascii?Q?IqhMJCpBbsMk1DLz9SWwO8S2EFxw9NWFT2YrlnwF/mdaWJyvjLNYzZQPfjDM?=
 =?us-ascii?Q?yKDT7FT4wF/UqS4zlVEYGHM9zCzPS3zkCvMwACr+u39gj1qhS+XTpCRiqByE?=
 =?us-ascii?Q?mjWEiWzut/C0x8wtOA92KUmNIOWpppJ/icr3G+3aSlaptQFjz2iTvqU7L0LH?=
 =?us-ascii?Q?Ccl8FV8F9Ih/RDtxpb1TfY4bHPTWwItpkKYpZmbK/NUBtxU2Am8COWjpGJ/G?=
 =?us-ascii?Q?FdswKuR8LPkc/hGpFRgqnQ1ug2ZMn6MZkNrnaLdhZfvEGTgvJ+eti9i+VfrT?=
 =?us-ascii?Q?xxN8Ys2sNaayx3gMhwAiLc3R6GmrP/AuwO36JnS2/Vk2IBEuM0QrocoLOhpC?=
 =?us-ascii?Q?WwpadoQvlsDHRue/yXGdyNE97HZHpzsknbU4oZ0+5qSy8uZVWRNn5iOVWdfV?=
 =?us-ascii?Q?9/1ThP4fRYAziK5ewkqU1MGvJqCTg/oDyKRYOQi+vxNJihC436+ZmWNIeb5N?=
 =?us-ascii?Q?FDrSJj3iC3XZH3r1MR+Vv5OFEu23lYU7mB?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB466;6:vwc6d/DslHwNwaJdeB6dHZBa6X+tyDFJrrSL8MJymZd5teOqmq+vbGCKFpBgE2T/RgmwNFa+8Il8gPfJyIaCN20p7wkPv38esAIBjZBHwgpJWtEAtOgESqevfYSzTwKWqCDVcxEdU9XZnyNPyGitWtCcv/RDaxpPfvBbZiMnrsu135RCQBNNgS8j3cAfgcboOZT8hIj3jojypOa9kMtpZev9F1ZKSeQ4X9c887rm/AB+EZCS/bMxbOm2KEjNBRFJjZAJyaM+m1imxCqGh03xIurYd0jAJkVJaFqMlg4aqlo4XTPBo9bA3RhWxfU9fBwF0GX6gZgQ/PiGOmdPeL85X6kWVCVdWsBdkALhYCdsFDo=;5:ylZ/GiMPZok7fneGXQ0HI7uc6McEHStii89+OiR2YelAiiWCzlQw2605yEwSKNxhyAvgKDeLN7K+DAr5SkeE89bEr9mzy/Aiz3+3Y1x5/rwCX/1cgc7myafyometCnN0uekvS7zHLIkSqYp4ahok/7AupqEhkxA37sPqX8D9W3E=;24:SUGMCBwwGfVnl9HWaVwAicnkYSC8bFA1LV7VxbZxuM5y3eoApLn8z6sJXrX6mk513mYjet2+ULyDEGfmbW+m2kbP9heL/drX+vwH3/I6H8I=;7:07boq57VtFxxz0P0aqTSwuHaTyOVvQi8QFj+uZm/YIH09kBQsiXW17bm5X583CJ9ST2CzXLOlOM5pspwb5JvMXKlHauCWFhV8jUGfwdWrRSRZ8G1MYVhvvR7ODYKeIvwcI8o0jHJTHs2Al5fLG1ycWKNic1+zxF0r7BxkgFI2MPm/OeEwcHWlrCUHQVew7ZA0oT7E2n+d7RwD1+y/xAYmS0pe1yjM6TpIt4wIpx3UKSkG6dRgpe7K85N3LBdpr2o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787ccafe-6e40-41f5-15b0-08d572f1dadd
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB466
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx composite clk is designed for Peripheral Clock Control (PCC)
module observed in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pcc can only be operated when clk is gated.

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
 * remove an unneeded blank line change
 * use clk_hw_register
---
 drivers/clk/imx/Makefile        |  1 +
 drivers/clk/imx/clk-composite.c | 90 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  6 +++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 9c04ae4..eab606c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ obj-y += \
 	clk.o \
 	clk-busy.o \
 	clk-cpu.o \
+	clk-composite.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
 	clk-gate-exclusive.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
new file mode 100644
index 0000000..78b891e
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#define PCG_PCS_SHIFT	24
+#define PCG_PCS_MASK	0x7
+#define PCG_CGC_SHIFT	30
+#define PCG_FRAC_SHIFT	3
+#define PCG_FRAC_WIDTH	1
+#define PCG_FRAC_MASK	BIT(3)
+#define PCG_PCD_SHIFT	0
+#define PCG_PCD_WIDTH	3
+#define PCG_PCD_MASK	0x7
+
+struct clk_hw *imx_clk_composite(const char *name,
+			      const char * const *parent_names,
+			      int num_parents, bool mux_present,
+			      bool rate_present, bool gate_present,
+			      void __iomem *reg)
+{
+	struct clk_hw *mux_hw = NULL, *fd_hw = NULL, *gate_hw = NULL;
+	struct clk_fractional_divider *fd = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk_hw *hw;
+
+	if (mux_present) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+		mux_hw = &mux->hw;
+		mux->reg = reg;
+		mux->shift = PCG_PCS_SHIFT;
+		mux->mask = PCG_PCS_MASK;
+	}
+
+	if (rate_present) {
+		fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+		if (!fd) {
+			kfree(mux);
+			return ERR_PTR(-ENOMEM);
+		}
+		fd_hw = &fd->hw;
+		fd->reg = reg;
+		fd->mshift = PCG_FRAC_SHIFT;
+		fd->mwidth = PCG_FRAC_WIDTH;
+		fd->mmask  = PCG_FRAC_MASK;
+		fd->nshift = PCG_PCD_SHIFT;
+		fd->nwidth = PCG_PCD_WIDTH;
+		fd->nmask = PCG_PCD_MASK;
+		fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	}
+
+	if (gate_present) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(mux);
+			kfree(fd);
+			return ERR_PTR(-ENOMEM);
+		}
+		gate_hw = &gate->hw;
+		gate->reg = reg;
+		gate->bit_idx = PCG_CGC_SHIFT;
+	}
+
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux_hw, &clk_mux_ops, fd_hw,
+				       &clk_fractional_divider_ops, gate_hw,
+				       &clk_gate_ops, CLK_SET_RATE_GATE |
+				       CLK_SET_PARENT_GATE);
+	if (IS_ERR(hw)) {
+		kfree(mux);
+		kfree(fd);
+		kfree(gate);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index ccd7181..fed7660 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -71,6 +71,12 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents);
 
+struct clk_hw *imx_clk_composite(const char *name,
+				 const char * const *parent_names,
+				 int num_parents, bool mux_present,
+				 bool rate_present, bool gate_present,
+				 void __iomem *reg);
+
 struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
-- 
2.7.4
