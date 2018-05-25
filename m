Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965112AbeEYHwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:52:01 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:45041
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964970AbeEYHvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:51:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 5/9] clk: imx: add composite clk support
Date: Fri, 25 May 2018 15:51:07 +0800
Message-Id: <1527234671-31755-6-git-send-email-aisheng.dong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:3V3pIO4AfV7aMU00mXsHFgyUOPFdPINVOi/SngpYFz423XT6qYspu0K6JjYNcmeTCoooIMB4mVvw0kiAky9gQM36V/tTJabTwdsCdmcTG245xlmAnKOvCsu4TG8hLop+E8xU5fscMQ1uJK0KVf/c8XdnPIxQq6O8ENGpUIV1HXMJq5GeLyGDhAcJvBULx6Z56Zu4se1/LTOYhDKfUKWerjQhKy5KmEaebKWVn7ZKhXKEifatCD2PzXvgSR2XMkt+;25:E1kWDpTBmMyBmjkKwtZvMYls1+Qsenyv3AAI8Dejf3lKUygEYOpE1pjIGESACBNQ5FJsX+xJbwogEwAjT4EtDA1ady1hNDGREfY0X/Tl7KfE0TvMj7avi5KRLm4t7rD0EN+B0NPGE8qE3bt0vaIaZUo6B+CcBHxsi1UokRinQCo4hhW3a2tMKOE0td7conBvPt2N4+6g9tB7yYvOA4icDfH+hd/jGm9yRrhWHiPX3fO/KfZ1GfAplwt7phUozHYXlOPAOrLhtNYwJKGNttsnGI89Neh8++sDcr6AQy6J78PeaJzIg78WJ8RkUYEgzNav91eBmHGB+e87fABcHQq4gw==;31:SjtXSDMjGuImD4ow+RsAzqfTrc0ZCiClGtW5KtVRCbwE7iBZyvgPcYfM4kW8lEo66rCPoAUJ2oZWZFz3QZpwx2bZ+XhTEEPr1Rn+nWbWkiIdKfU4zkv24vJcvpfciP1L8MAE51sheM9SwFn6hpzRsEt5pVO0aWI/PDtRX04fpHuLH4nvylU9Qgy+3vP/YCQnnvzocx3zdri0R7FwqOtODvO07lJdvEbwThhHVzxmRVg=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:YQW7nPkufkk5i9AOhyhNgiVEi0/Ze4UFgR1JgGTUCJvBVGpoRx735MbGKsmv66ttG2N9jgMx6mwwqZFfkrpZQXdx0sm73CZZ31Gr+UvnaVrUdnXF863oSIo4LxIb7py+O91dO9NPQUTg9fo/NILv6np9lBNSzmRGAMNcbCReVrXZIZrheyNjGTxziFcFS+n4xPk9rImvYOaAsmVkwVYGx7O3Zqhoxo8cy6wS+0ap8Ask/4e6va00dprlcuFPwQPPYLeUuX6G4DE9lVosIAeB/leqjdYE8VOZupbgqOHGcxbotetce6Ziksi+tFmOjl1aTqSbQdBebuGb/gI5ufbrP+IU5I+lacUVo2FS3GmHlVn9nwytKOkN8n20Lo2quZHzoQsR2gseHyLcq9mUB5uhf/1eEGaAD454YhrO56I04y1hqyUrlBpLHWb13dXAxk2GGXzV05OLBayCqNWl+1hdweRgiPTcxKYhPgiO0czuAv20uvzQeCQQeMlOCJWjHDuN;4:41/uYnZrxiaPqsJms93Z5HLbbhlxzBOj6eP/39TARHoUzbPltTEDM9tnK6jWnXx+QRam5e49NBRCJJm8hZjhKWgLK5pmN33XUJNdqqG1RPXdhZrtNaN7EuYRPhst0DfmwAl26BtKXQyi0MhuQEmgtVY3Lsr5+rG5f2UdAiYQFgYln2sSIX48v9xEupJqZxl9LqfIpfU1wEu5uv86tWg9zb40yjuHbwJd5NhNNHSGqI3qhCiyXQk1K5lAPpDapZ8GwYkL5PKMTqMgsgGptZPley1E9WezcHcLTywt2a5bsN83BJEVP/K/wag0hBLe92m3
X-Microsoft-Antispam-PRVS: <AM0PR04MB42108588BEAA8E6DC1AB184F80690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(575784001)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:fYqJEE0EysTPUR9KT2CnSqIF0BMeEfmEA5ROIKJKd?=
 =?us-ascii?Q?yzHfveebfqSCLC8bQFi0VdbPTcGVBCZHp+yrQ//7fU0EjEPGqR4/V+o63Us0?=
 =?us-ascii?Q?IAaKu5Ullcr5S3bRxOn897i08sHhwxemSyf/90P7IBjKbdJXNLGFYnQlGf7D?=
 =?us-ascii?Q?TJ/kObbO2KTogB93129rPrMrKLfbSrH3IpmXeP6PfpMfYSD9VdG0dDxuw5If?=
 =?us-ascii?Q?CQh3Er6GlwlI5XP8ub11ZZmhZKdTdRZGWutBtROBpWJeK7hYw4zBrbZOcKUE?=
 =?us-ascii?Q?AHaiLGjTMaABDfZWcjt2iptY99MFqG6yfArRZgqPARhiCnNbECPR+FuykZUQ?=
 =?us-ascii?Q?J0Mhiq9EhGo42taljhlJvhw+j7dphdmOczrdCixh1rnQLwnhksu2Q6754Yl0?=
 =?us-ascii?Q?k7aQKwotvrv5T/YUBxCrtAV6aU0lE8K4gh4nbhH+udC8jjnr7MRn4XNeotoM?=
 =?us-ascii?Q?8fpND2G4ylwmBHg70rQjjKxl8wGh+1Mo1S4dbXNZ9v8NVt0r6hP95MJhoKuH?=
 =?us-ascii?Q?pZV0+zExEqiBt4JV6pG5fW16du16p0CL1NueZo6bqCU4e4xXlEkYUTxYp1Li?=
 =?us-ascii?Q?A4u7fjeI91n27v09kKo3fckN1eDmZtRwrY87Q3vWpWCs7lEY59I8WYU/e+wy?=
 =?us-ascii?Q?3BoXV00VyFSlAS9JR1Mqg6z0/6MvLG+q82vndf7TXMNs/Yo6zQLHKjpmtDBI?=
 =?us-ascii?Q?KSz2UuY4KHeLxVo3XyERWaoZwropw919FV8zsY0k3Pc58ZuoQdkl+jtrb6rn?=
 =?us-ascii?Q?7ArTOilDriDS2wdt9oAniilOQpPINW1DTMbBBvV1CiF822QCUrEpNMyUBaTg?=
 =?us-ascii?Q?iRfopy1k/P9p6Wa4ypY2cqn+U8jNTUWXItcXJ+3OWC4gki+g+scg11InmTNq?=
 =?us-ascii?Q?xQC56wF9lRfaHJF+SRfqswCE3cMQKGn8yVm/MTTNiQeErLUDICW20H6d9Zcx?=
 =?us-ascii?Q?HwKWyMy9ExDDJvobZDk0kL59f5SomGAXd9UwK0kS94vd7eODQjfJTf61854y?=
 =?us-ascii?Q?b42lqvWvlCok/adjFzwIGzQZmRa87Oom15CRRHtJsNMok5Zzsu1BxQZZE9GS?=
 =?us-ascii?Q?A7QXHTRGRaaUNNFZmHrJAuTBh4bB6BhNsB13rKYNZ/RTm1RM5u8uaCEGW31/?=
 =?us-ascii?Q?DFkRg6X7bD9Uhu9dvcg3m3hzI8lafqQEYbqAEJ5Fwux5WijUP+YoydjPMeJ3?=
 =?us-ascii?Q?Y3jYR/zvlx0bNS+BFp3XRBeJybqhNtyctT8pjvJJp7c03vBSdevKmD2kDuew?=
 =?us-ascii?Q?+NEl0fsdLD10j/b5p5gtwWffrNMMKR/X/J1DELZlhdQnROFzxPFSMEP8kw6k?=
 =?us-ascii?Q?yV9ACln5LVG1q8p/XGxk28=3D?=
X-Microsoft-Antispam-Message-Info: Z0+vIy9/LKnStQ+3geyLvObYl91VopXi20kYt/X/wK5Km19xmHooECga963VjoBhFOBD3Lf7ZPNWhAqQRjTT0Er4UloVAiKjCDPRgNM21ug5hSYBmED7ieMEqmaOH1HWZoKwGu29ThOcR8V3oG+oNqUhEaI0uflI1JX00naGrtBJS8G33tP5ZOSZ2uV25mwH
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:5oAKlz9Luc4cv88Foo0njAaX4io2CwWHjOLQ98g1+AXDWSZWo330a6FCA53h42yFZG/kUZOHB1mPdf2xA2rEy9O0iXAd/H3fwK/Um/7Mm9T/Nt72LsG5mIT2Is5Z8lfJ32Uch1A6hPs8mbf0P5JXXaScA3YtN0VD4gaw0q8x0G5QTc48oW/j5XaHl2MFmfLTGp5GN5h48k7JhD497Th67JEBQP7toV92witLmSaAiebsgxbo+4oV2qtLYhq8Jcz73qi+YXWqfvP/QaqUVVCwxnO9eHyI962MAVPgKY7FfXNwY2eU/Mgsl7J3wqJYK3mqQoTDgsszVm3Sr02pgqVaA2nNzMQj9izzitxZxR9j3c12Wkr3rtWm+kU7evwGqy3QhH2ZFy14+0y2pjEsVaFz5agtBMiLOOYiLW4SxAc9DcHm3OEWUTkkWPHOF9bl2CiOee6hm3ao3bk8fiIZd58FcQ==;5:fCe5gcGy4NtUo3MffjMHLyyOBgmSJh0Mp6vX+WFdvr22rMfHXlTKSHoHdLWJ8jtxWNe20+H+z+jrAnjKWa65VU18tdgjpUHBYeA+nFqyrzxKnpbmKpeu432HO6JJZm6dIFF4VUhDU2WF4STrnchY+GNrca//5YzeX86DexQ7hrs=;24:yM0jYohtzHYB+oJqOTlZPCeKWO/C84TMxedmvPhEtTcN1pcW7fuwZGkjqf4ps6QwsSvo0tpfKtnQXynzdzZy8WLDB0xlaHuDArmwrQyScoE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:NCsaNtdBGcAafBYtxTt+7kHv4SKGM3Tj7if+oeGed8TxntSwdqg/hM42zjWSl6GEYy/WJvpy1mPZsKNPcCvuZgk1ZjBTVEEbdpy5TUfZ9e2iRTccGKpAYVKpwHz0xW3r2vmk7cU8IW/fH2yrE6ZCgwjzj/gKpnXUhumDLmqaGBDKJ+VPRarAnV5L8KWtGA2aNn6R4VSmVU0/AZXN3Cmy3w8AVgK6Se0sAnULwId6rDQ2FXMd5QC7HtWfcf61h714
X-MS-Office365-Filtering-Correlation-Id: 91fa66ee-fe6e-4a8e-7e24-08d5c214614d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:49.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fa66ee-fe6e-4a8e-7e24-08d5c214614d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
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
 drivers/clk/imx/clk-composite.c | 85 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  6 +++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index e5b0d42..f4da12c 100644
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
index 0000000..297974b
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
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
index a5a9374..bc43f68 100644
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
