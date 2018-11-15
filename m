Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5948BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B0A20818
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh6N6bxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B0A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbeKPBuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:50:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33515 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:50:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so9888785pfk.0;
        Thu, 15 Nov 2018 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Cg6brz7mYbLRhNFEJEtQAETpRuMNOqibtuUBxg6orP4=;
        b=Eh6N6bxmBaJCmbCwKW3nWNFuf4BU086XyvkfRs4vTvK36lWMY6cUN0FJX1PSYvywPA
         imnNfFW8NM5MhtB/HlVZZcHG+VZLG6fwdGA8wfvH3nTVvJ65/UEg8XF5sPJgwcMQ+Hcp
         24J7dBDK4YuAeDF1ME0tMs/isqPAtODXkGF+EuEklxGHrwSqW6x5O9XLDxpRfHpmSSvk
         Sm1Rl+EzeIHqJmV2GbHPGqlz3EsJ6NJzstXHM7D/kaiWLp1iZCgeJ7SAzbxnhLcdmVAD
         NANa4oTHJ5p9uJkn4VOq7tq40IfMMMlfkFxDrYrG6YazkS00ehOYAi289jFYFozTT7r6
         m7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cg6brz7mYbLRhNFEJEtQAETpRuMNOqibtuUBxg6orP4=;
        b=Fa567TI+O1CpU8eoLgDaskr3u+zB+OUMne2Lg1+kX5O33Cti5+e7j0dyPOap/J3frr
         F1XoC3J2cmi+yz8WbITbSYl3d4V5VJ0fCucPWLb15AuxMSkTb/2KyUDV5K5CbQOH+2FN
         S6cJ0zjBJAFw+kCg71knVgH3izY2cRQ10o5Xuv0S/plchx7v2WtCp6nyLUX4RyRQ8m/Z
         Ww1J2ZtUhVMZOIC3iKD5bpMRLNjO3+j5oONL6bSolTU2B2It0haRCm+W26esOOTSRbMl
         PmGZJV39eCPdXF63Y35aovG7dBaLPuFnErbyF3VwBrzkTiDa5xsYJt/A8UASMdLhKaXa
         YdOA==
X-Gm-Message-State: AGRZ1gIGczk05TotICf1j32ASmp2qFlAF8EOIWFGlwBjDOM+p0fwEH2c
        YVadhRST5mf9/HkbOjgYriLTcKYSPKs=
X-Google-Smtp-Source: AJdET5c/4IUsmJbAFLjrppekHCGzB7YBq4feZP6VdbGvFFyn78AfrEs+pTt1JsSRVIRjujxms+LN6A==
X-Received: by 2002:a63:5153:: with SMTP id r19mr6195032pgl.281.1542296514745;
        Thu, 15 Nov 2018 07:41:54 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id u127-v6sm28519773pfb.47.2018.11.15.07.41.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:41:53 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:15:30 +0530
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
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
Message-ID: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
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

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm_types.h |  3 +++
 mm/memory.c              | 28 ++++++++++++++++++++++++++++
 mm/nommu.c               |  7 +++++++
 3 files changed, 38 insertions(+)

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
index 15c417e..da904ed 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,34 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
+ * vm_insert_range - insert range of kernel pages into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pages: pointer to array of source kernel pages
+ * @page_count: no. of pages need to insert into user vma
+ *
+ * This allows drivers to insert range of kernel pages they've allocated
+ * into a user vma. This is a generic function which drivers can use
+ * rather than using their own way of mapping range of kernel pages into
+ * user vma.
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

