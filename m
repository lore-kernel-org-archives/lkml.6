Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B1221AA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDeR/U6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B1221AA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeGDOqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:46:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42665 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeGDOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:46:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id v9-v6so2775692pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bkWNnikjJbT3e+mfRlBMeXMcIA9OKGXVhJxht0n13G0=;
        b=UDeR/U6ZKyozely3gbEifmgnaAsOtPFPx5JdER9WMg1KNt05ai+28BqwJ7J/CyEOPA
         hbug5U9ChLlUyKMN6SzvQN/qq2CZ8jsRuE0SWsl3i5Si/eBSDn5lMNof9Z6AvM1xQ4Ft
         gZmo7SnlxB9FiqAjPE/ZO/XbckKvh7PYMG16wzNEucN2ytbWKwFvGyOX+kRb6RL1UPVO
         2IEY0tgEnbY1AwK6XdX3VpBcUDxDsIFGFhsSHt6TLfaep2yhoR837YdNT9357unH7dnP
         LxiOI27vIKHE3zLhaWlg+D2Q1IJ6ImfeIZhCbEAd4XOg1u0FmCXcP6pGvKks63MfPmgI
         LRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bkWNnikjJbT3e+mfRlBMeXMcIA9OKGXVhJxht0n13G0=;
        b=VO8fhTB1uigKGkw/e8Jl0xnpyWlU6MDAf83+Mg7JFr7wuO+9+HpBmbhp6dbXgZmLP+
         +UifFa1ugFubssb3OC33C+q9JMbEmAVWGHwsKp2UvwaPqGtoekz8LHRlrFuy8pAZdkpG
         9gx1DDngWanHPqfXJp2ljoohBy5XYu7roEtrbkKY9Z+ghvE3hEXbYNcJEeCTWJLH9B6g
         bflFV+oi22irxVbNrIhW/yBqDLaptESVLECklFXebHfAFc3upHJ70CkhUcFZIQeEGKm1
         98/ZS1rYXnbz1hvwJhyGJoyqJhpQOL6e94JY06DvIFL7dGOleSDooxsEuc8b2k5W4R+a
         dKjQ==
X-Gm-Message-State: APt69E1/9n44Z+vAHXodNzb92W28KzDBzI4dB/WMYti35t0/7mXBy6Z8
        9rf+/4KywbkM0A4tZtrw0BWP6A==
X-Google-Smtp-Source: AAOMgpelArj+A09xXSBu4cXDzsJ1YLn8lCH5NZMx09qhiYVkGQC/sBaOsfy6larf2nBIIkLC6C2QLw==
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr2259428pgo.208.1530715581032;
        Wed, 04 Jul 2018 07:46:21 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.94])
        by smtp.gmail.com with ESMTPSA id g10-v6sm7090847pfi.148.2018.07.04.07.46.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 07:46:18 -0700 (PDT)
Date:   Wed, 4 Jul 2018 20:18:50 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, eric@anholt.net, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        svptas.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com, ajitn.linux@gmail.com
Subject: [PATCH v2] gpu: drm: v3d: use new return type vm_fault_t
Message-ID: <20180704144850.GA10995@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert v3d_gem_fault to return vm_fault_t

Instead of converting an errno into a vm_fault_t ourselves, use
vmf_insert_mixed() which returns a vm_fault_t directly.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c  | 28 +++++-----------------------
 drivers/gpu/drm/v3d/v3d_drv.h |  3 ++-
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 7b1e2a5..54d9651 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -227,37 +227,19 @@ struct reservation_object *v3d_prime_res_obj(struct drm_gem_object *obj)
 	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
 }
 
-int v3d_gem_fault(struct vm_fault *vmf)
+vm_fault_t v3d_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct v3d_bo *bo = to_v3d_bo(obj);
-	unsigned long pfn;
+	pfn_t pfn;
 	pgoff_t pgoff;
-	int ret;
 
 	/* We don't use vmf->pgoff since that has the fake offset: */
 	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
-	pfn = page_to_pfn(bo->pages[pgoff]);
-
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
+	pfn = __pfn_to_pfn_t(page_to_pfn(bo->pages[pgoff]), PFN_DEV);
+
+	return vmf_insert_mixed(vma, vmf->address, pfn);
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

