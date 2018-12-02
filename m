Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B596C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D904520672
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgy+jXGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D904520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeLBDTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:19:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41823 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLBDTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:19:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so4187242pgh.8;
        Sat, 01 Dec 2018 19:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JbMipT4beD2NxGSzj++LCMz3H0vLVY/MGpnwAsfx8OY=;
        b=Qgy+jXGtpmAln9LEKKfN9x1G5nwBm/NF0sf+V5R67RP73bub8Rl2bw7eJIwx996btR
         7oxaMnoIk9QI2zHOFx5JKZgFKgkuqFKBibaODLwziRu67Ybffxmv+1P6jTJ3UV+uX69I
         9N3Q5YTG5AQBFiFtjze/uqjzjFB8MZEiQYYOEBtOkSqWGWlEw92/yMVfOnyT0IvdhAoV
         3bhAKA7FSKfQqIzfgtFML5P5apd8QKYXeSgzfVwz2a+8lAn8RqNw8CQ/cphp9n4EXOMN
         5Dryk76QOhUEJpyOdFF+MvTDpNC5eb8szLl8a5W1ZdU+5W4MfT/1WY+JNkEwOeHeseOu
         bCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JbMipT4beD2NxGSzj++LCMz3H0vLVY/MGpnwAsfx8OY=;
        b=Cf9mXL+ARluobLydgWh8dkBDUpg4Ly67yKtohmAbIqdgyCJEysC8VPR9a99IqyVvkc
         YlQWdGF9BFP277ycu3IWNh+9oCSikjcaXwCQY7WHFG/CTXYkJZdKx5SOVarNOHHKZxP+
         jjmK19UU5jmP39JC9fbMfCAugsvpUnW4Q9XRBFqn+jHYUFYAD94k7qkRxacmtVp8WeL9
         Q7EJ7tz4h3R18SfgZE9kx72I6WjPvhiKnPhJsSyvCyt9DbjL9Q2LsbSe+Wflp+nwIDR4
         y9luvFGbkNGwswIlMKku2+M9HBmAQR/eggRYOJPJkc5kOCoCQTsvk2U/2vCjid4d/sxu
         bZ9g==
X-Gm-Message-State: AA+aEWbDNO7v9HzRZbnjLP2Yhn1q1863rcx5lOOc6uuxGFlNZ4L/lurL
        zGUnMZs/xK89qWSx3PdtJPk=
X-Google-Smtp-Source: AFSGD/Xdzs/DiinMbbWtxQxcyIKN9aTXJLrN2ifuZH7zkg1MZNHubbiHONLIlaspziCfIUXtSttN4w==
X-Received: by 2002:a62:178f:: with SMTP id 137mr11100855pfx.226.1543720754730;
        Sat, 01 Dec 2018 19:19:14 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z7sm20538115pga.6.2018.12.01.19.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 19:19:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     arnd@arndb.de, abhinavk@codeaurora.org, bzwang@chromium.org,
        colin.king@canonical.com, airlied@linux.ie, jsanka@codeaurora.org,
        jcrouse@codeaurora.org, ryadav@codeaurora.org, robdclark@gmail.com,
        linux@armlinux.org.uk, swboyd@chromium.org,
        skolluku@codeaurora.org, seanpaul@chromium.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] gpu/drm: remove DEFINE_DPU_DEBUGFS_SEQ_FOPS()
Date:   Sat,  1 Dec 2018 22:19:11 -0500
Message-Id: <20181202031912.9736-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
such a macro separately,so remove DEFINE_DPU_DEBUGFS_SEQ_FOPS.
Also use DEFINE_SHOW_ATTRIBUTE to simplify some code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/gpu/drm/armada/armada_debugfs.c      | 21 ++++--------
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c | 14 +-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c     | 33 +++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c  | 17 ++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c      | 36 ++++----------------
 drivers/gpu/host1x/debug.c                   | 34 ++++--------------
 6 files changed, 29 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index 6758c3a83de2..64dccb7c8be2 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -28,7 +28,7 @@ static int armada_debugfs_gem_linear_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int armada_debugfs_reg_show(struct seq_file *m, void *data)
+static int reg_show(struct seq_file *m, void *data)
 {
 	struct drm_device *dev = m->private;
 	struct armada_private *priv = dev->dev_private;
@@ -50,18 +50,7 @@ static int armada_debugfs_reg_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int armada_debugfs_reg_r_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, armada_debugfs_reg_show, inode->i_private);
-}
-
-static const struct file_operations fops_reg_r = {
-	.owner = THIS_MODULE,
-	.open = armada_debugfs_reg_r_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(reg);
 
 static int armada_debugfs_write(struct file *file, const char __user *ptr,
 	size_t len, loff_t *off)
@@ -119,12 +108,14 @@ int armada_drm_debugfs_init(struct drm_minor *minor)
 		return ret;
 
 	de = debugfs_create_file("reg", S_IFREG | S_IRUSR,
-				 minor->debugfs_root, minor->dev, &fops_reg_r);
+				 minor->debugfs_root, minor->dev,
+				 &reg_fops);
 	if (!de)
 		return -ENOMEM;
 
 	de = debugfs_create_file("reg_wr", S_IFREG | S_IWUSR,
-				 minor->debugfs_root, minor->dev, &fops_reg_w);
+				 minor->debugfs_root, minor->dev,
+				 &fops_reg_w);
 	if (!de)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
index 879c13fe74e0..7607aac9449c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
@@ -299,18 +299,6 @@ static void dpu_disable_all_irqs(struct dpu_kms *dpu_kms)
 }
 
 #ifdef CONFIG_DEBUG_FS
-#define DEFINE_DPU_DEBUGFS_SEQ_FOPS(__prefix)				\
-static int __prefix ## _open(struct inode *inode, struct file *file)	\
-{									\
-	return single_open(file, __prefix ## _show, inode->i_private);	\
-}									\
-static const struct file_operations __prefix ## _fops = {		\
-	.owner = THIS_MODULE,						\
-	.open = __prefix ## _open,					\
-	.release = single_release,					\
-	.read = seq_read,						\
-	.llseek = seq_lseek,						\
-}
 
 static int dpu_debugfs_core_irq_show(struct seq_file *s, void *v)
 {
@@ -341,7 +329,7 @@ static int dpu_debugfs_core_irq_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-DEFINE_DPU_DEBUGFS_SEQ_FOPS(dpu_debugfs_core_irq);
+DEFINE_SHOW_ATTRIBUTE(dpu_debugfs_core_irq);
 
 int dpu_debugfs_core_irq_init(struct dpu_kms *dpu_kms,
 		struct dentry *parent)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index d4530d60767b..e705bad980ee 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1309,7 +1309,7 @@ int dpu_crtc_vblank(struct drm_crtc *crtc, bool en)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
+static int status_show(struct seq_file *s, void *data)
 {
 	struct dpu_crtc *dpu_crtc;
 	struct dpu_plane_state *pstate = NULL;
@@ -1428,24 +1428,6 @@ static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int _dpu_debugfs_status_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, _dpu_debugfs_status_show, inode->i_private);
-}
-
-#define DEFINE_DPU_DEBUGFS_SEQ_FOPS(__prefix)                          \
-static int __prefix ## _open(struct inode *inode, struct file *file)	\
-{									\
-	return single_open(file, __prefix ## _show, inode->i_private);	\
-}									\
-static const struct file_operations __prefix ## _fops = {		\
-	.owner = THIS_MODULE,						\
-	.open = __prefix ## _open,					\
-	.release = single_release,					\
-	.read = seq_read,						\
-	.llseek = seq_lseek,						\
-}
-
 static int dpu_crtc_debugfs_state_show(struct seq_file *s, void *v)
 {
 	struct drm_crtc *crtc = (struct drm_crtc *) s->private;
@@ -1468,20 +1450,15 @@ static int dpu_crtc_debugfs_state_show(struct seq_file *s, void *v)
 
 	return 0;
 }
-DEFINE_DPU_DEBUGFS_SEQ_FOPS(dpu_crtc_debugfs_state);
+
+DEFINE_SHOW_ATTRIBUTE(dpu_crtc_debugfs_state);
+DEFINE_SHOW_ATTRIBUTE(status);
 
 static int _dpu_crtc_init_debugfs(struct drm_crtc *crtc)
 {
 	struct dpu_crtc *dpu_crtc;
 	struct dpu_kms *dpu_kms;
 
-	static const struct file_operations debugfs_status_fops = {
-		.open =		_dpu_debugfs_status_open,
-		.read =		seq_read,
-		.llseek =	seq_lseek,
-		.release =	single_release,
-	};
-
 	if (!crtc)
 		return -EINVAL;
 	dpu_crtc = to_dpu_crtc(crtc);
@@ -1496,7 +1473,7 @@ static int _dpu_crtc_init_debugfs(struct drm_crtc *crtc)
 	/* don't error check these */
 	debugfs_create_file("status", 0400,
 			dpu_crtc->debugfs_root,
-			dpu_crtc, &debugfs_status_fops);
+			dpu_crtc, &status_fops);
 	debugfs_create_file("state", 0600,
 			dpu_crtc->debugfs_root,
 			&dpu_crtc->base,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 96cdf06e7da2..a36f9f72da87 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1873,7 +1873,7 @@ void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static int _dpu_encoder_status_show(struct seq_file *s, void *data)
+static int status_show(struct seq_file *s, void *data)
 {
 	struct dpu_encoder_virt *dpu_enc;
 	int i;
@@ -1912,11 +1912,7 @@ static int _dpu_encoder_status_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int _dpu_encoder_debugfs_status_open(struct inode *inode,
-		struct file *file)
-{
-	return single_open(file, _dpu_encoder_status_show, inode->i_private);
-}
+DEFINE_SHOW_ATTRIBUTE(status);
 
 static int _dpu_encoder_init_debugfs(struct drm_encoder *drm_enc)
 {
@@ -1925,13 +1921,6 @@ static int _dpu_encoder_init_debugfs(struct drm_encoder *drm_enc)
 	struct dpu_kms *dpu_kms;
 	int i;
 
-	static const struct file_operations debugfs_status_fops = {
-		.open =		_dpu_encoder_debugfs_status_open,
-		.read =		seq_read,
-		.llseek =	seq_lseek,
-		.release =	single_release,
-	};
-
 	char name[DPU_NAME_SIZE];
 
 	if (!drm_enc || !drm_enc->dev || !drm_enc->dev->dev_private) {
@@ -1953,7 +1942,7 @@ static int _dpu_encoder_init_debugfs(struct drm_encoder *drm_enc)
 
 	/* don't error check these */
 	debugfs_create_file("status", 0600,
-		dpu_enc->debugfs_root, dpu_enc, &debugfs_status_fops);
+		dpu_enc->debugfs_root, dpu_enc, &status_fops);
 
 	for (i = 0; i < dpu_enc->num_phys_encs; i++)
 		if (dpu_enc->phys_encs[i] &&
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 0a683e65a9f3..c3f036095c53 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -113,30 +113,19 @@ static int _dpu_danger_signal_status(struct seq_file *s,
 	return 0;
 }
 
-#define DEFINE_DPU_DEBUGFS_SEQ_FOPS(__prefix)				\
-static int __prefix ## _open(struct inode *inode, struct file *file)	\
-{									\
-	return single_open(file, __prefix ## _show, inode->i_private);	\
-}									\
-static const struct file_operations __prefix ## _fops = {		\
-	.owner = THIS_MODULE,						\
-	.open = __prefix ## _open,					\
-	.release = single_release,					\
-	.read = seq_read,						\
-	.llseek = seq_lseek,						\
-}
-
 static int dpu_debugfs_danger_stats_show(struct seq_file *s, void *v)
 {
 	return _dpu_danger_signal_status(s, true);
 }
-DEFINE_DPU_DEBUGFS_SEQ_FOPS(dpu_debugfs_danger_stats);
+
+DEFINE_SHOW_ATTRIBUTE(dpu_debugfs_danger_stats);
 
 static int dpu_debugfs_safe_stats_show(struct seq_file *s, void *v)
 {
 	return _dpu_danger_signal_status(s, false);
 }
-DEFINE_DPU_DEBUGFS_SEQ_FOPS(dpu_debugfs_safe_stats);
+
+DEFINE_SHOW_ATTRIBUTE(dpu_debugfs_safe_stats);
 
 static void dpu_debugfs_danger_destroy(struct dpu_kms *dpu_kms)
 {
@@ -162,7 +151,7 @@ static int dpu_debugfs_danger_init(struct dpu_kms *dpu_kms,
 	return 0;
 }
 
-static int _dpu_debugfs_show_regset32(struct seq_file *s, void *data)
+static int dpu_regset32_show(struct seq_file *s, void *data)
 {
 	struct dpu_debugfs_regset32 *regset;
 	struct dpu_kms *dpu_kms;
@@ -212,18 +201,7 @@ static int _dpu_debugfs_show_regset32(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int dpu_debugfs_open_regset32(struct inode *inode,
-		struct file *file)
-{
-	return single_open(file, _dpu_debugfs_show_regset32, inode->i_private);
-}
-
-static const struct file_operations dpu_fops_regset32 = {
-	.open =		dpu_debugfs_open_regset32,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dpu_regset32);
 
 void dpu_debugfs_setup_regset32(struct dpu_debugfs_regset32 *regset,
 		uint32_t offset, uint32_t length, struct dpu_kms *dpu_kms)
@@ -245,7 +223,7 @@ void *dpu_debugfs_create_regset32(const char *name, umode_t mode,
 	regset->offset = round_down(regset->offset, 4);
 
 	return debugfs_create_file(name, mode, parent,
-			regset, &dpu_fops_regset32);
+			regset, &dpu_regset32_fops);
 }
 
 static int _dpu_debugfs_init(struct dpu_kms *dpu_kms)
diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
index 329e4a3d8ae7..de7f020e2932 100644
--- a/drivers/gpu/host1x/debug.c
+++ b/drivers/gpu/host1x/debug.c
@@ -119,7 +119,7 @@ static void show_all(struct host1x *m, struct output *o, bool show_fifo)
 	}
 }
 
-static int host1x_debug_show_all(struct seq_file *s, void *unused)
+static int host1x_all_show(struct seq_file *s, void *unused)
 {
 	struct output o = {
 		.fn = write_to_seqfile,
@@ -131,7 +131,7 @@ static int host1x_debug_show_all(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int host1x_debug_show(struct seq_file *s, void *unused)
+static int host1x_show(struct seq_file *s, void *unused)
 {
 	struct output o = {
 		.fn = write_to_seqfile,
@@ -143,29 +143,8 @@ static int host1x_debug_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int host1x_debug_open_all(struct inode *inode, struct file *file)
-{
-	return single_open(file, host1x_debug_show_all, inode->i_private);
-}
-
-static const struct file_operations host1x_debug_all_fops = {
-	.open = host1x_debug_open_all,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int host1x_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, host1x_debug_show, inode->i_private);
-}
-
-static const struct file_operations host1x_debug_fops = {
-	.open = host1x_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(host1x_all);
+DEFINE_SHOW_ATTRIBUTE(host1x);
 
 static void host1x_debugfs_init(struct host1x *host1x)
 {
@@ -177,9 +156,10 @@ static void host1x_debugfs_init(struct host1x *host1x)
 	/* Store the created entry */
 	host1x->debugfs = de;
 
-	debugfs_create_file("status", S_IRUGO, de, host1x, &host1x_debug_fops);
+	debugfs_create_file("status", S_IRUGO, de, host1x,
+			   &host1x_fops);
 	debugfs_create_file("status_all", S_IRUGO, de, host1x,
-			    &host1x_debug_all_fops);
+			    &host1x_all_fops);
 
 	debugfs_create_u32("trace_cmdbuf", S_IRUGO|S_IWUSR, de,
 			   &host1x_debug_trace_cmdbuf);
-- 
2.17.0

