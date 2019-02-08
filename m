Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6CA217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0G+j2co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfBHNXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:23:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfBHNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:23:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so3373439wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21c9Dq6cDivZ+JoJgFAUaSKmMpkUoOCwsc5GtAeNigY=;
        b=q0G+j2coygYMPMuxaATAa8qRPm4Ws++muoIq9rwZ8TRBV/6jzVU8qxDsMfHEd/fjnL
         yAmzdze0hZQXd2iqp/ENKU5wiCh3tBnPEuqiR82z7HZHyxqjuM7gDIjJvNvQvNbU2FyD
         mnpPraTnZs/W+05ue4jz5VMmbWH9tyqS3KlKvHLgRotJG0ScZ8k+9P0nvRg231UO801t
         b4mncPCJ/Ac8ge77qeUsi1osOQpWwqd+O3V6l2POqpDawmeelGfJOD3tWI50G//cMJGR
         vCShhyJJp9yKusz5d/ILQvSuulmWcCtWuwMxYuFOFWkucbvk3fCL5L73Z81iG/a/HI/4
         qyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21c9Dq6cDivZ+JoJgFAUaSKmMpkUoOCwsc5GtAeNigY=;
        b=NT8fIuaPqkkM38vsbxWH0nynmJDMsPqcWuuTWmcWpA+n9yRnqjpF32om8gkakNNAws
         1t2zJJVEYmHZsmcaNM6oFSvx9sq5nhTNJYC1UFZ7i2+i2piTfBSRf2Qt5aGwQpbKQFv6
         8pgL9J7i0CedabOXDTG5yUQ3GYZyeWGcrSjV0e8yp8Eq7By+ZlgByN5LIxoYQbjdNVtN
         fxCZRH1Qsmdx2UIQvXf+eZ7gkhU9UmxwvFubCQ6Sdvr6Q4mMFQPFyAj86WOjw/5rBDSp
         cj93+bnLQC8LHXkZwRABx6bQZhO/NUDS85egebI0Lx7cCz8hW4gMW7vFFoc59HHESIXA
         6b7w==
X-Gm-Message-State: AHQUAuawHCK2WzgqWxbeRG8GZalClmVKOpVetLYvv7bAq0QelOVTmzzq
        LN+awLv7vlWz09/nN9J8lV8fiQ==
X-Google-Smtp-Source: AHgI3IaW2KNerwqW/bgVy+B0v83vk3axY921x/T872zul2r7jVxiKZXitCSTA0G3lBQp3AmfqGVsUg==
X-Received: by 2002:a1c:864f:: with SMTP id i76mr11247978wmd.83.1549632208437;
        Fri, 08 Feb 2019 05:23:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m21sm3033007wmi.43.2019.02.08.05.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 05:23:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH v6 5/5] misc: fastrpc: Add support for dmabuf exporter
Date:   Fri,  8 Feb 2019 13:23:06 +0000
Message-Id: <20190208132306.12571-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User process can involve dealing with big buffer sizes, and also passing
buffers from one compute context bank to other compute context bank for
complex dsp algorithms.

This patch adds support to fastrpc to make it a proper dmabuf exporter
to avoid making copies of buffers.

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 183 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   8 ++
 2 files changed, 191 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ddd9fa9b238e..357c29e5a779 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -107,10 +107,20 @@ struct fastrpc_invoke_rsp {
 
 struct fastrpc_buf {
 	struct fastrpc_user *fl;
+	struct dma_buf *dmabuf;
 	struct device *dev;
 	void *virt;
 	u64 phys;
 	u64 size;
+	/* Lock for dma buf attachments */
+	struct mutex lock;
+	struct list_head attachments;
+};
+
+struct fastrpc_dma_buf_attachment {
+	struct device *dev;
+	struct sg_table sgt;
+	struct list_head node;
 };
 
 struct fastrpc_map {
@@ -247,6 +257,9 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 	if (!buf)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&buf->attachments);
+	mutex_init(&buf->lock);
+
 	buf->fl = fl;
 	buf->virt = NULL;
 	buf->phys = 0;
@@ -361,6 +374,111 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	return ERR_PTR(ret);
 }
 
+static struct sg_table *
+fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
+		    enum dma_data_direction dir)
+{
+	struct fastrpc_dma_buf_attachment *a = attachment->priv;
+	struct sg_table *table;
+
+	table = &a->sgt;
+
+	if (!dma_map_sg(attachment->dev, table->sgl, table->nents, dir))
+		return ERR_PTR(-ENOMEM);
+
+	return table;
+}
+
+static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
+				  struct sg_table *table,
+				  enum dma_data_direction dir)
+{
+	dma_unmap_sg(attach->dev, table->sgl, table->nents, dir);
+}
+
+static void fastrpc_release(struct dma_buf *dmabuf)
+{
+	struct fastrpc_buf *buffer = dmabuf->priv;
+
+	fastrpc_buf_free(buffer);
+}
+
+static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
+				  struct dma_buf_attachment *attachment)
+{
+	struct fastrpc_dma_buf_attachment *a;
+	struct fastrpc_buf *buffer = dmabuf->priv;
+	int ret;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	ret = dma_get_sgtable(buffer->dev, &a->sgt, buffer->virt,
+			      FASTRPC_PHYS(buffer->phys), buffer->size);
+	if (ret < 0) {
+		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
+		return -EINVAL;
+	}
+
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->node);
+	attachment->priv = a;
+
+	mutex_lock(&buffer->lock);
+	list_add(&a->node, &buffer->attachments);
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+}
+
+static void fastrpc_dma_buf_detatch(struct dma_buf *dmabuf,
+				    struct dma_buf_attachment *attachment)
+{
+	struct fastrpc_dma_buf_attachment *a = attachment->priv;
+	struct fastrpc_buf *buffer = dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+	list_del(&a->node);
+	mutex_unlock(&buffer->lock);
+	kfree(a);
+}
+
+static void *fastrpc_kmap(struct dma_buf *dmabuf, unsigned long pgnum)
+{
+	struct fastrpc_buf *buf = dmabuf->priv;
+
+	return buf->virt ? buf->virt + pgnum * PAGE_SIZE : NULL;
+}
+
+static void *fastrpc_vmap(struct dma_buf *dmabuf)
+{
+	struct fastrpc_buf *buf = dmabuf->priv;
+
+	return buf->virt;
+}
+
+static int fastrpc_mmap(struct dma_buf *dmabuf,
+			struct vm_area_struct *vma)
+{
+	struct fastrpc_buf *buf = dmabuf->priv;
+	size_t size = vma->vm_end - vma->vm_start;
+
+	return dma_mmap_coherent(buf->dev, vma, buf->virt,
+				 FASTRPC_PHYS(buf->phys), size);
+}
+
+static const struct dma_buf_ops fastrpc_dma_buf_ops = {
+	.attach = fastrpc_dma_buf_attach,
+	.detach = fastrpc_dma_buf_detatch,
+	.map_dma_buf = fastrpc_map_dma_buf,
+	.unmap_dma_buf = fastrpc_unmap_dma_buf,
+	.mmap = fastrpc_mmap,
+	.map = fastrpc_kmap,
+	.vmap = fastrpc_vmap,
+	.release = fastrpc_release,
+};
+
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 			      u64 len, struct fastrpc_map **ppmap)
 {
@@ -893,6 +1011,65 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int fastrpc_dmabuf_free(struct fastrpc_user *fl, char __user *argp)
+{
+	struct dma_buf *buf;
+	int info;
+
+	if (copy_from_user(&info, argp, sizeof(info)))
+		return -EFAULT;
+
+	buf = dma_buf_get(info);
+	if (IS_ERR_OR_NULL(buf))
+		return -EINVAL;
+	/*
+	 * one for the last get and other for the ALLOC_DMA_BUFF ioctl
+	 */
+	dma_buf_put(buf);
+	dma_buf_put(buf);
+
+	return 0;
+}
+
+static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_alloc_dma_buf bp;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct fastrpc_buf *buf = NULL;
+	int err;
+
+	if (copy_from_user(&bp, argp, sizeof(bp)))
+		return -EFAULT;
+
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, &buf);
+	if (err)
+		return err;
+	exp_info.ops = &fastrpc_dma_buf_ops;
+	exp_info.size = bp.size;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = buf;
+	buf->dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(buf->dmabuf)) {
+		fastrpc_buf_free(buf);
+		return PTR_ERR(buf->dmabuf);
+	}
+
+	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	if (bp.fd < 0) {
+		dma_buf_put(buf->dmabuf);
+		return -EINVAL;
+	}
+
+	if (copy_to_user(argp, &bp, sizeof(bp))) {
+		dma_buf_put(buf->dmabuf);
+		return -EFAULT;
+	}
+
+	get_dma_buf(buf->dmabuf);
+
+	return 0;
+}
+
 static int fastrpc_init_attach(struct fastrpc_user *fl)
 {
 	struct fastrpc_invoke_args args[1];
@@ -965,6 +1142,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
 		break;
+	case FASTRPC_IOCTL_FREE_DMA_BUFF:
+		err = fastrpc_dmabuf_free(fl, argp);
+		break;
+	case FASTRPC_IOCTL_ALLOC_DMA_BUFF:
+		err = fastrpc_dmabuf_alloc(fl, argp);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 32d191c3b7bc..6d701af9fc42 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+#define FASTRPC_IOCTL_ALLOC_DMA_BUFF	_IOWR('R', 1, struct fastrpc_alloc_dma_buf)
+#define FASTRPC_IOCTL_FREE_DMA_BUFF	_IOWR('R', 2, __u32)
 #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
 #define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
 #define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
@@ -30,4 +32,10 @@ struct fastrpc_init_create {
 	__u64 file;	/* pointer to elf file */
 };
 
+struct fastrpc_alloc_dma_buf {
+	__s32 fd;	/* fd */
+	__u32 flags;	/* flags to map with */
+	__u64 size;	/* size */
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.20.1

