Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DA120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1MjaA4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DA120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeINXIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:14 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41238 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:13 -0400
Received: by mail-pf1-f201.google.com with SMTP id u13-v6so4968154pfm.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0nQ1+RxJj2aaz++1HtmtUr5nhay5haw9dYt4E1Jxiw8=;
        b=A1MjaA4VzKBW6M11SoksNL7AjZk0/pvr9kW/j+d4US+gtfSJGAYrBTSUjll4UjPSWt
         ZBAL6DaYtG5bVbgiV0bDqRJdRDJ5Xavir2VECJYDsnUMxxnjidZjGp/DEv+EBXD17bXz
         gjDHUPHfce84SWeA9Si1nPmoDtFj8fLYp3rw/ojHGCUxRQnx+66ZalZOO1iA8QwxM7dn
         p3a5vdiFI16jk13EMyZQ/wM+e08ZfXc3ChhznHtug/02NJeqEatYhaqaOIjwDpWwu7y+
         ynNXELtnfSjIU1oFT7VcX951jtmfSrHo321KxCZy6z+DNZQAKIrsBe6qcb8KCl/2mlAw
         a/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0nQ1+RxJj2aaz++1HtmtUr5nhay5haw9dYt4E1Jxiw8=;
        b=i63wN/XwEGJdBFaLA6hQN4Y+E9UvDxDUR1/tGO66+hAYGHpc0k8XLPaLGduQcGSuq/
         mr9cJA5kbI8bdshQWV+FHvLzAF6+jA4a6OolQXQgp0ZbmSA3oX+IwO2BjljpvrZ4aSet
         MXw8vthMsf+iife8hW0NQEyFLNf8WmjJAH2WQOr6UN3YDb4wVNPHcrf5QuizMcToiLQ0
         SiJ1UTTMACfZmrqDPDrRY/8cmEXfvtJ6w/7srS2iZdZdCGrsfRnmnXdpHRb0KfoPVh5b
         bzdBoBOQ3/opXEPn2mbqZLSkrcwCLP+fBcCwU/Hi1jHMww556rvI+w6aIDhiAFFtuInk
         0/qQ==
X-Gm-Message-State: APzg51Cqd9TF1iH0JgKnGSQ2P5Msw+zOkXX2HHjHTvI37xXg1pKG9Yw/
        aPbLHmCghr5QvPmAGJfyf+BCcSdQ
X-Google-Smtp-Source: ANB0Vdazq29sjsPWHvIcTpGA/yyDgEFzXZnt/m2lqK6+me2myDe1/S3SBUcUh0xxyGPbVRU2tjdJBbu5
X-Received: by 2002:a63:103:: with SMTP id 3-v6mr741917pgb.52.1536947560209;
 Fri, 14 Sep 2018 10:52:40 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:13 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-12-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 12/21] platform: goldfish: pipe: Return status from "deinit"
 since "remove" does not do much
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

This way deinit will have a chance to report an error.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe_v2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index ccde28abcb24..7187b2e603d4 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -1193,13 +1193,15 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev,
-					struct goldfish_pipe_dev *dev)
+static int goldfish_pipe_device_deinit(struct platform_device *pdev,
+				       struct goldfish_pipe_dev *dev)
 {
 	misc_deregister(&dev->miscdev);
 	tasklet_kill(&dev->irq_tasklet);
 	kfree(dev->pipes);
 	free_page((unsigned long)dev->buffers);
+
+	return 0;
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)
@@ -1245,8 +1247,7 @@ static int goldfish_pipe_remove(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
 
-	goldfish_pipe_device_deinit(pdev, dev);
-	return 0;
+	return goldfish_pipe_device_deinit(pdev, dev);
 }
 
 static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
-- 
2.19.0.397.gdd90340f6a-goog

