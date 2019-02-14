Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BD7222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH5PoN2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407245AbfBNOXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:23:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43739 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407232AbfBNOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:23:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id z20so4373784ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2icppJSE2JY56X+b3hh1qxMah7i9pLY5x+Xh+NERzMQ=;
        b=KH5PoN2hIKmme4i8Sa+e3vZIfhV+EJdVBTOsVrJc182dvNpw9Ut72YYNJvncMMbsxX
         xlefkT0bbFS18f6u2gEno9pliL/ahNgL+50DaoUHAV26zd0IxwOL/fJkYf9v65Qwj0Ty
         YMrpqmmvQYLno5UrvAorFOb+08RM+0xiQIHwUZhWN8yyTf3F5wQcyCFgA6cdj81syvXV
         qT0zsRWp3v3rarq/5lK5QNS+BKhTnBqM+NteShzfUWBfrbua/dAe7HbvqJfM3P7O7f7B
         NiNhZjpDMHmW/w1o3AOvk/9M84IK8Rt2dHki6LmL/qHhQNK+8GoG5/1aJmzfoDlb1zX+
         oqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2icppJSE2JY56X+b3hh1qxMah7i9pLY5x+Xh+NERzMQ=;
        b=GJnAnclISA2jWv2n/Ia91Vldd9EnIUtRtgbqVRidKCijQL+EdT5KJSlB4fMoFXDxzl
         7Y727/tB78kT0s4lWDw0lejOKEQQNkZjw8aNFb1OECTwF5I4QfBz+b8XsmmQ8vEp1Qm2
         MX7HRpiuAOz4YRT0BfDvgpFxQ1XLAkpp1GnMhDswls3gSsVCXinG+FMajDTZYZo9dW90
         7KRuyzF+ahxixiMSlYtLiYsJ8MmcfzvzJ/qcZJ4q8ZlfR/CWaxC68ocX2l0aEmUnxYzz
         4rEH+PAtZnJKjZe3mdSoy/c5XkqdtHu5R9Bnw1BlNPlY6lL/ZyEXFZ/ONbn76VUk82Vh
         m8Aw==
X-Gm-Message-State: AHQUAuYd433hkkcBK/m/d7fywtbjE8/B3BJrNyLdlXX4tOWyliHaWL1h
        GL/R+vC9BhfD5drepLEtvCU=
X-Google-Smtp-Source: AHgI3IZgb2sSvuBT0sbYIOda/c9IewaGLrQ56owAQC/u8ZLowhf95wjJGsw9phG9RHNwgGoo5ayZkA==
X-Received: by 2002:a2e:7803:: with SMTP id t3-v6mr2727167ljc.115.1550154208948;
        Thu, 14 Feb 2019 06:23:28 -0800 (PST)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id j27sm481078lfh.93.2019.02.14.06.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 06:23:28 -0800 (PST)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH 1/2] xen/gntdev: Do not destroy context while dma-bufs are in use
Date:   Thu, 14 Feb 2019 16:23:20 +0200
Message-Id: <20190214142321.1138-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

If there are exported DMA buffers which are still in use and
grant device is closed by either normal user-space close or by
a signal this leads to the grant device context to be destroyed,
thus making it not possible to correctly destroy those exported
buffers when they are returned back to gntdev and makes the module
crash:

[  339.617540] [<ffff00000854c0d8>] dmabuf_exp_ops_release+0x40/0xa8
[  339.617560] [<ffff00000867a6e8>] dma_buf_release+0x60/0x190
[  339.617577] [<ffff0000082211f0>] __fput+0x88/0x1d0
[  339.617589] [<ffff000008221394>] ____fput+0xc/0x18
[  339.617607] [<ffff0000080ed4e4>] task_work_run+0x9c/0xc0
[  339.617622] [<ffff000008089714>] do_notify_resume+0xfc/0x108

Fix this by referencing gntdev on each DMA buffer export and
unreferencing on buffer release.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/gntdev-dmabuf.c | 12 +++++++++++-
 drivers/xen/gntdev-dmabuf.h |  2 +-
 drivers/xen/gntdev.c        |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index cba6b586bfbd..d97fcfc5e558 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -80,6 +80,12 @@ struct gntdev_dmabuf_priv {
 	struct list_head imp_list;
 	/* This is the lock which protects dma_buf_xxx lists. */
 	struct mutex lock;
+	/*
+	 * We reference this file while exporting dma-bufs, so
+	 * the grant device context is not destroyed while there are
+	 * external users alive.
+	 */
+	struct file *filp;
 };
 
 /* DMA buffer export support. */
@@ -311,6 +317,7 @@ static void dmabuf_exp_release(struct kref *kref)
 
 	dmabuf_exp_wait_obj_signal(gntdev_dmabuf->priv, gntdev_dmabuf);
 	list_del(&gntdev_dmabuf->next);
+	fput(gntdev_dmabuf->priv->filp);
 	kfree(gntdev_dmabuf);
 }
 
@@ -423,6 +430,7 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 	mutex_lock(&args->dmabuf_priv->lock);
 	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
 	mutex_unlock(&args->dmabuf_priv->lock);
+	get_file(gntdev_dmabuf->priv->filp);
 	return 0;
 
 fail:
@@ -834,7 +842,7 @@ long gntdev_ioctl_dmabuf_imp_release(struct gntdev_priv *priv,
 	return dmabuf_imp_release(priv->dmabuf_priv, op.fd);
 }
 
-struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
+struct gntdev_dmabuf_priv *gntdev_dmabuf_init(struct file *filp)
 {
 	struct gntdev_dmabuf_priv *priv;
 
@@ -847,6 +855,8 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
 	INIT_LIST_HEAD(&priv->exp_wait_list);
 	INIT_LIST_HEAD(&priv->imp_list);
 
+	priv->filp = filp;
+
 	return priv;
 }
 
diff --git a/drivers/xen/gntdev-dmabuf.h b/drivers/xen/gntdev-dmabuf.h
index 7220a53d0fc5..3d9b9cf9d5a1 100644
--- a/drivers/xen/gntdev-dmabuf.h
+++ b/drivers/xen/gntdev-dmabuf.h
@@ -14,7 +14,7 @@
 struct gntdev_dmabuf_priv;
 struct gntdev_priv;
 
-struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void);
+struct gntdev_dmabuf_priv *gntdev_dmabuf_init(struct file *filp);
 
 void gntdev_dmabuf_fini(struct gntdev_dmabuf_priv *priv);
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index b0b02a501167..9d8e02cfd480 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -600,7 +600,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	mutex_init(&priv->lock);
 
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
-	priv->dmabuf_priv = gntdev_dmabuf_init();
+	priv->dmabuf_priv = gntdev_dmabuf_init(flip);
 	if (IS_ERR(priv->dmabuf_priv)) {
 		ret = PTR_ERR(priv->dmabuf_priv);
 		kfree(priv);
-- 
2.20.1

