Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1C921473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fws+fhY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbeLQUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:20:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34115 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeLQUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:20:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so6665013plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=Fws+fhY7OGBeBQzZIt7AfmMfEWU0cNhX2vqMdb1yNiRZXNX1tRQHb4vYuxPcpPKNJ1
         Hb+0nVDcrQsOZM5YJYZg8lWXylPHNMhFUab14v+d1rI1iTEXaGbE72ZNINF4xAYqtmK3
         u2xSL5jg5k0XWrMMwKSdNHYiXIl056gtmnrnU1K5z6xmkCg6maIGr61iUzFsdp7m6p5b
         AhXfHeEceYCaMXLYAJn7+/rBRGa4IegyZWt9JvH1ABBLNl4zbVOYWPDUsGAgsSpwRlQY
         uB6uGb/aH0cnaw3DCa8lUxnntiluqFAER78NHS2Fl50o3leVq1m7/6gqtSGA2sxohSyS
         L2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=glrSJmwX67dF6u4w5FUWK7a1lFsZQB9PgFnGG14sxBNwvZ1I3OaglnROiJXxZqlDIl
         +ttiACTEnMt3P2ID/ncsU6/2VfxjX5nvlY934ba4cYDcfKhHDj4jSJp+vfBUGdXe6I2o
         PnsPwFQb/O7HM9EbKjmNlEsOTub8ozkQJa4aFTrhxtLqb0JUS15BYTPA5OC9SItcYH+Y
         pNanYUWmlDRhTYB2B0+mY+C4MectHvCAvEBjFfFqvcOt8Yh9fIEklnm2bmWHb7CUpNRU
         KzaTQ9GdYM0ufnwrWnT38tttz+VftEOwRDQL/nXv9Gn3L11LpdNBxijmunvmLCchSzg+
         YweQ==
X-Gm-Message-State: AA+aEWaVe58uifyqsYKBtY3KYg4F9vUaJudxuniC8J2FFqJOJZ2es9fu
        H+yonyk10ZfRdsmiLJTW54g=
X-Google-Smtp-Source: AFSGD/XGXG9KVSKHfEOg6j87CYwUtc/H11tveEpFu3OIi9T52naHMGkf12FyOB+zZiJiH4z/gZspFg==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr13746784plb.86.1545078023341;
        Mon, 17 Dec 2018 12:20:23 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id 202sm25834765pfy.87.2018.12.17.12.20.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:20:22 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:54:14 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH v4 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181217202414.GA13431@jordon-HP-15-Notebook-PC>
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

