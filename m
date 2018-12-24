Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286EFC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB68E21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUnAh/Rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbeLXNU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:20:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45276 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXNU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:20:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so5796934pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=CUnAh/Rqve+lXu2kbGyo9bkEQtyA5AD0Ti2n6JA3IoBI/ZQ2YxAVlgC5u47FeQQMhn
         RpjsyPtlNuUeBZsoZ+4VsJYM9iGoFNhhpJn2J68frv2rKaaO0T0uYDo2Sj+NUpduPHzm
         EgtQ1QgTv89NIcvJAt/gcyrEod5yHLdsLtYUsZaZpo25zf5zGahIyOpp2kMc5TgdpRt8
         nKZrw+ux+pYMX7mul836T5MMdBuL4Kvuy3Nh05KJbMHRyYflMaTF53Q70EqkpjhsZmfa
         17K6i6wlPIIC5zVJ30t12v5tkCWaDvMmkBB1Kla3Tlld8MXLACGIePanxTtvXoop3ANE
         8tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=nSjmgtA3hrWTwTTbwBndhFBeg+zv7gDYZQos5HyWU1aecU31QrM6yvf+34zLJN7cFL
         kJ8CiOGLN/V5nW1sEPjTbREBh41pvTL8jXVRBO+hlNnzKguqw3tSKfOTDKgRHRaawQFw
         MWjZe2YVHetmv+5yz3s7IJHW0xR1AaFqkQo5/Hpbeqz69gEWIQEYvzB+zYA1kYi/m0Gv
         HydnsIfM07hnOHKAHc9mWKhCwowyz4gJEChDCdmjobQ0nkTa/5y9CZWucSPySM+y6mQk
         pM2hZBKgobZZl/HaRCg4SuB4g6TGOxcpNE5Zvzu72gSItDz14pN5vv0iTPwWnG2hPqbe
         LRSA==
X-Gm-Message-State: AJcUukdQw167jZi45oG+QkTAMp8/HIrNDgqT+I/VHVGsIIqbDmAJ3oxJ
        VZsFJi2q8S32ckXEpwwTeAk=
X-Google-Smtp-Source: ALg8bN5/gh7iKSFeVbCDxnlm68Sjq9dvwVK/fGxmQ8vvM0+wZbEa4aML94BwBBLnwyDRbrgezk3ImQ==
X-Received: by 2002:a62:c185:: with SMTP id i127mr620171pfg.43.1545657657811;
        Mon, 24 Dec 2018 05:20:57 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id 84sm87589245pfa.115.2018.12.24.05.20.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:20:56 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:54:53 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH v5 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181224132453.GA22132@jordon-HP-15-Notebook-PC>
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
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 47ff019..c21e5d1 100644
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
-
-		addr += PAGE_SIZE;
-	}
-	return 0;
+	ret = vm_insert_range(vma, vma->vm_start, xen_obj->pages,
+				xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
+	return ret;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

