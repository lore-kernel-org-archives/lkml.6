Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412CBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC7F20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY1+Dmfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC7F20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbeGWSDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:03:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33577 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGWSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so820113pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wQ9apzApLJXSVclvpZtPTOcvoyoiwV8cVR1HtUHcYUc=;
        b=FY1+DmfxBQ0KftX6FxyNmADP2Vggv7zVMhEJPr2FzV0pMv65Htu37fWoEa7l53/8xG
         q6hUorxLl7012k47JmAWRx5PTlM+LVbkIcomHRMR2bNb+8rnSfjfwvTO/yn68wRC3jtf
         r7u151UvafvObZwGbBfzB3l+LMY/+XWrQs91gRrqkLJa/JrJy+gBSl1wouranAiiJq3W
         bFn8Lv7vDmZN3W3Y2f+K190OEgsD6VD9cUCKmJoOby9PUxVY/KIiy8ki6mZFM7k+b00Y
         x9IUKA9r5ntv31cjrRWbJ4CUNmp14smKHYaf9qsBmyhNKA25+qAJzWmSD5Vf3vESI/mq
         PziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wQ9apzApLJXSVclvpZtPTOcvoyoiwV8cVR1HtUHcYUc=;
        b=W6gJn8/kjWJJXWUujBJ6FNItrYWh48KAbsXXFdXn3hxrv7/vU7uA9jsxxYoP3rdEjs
         o3i7kDxjP/p2zxJRAhNfznM2Y8rOtoz8M3K7tGI3l+veRFFoUcmA8ZTanQ26Is4t/+Np
         DJXHjb1tFRvi37qIF/Vi+98ivVLTFtttWVOzFhhKN6lRc7mopib8CzBAuCni+mAr/g6d
         PVE8G1cuuOl4r1ZcfRz9yvQboR2DJitvKHs68WKweyVITroKDIxfM2TaBGfL2eIb8VAC
         gJYSi2J5LB50zm5yOocR8f0d7pIv4qHp+8Gcw6iEBdaiuwrN7GBfB5O2lDJ9ysNoI/kL
         XSXQ==
X-Gm-Message-State: AOUpUlEzT1LRcx4fIJPHjoIRj46iieoHAJvzTH07U++MStTHpt9VDRHN
        mK/ZcSs86zViLfMjQ1BG15G0genu
X-Google-Smtp-Source: AAOMgpeMXaxyR9pUKSSQ8LkuCY+t0ZUVTE1wHCtUii4oFaITUU1Ga08eIaQ53xrk9VPfOWW1fONJhg==
X-Received: by 2002:a63:5866:: with SMTP id i38-v6mr13028332pgm.63.1532365298178;
        Mon, 23 Jul 2018 10:01:38 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.226])
        by smtp.gmail.com with ESMTPSA id z20-v6sm19981237pfd.99.2018.07.23.10.01.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 10:01:36 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:34:18 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, airlied@linux.ie, daniel.vetter@ffwll.ch,
        rodrigosiqueiramelo@gmail.com, gustavo.padovan@collabora.com,
        hamohammed.sa@gmail.com, jrdr.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm/vkms: Use new return type vm_fault_t
Message-ID: <20180723170418.GA6417@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
 drivers/gpu/drm/vkms/vkms_gem.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 07be29f..d5d04a8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -65,7 +65,7 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 				       u32 *handle,
 				       u64 size);
 
-int vkms_gem_fault(struct vm_fault *vmf);
+vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
 
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 		     struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index c7e3836..62e05dc 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -43,14 +43,14 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
 	kfree(gem);
 }
 
-int vkms_gem_fault(struct vm_fault *vmf)
+vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vkms_gem_object *obj = vma->vm_private_data;
 	unsigned long vaddr = vmf->address;
 	pgoff_t page_offset;
 	loff_t num_pages;
-	int ret;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
 	num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
@@ -58,7 +58,6 @@ int vkms_gem_fault(struct vm_fault *vmf)
 	if (page_offset > num_pages)
 		return VM_FAULT_SIGBUS;
 
-	ret = -ENOENT;
 	mutex_lock(&obj->pages_lock);
 	if (obj->pages) {
 		get_page(obj->pages[page_offset]);
-- 
1.9.1

