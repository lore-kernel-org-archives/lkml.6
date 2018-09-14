Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F31FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED57020853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYC/Zh0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED57020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeINXIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:31 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:46609 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:30 -0400
Received: by mail-ua1-f74.google.com with SMTP id g12-v6so3093755ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r0GmnibaRSZ4wFwzkIsbuCyBKEqgNS0mZ0XwSgt6Aa8=;
        b=mYC/Zh0uRegj4vGYNsV8AvfhYiXSXpmqCFsTBrZetRnA+T/GMFKczsR5RmHotp/HQQ
         FpEQ5HQiHIKlIunJMD4z1EpyVU3UMv5RBi1n8VTyk+u+tLxcwlqEfym/2HTs/WKDzR3m
         LIsCY0LH309lcaMWZSR3JF3QzF7LhrKCY7M9z0ufO25nhoJcNk3QCwAaCxi0dpaZOQD5
         SPNloNnj4V3IzNvvgvw88+GfmfAhPp9Rg+Es/HvY6Oa9Uc9DV3AeulrjMXh8f+QRCcJ1
         xfn6GMqCH59AFNlCPLjHCacChwg884AUp2CmRMhkQqS3QiFHnMmU/3UWd7KnvE/NDjcc
         MeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r0GmnibaRSZ4wFwzkIsbuCyBKEqgNS0mZ0XwSgt6Aa8=;
        b=Ghfnz7aJQPMLePx8cVyE/5a0DgIAI9iqRcV6CTVxXB19hHxJlmI+MFAbpcouO0zY7d
         1bGaf1vjd/P9LR5RyzKRatpiq9/fTxNSQb7dFnponAdURxmlO3Y/620A74uvFnJv6DoV
         uuXzmjAVl02XGlf5dE9tsMiaDyFrdbfEtGd/Zb5o/ciynwgVkctbrf7FkE7oJliqsKY2
         6eCwjiGrGsoAsz/6l3JHGQwNUWFRdFyfwBw9KX4cDO7cFM6adTIXPaorlW5zpb3xgey8
         P/Ei1trEzEvosEcamPzrpPirclBbVdz4KHuYWSvNOalLGPM5yRK6jjjRUUFybYkHrdYS
         vV+A==
X-Gm-Message-State: APzg51BJ6+o+ElvUbYqELrYhRFDx2v/2sZwjAfWuqcSvPvQx0xaORRwW
        YYcILBgu07n6Jpz3BseLRSu271M2
X-Google-Smtp-Source: ANB0VdZzBP7tdZvrQK213ttlA/zFtrpobfC49sH0HVZ/Ann3dxGCVZ8gfrnSc4kLa+c0xucczxo5d0cy
X-Received: by 2002:ab0:48d2:: with SMTP id y18-v6mr2896473uac.63.1536947576699;
 Fri, 14 Sep 2018 10:52:56 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:17 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-16-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 16/21] platform: goldfish: pipe: Call misc_deregister if init fails
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

Undo effects of misc_register if driver's init fails after
misc_register.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe_v2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 9fa5136be909..e3358c682562 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -1159,8 +1159,10 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
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
@@ -1173,6 +1175,7 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 		__get_free_page(GFP_KERNEL);
 	if (!dev->buffers) {
 		kfree(dev->pipes);
+		misc_deregister(&dev->miscdev);
 		return -ENOMEM;
 	}
 
-- 
2.19.0.397.gdd90340f6a-goog

