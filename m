Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C48FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B537620853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZArG+zUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B537620853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeINXHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46238 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id x85-v6so4993116pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KxOD7cpoHpP0etCc+j6bQ9uyj2TSRlPsUmZMd9SZNsI=;
        b=ZArG+zUSP5KrLEv/WjuHwdgndosOm0xyQhT64flaIkrYUZJNGYKHmrRlAHNcAu7bqs
         ERqKheRyshk5lq0X//3mjv8PDWD2Mvu+yBPC9b0UKJmQ9Ayiqjki8VXf5fWGnLIXFW9M
         8tUkb06pcusdVIICxBDoTt3Ce1ejGG7x7Vss0BwfTpRX5/nYpKPa4l127Ws1yvUAn+GC
         kskryMfodvd9C+Ib/wDKfiHIowz+mZIsez8GTy43CBHX6l9bccsT/xJeA3OVgBlYWeqU
         aoDrQFamRHvExnCxXWPTvdaqTQzFY6uxrnnaI+sH+Y5/tByyNzeSGY0GE+4ZwasELpbf
         rpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KxOD7cpoHpP0etCc+j6bQ9uyj2TSRlPsUmZMd9SZNsI=;
        b=Mz+9VuAVp2HOxGajFhnvSSgfrD7rxv1Hyo/aDdQ4/Y/3fLhLav3Dtf+A6szEfUIswN
         Npl/rYWpmaAyjspx0HkfKf5ef4jK6YFZfgZAIRK9ye5JKEdnftb47HTSMiQNufWWvz2c
         R6OPMzaizXnlvrBtuWuY3Kynfk4j5s3bwr6paAQ35uiPB7NPW/6vb1Rm/1AKkZM7UPez
         byThzLRtbyMMC7iJ7Nhh8TTW9rcsF7fHxMXZktBiDr+ts6i6+myzU8sgPmCdHCpFTbHM
         jMw66HiN5iXR6ozPKCqLsIePBlj/zM8rmzdc7Ry8joPbZkTvNrBihGbM2ihxxF6WVQI4
         CDVA==
X-Gm-Message-State: APzg51AXw/JHbq0WsaZrPniBNGBdW943vCnG4dQh6313qvalnh3S0I/T
        CC4+yaoUEbOst/ZLQzyC16Riy1D/
X-Google-Smtp-Source: ANB0Vdau15JopWM0EdRRZInEr/CbS+N472rlpu7Az7+jMFFSWSBNgYVylRZVT5keIBIvbs97TfObTYYp
X-Received: by 2002:a63:8b42:: with SMTP id j63-v6mr675744pge.19.1536947536580;
 Fri, 14 Sep 2018 10:52:16 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:08 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-7-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 07/21] platform: goldfish: pipe: Remove the
 goldfish_interrupt_tasklet global variable
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

This is a series of patches to remove mutable global variables
to introduce another version of the pipe driver for the older
host interface. I don't want to have two driver states where only
one is used.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 24 +++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 064a50a7f187..8a5ce7c01f11 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -242,6 +242,9 @@ struct goldfish_pipe_dev {
 	int version;
 	unsigned char __iomem *base;
 
+	/* an irq tasklet to run goldfish_interrupt_task */
+	struct tasklet_struct irq_tasklet;
+
 	/* DMA info */
 	size_t dma_alloc_total;
 };
@@ -618,14 +621,14 @@ static struct goldfish_pipe *signalled_pipes_pop_front(
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
@@ -641,7 +644,6 @@ static void goldfish_interrupt_task(unsigned long unused)
 		wake_up_interruptible(&pipe->wake_queue);
 	}
 }
-static DECLARE_TASKLET(goldfish_interrupt_tasklet, goldfish_interrupt_task, 0);
 
 /*
  * The general idea of the interrupt handling:
@@ -684,7 +686,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	tasklet_schedule(&goldfish_interrupt_tasklet);
+	tasklet_schedule(&dev->irq_tasklet);
 	return IRQ_HANDLED;
 }
 
@@ -1108,9 +1110,14 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
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
@@ -1162,6 +1169,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
 	misc_deregister(&goldfish_pipe_miscdev);
+	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
 	kfree(goldfish_pipe_dev.pipes);
 	free_page((unsigned long)goldfish_pipe_dev.buffers);
 }
-- 
2.19.0.397.gdd90340f6a-goog

