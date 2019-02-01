Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F66C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E85218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lwz+Icr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfBANLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:11:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfBANLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:11:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so7038796wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSBY8Zq/vNfyOCKSHs9YL7cSfTrK9S4qeCJe+mBJ494=;
        b=Lwz+Icr+DgUp/DsHPEV3Zvt7FapYCjXFW9do2MCBWuqWJYG0qop6xNUBhr6+7lLZ1K
         1jZ8ctAlRP3qceyjH53s2wkeyZTAJS06sOCB7t1HpHIPYz9UhitXo5Mp3CUMfEuTB2/u
         lBp6RyO8OoUOCTSsq76sffzVJKw2yYfm5Z9Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSBY8Zq/vNfyOCKSHs9YL7cSfTrK9S4qeCJe+mBJ494=;
        b=hlyd/qxT4ZbNQQTh9ez4N7b/lG3xxoxshMhnRgVVVH9G3ccP0QHhxOVsCvQfXKclgn
         qDfUw5mkWVGuJ1yfJFEY+8SN42XPT4PkvFOoIwsMJ/9XKTfW8RV3WyZxFg0g8Mkl7+8k
         1Fuhty+1kLQxHIQvraVQgDg6Nro0qdUPB3NXh5dDD+jFVEJzhJgqc4isoD31uWetlsYH
         HyXcbNP81TVFr7umFxwbPwAUSHtNxwvZpW4V3mkaBwH3ET8igHCYro8VU4jzi3fwgwE9
         vI6sPWx0iPBnC9/YzU9zKO5eHajo4dAhjFDbJxcBrcl0aFXMLwwLC4m2S04mo3D9dDms
         ov0Q==
X-Gm-Message-State: AJcUukcSFQ2pMs2qQr4r3oTIgnTSMvj5XpYqYmjGeQvFgTX9QNlqU9Vf
        3Ez8Gpe4SGseusKxLXlOsHFBYw==
X-Google-Smtp-Source: ALg8bN4ffMW0Of5fv2hm4VqbFtueD1Cq/7DkIeAzSjusn5aEVcHn48s49E+omcO7PkMwldVxZlB8iA==
X-Received: by 2002:adf:e608:: with SMTP id p8mr38850069wrm.166.1549026667224;
        Fri, 01 Feb 2019 05:11:07 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a12sm12563461wro.18.2019.02.01.05.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 05:11:06 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH v5 3/5] misc: fastrpc: Add support for context Invoke method
Date:   Fri,  1 Feb 2019 13:09:23 +0000
Message-Id: <20190201130925.27066-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
References: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to compute context invoke method on the
remote processor (DSP).
This involves setting up the functions input and output arguments,
input and output handles and mapping the dmabuf fd for the
argument/handle buffers.

The below diagram depicts invocation of a single method where the
client and objects reside on different processors. An object could
expose multiple methods which can be grouped together and referred
to as an interface.

,--------,        ,------,  ,-----------,  ,------,        ,--------,
|        | method |      |  |           |  |      | method |        |
| Client |------->| Stub |->| Transport |->| Skel |------->| Object |
|        |        |      |  |           |  |      |        |        |
`--------`        `------`  `-----------`  `------`        `--------`

Client:    Linux user mode process that initiates the remote invocation
Stub:      Auto generated code linked in with the user mode process that
           takes care of marshaling parameters
Transport: Involved in carrying an invocation from a client to an
           object. This involves two portions: 1) FastRPC Linux
           kernel driver that receives the remote invocation, queues
           them up and then waits for the response after signaling the
           remote side. 2) Service running on the remote side that
           dequeues the messages from the queue and dispatches them for
           processing.
Skel:      Auto generated code that takes care of un-marshaling
           parameters
Object:    Method implementation

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 720 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |  23 ++
 2 files changed, 743 insertions(+)
 create mode 100644 include/uapi/misc/fastrpc.h

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c86c7babf403..8fdbc86da949 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2,7 +2,9 @@
 // Copyright (c) 2011-2018, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/list.h>
@@ -14,6 +16,7 @@
 #include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <uapi/misc/fastrpc.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -21,14 +24,118 @@
 #define CDSP_DOMAIN_ID (3)
 #define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
 #define FASTRPC_MAX_SESSIONS	9 /*8 compute, 1 cpz*/
+#define FASTRPC_ALIGN		128
+#define FASTRPC_MAX_FDLIST	16
+#define FASTRPC_MAX_CRCLIST	64
+#define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_CTXID_MASK (0xFF0)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
+/* Retrives number of input buffers from the scalars parameter */
+#define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
+
+/* Retrives number of output buffers from the scalars parameter */
+#define REMOTE_SCALARS_OUTBUFS(sc)	(((sc) >> 8) & 0x0ff)
+
+/* Retrives number of input handles from the scalars parameter */
+#define REMOTE_SCALARS_INHANDLES(sc)	(((sc) >> 4) & 0x0f)
+
+/* Retrives number of output handles from the scalars parameter */
+#define REMOTE_SCALARS_OUTHANDLES(sc)	((sc) & 0x0f)
+
+#define REMOTE_SCALARS_LENGTH(sc)	(REMOTE_SCALARS_INBUFS(sc) +   \
+					 REMOTE_SCALARS_OUTBUFS(sc) +  \
+					 REMOTE_SCALARS_INHANDLES(sc)+ \
+					 REMOTE_SCALARS_OUTHANDLES(sc))
+/* Limit max scalars to 255, it needs revisit in future */
+#define MAX_REMOTE_SCALARS	0xff
+#define FASTRPC_BUILD_SCALARS(attr, method, in, out, oin, oout)  \
+				(((attr & 0x07) << 29) |		\
+				((method & 0x1f) << 24) |	\
+				((in & 0xff) << 16) |		\
+				((out & 0xff) <<  8) |		\
+				((oin & 0x0f) <<  4) |		\
+				(oout & 0x0f))
+
+#define FASTRPC_SCALARS(method, in, out) \
+		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
+
 #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
+struct fastrpc_phy_page {
+	u64 addr;		/* physical address */
+	u64 size;		/* size of contiguous region */
+};
+
+struct fastrpc_invoke_buf {
+	u32 num;		/* number of contiguous regions */
+	u32 pgidx;		/* index to start of contiguous region */
+};
+
+struct fastrpc_remote_arg {
+	u64 pv;
+	u64 len;
+};
+
+struct fastrpc_msg {
+	int pid;		/* process group id */
+	int tid;		/* thread id */
+	u64 ctx;		/* invoke caller context */
+	u32 handle;	/* handle to invoke */
+	u32 sc;		/* scalars structure describing the data */
+	u64 addr;		/* physical address */
+	u64 size;		/* size of contiguous region */
+};
+
+struct fastrpc_invoke_rsp {
+	u64 ctx;		/* invoke caller context */
+	int retval;		/* invoke return value */
+};
+
+struct fastrpc_buf {
+	struct fastrpc_user *fl;
+	struct device *dev;
+	void *virt;
+	u64 phys;
+	u64 size;
+};
+
+struct fastrpc_map {
+	struct list_head node;
+	struct fastrpc_user *fl;
+	int fd;
+	struct dma_buf *buf;
+	struct sg_table *table;
+	struct dma_buf_attachment *attach;
+	u64 phys;
+	u64 size;
+	void *va;
+	u64 len;
+	struct kref refcount;
+};
+
+struct fastrpc_invoke_ctx {
+	int nscalars;
+	int nbufs;
+	int retval;
+	int pid;
+	int tgid;
+	u32 sc;
+	u32 *crc;
+	u64 ctxid;
+	u64 msg_sz;
+	struct list_head node; /* list of ctxs */
+	struct completion work;
+	struct fastrpc_msg msg;
+	struct fastrpc_user *fl;
+	struct fastrpc_remote_arg *rpra;
+	struct fastrpc_map **maps;
+	struct fastrpc_buf *buf;
+	struct fastrpc_invoke_args *args;
+};
 
 struct fastrpc_session_ctx {
 	struct device *dev;
@@ -55,6 +162,7 @@ struct fastrpc_user {
 
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sctx;
+	struct fastrpc_buf *init_mem;
 
 	int tgid;
 	int pd;
@@ -64,6 +172,508 @@ struct fastrpc_user {
 	struct mutex mutex;
 };
 
+static void fastrpc_free_map(struct kref *ref)
+{
+	struct fastrpc_map *map;
+
+	map = container_of(ref, struct fastrpc_map, refcount);
+
+	list_del(&map->node);
+
+	if (map->table) {
+		dma_buf_unmap_attachment(map->attach, map->table,
+					 DMA_BIDIRECTIONAL);
+		dma_buf_detach(map->buf, map->attach);
+		dma_buf_put(map->buf);
+	}
+
+	kfree(map);
+}
+
+static void fastrpc_map_put(struct fastrpc_map *map)
+{
+	struct fastrpc_user *fl;
+
+	if (map) {
+		fl = map->fl;
+		mutex_lock(&fl->mutex);
+		kref_put(&map->refcount, fastrpc_free_map);
+		mutex_unlock(&fl->mutex);
+	}
+}
+
+static int fastrpc_map_get(struct fastrpc_user *fl, int fd,
+			   struct fastrpc_map **ppmap)
+{
+	struct fastrpc_map *map = NULL;
+
+	mutex_lock(&fl->mutex);
+	list_for_each_entry(map, &fl->maps, node) {
+		if (map->fd == fd) {
+			kref_get(&map->refcount);
+			*ppmap = map;
+			mutex_unlock(&fl->mutex);
+			return 0;
+		}
+	}
+	mutex_unlock(&fl->mutex);
+
+	return -ENOENT;
+}
+
+static void fastrpc_buf_free(struct fastrpc_buf *buf)
+{
+	dma_free_coherent(buf->dev, buf->size, buf->virt,
+			  FASTRPC_PHYS(buf->phys));
+	kfree(buf);
+}
+
+static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+			     u64 size, struct fastrpc_buf **obuf)
+{
+	struct fastrpc_buf *buf;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->fl = fl;
+	buf->virt = NULL;
+	buf->phys = 0;
+	buf->size = size;
+	buf->dev = dev;
+
+	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
+				       GFP_KERNEL);
+	if (!buf->virt)
+		return -ENOMEM;
+
+	if (fl->sctx && fl->sctx->sid)
+		buf->phys += ((u64)fl->sctx->sid << 32);
+
+	*obuf = buf;
+
+	return 0;
+}
+
+static void fastrpc_context_free(struct fastrpc_invoke_ctx *ctx)
+{
+	struct fastrpc_channel_ctx *cctx = ctx->fl->cctx;
+	struct fastrpc_user *user = ctx->fl;
+	int scalars = REMOTE_SCALARS_LENGTH(ctx->sc);
+	int i;
+
+	spin_lock(&user->lock);
+	list_del(&ctx->node);
+	spin_unlock(&user->lock);
+
+	for (i = 0; i < scalars; i++)
+		fastrpc_map_put(ctx->maps[i]);
+
+	if (ctx->buf)
+		fastrpc_buf_free(ctx->buf);
+
+	spin_lock(&cctx->lock);
+	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	spin_unlock(&cctx->lock);
+
+	kfree(ctx->maps);
+	kfree(ctx);
+}
+
+static struct fastrpc_invoke_ctx *
+fastrpc_context_alloc(struct fastrpc_user *user, u32 kernel, u32 sc,
+		      struct fastrpc_invoke_args *args)
+{
+	struct fastrpc_channel_ctx *cctx = user->cctx;
+	struct fastrpc_invoke_ctx *ctx = NULL;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&ctx->node);
+	ctx->fl = user;
+	ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
+	ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
+		     REMOTE_SCALARS_OUTBUFS(sc);
+
+	if (ctx->nscalars) {
+		ctx->maps = kcalloc(ctx->nscalars,
+				    sizeof(*ctx->maps), GFP_KERNEL);
+		if (!ctx->maps) {
+			kfree(ctx);
+			return ERR_PTR(-ENOMEM);
+		}
+		ctx->args = args;
+	}
+
+	ctx->sc = sc;
+	ctx->retval = -1;
+	ctx->pid = current->pid;
+	ctx->tgid = user->tgid;
+	init_completion(&ctx->work);
+
+	spin_lock(&user->lock);
+	list_add_tail(&ctx->node, &user->pending);
+	spin_unlock(&user->lock);
+
+	spin_lock(&cctx->lock);
+	ret = idr_alloc_cyclic(&cctx->ctx_idr, ctx, 1,
+			       FASTRPC_CTX_MAX, GFP_ATOMIC);
+	if (ret < 0) {
+		spin_unlock(&cctx->lock);
+		goto err_idr;
+	}
+	ctx->ctxid = ret << 4;
+	spin_unlock(&cctx->lock);
+
+	return ctx;
+err_idr:
+	spin_lock(&user->lock);
+	list_del(&ctx->node);
+	spin_unlock(&user->lock);
+	kfree(ctx->maps);
+	kfree(ctx);
+
+	return ERR_PTR(ret);
+}
+
+static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
+			      u64 len, struct fastrpc_map **ppmap)
+{
+	struct fastrpc_session_ctx *sess = fl->sctx;
+	struct fastrpc_map *map = NULL;
+	int err = 0;
+
+	if (!fastrpc_map_get(fl, fd, ppmap))
+		return 0;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&map->node);
+	map->fl = fl;
+	map->fd = fd;
+	map->buf = dma_buf_get(fd);
+	if (!map->buf) {
+		err = -EINVAL;
+		goto get_err;
+	}
+
+	map->attach = dma_buf_attach(map->buf, sess->dev);
+	if (IS_ERR(map->attach)) {
+		dev_err(sess->dev, "Failed to attach dmabuf\n");
+		err = PTR_ERR(map->attach);
+		goto attach_err;
+	}
+
+	map->table = dma_buf_map_attachment(map->attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(map->table)) {
+		err = PTR_ERR(map->table);
+		goto map_err;
+	}
+
+	map->phys = sg_dma_address(map->table->sgl);
+	map->phys += ((u64)fl->sctx->sid << 32);
+	map->size = len;
+	map->va = sg_virt(map->table->sgl);
+	map->len = len;
+	kref_init(&map->refcount);
+
+	spin_lock(&fl->lock);
+	list_add_tail(&map->node, &fl->maps);
+	spin_unlock(&fl->lock);
+	*ppmap = map;
+
+	return 0;
+
+map_err:
+	dma_buf_detach(map->buf, map->attach);
+attach_err:
+	dma_buf_put(map->buf);
+get_err:
+	kfree(map);
+
+	return err;
+}
+
+/*
+ * Fastrpc payload buffer with metadata looks like:
+ *
+ * >>>>>>  START of METADATA <<<<<<<<<
+ * +---------------------------------+
+ * |           Arguments             |
+ * | type:(struct fastrpc_remote_arg)|
+ * |             (0 - N)             |
+ * +---------------------------------+
+ * |         Invoke Buffer list      |
+ * | type:(struct fastrpc_invoke_buf)|
+ * |           (0 - N)               |
+ * +---------------------------------+
+ * |         Page info list          |
+ * | type:(struct fastrpc_phy_page)  |
+ * |             (0 - N)             |
+ * +---------------------------------+
+ * |         Optional info           |
+ * |(can be specific to SoC/Firmware)|
+ * +---------------------------------+
+ * >>>>>>>>  END of METADATA <<<<<<<<<
+ * +---------------------------------+
+ * |         Inline ARGS             |
+ * |            (0-N)                |
+ * +---------------------------------+
+ */
+
+static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
+{
+	int size = 0;
+
+	size = (sizeof(struct fastrpc_remote_arg) +
+		sizeof(struct fastrpc_invoke_buf) +
+		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
+		sizeof(u64) * FASTRPC_MAX_FDLIST +
+		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+
+	return size;
+}
+
+static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
+{
+	u64 size = 0;
+	int i;
+
+	size = ALIGN(metalen, FASTRPC_ALIGN);
+	for (i = 0; i < ctx->nscalars; i++) {
+		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1) {
+			size = ALIGN(size, FASTRPC_ALIGN);
+			size += ctx->args[i].length;
+		}
+	}
+
+	return size;
+}
+
+static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
+{
+	struct device *dev = ctx->fl->sctx->dev;
+	int i, err;
+
+	for (i = 0; i < ctx->nscalars; ++i) {
+		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
+		    ctx->args[i].length == 0)
+			continue;
+
+		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
+					 ctx->args[i].length, &ctx->maps[i]);
+		if (err) {
+			dev_err(dev, "Error Creating map %d\n", err);
+			return -EINVAL;
+		}
+
+	}
+	return 0;
+}
+
+static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
+{
+	struct device *dev = ctx->fl->sctx->dev;
+	struct fastrpc_remote_arg *rpra;
+	struct fastrpc_invoke_buf *list;
+	struct fastrpc_phy_page *pages;
+	int inbufs, i, err = 0;
+	u64 rlen, pkt_size;
+	uintptr_t args;
+	int metalen;
+
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	metalen = fastrpc_get_meta_size(ctx);
+	pkt_size = fastrpc_get_payload_size(ctx, metalen);
+	fastrpc_create_maps(ctx);
+	ctx->msg_sz = pkt_size;
+
+	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	if (err)
+		return err;
+
+	rpra = ctx->buf->virt;
+	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
+	pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
+		sizeof(*rpra));
+	args = (uintptr_t)ctx->buf->virt + metalen;
+	rlen = pkt_size - metalen;
+	ctx->rpra = rpra;
+
+	for (i = 0; i < ctx->nbufs; ++i) {
+		u64 len = ctx->args[i].length;
+
+		rpra[i].pv = 0;
+		rpra[i].len = len;
+		list[i].num = len ? 1 : 0;
+		list[i].pgidx = i;
+
+		if (!len)
+			continue;
+
+		pages[i].size = roundup(len, PAGE_SIZE);
+
+		if (ctx->maps[i]) {
+			rpra[i].pv = (u64) ctx->args[i].ptr;
+			pages[i].addr = ctx->maps[i]->phys;
+		} else {
+			rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
+			args = ALIGN(args, FASTRPC_ALIGN);
+			if (rlen < len)
+				goto bail;
+
+			rpra[i].pv = args;
+			pages[i].addr = ctx->buf->phys + (pkt_size - rlen);
+			pages[i].addr = pages[i].addr &	PAGE_MASK;
+			args = args + len;
+			rlen -= len;
+		}
+
+		if (i < inbufs && !ctx->maps[i]) {
+			void *dst = (void *)(uintptr_t)rpra[i].pv;
+			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
+
+			if (!kernel) {
+				if (copy_from_user(dst, (void __user *)src,
+						   len)) {
+					err = -EFAULT;
+					goto bail;
+				}
+			} else {
+				memcpy(dst, src, len);
+			}
+		}
+	}
+
+	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
+		rpra[i].pv = (u64) ctx->args[i].ptr;
+		rpra[i].len = ctx->args[i].length;
+		list[i].num = ctx->args[i].length ? 1 : 0;
+		list[i].pgidx = i;
+		pages[i].addr = ctx->maps[i]->phys;
+		pages[i].size = ctx->maps[i]->size;
+	}
+
+bail:
+	if (err) {
+		fastrpc_buf_free(ctx->buf);
+		dev_err(dev, "Error: get invoke args failed:%d\n", err);
+	}
+
+	return err;
+}
+
+static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
+			    u32 kernel)
+{
+	struct fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+
+	for (i = inbufs; i < ctx->nbufs; ++i) {
+		void *src = (void *)(uintptr_t)rpra[i].pv;
+		void *dst = (void *)(uintptr_t)ctx->args[i].ptr;
+		u64 len = rpra[i].len;
+
+		if (ctx->maps[i]) {
+			fastrpc_map_put(ctx->maps[i]);
+			ctx->maps[i] = NULL;
+			continue;
+		}
+
+		if (!kernel) {
+			if (copy_to_user((void __user *)dst, src, len))
+				return -EFAULT;
+		} else {
+			memcpy(dst, src, len);
+		}
+	}
+
+	return 0;
+}
+
+static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
+			       struct fastrpc_invoke_ctx *ctx,
+			       u32 kernel, uint32_t handle)
+{
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_user *fl = ctx->fl;
+	struct fastrpc_msg *msg = &ctx->msg;
+
+	cctx = fl->cctx;
+	msg->pid = fl->tgid;
+	msg->tid = current->pid;
+
+	if (kernel)
+		msg->pid = 0;
+
+	msg->ctx = ctx->ctxid | fl->pd;
+	msg->handle = handle;
+	msg->sc = ctx->sc;
+	msg->addr = ctx->buf ? ctx->buf->phys : 0;
+	msg->size = roundup(ctx->msg_sz, PAGE_SIZE);
+
+	return rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
+}
+
+static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
+				   u32 handle, u32 sc,
+				   struct fastrpc_invoke_args *args)
+{
+	struct fastrpc_invoke_ctx *ctx = NULL;
+	int err = 0;
+
+	if (!fl->sctx)
+		return -EINVAL;
+
+	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	if (ctx->nscalars) {
+		err = fastrpc_get_args(kernel, ctx);
+		if (err)
+			goto bail;
+	}
+	/* Send invoke buffer to remote dsp */
+	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
+	if (err)
+		goto bail;
+
+	/* Wait for remote dsp to respond or time out */
+	err = wait_for_completion_interruptible(&ctx->work);
+	if (err)
+		goto bail;
+
+	/* Check the response from remote dsp */
+	err = ctx->retval;
+	if (err)
+		goto bail;
+
+	/* populate all the output buffers with results */
+	err = fastrpc_put_args(ctx, kernel);
+	if (err)
+		goto bail;
+
+	/* We are done with this compute, release it now! */
+bail:
+	if (ctx)
+		fastrpc_context_free(ctx);
+
+	if (err)
+		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
+
+	return err;
+}
+
 static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx)
 {
@@ -95,11 +705,22 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct fastrpc_invoke_ctx *ctx, *n;
+	struct fastrpc_map *map, *m;
 
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
 
+	if (fl->init_mem)
+		fastrpc_buf_free(fl->init_mem);
+
+	list_for_each_entry_safe(ctx, n, &fl->pending, node)
+		fastrpc_context_free(ctx);
+
+	list_for_each_entry_safe(map, m, &fl->maps, node)
+		fastrpc_map_put(map);
+
 	fastrpc_session_free(fl->cctx, fl->sctx);
 
 	mutex_destroy(&fl->mutex);
@@ -134,9 +755,69 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_invoke_args *args = NULL;
+	struct fastrpc_invoke inv;
+	u32 nscalars;
+	int err;
+
+	if (copy_from_user(&inv, argp, sizeof(inv)))
+		return -EFAULT;
+
+	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
+
+	if (nscalars > MAX_REMOTE_SCALARS)
+		return -EINVAL;
+
+	if (nscalars) {
+		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
+		if (!args)
+			return -ENOMEM;
+
+		if (copy_from_user(args, (void __user *)(uintptr_t)inv.args,
+				   nscalars * sizeof(*args))) {
+			kfree(args);
+			return -EFAULT;
+		}
+
+		/* Make sure reserved field is set to 0 */
+		if (args->reserved) {
+			kfree(args);
+			return -EINVAL;
+		}
+	}
+
+	err = fastrpc_internal_invoke(fl, false, inv.handle, inv.sc, args);
+	kfree(args);
+
+	return err;
+}
+
+static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
+	char __user *argp = (char __user *)arg;
+	int err;
+
+	switch (cmd) {
+	case FASTRPC_IOCTL_INVOKE:
+		err = fastrpc_invoke(fl, argp);
+		break;
+	default:
+		err = -ENOTTY;
+		break;
+	}
+
+	return err;
+}
+
 static const struct file_operations fastrpc_fops = {
 	.open = fastrpc_device_open,
 	.release = fastrpc_device_release,
+	.unlocked_ioctl = fastrpc_device_ioctl,
+	.compat_ioctl = fastrpc_device_ioctl,
 };
 
 static int fastrpc_cb_probe(struct platform_device *pdev)
@@ -260,9 +941,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx;
+
+	spin_lock(&user->lock);
+	list_for_each_entry(ctx, &user->pending, node)
+		complete(&ctx->work);
+	spin_unlock(&user->lock);
+}
+
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_user *user;
+
+	spin_lock(&cctx->lock);
+	list_for_each_entry(user, &cctx->users, user)
+		fastrpc_notify_users(user);
+	spin_unlock(&cctx->lock);
 
 	misc_deregister(&cctx->miscdev);
 	of_platform_depopulate(&rpdev->dev);
@@ -272,6 +969,29 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 				  int len, void *priv, u32 addr)
 {
+	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_invoke_rsp *rsp = data;
+	struct fastrpc_invoke_ctx *ctx;
+	unsigned long flags;
+	unsigned long ctxid;
+
+	if (len < sizeof(*rsp))
+		return -EINVAL;
+
+	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	ctx = idr_find(&cctx->ctx_idr, ctxid);
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	if (!ctx) {
+		dev_err(&rpdev->dev, "No context ID matches response\n");
+		return -ENOENT;
+	}
+
+	ctx->retval = rsp->retval;
+	complete(&ctx->work);
+
 	return 0;
 }
 
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
new file mode 100644
index 000000000000..a69ef33dc37e
--- /dev/null
+++ b/include/uapi/misc/fastrpc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_FASTRPC_H__
+#define __QCOM_FASTRPC_H__
+
+#include <linux/types.h>
+
+#define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
+
+struct fastrpc_invoke_args {
+	__u64 ptr;
+	__u64 length;
+	__s32 fd;
+	__u32 reserved;
+};
+
+struct fastrpc_invoke {
+	__u32 handle;
+	__u32 sc;
+	__u64 args;
+};
+
+#endif /* __QCOM_FASTRPC_H__ */
-- 
2.20.1

