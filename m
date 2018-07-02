Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE262480C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpA0RgWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE262480C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeGBSZB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:25:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42462 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeGBSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:25:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so7498195pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ilBY72hYqwZbPPMSh+kWYp/Mo6fEgST0izjS0iYw2zI=;
        b=lpA0RgWYH+OuUo1OpPbwd+3WT9yS8i/Erp45aLq/QYpsnj+/EBWkxhRgfjjobU5aFz
         k2MNtHAhgDHTJhAm7to8BX1MXylO6Igd9yHj819rPmO7Ajfa2fBftpr6F9Kjs38756l9
         LweXAMBLNsb3OiGuN50IINMndAybglytt33asic0wAwZK8KgPHojRRdSGB6jo4xTn8bk
         saEl1BfoeHaUMIkvhOGZVzIJrmJettBB/iBuXJLmle2YXWsMBB0gtaumnmH+K9ndzbu+
         6toj9roL0qNo2RLMv4iW239xSkexLrwEnSLs7LslQd/gc7YsULSmbBbylORA9PTRaKZ2
         Nfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ilBY72hYqwZbPPMSh+kWYp/Mo6fEgST0izjS0iYw2zI=;
        b=UcnIW9a66Wj6mnIqIVrDQH9UBzNHIeVP+b2Se86rKZGVpK8h8U5W5UASsswEAs97XR
         /fcJr5ho7MeSa7Qi//pU0i2ciPl/HbBLG349GghNx9Xskgv9Yl+Feb/GKoR11gnLk/p+
         JMCeqjsfKjfUmhjmTJq6Gq1oM27A/L19Y6pchW68dH0du4MI58V/k3uu1WqJVwkFSQFJ
         ugPiUxjKNGqLQz4ktlhsneK1UjyoRP8Go+oaWjzPWEMG07ZsUZ0lKWBDr7fe/iqVGWGU
         mh1YwVvfHHqmLglFLq3sLqUOapEEuA3x+qeJKRi/lMOpVeumD9sb6KZYbOOW1NdTBk9Z
         XJMQ==
X-Gm-Message-State: APt69E09rEXd/hYJYodUDMRKkSwBf2s/V+4R1M8JVqxlJJUnELOLk8aZ
        ZYpKoOh809CPYCSC1E0tYkM=
X-Google-Smtp-Source: ADUXVKJwtxV8Xv8HQwwa3a2vAM0/I93W6HQnE0uitM3XVFxBLP5CzvBDs0u16e2AIRgMAN4igs/XJQ==
X-Received: by 2002:a63:b64d:: with SMTP id v13-v6mr22422556pgt.196.1530555899086;
        Mon, 02 Jul 2018 11:24:59 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id c1-v6sm2610510pgf.21.2018.07.02.11.24.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 11:24:57 -0700 (PDT)
Date:   Mon, 2 Jul 2018 23:57:28 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     airlied@linux.ie, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        ajitn.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH] gpu: drm: virito: code cleanup
Message-ID: <20180702182728.GA6015@jordon-HP-15-Notebook-PC>
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

