Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BA8C8C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539302087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLLOLau0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539302087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFKU0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:26:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46499 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbeFKU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:26:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so12947605pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iOLAyXVzVEBwHpVaU07ngUTW4bb1q7/NM+eC7rRtpRM=;
        b=WLLOLau0V7plUyo/HvHcrWNFmZ1Rn0KFG2xX8VBijXFXn+DW1XcurwypOYRNDHqs8G
         XyyGZ4G/IdD/T/BaSWeG7PDd+7QAY+lg/1n1lg7MwAcT5wx69G65r2UDR10qKNstWJrJ
         utgWqkHyhbVbqzUpxHOEb3CxPgIU/ayILnHze8Vf5DW1Qp/v9YwVusvpQME1ajeuJNZ0
         ghQ0tNC9sHlnGuYnEMFQkFE8291Y2Bf1YVl+6t2PRH+ZvpxTmSxfxCGyJMgd9yR9fh/H
         IdXkddcZhsrsEA15XVU48S1cN1pkOsvI74JELMX6Q/QbHRANDHFfN15cdhPZ+bpT9u/Y
         R+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iOLAyXVzVEBwHpVaU07ngUTW4bb1q7/NM+eC7rRtpRM=;
        b=GNmbkBUzIWylJ1Yzj2G8CzuQHlrjZGILnilkgpxoaiMCDLvQpvRSEzaSe0hWjOeAhr
         hgUJQeqjgJhWGf10oaMer3108iCRHS8Tr2+3BXTPHWKujJVIL4gE2cZTcw+4EMjZ+V1U
         trvEFuREUY/QO94M3OTKvQsmRg7jdWgVowbZ755YhzVIFxBuMN5b1wzlzsHxYjNhT0BO
         nSp0NmwbuYsxu0OzOFJsG1Xx1XyEJfdH/kNm5MGmScGMjoG4pKqDnV50bKKOAsrm9Li3
         sGHlIHaQQcQz43PVDrmqivtuJwLFrfLOIZmrYkP4kGZwQeCqyNlq2dgrnWt4wxygefOU
         TUjA==
X-Gm-Message-State: APt69E1GL287epg/5H4BQg2ltHwItLKuc8z2so+W4zP0fP05OnvE7EXx
        uG4g5kQAvqKk1I3GAk6u9c8=
X-Google-Smtp-Source: ADUXVKJvdL2sf7xpiq1KF2hyhiKSVCL5HoGRERGc5PxVy0qw3iSSEwpwuwG81h0y7fXF5LRbF3pCbQ==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21-v6mr668134plr.73.1528748801053;
        Mon, 11 Jun 2018 13:26:41 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.65])
        by smtp.gmail.com with ESMTPSA id u84-v6sm77939849pfg.156.2018.06.11.13.26.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 13:26:39 -0700 (PDT)
Date:   Tue, 12 Jun 2018 01:59:04 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, fbarrat@linux.vnet.ibm.com,
        andrew.donnellan@au1.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com
Subject: [PATCH] misc: ocxl: Change return type for fault handler
Message-ID: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
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

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

There is an existing bug when vm_insert_pfn() can return
ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
default. The new inline vmf_insert_pfn() has removed
this inefficiency by returning correct vm_fault_ type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/misc/ocxl/context.c | 22 +++++++++++-----------
 drivers/misc/ocxl/sysfs.c   |  5 ++---
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 909e880..98daf91 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -83,7 +83,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
 	return rc;
 }
 
-static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
+static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
 		u64 offset, struct ocxl_context *ctx)
 {
 	u64 trigger_addr;
@@ -92,15 +92,15 @@ static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
 	if (!trigger_addr)
 		return VM_FAULT_SIGBUS;
 
-	vm_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
 }
 
-static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
+static vm_fault_t map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
 		u64 offset, struct ocxl_context *ctx)
 {
 	u64 pp_mmio_addr;
 	int pasid_off;
+	vm_fault_t ret;
 
 	if (offset >= ctx->afu->config.pp_mmio_stride)
 		return VM_FAULT_SIGBUS;
@@ -118,27 +118,27 @@ static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
 		pasid_off * ctx->afu->config.pp_mmio_stride +
 		offset;
 
-	vm_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
+	ret = vmf_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
 	mutex_unlock(&ctx->status_mutex);
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
-static int ocxl_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ocxl_context *ctx = vma->vm_file->private_data;
 	u64 offset;
-	int rc;
+	vm_fault_t ret;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
 	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
 		ctx->pasid, vmf->address, offset);
 
 	if (offset < ctx->afu->irq_base_offset)
-		rc = map_pp_mmio(vma, vmf->address, offset, ctx);
+		ret = map_pp_mmio(vma, vmf->address, offset, ctx);
 	else
-		rc = map_afu_irq(vma, vmf->address, offset, ctx);
-	return rc;
+		ret = map_afu_irq(vma, vmf->address, offset, ctx);
+	return ret;
 }
 
 static const struct vm_operations_struct ocxl_vmops = {
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index d9753a1..0ab1fd1 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -64,7 +64,7 @@ static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static int global_mmio_fault(struct vm_fault *vmf)
+static vm_fault_t global_mmio_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ocxl_afu *afu = vma->vm_private_data;
@@ -75,8 +75,7 @@ static int global_mmio_fault(struct vm_fault *vmf)
 
 	offset = vmf->pgoff;
 	offset += (afu->global_mmio_start >> PAGE_SHIFT);
-	vm_insert_pfn(vma, vmf->address, offset);
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address, offset);
 }
 
 static const struct vm_operations_struct global_mmio_vmops = {
-- 
1.9.1

