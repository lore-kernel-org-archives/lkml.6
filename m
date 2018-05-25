Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964980AbeEYHxb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:53:31 -0400
Received: from mail-db5eur01on0050.outbound.protection.outlook.com ([104.47.2.50]:43984
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964975AbeEYHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:51:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 4/9] clk: imx: add pfdv2 support
Date: Fri, 25 May 2018 15:51:06 +0800
Message-Id: <1527234671-31755-5-git-send-email-aisheng.dong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:n26TGVo+mhR7vDkBjHksq7YHdxhQz+Q/kqH92vNnaADoEAPprYulkBIXaGb62dJsKK+9i5WANRSLsqgXOrkYPn2bQtGfsQxZ81m6hcfUCYbJkO+BvmWVYKMswfsuZBHm4laUuva9Ud7+rQWgpSpasRNWOsDYmc3SPbpdVtSP8iNrYJdoX7pbwvvnHyG1/t73Aejj2YX1Gdgr0lhrY+FeefSLNWCCpUP8pQ2p+YjZeZh2plmBDgH68j+ZgBmY125D;25:Ky3GM+U6T89Lyg8gJmxXhdi9Im+LHbATXVxvF/F0mBIWVxwbJx32FA24nSFd12bOVzagSoFAyJmN11vZSADpQK4tEeOdnmnop2IUvZyh/f94qbKdnx3fTA7VSidOPdx+12F/66Clnt4wJuU+sTGxYZnO56Ffl3WPR5PTK4pKBzkapPfoGO6M28aEaKwx2DZz2Q9JKF26QiR1vI/jQuoRCOfpCEKG+pOP19QulBvXknODlO7Vjh2sl5zXyUWp5gRsiCKWgLlb+sjmEEjdQrn1VudghpnUBmS3YAKTs8zVM3ULZMbMgdMFEo09bFPTA+Npaz5GaJ1aQ6DEIkECyMc46w==;31:bMOEr5gTxeScvypzPO1DKHZFwNazP7UIcib2KbnrZv/LmtawWiCPV+udgZwffOBbr1dw3dX66X3PfwwFIZibcmk7JYfsvvfLV9roi09QTBBQWopgdd+Hh6gwazz01eKey6454+ZvSXgSdmQ5n6qCI6lFiYUkWALiH8tNBzXvW+QTDxG9Ve/mwBo1l25ST++sR+PZSBwbtoyDXAubRthuQJ+blxItTSEI+ttXP54eYLw=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:8RYcbMfCh6P0yxFe+LLZaSThlce2NbeIWudb5npPc4+Unyo20hlJDY8RHFIChcvNy3bjHiw+koSLQUcB2ipqr/vECYPEz+WKJerRi/dE/yaMesUpUBa/uNpzJzeIQwd2VkRhQVZdt11Ki1Ge4Ai2ISkb+JzZmSFmtEhPGLRMRPTTURVV1dTAQ9FuSeCby9EAnpOOULXlZcnbTZECTF78rtIenYzHONkqUHme4a9o387UEqT4vRxMvJzCJ8PefqJNGO+Zq0UbT+IrNG/SZVPY5knVLmi/yqyQ7z6rtvmHwHpuSTjPMSY0i9vPUb0+L3Bnky5xb8tKJSIC2yakO3z+TLUCwPszJ87wBGnfv/uMwR10wea6pN/i/avZScXQpJMFI2I8LfvB85h00VH3RT/SrU3eNc/LD54RXtJHpSgy9riLQZP4UttmVyoEjosfBx57+tnlw8pZ02YCRsQuZ3wfUGu/PLc99HP4VuILw52DyB6dqX/rGD+ofJuPXfpI3+65;4:QFuAr8u8BBsNLlr6kE+dRvsJToKOCi27iijYSHgIJ+C8p3dnM2UQHvrmmz6/VSGUxqp+JNqctvZo8qPK5NfQeEOtQcecTZzrY/poBRs9zbyEzaCsmalZFafrUdaImbNBlQAFq1/ROWVk3dQMX4kWUrpCmB6RuWSkoedfTpIjykRCcAKxgurIXZ3ayEUaNtugnd9LBO0RhFq8xCubOP17CtzAvu954FnU8t0054vbs2vg3zcYJL9jS3oFq4I5axoFb63fpePxc5W6sS3BXr8CyN2msNgcTZhDBoCoo0jzenLi3lNsEEYi8zlbgstiXmeZ
X-Microsoft-Antispam-PRVS: <AM0PR04MB4210DD4A36D6D8173BF9491780690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(575784001)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:UojOvl7NhT3LckXG90mUj3DVDVaHXKpT9oPFRtjcZ?=
 =?us-ascii?Q?fspcp/lKqQCujXAGls5n9a74UgcWoWqOyDbODZyo+fdJuq0BpbiRmGFdkngx?=
 =?us-ascii?Q?ShBMsIYiPzOQXwyCJwq7lVXlzB7uWxODd+3zAN6lus1/QSBXjaAPIPkYIbgx?=
 =?us-ascii?Q?TkJdajnLwr5SlGuF+xgZZmHfzmmVo3q1bnV/iLR0WORPYHCg95721Mj2zGYh?=
 =?us-ascii?Q?bo5hTyYb8DQi/yru/Dy1jCk2gKTMz15iudGxOuEhJJHhZssRWNsr+oL+n+pd?=
 =?us-ascii?Q?5yPkHojzFbFjhbLK0OVreeDC9dfymD6UbvSbufeLjY/RuHRxYDFJqZfpF3JR?=
 =?us-ascii?Q?xd3QGmwHpFRdYc2Wz77kFnQUmQtc1EFaAlFqzfX6lpWbLk8c06FlAllo9ddm?=
 =?us-ascii?Q?Aaw6UgqzNQT0rbLG8YLc6gfsHU5MJZCuyqUP+k8poLThd6VJILCIKZlOx2i5?=
 =?us-ascii?Q?LTpTX4oylhc5MLuHAPS/xp+eUgmaAi1HskpRhrRjLknI8xeOKGqtfNU/ULr2?=
 =?us-ascii?Q?cQ6xtTC3ksa0Yk/wDIg6AounnljG7rKl52A/t+huhOuqixq0IBgsgx8oA0+g?=
 =?us-ascii?Q?Yqgdr+PSFxgaB9mdjj2JnOEp1IY5+IWjoULm8YnLCBsnYLg/bFEHQY7LPd7+?=
 =?us-ascii?Q?oXKzu6uL9qbamHIfv9gCmj5I1aHbm381CeSIuCf+bYGQz8owk1CeKCtuvbD6?=
 =?us-ascii?Q?IZa804z1RNC0kI8UVNqWhmzsMs6ueMpvWbhYTU9ArgJF99hYrxpczJPP4JSQ?=
 =?us-ascii?Q?8Acik7Opr6UFLgGNyOcIt0BNkuiEUOc5NEeqK3L5MNblVjL7fR5ei8n0Isji?=
 =?us-ascii?Q?UQKUMzr7jsWxKpXatZGaJqeO1/GUocrf8WMnM5AeGU8/CSR+KORdhp5J8KdR?=
 =?us-ascii?Q?OPaGKJ84YSKrlMd1HHMjlobt49hsUo8bnH8FEkRRqZ3ybtGOKrTWz+YrsVUc?=
 =?us-ascii?Q?YUqgxztFKE0DxzAZp1qgYcB3wQDqzE4Y0wkS3GTpkaJSBgjFDcPqHcpvMOMX?=
 =?us-ascii?Q?DlroX2SRevnBMkx+LrhhHdPTbm8il+eCqlI3r4hCsjLaWZbtlvNIihdh4goT?=
 =?us-ascii?Q?Sx3GWzQr6+tNZhgKUs0ukKvMhH0tFQMrCpOFH4Frfjxhcxr9uwwdIBKQ79H9?=
 =?us-ascii?Q?jgYJHWYH0bkorHnbNPFhTkc+oxDGJ9VCJqF7bVBOV9sBb7ASJj3sPSKZ2Ne5?=
 =?us-ascii?Q?Yy6P/0atNr6RtUBAKKMEiyAZL+0EI8JHOOjRNz5LxCS1hkTaZbVDf9bzTNS+?=
 =?us-ascii?Q?xn0G+zc2cJkD26ut4Bro/KdSHDgDcungUC/sEdfnvdGJ8PcMuSV3h+L1oPSf?=
 =?us-ascii?Q?3ymeVk/pzYLMXeHQ8OHsUGdSa+np/CW0lV0gHxyCZI0?=
X-Microsoft-Antispam-Message-Info: dVhR6BskjOqU/sVfiBLfv6aqPp+H2I9ijK9SVoR8BQ5N0XvvD6UD6U52ioVyutgh8caV+htBERTlGpuG2PDI0L4/YIuHIcvL+NZiA6Eqt7NaWGw5gfhzYrJ/Txd7rkC48nokRT4fQyBQVtbxCsthW/oEYdLux4nTgoRwbwB+pTxH0Zf9IFjJhXqE/qONrMCP
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:ZvKZFt414Xav8rNR7+OoNsUQxZeEqux/xr1P3HkWuByugU+af6U/8F5mF2KSz9G2wwdy9nWp6qir9nHcQIurjcMslAHgDyOQyFUvHSHyFoHUyn7CShfc7gKi+hckVL6ta52O0Ec8iuvFIwWbKeNYXm877cNbbUn0fJdF5RnZVlR3NaQGTo5z9FHInjjOtTDnBraP1J+cbb/02TOGUE0lv9fGY0cKlRLncAqP/xynHG4+d2w18b99icPvIyrsuyGq7wY6cgZHclRzPqtFpvTgDntwRDi+g3iTr3FxmjrSROrwj9eAIN6cx35tqO8Pc//L4DzIA9rp3wyrN8TMSgo9MvDXrZj00n3lOlG3N9mTFmYH1LR7fQ36sqJJrVJLQrEkUJ7x62CQuB/5iPMUBeii31AOqWLP/U5u9Bk2SMzQtQqZvyyAdULICNvB2nLu1FnApZkNBzn2EZpCVMfHrKm0rQ==;5:fB7qQhLBb12MTxVcWs0/TVKo1Z5qknCzHwpE/4X+dESHzubVNzmMywcQdMbMfM0SG1HsjnwpazufOnxMVU8AtdL2BL/9l4RoNeNISVqwhhT5A9Y1ATQlRXpqZrVlkfbJDnYhYD7c59H6vZqQ5xbzXn7SolxDJDiN/A+H6yVHjt8=;24:k09cd6RX5Pyo2D3T/ClV28kXZklS8KrhE6iaHAjvaPyzfs3dPjc2tfpEZyXJ7t1lcLnQmXPoACSRjyuC4O1AsbUTbJs9QXjCieL9+bdWODY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:Qdp6tgDoGZgTEN71/2HykmahnXchPSP1sF+fxVJNfLFPXjedED3vS3ETZ/u1FHPB1Wsk2wO8SYuh/5NUK++rE2/V/bQ++4cELw+gqTvOYrQ1hz9K/pbzjNZZ0PffU0DAt/anRV8qWOKGjRrjSd8IkWKMJTXiDDmZrWmyqPkfLu+t5tI7d5Z1lExVgO5Hclsi7yCzBQVP8oUeeruPIxalVS42noM2RPauUYqZR3+8Rw89N2agB7cIZ2mMbE4FHAee
X-MS-Office365-Filtering-Correlation-Id: 9132caad-9af5-418a-5a10-08d5c2145ed1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:45.4211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9132caad-9af5-418a-5a10-08d5c2145ed1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pfdv2 is designed for PLL Fractional Divide (PFD) observed in System
Clock Generation (SCG) module in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pfdv2 can only be operated when clk is gated.

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
 * change to readl_poll_timeout
 * add pfd lock to protect share reg access between rate and enable/disable
   operations and multiple pfd instances.
 * use clk_hw_register
---
 drivers/clk/imx/Makefile    |   3 +-
 drivers/clk/imx/clk-pfdv2.c | 201 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-pfdv2.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index bfe31bf..e5b0d42 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv2.o \
 	clk-pllv3.o \
 	clk-pllv4.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-pfdv2.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
new file mode 100644
index 0000000..afb2904
--- /dev/null
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -0,0 +1,201 @@
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
+/**
+ * struct clk_pfdv2 - IMX PFD clock
+ * @clk_hw:	clock source
+ * @reg:	PFD register address
+ * @gate_bit:	Gate bit offset
+ * @vld_bit:	Valid bit offset
+ * @frac_off:	PLL Fractional Divider offset
+ */
+
+struct clk_pfdv2 {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		gate_bit;
+	u8		vld_bit;
+	u8		frac_off;
+};
+
+#define to_clk_pfdv2(_hw) container_of(_hw, struct clk_pfdv2, hw)
+
+#define CLK_PFDV2_FRAC_MASK 0x3f
+
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static DEFINE_SPINLOCK(pfd_lock);
+
+static int clk_pfdv2_wait(struct clk_pfdv2 *pfd)
+{
+	u32 val;
+
+	return readl_poll_timeout(pfd->reg, val, val & pfd->vld_bit,
+				  0, LOCK_TIMEOUT_US);
+}
+
+static int clk_pfdv2_enable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val = readl_relaxed(pfd->reg);
+	val &= ~pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+
+	return clk_pfdv2_wait(pfd);
+}
+
+static void clk_pfdv2_disable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val = readl_relaxed(pfd->reg);
+	val |= pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+}
+
+static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	frac = (readl_relaxed(pfd->reg) >> pfd->frac_off)
+		& CLK_PFDV2_FRAC_MASK;
+
+	if (!frac) {
+		pr_debug("clk_pfdv2: %s invalid pfd frac value 0\n",
+			 clk_hw_get_name(hw));
+		return 0;
+	}
+
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	u64 tmp = *prate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	tmp = *prate;
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static int clk_pfdv2_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+
+	if (readl_relaxed(pfd->reg) & pfd->gate_bit)
+		return 0;
+
+	return 1;
+}
+
+static int clk_pfdv2_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	unsigned long flags;
+	u64 tmp = parent_rate;
+	u32 val;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val = readl_relaxed(pfd->reg);
+	val &= ~(CLK_PFDV2_FRAC_MASK << pfd->frac_off);
+	val |= frac << pfd->frac_off;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pfdv2_ops = {
+	.enable		= clk_pfdv2_enable,
+	.disable	= clk_pfdv2_disable,
+	.recalc_rate	= clk_pfdv2_recalc_rate,
+	.round_rate	= clk_pfdv2_round_rate,
+	.set_rate	= clk_pfdv2_set_rate,
+	.is_enabled     = clk_pfdv2_is_enabled,
+};
+
+struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+			     void __iomem *reg, u8 idx)
+{
+	struct clk_init_data init;
+	struct clk_pfdv2 *pfd;
+	struct clk_hw *hw;
+	int ret;
+
+	WARN_ON(idx > 3);
+
+	pfd = kzalloc(sizeof(*pfd), GFP_KERNEL);
+	if (!pfd)
+		return ERR_PTR(-ENOMEM);
+
+	pfd->reg = reg;
+	pfd->gate_bit = 1 << ((idx + 1) * 8 - 1);
+	pfd->vld_bit = pfd->gate_bit - 1;
+	pfd->frac_off = idx * 8;
+
+	init.name = name;
+	init.ops = &clk_pfdv2_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	pfd->hw.init = &init;
+
+	hw = &pfd->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pfd);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 2fb4f1d..a5a9374 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -60,6 +60,9 @@ struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
+struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+			     void __iomem *reg, u8 idx);
+
 struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift);
-- 
2.7.4
