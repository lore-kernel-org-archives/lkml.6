Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDTQiq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:38:46 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:4448
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751227AbeDTQik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:38:40 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bayhubtech.com;
From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>,
        Shirley Her <shirley.her@bayhubtech.com>,
        Yuxiang Wan <yuxiang.wan@bayhubtech.com>
Subject: [PATCH V5 2/3] mmc: sdhci: Add support for O2 hardware tuning
Date: Sat, 21 Apr 2018 00:38:12 +0800
Message-Id: <20180420163812.9868-1-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.174.170.68]
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To BY2PR04MB808.namprd04.prod.outlook.com
 (2a01:111:e400:2c51::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR04MB808;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB808;3:WRGQseZ2TxVHa34gumlFRoixoBkOvi01Dnv1ejU2ivqYHKquwIdWZ8MTDgeusQmNrs47RD9/FhmNx3u83CXAvuKyKoslz0MT85aoFsPkT1jCnBGrGsseWOMqngUYfpUEM1N75fGDZHkwnKAQRnWwbrjhoF1IfcrYq8cNeI4uzU2/UdtgQyEEh8c03zxz7zTqUWiRns3T3oPLB9i9GzdfWdnz/MShHt4KK72axnzX3/0c9yy5wLB32oDzIQjOlonJ;25:hKpRybvctidbaFwAH3YD58QNTqqf9w8Yyd5uH2BvpqU+VpiFLc0+uJ3wvH6261h1+sPNN4shbNrg980mYFwfvxbyfeKOPTqeT/0n1G7XXixhOOj+iv2E9YuiJ5oxab9DaLJdTxhsaznGaOgP9/+HvtL1iul92yPBieegeXRc+EQ+Z6S4QUhkSCbQRsyMMdyZFig/pKhHKQF6dzIezu0wlqMm2ddK2jpBlCxsfdzyo8t2ysEaDanfB/4ublpb+e6oadv9eg089WqGib4b4/51hUwuSDNymNVDVgMCoj/UgsKhlxEbqIJMRvxIQuCCOMOFHlquves/yCizlGcbbqzl0w==;31:/goHqq9T/rxolX493pyXBvcfFqxov26NFs+XzLlGq0fCEzDbVi0wlBRf7Z1Eb2NINqFQLmA4XeQAB1ec4eJc0S929Q9AhJ97bU8jl1tJpOiWD05J2AMcW2szv8NFJYwOHFWO25aXFxq6WXwx5Teg93iqmZuARbbB/aYr/ToqkWQKKmQWvb4uJvkUY3JMzHQMnyKXIaKnZXIygnrZrGXI6XwFfaPxCkXP6IkkW6v3/Ko=
X-MS-TrafficTypeDiagnostic: BY2PR04MB808:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB808;20:KBvfr8rdqrnDlEH38A4OMTchpn+2qR5jRtSKG5u+mVs0CrbvKHCQiimhvFBnYsO4kzKkuRVWT3zJqaXfBkkv7h5Q2xaWl92jaHId3hFj/i9+I/RMuZI03wLfEoD//NvswvKZE6cLs004mwQGQDcvbt0o6cRMaBpbuuc7B7muNpObD9DkOJrVaaIUcOLFZ02LCZ/+6hn7jVqowaQZGD8s35NnxI9djTfOIroMvBDNnS6UxPkWfqdGpP7Ky/7rkzml6Tnohg2GdtTm8LAHPhYsyAeIlB3iZs5tWsp6pFR3EsPDjCTodmlMYuUxrWX7dvWc/X2zou91OirUvp6Xky4Ft9sKJY98PQ0e7yD1HNYYs7cvuF/+yRh63aOsbtFUelHmwyopJWJmLI2iSHIPtDrdxCdWfDa+13wKTJH0FL/ywaU=;4:qlc6r7AnzGPNtYG8QtJLqgqqsMZhFggJOZeYtsnXLNr1SKU9Q4Aaop6gGF9xMJAInHH+ytwgAWHdHx6dg6+MpJR7NEv2xiufVpLg4DGdyBz1LbJd6GX+CF0c5Md7b022gr5rJObUm+/IuwZjMxDqn7sX2u1cQnseDjDqWyrMV4N9a+hh4QCFM+2x+gf/bASh3e0IMRPxcH9DMCDMVkmdwB+Ytf5wp0Z1m0P7XgKMDRAAQpfipQggBFz1233nHinMXEVcfTbhlyzG33DIF9f1ng==
X-Microsoft-Antispam-PRVS: <BY2PR04MB808293B5C24176D64A9390FE5B40@BY2PR04MB808.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:BY2PR04MB808;BCL:0;PCL:0;RULEID:;SRVR:BY2PR04MB808;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39380400002)(396003)(39840400004)(52116002)(478600001)(2906002)(386003)(6666003)(53936002)(476003)(6506007)(16526019)(59450400001)(5660300001)(186003)(26005)(8936002)(66066001)(6116002)(6486002)(25786009)(6512007)(4326008)(47776003)(2616005)(8676002)(50226002)(110136005)(36756003)(956004)(316002)(50466002)(54906003)(16586007)(3846002)(48376002)(305945005)(81166006)(7736002)(86362001)(1076002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR04MB808;H:localhost.localdomain;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR04MB808;23:IvCCIWZbm4gJmezrP/7RqamhtGskKDe3b2f0oYeZKf?=
 =?us-ascii?Q?ciPjyQFORr1Bypt1t9xoNLnBU9z4oh8dzEISvx82vgUeOQvnrkRJVztvlOvA?=
 =?us-ascii?Q?dTkztXcs/APjk0tTI8vvMw4+mNPUu0SbiJtgMJrWF4DGObyoBm5Eq2w1UgxN?=
 =?us-ascii?Q?GeG/dQTbGknbsfIf3Cw9TlmaujWt4S1/4mgwxybBazHOvsdgAPPRM1BJLNbn?=
 =?us-ascii?Q?xTl+PmnB+x6CB196drIlVLWuo3U15A9yCVvn81QR/+LVM0JdzLrJbtw8K4pT?=
 =?us-ascii?Q?vYPFCXl5fq0E8Ca5l8K9vISlxVpBMVgNpHAlTuvdALNgMPKWp7+y8DvvgRZL?=
 =?us-ascii?Q?FQyxJq3BlcXEsmkRCQ5lJkVmVBo7imB0I5Z4NBvHnIJUvWUnB5wtrABttLKY?=
 =?us-ascii?Q?ZRVX3+hs2CkGZsov8Pcn9C0PYGIHB2HZRcoAdumjOE+0fXzdne3WMOaf8NGB?=
 =?us-ascii?Q?WVEg1kC3Cusb9EtCbVAbANsJ9be/LU8WrbNec1nvW3xd+Sixd0UwQhsh0/0X?=
 =?us-ascii?Q?8sZ4QlPCD9nf7q4I3+WQR0svHcKSP08nfzj/B9T5O1+kcnDaDIXq5k7Aodpg?=
 =?us-ascii?Q?tMzyKL37gxqqM5QxMTe3Tb/vn8NI/0WK8G+hY45jpNaQ8U7QwSZnEz5YfUXG?=
 =?us-ascii?Q?RgHleLao08g2hV0bcgwQZ8KJY2b4hU1sh40gjoI5XhUbqKAf2MtbVTBH07/s?=
 =?us-ascii?Q?oE3lNRDzRIolh+uVmf2kLrMGVHhXYt0/FSt8V4Cc8r2pvH95LBT5MySAD6yM?=
 =?us-ascii?Q?odfJmglK3PSW+v08OKr6kmVADcQF6/vy5VoTO9HIvoj/QncyEVABI02aLzRE?=
 =?us-ascii?Q?Jb2Ai1EIHoLoPPgwjOP1+8LMeLNbYd6PduwnS9P+DTvx6PfyUhEPIa7BdGVa?=
 =?us-ascii?Q?VS5soMaDiYAdMhj8r2Mo0hebRvoRyp90jBwk7K/wrlyK1cw72JKm+LQrqrQ7?=
 =?us-ascii?Q?OnNVh5JhS6s7anV9VO62l8a1B7Bg4zC7Y6TKf1cDw86nvfK+XTrlVBBrBcEL?=
 =?us-ascii?Q?7DE18qRYxP83rLhmit96Di8IZ15hOv+KtPa/FUTuJUbw=3D=3D?=
X-Microsoft-Antispam-Message-Info: cXRartcsYSQU+zaBVsFhyQzcZ9dGyge+PCdlny9h5b0NeEfDGYT/Tlyg/TgGYsNWCo5NJX164D7KyuYW1C9Tp8e8hd8AZeA+dk+IhV8zb79oFbiyAs2Y43b/M8Ept/JYZlfwAa+3vBs39MFqhriyNxkuA2d394vmur3DpMUB4EXMjuGHA8L+okdI/aRAUu8d
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB808;6:dDhKvsOeKsdGDPYmPiSg5BTDrtaAvV21cji3NWuZp+n/WBRXDMtklpf+jBbJFnxBrT/6luSzXCIfHw8n8XpJizP+nAGICsGUUuYCwUOQjbspJSPdy+1sHJEf2LqPMsCtQHGNdj+3d/qnbIqP8SZwk4mLYpTe4E6R38M7RShIctogbLFtORVL+oCRyIW7YrIF/xUtsCGpHz0n1dIYcLKpKKPNffB98Mhy685MvqZ6kVkhJYLXqUPyvS0bgqP1UXPh/6d6RcPYHZRK8H/j0QskRtsy3po4wfQwRjZnMWE3XvjgOrLsJhkTEl732s2AlJOgp5aQHPHuylJNXGVF8C3o0W6uMHtBxNQINgx3J42GkkOUJKUv49ZRKEq7m3lcjjQjSWGb6cQIL3NPS4l0/g8Wnz3FAeKjiZPiRq5fJans0+tcignDuL1G3J+jkw+25CdZgNa/iicM1ycNTkWsHtI0yw==;5:YGyGJ5ahtaw6vZW3eFa26vmSSv/sDqtSkvx/Dzf0bc6khHYlspFdYGNtetFX6zEfkmUqKimsPHiWLiLThtglUSCwQSAlYxapdfk6ai+NcMrNCoJUVZwDss32www5znp8bgrpx9MDp6+PTAW9mb9xlDjOf6qfb91um9aoBP0FYjQ=;24:kmJFtqgFKIE6aqge9KmyC+puM1ZT4slg1CqfTWZJ/HIH+ck6W9qqE5ugU5dIyHQ9y7F6yEDZZNyRPj/bCJNsGUbFI2QrzUzJf6UlEOeH7ZQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB808;7:q8V02YI4qqbtnwiQ7Uogb9jkOmHD9A30IgMIoHmnkepRMRiCITlpN6dg10ERmDcNhckPMF5wmz/Gn2gwQG6aGKhAa7dcpwtEHBsMQFcjW7LIxbPly9xxrhwfVIH2r9XZ3YbqwEQZtAu7dowhMDvX3g09yPi2TCTB26OP6dm8lEHFxYXtVF11gvz02EwEIuLRhybei18sa033eYOaq49AK0ezqEbK7zqm/ErrDKFIGjpHgBjqOe2ckSOZXG4Fz9N7
X-MS-Office365-Filtering-Correlation-Id: 69112c22-c103-4c4f-f2b6-08d5a6dd2b1e
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 16:38:36.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69112c22-c103-4c4f-f2b6-08d5a6dd2b1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR04MB808
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware tuning function instead of software tuning because O2/Bayhub
SD host controller support hardware tuning.

Changes in V5:
	In function sdhci_o2_send_tuning, mrq.data should set to NULL for
	cmd.data has been set to NULL.

Changes in V4:
	Patch V3 delete register SDHCI_TRANSFER_MODE write operation before
	send hardware tuning command in function sdhci_o2_send_tuning. This
	is a mistake. The write operation is essential for tuning command.
	Add it back.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Add many functions to execute hardware tuning for eMMC 1.8V HS200
	mode, the hardware tuning procedure is based on O2/Bayhub hardware
	tuning spec.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 175 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c             |   5 +-
 2 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index ba59db6a..96adaae 100644
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
@@ -55,6 +58,176 @@
 
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
+static int sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct mmc_command cmd = { };
+	struct mmc_request mrq = { };
+	unsigned long flags;
+	u32 b = host->sdma_boundary;
+
+	cmd.opcode = opcode;
+	cmd.flags = MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
+	cmd.mrq = &mrq;
+	cmd.data = NULL;
+	mrq.cmd = &cmd;
+	mrq.data = NULL;
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
+				mmc_hostname(host->mmc));
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
@@ -215,6 +388,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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
