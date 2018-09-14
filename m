Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C1ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3ED20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSJdTOI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3ED20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeINXIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:10 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:33445 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeINXIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:10 -0400
Received: by mail-io1-f73.google.com with SMTP id s14-v6so9474312ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pyz7D5yfP+NwIsfgDDo9dr4phFAR5bRy/Nwh9J24D9w=;
        b=rSJdTOI56AYlPv0a0lbKEP3DhTyzWOE3O+GLKpoQzMHIDyvUL0Yh1Ey9Q8WEvigOl1
         41E1tDhDVYR9m6UViPPcHGViDQMVSFEpznHGIXphUKIy0v0lR6HvLyM0MeaZwzAL6ZmE
         CM8Wnzh4alQI88m32yevZYRwECbVcn/QbfQXk0FpSCaIly+Hfd04tIx3FxMEi3lLplSq
         4Wk3F4T8umwmSKcgO0LblrW81bgKM2MaSIxY+SG3dE/ybk++FMFBfCL8r/oxxFpHzvSg
         zw9TsTNXSJBmwDFZQRLpg+0hAPnicUYtcxw96m459l6Iq++KUHgA/p4tQyHUqaBcRvHD
         86QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pyz7D5yfP+NwIsfgDDo9dr4phFAR5bRy/Nwh9J24D9w=;
        b=iB/iAe8eoQsFDltli1SGVYqwQ0jxLrcv6oFi78AqOqJKnHPvDfUefNZcKbTQ8LVdqc
         8X3CSydEBx7l/80u63ErC+7dCnBXvFltEiOqSJ4hNuapGzRkSbTUZa6yPki4rqwIy+5k
         kXNgPITUbF/dSnxqde6XrUWy+xtXJNoa2sg6P6Z1y61mMNV527m+PA9YuokINEoIGBmq
         IaFe7pwNT4f2zGeZjxCoOn+XSzp5BkNrRXTmLmw5MBK35xv/V1u0i/WoDQ3VKpd9SGj6
         CsYpPzA3J0WlQOFBtGZ8+Yx7lqmZfjnPb8C+ViB6Q1FyLDZ380G/GHXrclrN3i4h0Lzp
         //yQ==
X-Gm-Message-State: APzg51CpROfzNpaLHzpXQjb7/wWF1+Fcul38phAXurPEjA4lPKeZmUiW
        R1gedjCezvc17ChxzNexyj1yEJsD
X-Google-Smtp-Source: ANB0Vdatnt4yYDFbTJyv+RGQEMoseSxY+Lcab+eAz9JDDaAVLphCfEgqg4hKH/Ry2TTW9A5N0iDuNpF7
X-Received: by 2002:a6b:d91a:: with SMTP id r26-v6mr10362020ioc.60.1536947556132;
 Fri, 14 Sep 2018 10:52:36 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:12 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-11-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 11/21] platform: goldfish: pipe: Move memory allocation from
 probe to init
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

There will be two separate init functions for v1 and v2 and they
will allocate different state.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe_v2.c | 41 +++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index c68035be4389..ccde28abcb24 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -241,8 +241,6 @@ struct goldfish_pipe_dev {
 	struct device *pdev_dev;
 
 	/* Some device-specific data */
-	int irq;
-	int version;
 	unsigned char __iomem *base;
 
 	/* an irq tasklet to run goldfish_interrupt_task */
@@ -1125,14 +1123,23 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
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
@@ -1147,6 +1154,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 		return err;
 	}
 
+	dev->base = base;
 	dev->pdev_dev = &pdev->dev;
 	dev->first_signalled_pipe = NULL;
 	dev->pipes_capacity = INITIAL_PIPES_CAPACITY;
@@ -1197,22 +1205,17 @@ static void goldfish_pipe_device_deinit(struct platform_device *pdev,
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
+	base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+	if (!base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		return -EINVAL;
 	}
@@ -1221,7 +1224,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (!r)
 		return -EINVAL;
 
-	dev->irq = r->start;
+	irq = r->start;
 
 	/*
 	 * Exchange the versions with the host device
@@ -1230,12 +1233,12 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel((u32)PIPE_DRIVER_VERSION, dev->base + PIPE_REG_VERSION);
-	dev->version = readl(dev->base + PIPE_REG_VERSION);
-	if (WARN_ON(dev->version < PIPE_CURRENT_DEVICE_VERSION))
+	writel((u32)PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
+	version = readl(base + PIPE_REG_VERSION);
+	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	return goldfish_pipe_device_init(pdev, dev);
+	return goldfish_pipe_device_init(pdev, base, irq);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
-- 
2.19.0.397.gdd90340f6a-goog

