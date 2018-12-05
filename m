Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E013C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB0B2082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0B53JE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB0B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeLEPM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:12:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46960 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeLEPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:12:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so10185883ply.13;
        Wed, 05 Dec 2018 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VcTBz6eJaIMpdcw4cxJ10GC15uk7L40/kiF3CidAQD8=;
        b=E0B53JE69uJYpRgjYfbGtOxswAKQjx/oxCkiu6xdsmEvfoIBglm/TBTRHK+UrF9rPU
         i6OThLM1qgLTdxoaIoGIwvJ2z0PVRRzeCu6qZ+jJ8+Dx3bB3tFmC1pa+kZN+/GTPR7JY
         DDiMKs1a34f19VuYMJkqTSGuNOzNMLYo+P2YoLu42nFzcZhzit6Vz+vgXRZog7Y3IApC
         D5lxfhuYr/PnOStMzyZ8gkt0TIw8HDgWUKp9QmENJAgpBwfm0+++O3Rg1jtPg6nM4STc
         /heSSWOpxFwCvSn2uBVxokXaBMdSJFoXA1A5+7IbRxqvDkxonoYHQo/kXfIp30k82RYK
         TCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VcTBz6eJaIMpdcw4cxJ10GC15uk7L40/kiF3CidAQD8=;
        b=GnEx15T+tMXzar09Kp7oDtqEhCNdvzYoMzHSeuCyAeXzZIHDWluGw6hYxJscdkEO4F
         SQNfo3FslmXu2/pgQkr23DGZLUWDQmFhu8nye9qHViSJqKu2u/9gGCcLKGfB/BfiJMOR
         QuDIH4fZvmiW5q70QYfzIsB6qdRhYiCg37a5gDcykFF7mjpGD+q+Xp37rPm5xtC3xUOz
         LJ69UoeWODqID1HrglRSs4HaCDqukxbbiNL2I3JFlvZXMvwhmJpNomZXzPKD3uXZajvR
         oM+FqHgSF9qwiFp17hfzU2HNhfVYwmmpxpDExSOTi4qg9Ickpwns5JBJ3fMPbpKmx8qK
         +PJg==
X-Gm-Message-State: AA+aEWbC6xDjHxQTFzcjsKfAXMRSc+7qGYTWsx1yU8sLkY8yyJg+8uIh
        LjdzENtxKfhgnNPZA8c8WLI=
X-Google-Smtp-Source: AFSGD/XYftKr4N73VZXyP+Tef6H+OVSA/E30tCWVSNxWhjpapqIQg75+nyxTRmRaGUfl269AJ9ff4A==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr24949776plm.154.1544022778047;
        Wed, 05 Dec 2018 07:12:58 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t29sm34624765pfa.158.2018.12.05.07.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:12:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] platform/x86: intel_pmc_core: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 10:12:54 -0500
Message-Id: <20181205151255.15367-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/platform/x86/intel_pmc_core.c | 49 +++++----------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index eba6f5c27e2f..22dbf115782e 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -367,7 +367,7 @@ static void pmc_core_display_map(struct seq_file *s, int index,
 		   pf_map[index].bit_mask & pf_reg ? "Off" : "On");
 }
 
-static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
+static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	const struct pmc_bit_map *map = pmcdev->map->pfear_sts;
@@ -385,18 +385,7 @@ static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-
-static int pmc_core_ppfear_sts_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_ppfear_sts_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_ppfear_ops = {
-	.open           = pmc_core_ppfear_sts_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmc_core_ppfear);
 
 /* This function should return link status, 0 means ready */
 static int pmc_core_mtpmc_link_status(void)
@@ -428,7 +417,7 @@ static int pmc_core_send_msg(u32 *addr_xram)
 	return 0;
 }
 
-static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
+static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	const struct pmc_bit_map *map = pmcdev->map->mphy_sts;
@@ -480,18 +469,7 @@ static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
 	mutex_unlock(&pmcdev->lock);
 	return err;
 }
-
-static int pmc_core_mphy_pg_sts_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_mphy_pg_sts_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_mphy_pg_ops = {
-	.open           = pmc_core_mphy_pg_sts_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmc_core_mphy_pg);
 
 static int pmc_core_pll_show(struct seq_file *s, void *unused)
 {
@@ -527,18 +505,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 	mutex_unlock(&pmcdev->lock);
 	return err;
 }
-
-static int pmc_core_pll_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_pll_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_pll_ops = {
-	.open           = pmc_core_pll_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
 static ssize_t pmc_core_ltr_ignore_write(struct file *file, const char __user
 *userbuf, size_t count, loff_t *ppos)
@@ -729,7 +696,7 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 			    &pmc_core_dev_state);
 
 	debugfs_create_file("pch_ip_power_gating_status", 0444, dir, pmcdev,
-			    &pmc_core_ppfear_ops);
+			    &pmc_core_ppfear_fops);
 
 	debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
 			    &pmc_core_ltr_ignore_ops);
@@ -738,12 +705,12 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 
 	if (pmcdev->map->pll_sts)
 		debugfs_create_file("pll_status", 0444, dir, pmcdev,
-				    &pmc_core_pll_ops);
+				    &pmc_core_pll_fops);
 
 	if (pmcdev->map->mphy_sts)
 		debugfs_create_file("mphy_core_lanes_power_gating_status",
 				    0444, dir, pmcdev,
-				    &pmc_core_mphy_pg_ops);
+				    &pmc_core_mphy_pg_fops);
 
 	if (pmcdev->map->slps0_dbg_maps) {
 		debugfs_create_file("slp_s0_debug_status", 0444,
-- 
2.17.0

