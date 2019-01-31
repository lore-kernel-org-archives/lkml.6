Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E2FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A10D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZf+RP8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfAaPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:41:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40701 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:41:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1504904pgp.7;
        Thu, 31 Jan 2019 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUn9Hz1mapneAAsBheVMXQ6anQd8S3NPWykszUHVa8w=;
        b=YZf+RP8HS1fxhfDMDVHKG2QZiLP9B7UKiRlJImDMVqC8NnpGCBMdKB19Ro9eKuSXmb
         l0opY/WKwmid1utJ5omHLDqJnPJlOXdzZWPjh6W8BmYk/ey/ryNZky/gtcjG5Ctp29Gb
         ehKUjuTgs/fWzhFkUGgMIQFDlODomeNv+N2Np6HwVizA0Rsjf8b/kmszWRw7ekaDiky/
         QeKI6B6KJIR4J+BXBuFeFiy/jn23XwQjZ9IrM5x4Rq95RGeOZ30ZwIfx9b5CfDzh0eLO
         4uO9LvZgCJyyyS1/kh9zLgFLq0FSZc0Mw7zA8fOAlnIkFt5LrzqduU3Pw2y/kNYa22KX
         H+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YUn9Hz1mapneAAsBheVMXQ6anQd8S3NPWykszUHVa8w=;
        b=qDvVRbmsID2s6HuJYWg/+/o6x3UslSntdGYjnzvnLlM9siS+5bOq2VbJMiP8Stz8Bn
         0EPhsWSH7BPowlcVe6x8JarCMumD2mq/WvioiZUlgqYz/C5kejFYHLkRWbCBwunjeYCF
         OESn8Pk1OBIjlWCkKUnvUYD3aa+t1/FoVT4a0cApWUmU7Zn/0jVsvERM4srBrpwrPVBQ
         s8qv+7OMcV/SNEj79QdmcPBkfiUwvWahufzZseEE+IjcwTMWpfP/bNmMGs5grV8PbD/d
         buys3+1Viymqyvezb4rjkbvXhNvycQQdXFWmToDl8vR/odJrGd/EUmSXpDZn/HjXNcal
         u4Cg==
X-Gm-Message-State: AJcUukcJJbIXLFgZuQSPSl1a2nw5rCrem2ahljAbvuKnIv27iOWp40oV
        OiM6nSMdWpPpQmKYz7txqq0=
X-Google-Smtp-Source: ALg8bN4BvhOXXTaCfC/s2uVWRDUxyEvONlSsft2rqhc2ZWiT7lI9OBBlJmAx/GMGq0AwYzO4TznAag==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr32319712pgg.398.1548949317903;
        Thu, 31 Jan 2019 07:41:57 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b2sm6622435pgg.87.2019.01.31.07.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 07:41:57 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        wendy.liang@xilinx.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH 2/3] rpmsg: virtio_rpmsg_bus: allocate rx/tx buffer separately
Date:   Thu, 31 Jan 2019 23:41:19 +0800
Message-Id: <1548949280-31794-3-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

many dma allocator align the returned address with buffer size,
so two small allocation could reduce the alignment requirement
and save the the memory space wasted by the potential alignment.

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 58 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index fb0d2eb..59c4554 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -40,7 +40,8 @@
  * @num_sbufs:	total number of buffers for tx
  * @buf_size:	size of one rx or tx buffer
  * @last_sbuf:	index of last tx buffer used
- * @bufs_dma:	dma base addr of the buffers
+ * @rbufs_dma:	dma base addr of rx buffers
+ * @sbufs_dma:	dma base addr of tx buffers
  * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
  *		sending a message might require waking up a dozing remote
  *		processor, which involves sleeping, hence the mutex.
@@ -62,7 +63,8 @@ struct virtproc_info {
 	unsigned int num_sbufs;
 	unsigned int buf_size;
 	int last_sbuf;
-	dma_addr_t bufs_dma;
+	dma_addr_t rbufs_dma;
+	dma_addr_t sbufs_dma;
 	struct mutex tx_lock;
 	struct idr endpoints;
 	struct mutex endpoints_lock;
@@ -872,9 +874,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	static const char * const names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	struct virtproc_info *vrp;
-	void *bufs_va;
 	int err = 0, i;
-	size_t total_buf_space;
 	bool notify;
 
 	vrp = kzalloc(sizeof(*vrp), GFP_KERNEL);
@@ -909,25 +909,28 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
 
-	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
-
 	/* allocate coherent memory for the buffers */
-	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
-				     total_buf_space, &vrp->bufs_dma,
-				     GFP_KERNEL);
-	if (!bufs_va) {
+	vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
+					vrp->num_rbufs * vrp->buf_size,
+					&vrp->rbufs_dma, GFP_KERNEL);
+	if (!vrp->rbufs) {
 		err = -ENOMEM;
 		goto vqs_del;
 	}
 
-	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
-		bufs_va, &vrp->bufs_dma);
+	dev_dbg(&vdev->dev, "rx buffers: va %p, dma 0x%pad\n",
+		vrp->rbufs, &vrp->rbufs_dma);
 
-	/* first part of the buffers is dedicated for RX */
-	vrp->rbufs = bufs_va;
+	vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
+					vrp->num_sbufs * vrp->buf_size,
+					&vrp->sbufs_dma, GFP_KERNEL);
+	if (!vrp->sbufs) {
+		err = -ENOMEM;
+		goto free_rbufs;
+	}
 
-	/* and second part is dedicated for TX */
-	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
+	dev_dbg(&vdev->dev, "tx buffers: va %p, dma 0x%pad\n",
+		vrp->sbufs, &vrp->sbufs_dma);
 
 	/* set up the receive buffers */
 	for (i = 0; i < vrp->num_rbufs; i++) {
@@ -954,7 +957,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 		if (!vrp->ns_ept) {
 			dev_err(&vdev->dev, "failed to create the ns ept\n");
 			err = -ENOMEM;
-			goto free_coherent;
+			goto free_sbufs;
 		}
 	}
 
@@ -979,9 +982,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_coherent:
-	dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
-			  bufs_va, vrp->bufs_dma);
+free_sbufs:
+	dma_free_coherent(vdev->dev.parent->parent,
+			  vrp->num_sbufs * vrp->buf_size,
+			  vrp->sbufs, vrp->sbufs_dma);
+free_rbufs:
+	dma_free_coherent(vdev->dev.parent->parent,
+			  vrp->num_rbufs * vrp->buf_size,
+			  vrp->rbufs, vrp->rbufs_dma);
 vqs_del:
 	vdev->config->del_vqs(vrp->vdev);
 free_vrp:
@@ -999,8 +1007,6 @@ static int rpmsg_remove_device(struct device *dev, void *data)
 static void rpmsg_remove(struct virtio_device *vdev)
 {
 	struct virtproc_info *vrp = vdev->priv;
-	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
-	size_t total_buf_space = num_bufs * vrp->buf_size;
 	int ret;
 
 	vdev->config->reset(vdev);
@@ -1016,8 +1022,12 @@ static void rpmsg_remove(struct virtio_device *vdev)
 
 	vdev->config->del_vqs(vrp->vdev);
 
-	dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
-			  vrp->rbufs, vrp->bufs_dma);
+	dma_free_coherent(vdev->dev.parent->parent,
+			  vrp->num_sbufs * vrp->buf_size,
+			  vrp->sbufs, vrp->sbufs_dma);
+	dma_free_coherent(vdev->dev.parent->parent,
+			  vrp->num_rbufs * vrp->buf_size,
+			  vrp->rbufs, vrp->rbufs_dma);
 
 	kfree(vrp);
 }
-- 
2.7.4

