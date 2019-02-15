Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1001C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D42D2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foVgED8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfBOCmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:42:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35646 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfBOCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:42:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id z15so4109341pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=foVgED8YU33cGUdNyMsYu1taL/xGldIA8jDJx5x9y9I6QigtUvC602CKjwOr0ZsAS/
         PrLVwNvSCYqqXgJkNNgsj/JW4o6PWnnMVV+sOZHXGFsGHwcW805LK+wgOzI/x/OVBO8m
         OE0NJpOQoDOheB7ogbrxz4yXHYX8Q4ORkgGb4p4hR8jDn2jxBGx513wY4g/BSbtUttC0
         +EUbqxPKWKxaEIwFfueP5dYGJ5wiFaiaVgytXN65xCDqGoDPEgYzQajnm8GLjMI6x6lJ
         uIsXrJrh4nv4qyfZmh7llHMdCo3NwZqLV9pBFVPB3QNi9ryMrkqN29sj6ImJovEthc7N
         Txrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=VqvwZ81f7KzE2ADPdyZWieE8Zlkey2ZwIabns0/V8FX6cz291uh/Gy3D++IlcnIDfm
         J3E752UQFbZbASILHP/pZsmL4CJOG9DVj/KGjreoyGxxA/BzaPwqXG5lA3qdh4cuvqBW
         ez2s5/7/23usznoCwI3HcXcTKXW62EtRYT8RDlvCIgO8ZFS4swc58sMAnoHxIHNCnAoL
         pUdIHkiEHUKqIv9zKctVP/IXCx+v/Nt0pEchz/nLk6GGTRccq6Zagx1MS+6DuEnm5F5l
         U6EXt5Dx439RgXs+zsUu0A345W+udIm8IHWB/0EYSt5GcQRZa9uq7k1K3BhTxsgNRYoc
         m1bw==
X-Gm-Message-State: AHQUAuaeZNbpYYDax73lTyEaX9801StDfNn6Q2zZ4byt/0L3c1S+Tn3u
        QIHMGvq7U8Sf7He4+4VFGqg=
X-Google-Smtp-Source: AHgI3IY09of71qEdGWmLQ9N0pTJcuq75/YFXp32CyRWU1WZj24MjvjzhxprXcBsoC8HhuoJWLmu0dQ==
X-Received: by 2002:a62:2e03:: with SMTP id u3mr2225821pfu.257.1550198524099;
        Thu, 14 Feb 2019 18:42:04 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id k19sm2131657pfi.126.2019.02.14.18.42.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:42:03 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:16:24 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH v4 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_map_pages()
Message-ID: <20190215024624.GA26425@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 28bc501..dd0602d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -224,8 +224,7 @@ struct drm_gem_object *
 static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 			struct vm_area_struct *vma)
 {
-	unsigned long addr = vma->vm_start;
-	int i;
+	int ret;
 
 	/*
 	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
@@ -246,18 +245,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
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
+	ret = vm_map_pages(vma, xen_obj->pages, xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to map pages into vma: %d\n", ret);
 
-		addr += PAGE_SIZE;
-	}
-	return 0;
+	return ret;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

