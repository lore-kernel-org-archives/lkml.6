Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A712084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j01UzZa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfBYUar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:30:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:30:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so5008060pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omgUtD5TBe/L2nj/vYLxBbkyge+zjnwluovkZCUWzAA=;
        b=j01UzZa+id2m/gN68bYEvZ2TcacRml0G75125G0/K1Kc15uFzc3+eHRhm1GmJEPo+e
         bPF9giJM+jYKBhNa9ilvHZMTDP415am/itTmB4YZk2mpSNJEgaB0ac9bgWe526icGmQ3
         5pNWwng9d1sC54oP81jbGJcHQNydL1WDOFZZETK9SecOJ2m56LI8c00vPW/5g0fuHn3A
         WFMDwylnTqVdmI9DCdMcsUyQosnLd6M3xVfIF2TCJvR7ojKoeO7R5cWZYoJu8ZJsLTno
         m6fH64U8YFtpe+mEei0jx39diwnfLPvE9aPYSSOIP3ARIIKMXV9eizsPB8doAiOD73xn
         4Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omgUtD5TBe/L2nj/vYLxBbkyge+zjnwluovkZCUWzAA=;
        b=BCBHiP98DTr7BFkosj0/yyPJr+pAYBJBbdRqTkWhtqt3JXCwYvi+NXGSF1F/wTUH98
         G1AEZVPxEvZh3lkNXaFRpNUr7kYG8+f4fz/DKZ8+sE5v3j4MgX93NTLhz28uR/Ij+nSx
         nvvlSjr/2aroypN5VgDrixUaxY74PeYrpX2qkml/5ursjt0mHa3enEbMpHlQXPH6/Ksn
         MN68EW8XqXAxK+dnVwDkFB+n6zwzKKnFBO64Uhh6SEQbU3eRbwfIX1Ko7h+MX5Ppxwmr
         CI+iGJ4PuvGYpBDSyEJnwo3+PpTkaWZ3BY0H/9Eq7/iGqwIorwsuBtHlJAjM2YJjXnpg
         Gxqg==
X-Gm-Message-State: AHQUAuaIeyanbroAJC4h0CHHBwk4kxS6+sqzH7QRqkX1Ngsas6IZQ1bM
        zJzSu/xeK5h+ZEDeDRpl4K4=
X-Google-Smtp-Source: AHgI3IbE9OLfOBUyZf9WhRChQMHXzfN8ZG5LJLKgkPJ0+6R2i4vCAr2MYtrIjYsBQogBmMKSDHzM9A==
X-Received: by 2002:a63:8bc8:: with SMTP id j191mr19599469pge.234.1551126643113;
        Mon, 25 Feb 2019 12:30:43 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d960])
        by smtp.gmail.com with ESMTPSA id s4sm6189885pfe.16.2019.02.25.12.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:30:42 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 1/3] mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
Date:   Mon, 25 Feb 2019 12:30:35 -0800
Message-Id: <20190225203037.1317-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225203037.1317-1-guro@fb.com>
References: <20190225203037.1317-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vunmap() calls find_vm_area() twice without an obvious reason:
first directly to get the area pointer, second indirectly by calling
remove_vm_area(), which is again searching for the area.

To remove this redundancy, let's split remove_vm_area() into
__remove_vm_area(struct vmap_area *), which performs the actual area
removal, and remove_vm_area(const void *addr) wrapper, which can
be used everywhere, where it has been used before.

On my test setup, I've got 5-10% speed up on vfree()'ing 1000000
of 4-pages vmalloc blocks.

Perf report before:
  22.64%  cat      [kernel.vmlinux]  [k] free_pcppages_bulk
  10.30%  cat      [kernel.vmlinux]  [k] __vunmap
   9.80%  cat      [kernel.vmlinux]  [k] find_vmap_area
   8.11%  cat      [kernel.vmlinux]  [k] vunmap_page_range
   4.20%  cat      [kernel.vmlinux]  [k] __slab_free
   3.56%  cat      [kernel.vmlinux]  [k] __list_del_entry_valid
   3.46%  cat      [kernel.vmlinux]  [k] smp_call_function_many
   3.33%  cat      [kernel.vmlinux]  [k] kfree
   3.32%  cat      [kernel.vmlinux]  [k] free_unref_page

Perf report after:
  23.01%  cat      [kernel.kallsyms]  [k] free_pcppages_bulk
   9.46%  cat      [kernel.kallsyms]  [k] __vunmap
   9.15%  cat      [kernel.kallsyms]  [k] vunmap_page_range
   6.17%  cat      [kernel.kallsyms]  [k] __slab_free
   5.61%  cat      [kernel.kallsyms]  [k] kfree
   4.86%  cat      [kernel.kallsyms]  [k] bad_range
   4.67%  cat      [kernel.kallsyms]  [k] free_unref_page_commit
   4.24%  cat      [kernel.kallsyms]  [k] __list_del_entry_valid
   3.68%  cat      [kernel.kallsyms]  [k] free_unref_page
   3.65%  cat      [kernel.kallsyms]  [k] __list_add_valid
   3.19%  cat      [kernel.kallsyms]  [k] __purge_vmap_area_lazy
   3.10%  cat      [kernel.kallsyms]  [k] find_vmap_area
   3.05%  cat      [kernel.kallsyms]  [k] rcu_cblist_dequeue

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b7455d4c8c12..8f0179895fb5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1477,6 +1477,24 @@ struct vm_struct *find_vm_area(const void *addr)
 	return NULL;
 }
 
+static struct vm_struct *__remove_vm_area(struct vmap_area *va)
+{
+	struct vm_struct *vm = va->vm;
+
+	might_sleep();
+
+	spin_lock(&vmap_area_lock);
+	va->vm = NULL;
+	va->flags &= ~VM_VM_AREA;
+	va->flags |= VM_LAZY_FREE;
+	spin_unlock(&vmap_area_lock);
+
+	kasan_free_shadow(vm);
+	free_unmap_vmap_area(va);
+
+	return vm;
+}
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -1489,31 +1507,20 @@ struct vm_struct *find_vm_area(const void *addr)
  */
 struct vm_struct *remove_vm_area(const void *addr)
 {
+	struct vm_struct *vm = NULL;
 	struct vmap_area *va;
 
-	might_sleep();
-
 	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA) {
-		struct vm_struct *vm = va->vm;
-
-		spin_lock(&vmap_area_lock);
-		va->vm = NULL;
-		va->flags &= ~VM_VM_AREA;
-		va->flags |= VM_LAZY_FREE;
-		spin_unlock(&vmap_area_lock);
-
-		kasan_free_shadow(vm);
-		free_unmap_vmap_area(va);
+	if (va && va->flags & VM_VM_AREA)
+		vm = __remove_vm_area(va);
 
-		return vm;
-	}
-	return NULL;
+	return vm;
 }
 
 static void __vunmap(const void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
+	struct vmap_area *va;
 
 	if (!addr)
 		return;
@@ -1522,17 +1529,18 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vm_area(addr);
-	if (unlikely(!area)) {
+	va = find_vmap_area((unsigned long)addr);
+	if (unlikely(!va || !(va->flags & VM_VM_AREA))) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
 		return;
 	}
 
+	area = va->vm;
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
-	remove_vm_area(addr);
+	__remove_vm_area(va);
 	if (deallocate_pages) {
 		int i;
 
@@ -1547,7 +1555,6 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	}
 
 	kfree(area);
-	return;
 }
 
 static inline void __vfree_deferred(const void *addr)
-- 
2.20.1

