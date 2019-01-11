Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53FE20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn8yGcSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbfAKPGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:06:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388449AbfAKPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:06:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so6428548pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jJyfr251abKPUjfrLnfnZBYdiVZ7BdP/pFKC0YWuEDs=;
        b=Jn8yGcSec9ppfdCMuebFOrYumbJez4VJp9ziQIzdHm4MyE7zHGBNv9jGGByDvcgQpn
         a4Mb1kNvbp+zXJnQq1QgIOOI7k4m7EBEOI8R9NBuJ+gOUIP+fz5rqpguuFagKdcElYjD
         +1EqR/6zuGgPokgzBSRbAqHNI2HGCTOaMZ7jveItEs2ypgi/m2luTW5lGJazXMnGy64q
         MXCUeX8B4/c4+WJv1umzbb5ZhKe3bWYqfF0fK3MwigxOq0vl1h7hkKTts1HzhjTGM/nY
         qASR6ayanD3G4foV2vBVIcJhbX1WEF9mjWene/Rj0RM1C+DPFca6892JPfFLhNGY97Kh
         7gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jJyfr251abKPUjfrLnfnZBYdiVZ7BdP/pFKC0YWuEDs=;
        b=kne9J5bA4x2K9ekNniL8HdfMqOwQRTYasrYokgNEl3dfJVThMHLkc/T5F0yetv9GRc
         4Ljp9SeoL0WBbtboPob4j/lIM7URRFuKHsYZrdbYYIae8iG46cnVtc1c5JY//yndOy9n
         VuSyRkgd9SbijXfSDYedw2lsfjYnPL3xi5Eqg/jOnxmz2bV/wVf5EtypHUGPP1Da0AH2
         AE4lLhGrRbG9MdMHAZ6+Ed7Wfof2W1S0g3Q/KtP/Q3k1ZpkplvDCjuTPRhRteBfewEAo
         nGg9skKfIKLXh6qUES3obMHesb9sWA5kHjaYhILnnsnyjIYRHXHoL3gM37/a/pSMfIi7
         m6hA==
X-Gm-Message-State: AJcUukcSolUVB1+AGSXsQb8mksOyEakWHUEFiKyj/oolOxf0VSyMDMc9
        7TzBG9ckerWWeR1lxFPDMjM=
X-Google-Smtp-Source: ALg8bN76xSFly+CWNyQpefhrTarhDoTZdH79A8t9NSuLjWP1kW/Wkt1ixSodqPFgFeaytLToyuoA9A==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr14876943pfn.91.1547219197536;
        Fri, 11 Jan 2019 07:06:37 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id 6sm165163391pfv.30.2019.01.11.07.06.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:06:36 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:40:37 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20190111151037.GA2781@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 47ff019..9990c2f 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -225,8 +225,7 @@ struct drm_gem_object *
 static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 			struct vm_area_struct *vma)
 {
-	unsigned long addr = vma->vm_start;
-	int i;
+	int ret;
 
 	/*
 	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
@@ -247,18 +246,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 	 * FIXME: as we insert all the pages now then no .fault handler must
 	 * be called, so don't provide one
 	 */
-	for (i = 0; i < xen_obj->num_pages; i++) {
-		int ret;
-
-		ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
-		if (ret < 0) {
-			DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
-			return ret;
-		}
+	ret = vm_insert_range(vma, xen_obj->pages, xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
 
-		addr += PAGE_SIZE;
-	}
-	return 0;
+	return ret;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

