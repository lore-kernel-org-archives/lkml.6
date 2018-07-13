Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56653ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F80208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4gp/bvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F80208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeGMP6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:58:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40890 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729899AbeGMP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:58:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id e13-v6so9484434pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=55VIPYdmpU3WYjpptCzXvaZGLE1/NgKMXcB7ty3jIpY=;
        b=s4gp/bvZWGQL1pbsaeVkOkmpj9CWtJlAvg7nSgbGJ2SK11VFYsjjixzFC/lPMiWKvz
         pssQCvXMCHk6M5McA+V15PX34CoML3cJTOB1E0JLj7J+3QsrnGAdUar+pg0yhlMND64R
         U422zrv6VMxEbouPhS71nu9hEl8SsaLee2NFvOEzgZx57Ej0a2Ja/o41fq/qIbhxyrLx
         Kn45XkhVcAbn9CeoDFjhPLDRh+Ns0DhfRb6FELon9lbFciasPlMupoaKA4ZqPCyLUiRv
         nHGDIij0rm7ZxG7i7cnXaxi81hznEHG9gCHb52pmlDTXgPF2xA8IJPm/EEu1eWPIhSrk
         YEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=55VIPYdmpU3WYjpptCzXvaZGLE1/NgKMXcB7ty3jIpY=;
        b=tRvKHSYd+w8bl61m3IYeEaL/sqhnXedZdGDefFZs81bi6awzCPn5K7JbfSE3N/Dqix
         X3nZybi12UcplBAxRGhkIefFKnwVsUPJensFEWgmVxMKy2Wmh5ErG4VEb6mQhj65DKUx
         tBOFrrt30Gx0nG8T9n3z1+F2HaFhHZnwjdZRXmc8pYN8dkoFwidfHg+88HYrB1aD7DQl
         YiusWgLgc71nmP2dCWFE5Kst67u/WL3fJSVHkwBveAoRDOVwNBA7jcLD6UY0zwjpSGK2
         ilvM2Hn76NDmNov/eBy4KrM7KGR06fPbRy0iLkFc/7fWBlLCdMqlu7rSXLsbKXi6QmL/
         PLKw==
X-Gm-Message-State: AOUpUlGC/0quUjrIwObihkjrdQdswHBO6AQaKv3BYk98u6ch0aWcrvqb
        jhbBWl8fQvyb2E9pzHGrF/qQVA==
X-Google-Smtp-Source: AAOMgpdEAcUg6kCDrthMbM9Ss4SsUN+U2DA4V+wKeIiASiI4kZ68VrBXF6E3fRdQ7EH24M8hecdqsA==
X-Received: by 2002:a62:11c4:: with SMTP id 65-v6mr7657896pfr.54.1531496586233;
        Fri, 13 Jul 2018 08:43:06 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.217])
        by smtp.gmail.com with ESMTPSA id s27-v6sm24738487pfk.133.2018.07.13.08.43.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:43:05 -0700 (PDT)
Date:   Fri, 13 Jul 2018 21:15:41 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     patrik.r.jakobsson@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v3] gpu: drm: gma500: Change return type to vm_fault_t
Message-ID: <20180713154541.GA3345@jordon-HP-15-Notebook-PC>
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

Previously vm_insert_{pfn,mixed} returns err which driver
mapped into VM_FAULT_* type. The new function
vmf_insert_{pfn,mixed} will replace this inefficiency by
returning VM_FAULT_* type.

vmf_error() is the newly introduce inline function
in 4.17-rc6.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: updated the change log

v3: Fixed kbuild error

 drivers/gpu/drm/gma500/framebuffer.c | 14 +++++---------
 drivers/gpu/drm/gma500/gem.c         | 27 ++++++++++-----------------
 drivers/gpu/drm/gma500/psb_drv.h     |  3 ++-
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index cb0a2ae..632aadb 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -111,7 +111,7 @@ static int psbfb_pan(struct fb_var_screeninfo *var, struct fb_info *info)
         return 0;
 }
 
-static int psbfb_vm_fault(struct vm_fault *vmf)
+static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct psb_framebuffer *psbfb = vma->vm_private_data;
@@ -120,7 +120,7 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
 	int page_num;
 	int i;
 	unsigned long address;
-	int ret;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 	unsigned long pfn;
 	unsigned long phys_addr = (unsigned long)dev_priv->stolen_base +
 				  psbfb->gtt->offset;
@@ -133,18 +133,14 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
 	for (i = 0; i < page_num; i++) {
 		pfn = (phys_addr >> PAGE_SHIFT);
 
-		ret = vm_insert_mixed(vma, address,
+		ret = vmf_insert_mixed(vma, address,
 				__pfn_to_pfn_t(pfn, PFN_DEV));
-		if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
+		if (unlikely(ret & VM_FAULT_ERROR))
 			break;
-		else if (unlikely(ret != 0)) {
-			ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
-			return ret;
-		}
 		address += PAGE_SIZE;
 		phys_addr += PAGE_SIZE;
 	}
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
 static void psbfb_vm_open(struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 1312397..e7be5c9 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -134,12 +134,13 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
  *	vma->vm_private_data points to the GEM object that is backing this
  *	mapping.
  */
-int psb_gem_fault(struct vm_fault *vmf)
+vm_fault_t psb_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj;
 	struct gtt_range *r;
-	int ret;
+	int err;
+	vm_fault_t ret;
 	unsigned long pfn;
 	pgoff_t page_offset;
 	struct drm_device *dev;
@@ -158,9 +159,10 @@ int psb_gem_fault(struct vm_fault *vmf)
 	/* For now the mmap pins the object and it stays pinned. As things
 	   stand that will do us no harm */
 	if (r->mmapping == 0) {
-		ret = psb_gtt_pin(r);
-		if (ret < 0) {
-			dev_err(dev->dev, "gma500: pin failed: %d\n", ret);
+		err = psb_gtt_pin(r);
+		if (err < 0) {
+			dev_err(dev->dev, "gma500: pin failed: %d\n", err);
+			ret = vmf_error(err);
 			goto fail;
 		}
 		r->mmapping = 1;
@@ -175,18 +177,9 @@ int psb_gem_fault(struct vm_fault *vmf)
 		pfn = (dev_priv->stolen_base + r->offset) >> PAGE_SHIFT;
 	else
 		pfn = page_to_pfn(r->pages[page_offset]);
-	ret = vm_insert_pfn(vma, vmf->address, pfn);
-
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
 fail:
 	mutex_unlock(&dev_priv->mmap_mutex);
-	switch (ret) {
-	case 0:
-	case -ERESTARTSYS:
-	case -EINTR:
-		return VM_FAULT_NOPAGE;
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index e8300f5..93d2f40 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -21,6 +21,7 @@
 #define _PSB_DRV_H_
 
 #include <linux/kref.h>
+#include <linux/mm_types.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_global.h>
@@ -749,7 +750,7 @@ extern int psb_gem_get_aperture(struct drm_device *dev, void *data,
 			struct drm_file *file);
 extern int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			struct drm_mode_create_dumb *args);
-extern int psb_gem_fault(struct vm_fault *vmf);
+extern vm_fault_t psb_gem_fault(struct vm_fault *vmf);
 
 /* psb_device.c */
 extern const struct psb_ops psb_chip_ops;
-- 
1.9.1

