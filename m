Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6936C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A577920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESGAR4J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfAOOEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:04:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40143 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfAOOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:04:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so2411819lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBs1m1L6hJVqllIR9X8eJg131udTFaLGSlu1wZ0Z74Q=;
        b=ESGAR4J3IWLEgtRycPWVRTuaBx6UQrDUdY9z6qURib0vNoVv7+YiVEoGYzq4j5qk+m
         0hjVR62cQVmxOWSEs7uWzeGuekE4kbXJ7KcY78ITHC2kACV3f6OJjOaSPDj+pL4P+/t4
         nZoCDzV2eds9jCEOfY9s61vcKVsEqgofVVKdWhhh1yk0QoITkPOgBv7DoP4B/xX1aZSC
         sWU1fMQJ5PlV9B39lt63fvnQgkdqzvUzlMqQ6VSPyGrJn0Jl42NB+MVKokYg5HzrYeRk
         i5lbCPsBonjBSgJl95ozxUD5CkZ6QPoKF4Ill2jNnID7J5cjfkw/2ppqhULPppAWC3Ie
         zDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBs1m1L6hJVqllIR9X8eJg131udTFaLGSlu1wZ0Z74Q=;
        b=cwvvJ2YIY2SH39vZOmnIyCh0F1BOEsBGsWCzM9VfSfC01Yd9fyfI+wFhJpygk56t6V
         i2dTGVttGz7C8Kp2+sVfRCsiJPiBzXWIOePxdu2vUo4+I/8uIg/xwYUAzyCtyqtZ2h+j
         GpElkb/C/ETwwHe8hRs4djytazJVnicSuTJFruKcPqHx5lSUfXLmAf8opRXxc0kjRLo/
         NxrzQbRbpS6lHJUHYxVxWAk6eKQ6kBIQA4N15W06BZsu3p68Y1S7JGOTLIEoUJVwx9vG
         F+gOwWblbMskNo9DSkak6GZ9RyXYcHHIwvW6djFmmbFLm+nnYjvwCXJU495Q1q7nHH0Z
         5+3w==
X-Gm-Message-State: AJcUukdHzj4g4c//tpD6vGI6U5ggjTEGHHlFuciEJk92yxHFYfhxw51v
        9VsosEfeRKh7Z0b+a4Wwz1c=
X-Google-Smtp-Source: ALg8bN4qrJgRyA6FbceZVy8DkExdZixUtoPDzCY+b3PUmVV/k38heEEYTX5oqPrPxKEiev4CVTYzIA==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr2617856ljb.104.1547561066774;
        Tue, 15 Jan 2019 06:04:26 -0800 (PST)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id g12-v6sm566917lja.74.2019.01.15.06.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 06:04:26 -0800 (PST)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, kraxel@redhat.com,
        noralf@tronnes.org, hch@infradead.org
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2] drm/xen-front: Make shmem backed display buffer coherent
Date:   Tue, 15 Jan 2019 16:04:20 +0200
Message-Id: <20190115140420.4652-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

When GEM backing storage is allocated with drm_gem_get_pages
the backing pages may be cached, thus making it possible that
the backend sees only partial content of the buffer which may
lead to screen artifacts. Make sure that the frontend's
memory is coherent and the backend always sees correct display
buffer content.

Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

---
Changes since v1:
 - Remove GFP_USER|__GFP_DMA32 mapping flags (Gerd)
 - Use drm_prime_pages_to_sg directly (Noralf)

 drivers/gpu/drm/xen/xen_drm_front_gem.c | 38 ++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 28bc501af450..0b0d9b4f97dc 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -32,8 +32,11 @@ struct xen_gem_object {
 	/* set for buffers allocated by the backend */
 	bool be_alloc;
 
-	/* this is for imported PRIME buffer */
-	struct sg_table *sgt_imported;
+	/*
+	 * this is for imported PRIME buffer or the one allocated via
+	 * drm_gem_get_pages.
+	 */
+	struct sg_table *sgt;
 };
 
 static inline struct xen_gem_object *
@@ -124,8 +127,28 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
 		goto fail;
 	}
 
+	xen_obj->sgt = drm_prime_pages_to_sg(xen_obj->pages,
+					     xen_obj->num_pages);
+	if (IS_ERR_OR_NULL(xen_obj->sgt)) {
+		ret = PTR_ERR(xen_obj->sgt);
+		xen_obj->sgt = NULL;
+		goto fail_put_pages;
+	}
+
+	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
+			DMA_BIDIRECTIONAL)) {
+		ret = -EFAULT;
+		goto fail_free_sgt;
+	}
+
 	return xen_obj;
 
+fail_free_sgt:
+	sg_free_table(xen_obj->sgt);
+	xen_obj->sgt = NULL;
+fail_put_pages:
+	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
+	xen_obj->pages = NULL;
 fail:
 	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
 	return ERR_PTR(ret);
@@ -148,7 +171,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
 	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
 
 	if (xen_obj->base.import_attach) {
-		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
+		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
 		gem_free_pages_array(xen_obj);
 	} else {
 		if (xen_obj->pages) {
@@ -157,6 +180,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
 							xen_obj->pages);
 				gem_free_pages_array(xen_obj);
 			} else {
+				if (xen_obj->sgt) {
+					dma_unmap_sg(xen_obj->base.dev->dev,
+						     xen_obj->sgt->sgl,
+						     xen_obj->sgt->nents,
+						     DMA_BIDIRECTIONAL);
+					sg_free_table(xen_obj->sgt);
+				}
 				drm_gem_put_pages(&xen_obj->base,
 						  xen_obj->pages, true, false);
 			}
@@ -202,7 +232,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	xen_obj->sgt_imported = sgt;
+	xen_obj->sgt = sgt;
 
 	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
 					       NULL, xen_obj->num_pages);
-- 
2.20.1

