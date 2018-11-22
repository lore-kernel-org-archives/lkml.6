Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE220684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOcZfZ6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbeKWAeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:34:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41233 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbeKWAeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:34:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so1782923pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tGUK+AlFl6F39kEclhyUYHbcEKwa14d1ysu53ZktSlY=;
        b=XOcZfZ6orBCkJeZWYFUgyAITiGh4swlaSUvjbG+uieutCrz20dZMpJLEHX51kRnvTN
         S2Jzflr1C593zRqsQ8QZw3mSQPvjGDpxFjtAdPPGfdCypeTz90FDJ/6ILjehEsZ3QbDn
         shiYua7EUPPlGsXjCz7FHxKtHYxAM/U4t7Li29m99H/iTFG73zCYOODGJeYbQVDCZnoz
         Hl9Smp/rUY9wkjAPe/5jHNDtGfgp3kfSQJ9hbjB/REI0pEBFq6talEY1WiKHwsCKhqHF
         oe874xMaFxZHwd9wDXv8jgykQmMTcnVqhwW8SNvEam7rcNiOUQA+RZqZb73pGo2EYW7P
         27Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tGUK+AlFl6F39kEclhyUYHbcEKwa14d1ysu53ZktSlY=;
        b=jk9lTKXR7JE+n21/fXK14FLvNeeaAMlV4hTbbGlCR1iy3u6FxevauP6wwFWGh29bAU
         MiHw7WPvZbpdNoMw8iTDqXT7xgkdELB8imFUSrtWckPYvpBAOjlDaUBcK+0Ov+vnsgrr
         JRYrhqsoPMQb5uEjlpCuZBhZUyLCfR0jNirOCKYo7IHE3t6WjNgJWEPS1OIN2HQKOfj1
         BJjjM9OuyZen3lcQhv1ZcjoqGbQwX9wGveC4uIdKMX4Y6hdapqStUbNVvGJ+JxHv9zWt
         rI9gkdzxAfyd/XsBzppZq69g68A1GYeNtxL7gC7XN3rx18DYYYyHuiLpWYV/9QIB/5dR
         PMJg==
X-Gm-Message-State: AGRZ1gLOflOZz+ZYV2YPAUJXVz7G4hueHxQTC6ZbgiOeRkSgC6hnzEje
        6QVvncqM1j2Yg2kh9J74k1w=
X-Google-Smtp-Source: AFSGD/VRREkcAx77cOOgeWPM+BvFvjEQe0CmlGqLfZ7vibAeMiUuRtXaPaJT/AtcyXG+PX3a1WKSLA==
X-Received: by 2002:a63:5907:: with SMTP id n7mr10083555pgb.435.1542894887724;
        Thu, 22 Nov 2018 05:54:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t4-v6sm52472830pfh.21.2018.11.22.05.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 05:54:46 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] iommu/omap: remove DEBUG_SEQ_FOPS_RO()
Date:   Thu, 22 Nov 2018 08:54:43 -0500
Message-Id: <20181122135443.25035-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we already have the DEFINE_SHOW_ATTRIBUTE,there is no need
to define such a macro.So remove DEBUG_SEQ_FOPS_RO.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/omap-iommu-debug.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 50217548c3b8..4abc0ef522a8 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -159,7 +159,7 @@ static size_t omap_dump_tlb_entries(struct omap_iommu *obj, struct seq_file *s)
 	return 0;
 }
 
-static int debug_read_tlb(struct seq_file *s, void *data)
+static int tlb_show(struct seq_file *s, void *data)
 {
 	struct omap_iommu *obj = s->private;
 
@@ -210,7 +210,7 @@ static void dump_ioptable(struct seq_file *s)
 	spin_unlock(&obj->page_table_lock);
 }
 
-static int debug_read_pagetable(struct seq_file *s, void *data)
+static int pagetable_show(struct seq_file *s, void *data)
 {
 	struct omap_iommu *obj = s->private;
 
@@ -228,35 +228,22 @@ static int debug_read_pagetable(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define DEBUG_SEQ_FOPS_RO(name)						       \
-	static int debug_open_##name(struct inode *inode, struct file *file)   \
-	{								       \
-		return single_open(file, debug_read_##name, inode->i_private); \
-	}								       \
-									       \
-	static const struct file_operations debug_##name##_fops = {	       \
-		.open		= debug_open_##name,			       \
-		.read		= seq_read,				       \
-		.llseek		= seq_lseek,				       \
-		.release	= single_release,			       \
-	}
-
 #define DEBUG_FOPS_RO(name)						\
-	static const struct file_operations debug_##name##_fops = {	\
+	static const struct file_operations name##_fops = {	        \
 		.open = simple_open,					\
 		.read = debug_read_##name,				\
 		.llseek = generic_file_llseek,				\
 	}
 
 DEBUG_FOPS_RO(regs);
-DEBUG_SEQ_FOPS_RO(tlb);
-DEBUG_SEQ_FOPS_RO(pagetable);
+DEFINE_SHOW_ATTRIBUTE(tlb);
+DEFINE_SHOW_ATTRIBUTE(pagetable);
 
 #define __DEBUG_ADD_FILE(attr, mode)					\
 	{								\
 		struct dentry *dent;					\
 		dent = debugfs_create_file(#attr, mode, obj->debug_dir,	\
-					   obj, &debug_##attr##_fops);	\
+					   obj, &attr##_fops);	        \
 		if (!dent)						\
 			goto err;					\
 	}
-- 
2.17.0

