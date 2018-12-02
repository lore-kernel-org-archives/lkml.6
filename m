Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95DC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 01:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3C820834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 01:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnyz3zCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3C820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725743AbeLBNIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:08:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45050 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:08:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so4655923pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WCGotKYlAVza6e7ysrGlcXo6KJs5XNyTxmncZpCKhis=;
        b=Hnyz3zCRxctI8ZQ6aEF8UHtDiRfbc6F9oKUbj1Io46ok0j3Zb05RxygcTHyKDp5uoO
         7AXEhEDYwHZ9uQhm/cmiNobd84pNvSUbluIMVxXCZWPqMdvKrlnI37Wtzp8UHeilmFbJ
         oWKFcegewJM3inleJvr1j/ERsIYmtn9sIVFEAk70olL/HTeFFxQKpf3uxxZ4Flh98SxT
         3eviK25ibxfUWIb9J7408oRVUKElS/7kODGcmhlz08+OusIVBgk0hDA2vZK5JWyrrsld
         qzsTn0Zx5HMTUuluok5EWk3oyUtXCN/x/YlmTzivR/a+KV15tLlC4RfbsI22oy4SQSkT
         1Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WCGotKYlAVza6e7ysrGlcXo6KJs5XNyTxmncZpCKhis=;
        b=Bn/DJ2MOspHJMoCt8ZLFuOQZed9AuahbK2VptyVZc0BAxR5O+t++lHxQ+GjSCPnGu/
         r/KNtISVKak/Dfb7TJfPGT0/XS6Jch2exxRCtCzhNEx4LEkWpZTRRo2f8T55Uy1PrzDt
         glAHoZB/g1yrSf+N15Hkunbt3YKvvw4ouS4AcWc+uVpw4avVrDstPtZ0AIOCGP0kuDfW
         qFUPVhi86Tt8Io4eF4iNWRB3+mXo4LL7cQfZVX+KLm3NG5Th0CuN94ZZfCySkFHOo1j0
         8ZBuT9l8iVmG97X85peX4PAAVix9H6RaPUj7LbPfx5DDQHAR1wtAhRJKOAOWIk8quHMu
         KFUg==
X-Gm-Message-State: AA+aEWZ8ImbWGCY95OQDo70JAGh9RseG9XtcL6geCOy5kXYL9u4YE+O9
        a/UxZZjPnN/EPO81kthg3eU=
X-Google-Smtp-Source: AFSGD/VCbdj3dKp2bXuJ7WivihMCD1UXuCC/NjVgJZ7ImYAZEOhOUNeSSVfWm8H1oe9ZFKnlTdrWJg==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr11247792plb.52.1543715660453;
        Sat, 01 Dec 2018 17:54:20 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d6sm12796112pgc.89.2018.12.01.17.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 17:54:19 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robert.jarzmik@free.fr, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        keescook@chromium.org, shreeya.patel23498@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] mtd: remove DEBUGFS_RO_ATTR()
Date:   Sat,  1 Dec 2018 20:54:17 -0500
Message-Id: <20181202015417.9100-1-tiny.windzz@gmail.com>
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
Changes in v2:
-Remove a missing DEBUGFS_RO_ATTR
---
 drivers/mtd/devices/docg3.c    | 20 ++++++++++++--------
 drivers/mtd/devices/docg3.h    | 11 -----------
 drivers/mtd/mtdswap.c          | 12 +-----------
 drivers/mtd/nand/raw/nandsim.c | 16 +++-------------
 4 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 512bd4c2eec0..80143972963e 100644
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
 
@@ -1623,9 +1623,10 @@ static int dbg_flashctrl_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-DEBUGFS_RO_ATTR(flashcontrol, dbg_flashctrl_show);
 
-static int dbg_asicmode_show(struct seq_file *s, void *p)
+DEFINE_SHOW_ATTRIBUTE(flashcontrol);
+
+static int asic_mode_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 
@@ -1660,9 +1661,10 @@ static int dbg_asicmode_show(struct seq_file *s, void *p)
 	seq_puts(s, ")\n");
 	return 0;
 }
-DEBUGFS_RO_ATTR(asic_mode, dbg_asicmode_show);
 
-static int dbg_device_id_show(struct seq_file *s, void *p)
+DEFINE_SHOW_ATTRIBUTE(asic_mode);
+
+static int device_id_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 	int id;
@@ -1674,9 +1676,10 @@ static int dbg_device_id_show(struct seq_file *s, void *p)
 	seq_printf(s, "DeviceId = %d\n", id);
 	return 0;
 }
-DEBUGFS_RO_ATTR(device_id, dbg_device_id_show);
 
-static int dbg_protection_show(struct seq_file *s, void *p)
+DEFINE_SHOW_ATTRIBUTE(device_id);
+
+static int protection_show(struct seq_file *s, void *p)
 {
 	struct docg3 *docg3 = (struct docg3 *)s->private;
 	int protect, dps0, dps0_low, dps0_high, dps1, dps1_low, dps1_high;
@@ -1726,7 +1729,8 @@ static int dbg_protection_show(struct seq_file *s, void *p)
 		   !!(dps1 & DOC_DPS_KEY_OK));
 	return 0;
 }
-DEBUGFS_RO_ATTR(protection, dbg_protection_show);
+
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
index d9dcb2d051b4..3afda6c95d62 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1266,17 +1266,7 @@ static int mtdswap_show(struct seq_file *s, void *data)
 	return 0;
 }
 
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
index c452819f6123..2d5532042803 100644
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
@@ -495,17 +495,7 @@ static int nandsim_debugfs_show(struct seq_file *m, void *private)
 	return 0;
 }
 
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
@@ -531,7 +521,7 @@ static int nandsim_debugfs_create(struct nandsim *dev)
 	}
 
 	dent = debugfs_create_file("nandsim_wear_report", S_IRUSR,
-				   root, dev, &dfs_fops);
+				   root, dev, &nandsim_fops);
 	if (IS_ERR_OR_NULL(dent)) {
 		NS_ERR("cannot create \"nandsim_wear_report\" debugfs entry\n");
 		return -1;
-- 
2.17.0

