Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50533ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AA320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpCvYw2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeINXIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:35 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:40624 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:35 -0400
Received: by mail-qt0-f202.google.com with SMTP id c14-v6so7774610qtc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Aghgp99e/Neo0QIJdksLf40AiG9Y/i6WDdqUf12X/Qg=;
        b=LpCvYw2/i/wVh6dEDWh+vhOY5e53+LrKGMli63AkMJI2Gan2FONyB3zCEcj0B1YWLW
         RKS5XINGSMAN0sIoneyjVkjuq9dj+TqUOfW5zfaAw5k7c3dveKNx/xxJBgw2vCcYErb1
         OlQhV898N/IvROByLuBhO1rEV+Wad+9VyF7byPaIe2W1uVvzSYVAwxtb7XJrIg6LwcsE
         mh3sUilAqLwqz6wrYRv1y4ivEmk+WfzSh6azIiVArkY4ml4V2ecPGA3RBtYfV5cScveJ
         3Ph8VAsGtr3YFkmVG5J9nbxf5H4krWu4dsufJ6oAUg0d3SzJPrmEhvjJnG+HaymC5h6G
         sOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Aghgp99e/Neo0QIJdksLf40AiG9Y/i6WDdqUf12X/Qg=;
        b=bpgexHNoWMOh8IBYVBZ0cAsOMDjwtL6DS8IWUnkMtA7X35AGotAmrk5Bk2NzoaoeJm
         MGPjDWio+sJJewtYWyCP4RWI2EILSMTVExi+wuqVPtN/bROKiT4qS4pibtB69CcnZonR
         85oqHarDugFcR0AGKiCRX5Io4d0BQUzH1zMUGP02PZNRToOFYQ6UMYXLZf8JJGyTLg3O
         dpGHYIACN89KJYdmMGhofh0HpBLC9hxr7AW6IayNAQzZIR2NJ3DDALlYfzbmNmW3dl3r
         5aD9xBXnAzn+iGppLjCNQU2TZN+GKwHTDJeDYMCQInxIOVI3eX8CkkWYp9arqiUGJZgZ
         QSIw==
X-Gm-Message-State: APzg51BKbzU+Dmmzu0Oq4OU43RnSKWj98P8EHL7jcw/i40BjEeIrp1sB
        hMidHID96Qc+yJwEMe5aUAyNFVnr
X-Google-Smtp-Source: ANB0VdbD9c8jKEE5tx5e7Mj2hPUrK5gV6GyJuOjT7Jz9tsfsk6/JW3MMJU+BsA9d4odMNyqZXgMq7aJv
X-Received: by 2002:a0c:873c:: with SMTP id 57-v6mr4192032qvh.38.1536947580926;
 Fri, 14 Sep 2018 10:53:00 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:18 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-17-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 17/21] platform: goldfish: pipe: Add a dedicated constant for
 the device name
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

Create a constant to refer to the device name instead if several copies
of a string.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.h    | 2 ++
 drivers/platform/goldfish/goldfish_pipe_v2.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.h b/drivers/platform/goldfish/goldfish_pipe.h
index 41e831f59eff..178efcf52d22 100644
--- a/drivers/platform/goldfish/goldfish_pipe.h
+++ b/drivers/platform/goldfish/goldfish_pipe.h
@@ -16,6 +16,8 @@
 #ifndef GOLDFISH_PIPE_H
 #define GOLDFISH_PIPE_H
 
+#define DEVICE_NAME "goldfish_pipe"
+
 struct goldfish_pipe_dev_base {
 	/* the destructor, the pointer is set in init */
 	int (*deinit)(void *pipe_dev, struct platform_device *pdev);
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index e3358c682562..2332aa4bfcea 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -1109,7 +1109,7 @@ static void init_miscdevice(struct miscdevice *miscdev)
 	memset(miscdev, 0, sizeof(*miscdev));
 
 	miscdev->minor = MISC_DYNAMIC_MINOR;
-	miscdev->name = "goldfish_pipe";
+	miscdev->name = DEVICE_NAME;
 	miscdev->fops = &goldfish_pipe_fops;
 }
 
@@ -1140,7 +1140,7 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 
 	err = devm_request_irq(&pdev->dev, irq,
 			       goldfish_pipe_interrupt,
-			       IRQF_SHARED, "goldfish_pipe", dev);
+			       IRQF_SHARED, DEVICE_NAME, dev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to allocate IRQ for v2\n");
 		return err;
-- 
2.19.0.397.gdd90340f6a-goog

