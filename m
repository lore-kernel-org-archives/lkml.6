Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45208C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81ED20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDhcul1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81ED20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeH2T3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:29:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44107 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2T3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:29:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so2473157pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i5dYOjhNG2gndHKxV80oE9viUYgIRkmhBFBmqtZPAJg=;
        b=HDhcul1RbwbyJbhynWAT3OdcinA3cb31SmG/ImOugmzK/Zh/MYVOdOHDKgQjPe2mo3
         3oFr3AsMRZTA0xLEHnkZPl8/58HE0LANxb5nRWMnBvwu6VB0G0zl7dfMLJl6bPT+EtKW
         +cceivbowM6zxk4v2E3c6E2N/Iq2WXNgVczfcoA4OI6Gv+pm0atD6RLlytEGu3Hl6i8V
         bcHzxsEFxJ2Iye/k+Mpy+nSkmnhWm1wY4MjqOFNNCpC2sFDyTqN7d53onSmfJ1vYvqIp
         Yw5vBr2mLSPG31mJSTWpmAJ8ROt559XYXZs6hDhKy6hk2G4cklTGQ6hoyHEEZlJUWFTx
         pW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i5dYOjhNG2gndHKxV80oE9viUYgIRkmhBFBmqtZPAJg=;
        b=QXSnziMMoCLA6ITpikBbFJXvcQVNI+5Km0erRLCD+OLEye5zSGZu/PsQQo2ZC/YsBN
         ZtgymgbZaFb6mP0BprLOssmXJ4D9+Soonq09/A5jg33IZ52DSQpPbikKgqqujxGAzjXq
         yFJXBD9TiWWR0kh/5ouKQX1U8NudMndYEGwcTK0jtNmpZjHl5FfZd5k/Vh9WSEfyoU/8
         ZPmZ/JYehEdylkuehClJPIR5CzPhsWp22UxAqqQ2wQMmd48CDAsBIVHXAQPCBXeH+zXp
         QytjoDewTrE3syzORO+8Y4iEY9SYRMpq2H/8Ok19oWVCLobtmdltxIpPBhNflnzAXAxr
         9U2Q==
X-Gm-Message-State: APzg51AFj/QM7OuxL0ssGtFMGdE3NYeIOHvaAIKlPg2jGnAsYtzS6xK2
        ry5+nG33/OZZa+DvaStbEfaixkaB
X-Google-Smtp-Source: ANB0VdY5bI4TQ2D1HTxUckkbR5wNueSPuHI62pXDImCdZW061GcfsgD8mgWUPc0rOqaDfM+ZT5xPjw==
X-Received: by 2002:a63:e056:: with SMTP id n22-v6mr6081050pgj.205.1535556702232;
        Wed, 29 Aug 2018 08:31:42 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([117.219.202.211])
        by smtp.gmail.com with ESMTPSA id f19-v6sm6828581pfd.147.2018.08.29.08.31.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 08:31:40 -0700 (PDT)
Date:   Wed, 29 Aug 2018 21:04:40 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v2] gpu: drm: virtio: code cleanup
Message-ID: <20180829153440.GA30850@jordon-HP-15-Notebook-PC>
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
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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

