Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83157C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B782089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R7ERtEKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B782089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbeG0LeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:34:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52731 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbeG0LeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:34:19 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180727101304epoutp032a97cd796c53afd4aed2bdd1641014fe~FMiWGtQe21712217122epoutp03u
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180727101304epoutp032a97cd796c53afd4aed2bdd1641014fe~FMiWGtQe21712217122epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532686384;
        bh=1RnyrlFn+bEesy3c+ACi3cNVZauoFfSJ1Hl6+5aGSJg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=R7ERtEKjCxavw79sC0FepnpYNCTpaOjrIKGPZfg1APvRdN0uUMgnJeO7Sg6ShBxjx
         DZcKK1srANmRr5PSxrVK7kkDBjs5kvunMl0JeWHsxgRw+3iVAQ/euLbSJgV/zcyr4z
         r+sGH8gYeNhkLaHtSDUOWytMQ3qm801PcrSSZths=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.196]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180727101303epcas5p3e529defe7f2437cf6e50278712bafbf2~FMiU2VTMV2052020520epcas5p3W;
        Fri, 27 Jul 2018 10:13:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.6F.04303.F20FA5B5; Fri, 27 Jul 2018 19:13:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20180727101302epcas5p22561edd1d60101e611933ccff3e3d008~FMiUBZnCN2101321013epcas5p2Z;
        Fri, 27 Jul 2018 10:13:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180727101302epsmtrp1cdb7da1fc089b30d2ef63226b9efdbac~FMiT-6cKU2067520675epsmtrp1C;
        Fri, 27 Jul 2018 10:13:02 +0000 (GMT)
X-AuditID: b6c32a49-937ff700000010cf-58-5b5af02fbb22
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.14.03759.E20FA5B5; Fri, 27 Jul 2018 19:13:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180727101300epsmtip249cb5366ed80ffe197dabc5c4d294693~FMiSKeOGX1760417604epsmtip28;
        Fri, 27 Jul 2018 10:13:00 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH] drm/kms/crtc: Improving the func drm_mode_setcrtc
Date:   Fri, 27 Jul 2018 15:42:51 +0530
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmuq7+h6hog5c/ZCx6z51ksrjy9T2b
        xc4Hu9gtXp1/w2xxedccNouFH7eyWKw938picXfDWUaL5aevM1sc23qJ3YHLY3bDRRaPnbPu
        snts//aA1WPeyUCP+93HmTx2TtrL5NG3ZRWjx+dNcgEcUak2GamJKalFCql5yfkpmXnptkre
        wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA3KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslaINDY30DA3M9YyMgLRprJWRKVBJQmrGj51LmQu2+1VcePGbtYFxvm0XIyeHhICJxIwt
        T5m6GLk4hAR2M0psn76GHcL5xCix9P5+KOcbo8S05deYYFoebD/GCpHYyygx99trRgjnC6PE
        9/7XLCBVbEBVz+fMAKsSEXjJKHGz5QwrSIJZoFTiwc0mZhBbWMBJYteCe2BxFgFVoLGfoFbI
        Sdw818kM0iwhsIZN4vSfd2ANvAJlEo1fbjNCFLlIPJq+jxnCFpZ4dXwLO4QtJfGyvw3Knswo
        0XzWD2LQakaJsxd7oRL2Ei1TDgCdygF0kabE+l36EMfxSfT+fsIEEpYQ4JXoaBOCqFaRWPni
        MDPM+D8LulghbA+JzUt/gd0sJBArMf/nQ7YJjDKzEIYuYGRcxSiZWlCcm55abFpgmJdarlec
        mFtcmpeul5yfu4kRnNS0PHcwzjrnc4hRgINRiYc34HVktBBrYllxZe4hRgkOZiUR3jXXgUK8
        KYmVValF+fFFpTmpxYcYTYGBNpFZSjQ5H5hw80riDU2NzMwMLA1MjS3MDJXEeT/4BUcLCaQn
        lqRmp6YWpBbB9DFxcEo1MC44ydjBPfnqjQ2/2hak33qT3XKPeT3zVffEz/tuswgkOp2f8evd
        Qd8A97LlZs6bBNPXO//7MoenV3NDnf21L9VfnRo2sft7bi6aEOEl3VZz962hlODkh+zG79me
        fTF+5zapZ8f1xKVP6s5xBPmKbOfavuzJ1/dMCeUaMp6HmfzuZ7xoCBabckyJpTgj0VCLuag4
        EQDxPHDbgAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvK7eh6hogyNnVS16z51ksrjy9T2b
        xc4Hu9gtXp1/w2xxedccNouFH7eyWKw938picXfDWUaL5aevM1sc23qJ3YHLY3bDRRaPnbPu
        snts//aA1WPeyUCP+93HmTx2TtrL5NG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZP3YuZS7Y
        7ldx4cVv1gbG+bZdjJwcEgImEg+2H2PtYuTiEBLYzSixpH0qG0RCSmLZm21QtrDEyn/P2SGK
        PjFK/P97DSzBBtT9fM4MsG4RgbeMEq07T7OAJJgFKiXOPZ/MCGILCzhJ7FpwjxXEZhFQBVr3
        iQnE5hVwk+h4OYUdYoOcxM1zncwTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIDkEtzR2Ml5fEH2IU4GBU4uENeB0ZLcSaWFZcmXuIUYKDWUmEd811oBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MUvW3fC7275v8RUH27rntJh1F
        uwS0AutNet7eEDtz2P3UukcPy26u14hqd5kZczZuvhLDjLhXir3GvG95WhiuXLoef/lgreNM
        k82Lu+azifAY30h9GeIfPK0yMuVk7rSHSzPVlG/pl/8o1Wc5ukj614qDO+Q6NeSn3p64yVBG
        pyGeOev/3uStSizFGYmGWsxFxYkAzDrccz0CAAA=
Message-Id: <20180727101302epcas5p22561edd1d60101e611933ccff3e3d008~FMiUBZnCN2101321013epcas5p2Z@epcas5p2.samsung.com>
X-CMS-MailID: 20180727101302epcas5p22561edd1d60101e611933ccff3e3d008
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180727101302epcas5p22561edd1d60101e611933ccff3e3d008
References: <CGME20180727101302epcas5p22561edd1d60101e611933ccff3e3d008@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following changes are done to this func:
1. Currently there are many redundant error checks for
count_connectors, mode, fb and mode_valid.
if (crtc_req->mode_valid)
if (crtc_req->count_connectors == 0 && mode)
if (crtc_req->count_connectors > 0 && (!mode || !fb))
if (crtc_req->count_connectors > 0)
if (crtc_req->count_connectors > config->num_connector)

These 5 checks are replaced by just 2 checks.
if (!crtc_req->mode_valid)
if (!crtc_req->count_connectors ||
crtc_req->count_connectors > config->num_connector)

2. Also, currently, if user pass invalid args
count_connectors=0, mode=NULL, fb=NULL, code wont throw
any errors and eventually __drm_mode_set_config_internal
will be called.
With the modified code, this will be taken care.

3. Also, these error checks alongwith following
if (!file_priv->aspect_ratio_allowed &&
(crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK)

has been  moved  before taking mutex and modeset lock
because they don't need any lock. Moreover, after grabbing locks,
if its found that user supplied  invalid args, it will
be too late as getting lock may require considerable time.

4. Also, if modeset_lock is tried many times in case of EDEADLK
error, then this will be the code flow

retry:
	ret = drm_modeset_lock_all_ctx(crtc->dev, &ctx);

if (ret)-->this is true
		goto out;

out:
	if (fb)
	if (connector_set)
	drm_mode_destroy(dev, mode);
	if (ret == -EDEADLK)
		goto retry;
It can be observed that checks on fb, connector_set and call to
mode_destroy are redundant in retry-case.
If we keep if (ret == -EDEADLK) just after out:,
that will avoid redundant checks.

In the normal case (non-retry), all checks will be required.
Thus shifting of if (ret == -EDEADLK) right after out label
won't affect normal case.

5. Also, kfree is moved inside if (connector_set).
6. Also, if major error checks are in the beginning of the func
and if user supplied invalid params,  we will exit the func sooner
without wasting much effort in finding crtc and framebuffer etc.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 drivers/gpu/drm/drm_crtc.c | 207 +++++++++++++++++++++------------------------
 1 file changed, 98 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 98a36e6..15927e7 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -578,7 +578,25 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	 */
 	if (crtc_req->x & 0xffff0000 || crtc_req->y & 0xffff0000)
 		return -ERANGE;
-
+	if (!file_priv->aspect_ratio_allowed &&
+		(crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK) !=
+		DRM_MODE_FLAG_PIC_AR_NONE) {
+		DRM_DEBUG_KMS("Unexpected aspect-ratio flag bits\n");
+		return -EINVAL;
+	}
+	/* Check if the flag is set*/
+	if (!crtc_req->mode_valid) {
+		DRM_DEBUG_KMS("mode_valid flag [%d] is not set\n",
+		crtc_req->mode_valid);
+		return -EINVAL;
+	}
+	/* Check the validity of count_connectors supplied by user */
+	if (!crtc_req->count_connectors ||
+		crtc_req->count_connectors > config->num_connector) {
+		DRM_DEBUG_KMS("Invalid connectors' count %d\n",
+		crtc_req->count_connectors);
+		return -EINVAL;
+	}
 	crtc = drm_crtc_find(dev, file_priv, crtc_req->crtc_id);
 	if (!crtc) {
 		DRM_DEBUG_KMS("Unknown CRTC ID %d\n", crtc_req->crtc_id);
@@ -595,134 +613,105 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	if (ret)
 		goto out;
 
-	if (crtc_req->mode_valid) {
-		/* If we have a mode we need a framebuffer. */
-		/* If we pass -1, set the mode with the currently bound fb */
-		if (crtc_req->fb_id == -1) {
-			struct drm_framebuffer *old_fb;
+	/* If we have a mode we need a framebuffer. */
+	/* If we pass -1, set the mode with the currently bound fb */
+	if (crtc_req->fb_id == -1) {
+		struct drm_framebuffer *old_fb;
 
-			if (plane->state)
-				old_fb = plane->state->fb;
-			else
-				old_fb = plane->fb;
+		if (plane->state)
+			old_fb = plane->state->fb;
+		else
+			old_fb = plane->fb;
 
-			if (!old_fb) {
-				DRM_DEBUG_KMS("CRTC doesn't have current FB\n");
-				ret = -EINVAL;
-				goto out;
-			}
-
-			fb = old_fb;
-			/* Make refcounting symmetric with the lookup path. */
-			drm_framebuffer_get(fb);
-		} else {
-			fb = drm_framebuffer_lookup(dev, file_priv, crtc_req->fb_id);
-			if (!fb) {
-				DRM_DEBUG_KMS("Unknown FB ID%d\n",
-						crtc_req->fb_id);
-				ret = -ENOENT;
-				goto out;
-			}
-		}
-
-		mode = drm_mode_create(dev);
-		if (!mode) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!file_priv->aspect_ratio_allowed &&
-		    (crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK) != DRM_MODE_FLAG_PIC_AR_NONE) {
-			DRM_DEBUG_KMS("Unexpected aspect-ratio flag bits\n");
+		if (!old_fb) {
+			DRM_DEBUG_KMS("CRTC doesn't have current FB\n");
 			ret = -EINVAL;
 			goto out;
 		}
 
-
-		ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
-		if (ret) {
-			DRM_DEBUG_KMS("Invalid mode\n");
+		fb = old_fb;
+		/* Make refcounting symmetric with the lookup path. */
+		drm_framebuffer_get(fb);
+	} else {
+		fb = drm_framebuffer_lookup(dev, file_priv, crtc_req->fb_id);
+		if (!fb) {
+			DRM_DEBUG_KMS("Unknown FB ID%d\n",
+					crtc_req->fb_id);
+			ret = -ENOENT;
 			goto out;
 		}
-
-		/*
-		 * Check whether the primary plane supports the fb pixel format.
-		 * Drivers not implementing the universal planes API use a
-		 * default formats list provided by the DRM core which doesn't
-		 * match real hardware capabilities. Skip the check in that
-		 * case.
-		 */
-		if (!plane->format_default) {
-			ret = drm_plane_check_pixel_format(plane,
-							   fb->format->format,
-							   fb->modifier);
-			if (ret) {
-				struct drm_format_name_buf format_name;
-				DRM_DEBUG_KMS("Invalid pixel format %s, modifier 0x%llx\n",
-					      drm_get_format_name(fb->format->format,
-								  &format_name),
-					      fb->modifier);
-				goto out;
-			}
-		}
-
-		ret = drm_crtc_check_viewport(crtc, crtc_req->x, crtc_req->y,
-					      mode, fb);
-		if (ret)
-			goto out;
-
 	}
 
-	if (crtc_req->count_connectors == 0 && mode) {
-		DRM_DEBUG_KMS("Count connectors is 0 but mode set\n");
-		ret = -EINVAL;
+	mode = drm_mode_create(dev);
+	if (!mode) {
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
-		DRM_DEBUG_KMS("Count connectors is %d but no mode or fb set\n",
-			  crtc_req->count_connectors);
-		ret = -EINVAL;
+	ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
+	if (ret) {
+		DRM_DEBUG_KMS("Invalid mode\n");
 		goto out;
 	}
 
-	if (crtc_req->count_connectors > 0) {
-		u32 out_id;
+	/*
+	 * Check whether the primary plane supports the fb pixel format.
+	 * Drivers not implementing the universal planes API use a
+	 * default formats list provided by the DRM core which doesn't
+	 * match real hardware capabilities. Skip the check in that
+	 * case.
+	 */
+	if (!plane->format_default) {
+		ret = drm_plane_check_pixel_format(plane,
+						   fb->format->format,
+						   fb->modifier);
+		if (ret) {
+			struct drm_format_name_buf format_name;
 
-		/* Avoid unbounded kernel memory allocation */
-		if (crtc_req->count_connectors > config->num_connector) {
-			ret = -EINVAL;
+			DRM_DEBUG_KMS("Invalid pixel format %s, modifier 0x%llx\n",
+				      drm_get_format_name(fb->format->format,
+							  &format_name),
+				      fb->modifier);
 			goto out;
 		}
+	}
 
-		connector_set = kmalloc_array(crtc_req->count_connectors,
+	ret = drm_crtc_check_viewport(crtc, crtc_req->x, crtc_req->y,
+				      mode, fb);
+	if (ret)
+		goto out;
+
+	connector_set = kmalloc_array(crtc_req->count_connectors,
 					      sizeof(struct drm_connector *),
 					      GFP_KERNEL);
-		if (!connector_set) {
-			ret = -ENOMEM;
-			goto out;
-		}
+	if (!connector_set) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-		for (i = 0; i < crtc_req->count_connectors; i++) {
-			connector_set[i] = NULL;
-			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
-			if (get_user(out_id, &set_connectors_ptr[i])) {
-				ret = -EFAULT;
-				goto out;
-			}
+	for (i = 0; i < crtc_req->count_connectors; i++) {
+		u32 out_id;
 
-			connector = drm_connector_lookup(dev, file_priv, out_id);
-			if (!connector) {
-				DRM_DEBUG_KMS("Connector id %d unknown\n",
-						out_id);
-				ret = -ENOENT;
-				goto out;
-			}
-			DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
-					connector->base.id,
-					connector->name);
+		connector_set[i] = NULL;
+		set_connectors_ptr =
+		(uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
+		if (get_user(out_id, &set_connectors_ptr[i])) {
+			ret = -EFAULT;
+			goto out;
+		}
 
-			connector_set[i] = connector;
+		connector = drm_connector_lookup(dev, file_priv, out_id);
+		if (!connector) {
+			DRM_DEBUG_KMS("Connector id %d unknown\n",
+					out_id);
+			ret = -ENOENT;
+			goto out;
 		}
+		DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
+				connector->base.id,
+				connector->name);
+
+		connector_set[i] = connector;
 	}
 
 	set.crtc = crtc;
@@ -735,6 +724,11 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	ret = __drm_mode_set_config_internal(&set, &ctx);
 
 out:
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
 	if (fb)
 		drm_framebuffer_put(fb);
 
@@ -743,14 +737,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 			if (connector_set[i])
 				drm_connector_put(connector_set[i]);
 		}
+		kfree(connector_set);
 	}
-	kfree(connector_set);
 	drm_mode_destroy(dev, mode);
-	if (ret == -EDEADLK) {
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry;
-	}
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	mutex_unlock(&crtc->dev->mode_config.mutex);
-- 
2.7.4

