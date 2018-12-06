Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BF320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt35VdLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BF320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLFSjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:39:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38835 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLFSjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:39:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so526451pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=gt35VdLOJLkkwu6HM2z/QMOGYwYxQY75TZOeYdRPNnTaNn34UV2lOUy11lpMiKEIfl
         pJUTYq87JeZixJZt6DZ2BEh2ecwXtuaUNMY4mqSOb/ww0qlIfkmmuqzotryN5D9+6oQi
         9xhmmpXQscZwqEWbKQ208V/yDxrw52NwRgJ141Brcflo/mxEtx/n6YjZDnoXQO/6v7R5
         NuiN1qnkxp/ZrYifd/oDMRri6z2c+QGns5ibd0289c2wHJf8F6j730XXRwGlnIw4sp8a
         L+bo4aqgKCsZYoPJZPAGP8JM7G+Rsh8zuj4x+O4mxtV2I8OIYHnpyGahS2dJCHTOy092
         pWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=pkTSkgP4CtQ/Xjf+gULAAJGZEyzDgp7LmMjjkJMNM2uMAQDsHceLEsodID00ClIQsx
         NvJ3Wf24Yf6t60/neI1OC2fjMP9ou/GHhReDMDvKbUl9y5vWh5vlK6LbFKmHM9WwWbnf
         XxfhEFAuebQopP++tE+CKhlpuVkOJseSCzQg/JPYtB8qiotOv2yc1JOPmAiSMcZihCQm
         Zo9JNvlt+luo7TruwgkjoCKfPYwX715SQFpM8z4EtmN95Pxd7+eoTAukg7oW0WYytDDY
         ShHOgpd+iRRCNu1gQ6OJveVsd/qFgIc8cdgpAPEOVJ/Z+rlU2mKGeK0cRxn6xk7WXGzD
         2OmQ==
X-Gm-Message-State: AA+aEWarQxX1RxykMVd9krrEes1XaDSlLyVVAMJCFJU2fRca21+KyZ75
        ClrjYxsxJcBIMB0ktEJ4W6A=
X-Google-Smtp-Source: AFSGD/UfFSt2nT8PksMeYnwOlOFwT/wi4bvRW16Y0LYOo7p9wxEoYqUr+4/gwU/InzrrQl8sQGE8eQ==
X-Received: by 2002:a63:2849:: with SMTP id o70mr23387850pgo.155.1544121564152;
        Thu, 06 Dec 2018 10:39:24 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
        by smtp.gmail.com with ESMTPSA id p11sm2259233pgn.60.2018.12.06.10.39.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:39:23 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:13:11 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH v3 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181206184311.GA29651@jordon-HP-15-Notebook-PC>
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

