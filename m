Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8731C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB7F20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q03Ykof1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB7F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJDAHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:03 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:32861 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:03 -0400
Received: by mail-vs1-f74.google.com with SMTP id e20-v6so2113113vsl.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2FgyjsgMohzJjsdQ4jm1QY2apbCQQphH7verDaFtLCY=;
        b=q03Ykof1SAvN0bkl+PQ+W/5EfDbUxVliougLPuCoeAmc8ZrH10TtKLpdwJ772BA1TO
         yflEBXVSUnwW9A6PJalNcrJrAWPUiZOeX84R7gER1Y/I4uQ7lYVCWHRrgNkl+3lSUb5q
         q3WuMrZsh2sseh+V4rc+OjGKm3RQFDb4yfwi8p1RDfbk6cZUQpKe+u6fcm490M1QTENC
         /L5Wv/mBkYmjn/QTvOjW2+7t5JA1K1Z9tTshD5PvsGcmraIHTW/n/Jvm1NmuAAV0/EIq
         krth5yKBOhVwOtJpYppmR86BklGETvMm7Pyo5uB1UeHN1uWH4R29OhWGEp1VIA3Jnz4r
         8JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2FgyjsgMohzJjsdQ4jm1QY2apbCQQphH7verDaFtLCY=;
        b=uCrR6QNwm0VYcYFHkL671p+5p9azpr7Ol0i1UKodMQhFHbLnOzijwtyFHn3fDUQuV1
         ejPAlytdhoXcJFxJWyaT69f3G9FoH3JUyZan/bebuWxnuyFTVy5as4bHHtague5C8kVx
         Xgttq1zvRb0JmuULWSVoElVXaPt7q1+csoiVNyigpH4Lcf7szhE/PKC9VODQf6LyR++V
         z+jrSOFLSQO/9liElj90zxSbjLCP6g+hZ1qOmsBGjtp1Fgpl4SViHtOkPK8pK/8tGGzj
         yObh5Zj5mDSDfPncAznxGq7tMIYIZfAAfjY/+CZA0nR/HbZKAvAMoONOYRkP3ZeK3a/S
         w7pQ==
X-Gm-Message-State: ABuFfoi94GMPbuF2OtFQa0xyW1+IA2mxaXqexDKq00ST5dmza2W+mSqL
        VeZKvKG9yAhD98+3pLXUw2ZPWmf4
X-Google-Smtp-Source: ACcGV61RE7fJo9UIVxmftIClqOXiURgUIB9KHImUJPoX5KpnDaFpqDu9/t0nETI8qki/SbOYL4fNc2im
X-Received: by 2002:a1f:b3c3:: with SMTP id c186-v6mr2180850vkf.7.1538587065238;
 Wed, 03 Oct 2018 10:17:45 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:06 -0700
Message-Id: <20181003171720.169953-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 01/15] platform: goldfish: pipe: Move the file-scope
 goldfish_interrupt_tasklet variable into the driver state
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

This is a series of patches to move mutable file-scope variables
into the driver state. This change will help to introduce another
version of the pipe driver (with different state) for the older
host interface or having several instances of this device.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - Updated the commit message.

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

