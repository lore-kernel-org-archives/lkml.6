Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE959C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7574B2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKELDaoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbeLSV2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:28:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44634 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbeLSV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:28:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so23904680qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2KlC2gYb5RbPGPDbqs2ZpeVmtjEkfvjUFWW6JWEh4SY=;
        b=pKELDaoebxkK57tzSjDqLW/XaPxnPc0K4PJHytSmtRx4lMg5Y9ebri7uKnItBW3K9B
         T7lSzNsK0DAHt7S0tCjPJ5GqmYpWOTx7s46Qagii4KLdvN4XDnddVaCmwnYc2QpW4+ub
         vQ+Kz5BY3ZxwJjsaU4ffqTIv6FjdCeaZPvKrFOex3eYvmHUVINlfIwxj5zkT0NCQ3kgT
         /GFA8HVdqD07RaAUeBwwA7C0YBtBH4NQzrS0bEebgPF4qgS1Am71/ZO1/sbcp17keOSl
         AIEdBj7FYbclhbo8jVtl3eQEWENsBmV7BQbTCeMdcTjXmB22aLwZbKZT8oYrUNuzY8rD
         JagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2KlC2gYb5RbPGPDbqs2ZpeVmtjEkfvjUFWW6JWEh4SY=;
        b=kYtW5qMQfCu7tch7oRSIH7wZLh/daXcSMqCwOOmjLrxLHJDrxOC8q+WWOc0dfrntiW
         hvlGXbx4nPuXq0DMwe9Jh7RB/VKjRl4G6YFK6+XgDlMNjNw0mwJKbIcPjgJv9ZLw47gC
         6zbYf5v/KJ2lfcr1aStB5i8KifcCfY7PK5KxklcoJlmadFSLnqBdQAXOpqoMteBHk4x7
         B/6GQaBEMqc1aY0l/QxOvH6XtZ0z5TNGCmihNB+2oNmS437r1FIZgfHwmx56y1euVmTl
         kda6daP3yUbVrXmiK2OLjUCNlPrK5NuGIv51mUXRIS9VX1TGriRFL44bc2jm+ymX46Ax
         tR3w==
X-Gm-Message-State: AA+aEWY7N7+oY9nsmLGMzzOYQVRqpGQU8ulOI+sTXSy8/7VcwCxWn/B7
        r+ETXceG/T27BAbtF+b73d4=
X-Google-Smtp-Source: AFSGD/Uki2nnMqlvotVY6txkV7oPzzmi2d4zl/iZSyf3h5lyVvb7xQhLP7awlRGys9Ea/LRatQfEtw==
X-Received: by 2002:aed:3e49:: with SMTP id m9mr21643038qtf.99.1545254920595;
        Wed, 19 Dec 2018 13:28:40 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 5sm2696684qkv.93.2018.12.19.13.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:28:40 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:28:36 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] drm: Remove use of drm_mode_object
Message-ID: <6f92f57a290658824bf25b45db58687afd098e44.1545254191.git.shayenneluzmoura@gmail.com>
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545254191.git.shayenneluzmoura@gmail.com>
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
 drivers/gpu/drm/drm_modes.c       | 5 -----
 2 files changed, 2 insertions(+), 8 deletions(-)

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
index 24a750436559..e2689afdcf50 100644
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
-- 
2.17.1

