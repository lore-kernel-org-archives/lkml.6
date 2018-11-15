Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BA32146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaSnmTGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BA32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbeKPBx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:53:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36969 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:53:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so7201299pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AIX2iBgnpBtMYOZdpGjm4pel7//JuaOij1dpz1xfGwk=;
        b=iaSnmTGxauxWoYCvtec0ALIvyDVANHjr0E0iWMOy4jVAkdzU0MtkTmDfa6SpFo8gTx
         jcVLoP7zG/gd8POY1+AqTH9V7De1H5Rs1TwYUfSBwTnjo7q54144wWJrm4ucHjXWyI4X
         u+cxZtRfnMBT51mS2ReqTU0bKsePqOAMCssP1vnITv8YsZkW68607kbxO3Lo5iD0R3P9
         DN0QuSwxEYqsDlhwAXMIu2Uank6RpS0pkXbAGiUikxQ7LqdmtANZ1DIOh4IFAtGGBXVy
         fEGg1pQNeorVxVXtIaYLEoQF8vnJNXp6Rya7AX3pFj2I3aucj/YI4hvc/IgXsjyyLDR5
         +Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AIX2iBgnpBtMYOZdpGjm4pel7//JuaOij1dpz1xfGwk=;
        b=YVaPXQ5W7GttLSrYzIHooc5sh+TXq9P+HiJdeR4ILSWGSqMKtBB4Wbeb8SnnpRF4ZF
         iT7IzRjwkGX3KUJBUzYZHS75/S9bgh7/2s3HNmvzsZDZfWS/TnXY7Z/Bycf3SA1eOJYj
         0j/lIqvNBqWk/ZBQZKKD1V8wq/+fATiSoUpoJwzNF0c+0SZZmYnbQOUmlTUNv20sGfZw
         ImGE6j9DRhuA2ArE9l+JUyzb+TpViktRYnWBrcp3fvVIp2uFjNJ27jc4WKitJsSXKiCD
         8PgflS34rAxWFCsAzybc6P3PLG11misTwnt1Icfg4oF+MtsxqLi6rVYb4AFT1X4jB0dD
         M8tQ==
X-Gm-Message-State: AGRZ1gJhSxWTbtUrmmhp8gFDWh/f7jobVmLfhpaploELyMDo8roGswog
        GkYGZbX83mW7+xDWCbyXyU4=
X-Google-Smtp-Source: AJdET5dZn74Y09JVDuVoqOuwbST/m0UXK3vcdwDSp4OFu4wopzDls58DF/KopJXuYC5ZxGgDjTn4UA==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr6374565pgl.282.1542296736882;
        Thu, 15 Nov 2018 07:45:36 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id b2sm24504163pfm.3.2018.11.15.07.45.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:45:35 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:19:13 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181115154912.GA27969@jordon-HP-15-Notebook-PC>
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
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 47ff019..a3eade6 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -225,8 +225,7 @@ struct drm_gem_object *
 static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 			struct vm_area_struct *vma)
 {
-	unsigned long addr = vma->vm_start;
-	int i;
+	int err;
 
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
+	err = vm_insert_range(vma, vma->vm_start, xen_obj->pages,
+				xen_obj->num_pages);
+	if (err < 0)
+		DRM_ERROR("Failed to insert pages into vma: %d\n", err);
+	return err;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

