Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B05C65BAA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2812089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McHsi/kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2812089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJCFFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:05:52 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:50786 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:05:51 -0400
Received: by mail-ot1-f73.google.com with SMTP id e69-v6so2430028ote.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z9XoGmB/wm15KgwqXF8ZoXAWypqHpinkJPu48yHLcLg=;
        b=McHsi/kBNY/vSGX7Qc2+eV3peAeE2eFog3G5QRWYQC3jFQSM6BQOXFU4q2U92cW5xs
         e28Yo+FQEfMK81FZ0FS4OHdv7EaEe5yiZtBHq+t3GkCEcyMlMLPKKLxzsCaNVlyROpRi
         jKY7Z3rST+hbzvntBL7JfsSPvVHfXw6ICJZQPQxDJRm0wPAWVD88KqocI0uPTZLhr5hL
         1R7g897XvdZhPOWpQHkfz3tAokbUEzTGF0/Ng9QJWoXkOW3bTuV5IBsyfHdLOjwwVjMi
         ueKzkU9kAVmxS4GnVvzwnh2XmATy16aE/tSG+aq2ncbYvSPHVxN0jx+y3jva8stzQyjU
         1ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z9XoGmB/wm15KgwqXF8ZoXAWypqHpinkJPu48yHLcLg=;
        b=uRdWpn+NGPSkD51t3RcyUnJZzY8WpJji2ffwnR4Q1gCXNvibjiiGJzH97vtpMhgPhi
         DEPzgU3ehktSwKzZJOTLX1LJeeDAlrZzsJLDjKsPD8EOKOA8HDj9UUcsgbZBslQzl3Ff
         ou3O+/P8fo/2RiMAU/HMXZwfLJub9Ja1W8qFxJCryGr2qhB6W+3FBgCKvoNAd9s90fgJ
         szQrGZQZXs40nwAO6DEvC8Z+8srWfAawB73M/cSBAzZuLLjfKk7GVpz6d+S3JBJ/QtMF
         gb7JGuOglsipW4FXWDsszTYVDfpkC/m3l5iSF7a090YCJxXrNbO3mxQsz64mrFdC3dMF
         DiYg==
X-Gm-Message-State: ABuFfoiRCOfwHm20EaSO+xZeAuNlVvycJnQif4hA9TYB34ddqwYUmG8Y
        UwBb+MIj4pe4exFevL0GdtwRyg8F
X-Google-Smtp-Source: ACcGV61MP9FMHPgbJ9n/4ak25x+c/wPDTjz2Df5W1FMwXgyeg3MOM+vf2fmFW+jz30QB8A16aytSXfR2
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr14624448oie.39.1538518816878;
 Tue, 02 Oct 2018 15:20:16 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:52 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-4-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 04/15] platform: goldfish: pipe: Call misc_deregister if init fails
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

Undo effects of misc_register if driver's init fails after
misc_register.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 4013832f38fb..c386aaf40034 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -844,8 +844,10 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	dev->pipes_capacity = INITIAL_PIPES_CAPACITY;
 	dev->pipes = kcalloc(dev->pipes_capacity, sizeof(*dev->pipes),
 			     GFP_KERNEL);
-	if (!dev->pipes)
+	if (!dev->pipes) {
+		misc_deregister(&dev->miscdev);
 		return -ENOMEM;
+	}
 
 	/*
 	 * We're going to pass two buffers, open_command_params and
@@ -858,6 +860,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 		__get_free_page(GFP_KERNEL);
 	if (!dev->buffers) {
 		kfree(dev->pipes);
+		misc_deregister(&dev->miscdev);
 		return -ENOMEM;
 	}
 
-- 
2.19.0.605.g01d371f741-goog

