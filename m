Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B676C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5D208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYk3rivE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C5D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJCFGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:00 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:54035 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:05:59 -0400
Received: by mail-io1-f74.google.com with SMTP id t22-v6so2398315ioc.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FygyPVxby0KPbnU/slZqgrgrOyyCkhv2g/IDUsh5K4k=;
        b=pYk3rivEpG+UC2eGjjx43jioHq9lYfeMEH2uPSwRJH2MRnJQ7zVk1NFafY50Ii6AjJ
         35efI/s+N45PM6lnluEIdLKkNWywn2SQeZVul1VZHFWynMcc6IF3pAASyS0STkW+hVYr
         2kn/Vm/Nc/OiUULAgIEPVBBlF327mK6HpbFGZJSpDU6Juy7CpssI5Xf6UIM9XNb+mXuv
         3qgEHuDu4WE7VvvXHV4GHMkivpL22GQCiyqGcuYdf22bJ2lXA+98GBuiz2bZYfxWpw0c
         wnJNUK+cK2s/zTdvWPVZvCj17M1nvWVPkkmsd6ekVuVUVHOOl773ns1WmSbUcT3Dp/42
         5lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FygyPVxby0KPbnU/slZqgrgrOyyCkhv2g/IDUsh5K4k=;
        b=E005KQ0EX2hgT4idUQb+eU6ZwkMr7maHkj4jLcqCLy/d0mzSuF6i3XFN2i7/BVNGrN
         +PbjKP9hK1Dr/Ug3dALp2trg1vLcA2sawPphNOUP8ovlysLVK4utC0bVrnyB+v5T18Vr
         1A9FdFfBe/VnX1qToeGto5i4RD3EivN1yVtkz9cGpPtY1QWrrgFB4lJz4VY7OaBNRB0v
         ls0tbwpS+D7SpEw1RbBz78erHyy+qOSQ3mRij94qusrQBNBeqZddqAKHlX8R+zvM3Zk3
         JKlsZ7x24m6rxCeeGXyC/bYIutl7cB1t9l4emd/mMEw9dhKRQ805QvEXNrA37mAQOcCk
         tZzA==
X-Gm-Message-State: ABuFfoidaeSpEJaXO4TNqsUDsBctj6nVyr14gs3Xl3+/I+VUmMwVxmiI
        AkASGsbiHlsxieqGrnCfxHMoD7ZL
X-Google-Smtp-Source: ACcGV63IbLxpDFsX7kHOAp7bIF+BmqgnB6aItSKz7TkOYCJuyXrdkGPPst9JHLIbHZKEjSOtbz4A5G2J
X-Received: by 2002:a24:6b97:: with SMTP id v145-v6mr3451471itc.40.1538518825207;
 Tue, 02 Oct 2018 15:20:25 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:54 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-6-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 06/15] platform: goldfish: pipe: Move memory allocation from
 probe to init
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

