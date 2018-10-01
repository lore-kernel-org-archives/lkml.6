Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA3EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C1E20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbCk7IQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C1E20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeJAWJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:09:43 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33934 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbeJAWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:09:43 -0400
Received: by mail-qk1-f202.google.com with SMTP id y130-v6so14879494qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b12hY9rsC65YWw5Ssm5MZ1/8YLuu+f6XdUruah2EdEs=;
        b=rbCk7IQJ9g7WKLh1ybyA7TrMCsMR5kJbU6hUfxnzlEU9S0mC1BKI+CW645Pa/x8r6K
         lkN7C4BTh3F4+HLPOnQ9y3FtiX6ULIQ4oDeOxjCJ0owefzJqBUk48ngn1yQqvrDZAdDb
         dLe4kzhQ1+yS2axXgGCWmT7VlxmLxfKx2CnOaYI5b7qMDRIRrjWp+8RMeOhJxVJ+eTuZ
         rsxSaIEDMSWWErir19zz5m8fzfR8k/fypJ2/481yWpjgv+tbiJ9/FPeM6o/aj5lBiejh
         2TyfmMSVJ+W+OAP07/cSy67A/Ds5Jmz8vMtcObhp44SpDWfr2nUqbmbbrFa97Y7nDJsM
         lSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b12hY9rsC65YWw5Ssm5MZ1/8YLuu+f6XdUruah2EdEs=;
        b=NxhUFGa3aauc9+QwBDwSIth5stx1nRbETHlwbQs1X85XU64AHI3QtFa3x9ixkqO7fj
         6mPr8Vmc02ASMyG4v45FpoZY+keGXbGFX7VMNxlwuZ1TS83Kl+40sY+XPSMG+PiwmPyd
         DdhWsWIwSdIX7VNNRghAoi8JrMGEsxGrn8Wm7NOJTmbjiV4IRfX2/Yqy8bd/NZaq6/vm
         sqmOsBnpoeih4knL6wwbQjagROnWqdKcfg8/ZZxoyx3lrGbkFePbwj13Hp8aRMXT73Vy
         fWs+s7GSC9p72b6+aGJHYnXsdiF3sUGX3+vb97kwO6EvdcBOhhG0JKwcQ7Ibq/Ou+VVK
         4C3A==
X-Gm-Message-State: ABuFfog8/zQyCeH0dQimWtLSlt/VA4U3D4NeyI7RmjmCTdwP9NKMu/xi
        CUeoY/1aqLNcAn9cyihjOSHj9bwIFQ==
X-Google-Smtp-Source: ACcGV60a3St0XvEEQSfJCAn0zcf/lXprW1gZijoWlDOezlNpIVbUaJljf5klZHt9c6uGjOTXwcZW4Bhzgw==
X-Received: by 2002:a37:109c:: with SMTP id 28-v6mr8679609qkq.38.1538407882290;
 Mon, 01 Oct 2018 08:31:22 -0700 (PDT)
Date:   Mon,  1 Oct 2018 17:31:17 +0200
Message-Id: <20181001153117.216923-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] drm: fix use-after-free read in drm_mode_create_lease_ioctl()
From:   Jann Horn <jannh@google.com>
To:     Keith Packard <keithp@keithp.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fd_install() moves the reference given to it into the file descriptor table
of the current process. If the current process is multithreaded, then
immediately after fd_install(), another thread can close() the file
descriptor and cause the file's resources to be cleaned up.

Since the reference to "lessee" is held by the file, we must not access
"lessee" after the fd_install() call.

As far as I can tell, to reach this codepath, the caller must have an open
file descriptor to a DRI device in master mode. I'm not sure what the
requirements for that are.

Signed-off-by: Jann Horn <jannh@google.com>
Fixes: 62884cd386b8 ("drm: Add four ioctls for managing drm mode object leases [v7]")
Cc: stable@vger.kernel.org
---
I'm not sure how to actually use this ioctl, so I have neither verified
the bug experimentally nor experimentally verified the fix. I would
appreciate it if someone could confirm my analysis.

There have been a number of fd_install() bugs over time; I think it's
probably time to rename fd_install() to fd_install_dropref(), or
something like that.

 drivers/gpu/drm/drm_lease.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index b54fb78a283c..b82da96ded5c 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -566,14 +566,14 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	lessee_priv->is_master = 1;
 	lessee_priv->authenticated = 1;
 
-	/* Hook up the fd */
-	fd_install(fd, lessee_file);
-
 	/* Pass fd back to userspace */
 	DRM_DEBUG_LEASE("Returning fd %d id %d\n", fd, lessee->lessee_id);
 	cl->fd = fd;
 	cl->lessee_id = lessee->lessee_id;
 
+	/* Hook up the fd */
+	fd_install(fd, lessee_file);
+
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
 	return 0;
 
-- 
2.19.0.605.g01d371f741-goog

