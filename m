Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376ADC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55F2242E5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFH02Hsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55F2242E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeGCPbv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:31:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46220 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeGCPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:31:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id q14-v6so1139792pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U5UcmPhLZVTrhjmGntLj2MrAGsTIp95syWuiee4K5kg=;
        b=tFH02HswoN9aK3HU1p76Z9QdSW2jaBM4aEeT0BAczIdse2qEcAff2d5c7Y1CsxPY0R
         PsOjlPV1cA0yi1ycypue7p0nrvu0MJC6LmT/HHjTVMp9S1La5Dx60tWK6/3mvFD2rQzT
         oL5Xa8CioAZ+ce+xVeGJg3l5ZrYLq/4Y8ENRAL49ULcIZFiSFdQkoEPgu3ZaNopS9kEq
         4ccHFoep+lWUgz186dMaoc5aRQyg4mulkyatX56YEP5kvOKxiur9DYuxo1Lfi1EqFwA4
         O0oFRxf0feg0f9tPfL1N8jKIkrAWNTPhYTiomRanmXqvvzewTGDrr3D15p4ESnxvcI5T
         mVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U5UcmPhLZVTrhjmGntLj2MrAGsTIp95syWuiee4K5kg=;
        b=OcjFdQvymwsMqiT1rz51wkDRKHGXU6NrRUq7TXN8bsBXPDJmbTRgH/HDXKqCi0HiDw
         M0cErumWLZ2W68wO4wmPH73iIojL5YA57nazENwgGFKxQ1bl5ky7EgsFDV+AuEiT0lC8
         oJOfect0W7LHvhiN1EybBktm30B1k1qGPSfSVBMCwt+BmojZClaoFqnLsrlUcJj8xFXu
         NoLdv1GPO34aFGAfsCmZo5Gks3Bz3OPwheq3nbrskZgCgo7c+6zkvNp5lBmFvn3urGUM
         rju29Bkle6p6WQA1CWprHbWsGfQrX/HYc3FMgoLqjTZex2oLME4Iy4casp5faKBMosZI
         DNmQ==
X-Gm-Message-State: APt69E19p5GHQ/4NcTvf1p9B9v6LVfudVfGdGvWm7q7CwtJuQ5PgduLL
        kXjSawcv0edtBdHcaSUHbiQ=
X-Google-Smtp-Source: ADUXVKI2jSQ8Mlpc/qGL52dTaK6Zz+FhcnQ2lSiau/M8e5ULn+ieZJNJOub3LjWRLavm6COjvgI15A==
X-Received: by 2002:a63:2c9:: with SMTP id 192-v6mr26536418pgc.354.1530631889265;
        Tue, 03 Jul 2018 08:31:29 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.17])
        by smtp.gmail.com with ESMTPSA id z19-v6sm2761850pfe.163.2018.07.03.08.31.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 08:31:27 -0700 (PDT)
Date:   Tue, 3 Jul 2018 21:03:53 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     airlied@linux.ie, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        ajitn.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH v2] gpu: drm: virtio: code cleanup
Message-ID: <20180703153353.GA3375@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fault handler code is commented since v4.2.
If there is no plan to enable the fault handler
code in future, we can remove this dead code.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: corrected subject line

 drivers/gpu/drm/virtio/virtgpu_ttm.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 11f8ae5..b6f021c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -106,29 +106,6 @@ static void virtio_gpu_ttm_global_fini(struct virtio_gpu_device *vgdev)
 	}
 }
 
-#if 0
-/*
- * Hmm, seems to not do anything useful.  Leftover debug hack?
- * Something like printing pagefaults to kernel log?
- */
-static struct vm_operations_struct virtio_gpu_ttm_vm_ops;
-static const struct vm_operations_struct *ttm_vm_ops;
-
-static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
-{
-	struct ttm_buffer_object *bo;
-	struct virtio_gpu_device *vgdev;
-	int r;
-
-	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
-	if (bo == NULL)
-		return VM_FAULT_NOPAGE;
-	vgdev = virtio_gpu_get_vgdev(bo->bdev);
-	r = ttm_vm_ops->fault(vmf);
-	return r;
-}
-#endif
-
 int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file_priv;
@@ -143,19 +120,8 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 	r = ttm_bo_mmap(filp, vma, &vgdev->mman.bdev);
-#if 0
-	if (unlikely(r != 0))
-		return r;
-	if (unlikely(ttm_vm_ops == NULL)) {
-		ttm_vm_ops = vma->vm_ops;
-		virtio_gpu_ttm_vm_ops = *ttm_vm_ops;
-		virtio_gpu_ttm_vm_ops.fault = &virtio_gpu_ttm_fault;
-	}
-	vma->vm_ops = &virtio_gpu_ttm_vm_ops;
-	return 0;
-#else
+
 	return r;
-#endif
 }
 
 static int virtio_gpu_invalidate_caches(struct ttm_bo_device *bdev,
-- 
1.9.1

