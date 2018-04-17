Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeDQNgx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:36:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42844 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbeDQNgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:36:52 -0400
X-Google-Smtp-Source: AIpwx4/CpHit+vOsutUbZ9iPFnc07yfvTqkDBlzvJgv5XZP8wuzHQR1ju23T5h3A86RglMtQ8D3lBw==
Date: Tue, 17 Apr 2018 19:08:44 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie
Cc: virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] gpu: drm: qxl: Adding new typedef vm_fault_t
Message-ID: <20180417133844.GA30256@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Reference id -> 1c8f422059ae ("mm: change return type to
vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 59cd74c..0b482b1 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -105,16 +105,16 @@ static void qxl_ttm_global_fini(struct qxl_device *qdev)
 static struct vm_operations_struct qxl_ttm_vm_ops;
 static const struct vm_operations_struct *ttm_vm_ops;
 
-static int qxl_ttm_fault(struct vm_fault *vmf)
+static vm_fault_t qxl_ttm_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo;
-	int r;
+	vm_fault_t ret;
 
 	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
 	if (bo == NULL)
 		return VM_FAULT_NOPAGE;
-	r = ttm_vm_ops->fault(vmf);
-	return r;
+	ret = ttm_vm_ops->fault(vmf);
+	return ret;
 }
 
 int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1
