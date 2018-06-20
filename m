Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19DC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6011920846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFlknzjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6011920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeFTSWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:22:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34495 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeFTSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:22:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so214355pfl.1;
        Wed, 20 Jun 2018 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HW2B9i0M1zf103eTZ7ZXfMb8e2cjJZpN97WJSeyIa3w=;
        b=QFlknzjzInMc9UuveaF0PlPZNku/1et4eVeFjYkWGlluYWKA4J0/a0AONrb7gphCaP
         cvOMLQsJLKE1OhU4XHDQald0Jw9yXouVCQ+gPnvNEPcsVZIQF27+Gwv4dnQj6WJ1pCEi
         2bBI4qPlioyfszQHjxrGtKUDGIA+vitwkWTtuf2pOnqkS5zu47jwddAPIoXOmja0rH9g
         85ApiJqxTFBEAA3E2Qp1D/Id6+QQpxl5DN/IGAJe8b2IuGZS8XqQ36QIcvS12++EW+WW
         wIWjbBagdtBDpwVP/SVQf0+j/5qcaz+cfyQPtss24us5+5rOcCd5+AdjFU+FBSgMIWH1
         R41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HW2B9i0M1zf103eTZ7ZXfMb8e2cjJZpN97WJSeyIa3w=;
        b=tt+esj2QzxlRPILSQ6T/QNPQLqo7+QHYQmlXrwSGPyHWWfTYlqwyyzcziWzTJPl1Iv
         SVKAqc/mYj3TceHeiD36YrLYbfnBUKu9vaFUOGwcevtRME3KffJJ4OGrmuNEZLWvyScK
         yH3npZAgkewFXqsXO/tev9FZcRp64BYGteey8gnpzR8TZ6bm+AVFC7j1LAb3UWpqa6aX
         WDcoQXnlaUnbXHIxB9FvXspZH04vQU3Fs1EmijINS1iF97oPKYzAt6/8xEhNggzxnLUy
         Vb3YZ7iVbdBp4V/Dl1LNPgunt599nMN6Yvt1QYLzy2yBHw10n//QM9RqDMBC++yOkyot
         6hyw==
X-Gm-Message-State: APt69E3q/+VkclUU3l5nDSw6HLcagFMDyDQh/4ALyA0TO4rWl9pFhOwW
        virfPU8EPFDxESBY64XFW4kYHA==
X-Google-Smtp-Source: ADUXVKIxBp+3jY++c+Yt+/yoRcMlBlbvv5yYQml37RtVLDLGi01M+YPOuyJRsq8x1/tnLQtQCWKHtg==
X-Received: by 2002:a65:450c:: with SMTP id n12-v6mr19899350pgq.242.1529518964716;
        Wed, 20 Jun 2018 11:22:44 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.226])
        by smtp.gmail.com with ESMTPSA id r74-v6sm6184159pfi.174.2018.06.20.11.22.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 11:22:43 -0700 (PDT)
Date:   Wed, 20 Jun 2018 23:55:07 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, manoj@linux.vnet.ibm.com,
        mrochs@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: cxlflash: Change return type for fault handler
Message-ID: <20180620182507.GA21775@jordon-HP-15-Notebook-PC>
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

Previously, VM_FAULT_NOPAGE was returned without verifying
return value of vm_insert_pfn. The new inline vmf_insert_pfn()
will address this issue by returning correct VM_FAULT_* type
from fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---

v2: Updated the change log and ocxlflash_mmap_fault()
    return type is changed to vm_fault_t

 drivers/scsi/cxlflash/ocxl_hw.c   | 5 ++---
 drivers/scsi/cxlflash/superpipe.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 0a95b5f..91178ff 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1158,7 +1158,7 @@ static int afu_release(struct inode *inode, struct file *file)
  *
  * Return: 0 on success, -errno on failure
  */
-static int ocxlflash_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t ocxlflash_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ocxlflash_context *ctx = vma->vm_file->private_data;
@@ -1181,8 +1181,7 @@ static int ocxlflash_mmap_fault(struct vm_fault *vmf)
 	mmio_area = ctx->psn_phys;
 	mmio_area += offset;
 
-	vm_insert_pfn(vma, vmf->address, mmio_area >> PAGE_SHIFT);
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address, mmio_area >> PAGE_SHIFT);
 }
 
 static const struct vm_operations_struct ocxlflash_vmops = {
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index e489d89..eee193e 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1108,7 +1108,7 @@ static struct page *get_err_page(struct cxlflash_cfg *cfg)
  *
  * Return: 0 on success, VM_FAULT_SIGBUS on failure
  */
-static int cxlflash_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t cxlflash_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
@@ -1119,7 +1119,7 @@ static int cxlflash_mmap_fault(struct vm_fault *vmf)
 	struct ctx_info *ctxi = NULL;
 	struct page *err_page = NULL;
 	enum ctx_ctrl ctrl = CTX_CTRL_ERR_FALLBACK | CTX_CTRL_FILE;
-	int rc = 0;
+	vm_fault_t rc = 0;
 	int ctxid;
 
 	ctxid = cfg->ops->process_element(ctx);
@@ -1159,7 +1159,7 @@ static int cxlflash_mmap_fault(struct vm_fault *vmf)
 out:
 	if (likely(ctxi))
 		put_context(ctxi);
-	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
+	dev_dbg(dev, "%s: returning rc=%x\n", __func__, rc);
 	return rc;
 
 err:
-- 
1.9.1

