Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB9FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7767E20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Td6lJVZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7767E20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeINXHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:55 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:48251 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:54 -0400
Received: by mail-ua1-f73.google.com with SMTP id i4-v6so3090991ual.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CX5wLBZla2yAn71djUxLcYeQ8kWWWoMXBJ0sXHF5X4k=;
        b=Td6lJVZuxK6zJ9XAx5XfsVsNF7mL6rIM6eFUOHUf+YZ9DcUkNjy3NKYdPDBjgTT8uc
         YKi1SaDE1tnWr3vtzOjv918scQoXTCHOSJb9fEioGxl9E2iKI3hjVSZ82e/6C7GZQiZu
         QXmouVZHFZDt/ht8ZeOIXJprnnS4SJAObVRYzabuq8LXxTUxZLxvVOw0QY83Z17nn11B
         10QystdOPb+eu8dAXfIEAGfe7hM4+jOMYqPs2SFxW07u3xlvp+H612ZGhm2sgjSoVCgg
         Re9GnQ7qmN3bqhoaG1zQmKm50vDm+5nvU3hGM61crGXTwePokD51bEiZa7QJEDiv4g3x
         uRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CX5wLBZla2yAn71djUxLcYeQ8kWWWoMXBJ0sXHF5X4k=;
        b=hCJkmypSv9RpUJUJcUksq6SApo8oZo7Orieivg8DogQUr7Hn7qDlqJjZgF2sr/E3pL
         DbwKCkZ7v6PNKes2QS2kgRV15xUy6JmJIwrawjXGp+usLLH2H68QEA4MhBm9PaXY4ARv
         I1qmVq8Pb7HbNixqt4orcc14aqVcsrDd9b31DuQlC63aug4t8DDF+cBZg/n/G0Nxgkdt
         QAKaIpvf3OI/Fef3D7+E8QeUIP0JxoFnbZ5eX6Zc4FzT6bzVE8MyMptU54QdhXncQG84
         Uqdyl1I87PyGu0Fo/1iRiAdgf0JeQ1+j1rhkgVS5tfDZ6qmSyg1nrfFqGURwrsSPB1WR
         l/Aw==
X-Gm-Message-State: APzg51Any8XFHM0AvF7oGkB/VrgB8rFDgq0qEnCFNEZrIMsNZPEGXAat
        VWpZA328i9e+8eCK/hEyx5gtUgmH
X-Google-Smtp-Source: ANB0VdYboaU0kabT+AeWDcCDleh0dx7HOFj7mn9uH+Yaeq/HqVItPTfKQxCrpaOVDLRVBZRhwEqRaY66
X-Received: by 2002:ab0:4b64:: with SMTP id i36-v6mr2548353uaf.22.1536947540890;
 Fri, 14 Sep 2018 10:52:20 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:09 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-8-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 08/21] platform: goldfish: pipe: Remove the
 goldfish_pipe_miscdev global variable
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
host interface. I don't want to have two driver states where
only one is used.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 8a5ce7c01f11..53832e46ad1a 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -245,6 +245,8 @@ struct goldfish_pipe_dev {
 	/* an irq tasklet to run goldfish_interrupt_task */
 	struct tasklet_struct irq_tasklet;
 
+	struct miscdevice miscdev;
+
 	/* DMA info */
 	size_t dma_alloc_total;
 };
@@ -1093,11 +1095,14 @@ static const struct file_operations goldfish_pipe_fops = {
 	.compat_ioctl = goldfish_dma_ioctl,
 };
 
-static struct miscdevice goldfish_pipe_miscdev = {
-	.minor = MISC_DYNAMIC_MINOR,
-	.name = "goldfish_pipe",
-	.fops = &goldfish_pipe_fops,
-};
+static void init_miscdevice(struct miscdevice *miscdev)
+{
+	memset(miscdev, 0, sizeof(*miscdev));
+
+	miscdev->minor = MISC_DYNAMIC_MINOR;
+	miscdev->name = "goldfish_pipe";
+	miscdev->fops = &goldfish_pipe_fops;
+}
 
 static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 {
@@ -1123,7 +1128,8 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		return err;
 	}
 
-	err = misc_register(&goldfish_pipe_miscdev);
+	init_miscdevice(&dev->miscdev);
+	err = misc_register(&dev->miscdev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register v2 device\n");
 		return err;
@@ -1168,7 +1174,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
-	misc_deregister(&goldfish_pipe_miscdev);
+	misc_deregister(&goldfish_pipe_dev.miscdev);
 	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
 	kfree(goldfish_pipe_dev.pipes);
 	free_page((unsigned long)goldfish_pipe_dev.buffers);
-- 
2.19.0.397.gdd90340f6a-goog

