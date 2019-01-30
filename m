Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B520863
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GGajD6r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfA3Wxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:53:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42138 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3Wxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 17:53:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so506815pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwUVPqZYtJ4/qC/YA4rShqVKVS/62hvbzlxn0+9DHfU=;
        b=GGajD6r8JZS51Dfjgulo6Te9yoS8F0DIvFTQThgjCy5ERlpYnlAH65nCX5iyQUPlM1
         g/SVzX0E3oyKGD95zoMYvRS41mBXupvy6pBzNa8miatzOHXvbXpqcBpvyJY/OPQ2hfm4
         QODnBgHJWKqQhQDPVTq30FpqKmU76eBKT5hfKXJmz8xO9zl8j1PrVgEKluwLMKe9b7dY
         SVaJhzK5sxd6wBMQreHDor1BXNnhz8DTTNkEnmVcqyCq9fTuL6hzHSkR9gFXj4IUrwcS
         tEOa5mRJFC/ZyG+KjbwxIrB9QhvfmwzDhqCkIoDSa/xilvOvTZmPaif3BM5UkNxxLjX4
         2NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwUVPqZYtJ4/qC/YA4rShqVKVS/62hvbzlxn0+9DHfU=;
        b=VPRnBu8mfkxNr2DrbFhvtfXanhdPhhzoUa+CDYJtEDnhg4lcNLWJACObUhynZmOlRS
         G4Eiqhl8X8lxUmpV5Q5NgKMfHnxKYmL3hSn5UhdG/8ttR52J+C70MUSKWNINLEEi83nS
         lb+QapyxOcj5DrNKtPW32YzOjAAF+77y7/td3hfCp8/Xt0nMWA3bFWzsaGsFdncS6IdK
         XtEsM/Tq4Y0ULf1Xxkip5TXG4pzk52rZ/BRqUlnAqXylPe9emSXowDPGcl4ClnEqKz8v
         IuY4ZrNPLB4kOVsJDrJdUuDioAJa4OlPxDcidzwbzw9xqPmdlDXI7pBpJt0JcTE5coBE
         PozQ==
X-Gm-Message-State: AJcUukfb5r0E7ePmnk2/uKIMSlDKAsIxSF6cU2KYnEqbGMV8EdRoE7vk
        oPuLCCFKh6sBmQhW+MZM20eL2Q==
X-Google-Smtp-Source: ALg8bN4LSXDcPGZ97ZMmQy0cbjO5jKUUD1sDBofkslSqg0sQfwT91Ts6fSHErBq6Ffss9BRoJAeB7Q==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr28731645pga.355.1548888437277;
        Wed, 30 Jan 2019 14:47:17 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id w136sm4219190pfd.169.2019.01.30.14.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:47:16 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 5/7] binder: remove kernel vm_area for buffer space
Date:   Wed, 30 Jan 2019 14:46:53 -0800
Message-Id: <20190130224655.255149-6-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190130224655.255149-1-tkjos@google.com>
References: <20190130224655.255149-1-tkjos@google.com>
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
index 2eebff4be83e..d4cbe4b3947a 100644
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

