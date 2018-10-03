Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E76AC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EDB213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFjg9l+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EDB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJDAHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:20 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51240 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:20 -0400
Received: by mail-pg1-f202.google.com with SMTP id 17-v6so2431556pgs.18
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bm54riCTpJDeoxMX0Z99Kf+V1AldWinQ4j3SYVndgBc=;
        b=DFjg9l+u97mG+lcg2M7bUIm2YDNO0GYj64mx/5FbRvXJWjo/9r+AjOGifhKwG8onD+
         /nO19ukE3k+vM0unz/CE4oGaRY2Wtf1+D4sh4zrSbMV1Cr7lWRlsktilx4iqGVR8rkYL
         rL4yWBz4/Z7aXeR6nGhRvpGrSZZseInFiojjZ663LkYWtBqTXaHk2iXlsNeywktfqzI7
         CVuwNkUmZTsCEfU6bdoj4On6cAS9QFUHxmTlgnGOvW5IHiqzdzxC2r7wvI8HVN9V615l
         fVS9MJQTvpkyrTHJI8KvBlIU0zUDX9MLkdm6+xJ+pAATgT6Ra7DfQPsbxL3e88FLq4/I
         L9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bm54riCTpJDeoxMX0Z99Kf+V1AldWinQ4j3SYVndgBc=;
        b=Z35ZQZFd4rH/luo8Z8h7xZ8+g0BRo5+4lz8xseM41tnLsZtPzVFAsJ7E+DV9jNwqj8
         MnCjRqn94/C+o1s5yL00mppxR9J7f9ZMMosa4rHbuXJTbaYmgCPePimIB3kemgbWqAJy
         SJVOZcpWcAe47MM4ytdWW7tr5jibTCxWfy2SQbEHknUdcjT3W4ZabIvaKDaJX/RR2Kzn
         P5LUeHQyACJ/xhTNAJc4nkvaIWxQFGOhYa0tRVcobW4No5BIaqRt698A2/GkiW58swf2
         WLkR6jlY8fRFHpQorhLQKCiNrE3kcvlEh/o8i+jMS/kNLAoXYjP8lz4pHbhWgbr8r5qe
         emXg==
X-Gm-Message-State: ABuFfoiB8a5oqIU5TXlvuOYtD/WxYH0zwUJY+LpRbwzHFd4Va/1A6EMC
        kBuKgv32acdR2/vfLoU8QKjvAhFq
X-Google-Smtp-Source: ACcGV63eDpIB60cGeNXthH9yPN2OD8YMe9IaARl5NgPhFxcmaWBaDe746bBKxKU3dkkj1LdZ3hU8zWwn
X-Received: by 2002:a63:1f07:: with SMTP id f7-v6mr989315pgf.32.1538587081973;
 Wed, 03 Oct 2018 10:18:01 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:11 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-6-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 06/15] platform: goldfish: pipe: Move memory allocation
 from probe to init
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

There will be two separate init functions for v1 and v2
(different driver versions) and they will allocate different
state.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c | 42 +++++++++++++----------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index bc431f04c4cf..445c0c0c66c4 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -208,8 +208,6 @@ struct goldfish_pipe_dev {
 	struct device *pdev_dev;
 
 	/* Some device-specific data */
-	int irq;
-	int version;
 	unsigned char __iomem *base;
 
 	/* an irq tasklet to run goldfish_interrupt_task */
@@ -817,14 +815,23 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 }
 
 static int goldfish_pipe_device_init(struct platform_device *pdev,
-				     struct goldfish_pipe_dev *dev)
+				     char __iomem *base,
+				     int irq)
 {
+	struct goldfish_pipe_dev *dev;
 	int err;
 
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->magic = &goldfish_pipe_device_deinit;
+	spin_lock_init(&dev->lock);
+
 	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
 		     (unsigned long)dev);
 
-	err = devm_request_irq(&pdev->dev, dev->irq,
+	err = devm_request_irq(&pdev->dev, irq,
 			       goldfish_pipe_interrupt,
 			       IRQF_SHARED, "goldfish_pipe", dev);
 	if (err) {
@@ -839,6 +846,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 		return err;
 	}
 
+	dev->base = base;
 	dev->pdev_dev = &pdev->dev;
 	dev->first_signalled_pipe = NULL;
 	dev->pipes_capacity = INITIAL_PIPES_CAPACITY;
@@ -892,22 +900,18 @@ static void goldfish_pipe_device_deinit(struct platform_device *pdev,
 static int goldfish_pipe_probe(struct platform_device *pdev)
 {
 	struct resource *r;
-	struct goldfish_pipe_dev *dev;
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->magic = &goldfish_pipe_device_deinit;
-	spin_lock_init(&dev->lock);
+	char __iomem *base;
+	int irq;
+	int version;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r || resource_size(r) < PAGE_SIZE) {
 		dev_err(&pdev->dev, "can't allocate i/o page\n");
 		return -EINVAL;
 	}
-	dev->base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
-	if (!dev->base) {
+
+	base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+	if (!base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		return -EINVAL;
 	}
@@ -916,7 +920,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (!r)
 		return -EINVAL;
 
-	dev->irq = r->start;
+	irq = r->start;
 
 	/*
 	 * Exchange the versions with the host device
@@ -925,12 +929,12 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel(PIPE_DRIVER_VERSION, dev->base + PIPE_REG_VERSION);
-	dev->version = readl(dev->base + PIPE_REG_VERSION);
-	if (WARN_ON(dev->version < PIPE_CURRENT_DEVICE_VERSION))
+	writel(PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
+	version = readl(base + PIPE_REG_VERSION);
+	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	return goldfish_pipe_device_init(pdev, dev);
+	return goldfish_pipe_device_init(pdev, base, irq);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
-- 
2.19.0.605.g01d371f741-goog

