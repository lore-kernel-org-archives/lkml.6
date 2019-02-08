Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA97C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5F92146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="RzKCAJwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBHSgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:36:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45028 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfBHSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:35:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so2057569pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwp4av0rFoVSu/yavwYPj1kXW4mS0yBlIgbcR0OoIqs=;
        b=RzKCAJwrV5kruqdR9ROVJBGzmOrpqZRBW2b4ikkeus+HjJy0SeFkGTgDly5bZ7IL0Z
         Pp6VCXsXNSyGXiIh/qqmlHG3Yz/aY2A/9PlbrU3WQxivi0A1CZKovHMVSPqfqsbWT22C
         0xEYAswdVAQbBDmMFdbyuKTU5bHElKAJ6J70zXOwfX0dOVgPT1w41N/t4odssKWcnhDd
         sOAjd/JVBfzIIudfONwDyCvpt84DZ3EwJ2kjgwM9By1Wm7VTAU8YELVQHe0XcyQxUuXm
         MpWIpGfybh06rZB+mqRrX8QtcYoVVPCvYudfbVvB4SxArPbt8+ZoXVZ4xv0uhUI8Zldo
         NSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwp4av0rFoVSu/yavwYPj1kXW4mS0yBlIgbcR0OoIqs=;
        b=GR1IN9rVCUdm5tr+tX7W16rriRmuVfLx4iA1VSVVNyJVzq0pjB85xHhPDGb3oyuhyc
         +O5BWPfrB6MHlsKqN8Exd+EAfLmUXXtRNHhH3dSVHK9Eoyri42dYrJnN+q6IAOGOIW3u
         5vMIpD9Eq0IyQvbycf/9rVn6DBdOVo53aOPf975l2vioYgj4X/eE0x5bnfikJKD081Jk
         tqyJG9xMb5E4Pzsw9Kzzl1Jyhp1up7xh3oni8gz7eVa4opsq35F+FmsZsecr2/102+HG
         EZsRpBHRMzEAWLBG8hWI2lb7fr9Na6BCxkUxu/TFGPjwlcIsDSHp0cU6IfGWt3IVgj1k
         3s4g==
X-Gm-Message-State: AHQUAuZeb/804/80jh8Kh7Vfxyc/6lZB13detp9umRtu+I03dyyMKdCF
        PFi5/lFj5PwjTNscAKUse7e0dw==
X-Google-Smtp-Source: AHgI3IbSK74VjJAIdyqXm8eEwYeIlvatUcPgN1jPffinXIM8wMm2lCLt+z/JOYS5n8uAwyfoUfQirA==
X-Received: by 2002:a63:c045:: with SMTP id z5mr3619267pgi.135.1549650941301;
        Fri, 08 Feb 2019 10:35:41 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id 14sm2306472pgq.22.2019.02.08.10.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:35:40 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 3/7] binder: add function to copy binder object from buffer
Date:   Fri,  8 Feb 2019 10:35:16 -0800
Message-Id: <20190208183520.30886-4-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190208183520.30886-1-tkjos@google.com>
References: <20190208183520.30886-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating or tearing down a transaction, the binder driver
examines objects in the buffer and takes appropriate action.
To do this without needing to dereference pointers into the
buffer, the local copies of the objects are needed. This patch
introduces a function to validate and copy binder objects
from the buffer to a local structure.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: remove casts as suggested by Dan Carpenter

 drivers/android/binder.c | 75 +++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 74d0c1ff874e2..8063b405e4fa1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -628,6 +628,26 @@ struct binder_transaction {
 	spinlock_t lock;
 };
 
+/**
+ * struct binder_object - union of flat binder object types
+ * @hdr:   generic object header
+ * @fbo:   binder object (nodes and refs)
+ * @fdo:   file descriptor object
+ * @bbo:   binder buffer pointer
+ * @fdao:  file descriptor array
+ *
+ * Used for type-independent object copies
+ */
+struct binder_object {
+	union {
+		struct binder_object_header hdr;
+		struct flat_binder_object fbo;
+		struct binder_fd_object fdo;
+		struct binder_buffer_object bbo;
+		struct binder_fd_array_object fdao;
+	};
+};
+
 /**
  * binder_proc_lock() - Acquire outer lock for given binder_proc
  * @proc:         struct binder_proc to acquire
@@ -2017,26 +2037,33 @@ static void binder_cleanup_transaction(struct binder_transaction *t,
 }
 
 /**
- * binder_validate_object() - checks for a valid metadata object in a buffer.
+ * binder_get_object() - gets object and checks for valid metadata
+ * @proc:	binder_proc owning the buffer
  * @buffer:	binder_buffer that we're parsing.
- * @offset:	offset in the buffer at which to validate an object.
+ * @offset:	offset in the @buffer at which to validate an object.
+ * @object:	struct binder_object to read into
  *
  * Return:	If there's a valid metadata object at @offset in @buffer, the
- *		size of that object. Otherwise, it returns zero.
+ *		size of that object. Otherwise, it returns zero. The object
+ *		is read into the struct binder_object pointed to by @object.
  */
-static size_t binder_validate_object(struct binder_buffer *buffer, u64 offset)
+static size_t binder_get_object(struct binder_proc *proc,
+				struct binder_buffer *buffer,
+				unsigned long offset,
+				struct binder_object *object)
 {
-	/* Check if we can read a header first */
+	size_t read_size;
 	struct binder_object_header *hdr;
 	size_t object_size = 0;
 
-	if (buffer->data_size < sizeof(*hdr) ||
-	    offset > buffer->data_size - sizeof(*hdr) ||
-	    !IS_ALIGNED(offset, sizeof(u32)))
+	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
+	if (read_size < sizeof(*hdr))
 		return 0;
+	binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
+				      offset, read_size);
 
-	/* Ok, now see if we can read a complete object. */
-	hdr = (struct binder_object_header *)(buffer->data + offset);
+	/* Ok, now see if we read a complete object. */
+	hdr = &object->hdr;
 	switch (hdr->type) {
 	case BINDER_TYPE_BINDER:
 	case BINDER_TYPE_WEAK_BINDER:
@@ -2245,6 +2272,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	for (offp = off_start; offp < off_end; offp++) {
 		struct binder_object_header *hdr;
 		size_t object_size;
+		struct binder_object object;
 		binder_size_t object_offset;
 		binder_size_t buffer_offset = (uintptr_t)offp -
 			(uintptr_t)buffer->data;
@@ -2252,14 +2280,14 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
 					      buffer, buffer_offset,
 					      sizeof(object_offset));
-		object_size = binder_validate_object(buffer, object_offset);
+		object_size = binder_get_object(proc, buffer,
+						object_offset, &object);
 		if (object_size == 0) {
 			pr_err("transaction release %d bad object at offset %lld, size %zd\n",
 			       debug_id, (u64)object_offset, buffer->data_size);
 			continue;
 		}
-		hdr = (struct binder_object_header *)
-			(buffer->data + object_offset);
+		hdr = &object.hdr;
 		switch (hdr->type) {
 		case BINDER_TYPE_BINDER:
 		case BINDER_TYPE_WEAK_BINDER: {
@@ -3159,6 +3187,7 @@ static void binder_transaction(struct binder_proc *proc,
 	for (; offp < off_end; offp++) {
 		struct binder_object_header *hdr;
 		size_t object_size;
+		struct binder_object object;
 		binder_size_t object_offset;
 		binder_size_t buffer_offset =
 			(uintptr_t)offp - (uintptr_t)t->buffer->data;
@@ -3168,7 +3197,8 @@ static void binder_transaction(struct binder_proc *proc,
 					      t->buffer,
 					      buffer_offset,
 					      sizeof(object_offset));
-		object_size = binder_validate_object(t->buffer, object_offset);
+		object_size = binder_get_object(target_proc, t->buffer,
+						object_offset, &object);
 		if (object_size == 0 || object_offset < off_min) {
 			binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
 					  proc->pid, thread->pid,
@@ -3181,8 +3211,7 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_bad_offset;
 		}
 
-		hdr = (struct binder_object_header *)
-			(t->buffer->data + object_offset);
+		hdr = &object.hdr;
 		off_min = object_offset + object_size;
 		switch (hdr->type) {
 		case BINDER_TYPE_BINDER:
@@ -3197,6 +3226,9 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    fp, sizeof(*fp));
 		} break;
 		case BINDER_TYPE_HANDLE:
 		case BINDER_TYPE_WEAK_HANDLE: {
@@ -3210,6 +3242,9 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    fp, sizeof(*fp));
 		} break;
 
 		case BINDER_TYPE_FD: {
@@ -3226,6 +3261,9 @@ static void binder_transaction(struct binder_proc *proc,
 				goto err_translate_failed;
 			}
 			fp->pad_binder = 0;
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    fp, sizeof(*fp));
 		} break;
 		case BINDER_TYPE_FDA: {
 			struct binder_fd_array_object *fda =
@@ -3310,7 +3348,10 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
-			last_fixup_obj = bp;
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    bp, sizeof(*bp));
+			last_fixup_obj = t->buffer->data + object_offset;
 			last_fixup_min_off = 0;
 		} break;
 		default:
-- 
2.20.1.791.gb4d0f1c61a-goog

