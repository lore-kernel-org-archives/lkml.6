Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90520ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B63820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVf1b9fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B63820853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeINXIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:48 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:50469 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:47 -0400
Received: by mail-qt0-f202.google.com with SMTP id e14-v6so7731661qtp.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G25UCWm4mMz33+eKUPKhs6JGwqVkqzCk8I3cSuz0GoE=;
        b=fVf1b9fPITq9RTWj+mSp2sGeigS4UK1ThbKRs8va5jR4CRz4YbtJ8z5fy8iGjQKwjc
         OgYFfPsOVmksQQ+DXT/QUH6evzTz9pZbcGbnKLhwkyw7IIQHBzRsu0Fgum+o4g2Di8wC
         f4oRxhcjkgTnp01Cs+IumsNgPJJfMLdVTVnk/2vYuAmyeWk7TcOkRgGNKm2CEbutUie3
         czNYczfP9Ni6TUSCDnjsT13M5DmLMg2C2wTzal3XUXyIvmHHeA2wNpwoSJgphTzvcFBk
         JszKCqDiklix30RY1zWCdqwCEelVQ3e1nQ7sjuisffB3npHpa0YrSks78EhqT98TbZNZ
         gNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G25UCWm4mMz33+eKUPKhs6JGwqVkqzCk8I3cSuz0GoE=;
        b=Vj2NlGFTqec4tUdKCykn09U43ZeG1EcZCx/VPNYqYKAzWYCO0ud9z7Pz6ajS+qgAh+
         2WUTok9H7veBjhT8/P3fzoRQU083/76YW5mp8RvyEAInDsT55r6ZJZb7Cg6EVy3+zARb
         p+659i0Mg6UuGSc4r3Rm5hpboprbsVHVGOdAr5D9/OueN0jjL5P6t5dIXmjzebr45WOA
         ddi/igv1n32+66q+OZMld4tuhDvN9YnbQk8o27vCbgMNoAklLSn4/NLi5bIP5pq406bK
         2Mfi8TUDRynnuJ3pBkTquvYixJQFIWUDSgFex4s3Ik4PSZOQqmDNrj4iFUDbu5AxYLVD
         KHGg==
X-Gm-Message-State: APzg51C+vYlN8XQKhaFFtO1XT6hGU2CKsoNWodmwBdO/FEl2dgaWJKUA
        4fwtlvmFjhgFXUw/LJZ1qyZzVZ+y
X-Google-Smtp-Source: ANB0VdYIuTk+KbMWa2lZycuknSCL5PxQThWMF4jRUqtF9tKiT+kQl83EX81sXzq3fS+KSiX0ZgPAFGzd
X-Received: by 2002:aed:2452:: with SMTP id s18-v6mr4261542qtc.20.1536947593614;
 Fri, 14 Sep 2018 10:53:13 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:21 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-20-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 20/21] platform: goldfish: pipe: Remove redundant casting
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

This casting is not required.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index e45e262517a0..f6c144e71c30 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -103,7 +103,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel((u32)PIPE_DRIVER_VERSION, base + PIPE_V2_REG_VERSION);
+	writel(PIPE_DRIVER_VERSION, base + PIPE_V2_REG_VERSION);
 	version = readl(base + PIPE_V2_REG_VERSION);
 
 	if (version < PIPE_CURRENT_DEVICE_VERSION)
-- 
2.19.0.397.gdd90340f6a-goog

