Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A244C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7F32089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTE/Ly1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7F32089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJCFFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:05:46 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:55322 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:05:45 -0400
Received: by mail-io1-f73.google.com with SMTP id k20-v6so302950iom.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wHLXUYfVp1ipOXy115YFI9ZAxevv9ZPFcXXgz35wtJU=;
        b=iTE/Ly1Frppq4b8BpoMouRRT5zUHD+at6P1Pay/wAC/NFPJGwGuDnqgEex1hSYCmdW
         bCb73pdUMVsG1N/BnnZv9evIJpvp62tyxAeKc+xjXm3pziIcWsMlR8q1SwVYZAiWv61D
         E7ikmfR5uOqjGaL3gYd4pzVsDfu5gDfDcMyUVnE5myWIv6MLXgjJI4IhWZOYDxeB2QYn
         4U8Kd5kt5n842wn6cJJETjfIfnbOlUAw0+aNoHCDmUo3d+Q9ySnc3arWsWUPlCtS+6dU
         /xdDy7pt0UKN83GjPscas0nBahr1efgDyeGCPHp/CCQXXh9QYPitH0mibH8oZvjjXLVT
         Tz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wHLXUYfVp1ipOXy115YFI9ZAxevv9ZPFcXXgz35wtJU=;
        b=X507zX9mUJTW0W6/KCAH4QaJxHstjvkpxcT7XX01RUtwaEd6MllY02/aVsGFr/QH5t
         JTQ+g+BxF0mx94mmcMyYGT8XdZwzPoruHSZk248BQdpDG4imKFHzqEM6xPq2/YRGuWnP
         d6awnEdQRMXL5mQN6AVmnsF9LSPTn0e4UxCm4Fkdl9SPfCvC67TYVLZci6ZqbhIg+R7p
         r/4WZCMyDIlQESmKeGcc8ej2kSkq3Hk4Bd5umwLSczGuem70odYTeSo2uP0456BXjBGp
         eK6+7NI2w/3jQoa13JT1PKGQjH4X1cncSUVxXRm+ucRNK5QLShvXZJRPao193Rc0oeE4
         zbOg==
X-Gm-Message-State: ABuFfojMEJp2HGHJEX9K8L+a3zh4Z3XAqoPaYVpTUXjlDYHxP4o3Tc+Y
        S5nOJaUUbVmOb4W6Q8gR8tMd0LfR
X-Google-Smtp-Source: ACcGV60WjL/DyDOFa9aWKcfUeuFroFbXbuopPw+5T65OrphD4NvGbasomo1HAGAnBGYwOl6Y3fLgjZXI
X-Received: by 2002:a24:328e:: with SMTP id j136-v6mr3410405ita.26.1538518810437;
 Tue, 02 Oct 2018 15:20:10 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:50 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-2-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 02/15] platform: goldfish: pipe: Remove the
 goldfish_pipe_miscdev global variable
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
host interface. I don't want to have two driver states where
only one is used.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
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

