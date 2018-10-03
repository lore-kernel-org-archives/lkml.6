Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07364C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393121473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdQd4ZBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C393121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJDAHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:41 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44491 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:40 -0400
Received: by mail-vk1-f202.google.com with SMTP id t185-v6so398725vkd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vps50yU90mqVrXWfVdGhzV3pk2wZZ0SonallQsP2DO4=;
        b=CdQd4ZByHdBetErmsMTu5FsBbnVTiKwWYfBV8WgnCVqtNd/z1zP2HxLYdYp5GeVhuz
         onesiMfsg50FPE0Yf6w9sXVYcHW3/QCYTqV75iT7XhlfJ2pmooqCX7eyFHt6qaGx8fBO
         JO6Kz7bln7kzs8vor6jvHyZXK8h6rQCQsHst0DWZIMaMjcncxW397zMH/IRmZQHAOVJW
         1EkQ/yS81S4D/K8dFYuSbkMfCWrZxx3lPfFfQx+NnvOm7K6G4WgebDfFTJPOxbEoj1h6
         0BOo7uZLGTLe7E1dGdgoy2HZbZsfamB+lzDRNSpv5qtEhEsGULpqoQ/mX+acNhBW6OZE
         RLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vps50yU90mqVrXWfVdGhzV3pk2wZZ0SonallQsP2DO4=;
        b=ZY3J4wgcGvmMwFY+q43+UdvPXxJffqlVk1qGu3Kc0rjhLm+6vIY0/DMCRP+ZvMH1lp
         lF+xRJsXha9wjVOYdyBS1zMhOQToREUbTMlmkgSoOYjSkqgyjOupDUg3AwYxq3DDGsQR
         6hrv6K9nagdnh/86YJM39TKk8TXBTlkD9uNadZkWmpt0Wd28OcCFeBx4k1F3bXV6Ur1n
         xafAE35LM3Gy++cBFQCA0whY55NlcnZWeYEy8gSmlkl2K7IvjTtLnyoRl33nj9S1s99q
         kJlh0eVB9GBD91W2N9dCofAhxDC4WZvwfchMaFCrYhagKi1g6WdVxW6rfODAkvptHicF
         Ngpw==
X-Gm-Message-State: ABuFfogNzhqZcEtkJBEGmseBJO4EM6h2CTM2IaNjLNDe7m/tmpQhlUyV
        eDRtPr90UFLFEKnCFCxuLvgqtUZ6
X-Google-Smtp-Source: ACcGV63mprRMrab9yjQzd6NDzaIyZVXNjo/IN76zxIRGtkjmX4r/jqianKWI10WkfJhr+UFY5pkEcx1T
X-Received: by 2002:ab0:2044:: with SMTP id g4-v6mr2144037ual.15.1538587101925;
 Wed, 03 Oct 2018 10:18:21 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:18 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-13-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 13/15] platform: goldfish: pipe: Add a dedicated constant
 for the device name
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

Create a constant to refer to the device name instead if several copies
of a string.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.h    | 2 ++
 drivers/platform/goldfish/goldfish_pipe_v2.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.h b/drivers/platform/goldfish/goldfish_pipe.h
index ee0b54bcb165..0fa6ecb32c6d 100644
--- a/drivers/platform/goldfish/goldfish_pipe.h
+++ b/drivers/platform/goldfish/goldfish_pipe.h
@@ -2,6 +2,8 @@
 #ifndef GOLDFISH_PIPE_H
 #define GOLDFISH_PIPE_H
 
+#define DEVICE_NAME "goldfish_pipe"
+
 struct goldfish_pipe_dev_base {
 	/* the destructor, the pointer is set in init */
 	int (*deinit)(void *pipe_dev, struct platform_device *pdev);
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 9857ce07d0e6..0e2a62322477 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -775,7 +775,7 @@ static void init_miscdevice(struct miscdevice *miscdev)
 	memset(miscdev, 0, sizeof(*miscdev));
 
 	miscdev->minor = MISC_DYNAMIC_MINOR;
-	miscdev->name = "goldfish_pipe";
+	miscdev->name = DEVICE_NAME;
 	miscdev->fops = &goldfish_pipe_fops;
 }
 
@@ -806,7 +806,7 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 
 	err = devm_request_irq(&pdev->dev, irq,
 			       goldfish_pipe_interrupt,
-			       IRQF_SHARED, "goldfish_pipe", dev);
+			       IRQF_SHARED, DEVICE_NAME, dev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to allocate IRQ for v2\n");
 		return err;
-- 
2.19.0.605.g01d371f741-goog

