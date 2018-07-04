Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0309A208B4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDMq6KWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0309A208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeGDQBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:01:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40087 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeGDQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:01:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so2975876pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SSSL9/+heVl/Lt4SV+URN0/ppkB7hEKNkyXNsp2mfaU=;
        b=HDMq6KWMT0mjEtxtNy+3Xrr7UFNkBXTJDQiAdB9uFqC8NjMcsPOFl5K8k8+gqzMIqv
         wIfphsgFH82Akf3LjnZGmJ5dxvgdRSsfl77/LB082WwUISjDHudx/7I1nt/4D25wSort
         H0mv37GcnEn2i65qaJTeB9pBSL1cBn1Ei+KadnMIQc0pVyu7al5A8AMfjFLgMd8XiagD
         YUKuWlUHaOBvj7cVKQSffro5dfYlwxxgSVt4KsxrFJtwH8rGlQWk5ALMBdb0uSCi3d3a
         8L6G42hVPYRy7KEsiPuaEC0lxsFV+USaOAq+rXmAyvisqnb5V06CgKMkL48gKFh8vqlh
         racA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SSSL9/+heVl/Lt4SV+URN0/ppkB7hEKNkyXNsp2mfaU=;
        b=lI7fR3Pip0iwkM+7xE+hfDi9BVxkmi7XEs6JIX2pw9SL/GegD/Puo3l+mV4xvW+Oz5
         GfWLpBJvns+kLzrLS16GkWgb+wM+leEYkm5S7BFC0iNvzecvyjBuxM7ldCAqUCJoI5Pq
         xKd5gRnGCJ3vY5fEzsTSSniJuvgyTt+/d8rlFFnEcggGwwoV3+egJCEA6gYIpA0Ehcfz
         R1K3J+rv4KVu427QlvwKE2kwJXMRpTxRDbltYJo+LrSiiEhh8phiPuAlLEKm57FcCfJB
         g7I1as3vu4j670vpZgeEO4FZtCuKAZSCOjweLdGYz87d5o+y2uHccVXqTRKIQB6iSX1V
         8SvA==
X-Gm-Message-State: APt69E1RCaNmqHV69ESPgMiyh0VIgRlvrxbRMb1zRhadDBC91i+MSKaO
        bao4wnSsjHoQiWmQ5AvuGJE=
X-Google-Smtp-Source: AAOMgpeL1hHyCgEZX12cMCst7EKRlZLgRHbxR1gK80Ix+RAcHuOOhOiV2w3rLfG3978fwopqjvLe/Q==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr2459529plp.212.1530716005687;
        Wed, 04 Jul 2018 07:53:25 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.94])
        by smtp.gmail.com with ESMTPSA id z123-v6sm6514752pfz.16.2018.07.04.07.53.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 07:53:24 -0700 (PDT)
Date:   Wed, 4 Jul 2018 20:25:57 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, eric@anholt.net, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        svptas.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com, ajitn.linux@gmail.com
Subject: [PATCH v2] gpu: drm: v3d: use new return type vm_fault_t
Message-ID: <20180704145556.GA11036@jordon-HP-15-Notebook-PC>
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
v2: Address Matthew's comment.
    Updated the changelog

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

