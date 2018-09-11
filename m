Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2231C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31112086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31112086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIKSlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:41:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbeIKSlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B9098011309;
        Tue, 11 Sep 2018 13:42:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECDA6B27B2;
        Tue, 11 Sep 2018 13:42:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9093B9A98; Tue, 11 Sep 2018 15:42:17 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 13/13] udmabuf: add documentation
Date:   Tue, 11 Sep 2018 15:42:16 +0200
Message-Id: <20180911134216.9760-14-kraxel@redhat.com>
In-Reply-To: <20180911134216.9760-1-kraxel@redhat.com>
References: <20180911134216.9760-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 13:42:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 13:42:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/udmabuf.h         | 50 +++++++++++++++++++++++++++++++++---
 Documentation/driver-api/dma-buf.rst |  8 ++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
index 46b6532ed8..f30b37cb5c 100644
--- a/include/uapi/linux/udmabuf.h
+++ b/include/uapi/linux/udmabuf.h
@@ -5,8 +5,38 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+/**
+ * DOC: udmabuf
+ *
+ * udmabuf is a device driver which allows userspace create dmabufs.
+ * The memory used for these dmabufs must be backed by memfd.  The
+ * memfd must have F_SEAL_SHRINK and it must not have F_SEAL_WRITE.
+ *
+ * The driver has two ioctls, one to create a dmabuf from a single
+ * memory block and one to create a dmabuf from a list of memory
+ * blocks.
+ *
+ * UDMABUF_CREATE - _IOW('u', 0x42, udmabuf_create)
+ *
+ * UDMABUF_CREATE_LIST - _IOW('u', 0x43, udmabuf_create_list)
+ */
+
+#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
+#define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct udmabuf_create_list)
+
 #define UDMABUF_FLAGS_CLOEXEC	0x01
 
+/**
+ * struct udmabuf_create - create a dmabuf from a single memory block.
+ *
+ * @memfd: The file handle.
+ * @offset: Start of the buffer (from memfd start).
+ * Must be page aligned.
+ * @size: Size of the buffer.  Must be rounded to page size.
+ *
+ * flags:
+ * UDMABUF_FLAGS_CLOEXEC: set CLOEXEC flag for the dmabuf.
+ */
 struct udmabuf_create {
 	__u32 memfd;
 	__u32 flags;
@@ -14,6 +44,14 @@ struct udmabuf_create {
 	__u64 size;
 };
 
+/**
+ * struct udmabuf_create_item - one memory block list item.
+ *
+ * @memfd: The file handle.
+ * @offset: Start of the buffer (from memfd start).
+ * Must be page aligned.
+ * @size: Size of the buffer.  Must be rounded to page size.
+ */
 struct udmabuf_create_item {
 	__u32 memfd;
 	__u32 __pad;
@@ -21,13 +59,19 @@ struct udmabuf_create_item {
 	__u64 size;
 };
 
+/**
+ * struct udmabuf_create_list - create a dmabuf from a memory block list.
+ *
+ * @count: The number of list elements.
+ * @list: The memory block list
+ *
+ * flags:
+ * UDMABUF_FLAGS_CLOEXEC: set CLOEXEC flag for the dmabuf.
+ */
 struct udmabuf_create_list {
 	__u32 flags;
 	__u32 count;
 	struct udmabuf_create_item list[];
 };
 
-#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
-#define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct udmabuf_create_list)
-
 #endif /* _UAPI_LINUX_UDMABUF_H */
diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index b541e97c7a..1f62c30a14 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -166,3 +166,11 @@ DMA Fence uABI/Sync File
 .. kernel-doc:: include/linux/sync_file.h
    :internal:
 
+Userspace DMA Buffer driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/uapi/linux/udmabuf.h
+   :doc: udmabuf
+
+.. kernel-doc:: include/uapi/linux/udmabuf.h
+   :internal:
-- 
2.9.3

