Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4828AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1D62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTag1MVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1D62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbeLKDlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:41:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeLKDlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:41:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so6271430plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 19:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKJ9xf2ILUGJH+ywFCoQ7Nrx2kVd2JlxIygL+/0se3M=;
        b=kTag1MVbGzjixa7omg5YthKphxlGfMFyrYvyohmPoJLGKgeCzOsVwSVIwZ7+K4ES1F
         RmbZURdu71Xjv9KI3TqDFlxmL7cENhzh3+Q/h5oXN0pj2bHfOVxhyfY0+4uAhAev+FAp
         uXLtx5pyWEHo4qD8dEyAJEwSblM/dZmSR5ERM6Yu/gu5ijrjXf5ijob2OvL5FbAA072M
         NI8598V33cs6UxkBgJglPV0WS5oU2MbR0GXS6ENYodf+Ot+yQlmXBenKTX/jgBsvHDDj
         kuJ/XBRArFDzzu40LDG5z+9IK4IaZmzj7+lPZAl5mXCuoWK9zfhFVxGlzeouV9PB3ObM
         mbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKJ9xf2ILUGJH+ywFCoQ7Nrx2kVd2JlxIygL+/0se3M=;
        b=rqGhAddPgTr7VSHa9CAkS4iDZUYyqsPU46xLyHQce2AkTOK9nwtTZwTNnRwfsyux4T
         iqgCZLx7gUWf63KQII/+EekSXBacIcLQtLBBxONmCxT/4PSSDPo1Yj7gmV/RuxvkE1qa
         R1sWyFHnmluugqaWbJCP3bW04qE1olM+Rn8jLayaeRdw1U/g4U/8efJhmO8Ab02ckvR0
         x5/bQlwP9El60bJHe9C4B+WsXkn9r4qgIm3acAmwqvVeK3ieto6JvnxKjtXd6RZhHUTv
         7GOa/pHi/9mZcNJ+aXvt8uOCdYu4YwPbk1pP1lptTkqIak7F2R3spu8vhS8mafrnbQM9
         qceA==
X-Gm-Message-State: AA+aEWb9IfwT2cHLrjYIPraRF1kg842xVBVj6yyAsPF0S5SUlCWrT4wc
        Z4vZFlx4pSDr9PPlxugz5FM=
X-Google-Smtp-Source: AFSGD/UYqBTfZ0/tx4XiSW4f20+CEzWhDqDagxUKhx8HbeMc04jIXaX/MiuhJHspUspxB1WyyyWRGw==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr14463219plq.139.1544499662265;
        Mon, 10 Dec 2018 19:41:02 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.52])
        by smtp.gmail.com with ESMTPSA id p2sm19271689pgc.94.2018.12.10.19.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 19:41:01 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     keescook@chromium.org, mkelly@xevo.com, jkosina@suse.cz
Cc:     linux-kernel@vger.kernel.org,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Guangrong Xiao <xiaoguangrong@tencent.com>
Subject: [PATCH] kfifo: add memory barrier in kfifo to prevent data loss
Date:   Tue, 11 Dec 2018 11:40:32 +0800
Message-Id: <20181211034032.32338-1-yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Early this year we spot there may be two issues in kernel
kfifo.

One is reported by Xiao Guangrong to linux kernel.
https://lkml.org/lkml/2018/5/11/58
In current kfifo implementation there are missing memory
barrier in the read side, so that without proper barrier
between reading the kfifo->in and fetching the data there
is potential ordering issue.

Beside that, there is another potential issue in kfifo,
please consider the following case:
at the beginning
ring->size = 4
ring->out = 0
ring->in = 4

    Consumer                        Producer
---------------                  --------------
index = ring->out; /* index == 0 */
ring->out++; /* ring->out == 1 */
< Re-Order >
                                 out = ring->out;
                                 if (ring->in - out >= ring->mask)
                                     return -EFULL;
                                 /* see the ring is not full */
                                 index = ring->in & ring->mask;
                                 /* index == 0 */
                                 ring->data[index] = new_data;
　　　　　　　　　　 　　　　　　ring->in++;

data = ring->data[index];
/* you will find the old data is overwritten by the new_data */

In order to avoid the issue:
1) for the consumer, we should read the ring->data[] out before
updating ring->out
2) for the producer, we should read ring->out before updating
ring->data[]

So in this patch we introduce the following four functions which
are wrapped with proper memory barrier and keep in pairs to make
sure the in and out index are fetched and updated in order to avoid
data loss.

kfifo_read_index_in()
kfifo_write_index_in()
kfifo_read_index_out()
kfifo_write_index_out()

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
Signed-off-by: Guangrong Xiao <xiaoguangrong@tencent.com>
---
 include/linux/kfifo.h |  70 ++++++++++++++++++++++++++-
 lib/kfifo.c           | 107 +++++++++++++++++++++++++++---------------
 2 files changed, 136 insertions(+), 41 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 89fc8dc7bf38..3bd2a869ca7e 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -286,6 +286,71 @@ __kfifo_uint_must_check_helper( \
 }) \
 )
 
+/**
+ * kfifo_read_index_in - returns the in index of the fifo
+ * @fifo: address of the kfifo to be used
+ *
+ * add memory read barrier to make sure the fifo->in index
+ * is fetched first before write data to the fifo, which
+ * is paired with the write barrier in kfifo_write_index_in
+ */
+#define kfifo_read_index_in(kfifo) \
+({ \
+	typeof((kfifo) + 1) __tmp = (kfifo); \
+	struct __kfifo *__kfifo = __tmp; \
+	unsigned int __val = READ_ONCE(__kfifo->in); \
+	smp_rmb(); \
+	__val; \
+})
+
+/**
+ * kfifo_write_index_in - updates the in index of the fifo
+ * @fifo: address of the kfifo to be used
+ *
+ * add memory write barrier to make sure the data entry is
+ * updated before increase the fifo->in
+ */
+#define kfifo_write_index_in(kfifo, val) \
+({ \
+	typeof((kfifo) + 1) __tmp = (kfifo); \
+	struct __kfifo *__kfifo = __tmp; \
+	unsigned int __val = (val); \
+	smp_wmb(); \
+	WRITE_ONCE(__kfifo->in, __val); \
+})
+
+/**
+ * kfifo_read_index_out - returns the out index of the fifo
+ * @fifo: address of the kfifo to be used
+ *
+ * add memory barrier to make sure the fifo->out index is
+ * fetched before read data from the fifo, which is paired
+ * with the memory barrier in kfifo_write_index_out
+ */
+#define kfifo_read_index_out(kfifo) \
+({ \
+	typeof((kfifo) + 1) __tmp = (kfifo); \
+	struct __kfifo *__kfifo = __tmp; \
+	unsigned int __val = smp_load_acquire(&__kfifo->out); \
+	__val; \
+})
+
+/**
+ * kfifo_write_index_out - updates the out index of the fifo
+ * @fifo: address of the kfifo to be used
+ *
+ * add memory barrier to make sure reading out the entry before
+ * update the fifo->out index to avoid overwitten the entry by
+ * the producer
+ */
+#define kfifo_write_index_out(kfifo, val) \
+({ \
+	typeof((kfifo) + 1) __tmp = (kfifo); \
+	struct __kfifo *__kfifo = __tmp; \
+	unsigned int __val = (val); \
+	smp_store_release(&__kfifo->out, __val); \
+})
+
 /**
  * kfifo_skip - skip output data
  * @fifo: address of the fifo to be used
@@ -298,7 +363,7 @@ __kfifo_uint_must_check_helper( \
 	if (__recsize) \
 		__kfifo_skip_r(__kfifo, __recsize); \
 	else \
-		__kfifo->out++; \
+		kfifo_write_index_out(__kfifo, __kfifo->out++); \
 })
 
 /**
@@ -740,7 +805,8 @@ __kfifo_uint_must_check_helper( \
 	if (__recsize) \
 		__kfifo_dma_out_finish_r(__kfifo, __recsize); \
 	else \
-		__kfifo->out += __len / sizeof(*__tmp->type); \
+		kfifo_write_index_out(__kfifo, __kfifo->out \
+				+ (__len / sizeof(*__tmp->type))); \
 })
 
 /**
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 015656aa8182..189590d9d614 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -32,7 +32,12 @@
  */
 static inline unsigned int kfifo_unused(struct __kfifo *fifo)
 {
-	return (fifo->mask + 1) - (fifo->in - fifo->out);
+	/*
+	 * add memory barrier to make sure the index is fetched
+	 * before write to the buffer
+	 */
+	return (fifo->mask + 1) -
+		(fifo->in - kfifo_read_index_out(fifo));
 }
 
 int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
@@ -116,11 +121,6 @@ static void kfifo_copy_in(struct __kfifo *fifo, const void *src,
 
 	memcpy(fifo->data + off, src, l);
 	memcpy(fifo->data, src + l, len - l);
-	/*
-	 * make sure that the data in the fifo is up to date before
-	 * incrementing the fifo->in index counter
-	 */
-	smp_wmb();
 }
 
 unsigned int __kfifo_in(struct __kfifo *fifo,
@@ -133,7 +133,11 @@ unsigned int __kfifo_in(struct __kfifo *fifo,
 		len = l;
 
 	kfifo_copy_in(fifo, buf, len, fifo->in);
-	fifo->in += len;
+	/*
+	 * make sure that the data in the fifo is up to date before
+	 * incrementing the fifo->in index counter
+	 */
+	kfifo_write_index_in(fifo, fifo->in + len);
 	return len;
 }
 EXPORT_SYMBOL(__kfifo_in);
@@ -155,11 +159,6 @@ static void kfifo_copy_out(struct __kfifo *fifo, void *dst,
 
 	memcpy(dst, fifo->data + off, l);
 	memcpy(dst + l, fifo->data, len - l);
-	/*
-	 * make sure that the data is copied before
-	 * incrementing the fifo->out index counter
-	 */
-	smp_wmb();
 }
 
 unsigned int __kfifo_out_peek(struct __kfifo *fifo,
@@ -167,7 +166,7 @@ unsigned int __kfifo_out_peek(struct __kfifo *fifo,
 {
 	unsigned int l;
 
-	l = fifo->in - fifo->out;
+	l = kfifo_read_index_in(fifo) - fifo->out;
 	if (len > l)
 		len = l;
 
@@ -180,7 +179,11 @@ unsigned int __kfifo_out(struct __kfifo *fifo,
 		void *buf, unsigned int len)
 {
 	len = __kfifo_out_peek(fifo, buf, len);
-	fifo->out += len;
+	/*
+	 * make sure that the data in the fifo is fetched before
+	 * incrementing the fifo->out index counter
+	 */
+	kfifo_write_index_out(fifo, fifo->out + len);
 	return len;
 }
 EXPORT_SYMBOL(__kfifo_out);
@@ -210,11 +213,6 @@ static unsigned long kfifo_copy_from_user(struct __kfifo *fifo,
 		if (unlikely(ret))
 			ret = DIV_ROUND_UP(ret, esize);
 	}
-	/*
-	 * make sure that the data in the fifo is up to date before
-	 * incrementing the fifo->in index counter
-	 */
-	smp_wmb();
 	*copied = len - ret * esize;
 	/* return the number of elements which are not copied */
 	return ret;
@@ -241,7 +239,11 @@ int __kfifo_from_user(struct __kfifo *fifo, const void __user *from,
 		err = -EFAULT;
 	} else
 		err = 0;
-	fifo->in += len;
+	/*
+	 * make sure that the data in the fifo is up to date before
+	 * incrementing the fifo->in index counter
+	 */
+	kfifo_write_index_in(fifo, fifo->in + len);
 	return err;
 }
 EXPORT_SYMBOL(__kfifo_from_user);
@@ -270,11 +272,6 @@ static unsigned long kfifo_copy_to_user(struct __kfifo *fifo, void __user *to,
 		if (unlikely(ret))
 			ret = DIV_ROUND_UP(ret, esize);
 	}
-	/*
-	 * make sure that the data is copied before
-	 * incrementing the fifo->out index counter
-	 */
-	smp_wmb();
 	*copied = len - ret * esize;
 	/* return the number of elements which are not copied */
 	return ret;
@@ -291,7 +288,7 @@ int __kfifo_to_user(struct __kfifo *fifo, void __user *to,
 	if (esize != 1)
 		len /= esize;
 
-	l = fifo->in - fifo->out;
+	l = kfifo_read_index_in(fifo) - fifo->out;
 	if (len > l)
 		len = l;
 	ret = kfifo_copy_to_user(fifo, to, len, fifo->out, copied);
@@ -300,7 +297,11 @@ int __kfifo_to_user(struct __kfifo *fifo, void __user *to,
 		err = -EFAULT;
 	} else
 		err = 0;
-	fifo->out += len;
+	/*
+	 * make sure that the data is copied before
+	 * incrementing the fifo->out index counter
+	 */
+	kfifo_write_index_out(fifo, fifo->out + len);
 	return err;
 }
 EXPORT_SYMBOL(__kfifo_to_user);
@@ -384,7 +385,7 @@ unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
 {
 	unsigned int l;
 
-	l = fifo->in - fifo->out;
+	l = kfifo_read_index_in(fifo) - fifo->out;
 	if (len > l)
 		len = l;
 
@@ -457,7 +458,11 @@ unsigned int __kfifo_in_r(struct __kfifo *fifo, const void *buf,
 	__kfifo_poke_n(fifo, len, recsize);
 
 	kfifo_copy_in(fifo, buf, len, fifo->in + recsize);
-	fifo->in += len + recsize;
+	/*
+	 * make sure that the data in the fifo is up to date before
+	 * incrementing the fifo->in index counter
+	 */
+	kfifo_write_index_in(fifo, fifo->in + len + recsize);
 	return len;
 }
 EXPORT_SYMBOL(__kfifo_in_r);
@@ -479,7 +484,7 @@ unsigned int __kfifo_out_peek_r(struct __kfifo *fifo, void *buf,
 {
 	unsigned int n;
 
-	if (fifo->in == fifo->out)
+	if (kfifo_read_index_in(fifo) == fifo->out)
 		return 0;
 
 	return kfifo_out_copy_r(fifo, buf, len, recsize, &n);
@@ -491,11 +496,15 @@ unsigned int __kfifo_out_r(struct __kfifo *fifo, void *buf,
 {
 	unsigned int n;
 
-	if (fifo->in == fifo->out)
+	if (kfifo_read_index_in(fifo) == fifo->out)
 		return 0;
 
 	len = kfifo_out_copy_r(fifo, buf, len, recsize, &n);
-	fifo->out += n + recsize;
+	/*
+	 * make sure that the fifo data is fetched before
+	 * incrementing the fifo->out index counter
+	 */
+	kfifo_write_index_out(fifo, fifo->out + n + recsize);
 	return len;
 }
 EXPORT_SYMBOL(__kfifo_out_r);
@@ -505,7 +514,11 @@ void __kfifo_skip_r(struct __kfifo *fifo, size_t recsize)
 	unsigned int n;
 
 	n = __kfifo_peek_n(fifo, recsize);
-	fifo->out += n + recsize;
+	/*
+	 * make sure that the fifo data is fetched before
+	 * incrementing the fifo->out index counter
+	 */
+	kfifo_write_index_out(fifo, fifo->out + n + recsize);
 }
 EXPORT_SYMBOL(__kfifo_skip_r);
 
@@ -528,7 +541,11 @@ int __kfifo_from_user_r(struct __kfifo *fifo, const void __user *from,
 		*copied = 0;
 		return -EFAULT;
 	}
-	fifo->in += len + recsize;
+	/*
+	 * make sure that the data in the fifo is up to date before
+	 * incrementing the fifo->in index counter
+	 */
+	kfifo_write_index_in(fifo, fifo->in + len + recsize);
 	return 0;
 }
 EXPORT_SYMBOL(__kfifo_from_user_r);
@@ -539,7 +556,7 @@ int __kfifo_to_user_r(struct __kfifo *fifo, void __user *to,
 	unsigned long ret;
 	unsigned int n;
 
-	if (fifo->in == fifo->out) {
+	if (kfifo_read_index_in(fifo) == fifo->out) {
 		*copied = 0;
 		return 0;
 	}
@@ -553,7 +570,11 @@ int __kfifo_to_user_r(struct __kfifo *fifo, void __user *to,
 		*copied = 0;
 		return -EFAULT;
 	}
-	fifo->out += n + recsize;
+	/*
+	 * make sure that the data is copied before
+	 * incrementing the fifo->out index counter
+	 */
+	kfifo_write_index_out(fifo, fifo->out + n + recsize);
 	return 0;
 }
 EXPORT_SYMBOL(__kfifo_to_user_r);
@@ -577,7 +598,11 @@ void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
 {
 	len = __kfifo_max_r(len, recsize);
 	__kfifo_poke_n(fifo, len, recsize);
-	fifo->in += len + recsize;
+	/*
+	 * make sure that the data in the fifo is updated before
+	 * incrementing the fifo->in index counter
+	 */
+	kfifo_write_index_in(fifo, fifo->in + len + recsize);
 }
 EXPORT_SYMBOL(__kfifo_dma_in_finish_r);
 
@@ -588,7 +613,7 @@ unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
 
 	len = __kfifo_max_r(len, recsize);
 
-	if (len + recsize > fifo->in - fifo->out)
+	if (len + recsize > kfifo_read_index_in(fifo) - fifo->out)
 		return 0;
 
 	return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize);
@@ -600,6 +625,10 @@ void __kfifo_dma_out_finish_r(struct __kfifo *fifo, size_t recsize)
 	unsigned int len;
 
 	len = __kfifo_peek_n(fifo, recsize);
-	fifo->out += len + recsize;
+	/*
+	 * make sure that the data is copied before
+	 * incrementing the fifo->out index counter
+	 */
+	kfifo_write_index_out(fifo, fifo->out + len + recsize);
 }
 EXPORT_SYMBOL(__kfifo_dma_out_finish_r);
-- 
2.17.1

