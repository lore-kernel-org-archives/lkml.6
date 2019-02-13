Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9779BC4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62822222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3NB43+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbfBMOBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:01:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34680 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfBMOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:01:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so1219084plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=a3NB43+TY8+WgWQevWmth0jDcxyBS/n2gAoDY2YZP49uixFVqF9mvLnqWGduB6Va/H
         feQh5HfmgXevrSsUjZhdngnb/naX2abIqktrI2KmmPQ8oNpgax5etRPOVTOOFtAOb1YG
         zhhHS9mNeuWvPEeHM5vcn+7gTBoWwJ0R+XoaM8QBfMA+CTM2NXjJVl6JImLxquz6l9Fl
         BtCPxnokINBzCCKtI+vM8SJ03eMGBK4CKngpr1xjCKL7zP2xXkcut5n3iNwAMAKrAb7P
         epNaoBisfUaCTj5Cg8+sPkYrY82yZ+MPAE/klZurmQjZ9YF6Q78A1sMJks+f4FhOgCiO
         J+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=PM30rG9TmZN4ydx/iElO0Cj3TX12p4wVfI4w3bSimzv8/cNHZVCJJImX2SNf4LC964
         tbMoLMKmnLq1d7Vzz+ErpAdbpu1I1Km0m0cYFjrSLL3n6lgyuzEcA9KQ4qm2qpsAqsQD
         eGbS+9fJnpHy1FXuROtVX9PkNgyxQDtEj0nflVZ9jcnO9Gvu1lSWlS/bum69vVSIXbXX
         CCZ8JLnlBIAK4XWqgkOs119LZ+tHc32MfAA647p76sFpkrrat09d7vRiF8thqa7bd8Nz
         lUk8lv3WLglrkgQhj8XTT+lLFzFwvckIQYuQXFwQlQR6pPJj8S+aliKbcYv58I+AmHY+
         jCgQ==
X-Gm-Message-State: AHQUAuZlwsRA5nCgwALm6fdKWxIEMjCLVyNNrlTX8xU0mnHj0YvhIQqL
        04JW/mYeUrbhtQBLLYpLpH0=
X-Google-Smtp-Source: AHgI3Ibm0TTd/gAqweslKR095bYfBxZMG3ZrVdI1TDAsasHXYl9RczcsJBx08hZyBa/705vkTwMYUg==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr650376pld.337.1550066462186;
        Wed, 13 Feb 2019 06:01:02 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id w65sm18734568pfb.23.2019.02.13.06.01.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 06:01:01 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:35:20 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCH v3 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_map_pages()
Message-ID: <20190213140520.GA22029@jordon-HP-15-Notebook-PC>
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

