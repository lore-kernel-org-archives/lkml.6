Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E5B2156F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="b1uyLlOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E5B2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHGWNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:13:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33248 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeHGWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:13:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so9106780pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQK5+D82N2z6u3SYKNEfLZ5XaFSfCT60YT8YYixT3qA=;
        b=b1uyLlOeSI+b5W44M2nFq49SQINP146i56gc5bFKt7nLco2GoOu+euY16FX00Ml6uu
         yrMnTzC6PT8o+G9c84taQesWqz8SHuMPo8jrFphGe8+c46TdmgtMLYnS8Mlhm8WxZbtv
         H2zP0wB1iyapLr3VDENSzl9jsXkRlrtXuvr7YTS/GBVm5cFHUcLR3Fd+CycHBpnhTaoH
         J3AGftkkIN47KLAZVsgCaFg7fnn6fLA92DJcxbxsfwipexLp/yUHhxZ5pUuU8+HLt2Kr
         3tcAlRApKI00q64shZq6c5LGbDYtomLeNK7JNT5yUJ3mZrvxEVKR1njIm9BDhNxIboDf
         zw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQK5+D82N2z6u3SYKNEfLZ5XaFSfCT60YT8YYixT3qA=;
        b=AmQHEE/tou7vA/Uy+uZafQKmBcqE+s0RdMRq0j3bUctMXm/ABCyiT26by4JMQNdfq7
         sMTlIwWE8eUAe0IaMUVLo0I2pxQl6tC8J39Kk2r1Fho2fFeUvkwYTJriyTeXY8BCypKI
         1bbFwpq7pZpmStaat2Pa80+iLouH14fHvvy2A4HO+TIC/YBX1FtwBcMEPgli4wisuq9f
         UjKzIEVJu/f35dL0wGYHfcGhAkM8uzxCEltF2lJHF2cj4qEhpaevfcDhPp8mXFV4gVOc
         4RAmkZDDbi+7KlqE8beTf369Jj0KHCHcPCB1H2JqbEogACOl/vFo0YTcLT7IB5Ds93L8
         qVdg==
X-Gm-Message-State: AOUpUlGwdgOCYtcj99g/nRNWXQiVdexG4Gvdj3nuuhEyJdUuEj3tDD5G
        1zuDo1558nQyQCRZGD5f0dkXDTqi8aI=
X-Google-Smtp-Source: AAOMgpf+k4wDhIANSqBHU1UGkCKjMVyzNZC+8KNBvvQITkq723vFLwy6H/6WBRLXdqHOzikcTGKjMQ==
X-Received: by 2002:a63:3e4d:: with SMTP id l74-v6mr20319025pga.355.1533671840153;
        Tue, 07 Aug 2018 12:57:20 -0700 (PDT)
Received: from sherryy2.mtv.corp.google.com ([2620:0:1000:1612:cc83:cf0b:baf7:605])
        by smtp.gmail.com with ESMTPSA id s85-v6sm4697894pfa.116.2018.08.07.12.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:57:19 -0700 (PDT)
From:   Sherry Yang <sherryy@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, maco@google.com,
        Sherry Yang <sherryy@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        devel@driverdev.osuosl.org (open list:ANDROID DRIVERS)
Subject: [PATCH v2] android: binder: Rate-limit debug and userspace triggered err msgs
Date:   Tue,  7 Aug 2018 12:57:13 -0700
Message-Id: <20180807195714.196980-1-sherryy@android.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802083442>
References: <20180802083442>
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
v2: rebase onto char-misc-next to resolve include order
difference from master

 drivers/android/binder.c       |  5 +++--
 drivers/android/binder_alloc.c | 41 +++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 1cc2fa16af8b..d58763b6b009 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -70,6 +70,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/security.h>
 #include <linux/spinlock.h>
+#include <linux/ratelimit.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -163,13 +164,13 @@ module_param_call(stop_on_user_error, binder_set_stop_on_user_error,
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
index 2c258dcf9d72..3f3b7b253445 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/list_lru.h>
+#include <linux/ratelimit.h>
 #include <asm/cacheflush.h>
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
2.18.0.597.ga71716f1ad-goog

