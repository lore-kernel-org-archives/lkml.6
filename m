Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19F1C65BA7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AE4208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRK5o95W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AE4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJCFFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:05:49 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:42910 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:05:48 -0400
Received: by mail-io1-f74.google.com with SMTP id m7-v6so3806490iop.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=074mm3tuAAJYVUsSMvHe/EIvUURLOXBQbw9R8ihxjoA=;
        b=bRK5o95WL1uZ11Ub7w2h2NMaOCnUHVHQgFJI6mo3A2q3mhusCdPo2QnMlCwHHPLfe0
         tXxyNgH+GiXZquPQcoHeTNBerwDw2fMmV4YMlfTescjMwyvgcoPPSDobZyh7cHu9kK5L
         bIAjL3iusoQ9ys6kYLt+OPgQ3AuFfP421cBrDEXi2rAtsmeqbht4w/4x2iVZZhlqJyi8
         jFbbs14a5ZnyEq/xTJfaXIBmhFVVMbztQK6yug3KEdj6TQpELHfe7ueoj4+IxKXWAfdW
         HQrRQZlutaH/bY5mekysQIKKPdDn9AoZ247Znm3kQW3qCMySa6Fn65lOEJay+VwMY5No
         pmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=074mm3tuAAJYVUsSMvHe/EIvUURLOXBQbw9R8ihxjoA=;
        b=SFmVfM2LL9c/Py1Zmk1eho7loc30D+z+LUxo12LSGskK1ZjKn1EwpCNZ5GzTw34mTs
         0Bxdikb2M9cagU9C85l42bHBtcwzd3suZOVuSrg/Eow3gmc9mdLVAT6xR/EPwFoZh8Lf
         yrGl291WXSTU/QtAzuFBGNZv+Q/qIo5VNeP6hKejR7iBfSUVi2kIag6B5GymY8wDCOpS
         /XIPDQgndOXoyCIpEyg0V2/apXEalNbETI1uRN3zAQUDmPAxSCNQrutLLJHEm5mn6tbn
         HMxOnNufl+noTiRxZMSR4LByXQpb+AoEDTx8WGyAnnkJMlbow0GUqPT/qVm9ZS7/T+Z7
         hqdA==
X-Gm-Message-State: ABuFfogPNC4b7aJkI6Y7s0dd9oNgV8+nm7ujQyqKkzm+O7DH7X8fyrUh
        vtkke5Wzhp1jXhphhTuaTaYBkdND
X-Google-Smtp-Source: ACcGV60eNNtbHtZGg+UUWANtZaHZ5QRf0TniqA+aKQ3JjZITi1pn8n6F1Lufwdb+p5vO/vo8VZhWw3Ec
X-Received: by 2002:a24:fe01:: with SMTP id w1-v6mr3586494ith.0.1538518813375;
 Tue, 02 Oct 2018 15:20:13 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:51 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-3-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 03/15] platform: goldfish: pipe: Remove the goldfish_pipe_dev
 global variable
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
 drivers/platform/goldfish/goldfish_pipe.c | 66 +++++++++++++----------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 8ca709b45e1f..4013832f38fb 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -169,6 +169,9 @@ struct goldfish_pipe {
  * waiting to be awoken.
  */
 struct goldfish_pipe_dev {
+	/* A magic number to check if this is an instance of this struct */
+	void *magic;
+
 	/*
 	 * Global device spinlock. Protects the following members:
 	 *  - pipes, pipes_capacity
@@ -215,8 +218,6 @@ struct goldfish_pipe_dev {
 	struct miscdevice miscdev;
 };
 
-static struct goldfish_pipe_dev goldfish_pipe_dev;
-
 static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
 				    enum PipeCmdCode cmd)
 {
@@ -611,6 +612,9 @@ static void goldfish_interrupt_task(unsigned long dev_addr)
 	}
 }
 
+static void goldfish_pipe_device_deinit(struct platform_device *pdev,
+					struct goldfish_pipe_dev *dev);
+
 /*
  * The general idea of the interrupt handling:
  *
@@ -631,7 +635,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev != &goldfish_pipe_dev)
+	if (dev->magic != &goldfish_pipe_device_deinit)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -683,6 +687,14 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
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
@@ -696,7 +708,7 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
  */
 static int goldfish_pipe_open(struct inode *inode, struct file *file)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
+	struct goldfish_pipe_dev *dev = to_goldfish_pipe_dev(file);
 	unsigned long flags;
 	int id;
 	int status;
@@ -804,9 +816,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-static int goldfish_pipe_device_init(struct platform_device *pdev)
+static int goldfish_pipe_device_init(struct platform_device *pdev,
+				     struct goldfish_pipe_dev *dev)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	int err;
 
 	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
@@ -861,26 +873,29 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
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
@@ -895,10 +910,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
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
@@ -913,20 +927,14 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
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

