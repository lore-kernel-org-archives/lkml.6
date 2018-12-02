Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01AF206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2PXT1U8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01AF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbeLBIeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:34:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40945 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeLBIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:34:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so4343908pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wueTmP8apvZBSrrpJh/dUcWLiev/DbStDQlMrgptmPQ=;
        b=q2PXT1U8kh1bt5I18t4vCunMZxsx6qkn1/EyojXRmRhmbg4wF6YCsNeD+oaDm3xQ9a
         b+d9LKrdL3cCzDe8kQpPBxdykKRoy/+u75AV7nl7IlpAS3z63yUe0X55ZJzVvwF6ESq+
         SAIPl+woWKivLkmcjEj1XXTROBShYw9Evo8q4wRx3BRNtzLikqjsqhDDq2N9RPbJCCMG
         gGpt8Px6kykVx2ipu66UPzU1l9nmj8J5lnwuLVrEyucxd1jarugV2N4DsZuRE/TWH6j9
         ggkn4ib980KRN0zZx38bgcF6ooquRWM+rbIj35Z9/joqmZFq9GT8OSzTDO0/AHFdAWC3
         U1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wueTmP8apvZBSrrpJh/dUcWLiev/DbStDQlMrgptmPQ=;
        b=AjvQL2uxjaRmbIvroQuIsGkCIc0H/UxUE7IH1DSei90UIc+twdDbYIE92Hur4uSYSx
         op2qWyFihr2mfC0vS0VXJJ1LMgc9ckODgTPKK9Z1xRLO1BLKagKS3Bmur+wShrsi6I9O
         skL+vbBvYrBYTh3FSBuyH6fxOEKIQY14vvCI8E6pHpUw+XvzalqfMmfK4js8sEJO3Xbt
         XaQyegUde4GdTyoflZn/ANEn+QS/o4XFOZJNJUqCb9J0q+yj31IWuGSWnyn+4Sx87yd+
         ZK0h/y5csFiI5lLXJco2FHdn/hZkivtWGAVlpprElM322JnCqOgarGAf+jX1IWwrcBnH
         FXyw==
X-Gm-Message-State: AA+aEWZiolvDY8EduFbgDVy+qHMobqbpxB7AIlUoAGgyBIAoWchWLMEZ
        Z/rAaim0PIxkHjOrVH6WF2o=
X-Google-Smtp-Source: AFSGD/UHoAmmbLjiwaTh2unsBwXvJhO7HrDyzw9FXDR9z3a3JbWUfn8/8ERycvFvIbMUmQEKKAL1sw==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr9382653pgc.366.1543739640690;
        Sun, 02 Dec 2018 00:34:00 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v62sm18814570pfd.163.2018.12.02.00.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 00:33:59 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robert.jarzmik@free.fr, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        keescook@chromium.org, shreeya.patel23498@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mtd: use DEFINE_SHOW_ATTRIBUTE() instead of open-coding it
Date:   Sun,  2 Dec 2018 03:33:58 -0500
Message-Id: <20181202083358.10896-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_SHOW_ATTRIBUTE macro can help us simplify the code,so change
to it.And change the DEBUGFS_RO_ATTR macro defined in some file to a
standard macro.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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

