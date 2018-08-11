Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D364C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439BB21E26
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBa+GiVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439BB21E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeHKWoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:44:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35036 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeHKWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:44:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so5370357plq.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CtbgM/NTlNYiBS2GbCvGWHgIJawlE9w7f17w5mGE2FU=;
        b=qBa+GiVfooIUlcgUC0My3Zm5pHoPNbNPSkOVTLoB/J+oEXB08pcGO1Ev5w/f+eLKrc
         P+5701UAuSukHnpjj2T+EO+tX/UAdyQxEtBbJ3of+y+QFwI1yg0lahOob+Y2pacJ3KLh
         IkF93Z1NpNmCSzncdJTvKKGfjsTSRTIWfs57hVs2gbOL8AoRw+mY1bAVIM1kFX2gYFOw
         ZOHH2cw5wNCVXMMc1Z8sQKwOq47u7VW1THPSu7IW017zU89dt90HcffWmJzXDssl0/xY
         azHaEpICMhN6Q82l2YsCiZseLmx1XkfitoXJ7bjaaRGkYfiwYGh5wpXWn+nVt4cJePaP
         ohPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CtbgM/NTlNYiBS2GbCvGWHgIJawlE9w7f17w5mGE2FU=;
        b=OP0hUA6lqTLH+kxbul2MKS7u8ZcXwLUUAXaeAgS0aOhzls09BjpKVIIiktE9l4pTyQ
         NFKn/rczyJ8lsF37vN+NIs85gVZuaD4BKQSd0bB+uLtgtYJ2bN6S1MoHdgahCYj0I4b7
         TN5f8zFyR3zDSUmM/jMJz0pzbJKtBglkYu+RSdvvjSa+Uw9qdmDNWx5jostXq9l6gdOO
         ukgPQgaXRfB+Hry10ulU2+24qPVM0wtYCy0yuUE6OEkGofFVQCnEKtmDdkkrcCe0HMiJ
         X22s2/12A5X3sAmj9tyYPH49edK3J9iHsFTcpXdJWlRVdSz98+HnENFKWirYn0YYnCk6
         lklQ==
X-Gm-Message-State: AOUpUlFo7RrbKayTICKSw6kBY+q73L/gHMkM3KdISQN0D2l2EOBvZ1/B
        0riNi1xrv44vz25jFkXsnyaINT51
X-Google-Smtp-Source: AA+uWPxc75kY/OfXOHDZcyS4skJJHf2XNv8Y0WoXIZpN8QV4IulCo4x3NbQdV+Hk9mRuUWlttq7Wgg==
X-Received: by 2002:a17:902:4124:: with SMTP id e33-v6mr10896600pld.48.1534018138184;
        Sat, 11 Aug 2018 13:08:58 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.163])
        by smtp.gmail.com with ESMTPSA id d19-v6sm38561409pfm.48.2018.08.11.13.08.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 13:08:56 -0700 (PDT)
Date:   Sun, 12 Aug 2018 01:41:48 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux-graphics-maintainer@vmware.com, syeh@vmware.com,
        thellstrom@vmware.com, airlied@linux.ie, ajitn.linux@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180811201147.GA14169@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert drm_atomic_helper_suspend/resume() to use
drm_mode_config_helper_suspend/resume().

suspend_state can be removed from vmw_private as
it will not be used anymore.

Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |  6 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 25 ++-----------------------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index bb6dbbe..a317cda 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1521,7 +1521,7 @@ static int vmw_pm_freeze(struct device *kdev)
 		WARN_ON(vmw_request_device_late(dev_priv));
 		dev_priv->suspend_locked = false;
 		ttm_suspend_unlock(&dev_priv->reservation_sem);
-		if (dev_priv->suspend_state)
+		if (dev->mode_config.suspend_state)
 			vmw_kms_resume(dev);
 		if (dev_priv->enable_fb)
 			vmw_fb_on(dev_priv);
@@ -1558,8 +1558,8 @@ static int vmw_pm_restore(struct device *kdev)
 	vmw_fence_fifo_up(dev_priv->fman);
 	dev_priv->suspend_locked = false;
 	ttm_suspend_unlock(&dev_priv->reservation_sem);
-	if (dev_priv->suspend_state)
-		vmw_kms_resume(dev_priv->dev);
+	if (dev->mode_config.suspend_state)
+		vmw_kms_resume(dev);
 
 	if (dev_priv->enable_fb)
 		vmw_fb_on(dev_priv);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 1abe217..b8e200b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -438,7 +438,6 @@ struct vmw_private {
 	struct vmw_framebuffer *implicit_fb;
 	struct mutex global_kms_state_mutex;
 	spinlock_t cursor_lock;
-	struct drm_atomic_state *suspend_state;
 
 	/*
 	 * Context and surface management.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 23beff5..2d011a1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -3028,19 +3028,7 @@ int vmw_kms_set_config(struct drm_mode_set *set,
  */
 int vmw_kms_suspend(struct drm_device *dev)
 {
-	struct vmw_private *dev_priv = vmw_priv(dev);
-
-	dev_priv->suspend_state = drm_atomic_helper_suspend(dev);
-	if (IS_ERR(dev_priv->suspend_state)) {
-		int ret = PTR_ERR(dev_priv->suspend_state);
-
-		DRM_ERROR("Failed kms suspend: %d\n", ret);
-		dev_priv->suspend_state = NULL;
-
-		return ret;
-	}
-
-	return 0;
+	return drm_mode_config_helper_suspend(dev);
 }
 
 
@@ -3055,16 +3043,7 @@ int vmw_kms_suspend(struct drm_device *dev)
  */
 int vmw_kms_resume(struct drm_device *dev)
 {
-	struct vmw_private *dev_priv = vmw_priv(dev);
-	int ret;
-
-	if (WARN_ON(!dev_priv->suspend_state))
-		return 0;
-
-	ret = drm_atomic_helper_resume(dev, dev_priv->suspend_state);
-	dev_priv->suspend_state = NULL;
-
-	return ret;
+	return drm_mode_config_helper_resume(dev);
 }
 
 /**
-- 
1.9.1

