Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E0020857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB5nHPAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E0020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeG3U5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:57:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44417 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbeG3U5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:57:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so5977585pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RqWBkqg5mznyg3giKKdCfIBjtALZN2rZ/TFq05RAwIk=;
        b=FB5nHPAQH2pM0ZRI4BmjR2MewLZeHGWatf4h/+YBlhudpLpNNJo+NCQ3BjzPgbow2t
         kdLGI81Fe/gBSTfNNtWITmk7MfQw2RvZn2so/5pFgqE2dfBbHnMCAUetHiBVdtG1Cb5R
         wHGW7jaZl6LhDnr9At7v11VpmcWeecpjtO8N2e2gqJ6QYXcPkH0oSGGa9JIj+R2vs+wy
         5pLYgspQV4Xf1w9i7RqaDBOaZqfOOMUwdJUMFt+enOB/BoLLxDkqTwGSt8X7/h/CAFEe
         EUai+uJ/a/6iZPz+v9VL9W6oic+5iJ5cbHp06U9yUiVhZXAHOhV+Ye7p0pnmzFo9HE7n
         FgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RqWBkqg5mznyg3giKKdCfIBjtALZN2rZ/TFq05RAwIk=;
        b=dy+S4QJBj4O45KLzfAK1wJa5arEtDhFmmwGyVxQTIP0lLhw/+RdBg5HQTkBBUjrLDR
         3olJBQ1yTpty9hBCgbP15NiJxiApMMjPmtCzZmbeqFIbO2jCPGI/hJoa3w+jdX7te+o8
         D5wzwlPOKpNO+A6gwWR3Dbf8U4veACfVblNQ46C1FYHN0TEWSj+RCXaYNgg000ECmH9K
         0Pxzh3ffP3WOKucceYU83TeZblR01Pf60TT80xFaK+i4WPp774IytZYm8airPrkzptiI
         vh3qpofhJE+XPEKVHAuv08CepW4h7SVBGhBxvfYfgSNej3hY7dfKqJU7dA3Nn1KjkVC9
         +ZJw==
X-Gm-Message-State: AOUpUlEHwaBNwz2kCjJbuhm1yDZx0mgK84BmIWPru1/0g4P/d4wshzIJ
        PPOVv4JaxgCQcqAqmipO7MozFtWL
X-Google-Smtp-Source: AAOMgpdf8xblMeUZVAyzR03LILoIt7fNfVC7itGpr1X+3E4xnh6+/GhWvegW5JlkQk60z0NO9Lp/qg==
X-Received: by 2002:a17:902:9348:: with SMTP id g8-v6mr17474180plp.302.1532978441643;
        Mon, 30 Jul 2018 12:20:41 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.188])
        by smtp.gmail.com with ESMTPSA id i6-v6sm17144326pfo.107.2018.07.30.12.20.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 12:20:40 -0700 (PDT)
Date:   Tue, 31 Jul 2018 00:53:26 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Remove drm_fbdev_cma_set_suspend()
Message-ID: <20180730192326.GA31354@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_fbdev_cma_set_suspend() is not getting called from
any other places. If there is no plan to use it in future
we can remove this API.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/drm_fb_cma_helper.c | 15 ---------------
 include/drm/drm_fb_cma_helper.h     |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 186d00a..4c283d9 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -516,21 +516,6 @@ void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma)
 EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
 
 /**
- * drm_fbdev_cma_set_suspend - wrapper around drm_fb_helper_set_suspend
- * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
- * @state: desired state, zero to resume, non-zero to suspend
- *
- * Calls drm_fb_helper_set_suspend, which is a wrapper around
- * fb_set_suspend implemented by fbdev core.
- */
-void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state)
-{
-	if (fbdev_cma)
-		drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state);
-}
-EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
-
-/**
  * drm_fbdev_cma_set_suspend_unlocked - wrapper around
  *                                      drm_fb_helper_set_suspend_unlocked
  * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
index d532f88a..52f09dc 100644
--- a/include/drm/drm_fb_cma_helper.h
+++ b/include/drm/drm_fb_cma_helper.h
@@ -32,7 +32,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
 
 void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
 void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
-void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
 void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
 					bool state);
 
-- 
1.9.1

