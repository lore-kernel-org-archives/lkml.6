Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC7C21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alg9jrrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLRNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32955 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so18185005qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ORICpf2dl6GUo7+siLAXSGZnXxg4OAmXsWTVd3NYN74=;
        b=Alg9jrrWoByVKO1LuKEtxESkutzAMR9gkoXmR8Z2fJbYFuyMUXHsWhD4b1DDqhPKoK
         A80WoXhW6bfofuo4cMTXiI4MMv3mD3/ytPZVsSl079udPRB/JL8EBO9DadNrTxu2nJRa
         7waN+hVcYlMiZqxck/tgMCcMTGxDMwyC8L34XxmCiBRLSDVJEwRn8pcVRUXQufkGYZ+7
         HFTcA7S/i61pTvYSHVXVSvbZ9MySGe5xMgJSS81WdsfzffLRdtbG9SCiOp5vfnJYIVRi
         UixxbT+f8FZIEzpH7qgfpyRLFY5hCZ3a8aotcbRNqK1LlRXjt8+wbskobNUTnBhEuYPN
         YgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ORICpf2dl6GUo7+siLAXSGZnXxg4OAmXsWTVd3NYN74=;
        b=FJ2uN8VbXBe9V/726rwEJVHuKF9kUu+8Wbv4D7C9w+Fnowd6Bm/oH9znvL0MAAi5RE
         7J2E5AoP9WjRKobXfKqQoyQoYX8Pw8qcGyePWo46oD/XJEJ1qH4sr29RbJ3MprpZmrof
         CA9+DrkFt1v8HTTe78vGtvnC195gA1wdzNR49EDr5AJkMBfb72L/zdnWJ0dpbRM+D/ho
         VRuvmd8F011TfImJWC0faQj+LhzjfwT9PzIMruJ9S/2upUgTk67dn33s3/rtUuslU5HK
         G9SVvbg7x+WxpTmuHh8/EE7dU9RQvzXBAnsfSAEl3VGTP+1afXh0a/aO6cwbjC/zA9W1
         XnRw==
X-Gm-Message-State: AA+aEWYl71z+nz2aySpVlztI1KcOqw6SDo3PM7wtUJRX3i0Ai4WBc9eR
        +ouuU+kd/smJTgvxrSEwPRE=
X-Google-Smtp-Source: AFSGD/Ur8OLq6a6vcHX/kkW0OJldUIvXaqG/2iI+PAaitjwlHVxqZKPwayDt0cNB40F92FolYknrgQ==
X-Received: by 2002:aed:3482:: with SMTP id x2mr16787518qtd.72.1545140295231;
        Tue, 18 Dec 2018 05:38:15 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j38sm10233963qtj.72.2018.12.18.05.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:14 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:10 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] drm: Remove use of drm_mode_object
Message-ID: <20181218133810.aqhmqflvl5mqrfgo@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the drm_mode_object prints, evaluation and use from 
drm_display_mode objects used in drm files. It removes dependency from
drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 5 ++---
 drivers/gpu/drm/drm_modes.c       | 9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index a3c81850e755..cc5cc8d109a2 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -386,9 +386,8 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 		if (!encoder_funcs)
 			continue;
 
-		DRM_DEBUG_KMS("[ENCODER:%d:%s] set [MODE:%d:%s]\n",
-			encoder->base.id, encoder->name,
-			mode->base.id, mode->name);
+		DRM_DEBUG_KMS("[ENCODER:%d:%s] set [MODE:%s]\n",
+			encoder->base.id, encoder->name, mode->name);
 		if (encoder_funcs->mode_set)
 			encoder_funcs->mode_set(encoder, mode, adjusted_mode);
 
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 24a750436559..adce9a26bac9 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -71,11 +71,6 @@ struct drm_display_mode *drm_mode_create(struct drm_device *dev)
 	if (!nmode)
 		return NULL;
 
-	if (drm_mode_object_add(dev, &nmode->base, DRM_MODE_OBJECT_MODE)) {
-		kfree(nmode);
-		return NULL;
-	}
-
 	return nmode;
 }
 EXPORT_SYMBOL(drm_mode_create);
@@ -92,8 +87,6 @@ void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode)
 	if (!mode)
 		return;
 
-	drm_mode_object_unregister(dev, &mode->base);
-
 	kfree(mode);
 }
 EXPORT_SYMBOL(drm_mode_destroy);
@@ -911,11 +904,9 @@ EXPORT_SYMBOL(drm_mode_set_crtcinfo);
  */
 void drm_mode_copy(struct drm_display_mode *dst, const struct drm_display_mode *src)
 {
-	int id = dst->base.id;
 	struct list_head head = dst->head;
 
 	*dst = *src;
-	dst->base.id = id;
 	dst->head = head;
 }
 EXPORT_SYMBOL(drm_mode_copy);
-- 
2.17.1

