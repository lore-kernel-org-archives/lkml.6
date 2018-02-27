Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeB0L42 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:56:28 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:49833 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeB0L40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:56:26 -0500
From: Harish Jenny K N <harish_kandiga@mentor.com>
To: <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harish_kandiga@mentor.com>
Subject: [PATCH] mmc: Export card RCA register to sysfs.
Date: Tue, 27 Feb 2018 17:26:20 +0530
Message-ID: <1519732580-2867-1-git-send-email-harish_kandiga@mentor.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports RCA register to sysfs which will help in
reading the disk identification information.

Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---
 drivers/mmc/core/mmc.c | 2 ++
 drivers/mmc/core/sd.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 208a762..d45a244 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -792,6 +792,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
+MMC_DEV_ATTR(rca, "0x%x\n", card->rca);
 MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);

 static ssize_t mmc_fwrev_show(struct device *dev,
@@ -848,6 +849,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
 	&dev_attr_raw_rpmb_size_mult.attr,
 	&dev_attr_rel_sectors.attr,
 	&dev_attr_ocr.attr,
+	&dev_attr_rca.attr,
 	&dev_attr_dsr.attr,
 	&dev_attr_cmdq_en.attr,
 	NULL,
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 62b84dd..17d9005 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -676,6 +676,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
+MMC_DEV_ATTR(rca, "0x%x\n", card->rca);


 static ssize_t mmc_dsr_show(struct device *dev,
@@ -709,6 +710,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_ocr.attr,
+	&dev_attr_rca.attr,
 	&dev_attr_dsr.attr,
 	NULL,
 };
--
1.9.1
