Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07904C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF2120870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="n2sycRtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfA2AuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:50:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34908 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:50:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so8539768plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BV/Cgd6LGnhczDiGpnpuYj3/SOgx8F/Vl7ZzK8XKPN4=;
        b=n2sycRtgq78L5sK14KsG8qaacif5vgyt+krtw+nr0bhAAyBb2uwz1dbFfVvaRfDUy1
         hOzsO5r0czHlDCp1wrfEW2lVqzrj18gUDGgAM/WcwTZvuMKzU5F7HsaTdFtl8O70V34V
         nW699a0dJV8XJnbyHrmC0ejzfCAOqbZ+en6h384g9aIC+iE26tctXLfAoGtPFpFfwbHm
         hgRR58g16Z1DA5yp1siOWZds3DiGj/tQyoMyo0ry5NBa4YuaBFP93cbYwGMfLGVD58vh
         CcEHUK4WtlMvWsrjfRW9GiAoKkla4i5gwwmfCqTC9fH2FDZmaC2byWGQXV5drvSHTpym
         H9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BV/Cgd6LGnhczDiGpnpuYj3/SOgx8F/Vl7ZzK8XKPN4=;
        b=G1kc9S2tlg79F9zX2uGb7RGrlAz8kqECmVrwRAxFIA8HYgHt0Tn0HU6eBdtW59H8Rl
         lE9UnZSJVwzPwqeP+FFATrjgrUF59ldMWYLjtw+85fN3cei7/p9CLGqYHezaVg8ReORX
         hHG3QJAUtch5P4rTp+/yM1w8mDAx85pGnidK/OHr2xaevMbVsnDCGAt3L2CVkOlssxPM
         IOiduvXmiOeOhMhfX5CntqBg9aRKcn3SJnvT3s/0gxmfs/ZfWLx9f/xHPncDK4KC0WJZ
         csIQBRfrxCz9WkO+OLQkE6PQgknL4zyOQfEjqyV3aMAO7IcqJfxaSlmfB8qLWdvslyJV
         bp6w==
X-Gm-Message-State: AJcUukflS2EaJMc92FJY13eLXgufqnjBSHvZnaINiyCTmiJ+P6bI6J4V
        776uG9UAAYGyihSxfsz4Y7UlCQ==
X-Google-Smtp-Source: ALg8bN7E2eK21xLjDS/4GPl1a6WfkYpa2g3lcGllEDe+U6vCMdgWh0nGhGn1yO1I5QVyltRwDwDCnQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr24313081plb.55.1548723013940;
        Mon, 28 Jan 2019 16:50:13 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id g3sm52090792pfe.37.2019.01.28.16.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:50:12 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH 5/7] binder: remove kernel vm_area for buffer space
Date:   Mon, 28 Jan 2019 16:49:32 -0800
Message-Id: <20190129004934.85885-6-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129004934.85885-1-tkjos@google.com>
References: <20190129004934.85885-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the kernel's vm_area and the code that maps
buffer pages into it.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder_alloc.c | 40 ++--------------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index be2a6077e6c5c..dde8977c49ea0 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -265,16 +265,6 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		page->alloc = alloc;
 		INIT_LIST_HEAD(&page->lru);
 
-		ret = map_kernel_range_noflush((unsigned long)page_addr,
-					       PAGE_SIZE, PAGE_KERNEL,
-					       &page->page_ptr);
-		flush_cache_vmap((unsigned long)page_addr,
-				(unsigned long)page_addr + PAGE_SIZE);
-		if (ret != 1) {
-			pr_err("%d: binder_alloc_buf failed to map page at %pK in kernel\n",
-			       alloc->pid, page_addr);
-			goto err_map_kernel_failed;
-		}
 		user_page_addr =
 			(uintptr_t)page_addr + alloc->user_buffer_offset;
 		ret = vm_insert_page(vma, user_page_addr, page[0].page_ptr);
@@ -314,8 +304,6 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		continue;
 
 err_vm_insert_page_failed:
-		unmap_kernel_range((unsigned long)page_addr, PAGE_SIZE);
-err_map_kernel_failed:
 		__free_page(page->page_ptr);
 		page->page_ptr = NULL;
 err_alloc_page_failed:
@@ -695,7 +683,6 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 			      struct vm_area_struct *vma)
 {
 	int ret;
-	struct vm_struct *area;
 	const char *failure_string;
 	struct binder_buffer *buffer;
 
@@ -706,28 +693,10 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_already_mapped;
 	}
 
-	area = get_vm_area(vma->vm_end - vma->vm_start, VM_ALLOC);
-	if (area == NULL) {
-		ret = -ENOMEM;
-		failure_string = "get_vm_area";
-		goto err_get_vm_area_failed;
-	}
-	alloc->buffer = area->addr;
-	alloc->user_buffer_offset =
-		vma->vm_start - (uintptr_t)alloc->buffer;
+	alloc->buffer = (void *)vma->vm_start;
+	alloc->user_buffer_offset = 0;
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-#ifdef CONFIG_CPU_CACHE_VIPT
-	if (cache_is_vipt_aliasing()) {
-		while (CACHE_COLOUR(
-				(vma->vm_start ^ (uint32_t)alloc->buffer))) {
-			pr_info("%s: %d %lx-%lx maps %pK bad alignment\n",
-				__func__, alloc->pid, vma->vm_start,
-				vma->vm_end, alloc->buffer);
-			vma->vm_start += PAGE_SIZE;
-		}
-	}
-#endif
 	alloc->pages = kcalloc((vma->vm_end - vma->vm_start) / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
@@ -760,9 +729,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->pages = NULL;
 err_alloc_pages_failed:
 	mutex_lock(&binder_alloc_mmap_lock);
-	vfree(alloc->buffer);
 	alloc->buffer = NULL;
-err_get_vm_area_failed:
 err_already_mapped:
 	mutex_unlock(&binder_alloc_mmap_lock);
 	binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
@@ -821,12 +788,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 				     "%s: %d: page %d at %pK %s\n",
 				     __func__, alloc->pid, i, page_addr,
 				     on_lru ? "on lru" : "active");
-			unmap_kernel_range((unsigned long)page_addr, PAGE_SIZE);
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
 		kfree(alloc->pages);
-		vfree(alloc->buffer);
 	}
 	mutex_unlock(&alloc->mutex);
 	if (alloc->vma_vm_mm)
@@ -988,7 +953,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	trace_binder_unmap_kernel_start(alloc, index);
 
-	unmap_kernel_range(page_addr, PAGE_SIZE);
 	__free_page(page->page_ptr);
 	page->page_ptr = NULL;
 
-- 
2.20.1.495.gaa96b0ce6b-goog

