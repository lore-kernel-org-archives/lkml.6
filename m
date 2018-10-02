Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E1CC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2D320645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/EGNlSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2D320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJCF4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:56:18 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:33695 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCF4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:56:18 -0400
Received: by mail-io1-f74.google.com with SMTP id c5-v6so3856657ioa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v1/PuiYfXT6aW7CBjL7YO5ci4U91JrGo4Hi2aBBjbu4=;
        b=S/EGNlSlHqqGdAhWPXDmQyDxYkihn7gQPUQwMqnRb1WP6dwajZH6xi1LmaDtKGqToq
         R4bdt3FVkjIXX+9DWoCAwoItrTqM6nzDvCV/U4iMAEMzEeJ39Oq0FdT5NeDGg21golNC
         LsKEUXBN0Q48XjxF8VxwMoLxC3UCym5j7YYIL4xKAp2mxnhGb0Zwf21wzMN8DyT3RBFo
         WTVC6fLLx7AaoqNEHyF9tK8apI/Zf78iP+cDZ2UCHBUrcbdmGbFK4EvhXQGAKz2XjP/a
         FIPcIgVPkPfZjV0MlUbryoBikXWn+DQZahdN6u7MJjPm/KsY5zcFXW14hkWqCxh/wLXw
         vdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v1/PuiYfXT6aW7CBjL7YO5ci4U91JrGo4Hi2aBBjbu4=;
        b=ThNil7mdk3ycGNgPDRHDCZPmRw+UYVyfaMuFK5fVZ72CP2ygzz1blSMK1jUoLC5zRU
         ImRTOGbsOqFQBs9FRtCVc5bvLx4b31VuMhkPGWnD3eFRt2K9suNEAF5KWia9Q8c9Ewps
         eX4PoixNQ0tvGOYwXicDVq7rfd5Q0TURJY+ksrOGA7S+TPk7sNGbZKDS4hW3J6CRrIG6
         SQi3GYFnJkCibWdzMuUejpgAnEuClBis6l7Qkot6kvnAWo70nhdQn/IkRGN5NdYowL5m
         1msZJI6Zm0pwIJc2LYpFdn7xYWxHlZ+t1R36MCShXmxtwvb3SMDwNaaz8vSYkmJj5p5l
         0sVA==
X-Gm-Message-State: ABuFfoiE76dLq6uOwsMkW1NIhLJ76PQM4kxXIgRpuM/ZllPmWa6YAqNN
        1OwRxua5rba3d5/eNWH58yNEqGv3
X-Google-Smtp-Source: ACcGV604VwXqSJggliWS1dPmt9zkVHlBBfco7JiFTHqnEsCNCVlBwEMF1S5XrY0rvceBot+zhk6E5MJt
X-Received: by 2002:a24:2414:: with SMTP id f20-v6mr16044275ita.0.1538521833179;
 Tue, 02 Oct 2018 16:10:33 -0700 (PDT)
Date:   Tue,  2 Oct 2018 16:10:23 -0700
In-Reply-To: <20181002231024.58408-1-rkir@google.com>
Message-Id: <20181002231024.58408-2-rkir@google.com>
Mime-Version: 1.0
References: <20181002231024.58408-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 02/15] platform: goldfish: pipe: Move the file-scope
 goldfish_pipe_miscdev variable into the driver state
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
Changes in v2:
 - Updated the commit message.

 drivers/platform/goldfish/goldfish_pipe.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index ba9aede17d57..8ca709b45e1f 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -211,6 +211,8 @@ struct goldfish_pipe_dev {
 
 	/* an irq tasklet to run goldfish_interrupt_task */
 	struct tasklet_struct irq_tasklet;
+
+	struct miscdevice miscdev;
 };
 
 static struct goldfish_pipe_dev goldfish_pipe_dev;
@@ -785,11 +787,14 @@ static const struct file_operations goldfish_pipe_fops = {
 	.release = goldfish_pipe_release,
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
@@ -815,7 +820,8 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		return err;
 	}
 
-	err = misc_register(&goldfish_pipe_miscdev);
+	init_miscdevice(&dev->miscdev);
+	err = misc_register(&dev->miscdev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register v2 device\n");
 		return err;
@@ -860,7 +866,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
-	misc_deregister(&goldfish_pipe_miscdev);
+	misc_deregister(&goldfish_pipe_dev.miscdev);
 	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
 	kfree(goldfish_pipe_dev.pipes);
 	free_page((unsigned long)goldfish_pipe_dev.buffers);
-- 
2.19.0.605.g01d371f741-goog

