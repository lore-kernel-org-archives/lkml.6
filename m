Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51932C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA50218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLOGSg8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfBANLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:11:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfBANLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:11:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so6974577wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHMC2VT1gbU85oxct7OwKHUrwEzYf1AnqHKSjJb7GbQ=;
        b=WLOGSg8Ij6dfGHfZdNmrpQ4VGQI/G4NCg/9JJ/6rOm72OJiQdTrPznLIR+0hnQEbB+
         EyGLnyJP8xZ1vtPyPl9M+xat6ml4AfxE4ZiiniGX9eFs10yFAwnf/4JDzdmaHC+HrA/2
         m8bYoDwbuQoIRbEZJw6jnnut5B/1CVQ6/6wgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHMC2VT1gbU85oxct7OwKHUrwEzYf1AnqHKSjJb7GbQ=;
        b=NO0EWeZWfJ/GTM1dLwnesGf//zMqXFTC/i1l5Du7novO39Hjoilnq8OFQV5kE0TKjU
         jYFPr+GXiOmT7FUKyt2HCKzdjBq6SUZbHQ8cBuxgNmQlP457WijSvlGSsHpP/feADYd/
         mPY+o3MBc1qEsUyrWQvL4/2AoMs2KJAjzjji4JAkcgEk8kHVQg5vd7k82siAoTGaBUAQ
         eNwIiD1+rp1RUFAgNGbSyTQNJOUY+I9q5JzL9i5VyFPDqthPlj3XZBlUecayh3chvW4v
         IWCKbFbbBRNXhy8uXSX3UkCx1oS0DG+dW1kSNDwcgM/iTah6dU9UGbPjm4nebGeKeULl
         RGYw==
X-Gm-Message-State: AHQUAuaI53OHDCZfId09dkNuy9ssSu32S8ubMki2XErPlDpVVEGUwWoD
        X6ql+1Hx0nBfGGqGtqUraNF/Lg==
X-Google-Smtp-Source: AHgI3IZuyf0uQNXATURo0oOw0AaNFnKddWTvo1SKnZNL8EEyccuV7O7F+HqBlLTGA+BU7wL19ipy6Q==
X-Received: by 2002:adf:e509:: with SMTP id j9mr33244010wrm.76.1549026670565;
        Fri, 01 Feb 2019 05:11:10 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a12sm12563461wro.18.2019.02.01.05.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 05:11:09 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH v5 5/5] misc: fastrpc: Add support for dmabuf exporter
Date:   Fri,  1 Feb 2019 13:09:25 +0000
Message-Id: <20190201130925.27066-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
References: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
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
 drivers/misc/fastrpc.c      | 182 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   8 ++
 2 files changed, 190 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fd5d602d0e7f..ec6b1e7a6ec7 100644
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
@@ -350,6 +363,110 @@ fastrpc_context_alloc(struct fastrpc_user *user, u32 kernel, u32 sc,
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
@@ -875,6 +992,65 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
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
@@ -947,6 +1123,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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

