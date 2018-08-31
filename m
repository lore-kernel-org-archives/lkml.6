Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D62083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="PzAZwZFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6D62083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIAAhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:37:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37426 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIAAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:37:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so6013469pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxIgAJ16plxxWowU0cf0B+bi/LotX1IMoVF01R874jk=;
        b=PzAZwZFFcJhvP6UTcfsInRYIxpYwpnW0RijymUqBh0+NIuCH3BqSDgC4P/YHOe4AVg
         XH4y5KMIGgpJj85VikSY50vYa8BqtaV8y7t1MavMcj3kpmotzUzQ+65tAO4KuEpNxSDv
         Kjvyxc4wMf5So+vCG6O0no3yf5n6l6QfV1Bakx9yuMPPj+f/lNw+6RiyFN6lDMJMHOBa
         aFhdI1pO16m9mLXiISqzbfwTwm5mF5E8+BJoWuVq/o2txJmWJY/6DukAWnfF7O26Kt43
         sDWM84YdpjAkFTPmK3/TTTElEF7TvkRKGHEsSzJQ89Som1pVuoHZCGp5Ltm1y2nM5atL
         RRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxIgAJ16plxxWowU0cf0B+bi/LotX1IMoVF01R874jk=;
        b=PBHOmnB4Yt7j/bn8EjzAMXHIy+6GosqNYZ7XjfWCz5wEDbCXRGCWYo238rsWSI6yMf
         LHqiI0I/cZ+GKfg0yyUg7sG0qHRJdOmQEEqbpZsHRlyra7xz1QX19w+vrvc9kdCMdnyb
         +2R3fj4g5xM2QAeeEb+8poZVqUhTpzV3B84vL/OCSXt/97/HPEpda524YhyP5nj/axeq
         lnj78hZg8YM5pJSRCYqJAbe9CU6LW/7kIxu7etAixi1JxdeQ6oTuNFAfpUCCdr2X28d9
         reg64RkB4glGDG/2iBs9O/6sWm3oCibpVYhBHtdliJ3QVgscLiEI+AWI1DlS8tCxPftn
         5eIg==
X-Gm-Message-State: APzg51D/zWrg5tITkW3CHYCByimubbIAzvnziIOUszurDsImHGVBexqi
        WXuOBeh4a93TL1hnVK0MxixpN3Cwl/I=
X-Google-Smtp-Source: ANB0Vdb8zLJayDWQoL7rukNO1A/h9xxEJFor3hX/C2ZxjCneJlAtwA7SBnOXX6zxaYFFTUDD+tocXQ==
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr17642752pff.199.1535747284895;
        Fri, 31 Aug 2018 13:28:04 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id f75-v6sm20054786pfk.85.2018.08.31.13.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:28:04 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: [PATCH] staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free
Date:   Fri, 31 Aug 2018 13:27:38 -0700
Message-Id: <20180831202738.78559-1-ghackmann@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
In-Reply-To: <20180831202250.GB30176@kroah.com>
References: <20180831202250.GB30176@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ION_IOC_{MAP,SHARE} ioctls drop and reacquire client->lock several
times while operating on one of the client's ion_handles.  This creates
windows where userspace can call ION_IOC_FREE on the same client with
the same handle, and effectively make the kernel drop its own reference.
For example:

- thread A: ION_IOC_ALLOC creates an ion_handle with refcount 1
- thread A: starts ION_IOC_MAP and increments the refcount to 2
- thread B: ION_IOC_FREE decrements the refcount to 1
- thread B: ION_IOC_FREE decrements the refcount to 0 and frees the
            handle
- thread A: continues ION_IOC_MAP with a dangling ion_handle * to
            freed memory

Fix this by holding client->lock for the duration of
ION_IOC_{MAP,SHARE}, preventing the concurrent ION_IOC_FREE.  Also
remove ion_handle_get_by_id(), since there's literally no way to use it
safely.

This patch is applied on top of 4.4.y, and applies to older kernels
too.  4.9.y was fixed separately.  Kernels 4.12 and later are
unaffected, since all the underlying ion_handle infrastructure has been
ripped out.

Change-Id: Ia0542dd8134e81cd5e1412e126545303c766f738
Cc: stable@vger.kernel.org # v4.4-
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 drivers/staging/android/ion/ion.c | 60 +++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 47cb163da9a0..4adb1138af09 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -449,18 +449,6 @@ static struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
 	return ERR_PTR(-EINVAL);
 }
 
-struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
-						int id)
-{
-	struct ion_handle *handle;
-
-	mutex_lock(&client->lock);
-	handle = ion_handle_get_by_id_nolock(client, id);
-	mutex_unlock(&client->lock);
-
-	return handle;
-}
-
 static bool ion_handle_validate(struct ion_client *client,
 				struct ion_handle *handle)
 {
@@ -1138,24 +1126,28 @@ static struct dma_buf_ops dma_buf_ops = {
 	.kunmap = ion_dma_buf_kunmap,
 };
 
-struct dma_buf *ion_share_dma_buf(struct ion_client *client,
-						struct ion_handle *handle)
+static struct dma_buf *__ion_share_dma_buf(struct ion_client *client,
+					   struct ion_handle *handle,
+					   bool lock_client)
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct ion_buffer *buffer;
 	struct dma_buf *dmabuf;
 	bool valid_handle;
 
-	mutex_lock(&client->lock);
+	if (lock_client)
+		mutex_lock(&client->lock);
 	valid_handle = ion_handle_validate(client, handle);
 	if (!valid_handle) {
 		WARN(1, "%s: invalid handle passed to share.\n", __func__);
-		mutex_unlock(&client->lock);
+		if (lock_client)
+			mutex_unlock(&client->lock);
 		return ERR_PTR(-EINVAL);
 	}
 	buffer = handle->buffer;
 	ion_buffer_get(buffer);
-	mutex_unlock(&client->lock);
+	if (lock_client)
+		mutex_unlock(&client->lock);
 
 	exp_info.ops = &dma_buf_ops;
 	exp_info.size = buffer->size;
@@ -1170,14 +1162,21 @@ struct dma_buf *ion_share_dma_buf(struct ion_client *client,
 
 	return dmabuf;
 }
+
+struct dma_buf *ion_share_dma_buf(struct ion_client *client,
+				  struct ion_handle *handle)
+{
+	return __ion_share_dma_buf(client, handle, true);
+}
 EXPORT_SYMBOL(ion_share_dma_buf);
 
-int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
+static int __ion_share_dma_buf_fd(struct ion_client *client,
+				  struct ion_handle *handle, bool lock_client)
 {
 	struct dma_buf *dmabuf;
 	int fd;
 
-	dmabuf = ion_share_dma_buf(client, handle);
+	dmabuf = __ion_share_dma_buf(client, handle, lock_client);
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
 
@@ -1187,8 +1186,19 @@ int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
 
 	return fd;
 }
+
+int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
+{
+	return __ion_share_dma_buf_fd(client, handle, true);
+}
 EXPORT_SYMBOL(ion_share_dma_buf_fd);
 
+static int ion_share_dma_buf_fd_nolock(struct ion_client *client,
+				       struct ion_handle *handle)
+{
+	return __ion_share_dma_buf_fd(client, handle, false);
+}
+
 struct ion_handle *ion_import_dma_buf(struct ion_client *client, int fd)
 {
 	struct dma_buf *dmabuf;
@@ -1335,11 +1345,15 @@ static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	{
 		struct ion_handle *handle;
 
-		handle = ion_handle_get_by_id(client, data.handle.handle);
-		if (IS_ERR(handle))
+		mutex_lock(&client->lock);
+		handle = ion_handle_get_by_id_nolock(client, data.handle.handle);
+		if (IS_ERR(handle)) {
+			mutex_unlock(&client->lock);
 			return PTR_ERR(handle);
-		data.fd.fd = ion_share_dma_buf_fd(client, handle);
-		ion_handle_put(handle);
+		}
+		data.fd.fd = ion_share_dma_buf_fd_nolock(client, handle);
+		ion_handle_put_nolock(handle);
+		mutex_unlock(&client->lock);
 		if (data.fd.fd < 0)
 			ret = data.fd.fd;
 		break;
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

