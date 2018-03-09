Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932214AbeCIOFd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:05:33 -0500
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:59279
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751120AbeCIOEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:04:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com;
From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        yuxiang.wan@bayhubtech.com
Subject: [PATCH V4 2/3] mmc: sdhci: Add support for O2 hardware tuning
Date: Fri,  9 Mar 2018 22:04:24 +0800
Message-Id: <1520604265-4430-2-git-send-email-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
References: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [27.16.214.154]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com (10.170.154.33) To
 CO2PR04MB812.namprd04.prod.outlook.com (10.141.226.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b1f62d6-9883-4181-092a-08d585c6b758
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CO2PR04MB812;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;3:tEj7eKxa6oG/DsbLkvVMD4UMeKWWOauz6qudXFG6+N9pdmtRgPTMOcPt6hWTAprk92m86N/Ld7fWJwnPgltosHn2MTxyRIDMEpj95ezLoKjwz5keZdTP+hqFGO7zUbqIZWdd5OjRaKWIdgHUYQu4xb6/VZGePtgkBCd63r11DYULKB1SRmKdMI2wC6wsQqmkf/YzT842C40LnmjqH1bxf9EAw0oo3t1POrVu5M09sJJ8+642L3xKwTJF3GHrxhcC;25:e/Ac1tjRVARYQiUFTA6JEuxt3UH1tqwr3OVbFPFm73d4fK1coz8AIiP6fskmRA6O5CiihKpbk0+vfBcuX3thqhUQj9+fU7ZHo6GtXB9V20rokTbEElLG4dgkbmAqGh9LjKierExcI9Mexr17h75IX0t6ho0sz7pDbpRrTOYRcyocnfSkQyXZQj/NPK3K1EPae0TA6m9JjLErYHI+NHajEfDvc6EHwa6CZGnF6PdYD0qnJWclUZvtWC5yGnDEhIPRnhwg4b8pcp0Mb6Et3xsh/McJz4GEb5fy4LL2CfZbMN3YmIYWt7UC4usmCH8xL26+J0MO/acM0/mW/i0Ri6b8EQ==;31:Pszdd8gxlDs1XgUJIiOS8fSFmhwUdxAM6YFhzbXyNeBATkacEigc3FVvErL3LkoANYeIXTA2NgE73BANMUTPeiL0BtBMzlCPSYejb82nLcm2PkZTLQ0QZ5qIvuiLDzbtJVSxtqCtk9crJjJ6VB5ViUd0L9KOu3Hj/XrxfkPFwg5MWa1J1fMAVAFPPW1JJZHKTsAgmD6vrIpGnrBsGEfDce0GpfBOMkyeQNz7TfNgFHQ=
X-MS-TrafficTypeDiagnostic: CO2PR04MB812:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;20:06l6O6BpYmM4yGdt1pUjef8D9PT9BImfwQXrL3rRIPJtNcMDVgoDrHZ80hoydw2LtKw2ge6iB0f9Ph5vRMlTWoLMrCY65qPToapfwWCpY9Aprjw/VpZcRCQpDkZVQvi1uDXh3kByJ0RrEWyvovltBnrJHNfdec1sLjJfESU104xE7tJmVVQx0oaHuWEkltbi5DyeQLP5TAXI5HdY1Wx6zIhgjW7hJvUM8eEIbcSzUQppoka8hDc+eS79VyRZdKTcelzF1lonNngTpBVoUWFeWE++h16+Wq5sRtkdtznc90OZYrsqmNNUp1lFNTO+cMUpfqtOoAA/udtzDTY8oPAE5OgQ8xQBnN1pWaWF66wdSwJfE0v0OzsD/VQ+TB8Fnq6xI3u903wC2UxerzHMM2o9jd9zeIPyh+HbeikdYwzYvCk=;4:9io9X+kkno9I1xfCo1uWxPcg/GMJq2gaDa2YY9X9evFTwN/owUPwr7o3WErLd/WIRQBLBB+Cs8ajcgb9ydi0CSWkJmnFGgPuP54SamFba0E9wJ4x73VPeum+AGcGZp4jntq++hWBWEzeDYV8SJ0u6Vf3yGL5M1hRct2MEzcKMoodz0oKrvDu5fgylFDNMXWOp53xBcRc97VyhUv3XE423mbWh0bGUfu8TtW8vsL9I7oAzLHvY8QOFldc9HoOk0qG2HaQrEqIKlg0BeJZev3GPw==
X-Microsoft-Antispam-PRVS: <CO2PR04MB8124AC2D1B424AA0CE5FEC3E5DE0@CO2PR04MB812.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:CO2PR04MB812;BCL:0;PCL:0;RULEID:;SRVR:CO2PR04MB812;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39830400003)(396003)(376002)(39380400002)(366004)(346002)(199004)(189003)(97736004)(105586002)(6666003)(2950100002)(48376002)(7736002)(186003)(5660300001)(47776003)(107886003)(16526019)(3846002)(6116002)(50466002)(305945005)(76176011)(6512007)(26005)(106356001)(51416003)(52116002)(2906002)(68736007)(6486002)(53936002)(386003)(6506007)(81166006)(8676002)(478600001)(86362001)(110136005)(81156014)(16586007)(59450400001)(36756003)(50226002)(316002)(66066001)(25786009)(4326008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB812;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR04MB812;23:ZxZs/itehdqYpWCRzouvAQSaebPXL1VQa49k9MB7SQ?=
 =?us-ascii?Q?pbHPl6qsaUcuxSODtSlwtnDWVtlPgM7PSpHn3BkjwUO+Xh7YM2wC5uIhzOni?=
 =?us-ascii?Q?NR1ZqvKuIj1sCWz7UDxfkKy6rxaQKiDBF8lbQPUx77limn5Bvif8KIwHAbg0?=
 =?us-ascii?Q?xSLT6TeeIcTNETZQ2JmtNpTMp3lc+obDoS0Y/X/amKnnBNDSz3jf4ZhErJJr?=
 =?us-ascii?Q?vRJZLvcwQQqRy0KtnFZUHiPOgWXjBAz+O85b/aT7LyxRUr+170TmG2EmmvXi?=
 =?us-ascii?Q?moQlFqCSOnmAReBMluTdBuTrpY83yMGBeNeXkWrHyK6M//iPS//UXue+KNm0?=
 =?us-ascii?Q?YR4WzBCA+oLAmGlbPfSCV+88baerGMPTKgxN9Linxi2fj12jsvjRE3ZdLxWO?=
 =?us-ascii?Q?t8ZEtiZWqPYrKZK9MYfAQfwQ8xiEywHQZcr/0J97Myhjx/c0zNknUITVHyqd?=
 =?us-ascii?Q?Qy/YtFr8QtsOohcUqHGsnJvahdx9c9WME4OsOjw3hWOc8FWB32I9jjGve7AO?=
 =?us-ascii?Q?8KL6xG7IHiRopcbE7yKy/SWortsUUIFLNtFQmQ8M71W4oyiody8Cf9T0B/22?=
 =?us-ascii?Q?SprbiU6xkwzuDt987VbXtoJYhUrbG0E8McEwV0X3IspUz4owVj7+y+so+6Tr?=
 =?us-ascii?Q?LMmzqnsEsD3tTOQmYwyG7ECG7ykq6FsJclAZw8QalHaEVDH4TXdDFlNOq6e6?=
 =?us-ascii?Q?nCKNipPrLawK5HYSRZQRtGE7uRW5P1kQJIJagf9Mha893YX/9sDZ+/2+EfgR?=
 =?us-ascii?Q?WEYc/53xrhEI0Gty/98XUpmv6d/8RtZ111Kt6t6Y1YVFtH9N4UA14BgspDPO?=
 =?us-ascii?Q?zytttZ8QCSjFEzlBY9QmfdcW0cvHIoIXYhZI7nTGA0rk+e1PdgKWUfbtiTmh?=
 =?us-ascii?Q?EC/JNT//GjX0sJANpIC7r1FVisCAC/r15e8rJAfgZYuzOUNn1xFgTtCQNc3n?=
 =?us-ascii?Q?pAZjWV77p6CGSNntSHoXfiKzNcjZ5viHpeL7XMmP/OwFFAObhr+9+U96d+YN?=
 =?us-ascii?Q?qmpPFiI3Ya69aw+tEqYq8kWFKSf3J2n+bcCMV+4YETUcupNMuHjVFTKxX319?=
 =?us-ascii?Q?3td8uacDiYKUN4OGPrlLzq8XSH1XXIBxbi/7tVN2a5wWZxWw2jBhl+t7y3MA?=
 =?us-ascii?Q?wn7ysg++KWnUBaUI6Wkg1kyJz9mi/Jfe71J2BrMSh1zcD5ITk7eg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5jBiPkMQbTu/84dqeGa4S7+TBVciPxISqbt3TMP3fh8mI+nL6jKJRIhvxpPKzdKiKBioN2hJxkfPUPObc+CUUARyiVRyhKvsjiSgbM/W5zxSpiALoFxz2QroegI5+NMl6/OEM5pEQMuiOUhUlKXblPq5xphq2HdCZPfzM+m/LDT+Cor9gCFTcD4AVPy2u6W6
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;6:WOWREdWREHQyyqXaDMcm8yqOrsfN4Du2V79LRdycnSh9FlPLUvi8KVvxuK9CRcr0MaDEe9FnBUbJuImeSPFBGwITGeeBwENCpB+AzBJc24mC1XRcBRnfZp7as2buSwfdsS6lT73SFspFt+BC5AYyn8CMoT9a9i6zQHar2n8RBqTUrsU9yXiYN9ePXrOU88dPLRs5I74bvDIR3qKyzWcVqiXyFyhgb9KgYrv3yVooRfzXVBeL4k1SdPkp1x+O0VkXGBRgmeU+fW7vGMOlwc1iFG7bj9P33zHrjTaEvED6FL8iZVTROjUDJCg5iL5HlN1+CnwKA4UAYMVCOz4lXmWzLqkNNo4XtzrqBxi15eGI6z4=;5:ZbD7c1mZvSwHrTD7wgy7Vcudhw5KuuDXbkknlEQCAa8TTQC0OAUM3oapl/UpuiWtNhLQEN3ptfr79m0BEzLaQA6zskTnPXGSQD5oA27FwAq3fs0Jj36qqQ8qSGHzSbd7B817NaxZBRzOUndVRcRc+C7klhInxffVoOR13/B/w2s=;24:I51hYqQRv3YBSm0/SXTe2OhAXH+oAEdDAINz9uamO9m4gFHAiP9laVG8ntoWxBfolEZVCeYTHGg7DmtcdMLNkw72U15UNjexQVt5OWI+w3Y=;7:RtudjGJaSJi/LHV8Bspa0yRPp6zJtNXufUADf5HHWiE7k92DSTtKBfCkSsV/RgNsc0wkebq8QvbAWafM2JSeqXA64Y6RgR8zR+QcoDU3rJqDOE8LY2unrir/zKEC5neB99vNA2A3UKUOpB73kko/7dp+JqGLI5ndArKQULLkOJJi8TlK5PSF9ke9uqXrL4bC4CMcnh7uwS/IhvjnhR5hGc7Rv/YoxqN44yT9s76Yotafg0YRkw0u+n8giAIdsjYf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 14:04:45.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1f62d6-9883-4181-092a-08d585c6b758
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB812
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware tuning function instead of software tuning because O2/Bayhub
SD host controller support hardware tuning.

Changes: Add many functions to execute hardware tuning for eMMC 1.8V HS200
mode, the hardware tuning command and procedure is based on O2/Bayhub 
hardware tuning spec.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 193 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c             |   5 +-
 2 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index d465751..a918984 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -17,6 +17,9 @@
  */
 
 #include <linux/pci.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -55,6 +58,194 @@
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
+#define O2_SD_HW_TUNING_DISABLE	BIT(4)
+
+static void sdhci_o2_start_tuning(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+	/*
+	 * As per the Host Controller spec v3.00, tuning command
+	 * generates Buffer Read Ready interrupt, so enable that.
+	 *
+	 * Note: The spec clearly says that when tuning sequence
+	 * is being performed, the controller does not generate
+	 * interrupts other than Buffer Read Ready interrupt. But
+	 * to make sure we don't hit a controller bug, we _only_
+	 * enable Buffer Read Ready interrupt here.
+	 */
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_o2_end_tuning(struct sdhci_host *host)
+{
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
+{
+	return cmd->data || cmd->flags & MMC_RSP_BUSY;
+}
+
+static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	if (sdhci_data_line_cmd(mrq->cmd))
+		del_timer(&host->data_timer);
+	else
+		del_timer(&host->timer);
+}
+
+static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
+{
+	u16 reg;
+
+	/* enable hardware tuning */
+	reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
+	reg &= ~O2_SD_HW_TUNING_DISABLE;
+	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+}
+
+
+static int sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct mmc_command cmd = { };
+	struct mmc_data data = { };
+	struct scatterlist sg;
+	struct mmc_request mrq = { };
+	unsigned long flags;
+	u32 b = host->sdma_boundary;
+	int size = 64;
+	u8 *data_buf = kzalloc(size, GFP_KERNEL);
+
+	if (!data_buf)
+		return -ENOMEM;
+
+	cmd.opcode = opcode;
+	cmd.flags = MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
+	cmd.mrq = &mrq;
+	cmd.data = NULL;
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	data.blksz = size;
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+
+	data.timeout_ns = 50 * NSEC_PER_MSEC;
+
+	data.sg = &sg;
+	data.sg_len = 1;
+	sg_init_one(&sg, data_buf, size);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
+
+	/*
+	 * The tuning block is sent by the card to the host controller.
+	 * So we set the TRNS_READ bit in the Transfer Mode register.
+	 * This also takes care of setting DMA Enable and Multi Block
+	 * Select in the same register to 0.
+	 */
+	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+
+	sdhci_send_command(host, &cmd);
+
+	host->cmd = NULL;
+
+	sdhci_del_timer(host, &mrq);
+
+	host->tuning_done = 0;
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	/* Wait for Buffer Read Ready interrupt */
+	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
+			   msecs_to_jiffies(50));
+	kfree(data_buf);
+	return 0;
+}
+
+static void sdhci_o2_reset_tuning(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+}
+
+static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+
+	sdhci_o2_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+
+	for (i = 0; i < 150; i++) {
+		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				host->tuning_done = true;
+				return;
+			}
+			pr_warn("%s: HW tuning failed !\n",
+				   mmc_hostname(host->mmc));
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_o2_reset_tuning(host);
+}
+
+static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int current_bus_width = 0;
+
+	/*
+	 * This handler only implements the eMMC tuning that is specific to
+	 * this controller.  Fall back to the standard method for other TIMING.
+	 */
+	if (host->timing != MMC_TIMING_MMC_HS200)
+		return sdhci_execute_tuning(mmc, opcode);
+
+	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
+		return -EINVAL;
+
+	/*
+	 * o2 sdhci host didn't support 8bit emmc tuning
+	 */
+	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		current_bus_width = mmc->ios.bus_width;
+		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
+	}
+
+	sdhci_o2_set_tuning_mode(host);
+
+	sdhci_o2_start_tuning(host);
+
+	__sdhci_o2_execute_tuning(host, opcode);
+
+	sdhci_o2_end_tuning(host);
+
+	if (current_bus_width == MMC_BUS_WIDTH_8)
+		sdhci_set_bus_width(host, current_bus_width);
+
+	host->flags &= ~SDHCI_HS400_TUNING;
+	return 0;
+}
 
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
@@ -215,6 +406,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			}
 		}
 
+		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ededa7..3bf6117 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -955,7 +955,10 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
-			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+			/* must not clear SDHCI_TRANSFER_MODE when tuning */
+			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
+				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+			}
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
 			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
-- 
2.7.4
