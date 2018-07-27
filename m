Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE45C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379D420673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="frI9N2rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379D420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbeG0Bgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:36:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35140 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbeG0Bgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:36:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7-v6so1110006pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDQL03F6jDJqg8vmjsAoXWo8ugyjdr2mFrww0D37Icg=;
        b=frI9N2rOATVJgl3QFPbewz1MednbWezlLzuovtzECxomICpq3aSumq/hfp3sBLFttz
         6dYR6MPNNjSbkWrH9cJRGMS/rlYrAloN0ArxCcuwsJKZ0gqmG4TVKqFIfJFNusDjgifD
         zS5DoAX/KpSytE3ry+T9ox4WtEJuy4FS4b5fpujDUVA031mb3Xb6fktkRAcfXMBY4aps
         7ehGh6CmTUIFTQb8a8oDz2aS2OYIqrC76kva8EAdHLylcXlnlQwVc8fGewQeGBpdK7uP
         jLFBY6UurgTLWClOjnnr3bTwt0XTd+GNxjYsE+NTYF9qfUFxxLkunuCo7oX3h18ivUO7
         Ey+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDQL03F6jDJqg8vmjsAoXWo8ugyjdr2mFrww0D37Icg=;
        b=NT5JBUqpySD6wIB0YYF1w4Ekn4zNv7wI3WHbq1ZetiAhqIBWY2RoQElEC12AhbR9MC
         zTFsolgdYqRdKLHdGmJi59EN7+WimA1LDGq1IyEAagXtc3HNOexHz8JpF9L1S9xOyZ75
         8g1eh3+4YWCkfn+Kl/Cuc1+s31TP8X5VB7zbna7kcbSyRFHzYzOwSk4uw8dm+cVkFwUO
         4N54IvnE7TZ9iXIErD8RgUKBwtevuw6DiVBnsU/VAJTa6Ty9ybeuGtE46aN6gDZ2nYvs
         GNL+1LIUTKVQCiuDksT2Gg70+80+k7g5xWSQBIupkk7YwtNvlZzmmeDk9MVQRMJICimn
         4aXA==
X-Gm-Message-State: AOUpUlGdnxNduoFqkEt1JnmMo00PTvkHoTUuM2AZCO5TmAyMLtFtXn/0
        g5NIJfsgpwcKhMJoQtx5WpuIC64PydI=
X-Google-Smtp-Source: AAOMgpfAiG5z9Ihux/pGqe6Y+EnwPCZBxnR95Zj2grCbiKh7kwxw7c1jPRkYTTzZLsEPANr0AoqE7A==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr3870789pgd.372.1532650648060;
        Thu, 26 Jul 2018 17:17:28 -0700 (PDT)
Received: from sherryy2.mtv.corp.google.com ([2620:0:1000:1611:8e0a:214e:3e7b:4985])
        by smtp.gmail.com with ESMTPSA id q65-v6sm5345864pfj.127.2018.07.26.17.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 17:17:27 -0700 (PDT)
From:   Sherry Yang <sherryy@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, maco@google.com,
        Sherry Yang <sherryy@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        devel@driverdev.osuosl.org (open list:ANDROID DRIVERS)
Subject: [PATCH 2/2] android: binder: Rate-limit debug and userspace triggered err msgs
Date:   Thu, 26 Jul 2018 17:17:18 -0700
Message-Id: <20180727001718.242587-3-sherryy@android.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727001718.242587-1-sherryy@android.com>
References: <20180727001718.242587-1-sherryy@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rate-limited debug messages where userspace can trigger
excessive log spams.

Acked-by: Arve Hjønnevåg <arve@android.com>
Signed-off-by: Sherry Yang <sherryy@android.com>
---
 drivers/android/binder.c       |  5 +++--
 drivers/android/binder_alloc.c | 41 +++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 95283f3bb51c..78cc1190282c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -71,6 +71,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/security.h>
 #include <linux/spinlock.h>
+#include <linux/ratelimit.h>
 
 #include <uapi/linux/android/binder.h>
 #include "binder_alloc.h"
@@ -161,13 +162,13 @@ module_param_call(stop_on_user_error, binder_set_stop_on_user_error,
 #define binder_debug(mask, x...) \
 	do { \
 		if (binder_debug_mask & mask) \
-			pr_info(x); \
+			pr_info_ratelimited(x); \
 	} while (0)
 
 #define binder_user_error(x...) \
 	do { \
 		if (binder_debug_mask & BINDER_DEBUG_USER_ERROR) \
-			pr_info(x); \
+			pr_info_ratelimited(x); \
 		if (binder_stop_on_user_error) \
 			binder_stop_on_user_error = 2; \
 	} while (0)
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2628806c64a2..e16116e9ad1f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/list_lru.h>
+#include <linux/ratelimit.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
@@ -36,11 +37,12 @@ struct list_lru binder_alloc_lru;
 static DEFINE_MUTEX(binder_alloc_mmap_lock);
 
 enum {
+	BINDER_DEBUG_USER_ERROR             = 1U << 0,
 	BINDER_DEBUG_OPEN_CLOSE             = 1U << 1,
 	BINDER_DEBUG_BUFFER_ALLOC           = 1U << 2,
 	BINDER_DEBUG_BUFFER_ALLOC_ASYNC     = 1U << 3,
 };
-static uint32_t binder_alloc_debug_mask;
+static uint32_t binder_alloc_debug_mask = BINDER_DEBUG_USER_ERROR;
 
 module_param_named(debug_mask, binder_alloc_debug_mask,
 		   uint, 0644);
@@ -48,7 +50,7 @@ module_param_named(debug_mask, binder_alloc_debug_mask,
 #define binder_alloc_debug(mask, x...) \
 	do { \
 		if (binder_alloc_debug_mask & mask) \
-			pr_info(x); \
+			pr_info_ratelimited(x); \
 	} while (0)
 
 static struct binder_buffer *binder_buffer_next(struct binder_buffer *buffer)
@@ -152,8 +154,10 @@ static struct binder_buffer *binder_alloc_prepare_to_free_locked(
 			 * free the buffer twice
 			 */
 			if (buffer->free_in_progress) {
-				pr_err("%d:%d FREE_BUFFER u%016llx user freed buffer twice\n",
-				       alloc->pid, current->pid, (u64)user_ptr);
+				binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+						   "%d:%d FREE_BUFFER u%016llx user freed buffer twice\n",
+						   alloc->pid, current->pid,
+						   (u64)user_ptr);
 				return NULL;
 			}
 			buffer->free_in_progress = 1;
@@ -224,8 +228,9 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 
 	if (!vma && need_mm) {
-		pr_err("%d: binder_alloc_buf failed to map pages in userspace, no vma\n",
-			alloc->pid);
+		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+				   "%d: binder_alloc_buf failed to map pages in userspace, no vma\n",
+				   alloc->pid);
 		goto err_no_vma;
 	}
 
@@ -344,8 +349,9 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	int ret;
 
 	if (alloc->vma == NULL) {
-		pr_err("%d: binder_alloc_buf, no vma\n",
-		       alloc->pid);
+		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+				   "%d: binder_alloc_buf, no vma\n",
+				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
 
@@ -417,11 +423,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			if (buffer_size > largest_free_size)
 				largest_free_size = buffer_size;
 		}
-		pr_err("%d: binder_alloc_buf size %zd failed, no address space\n",
-			alloc->pid, size);
-		pr_err("allocated: %zd (num: %zd largest: %zd), free: %zd (num: %zd largest: %zd)\n",
-		       total_alloc_size, allocated_buffers, largest_alloc_size,
-		       total_free_size, free_buffers, largest_free_size);
+		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+				   "%d: binder_alloc_buf size %zd failed, no address space\n",
+				   alloc->pid, size);
+		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+				   "allocated: %zd (num: %zd largest: %zd), free: %zd (num: %zd largest: %zd)\n",
+				   total_alloc_size, allocated_buffers,
+				   largest_alloc_size, total_free_size,
+				   free_buffers, largest_free_size);
 		return ERR_PTR(-ENOSPC);
 	}
 	if (n == NULL) {
@@ -731,8 +740,10 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 err_get_vm_area_failed:
 err_already_mapped:
 	mutex_unlock(&binder_alloc_mmap_lock);
-	pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
-	       alloc->pid, vma->vm_start, vma->vm_end, failure_string, ret);
+	binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+			   "%s: %d %lx-%lx %s failed %d\n", __func__,
+			   alloc->pid, vma->vm_start, vma->vm_end,
+			   failure_string, ret);
 	return ret;
 }
 
-- 
2.18.0.345.g5c9ce644c3-goog

