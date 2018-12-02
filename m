Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C90C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B092B20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkWNvrz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B092B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725745AbeLBNSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:18:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46658 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeLBNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:18:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so4140656pgp.13;
        Sat, 01 Dec 2018 18:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=prIE/4QH1O1/SYGDzDNQ7mm6c7DkU5O2rgbSuKrVpsI=;
        b=WkWNvrz6P9MFXQsqB/8uY+qG7ArRv2crG66nlkWQkoS9pTn/q+LhPWfBHIiQgqc2aZ
         Jjl8S0Oc+COUF0lFK3fwB4k+V6WqlnWjlEOZuYk5oyQcMumEeR/fqWunQPbhRB3DiII7
         xcYRsKXllpP9/8tNPqGnGELxs0IZWIYC9mWoOuZWcKzoF8vQVTmDtDgHLCKsTpS7x+R4
         EyrLdxSJGta+4tyF3oc79cFsc+EZM6SXIh88TimJFsZUYilgZ0ZsJfJur4gRquGI/6gt
         yeQp45IiwOHkZ9LLqNMucGxUMTznUp324ydgZhQb6fXoV07sybbhtNgwBeLLo2A1WVeb
         0Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=prIE/4QH1O1/SYGDzDNQ7mm6c7DkU5O2rgbSuKrVpsI=;
        b=FIFmZ+AFrp56aYZ/DoELLWS74kYET30qlpFmx9lpdRWUNy5t643J8garcjDJ4fUeDm
         Gj8Z8miXQc2OEzaVdPUONdM9+YZyNXuJAhhPTjXnDhJvEDxtYEw2EzRo+OaxmIWBVuCZ
         CDZHfwd+yew/Ryl/AAzCLspKJdAe3F1MybmkZH8orSYHfPYAckoFogjEMvktAWAKFSkK
         9xnrZU/muSV0F/iir/OM8SjM5Fa3oKdUdbaGUt7YtcmQn+X/eZJddOwCifg89fkTqvra
         dXxKGCXI9T6vWvftJmhzZzUGAorRMYFkelpROypBe+6ZVto17qadC4xB55wJQB9ASe7R
         +1Kw==
X-Gm-Message-State: AA+aEWav+hvU6se7TN6hFrD8oOPHI8J6Yp1JYjypC7UpffPh5/0kVmoF
        2t6fWmr8TdwIfUctSF+xf7U=
X-Google-Smtp-Source: AFSGD/UJiARMHxTMyNh342EPlNZuPpEvJXeWzqm00D8fLLworhmJ4rQL7UVDy19Kh6fvJai+iJoJyA==
X-Received: by 2002:a65:434d:: with SMTP id k13mr9321139pgq.269.1543716267369;
        Sat, 01 Dec 2018 18:04:27 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b9sm13021411pfi.118.2018.12.01.18.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 18:04:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        fabien.dessenne@st.com, jean-christophe.trotin@st.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] media: remove bdisp_dbg_declare() and hva_dbg_declare()
Date:   Sat,  1 Dec 2018 21:04:25 -0500
Message-Id: <20181202020425.9189-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
bdisp_dbg_declare and hva_dbg_declare,so remove them.Also use
DEFINE_SHOW_ATTRIBUTE to simplify some code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-delete fimc_is_debugfs_open
---
 drivers/media/platform/exynos4-is/fimc-is.c   | 16 ++-------
 .../media/platform/sti/bdisp/bdisp-debug.c    | 34 ++++++------------
 drivers/media/platform/sti/hva/hva-debugfs.c  | 36 +++++++------------
 3 files changed, 26 insertions(+), 60 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index f5fc54de19da..02da0b06e56a 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -738,7 +738,7 @@ int fimc_is_hw_initialize(struct fimc_is *is)
 	return 0;
 }
 
-static int fimc_is_log_show(struct seq_file *s, void *data)
+static int fimc_is_show(struct seq_file *s, void *data)
 {
 	struct fimc_is *is = s->private;
 	const u8 *buf = is->memory.vaddr + FIMC_IS_DEBUG_REGION_OFFSET;
@@ -752,17 +752,7 @@ static int fimc_is_log_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int fimc_is_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fimc_is_log_show, inode->i_private);
-}
-
-static const struct file_operations fimc_is_debugfs_fops = {
-	.open		= fimc_is_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fimc_is);
 
 static void fimc_is_debugfs_remove(struct fimc_is *is)
 {
@@ -777,7 +767,7 @@ static int fimc_is_debugfs_create(struct fimc_is *is)
 	is->debugfs_entry = debugfs_create_dir("fimc_is", NULL);
 
 	dentry = debugfs_create_file("fw_log", S_IRUGO, is->debugfs_entry,
-				     is, &fimc_is_debugfs_fops);
+				     is, &fimc_is_fops);
 	if (!dentry)
 		fimc_is_debugfs_remove(is);
 
diff --git a/drivers/media/platform/sti/bdisp/bdisp-debug.c b/drivers/media/platform/sti/bdisp/bdisp-debug.c
index c6a4e2de5c0c..77ca7517fa3e 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-debug.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-debug.c
@@ -315,7 +315,7 @@ static void bdisp_dbg_dump_ivmx(struct seq_file *s,
 	seq_puts(s, "Unknown conversion\n");
 }
 
-static int bdisp_dbg_last_nodes(struct seq_file *s, void *data)
+static int last_nodes_show(struct seq_file *s, void *data)
 {
 	/* Not dumping all fields, focusing on significant ones */
 	struct bdisp_dev *bdisp = s->private;
@@ -388,7 +388,7 @@ static int bdisp_dbg_last_nodes(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int bdisp_dbg_last_nodes_raw(struct seq_file *s, void *data)
+static int last_nodes_raw_show(struct seq_file *s, void *data)
 {
 	struct bdisp_dev *bdisp = s->private;
 	struct bdisp_node *node;
@@ -437,7 +437,7 @@ static const char *bdisp_fmt_to_str(struct bdisp_frame frame)
 	}
 }
 
-static int bdisp_dbg_last_request(struct seq_file *s, void *data)
+static int last_request_show(struct seq_file *s, void *data)
 {
 	struct bdisp_dev *bdisp = s->private;
 	struct bdisp_request *request = &bdisp->dbg.copy_request;
@@ -474,7 +474,7 @@ static int bdisp_dbg_last_request(struct seq_file *s, void *data)
 
 #define DUMP(reg) seq_printf(s, #reg " \t0x%08X\n", readl(bdisp->regs + reg))
 
-static int bdisp_dbg_regs(struct seq_file *s, void *data)
+static int regs_show(struct seq_file *s, void *data)
 {
 	struct bdisp_dev *bdisp = s->private;
 	int ret;
@@ -582,7 +582,7 @@ static int bdisp_dbg_regs(struct seq_file *s, void *data)
 
 #define SECOND 1000000
 
-static int bdisp_dbg_perf(struct seq_file *s, void *data)
+static int perf_show(struct seq_file *s, void *data)
 {
 	struct bdisp_dev *bdisp = s->private;
 	struct bdisp_request *request = &bdisp->dbg.copy_request;
@@ -627,27 +627,15 @@ static int bdisp_dbg_perf(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define bdisp_dbg_declare(name) \
-	static int bdisp_dbg_##name##_open(struct inode *i, struct file *f) \
-	{ \
-		return single_open(f, bdisp_dbg_##name, i->i_private); \
-	} \
-	static const struct file_operations bdisp_dbg_##name##_fops = { \
-		.open           = bdisp_dbg_##name##_open, \
-		.read           = seq_read, \
-		.llseek         = seq_lseek, \
-		.release        = single_release, \
-	}
-
 #define bdisp_dbg_create_entry(name) \
 	debugfs_create_file(#name, S_IRUGO, bdisp->dbg.debugfs_entry, bdisp, \
-			    &bdisp_dbg_##name##_fops)
+			    &name##_fops)
 
-bdisp_dbg_declare(regs);
-bdisp_dbg_declare(last_nodes);
-bdisp_dbg_declare(last_nodes_raw);
-bdisp_dbg_declare(last_request);
-bdisp_dbg_declare(perf);
+DEFINE_SHOW_ATTRIBUTE(regs);
+DEFINE_SHOW_ATTRIBUTE(last_nodes);
+DEFINE_SHOW_ATTRIBUTE(last_nodes_raw);
+DEFINE_SHOW_ATTRIBUTE(last_request);
+DEFINE_SHOW_ATTRIBUTE(perf);
 
 int bdisp_debugfs_create(struct bdisp_dev *bdisp)
 {
diff --git a/drivers/media/platform/sti/hva/hva-debugfs.c b/drivers/media/platform/sti/hva/hva-debugfs.c
index 9f7e8ac875d1..7d12a5b5d914 100644
--- a/drivers/media/platform/sti/hva/hva-debugfs.c
+++ b/drivers/media/platform/sti/hva/hva-debugfs.c
@@ -271,7 +271,7 @@ static void hva_dbg_perf_compute(struct hva_ctx *ctx)
  * device debug info
  */
 
-static int hva_dbg_device(struct seq_file *s, void *data)
+static int device_show(struct seq_file *s, void *data)
 {
 	struct hva_dev *hva = s->private;
 
@@ -281,7 +281,7 @@ static int hva_dbg_device(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int hva_dbg_encoders(struct seq_file *s, void *data)
+static int encoders_show(struct seq_file *s, void *data)
 {
 	struct hva_dev *hva = s->private;
 	unsigned int i = 0;
@@ -299,7 +299,7 @@ static int hva_dbg_encoders(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int hva_dbg_last(struct seq_file *s, void *data)
+static int last_show(struct seq_file *s, void *data)
 {
 	struct hva_dev *hva = s->private;
 	struct hva_ctx *last_ctx = &hva->dbg.last_ctx;
@@ -316,7 +316,7 @@ static int hva_dbg_last(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int hva_dbg_regs(struct seq_file *s, void *data)
+static int regs_show(struct seq_file *s, void *data)
 {
 	struct hva_dev *hva = s->private;
 
@@ -325,26 +325,14 @@ static int hva_dbg_regs(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define hva_dbg_declare(name)						  \
-	static int hva_dbg_##name##_open(struct inode *i, struct file *f) \
-	{								  \
-		return single_open(f, hva_dbg_##name, i->i_private);	  \
-	}								  \
-	static const struct file_operations hva_dbg_##name##_fops = {	  \
-		.open		= hva_dbg_##name##_open,		  \
-		.read		= seq_read,				  \
-		.llseek		= seq_lseek,				  \
-		.release	= single_release,			  \
-	}
-
 #define hva_dbg_create_entry(name)					 \
 	debugfs_create_file(#name, 0444, hva->dbg.debugfs_entry, hva, \
-			    &hva_dbg_##name##_fops)
+			    &name##_fops)
 
-hva_dbg_declare(device);
-hva_dbg_declare(encoders);
-hva_dbg_declare(last);
-hva_dbg_declare(regs);
+DEFINE_SHOW_ATTRIBUTE(device);
+DEFINE_SHOW_ATTRIBUTE(encoders);
+DEFINE_SHOW_ATTRIBUTE(last);
+DEFINE_SHOW_ATTRIBUTE(regs);
 
 void hva_debugfs_create(struct hva_dev *hva)
 {
@@ -380,7 +368,7 @@ void hva_debugfs_remove(struct hva_dev *hva)
  * context (instance) debug info
  */
 
-static int hva_dbg_ctx(struct seq_file *s, void *data)
+static int ctx_show(struct seq_file *s, void *data)
 {
 	struct hva_ctx *ctx = s->private;
 
@@ -392,7 +380,7 @@ static int hva_dbg_ctx(struct seq_file *s, void *data)
 	return 0;
 }
 
-hva_dbg_declare(ctx);
+DEFINE_SHOW_ATTRIBUTE(ctx);
 
 void hva_dbg_ctx_create(struct hva_ctx *ctx)
 {
@@ -407,7 +395,7 @@ void hva_dbg_ctx_create(struct hva_ctx *ctx)
 
 	ctx->dbg.debugfs_entry = debugfs_create_file(name, 0444,
 						     hva->dbg.debugfs_entry,
-						     ctx, &hva_dbg_ctx_fops);
+						     ctx, &ctx_fops);
 }
 
 void hva_dbg_ctx_remove(struct hva_ctx *ctx)
-- 
2.17.0

