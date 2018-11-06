Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D7AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADB120844
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="n2aF9W7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADB120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbeKGJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:23:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36162 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbeKGJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:23:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so6977753plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=La2xAe9jd3uC28Fhz2DfVrF3HqHgtVXfdg5RQNp/Bkw=;
        b=n2aF9W7y4wYMFQYWfd/NikkJ2CPl2/+c+jpmUpwLyL5SPpiEcyAblE96uC18H/O/Mi
         9M0h26n4NsXxznUy2gDIC0gYRjUFDv7jTp0PnQKRBoUiLIwqf22BXy8hYUwM94BWNJX/
         cVuuObOz17c18PDZ3aJ7d/yMnURFha6zqg+W8MLLt7bEysFMOhUcLevzIuOclwyKMGlf
         cs96p7/9r+tlTfBGEzVxrIvThS6RRYW3iliVqRnd/3Fw+q9r3CnU5kkgczyd85u+DLkP
         f494vWHy5gP4wSzgWMPZZnSVFOeu6K3gZLCVaCXG7crqApNPH70Mohrttxlo/gTe2u1N
         kPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=La2xAe9jd3uC28Fhz2DfVrF3HqHgtVXfdg5RQNp/Bkw=;
        b=gdqyhHjy/dSvncD4TVg0QTTW3TU5de0glZrA/0cOXoQvd/6zmH3Yg0aZIjZFraUj/J
         YbKUVfCEGPgpS+XvhABQGsVU4CXq6aZ8UHRs89OdgX2GassIokCNBuUZGtxvEL23Vw6f
         eukW5iuj07XhLUPA6Yi4fQBk7SVYOTJgT2Ldtw+JkZT70xHn3EBqyYqiqaEJ+B9/I25T
         z2MPPtb86MtsxAJoWvIUhblAT+xBIkVxhSTv4o2S9X8NBjFjYty2nbpJFmVrI4vOGDSH
         YjIuiMmWn5tB5a2HNiz7jVDiyx7HsRiV354hlRnB4R8SVby6FVBwj9H3FxXm1JaJb4Hh
         dzbg==
X-Gm-Message-State: AGRZ1gKiuwrPQpVQtDGNWGJcIhvAWH5sIeaSrrQgLV3Fiz1zMxPww0/M
        rENVq354qkICIEWUfWd15lGluA==
X-Google-Smtp-Source: AJdET5fSiNvy1o0+MD2B3EZ8Rc2mLbyg3S84t+CElnCC43FqPfzRKM8t1MfyWhO5NOSvaZm8XL+xEQ==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr20093798pls.137.1541548550077;
        Tue, 06 Nov 2018 15:55:50 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:f5a1:2b8d:9c84:99b])
        by smtp.googlemail.com with ESMTPSA id p62-v6sm67287329pfp.111.2018.11.06.15.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 15:55:49 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, stable@vger.kernel.org
Cc:     kernel-team@android.com
Subject: [PATCH] binder: fix race that allows malicious free of live buffer
Date:   Tue,  6 Nov 2018 15:55:32 -0800
Message-Id: <20181106235532.171646-1-tkjos@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Malicious code can attempt to free buffers using the
BC_FREE_BUFFER ioctl to binder. There are protections
against a user freeing a buffer while in use by the
kernel, however there was a window where BC_FREE_BUFFER
could be used to free a recently allocated buffer that
was not completely initialized. This resulted in a
use-after-free detected by KASAN with a malicious
test program.

This window is closed by setting the buffer's
allow_user_free attribute to 0 when the buffer
is allocated or when the user has previously
freed it instead of waiting for the caller
to set it. The problem was that when the struct
buffer was recycled, allow_user_free was stale
and set to 1 allowing a free to go through.

Signed-off-by: Todd Kjos <tkjos@google.com>
Acked-by: Arve Hjønnevåg <arve@android.com>
---
 drivers/android/binder.c       | 21 ++++++++++++---------
 drivers/android/binder_alloc.c | 16 ++++++----------
 drivers/android/binder_alloc.h |  3 +--
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cb30a524d16d8..9f1000d2a40c7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2974,7 +2974,6 @@ static void binder_transaction(struct binder_proc *proc,
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
-	t->buffer->allow_user_free = 0;
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
 	t->buffer->target_node = target_node;
@@ -3510,14 +3509,18 @@ static int binder_thread_write(struct binder_proc *proc,
 
 			buffer = binder_alloc_prepare_to_free(&proc->alloc,
 							      data_ptr);
-			if (buffer == NULL) {
-				binder_user_error("%d:%d BC_FREE_BUFFER u%016llx no match\n",
-					proc->pid, thread->pid, (u64)data_ptr);
-				break;
-			}
-			if (!buffer->allow_user_free) {
-				binder_user_error("%d:%d BC_FREE_BUFFER u%016llx matched unreturned buffer\n",
-					proc->pid, thread->pid, (u64)data_ptr);
+			if (IS_ERR_OR_NULL(buffer)) {
+				if (PTR_ERR(buffer) == -EPERM) {
+					binder_user_error(
+						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
+						proc->pid, thread->pid,
+						(u64)data_ptr);
+				} else {
+					binder_user_error(
+						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
+						proc->pid, thread->pid,
+						(u64)data_ptr);
+				}
 				break;
 			}
 			binder_debug(BINDER_DEBUG_FREE_BUFFER,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 64fd96eada31f..030c98f35cca7 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -151,16 +151,12 @@ static struct binder_buffer *binder_alloc_prepare_to_free_locked(
 		else {
 			/*
 			 * Guard against user threads attempting to
-			 * free the buffer twice
+			 * free the buffer when in use by kernel or
+			 * after it's already been freed.
 			 */
-			if (buffer->free_in_progress) {
-				binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
-						   "%d:%d FREE_BUFFER u%016llx user freed buffer twice\n",
-						   alloc->pid, current->pid,
-						   (u64)user_ptr);
-				return NULL;
-			}
-			buffer->free_in_progress = 1;
+			if (!buffer->allow_user_free)
+				return ERR_PTR(-EPERM);
+			buffer->allow_user_free = 0;
 			return buffer;
 		}
 	}
@@ -500,7 +496,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 
 	rb_erase(best_fit, &alloc->free_buffers);
 	buffer->free = 0;
-	buffer->free_in_progress = 0;
+	buffer->allow_user_free = 0;
 	binder_insert_allocated_buffer_locked(alloc, buffer);
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 		     "%d: binder_alloc_buf size %zd got %pK\n",
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 9ef64e5638566..fb3238c74c8a8 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -50,8 +50,7 @@ struct binder_buffer {
 	unsigned free:1;
 	unsigned allow_user_free:1;
 	unsigned async_transaction:1;
-	unsigned free_in_progress:1;
-	unsigned debug_id:28;
+	unsigned debug_id:29;
 
 	struct binder_transaction *transaction;
 
-- 
2.19.1.930.g4563a0d9d0-goog

