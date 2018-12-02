Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F104E20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5hPFJ3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F104E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbeLBGU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:20:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41841 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLBGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:20:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so4816282plm.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=p5hPFJ3iSMtwwIFg6uQF6/1FmqoFOIF7Z7cv0qKHYdoPTS1Dget3BqY7fzgcPpg+ne
         FLj3CU5H9J/pEfpGYVp/1OdBYEwxCU/2uqb+U3AsdayDjssFGsuV06VCAYzDEkwn9WhA
         hZTFsU+FKQ8rZPQP6e3h0YATS8ToxJkercqFvK8LYdI3nmE1fdElhw3UuPJ3SPbmE7Mo
         cBUiP44KfYpWIve7yAyu+ztKUBjJIndFcvRtrpBuWP7l1iCGTGGA4lt3NB5l7Fe7kWh2
         U5m3UyT0Clxp1LaoZO5I3Kz4PCL/3x5D32MDn+iAFStg4AlR7uIOpaa0NinYWmgWbCk6
         8UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YwqNkUNPLYdK07Ra2/mSQ+jZoA95B8gqjnUO/EioucE=;
        b=HyideWR+YU5iR9roXEUnBeLdZCUwhlYOt0t29Pp47tei8yBghBmM7WxSwlrK/VVXU3
         DOd0VF5XyJjX+MVPddQuECkGt556tekHvfE1kedPSDBhlfWKw/G2DUtlppu8KUSYo8gw
         ePfs3fEHE5HrGBMzlCZVPJP0661oFXrCJCQIKAS2HrH7SvRiMTKEWNkTWjkLoKph5pV1
         M1mEdO0W1wDz+Z8xB3w23IHXgPOoLKzJ5FEJ4SadVixdT++M/nAHyVUHMQ+75DFyzUAl
         u8Qd+T6Ircww1izfHX0da8lJ23w5H4tGHCoTUIurTHK4vFW2PDKoFbnQu4k0ZUs+Sspj
         xBaA==
X-Gm-Message-State: AA+aEWb5RyOmDK579OVZI/kfdFXm4uGB/+A1ADKqBXpcTqMux1CI4htW
        QSxulzZsH5eL75rvU9xxiiY=
X-Google-Smtp-Source: AFSGD/VY5/fEWSrHIAji3y6gn1HY31kQbbulywZEulPpaUoQZqHYw4pOSjtRtYYrVApigSKFsr3e/g==
X-Received: by 2002:a17:902:7603:: with SMTP id k3mr11634668pll.285.1543731624627;
        Sat, 01 Dec 2018 22:20:24 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id 128sm16732440pfu.129.2018.12.01.22.20.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:20:23 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:54:08 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH v2 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181202062408.GA3178@jordon-HP-15-Notebook-PC>
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

