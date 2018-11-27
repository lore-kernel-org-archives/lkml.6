Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E985C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D94D20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYWwjzx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94D20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeK0Va3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:30:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37035 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeK0Va2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:30:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so16012497lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1gi3+Dk1YWB2w+kSeJ4WK1TaNSfKWfiECwYi2qFw50=;
        b=KYWwjzx9QQKwYOb8E0aV8/6ZRsBNFF1px72cNCuDKHZZyYrvPGsBeHXrW9X+Q2zIcH
         HtUP70cDHk8ySZ/WlsOAmdRaVGPfPFbapSVfUbD9yk91pNdZF/pAIEqnOGBIaUylTqVT
         28195MYHuNboukIqyxXYUI0fYWH1Cbn4rdQ9uTkhQgeIXEB6UbU97NX+Mo8P7L594bNu
         OUg1l8UCsnjR/ppsGbD6C4t91RgMYSRecaflNfLgXoJ5K52BJKv7NkhvXOuE0sh/vE8S
         OtSejGxniUKebDT1eHgtNO0o1+bCNbon9elR8d9BaAh8zSN4oNELfm/iRH/cg93vHcgG
         gVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1gi3+Dk1YWB2w+kSeJ4WK1TaNSfKWfiECwYi2qFw50=;
        b=Bb0pANQMlmfxmI9WFD7PlwQKjSL0RHzyPvrbUmkIXMrx36Aa+CKmPCf45/eP4Ou9wq
         w3vfqLK/yJYYBpkHqnTWIs0J7J7yasQl1bPY01k0+Cnk+o9JuFNot4uE2N2Y95yy3G8J
         AWBRm+eg1mOhrlfTCGJnnffqWBD73I7w8S8TWMAsdnfHzpbF3p+kgjkA60RI77QFFHyH
         Y8t70hcWyNS//ApKSnQEsBaYNX5Dc46iAKenIn5l3kBEZ6I8l4S7JbMSNmphKmZakwQS
         3UIhXZzhGcNu8uIPsmpf+eGC/7fwKS7WapKtpj17knPWW8PZAAoNdKqljUUg2KiWk0Ki
         aZjQ==
X-Gm-Message-State: AGRZ1gLqTmiuSuyUDFpeIvbdZhk/KboWv5Vsba+f1GK2cpaCpmbP9CFP
        IfMATvqMtucNl0381AinjVc=
X-Google-Smtp-Source: AJdET5ffzbOsFcdrcCLk9mkGLx/VkHPl0L9k9rEJTjhDaFg3Z0mdZK7vj+ZbQHIUySRuumw8aI40Ug==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr19390351lfi.3.1543314779029;
        Tue, 27 Nov 2018 02:32:59 -0800 (PST)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id 65sm515098lfp.55.2018.11.27.02.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 02:32:58 -0800 (PST)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Date:   Tue, 27 Nov 2018 12:32:52 +0200
Message-Id: <20181127103252.20994-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.19.1
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
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 47ff019d3aef..c592735e49d2 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -33,8 +33,11 @@ struct xen_gem_object {
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
@@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
 	return xen_obj;
 }
 
+struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
+{
+	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
+
+	if (!xen_obj->pages)
+		return ERR_PTR(-ENOMEM);
+
+	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
+}
+
 static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
 {
 	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
 	struct xen_gem_object *xen_obj;
+	struct address_space *mapping;
 	int ret;
 
 	size = round_up(size, PAGE_SIZE);
@@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
 		xen_obj->be_alloc = true;
 		return xen_obj;
 	}
+
 	/*
 	 * need to allocate backing pages now, so we can share those
 	 * with the backend
 	 */
+	mapping = xen_obj->base.filp->f_mapping;
+	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
+
 	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
 	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
 	if (IS_ERR_OR_NULL(xen_obj->pages)) {
@@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
 		goto fail;
 	}
 
+	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
+	if (IS_ERR_OR_NULL(xen_obj->sgt)){
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
@@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
 	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
 
 	if (xen_obj->base.import_attach) {
-		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
+		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
 		gem_free_pages_array(xen_obj);
 	} else {
 		if (xen_obj->pages) {
@@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
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
@@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
 	return xen_obj->pages;
 }
 
-struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
-{
-	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
-
-	if (!xen_obj->pages)
-		return ERR_PTR(-ENOMEM);
-
-	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
-}
-
 struct drm_gem_object *
 xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 				  struct dma_buf_attachment *attach,
@@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	xen_obj->sgt_imported = sgt;
+	xen_obj->sgt = sgt;
 
 	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
 					       NULL, xen_obj->num_pages);
-- 
2.19.1

