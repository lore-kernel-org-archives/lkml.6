Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914E920851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWk6uLkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914E920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLBGQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:16:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44038 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLBGQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:16:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4771869pfh.11;
        Sat, 01 Dec 2018 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zpuGNdUnpdN5wTEIRBOxYuxj5rUfCCVuWQ25gpRoE6s=;
        b=bWk6uLkFrct4pezrRVHDS3fxAfnzuH30JJU4oMJOz2yuRc6qGON0LS3euO9PI18qCG
         ZWCJ/La6wnc++Nb6Jl5M7htxappQkoe07uJn+Tgm2gzZrUpW4u6sFMq4hhElyN39p+9v
         zz1vE8r8mohE3kP3S+LsBxTj9Y9QmOvTxyr+xuNsnDmySrcEt7Zz/1uqxJRqxgRQTFTW
         h/SSYR9cuTSYigG5l+TwSwbmOvd7pT/sHv8kYvijQHX0gOgpzngqpuzQWss+3SjvQuvP
         Q74IyFtYvg1IFgMLRPd0NLO+dpLsHbzDcBnYYIMyHZbKylIA5otr3Lj2UWKVL3p/SPpM
         lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zpuGNdUnpdN5wTEIRBOxYuxj5rUfCCVuWQ25gpRoE6s=;
        b=THyyVfz6zTLvQGp7SMSVu2jOPk97szapGbUrak6GHW1mwqg0XsSZzBuPgarGoVF3sU
         QSoYsRlXxWtzxRapNVXjhUlibGIMEmByPRuQOKZK///zhdfwYnHPd4GtK4WPBqFS/h7U
         jLcZ0TZxXvbyGTNGbX6Y0UtPAw5Lb6WF42aKwZx+WHkNvzk/eZsKHRWOKQDyA3x3XWvN
         MRdmmyFH6VkzuW6rKcHZV+gieaoncELGowoTkESpkg/CShEDXkOrDRwPXXB/2IIcJ3T6
         teVk9dHeVYVow0CdTeS9BHz28FDyjh43taIFBfGDfudLWBjo9LxdaS2VDPOnuPnRQoEY
         yGdw==
X-Gm-Message-State: AA+aEWbxiS6sqz9JtaQX6X0AUxeOzD0SwcmmSe1k50qSoFQCoPb1PTsp
        YdI8GPvzUt33SizQgDQzxa/zyVHk
X-Google-Smtp-Source: AFSGD/UBkP9uRpZkSu5Rmi17UiqjfK/g8dHm6TgDXv94eGr1l1iC6bkXVyD45WRhl9f9OjSvEy60DQ==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr9689461pgl.173.1543731360563;
        Sat, 01 Dec 2018 22:16:00 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id v14sm16952190pgf.3.2018.12.01.22.15.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:15:59 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:49:44 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Subject: [PATCH v2 1/9] mm: Introduce new vm_insert_range API
Message-ID: <20181202061944.GA3094@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating a new function and use it across
the drivers.

vm_insert_range is the new API which will be used to map a
range of kernel memory/pages to user vma.

This API is tested by Heiko for Rockchip drm driver, on rk3188,
rk3288, rk3328 and rk3399 with graphics.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/mm_types.h |  3 +++
 mm/memory.c              | 38 ++++++++++++++++++++++++++++++++++++++
 mm/nommu.c               |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f62..15ae24f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 extern void tlb_finish_mmu(struct mmu_gather *tlb,
 				unsigned long start, unsigned long end);
 
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count);
+
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
 {
 	atomic_set(&mm->tlb_flush_pending, 0);
diff --git a/mm/memory.c b/mm/memory.c
index 15c417e..84ea46c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
+ * vm_insert_range - insert range of kernel pages into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pages: pointer to array of source kernel pages
+ * @page_count: number of pages need to insert into user vma
+ *
+ * This allows drivers to insert range of kernel pages they've allocated
+ * into a user vma. This is a generic function which drivers can use
+ * rather than using their own way of mapping range of kernel pages into
+ * user vma.
+ *
+ * If we fail to insert any page into the vma, the function will return
+ * immediately leaving any previously-inserted pages present.  Callers
+ * from the mmap handler may immediately return the error as their caller
+ * will destroy the vma, removing any successfully-inserted pages. Other
+ * callers should make their own arrangements for calling unmap_region().
+ *
+ * Context: Process context. Called by mmap handlers.
+ * Return: 0 on success and error code otherwise
+ */
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count)
+{
+	unsigned long uaddr = addr;
+	int ret = 0, i;
+
+	for (i = 0; i < page_count; i++) {
+		ret = vm_insert_page(vma, uaddr, pages[i]);
+		if (ret < 0)
+			return ret;
+		uaddr += PAGE_SIZE;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(vm_insert_range);
+
+/**
  * vm_insert_page - insert single page into user vma
  * @vma: user vma to map to
  * @addr: target user address of this page
diff --git a/mm/nommu.c b/mm/nommu.c
index 749276b..d6ef5c7 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vm_insert_range);
+
 /*
  *  sys_brk() for the most part doesn't need the global kernel
  *  lock, except when an application is doing something nasty
-- 
1.9.1

