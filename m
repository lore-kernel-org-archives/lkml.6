Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1B8208C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJxWOT2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1B8208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGCQIO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:08:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39247 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932409AbeGCQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:08:13 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so1190275pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cscXmuOb+JzLly+J2MScdfFx0Ib6Chh3Jndyt4wx4/4=;
        b=WJxWOT2k+VNlbhE0SO2Bzf/+/TKweokwYJGmJEOyTd2aW79T4m1MZ1ATmNz1QBiCbf
         EgiwII7Avx4oS/59H9wUSldtWLx676q8fR2ps9bLqfWG89AVqE9wbvZtDxaUxZO0r32j
         Sv8Iq7SlqtSpln/AXiiG+QvpcUHevOjEmNOksB+Y4qujoE4RKXKzOgeXVvoHbnMcOkAs
         DEqqRPfElNzZ6aDveKok5pSegWycsVgRN5UyFIgQ+WS3GQ7yNDphznBEzJ8FmAWo+qUB
         g2zJMBN0FQm6oiciXXNZi3TYgL9WdezhEcFt8sCkD6lYlJswbEqfnrGYGZQvpvTV3jqM
         WxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cscXmuOb+JzLly+J2MScdfFx0Ib6Chh3Jndyt4wx4/4=;
        b=QQkJeLwWcqcHc/ALXxITzyYoYgTJ+45tv9xFJKYq7zM8qG44Y4XIlfmgQh7gPtrFhT
         LS/IUcmEWleo/zZwcjQtEoWjBCqc31BnUuTpwnqhglFfWzBtwHuRhzzgMzmssh9+yiu3
         iywCK0kIq1BtY3GrVM6Dz2AabyDaIJVdDT/Szk5ZB34wX1wSqQu4H2bPsaL/hpc1nTme
         5hzUme8BkGx3hx5s6O2DcIops+mOFrq66q/5cci/5zSMqLGHsr3Yw08c/UnBhH5+q0M8
         zyA9r0VPJRysz+qn3E3XVrYe3V6uyJEgbV/EeismODwTI2kgrK0FsUDD2pQgAupFrKXl
         cirA==
X-Gm-Message-State: APt69E1wHUCfradK8JubL1QMtDJsEi61D25rMLLWhmkmIhgR13wvqItL
        YfhrxlVvnWo3zlb7TmeH56E=
X-Google-Smtp-Source: AAOMgpeOU4XA+KAVl02eg35nNtgsm5FV6YLo0XsN9aNgOK3+G0gLgc89T0MZ+In6Gx/YCDRFwDBwcg==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr20325363pff.216.1530634093055;
        Tue, 03 Jul 2018 09:08:13 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.17])
        by smtp.gmail.com with ESMTPSA id m21-v6sm2354614pgv.27.2018.07.03.09.08.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 09:08:11 -0700 (PDT)
Date:   Tue, 3 Jul 2018 21:40:43 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, eric@anholt.net, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        svptas.linux@gmail.com, ajitn.linux@gmail.com,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: [PATCH] gpu: drm: v3d: use new return type vm_fault_t
Message-ID: <20180703161043.GA26927@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

see commit 1c8f422059ae ("mm: change return type to vm_fault_t")
for reference.

Previously vm_insert_mixed returns err which driver
mapped into VM_FAULT_* type. The new function
vmf_insert_mixed will replace this inefficiency by
returning VM_FAULT_* type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c  | 23 +++--------------------
 drivers/gpu/drm/v3d/v3d_drv.h |  3 ++-
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 7b1e2a5..f4e8de4 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -227,37 +227,20 @@ struct reservation_object *v3d_prime_res_obj(struct drm_gem_object *obj)
 	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
 }
 
-int v3d_gem_fault(struct vm_fault *vmf)
+vm_fault_t v3d_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct v3d_bo *bo = to_v3d_bo(obj);
 	unsigned long pfn;
 	pgoff_t pgoff;
-	int ret;
 
 	/* We don't use vmf->pgoff since that has the fake offset: */
 	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
 	pfn = page_to_pfn(bo->pages[pgoff]);
 
-	ret = vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
-
-	switch (ret) {
-	case -EAGAIN:
-	case 0:
-	case -ERESTARTSYS:
-	case -EINTR:
-	case -EBUSY:
-		/*
-		 * EBUSY is ok: this just means that another thread
-		 * already did the job.
-		 */
-		return VM_FAULT_NOPAGE;
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+	return vmf_insert_mixed(vma, vmf->address,
+		__pfn_to_pfn_t(pfn, PFN_DEV));
 }
 
 int v3d_mmap(struct file *filp, struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index a043ac3..09aa634 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -2,6 +2,7 @@
 /* Copyright (C) 2015-2018 Broadcom */
 
 #include <linux/reservation.h>
+#include <linux/mm_types.h>
 #include <drm/drmP.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
@@ -248,7 +249,7 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv);
 int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv);
-int v3d_gem_fault(struct vm_fault *vmf);
+vm_fault_t v3d_gem_fault(struct vm_fault *vmf);
 int v3d_mmap(struct file *filp, struct vm_area_struct *vma);
 struct reservation_object *v3d_prime_res_obj(struct drm_gem_object *obj);
 int v3d_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
-- 
1.9.1

