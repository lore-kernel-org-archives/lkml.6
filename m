Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbeDBKkW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:40:22 -0400
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:23072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754382AbeDBKj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:39:28 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radheys@xilinx.com>, <lars@metafoo.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words to netdev dma client
Date: Mon, 2 Apr 2018 16:09:02 +0530
Message-ID: <1522665546-10035-3-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(346002)(39380400002)(2980300002)(438002)(199004)(189003)(486005)(476003)(486005)(6666003)(16586007)(81156014)(36386004)(42186006)(26005)(2616005)(8676002)(110136005)(54906003)(446003)(36756003)(106002)(478600001)(126002)(90966002)(426003)(50226002)(8936002)(2201001)(11346002)(81166006)(52956003)(106466001)(316002)(305945005)(4326008)(356003)(47776003)(2906002)(51416003)(50466002)(336012)(63266004)(103686004)(59450400001)(48376002)(76176011)(6266002)(186003)(5660300001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1310;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:DYae3NMbBLn35wCwfQx4h7ozJBBy+IZlvFi+l3r8Ty+HQur0/M2YqdFp7LOHB0zgk2CchOq3ZMxZQRbdbBAn3fptmakJS8JXmW0W8SW2FPzIaiqiEClZO9VKJvO1BO1s
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de4ab08-1e99-4026-9280-08d5988600e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR02MB1310;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1310;3:fcl8+oKqjoqDqVlwBMcxnyTwcisZ7iCYPbXqVCYAzsiScN2Uj3bcdppxtyfwooukbgmIRh5xNgjV4UQ3cjxNG8DVhAh9Wev6Gxj54PmpPWSO3m3ak0utBkSQCcH4GSQ/NTqd/0Lt1rFsDQPF7SV3QlRZFIHx0C1xr1lIqloOx8mREvLL8dMtX/8KeZ5iNKZg48dBVlHHyLhTmi47ngpHx8hh6UlYG3pxwdI/eeIrxUii96JDHFwyOEx6H4DRFwGv1jiq5A3VGupR2bHc2d1nR+7cc8FN4iWLuHLGFTj/W4huVYlBMZdWoeAVVIdxlY4GNKaJP3IB8orxJehqMGdeI+/nVSYYClYOBtcEFIyUSYI=;25:TmyEHBrVY1wFnD8j0w7+GW8NGruhymhPNyEqQHNBuw3jIocLpw9opCkT8xzyn7+h8UaDY64J1ZchwliJCIXGNPsl16cK0D0GwHKg4KsbRBOrHr6OEjesrlaGurUh0PR+EIsoVtcAmdEMapzI68Vn86Y+6cgX2dpn+rzJnrDHOe7G290MzkbS/drQUwMc49wlgt2Qy/ebx6XwnBA6kYz7AbJryciPnTnQUUDbqTyWzIAlA7aYmT/h131CUbzx4lJP4SKEyqppXJEEB7mj0c4aFteB2U8juU+tPBKeQTdHv4S7OJRkYjuAe8qRPzjxHGrxNdak4y1VvZnY/VnEfsipDQ==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1310:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1310;31:YQpt4ZAN0RxrSNrM709S7/R20ni/JcRlDSU0GJp1Pyiy9wnVuDbY3aj0NETDUuD7HKk5cw1ItuxE12Tq9B6zWL32qIsQPstvy0dgT6nUy1YsS0NLHiYD3bVJV65m918gVZzLoyV//Bk6ny+UgZPg626hXUagDt+U4WnvIgiac/cR/nao8S4m2W+kEqdEwDHTobn794Frcqp+91PJh+9gZoRAixq7TxEr8aWnghbp2ZE=;20:twKPjIvF8lawhtT6ZsVo9c8ujW6K5CjCmXKkfY7/sxFX+w5nIdE5Z0GK9Zu9KSm8SHStZVCF0kYxLlO/LqoIat+ZPCnN49visMBb/I1NQqFcvs9Uq1ocaMYHlfvApiWpbHhQL9n7ov83r8DvxsAGkH3Ysvx5SoYb2Ffl9HMuxw8gxNP26R9Mbt/ogGbaAyLlZYjNaSL23xTNFRyZ8wd1FEo6iYm/KFsVbYzCglFUdwnQcXA9TFM08HK7oHIDR1PgPvgXTAodhaHMiz6r3GDOPKdnfIt4uaQ4/QtSOTrLofntHtYd9jRj+IkwZ1yKM+2kT3u7ycSBOFJGbC7VU4F0ZJ2JJdMUUlT7lJU0ttNOfujvLEuVWgHAMV9DgzVGVNhsJPUOFm0a5XTvIP7LUCTfc+rcnCSHg7mkKOcidsexsRQv5ypowt7Ocd9jICMKY78gY0SGtOzXm9TysLtAM1Fp65RrMqdOjsK+/d3R4arpfqa0QW5KArCCDjoyjvRmdutn
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB13107C944A6D5E95319AB132C7A60@SN1PR02MB1310.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR02MB1310;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1310;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1310;4:zEv+IsgxQJainLRElFSkpw8AuQU3A8L75pPlcot5bE+g/MJRyp8pHZQNszwlZ5Ghoy27kpnDZ7TE2Nwf6VBq5e4+OD6ihYe2GEUdjfnS5esclI2MfReiCfjAi1E9rgyDyfJPP5Me8RfvjooLQOSBbzXGjpXpPEAJv/cnjIBRU3VIxNyhD0Fcv/sVsKXsZ+DvxCXJjyT40OMg6RG1XTNILxpA4C1es8BLhvEH6UcA1ayPaMiDEx1QuDk5+E05Q2f0VJNxMJV/YrjPuqA3dOziLlwAFWNaVknhZmhJsV5d3KM/as2NCUouMOSyglPiE8/F
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1310;23:6hK/ZJN4b0QkzISe04B6O0qeTx0aJZ8GoT+LeeEYR?=
 =?us-ascii?Q?lVmYrtMCEonKJPl6vX8wkSHfxyLdwtqu2CLAXDfAFoff+I8D6ICv0nM0fcIi?=
 =?us-ascii?Q?VY3YCN8ufDYwjsGB3qXb3ToTGOeAe5nVXkZEFKvYZlt1NEl1ByUs7qPcfqeH?=
 =?us-ascii?Q?XJQjjgSapHSYc4Rgsr0HI7Sp599f7S6c5KQWmA504VojET+InZ/sLfIpIN4o?=
 =?us-ascii?Q?KTA5HZ0/8BI+y08rJyPfTCBn4IXb/Soyn94R8Jz9DP1vCzJNcftIduXGRKgM?=
 =?us-ascii?Q?L/cGNjSDhyEJwAi3aB54yiqiPmcEztKBWgDWo/HHla5MVw/uFv0/IkaetD6j?=
 =?us-ascii?Q?afdModKiviFOhBKdgi6yAQyRbcIhzkvjWpeljjhkGjGhTf57/esd6HhCkmtV?=
 =?us-ascii?Q?mRXek8jGmGZ9fmGNq91K87HC2IIl72QJYTnVOu1W+M/s6sWHDb8qkMKNtDFZ?=
 =?us-ascii?Q?R3sI36rUAM/XKTrtc99zbcgrrjC2sQZxB3TNhn5fOAhC9h4dA1w02B3WLSxF?=
 =?us-ascii?Q?xBy1umZyRABbupEcS5DOZNhuruc/C7NNtA3LClfLfh3QnxBJgA3QoyzXmq4/?=
 =?us-ascii?Q?fWmWTNL5sJQqyjXBVBheJCZZTAN7G1U17SVb4m9nJ89vFbjFKRZ1c+dCXe6B?=
 =?us-ascii?Q?quqVlOxv53j5Ys6G06DRYEVvJJqiy+V9KVksORn7nWNOD1X1dX+19Vreryj4?=
 =?us-ascii?Q?NsjH9oj4mpKwCIHiQCgTieeiV5HsSfXn3dFO+ZDtzcYKkmL9bbj4dKqeO8y0?=
 =?us-ascii?Q?AW5mO8JK8VrKcnnHAJjaWg5a61tQEvDVI6nrmXLaCr7itcF/hFr/eiFuBNOf?=
 =?us-ascii?Q?SuuDbU4uyg0YAQEo4EdoF27bMBmFHaKxHc+y8pVZGkdp3bIt0lZnbWJQOa07?=
 =?us-ascii?Q?Mc43DabYfbzfTyIMeu0Sj8EjTRLfE6h3yVKPFzQLUL00JhfPucbjZqlEyHE5?=
 =?us-ascii?Q?GX2yH+EJ8R3jdzcBH8VYNMrClaSU/WEb4OgJWEXJ7BpaloRVhaWXQXl36F+u?=
 =?us-ascii?Q?GB+Kc49G8/TW0exBg4dUqAhqSyzkWZgevdIDuUpIu746Dh2ff2al7U9aT4J5?=
 =?us-ascii?Q?tZogVKngJfaSRecNycgzvOsqEnmfhYz/WAX/C4X9FNp6qXc57y/Umg9aSzeb?=
 =?us-ascii?Q?455RdWyi5ehFybW1ri/WCXPPGJIgIXU2tFReLM9dhJdSnr+pcLfHWeCD/Vfg?=
 =?us-ascii?Q?Fy/HJCM9QyhVW0Fa4jSEkYMQQ8BN7qeKYLH?=
X-Microsoft-Antispam-Message-Info: ze4GwdDykCfRh5Zl8nAHCt7NZrbtmGrvUifEmeu7kd4w1HMxIyxw1OIkeSzw3M3aljl+2W0ZUXXBfzFnqp/4VuRggrBSR5T8gSSZSLXv7pla+j+PJD/zMJussNgheaCfRJx4FwFgWIuV1SPrfA0D75bsOZtxBQ4hiw/n5drxXm1JDLiYir0XLG5gi5Mgz5fS
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1310;6:NJ+QFW4AeWkRo+mQzX89udO2ey2wipL9XIdxpMCiMJL1/BPvWYzAT6x41LrLv9f6wQLHVv1M1yHwwMxV9bF6u4/kurqeJRgyxA5SN8QC7XqUeA33aNiXUtW9B69Cobd5hG5nnyoFPOr8YCV8wC67wJ19aXQbWMJIQKzvNrTmfROhN1lW5/KebZHtxuKuCmg7lm/T363vOAy30FDGa9NUJT4AA1qCCGz3KdCCjRXX9LYuoQKsLzMIDEwEDIkbgYeIKMFgZQJZb4i/UMzwoGHyiORFdTLYAqWr56ychhi7hddFcE1UpWNsoDXJoh7Ko0Z+ULQAYBSqtEbWDyzqnFWmGWUDdNqDdLUPfLCLGms+Q1EzegZ+/SkX63cAKr+huuG3j3ppSMpFC1fmzr8pY/KrKr7EqBfeMnYjJm2UqHQCIv0OSpIi6ORWOSa6bIXzwHK0l0zQTmg4IByjDlb9kKzFww==;5:ofP3L/iFhobaVtjnZA/zdyR/yh+BQ+pYnl6BKPJJjERi9SPZwhjErHJolTMkOtvfFmVhIK3c79zhZSujMzM7KGB3CBNC5KeEl+aKh9dtvg6GX8NfNrh4/S2cHWdobfwnpRIk4Zr05wyOXDILbyz7hZMOXJ2ZWyA4sPFV/rhPs0o=;24:1QRtDiHE/EFlhutKAO21K+CZtg7Alenqgg4ZFnP2zxNh1+nb+VU6W3+/LfvNt6v5wS4c4Am7tJ8rCbR1loX8bVW5h11cRQec/B813jYrNF4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1310;7:y5hGpm35ndRFp1Ihwp1JrgF5z3451Hj+etdCy3N2eY/awBCpEVGBmn4WheZThPPLyJvZCz5Wjop4XbboJKL6IeHAdmwc9VgTz7JNAjlX/LSFzhCcHw4lgEIdIjBCa4rkql6XBrYOpatA5ioP6VXGeIL8iLF+6v3Sz9G8vwpsydvqsH9KqqywXg9NwnGeWz00D4bap8TiElhc4eJCEgZnQL+LdW30OpmZ2KkXvK/GU2XWArOO8GBWk10VYDzZn13i
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de4ab08-1e99-4026-9280-08d5988600e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1310
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read DT property to check if AXI DMA is connected to axithernet.
If connected pass AXI4-Stream control words to netdev dma client.
It is mandatory that netdev dma client reserve initial memory for
max supported control words in callback_param.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b5235..16fee30 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -418,6 +418,7 @@ struct xilinx_dma_config {
  * @rxs_clk: DMA s2mm stream clock
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
+ * @has_axieth_connected: AXI DMA connected to AXI ethernet
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -437,6 +438,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	bool has_axieth_connected;
 };
 
 /* Macros */
@@ -809,7 +811,10 @@ static void xilinx_dma_chan_handle_cyclic(struct xilinx_dma_chan *chan,
 static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *desc, *next;
+	struct xilinx_axidma_tx_segment *seg;
+	struct xilinx_axidma_desc_hw *hw;
 	unsigned long flags;
+	u32 *app_w;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -821,17 +826,28 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 			break;
 		}
 
-		/* Remove from the list of running transactions */
-		list_del(&desc->node);
-
 		/* Run the link descriptor callback function */
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
-		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock_irqrestore(&chan->lock, flags);
-			dmaengine_desc_callback_invoke(&cb, NULL);
-			spin_lock_irqsave(&chan->lock, flags);
+
+		if (chan->xdev->has_axieth_connected) {
+			seg = list_first_entry(&desc->segments,
+					struct xilinx_axidma_tx_segment, node);
+			if (cb.callback_param) {
+				app_w = (u32 *) cb.callback_param;
+				hw = &seg->hw;
+				*app_w = hw->status & XILINX_DMA_MAX_TRANS_LEN;
+				memcpy(app_w, hw->app, sizeof(u32) *
+					XILINX_DMA_NUM_APP_WORDS);
+			}
 		}
 
+		/* Remove from the list of running transactions */
+		list_del(&desc->node);
+
+		spin_unlock_irqrestore(&chan->lock, flags);
+		dmaengine_desc_callback_invoke(&cb, NULL);
+		spin_lock_irqsave(&chan->lock, flags);
+
 		/* Run any dependencies, then free the descriptor */
 		dma_run_dependencies(&desc->async_tx);
 		xilinx_dma_free_tx_descriptor(chan, desc);
@@ -2602,8 +2618,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
+		xdev->has_axieth_connected = of_property_read_bool(node,
+						"xlnx,axieth-connected");
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
1.7.1
