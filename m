Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1040BC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068720645
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545321621;
	bh=B6Be6/3tlXlsPyKZ2FEt5ea0xfP5/tm6Ccc363ZumBU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HtNnPTNQsWDBl/sP8ieN30Av+zA70BvqnRLFrs/Y0+speaNu4zijvDTbVUhtH97XB
	 r5+BBTTBxBLzYPU46V/2Xq1exK/zFJdvD/Wa1XM6sK2Ic9f9OjA5h/Kuoi7mov/at7
	 otTTjqBQsMznzt0u2yn25BT5Y2QMzh1AlPL17uXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbeLTQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:00:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbeLTQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Uuoa3NhYq4vFpaFc2DIiyNLD3tTAH4NYhdXbJjzmKbc=; b=IDjO3aLCh8sL
        pH1MDst5JlkwEsv6Q01S3cdH+BscSO8mGJDQZCmnFEsENuKaGoejGzQ8gQ7Ryo9/tNtq9ck+tSCxn
        pVEyndeJGUmk4y6/InBkSbU4xd2sAmBmONCpXLAoCEOXYDrTjZycXi8b1/Yn8kpu/2z+n4gXdnJui
        KXxZ0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ga0kE-0003rC-7n; Thu, 20 Dec 2018 16:00:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E5F231121B87; Thu, 20 Dec 2018 16:00:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: convert to DEFINE_SHOW_ATTRIBUTE" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181220160017.E5F231121B87@debutante.sirena.org.uk>
Date:   Thu, 20 Dec 2018 16:00:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: convert to DEFINE_SHOW_ATTRIBUTE

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 3e60b4fc86710cd2095628c67b296e7cc4b239c1 Mon Sep 17 00:00:00 2001
From: Yangtao Li <tiny.windzz@gmail.com>
Date: Sat, 15 Dec 2018 03:21:48 -0500
Subject: [PATCH] regulator: convert to DEFINE_SHOW_ATTRIBUTE

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         | 37 +++++---------------------------
 drivers/regulator/dbx500-prcmu.c | 35 ++++--------------------------
 2 files changed, 9 insertions(+), 63 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f211aa7da44e..0e402606e8be 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5278,23 +5278,8 @@ static int supply_map_show(struct seq_file *sf, void *data)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(supply_map);
 
-static int supply_map_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, supply_map_show, inode->i_private);
-}
-#endif
-
-static const struct file_operations supply_map_fops = {
-#ifdef CONFIG_DEBUG_FS
-	.open = supply_map_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-#endif
-};
-
-#ifdef CONFIG_DEBUG_FS
 struct summary_data {
 	struct seq_file *s;
 	struct regulator_dev *parent;
@@ -5516,21 +5501,8 @@ static int regulator_summary_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int regulator_summary_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, regulator_summary_show, inode->i_private);
-}
-#endif
-
-static const struct file_operations regulator_summary_fops = {
-#ifdef CONFIG_DEBUG_FS
-	.open		= regulator_summary_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-#endif
-};
+DEFINE_SHOW_ATTRIBUTE(regulator_summary);
+#endif /* CONFIG_DEBUG_FS */
 
 static int __init regulator_init(void)
 {
@@ -5542,12 +5514,13 @@ static int __init regulator_init(void)
 	if (!debugfs_root)
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
+#ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
 			    &supply_map_fops);
 
 	debugfs_create_file("regulator_summary", 0444, debugfs_root,
 			    NULL, &regulator_summary_fops);
-
+#endif
 	regulator_dummy_init();
 
 	return ret;
diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index 8976141c1438..308e3ff0a1bd 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -75,7 +75,7 @@ static struct ux500_regulator_debug {
 	u8 *state_after_suspend;
 } rdebug;
 
-static int ux500_regulator_power_state_cnt_print(struct seq_file *s, void *p)
+static int ux500_regulator_power_state_cnt_show(struct seq_file *s, void *p)
 {
 	/* print power state count */
 	seq_printf(s, "ux500-regulator power state count: %i\n",
@@ -83,23 +83,9 @@ static int ux500_regulator_power_state_cnt_print(struct seq_file *s, void *p)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(ux500_regulator_power_state_cnt);
 
-static int ux500_regulator_power_state_cnt_open(struct inode *inode,
-	struct file *file)
-{
-	return single_open(file, ux500_regulator_power_state_cnt_print,
-		inode->i_private);
-}
-
-static const struct file_operations ux500_regulator_power_state_cnt_fops = {
-	.open = ux500_regulator_power_state_cnt_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int ux500_regulator_status_print(struct seq_file *s, void *p)
+static int ux500_regulator_status_show(struct seq_file *s, void *p)
 {
 	int i;
 
@@ -122,20 +108,7 @@ static int ux500_regulator_status_print(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int ux500_regulator_status_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ux500_regulator_status_print,
-		inode->i_private);
-}
-
-static const struct file_operations ux500_regulator_status_fops = {
-	.open = ux500_regulator_status_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ux500_regulator_status);
 
 int __attribute__((weak)) dbx500_regulator_testcase(
 	struct dbx500_regulator_info *regulator_info,
-- 
2.20.1

