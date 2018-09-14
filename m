Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE91FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8EA20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvcs9p5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8EA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeINXIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:01 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:41620 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:01 -0400
Received: by mail-yb1-f201.google.com with SMTP id p4-v6so6701221yba.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1tbSLqoerGQU+IRntBzG8zZnMy13hYy2jTTN21lMTaw=;
        b=vvcs9p5JmpQ27slH6SB+Hg5QX+1hdkC/O4lYilsQhiPMoycNlC4inO2nt75Q3ZlAg3
         8QvC1vfJawTt6z5CrQf9qTijPY6FVzoJqY8yqQSW4OS1BCFTwC3lQGERWlL855l1oR8k
         rjeXjLg4utiR+Pw5vEXGshJPfroVyMp5/xLDvgEhjNf2aSGGfiHZeL0T+TuXjdIcWWi5
         p7GEMFzMKsjjK/McsfcefUH+0JlpEIJj8TXGx+QLCiq9+gpFO/3btJxstw1A+4eMF/Nd
         5ufeR9pNz2bYYNbboGCn15Hp4xVyX8fbh8bRNUpgl75euNm6xuUljyx+nBAtzowE9q+7
         WElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1tbSLqoerGQU+IRntBzG8zZnMy13hYy2jTTN21lMTaw=;
        b=j3jewvsD3pI6THEWTrO/R3j7LeogDO/UHZCGbVinM/pN4/hVU63RhkLyxMQFoAUHQF
         yMlusbv48H3ptbeHJkVlVoTiY4k6KM9tz2S3HWcMozhjZNN6vq8BM8PUHUydp2ag0ZNb
         YmQ7KnskLurlWAA1YQ8i3DGHV0iAsteuctTXHhbQb/Y3MLZ8t4uimEGAS/WCQ44aqTpV
         hPOThPeL9/BGGBJJFesfIh6DJxYmuEIkD5kNLsNAPaZtuGRENM53LoQc0ccwi1lKEmk4
         QpyVJyOOVw+fQ/661L8n5q8PNKx9TYvDNlYa3MJV3kK1NUlop7a98A5sox35r+m4Gfcm
         u1WA==
X-Gm-Message-State: APzg51Csi2NrRBAlAaNbry8+jYtLFdhOW5AS66tfgK5Bqui4q8XrJ18k
        Z3dlql4IuVXCjtrqHBuEPm9EV0nL
X-Google-Smtp-Source: ANB0VdbB6tkJOGZlJ1L3iJyTcN4ZW7J5ZB2Hz+me01ulgzSrnYcuCVr2yDyPTrMtoBlBPtc7rcrGgO+i
X-Received: by 2002:a25:aace:: with SMTP id t72-v6mr2008828ybi.55.1536947547294;
 Fri, 14 Sep 2018 10:52:27 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:10 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-9-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 09/21] platform: goldfish: pipe: Remove the goldfish_pipe_dev
 global variable
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
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
 drivers/platform/goldfish/goldfish_pipe.c | 66 +++++++++++++----------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 53832e46ad1a..c68035be4389 100644
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
 
-struct goldfish_pipe_dev goldfish_pipe_dev;
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
2.19.0.397.gdd90340f6a-goog

