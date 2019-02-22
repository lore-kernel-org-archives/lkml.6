Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AB0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CEA2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBVPb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:31:28 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:45352 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBVPb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 94AB418690;
        Fri, 22 Feb 2019 16:31:23 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XL1NFSNf-eSH; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 904D81868A;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC481A081;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 503471A07C;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 3F92D3124;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 3DA3480F99; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2 char-misc-next 2/7] mic: Rename ioremap pointer to remap
Date:   Fri, 22 Feb 2019 16:30:49 +0100
Message-Id: <20190222153056.18878-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222153056.18878-1-vincent.whitchurch@axis.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures (like MIPS) implement ioremap as a macro, and this
leads to conflicts with the ioremap function pointer in various mic
structures.

 drivers/misc/mic/vop/vop_vringh.c:
   In function 'vop_virtio_init_post':
 drivers/misc/mic/vop/vop_vringh.c:86:13:
   error: macro "ioremap" passed 3 arguments, but takes just 2

Rename ioremap to remap to fix this.  Likewise for iounmap.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/bus/scif_bus.h    |  8 ++++----
 drivers/misc/mic/bus/vop_bus.h     |  8 ++++----
 drivers/misc/mic/card/mic_device.c |  8 ++++----
 drivers/misc/mic/host/mic_boot.c   |  8 ++++----
 drivers/misc/mic/scif/scif_map.h   |  4 ++--
 drivers/misc/mic/vop/vop_main.c    |  7 +++----
 drivers/misc/mic/vop/vop_vringh.c  | 10 +++++-----
 7 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/mic/bus/scif_bus.h b/drivers/misc/mic/bus/scif_bus.h
index ff59568219ad..377a4f38cd7e 100644
--- a/drivers/misc/mic/bus/scif_bus.h
+++ b/drivers/misc/mic/bus/scif_bus.h
@@ -88,8 +88,8 @@ struct scif_driver {
  * @send_intr: Send an interrupt to the remote node on a specified doorbell.
  * @send_p2p_intr: Send an interrupt to the peer node on a specified doorbell
  * which is specifically targeted for a peer to peer node.
- * @ioremap: Map a buffer with the specified physical address and length.
- * @iounmap: Unmap a buffer previously mapped.
+ * @remap: Map a buffer with the specified physical address and length.
+ * @unmap: Unmap a buffer previously mapped.
  */
 struct scif_hw_ops {
 	int (*next_db)(struct scif_hw_dev *sdev);
@@ -104,9 +104,9 @@ struct scif_hw_ops {
 	void (*send_intr)(struct scif_hw_dev *sdev, int db);
 	void (*send_p2p_intr)(struct scif_hw_dev *sdev, int db,
 			      struct mic_mw *mw);
-	void __iomem * (*ioremap)(struct scif_hw_dev *sdev,
+	void __iomem * (*remap)(struct scif_hw_dev *sdev,
 				  phys_addr_t pa, size_t len);
-	void (*iounmap)(struct scif_hw_dev *sdev, void __iomem *va);
+	void (*unmap)(struct scif_hw_dev *sdev, void __iomem *va);
 };
 
 int scif_register_driver(struct scif_driver *driver);
diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
index fff7a865d721..cf5f3fae573c 100644
--- a/drivers/misc/mic/bus/vop_bus.h
+++ b/drivers/misc/mic/bus/vop_bus.h
@@ -87,8 +87,8 @@ struct vop_driver {
  * @get_dp: Get access to the virtio device page used by the self
  *          node to add/remove/configure virtio devices.
  * @send_intr: Send an interrupt to the peer node on a specified doorbell.
- * @ioremap: Map a buffer with the specified DMA address and length.
- * @iounmap: Unmap a buffer previously mapped.
+ * @remap: Map a buffer with the specified DMA address and length.
+ * @unmap: Unmap a buffer previously mapped.
  * @dma_filter: The DMA filter function to use for obtaining access to
  *		a DMA channel on the peer node.
  */
@@ -104,9 +104,9 @@ struct vop_hw_ops {
 	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
 	void * (*get_dp)(struct vop_device *vpdev);
 	void (*send_intr)(struct vop_device *vpdev, int db);
-	void __iomem * (*ioremap)(struct vop_device *vpdev,
+	void __iomem * (*remap)(struct vop_device *vpdev,
 				  dma_addr_t pa, size_t len);
-	void (*iounmap)(struct vop_device *vpdev, void __iomem *va);
+	void (*unmap)(struct vop_device *vpdev, void __iomem *va);
 };
 
 struct vop_device *
diff --git a/drivers/misc/mic/card/mic_device.c b/drivers/misc/mic/card/mic_device.c
index e749af48f736..dcd07ef29801 100644
--- a/drivers/misc/mic/card/mic_device.c
+++ b/drivers/misc/mic/card/mic_device.c
@@ -245,8 +245,8 @@ static struct scif_hw_ops scif_hw_ops = {
 	.next_db = ___mic_next_db,
 	.send_intr = ___mic_send_intr,
 	.send_p2p_intr = ___mic_send_p2p_intr,
-	.ioremap = ___mic_ioremap,
-	.iounmap = ___mic_iounmap,
+	.remap = ___mic_ioremap,
+	.unmap = ___mic_iounmap,
 };
 
 static inline struct mic_driver *vpdev_to_mdrv(struct vop_device *vpdev)
@@ -316,8 +316,8 @@ static struct vop_hw_ops vop_hw_ops = {
 	.next_db = __mic_next_db,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
-	.ioremap = __mic_ioremap,
-	.iounmap = __mic_iounmap,
+	.remap = __mic_ioremap,
+	.unmap = __mic_iounmap,
 };
 
 static int mic_request_dma_chans(struct mic_driver *mdrv)
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index 6479435ac96b..079c36f0ce6e 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -133,8 +133,8 @@ static struct vop_hw_ops vop_hw_ops = {
 	.get_dp = __mic_get_dp,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
-	.ioremap = __mic_ioremap,
-	.iounmap = __mic_iounmap,
+	.remap = __mic_ioremap,
+	.unmap = __mic_iounmap,
 };
 
 static inline struct mic_device *scdev_to_mdev(struct scif_hw_dev *scdev)
@@ -315,8 +315,8 @@ static struct scif_hw_ops scif_hw_ops = {
 	.ack_interrupt = ___mic_ack_interrupt,
 	.next_db = ___mic_next_db,
 	.send_intr = ___mic_send_intr,
-	.ioremap = ___mic_ioremap,
-	.iounmap = ___mic_iounmap,
+	.remap = ___mic_ioremap,
+	.unmap = ___mic_iounmap,
 };
 
 static inline struct mic_device *mbdev_to_mdev(struct mbus_device *mbdev)
diff --git a/drivers/misc/mic/scif/scif_map.h b/drivers/misc/mic/scif/scif_map.h
index 3e86360ba5a6..7b380534eba1 100644
--- a/drivers/misc/mic/scif/scif_map.h
+++ b/drivers/misc/mic/scif/scif_map.h
@@ -97,7 +97,7 @@ scif_ioremap(dma_addr_t phys, size_t size, struct scif_dev *scifdev)
 		out_virt = phys_to_virt(phys);
 	else
 		out_virt = (void __force *)
-			   sdev->hw_ops->ioremap(sdev, phys, size);
+			   sdev->hw_ops->remap(sdev, phys, size);
 	return out_virt;
 }
 
@@ -107,7 +107,7 @@ scif_iounmap(void *virt, size_t len, struct scif_dev *scifdev)
 	if (!scifdev_self(scifdev)) {
 		struct scif_hw_dev *sdev = scifdev->sdev;
 
-		sdev->hw_ops->iounmap(sdev, (void __force __iomem *)virt);
+		sdev->hw_ops->unmap(sdev, (void __force __iomem *)virt);
 	}
 }
 
diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 263e0c3fa7c6..e37b2c2152a2 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -270,7 +270,7 @@ static void vop_del_vq(struct virtqueue *vq, int n)
 	free_pages((unsigned long)vdev->used_virt[n],
 		   get_order(vdev->used_size[n]));
 	vring_del_virtqueue(vq);
-	vpdev->hw_ops->iounmap(vpdev, vdev->vr[n]);
+	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
 }
 
@@ -338,8 +338,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	memcpy_fromio(&config, vqconfig, sizeof(config));
 	_vr_size = vring_size(le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN);
 	vr_size = PAGE_ALIGN(_vr_size + sizeof(struct _mic_vring_info));
-	va = vpdev->hw_ops->ioremap(vpdev, le64_to_cpu(config.address),
-			vr_size);
+	va = vpdev->hw_ops->remap(vpdev, le64_to_cpu(config.address), vr_size);
 	if (!va)
 		return ERR_PTR(-ENOMEM);
 	vdev->vr[index] = va;
@@ -393,7 +392,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	free_pages((unsigned long)used,
 		   get_order(vdev->used_size[index]));
 unmap:
-	vpdev->hw_ops->iounmap(vpdev, vdev->vr[index]);
+	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
 	return ERR_PTR(err);
 }
 
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 73d9fe6bc18d..3632fce40590 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -80,7 +80,7 @@ static void vop_virtio_init_post(struct vop_vdev *vdev)
 			continue;
 		}
 		vdev->vvr[i].vrh.vring.used =
-			(void __force *)vpdev->hw_ops->ioremap(
+			(void __force *)vpdev->hw_ops->remap(
 			vpdev,
 			le64_to_cpu(vqconfig[i].used_address),
 			used_size);
@@ -528,7 +528,7 @@ static int vop_virtio_copy_to_user(struct vop_vdev *vdev, void __user *ubuf,
 				   int vr_idx)
 {
 	struct vop_device *vpdev = vdev->vpdev;
-	void __iomem *dbuf = vpdev->hw_ops->ioremap(vpdev, daddr, len);
+	void __iomem *dbuf = vpdev->hw_ops->remap(vpdev, daddr, len);
 	struct vop_vringh *vvr = &vdev->vvr[vr_idx];
 	struct vop_info *vi = dev_get_drvdata(&vpdev->dev);
 	size_t dma_alignment;
@@ -588,7 +588,7 @@ static int vop_virtio_copy_to_user(struct vop_vdev *vdev, void __user *ubuf,
 	}
 	err = 0;
 err:
-	vpdev->hw_ops->iounmap(vpdev, dbuf);
+	vpdev->hw_ops->unmap(vpdev, dbuf);
 	dev_dbg(vop_dev(vdev),
 		"%s: ubuf %p dbuf %p len 0x%zx vr_idx 0x%x\n",
 		__func__, ubuf, dbuf, len, vr_idx);
@@ -606,7 +606,7 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 				     int vr_idx)
 {
 	struct vop_device *vpdev = vdev->vpdev;
-	void __iomem *dbuf = vpdev->hw_ops->ioremap(vpdev, daddr, len);
+	void __iomem *dbuf = vpdev->hw_ops->remap(vpdev, daddr, len);
 	struct vop_vringh *vvr = &vdev->vvr[vr_idx];
 	struct vop_info *vi = dev_get_drvdata(&vdev->vpdev->dev);
 	size_t dma_alignment;
@@ -676,7 +676,7 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 	vdev->out_bytes += len;
 	err = 0;
 err:
-	vpdev->hw_ops->iounmap(vpdev, dbuf);
+	vpdev->hw_ops->unmap(vpdev, dbuf);
 	dev_dbg(vop_dev(vdev),
 		"%s: ubuf %p dbuf %p len 0x%zx vr_idx 0x%x\n",
 		__func__, ubuf, dbuf, len, vr_idx);
-- 
2.20.0

