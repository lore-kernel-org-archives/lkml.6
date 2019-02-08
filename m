Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998F720863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="APBOh40D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBHSfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:35:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35334 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfBHSfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:35:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so2084559pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehcN1ZzF0UizjOuICGMhwpy36uG2t0n1xaET+U8Av5w=;
        b=APBOh40DrWMmcp2UTwx3+dAKCw4rnwPwQb31uVbeRwG/12T/3FlPv3UP6LLSmAvgBt
         lFTHgBRlmFPdmVJ/XKQmdKmBoii1JuSfFBfhOirQQGKsWps69GPliJeMZVnELDaytIVS
         D8fL8SC4DJkTYmvqQkcit5pcEGFmN6eJFVPT7MdI5avWkYsIx0Rjb1dZoWQBuub5NPUz
         PWhSCfMG5FMiRU3j7l8lH8htkV4XAHNAbJmZpaSM55bPLgJmy/3YAYsh2qMy7DIUsCeB
         Mh4ZTBSOHBkhyAowtmpNH7uN7zZp2s9AR+SDRq72kH+6E9r/8eAmxUCClT+g83ieQ4C0
         tTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehcN1ZzF0UizjOuICGMhwpy36uG2t0n1xaET+U8Av5w=;
        b=C3i+17OhnQBPl8NuI5lflpIYl8JpVthb0bYykqwpVEhsA9UpysdcRhT6wvdav3AZ09
         Q4L8wLxs23pEVZrhq5zlERIB/81e8J9JrG6uVZ1XFWtAU6CMznf+B+cd4hsjI9AayeoS
         baqKFK96jAlUy/Rok1LzREZAzcwAqC/T3AnEwuQcVb9OvQsHdGH/4kfJJSUhQBoXPAqj
         vQgA/skYbpAMNeIHKwOkD7JNcBxhkq6wxpapAwb+vXOn4e7iobbP9k0BbDDHx77ywEgE
         alwQW3U+QC2IFGKoWCrjiNfLakWzNLA4A5V/QSkcM4mt8P8/q5Qq74xcJDIl8P8ENoo7
         0qmQ==
X-Gm-Message-State: AHQUAua57VqWRegbqSw7FBzJgHT2NOt0a3PLolFy/HqKYbd1aFOoiWgp
        WpUyjRg2aTQu6STuRxqpY5F1Zw==
X-Google-Smtp-Source: AHgI3IYYyAOF7jkRLAqeqDu0LiRHl4wdo5W7pWXZ3r5xoLzaQAihv+2rc2NGJeIk7f9odEEYaCV6PA==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr22069806pgv.429.1549650943809;
        Fri, 08 Feb 2019 10:35:43 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id 14sm2306472pgq.22.2019.02.08.10.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:35:43 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 5/7] binder: remove kernel vm_area for buffer space
Date:   Fri,  8 Feb 2019 10:35:18 -0800
Message-Id: <20190208183520.30886-6-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190208183520.30886-1-tkjos@google.com>
References: <20190208183520.30886-1-tkjos@google.com>
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
index 2eebff4be83e0..d4cbe4b3947a6 100644
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
2.20.1.791.gb4d0f1c61a-goog

