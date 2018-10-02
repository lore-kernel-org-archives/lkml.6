Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520D5C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C72208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW4PUxZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C72208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJCFFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:05:42 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:57164 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:05:42 -0400
Received: by mail-it1-f202.google.com with SMTP id i188-v6so4951005itf.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h/vg1U5Bs8q6OZJRNNuW9qMPUzJCrOG2DRsiFTiSuxg=;
        b=LW4PUxZq2JH2KEm+rSDCjo+9bvgoDlhGOy3o2+ubHC8RD/Uy9KWjWCOszNYx7thqlu
         dNzhTcs1dp2VXN1ZHzn/Wy2LBXzAxYn+TgjO3lU+dvE5qOoDqj5avfYgXmrI/NASGqem
         +s3Llz3mUhGyGH/QzVfxHzR5il50dydPyELYEuQCMTnxiOSPLayUBKtylEN29VzaT4Ba
         K1NwNNuyNAP23MirXqKzOpzgpTu0UhZTrrz7I8Sg6jD0kYNGfp/lQwM5ClWKataYXwx6
         rmOaeFO/3oNY+LMb8fcEYwUxz467935kTs2YdREF2oyPbRMB1U8bGkjTOwj9k0OKnMgb
         1P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h/vg1U5Bs8q6OZJRNNuW9qMPUzJCrOG2DRsiFTiSuxg=;
        b=LdTz/1uWB8Oejgxa5zXe5XoMZjMVv8RYiBqtbtdYPBl2E4rZJEgJsiEXp7YiGs6tAk
         deNbzXvBzfIpiMi4Kn3BT/hMeeaiA8ZXw2DRxtfW81eDsTI8cHtYD5XrTNn8Ecwe2Bu3
         ZZ6QOEp8k5dvsBxPhsYZ2KOCxMv7Ly62EQHb7RKSkN/AUgvpx2Var4Q+/zsiHnI+tx0m
         aHuhrtMiTdI84ldtJBkPKhx2j1SPXnZ4AAEYT0ojX+1Md+Fo/fh6ufiYNlGatt8Y5jJK
         DOR7dVwVAjcGozTlqbHZnmf1M7xEy9c4z4liMv0YiDxgtVJKMmwDypzE0Vb72qdcEJ/P
         7Acg==
X-Gm-Message-State: ABuFfog1fyPPCW6Kj3RPUbjfz0gw1OdKEaaRrNzSTbmgZrEqqZ5wvcYu
        frJ4d+gCRUIAk0MNZHI4RT6/NQPi
X-Google-Smtp-Source: ACcGV630VEbl3fW4YorvDRUumpQnyRU9W+XRngF+NLKPh/8ncoN9Ub+BBkgecdsun9oNrf7w85uJVJuD
X-Received: by 2002:a24:d49:: with SMTP id 70-v6mr3487202itx.5.1538518807438;
 Tue, 02 Oct 2018 15:20:07 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:49 -0700
Message-Id: <20181002221903.19476-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 01/15] platform: goldfish: pipe: Remove the
 goldfish_interrupt_tasklet global variable
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

This is a series of patches to remove mutable global variables
to introduce another version of the pipe driver for the older
host interface. I don't want to have two driver states where only
one is used.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 24 +++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 56665e879e5a..ba9aede17d57 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -208,6 +208,9 @@ struct goldfish_pipe_dev {
 	int irq;
 	int version;
 	unsigned char __iomem *base;
+
+	/* an irq tasklet to run goldfish_interrupt_task */
+	struct tasklet_struct irq_tasklet;
 };
 
 static struct goldfish_pipe_dev goldfish_pipe_dev;
@@ -582,14 +585,14 @@ static struct goldfish_pipe *signalled_pipes_pop_front(
 	return pipe;
 }
 
-static void goldfish_interrupt_task(unsigned long unused)
+static void goldfish_interrupt_task(unsigned long dev_addr)
 {
 	/* Iterate over the signalled pipes and wake them one by one */
+	struct goldfish_pipe_dev *dev = (struct goldfish_pipe_dev *)dev_addr;
 	struct goldfish_pipe *pipe;
 	int wakes;
 
-	while ((pipe = signalled_pipes_pop_front(&goldfish_pipe_dev, &wakes)) !=
-			NULL) {
+	while ((pipe = signalled_pipes_pop_front(dev, &wakes)) != NULL) {
 		if (wakes & PIPE_WAKE_CLOSED) {
 			pipe->flags = 1 << BIT_CLOSED_ON_HOST;
 		} else {
@@ -605,7 +608,6 @@ static void goldfish_interrupt_task(unsigned long unused)
 		wake_up_interruptible(&pipe->wake_queue);
 	}
 }
-static DECLARE_TASKLET(goldfish_interrupt_tasklet, goldfish_interrupt_task, 0);
 
 /*
  * The general idea of the interrupt handling:
@@ -648,7 +650,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	tasklet_schedule(&goldfish_interrupt_tasklet);
+	tasklet_schedule(&dev->irq_tasklet);
 	return IRQ_HANDLED;
 }
 
@@ -800,9 +802,14 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 static int goldfish_pipe_device_init(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
-	int err = devm_request_irq(&pdev->dev, dev->irq,
-				goldfish_pipe_interrupt,
-				IRQF_SHARED, "goldfish_pipe", dev);
+	int err;
+
+	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
+		     (unsigned long)dev);
+
+	err = devm_request_irq(&pdev->dev, dev->irq,
+			       goldfish_pipe_interrupt,
+			       IRQF_SHARED, "goldfish_pipe", dev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to allocate IRQ for v2\n");
 		return err;
@@ -854,6 +861,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
 	misc_deregister(&goldfish_pipe_miscdev);
+	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
 	kfree(goldfish_pipe_dev.pipes);
 	free_page((unsigned long)goldfish_pipe_dev.buffers);
 }
-- 
2.19.0.605.g01d371f741-goog

