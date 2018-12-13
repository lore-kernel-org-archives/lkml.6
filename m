Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EBC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BFD20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlfzYqT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeLMVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:30:06 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:36651 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:30:05 -0500
Received: by mail-qt1-f179.google.com with SMTP id t13so3955866qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 13:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M1jct51NouuWowl8d6PZRlHpN7bjDs8mqzL9LudzrXg=;
        b=PlfzYqT29n0B84Tz1v4gGi9OGAP1N9qef6S47dZmxaUKDlVL/V5NdHVUhDLJgXBYLQ
         07TY29iH47GN7jf3YN2VJLrk+XbRJPrWKfDW+nYYNTRogGoXxD7fW5gYy1jFQW/+q7BA
         LECOZfVD56Dm22xIi37XCpqBFt0DtC9HngswCMECAFwbZhLCPWuF59y4RILm95JVYaQ5
         YsWueOeOQppTrfAbo/TM2Err8lCJlh4LR3svpxi5mkRfVp3F2aQCSLdxBbn+ymxF37ro
         8myGs9OTzniPvbqaxHivstt+rEy/TZ3wWj55JkESDfu40sAvVLaYd8X02SwO4wzZ/UJE
         aOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M1jct51NouuWowl8d6PZRlHpN7bjDs8mqzL9LudzrXg=;
        b=JZpAmePeTSeQhMPCrZMOtssSKpfW3dV0HxMRgzl/5SdWfVkvA7meQpa9NwoK5+FLJe
         EIlHdjMQ5enfHY3vVIw7dCgQ5XtsspFSe6vLOpiQfVGpsZxKWEj2QbB4ptBwxFpyVkxT
         45AfWzZMq/oIcCpx35y9MPU5BCt83dk4XPRy+ogBy5zJZR7o5W8wGMMX8FlGxVef/+Lx
         1xo/FiSwzXaxxT7HtSKU6ZhP8svIsY6I55Oaua6UEO241k0WNzggMOleP9EBa7k/fJ4K
         nhsN30MXBVrHJaBkxlcycek2gP7C0g7Qi/jglb6wUEQrfmGhe1jU9/Z8YScXLjTLgCb3
         8iPA==
X-Gm-Message-State: AA+aEWZD5qDmx/xTezrmVPnX/Yn/n6hcVbay4tMb28bVynZU6b7kz6EG
        tVeeWK2xku+Tlz3EGF0HIZQ=
X-Google-Smtp-Source: AFSGD/Xmi6VZD4ZhXEIU0TGmAr+uIr32AWMupCVVy+kypPb3C94OnmWHtNFIiQXgKFX6cbSZbVXa4w==
X-Received: by 2002:a0c:ba24:: with SMTP id w36mr460071qvf.60.1544736604084;
        Thu, 13 Dec 2018 13:30:04 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id r56sm1944559qtj.30.2018.12.13.13.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 13:30:03 -0800 (PST)
Date:   Thu, 13 Dec 2018 19:29:57 -0200
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [RESEND PATCH v2] drm: Rename crtc_idr as object_idr to KMS cleanups
Message-ID: <20181213212957.vkitkyl5cj2qh7qr@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves this TODO task:
 drm_mode_config.crtc_idr is misnamed, since it contains all KMS object.
 Should be renamed to drm_mode_config.object_idr.

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>

---
Changes in v2:
 - Make commit message more clear and change header file

 drivers/gpu/drm/drm_lease.c       | 6 +++---
 drivers/gpu/drm/drm_mode_config.c | 4 ++--
 drivers/gpu/drm/drm_mode_object.c | 8 ++++----
 include/drm/drm_mode_config.h     | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 977f069f6d90..b2cbb58834bc 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -218,7 +218,7 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
 
 	idr_for_each_entry(leases, entry, object) {
 		error = 0;
-		if (!idr_find(&dev->mode_config.crtc_idr, object))
+		if (!idr_find(&dev->mode_config.object_idr, object))
 			error = -ENOENT;
 		else if (!_drm_lease_held_master(lessor, object))
 			error = -EACCES;
@@ -434,7 +434,7 @@ static int fill_object_idr(struct drm_device *dev,
 		/*
 		 * We're using an IDR to hold the set of leased
 		 * objects, but we don't need to point at the object's
-		 * data structure from the lease as the main crtc_idr
+		 * data structure from the lease as the main object_idr
 		 * will be used to actually find that. Instead, all we
 		 * really want is a 'leased/not-leased' result, for
 		 * which any non-NULL pointer will work fine.
@@ -675,7 +675,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
 
 	if (lessee->lessor == NULL)
 		/* owner can use all objects */
-		object_idr = &lessee->dev->mode_config.crtc_idr;
+		object_idr = &lessee->dev->mode_config.object_idr;
 	else
 		/* lessee can only use allowed object */
 		object_idr = &lessee->leases;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index ee80788f2c40..ab553b6465e2 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -381,7 +381,7 @@ void drm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.property_list);
 	INIT_LIST_HEAD(&dev->mode_config.property_blob_list);
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
-	idr_init(&dev->mode_config.crtc_idr);
+	idr_init(&dev->mode_config.object_idr);
 	idr_init(&dev->mode_config.tile_idr);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
@@ -484,7 +484,7 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 
 	ida_destroy(&dev->mode_config.connector_ida);
 	idr_destroy(&dev->mode_config.tile_idr);
-	idr_destroy(&dev->mode_config.crtc_idr);
+	idr_destroy(&dev->mode_config.object_idr);
 	drm_modeset_lock_fini(&dev->mode_config.connection_mutex);
 }
 EXPORT_SYMBOL(drm_mode_config_cleanup);
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index cd9bc0ce9be0..bb1dd46496cd 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -38,7 +38,7 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 	int ret;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL,
+	ret = idr_alloc(&dev->mode_config.object_idr, register_obj ? obj : NULL,
 			1, 0, GFP_KERNEL);
 	if (ret >= 0) {
 		/*
@@ -79,7 +79,7 @@ void drm_mode_object_register(struct drm_device *dev,
 			      struct drm_mode_object *obj)
 {
 	mutex_lock(&dev->mode_config.idr_mutex);
-	idr_replace(&dev->mode_config.crtc_idr, obj, obj->id);
+	idr_replace(&dev->mode_config.object_idr, obj, obj->id);
 	mutex_unlock(&dev->mode_config.idr_mutex);
 }
 
@@ -99,7 +99,7 @@ void drm_mode_object_unregister(struct drm_device *dev,
 {
 	mutex_lock(&dev->mode_config.idr_mutex);
 	if (object->id) {
-		idr_remove(&dev->mode_config.crtc_idr, object->id);
+		idr_remove(&dev->mode_config.object_idr, object->id);
 		object->id = 0;
 	}
 	mutex_unlock(&dev->mode_config.idr_mutex);
@@ -131,7 +131,7 @@ struct drm_mode_object *__drm_mode_object_find(struct drm_device *dev,
 	struct drm_mode_object *obj = NULL;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	obj = idr_find(&dev->mode_config.crtc_idr, id);
+	obj = idr_find(&dev->mode_config.object_idr, id);
 	if (obj && type != DRM_MODE_OBJECT_ANY && obj->type != type)
 		obj = NULL;
 	if (obj && obj->id != id)
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index d643d268693e..4750fccb5b4a 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -385,18 +385,18 @@ struct drm_mode_config {
 	/**
 	 * @idr_mutex:
 	 *
-	 * Mutex for KMS ID allocation and management. Protects both @crtc_idr
+	 * Mutex for KMS ID allocation and management. Protects both @object_idr
 	 * and @tile_idr.
 	 */
 	struct mutex idr_mutex;
 
 	/**
-	 * @crtc_idr:
+	 * @object_idr:
 	 *
 	 * Main KMS ID tracking object. Use this idr for all IDs, fb, crtc,
 	 * connector, modes - just makes life easier to have only one.
 	 */
-	struct idr crtc_idr;
+	struct idr object_idr;
 
 	/**
 	 * @tile_idr:
-- 
2.19.1

