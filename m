Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF34C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B86120644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkzgHeJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B86120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJDBpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:45:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34772 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeJDBpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:45:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so3901110plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=s5NPvJ4Hi1iMK1Gbvo3nK97G7mxYdJpVsql62D/N3rE=;
        b=YkzgHeJ5eSLEt/WvHWEPRtV0ZVXV8m4eHG09PCG8SCJHGiKWNdvZ8lM2jqTDpoxXSU
         AhwFbSzwLzyd2y8IUTXmN38BlsIb1iLEj1hDkwLzAA6+0n5EeO8YAx+djVyKbiy7MD+u
         DY5MaUSgODIRoN+kynCJYGumRla/3ijPQwGr/fbskeSGto0XWrWVr+BMrXEsxZeazBZc
         u4mBtuFNTFYCBKOgXwu0EJrNyY3DqlyXjXWodSsq3tOxrJYwaFp1B2KVZE6mR352rDJJ
         DrINthXW5+Ft4Q7ymdIhCksCizhehUK0FmkHVPrnzyxwn39Zlp0q9sx3/7cEB5c14L/r
         fBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s5NPvJ4Hi1iMK1Gbvo3nK97G7mxYdJpVsql62D/N3rE=;
        b=iGChKdekTibHMGVyey9qEyhd0o1RSL6MUO7U9a1zk6C7pxZ7VfT5EJvPtKqORqNiLW
         GTIja0Jph6nXvz622q1vwqghMp+Y1Ghs6L8pAjdULmpkTAy3I1VIiLhIU16eddtlFr5q
         jIJXTbQWYUeSNbyJDc4wJV/Nt/ydIUFtGMWFnBRQ2igjXR1DpyIQGsWq+MmWW2Mou+sj
         KXtX593zUeoJ1q2cDpmDZG39RSLYbzwVw2DFOEJkDIwVlU58leJz+d5vdcfJXLyyJqBi
         GUwizklV8QYAMoFQj0Nmb8WA72PIuVoCEuaXOLB9vR2pF3Ep2zmQx/faDZTAbEfR6tI0
         HVaA==
X-Gm-Message-State: ABuFfoheQkFyRkrcuj/oiRBTO+8YmW6ZnrVQ3NL/+o+VY/9UwWaUqDzq
        QRp7JiBlDNsGKnUQlHMuPmU=
X-Google-Smtp-Source: ACcGV60cmgpdvdvjntzCoQtGHcMyv7zUwMsshrCNzIyIjblSfm3oCV5ICY3gSvIzuxofzYuZ0hAgdg==
X-Received: by 2002:a17:902:708a:: with SMTP id z10-v6mr3083155plk.330.1538592937469;
        Wed, 03 Oct 2018 11:55:37 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.142])
        by smtp.gmail.com with ESMTPSA id l2-v6sm2480592pgp.20.2018.10.03.11.55.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 11:55:35 -0700 (PDT)
Date:   Thu, 4 Oct 2018 00:28:54 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, linux@armlinux.org.uk,
        miguel.ojeda.sandonis@gmail.com, robin@protonic.nl,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de,
        airlied@linux.ie, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, m.szyprowski@samsung.com,
        keescook@chromium.org, treding@nvidia.com, mhocko@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        mark.rutland@arm.com, aryabinin@virtuozzo.com, dvyukov@google.com,
        kstewart@linuxfoundation.org, tchibo@google.com, riel@redhat.com,
        minchan@kernel.org, peterz@infradead.org, ying.huang@intel.com,
        ak@linux.intel.com, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, arnd@arndb.de, cpandya@codeaurora.org,
        hannes@cmpxchg.org, joe@perches.com, mcgrof@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_insert_kmem_page is similar to vm_insert_page and will
be used by drivers to map kernel (kmalloc/vmalloc/pages)
allocated memory to user vma.

Going forward, the plan is to restrict future drivers not
to use vm_insert_page ( *it will generate new errno to
VM_FAULT_CODE mapping code for new drivers which were already
cleaned up for existing drivers*) in #PF (page fault handler)
context but to make use of vmf_insert_page which returns
VMF_FAULT_CODE and that is not possible until both vm_insert_page
and vmf_insert_page API exists.

But there are some consumers of vm_insert_page which use it
outside #PF context. straight forward conversion of vm_insert_page
to vmf_insert_page won't work there as those function calls expects
errno not vm_fault_t in return.

These are the approaches which could have been taken to handle
this scenario -

*  Replace vm_insert_page with vmf_insert_page and then write few
   extra lines of code to convert VM_FAULT_CODE to errno which
   makes driver users more complex ( also the reverse mapping errno to
   VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
   not preferred to introduce anything similar again)

*  Maintain both vm_insert_page and vmf_insert_page and use it in
   respective places. But it won't gurantee that vm_insert_page will
   never be used in #PF context.

*  Introduce a similar API like vm_insert_page, convert all non #PF
   consumer to use it and finally remove vm_insert_page by converting
   it to vmf_insert_page.

And the 3rd approach was taken by introducing vm_insert_kmem_page().

In short, vmf_insert_page will be used in page fault handlers
context and vm_insert_kmem_page will be used to map kernel
memory to user vma outside page fault handlers context.

Few drivers are converted to use vm_insert_kmem_page(). This will
allow both to review the api and that it serves it purpose. other
consumers of vm_insert_page (*used in non #PF context*) will be
replaced by vm_insert_kmem_page, but in separate patches.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Few non #PF consumers of vm_insert_page are converted
    to use vm_insert_kmem_page in patch v2.

    Updated the change log.
    
 arch/arm/mm/dma-mapping.c                   |  2 +-
 drivers/auxdisplay/cfag12864bfb.c           |  2 +-
 drivers/auxdisplay/ht16k33.c                |  2 +-
 drivers/firewire/core-iso.c                 |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
 include/linux/mm.h                          |  2 +
 kernel/kcov.c                               |  4 +-
 mm/memory.c                                 | 69 +++++++++++++++++++++++++++++
 mm/nommu.c                                  |  7 +++
 mm/vmalloc.c                                |  2 +-
 10 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6656647..58d7971 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1598,7 +1598,7 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 	pages += off;
 
 	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
+		int ret = vm_insert_kmem_page(vma, uaddr, *pages++);
 		if (ret) {
 			pr_err("Remapping memory failed: %d\n", ret);
 			return ret;
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 40c8a55..82fd627 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -52,7 +52,7 @@
 
 static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	return vm_insert_page(vma, vma->vm_start,
+	return vm_insert_kmem_page(vma, vma->vm_start,
 		virt_to_page(cfag12864b_buffer));
 }
 
diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a43276c..64de30b 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -224,7 +224,7 @@ static int ht16k33_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct ht16k33_priv *priv = info->par;
 
-	return vm_insert_page(vma, vma->vm_start,
+	return vm_insert_kmem_page(vma, vma->vm_start,
 			      virt_to_page(priv->fbdev.buffer));
 }
 
diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 051327a..5f1548d 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -112,7 +112,7 @@ int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 
 	uaddr = vma->vm_start;
 	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
+		err = vm_insert_kmem_page(vma, uaddr, buffer->pages[i]);
 		if (err)
 			return err;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..57eb7af 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -234,7 +234,7 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 		return -ENXIO;
 
 	for (i = offset; i < end; i++) {
-		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
+		ret = vm_insert_kmem_page(vma, uaddr, rk_obj->pages[i]);
 		if (ret)
 			return ret;
 		uaddr += PAGE_SIZE;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8..5f42d35 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2477,6 +2477,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
+int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
+				struct page *page);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3ebd09e..2afaeb4 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -293,8 +293,8 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 		spin_unlock(&kcov->lock);
 		for (off = 0; off < size; off += PAGE_SIZE) {
 			page = vmalloc_to_page(kcov->area + off);
-			if (vm_insert_page(vma, vma->vm_start + off, page))
-				WARN_ONCE(1, "vm_insert_page() failed");
+			if (vm_insert_kmem_page(vma, vma->vm_start + off, page))
+				WARN_ONCE(1, "vm_insert_kmem_page() failed");
 		}
 		return 0;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index c467102..b800c10 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1682,6 +1682,75 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 	return pte_alloc_map_lock(mm, pmd, addr, ptl);
 }
 
+static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
+		struct page *page, pgprot_t prot)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int retval;
+	pte_t *pte;
+	spinlock_t *ptl;
+
+	retval = -EINVAL;
+	if (PageAnon(page))
+		goto out;
+	retval = -ENOMEM;
+	flush_dcache_page(page);
+	pte = get_locked_pte(mm, addr, &ptl);
+	if (!pte)
+		goto out;
+	retval = -EBUSY;
+	if (!pte_none(*pte))
+		goto out_unlock;
+
+	get_page(page);
+	inc_mm_counter_fast(mm, mm_counter_file(page));
+	page_add_file_rmap(page, false);
+	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+
+	retval = 0;
+	pte_unmap_unlock(pte, ptl);
+	return retval;
+out_unlock:
+	pte_unmap_unlock(pte, ptl);
+out:
+	return retval;
+}
+
+/**
+ * vm_insert_kmem_page - insert single page into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @page: source kernel page
+ *
+ * This allows drivers to insert individual kernel memory into a user vma.
+ * This API should be used outside page fault handlers context.
+ *
+ * Previously the same has been done with vm_insert_page by drivers. But
+ * vm_insert_page will be converted to vmf_insert_page and will be used
+ * in fault handlers context and return type of vmf_insert_page will be
+ * vm_fault_t type.
+ *
+ * But there are places where drivers need to map kernel memory into user
+ * vma outside fault handlers context. As vmf_insert_page will be restricted
+ * to use within page fault handlers, vm_insert_kmem_page could be used
+ * to map kernel memory to user vma outside fault handlers context.
+ */
+int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
+			struct page *page)
+{
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return -EFAULT;
+	if (!page_count(page))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_MIXEDMAP)) {
+		BUG_ON(down_read_trylock(&vma->vm_mm->mmap_sem));
+		BUG_ON(vma->vm_flags & VM_PFNMAP);
+		vma->vm_flags |= VM_MIXEDMAP;
+	}
+	return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(vm_insert_kmem_page);
+
 /*
  * This is the old fallback for page remapping.
  *
diff --git a/mm/nommu.c b/mm/nommu.c
index e4aac33..153b8c8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
+				struct page *page)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vm_insert_kmem_page);
+
 /*
  *  sys_brk() for the most part doesn't need the global kernel
  *  lock, except when an application is doing something nasty
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a728fc4..61d279f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2251,7 +2251,7 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 		struct page *page = vmalloc_to_page(kaddr);
 		int ret;
 
-		ret = vm_insert_page(vma, uaddr, page);
+		ret = vm_insert_kmem_page(vma, uaddr, page);
 		if (ret)
 			return ret;
 
-- 
1.9.1

