Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DFFC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23F2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLEGpMps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F23F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbeLBHcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:32:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46337 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:32:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so4849197ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VYIeEXU9neiBUwJx/pKBhXUu0MZ5ElRRlsG+jOLiyqs=;
        b=jLEGpMpsUVNHMjrMia9qhg8lYk0W/uFQ5brRTEySHmtQrMZ/Uo9i6i4orl6MZEe2O8
         Z9j806cszp596ivwrytlKrBgvO3N0e1EHt+wjdXXGxjqUyU+VHy6jJ3SYEv/+dSVbspx
         fRQIdAq0g5IEopMyojmDPOCSgjz/1IlRAiNDr3peylOx1EopVzgrBq6Vo7IDOCLfexc7
         7Eq+3S29GuSAIFCCNZ6YXxxqygywTYb7YUCtYFuRt+HOdFUv4aNy9tWwJyD2+AKdN4Va
         wr1wJXPMYDcj2f+7rF+tGuvGwHSWzgSoChVS3ZUqD9u/KdK9WoWr2b21c480DX+zb2hZ
         dPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VYIeEXU9neiBUwJx/pKBhXUu0MZ5ElRRlsG+jOLiyqs=;
        b=LEyS9HP5rGrqMubbh0ZVE2LWe3pRyhen8se0DYUv8D3/qYMHknFTKkgFtv9DI4F/sq
         puypS6+gT2LSlHeRcmchvMrEqp78zo2kO5T6KPBOsbvdYYTUxRpLIadcx3VJSkMDkUui
         ki32h0irtsvinV8wAGYiduknpXS8RWi0Vld/m9IHIkVjHGq1JCki8IZNq9uQ7cg4gdRD
         Da7EL5BNIR3SdVAz4keLu3PeBHQoaEHEhVMooZItmG70dgiRCT/WG6DejUNjxNdv5Zak
         nwFrxlUNLGd+gmO/+kjJ/AkjzE1/gm8ZUVwkowlITRAkLgYZs2T6X5/Rik/68v0nKNAH
         TeZQ==
X-Gm-Message-State: AA+aEWa66ePt7VXOGMLY0F/NyB6w6WRuadXXwQ2vxhHNm9Lnfg+DYvIE
        9ig8tkwYjynn1HEp5TnECYU=
X-Google-Smtp-Source: AFSGD/Vjh33QMi37U3pMv1FVZ8tkZi2woNJhty6MCeGK72su+iJG1Sbe2gcqbUiM7Giu3T5AIPWJtg==
X-Received: by 2002:a17:902:7c85:: with SMTP id y5mr11499138pll.63.1543735924874;
        Sat, 01 Dec 2018 23:32:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 64sm12602003pff.101.2018.12.01.23.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 23:32:04 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robert.jarzmik@free.fr, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        keescook@chromium.org, shreeya.patel23498@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3] mtd: remove DEBUGFS_RO_ATTR()
Date:   Sun,  2 Dec 2018 02:32:02 -0500
Message-Id: <20181202073202.10587-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
such a macro,so remove DEBUGFS_RO_ATTR.Also use DEFINE_SHOW_ATTRIBUTE
to simplify some code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v3:
-remove the blank line between the function
 definition and DEFINE_SHOW_ATTRIBUTE()
---
 drivers/mtd/devices/docg3.c    | 16 ++++++++--------
 drivers/mtd/devices/docg3.h    | 11 -----------
 drivers/mtd/mtdswap.c          | 13 +------------
 drivers/mtd/nand/raw/nandsim.c | 17 +++--------------
 4 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 512bd4c2eec0..4c94fc096696 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1603,7 +1603,7 @@ static void doc_unregister_sysfs(struct platform_device *pdev,
 /*
  * Debug sysfs entries
  */
-static int dbg_flashctrl_show(struct seq_file *s, void *p)
+static int flashcontrol_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 
@@ -1623,9 +1623,9 @@ static int dbg_flashctrl_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-DEBUGFS_RO_ATTR(flashcontrol, dbg_flashctrl_show);
+DEFINE_SHOW_ATTRIBUTE(flashcontrol);
 
-static int dbg_asicmode_show(struct seq_file *s, void *p)
+static int asic_mode_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 
@@ -1660,9 +1660,9 @@ static int dbg_asicmode_show(struct seq_file *s, void *p)
 	seq_puts(s, ")\n");
 	return 0;
 }
-DEBUGFS_RO_ATTR(asic_mode, dbg_asicmode_show);
+DEFINE_SHOW_ATTRIBUTE(asic_mode);
 
-static int dbg_device_id_show(struct seq_file *s, void *p)
+static int device_id_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 	int id;
@@ -1674,9 +1674,9 @@ static int dbg_device_id_show(struct seq_file *s, void *p)
 	seq_printf(s, "DeviceId = %d\n", id);
 	return 0;
 }
-DEBUGFS_RO_ATTR(device_id, dbg_device_id_show);
+DEFINE_SHOW_ATTRIBUTE(device_id);
 
-static int dbg_protection_show(struct seq_file *s, void *p)
+static int protection_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 	int protect, dps0, dps0_low, dps0_high, dps1, dps1_low, dps1_high;
@@ -1726,7 +1726,7 @@ static int dbg_protection_show(struct seq_file *s, void *p)
 		   !!(dps1 & DOC_DPS_KEY_OK));
 	return 0;
 }
-DEBUGFS_RO_ATTR(protection, dbg_protection_show);
+DEFINE_SHOW_ATTRIBUTE(protection);
 
 static void __init doc_dbg_register(struct mtd_info *floor)
 {
diff --git a/drivers/mtd/devices/docg3.h b/drivers/mtd/devices/docg3.h
index e99946575398..e16dca23655b 100644
--- a/drivers/mtd/devices/docg3.h
+++ b/drivers/mtd/devices/docg3.h
@@ -317,17 +317,6 @@ struct docg3 {
 #define doc_info(fmt, arg...) dev_info(docg3->dev, (fmt), ## arg)
 #define doc_dbg(fmt, arg...) dev_dbg(docg3->dev, (fmt), ## arg)
 #define doc_vdbg(fmt, arg...) dev_vdbg(docg3->dev, (fmt), ## arg)
-
-#define DEBUGFS_RO_ATTR(name, show_fct) \
-	static int name##_open(struct inode *inode, struct file *file) \
-	{ return single_open(file, show_fct, inode->i_private); }      \
-	static const struct file_operations name##_fops = { \
-		.owner = THIS_MODULE, \
-		.open = name##_open, \
-		.llseek = seq_lseek, \
-		.read = seq_read, \
-		.release = single_release \
-	};
 #endif
 
 /*
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index d9dcb2d051b4..d162d1717fad 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1265,18 +1265,7 @@ static int mtdswap_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int mtdswap_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mtdswap_show, inode->i_private);
-}
-
-static const struct file_operations mtdswap_fops = {
-	.open		= mtdswap_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mtdswap);
 
 static int mtdswap_add_debugfs(struct mtdswap_dev *d)
 {
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index c452819f6123..ef8721418f2d 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -443,7 +443,7 @@ static unsigned long total_wear = 0;
 /* MTD structure for NAND controller */
 static struct mtd_info *nsmtd;
 
-static int nandsim_debugfs_show(struct seq_file *m, void *private)
+static int nandsim_show(struct seq_file *m, void *private)
 {
 	unsigned long wmin = -1, wmax = 0, avg;
 	unsigned long deciles[10], decile_max[10], tot = 0;
@@ -494,18 +494,7 @@ static int nandsim_debugfs_show(struct seq_file *m, void *private)
 
 	return 0;
 }
-
-static int nandsim_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nandsim_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations dfs_fops = {
-	.open		= nandsim_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nandsim);
 
 /**
  * nandsim_debugfs_create - initialize debugfs
@@ -531,7 +520,7 @@ static int nandsim_debugfs_create(struct nandsim *dev)
 	}
 
 	dent = debugfs_create_file("nandsim_wear_report", S_IRUSR,
-				   root, dev, &dfs_fops);
+				   root, dev, &nandsim_fops);
 	if (IS_ERR_OR_NULL(dent)) {
 		NS_ERR("cannot create \"nandsim_wear_report\" debugfs entry\n");
 		return -1;
-- 
2.17.0

