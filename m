Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075E321710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQvW4dmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075E321710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeI1AHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:07:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45586 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1AHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:07:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so2465383pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HDQ9y9C/oiqeIou2l3SVv0ho6BkiUbABnTmzk+xl4LE=;
        b=IQvW4dmmeGDwnygUzN8u0nkcMxPauUjXTXhZkys2wMPa8CxfT7jUAvcmbRnqpYTf7G
         aAIKlu8mn/ZfpCD8mWs20RsJulBZox0NbEK7mlAm6jhgxiXQOnPVCp1f2zJbfdHtQLC8
         ItcXlvTI2FzpsBjz5AuX4fV+2B+YE/wWC/J0/JOp8VEeudYfYxYRKrwaxEVnzur2DKQs
         nGi/e7puiDe8aYiraPi832wsiJXeZICLjbFEaDvLwzXh84Y2Zn6tnaN/n6e69Dnd5KQA
         j5GLJdO3ObU1m78HoL+1+d7qYq4KUYGw2lCqpQhRkZZDzTAcI5XcDYMEnEgmY8UlGQsX
         4zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HDQ9y9C/oiqeIou2l3SVv0ho6BkiUbABnTmzk+xl4LE=;
        b=j85Wlp4q9mivCnjwdCvZRy/rpR0BWSZxaL5CBWVLJ+P7eIBLHj59rqoTPBJbLA90xg
         ruQBPWii6wyrMdgQfY6XgG/n4maMMOu+T5RXkB5hYxmw96uc9AnlL2+UUivi5USmmHwV
         ORI7AgTVROYD5Y2nefj4GmAawxbYkT+Z9OEZwEhy9QqmqSYkd3K720Ob4mBvy/cqbIqI
         nPyBJa2MfgKOBl3KEwVDpLMg2NTUsf4BrLMn3tlcZMQfolPD3v+EWLSqT9bCtf9zcWGx
         H86lKDzEo+KXpAJQXkrCw009mRPZOuBAaMQCc4XpISj+EdOXKOl5XHT8I5LEstErNATm
         nnGg==
X-Gm-Message-State: ABuFfojVhck1jO4Srt0zGO2c8Z2rIYdSMJPDzJseLFVXlrDmnqz+lGQ3
        5NJLB5LRXZOd5eVROQ5QenOz8HYb
X-Google-Smtp-Source: ACcGV63d39oyKY8lCOqDWf4RHO297kS9KEKakDJIYhFdu3/5r2/qnVHK3B2lKNSgCHgBbZGSYoCudQ==
X-Received: by 2002:a65:53c9:: with SMTP id z9-v6mr11193305pgr.203.1538070489368;
        Thu, 27 Sep 2018 10:48:09 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.124])
        by smtp.gmail.com with ESMTPSA id w12-v6sm3981717pfd.110.2018.09.27.10.48.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 10:48:08 -0700 (PDT)
Date:   Thu, 27 Sep 2018 23:21:23 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        pasha.tatashin@oracle.com, riel@redhat.com, willy@infradead.org,
        minchan@kernel.org, peterz@infradead.org, ying.huang@intel.com,
        ak@linux.intel.com, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, arnd@arndb.de, mcgrof@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20180927175123.GA16367@jordon-HP-15-Notebook-PC>
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

Previously vm_insert_page is used for both page fault
handlers and outside page fault handlers context. When
vm_insert_page is used in page fault handlers context,
each driver have to map errno to VM_FAULT_CODE in their
own way. But as part of vm_fault_t migration all the
page fault handlers are cleaned up by using new vmf_insert_page.
Going forward, vm_insert_page will be removed by converting
it to vmf_insert_page.
 
But their are places where vm_insert_page is used outside
page fault handlers context and converting those to
vmf_insert_page is not a good approach as drivers will end
up with new VM_FAULT_CODE to errno conversion code and it will
make each user more complex.

So this new vm_insert_kmem_page can be used to map kernel
memory to user vma outside page fault handler context.

In short, vmf_insert_page will be used in page fault handlers
context and vm_insert_kmem_page will be used to map kernel
memory to user vma outside page fault handlers context.

We will slowly convert all the user of vm_insert_page to
vm_insert_kmem_page after this API be available in linus tree.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  7 ++++++
 3 files changed, 78 insertions(+)

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
-- 
1.9.1

