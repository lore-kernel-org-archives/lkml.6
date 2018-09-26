Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DBFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DE32154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GV0U4nXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DE32154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeI0FSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:18:38 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:36124 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0FSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:18:38 -0400
Received: by mail-it1-f201.google.com with SMTP id t18-v6so5558044ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sbagc6xRpMxzzlNAN7tsxIa/IFWtM9sf2COaGmuTnaM=;
        b=GV0U4nXm5G6qJpUhrljy1GDRKdwbo6/ltb+z99uCb/vZF+aB9iur5pvO8hw6F6PYsf
         Xu89bIARi3+jo824eieVLJWqgbQM02Homd6GwuZ8/pglldV1uEGZCAnfKQM/Jzf7nnpn
         N/1fw1Xe/4naRt6O0Y5ynEbcXwouylw/qX3nNDjAPTjB5tsdI+p81CqKGsPgS+5EbYSs
         lzzl83Npeh85xpPbt0wgPRnv0tZRw9HXVdQyI9cbNNGoCWB29S8zAkp6JS9u8VkSboFT
         CdDmXNP1d7JIEpg5lAc81yMkd+xoKLpPWoapU1DSw6LkXfL86OjT3unIjExPSBuQLFCF
         nEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sbagc6xRpMxzzlNAN7tsxIa/IFWtM9sf2COaGmuTnaM=;
        b=pQzyMXfDVU7l7e5j4ucrq1HD54WlrsnUVDGXWAhn5qTwqEjTcB8Zz2PSz0UFeZY4H8
         NAR3cDLMhwjn/4QndIVip96plDOKZIuj4p+sQTFoWayIqem8GGJK3fh99fsKeQiIXm1z
         oo+KzC9VlTYyxDYqnGqh6DW+MjDug8ZrWZJAaUDYig0k3fdpOaYeig/HTsDzsR1fYhvf
         Y+FMoryD9AFVINd29MroJa+VKy17/LSwqAiU/bL4IawQPXSmX53AI9RlS9jzxB334Fr/
         J8nwchW+6idUaQiBNQD5/cYeFX39YMhXOSr1EyASFboh8vJCThnmvRZGVnT2kblusPyv
         AOhQ==
X-Gm-Message-State: ABuFfojPl1HkCg0FMXuxEI7MuBnt1GEDVRlGcyIOAEOhDoH4mmZm+Bmj
        K1RT1C7ceJuxfubfaBpWj2cFYqFF
X-Google-Smtp-Source: ACcGV62lx75bCgsof7CMMD9xme+VHGMEUcNPdNi3C8+YIUq1FJGha2WCv38gkb9kTd9tCiWlYSy7LSb+
X-Received: by 2002:a6b:8fd1:: with SMTP id r200-v6mr5551811iod.72.1538003002138;
 Wed, 26 Sep 2018 16:03:22 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:02:20 -0700
In-Reply-To: <20180926230222.126513-1-rkir@google.com>
Message-Id: <20180926230222.126513-2-rkir@google.com>
Mime-Version: 1.0
References: <20180926230222.126513-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 09/21] platform: goldfish: pipe: Remove the
 goldfish_pipe_dev global variable
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This is the last patch in the series of patches to remove mutable
global variables to introduce another version of the pipe driver
for the older host interface. I don't want to have two driver
states where only one is used.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - Rebased to address that goldfish_pipe_dev is static now.

 drivers/platform/goldfish/goldfish_pipe.c | 66 +++++++++++++----------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index b0cf4e59c0ec..c68035be4389 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -202,6 +202,9 @@ struct goldfish_pipe {
  * waiting to be awoken.
  */
 struct goldfish_pipe_dev {
+	/* A magic number to check if this is an instance of this struct */
+	void *magic;
+
 	/*
 	 * Global device spinlock. Protects the following members:
 	 *  - pipes, pipes_capacity
@@ -251,8 +254,6 @@ struct goldfish_pipe_dev {
 	size_t dma_alloc_total;
 };
 
-static struct goldfish_pipe_dev goldfish_pipe_dev;
-
 static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
 				    enum PipeCmdCode cmd)
 {
@@ -647,6 +648,9 @@ static void goldfish_interrupt_task(unsigned long dev_addr)
 	}
 }
 
+static void goldfish_pipe_device_deinit(struct platform_device *pdev,
+					struct goldfish_pipe_dev *dev);
+
 /*
  * The general idea of the interrupt handling:
  *
@@ -667,7 +671,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev != &goldfish_pipe_dev)
+	if (dev->magic != &goldfish_pipe_device_deinit)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -719,6 +723,14 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
 	return id;
 }
 
+/* A helper function to get the instance of goldfish_pipe_dev from file */
+static struct goldfish_pipe_dev *to_goldfish_pipe_dev(struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+
+	return container_of(miscdev, struct goldfish_pipe_dev, miscdev);
+}
+
 /**
  *	goldfish_pipe_open - open a channel to the AVD
  *	@inode: inode of device
@@ -732,7 +744,7 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
  */
 static int goldfish_pipe_open(struct inode *inode, struct file *file)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
+	struct goldfish_pipe_dev *dev = to_goldfish_pipe_dev(file);
 	unsigned long flags;
 	int id;
 	int status;
@@ -1112,9 +1124,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-static int goldfish_pipe_device_init(struct platform_device *pdev)
+static int goldfish_pipe_device_init(struct platform_device *pdev,
+				     struct goldfish_pipe_dev *dev)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	int err;
 
 	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
@@ -1169,26 +1181,29 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		      dev->base + PIPE_REG_OPEN_BUFFER,
 		      dev->base + PIPE_REG_OPEN_BUFFER_HIGH);
 
+	platform_set_drvdata(pdev, dev);
 	return 0;
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev)
+static void goldfish_pipe_device_deinit(struct platform_device *pdev,
+					struct goldfish_pipe_dev *dev)
 {
-	misc_deregister(&goldfish_pipe_dev.miscdev);
-	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
-	kfree(goldfish_pipe_dev.pipes);
-	free_page((unsigned long)goldfish_pipe_dev.buffers);
+	misc_deregister(&dev->miscdev);
+	tasklet_kill(&dev->irq_tasklet);
+	kfree(dev->pipes);
+	free_page((unsigned long)dev->buffers);
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)
 {
-	int err;
 	struct resource *r;
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
+	struct goldfish_pipe_dev *dev;
 
-	/* not thread safe, but this should not happen */
-	WARN_ON(dev->base);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
+	dev->magic = &goldfish_pipe_device_deinit;
 	spin_lock_init(&dev->lock);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1203,10 +1218,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (!r)
+		return -EINVAL;
+
 	dev->irq = r->start;
 
 	/*
@@ -1221,20 +1235,14 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (WARN_ON(dev->version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	err = goldfish_pipe_device_init(pdev);
-	if (!err)
-		return 0;
-
-error:
-	dev->base = NULL;
-	return err;
+	return goldfish_pipe_device_init(pdev, dev);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
-	goldfish_pipe_device_deinit(pdev);
-	dev->base = NULL;
+	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
+
+	goldfish_pipe_device_deinit(pdev, dev);
 	return 0;
 }
 
-- 
2.19.0.605.g01d371f741-goog

