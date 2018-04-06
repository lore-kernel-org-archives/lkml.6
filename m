Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756328AbeDFOY3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:24:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756739AbeDFOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:23:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hansverk@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: platform: fsl-viu: add __iomem annotations
Date: Fri,  6 Apr 2018 16:23:18 +0200
Message-Id: <20180406142336.2079928-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Sn/uNmomkBRdXYc/WRofuyZ0iAk7yWvJ1MTmHu3qywFsN9WEULa
 UxCv470AxDxsjnZUsjrGljCm2wwEPtD8E2iA03FLGJJtIgYfA/UGAhl6oR0Ds7LUbSSzkgi
 tuqcMlgGoLFk4BxXEJ6uLTa3wVWvwYuFX8ml9XMgC1xo1OcvIV9exeME/qshluw6bjmZ4dt
 hhLnBaGi6lbSRL9Hd5IPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gBuwMhB8lxo=:0Ktoq8v7RBk+ZsabkOnYeR
 +oa81rOUIY8PHX2p56OGRHMF16to1xQsgl7E+oCOwfQt5qp4+57EKd5FKJ2E/IGcVGkzp9Z/o
 1WUmbnU4aGOt+97mE6JHYlXrENUb335a6btwWEw9SzvH9fzv5TKNnoLmL9Xl+laxWasdBb+md
 zSkjAt51GvGYMFtncPGVJf5BxTzkEIR5tA3ZYVYB7XTdLQHIWliv8N2zoyl4FAhqg7b3luc2m
 dbch6pDYMhpqBw7tGjo2mjGoE2c/vPDAWXeq/eUjhxjLzkxWhbix7LjkdRENj90TzSy9Wxtsv
 XwbUPhqCEPy6wXSS4FuG7kR7hu9E5URtni5wyBP1dB9MYIoMyeh8n4RlB96OEX793UKAmybKQ
 nQ9qLLpvH2Lzx4SkjuRd8gsTWtfkwHYf15HuL3POF5fwPpRNswCs+UTsFTMpjR6XUlhhzYhK8
 9MuCAa1fFirRYbbSq6u0hJVBjZLJh8ozsW4JRhM3tLHKIuwDHM5zCizXigRGGWK9vW8tINJwW
 /MrbYXnUEoAnzhD5eHiXUV86HW1eYVGmpBlXTM1M2Qj2t9k3D0c4fepJwO9dK57Auxn8gM1e3
 QmczNcgQDJVKMVD4jroVOvkUWxcK1IjggNcB4sw7X4x9MnjMpqFW1wamN5EkZ+gh+r/0RoB76
 6bvol3InyrPtBjxjDl2rNtPDTWVmh9948eSMxydR2u0V2HslWyefAONXg9KgMbgjqXY+84eiZ
 SoFEcU5OQ/0ZCXNoc0VhLfwgOOnhu6JDtHRVmQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids countless sparse warnings like

   drivers/media/platform/fsl-viu.c:1081:25: sparse: incorrect type in argument 2 (different address spaces)
   drivers/media/platform/fsl-viu.c:1082:25: sparse: incorrect type in argument 2 (different address spaces)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/fsl-viu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index 200c47c69a75..cc85620267f1 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -128,7 +128,7 @@ struct viu_dev {
 	int			dma_done;
 
 	/* Hardware register area */
-	struct viu_reg		*vr;
+	struct viu_reg __iomem	*vr;
 
 	/* Interrupt vector */
 	int			irq;
@@ -244,7 +244,7 @@ struct viu_fmt *format_by_fourcc(int fourcc)
 
 void viu_start_dma(struct viu_dev *dev)
 {
-	struct viu_reg *vr = dev->vr;
+	struct viu_reg __iomem *vr = dev->vr;
 
 	dev->field = 0;
 
@@ -255,7 +255,7 @@ void viu_start_dma(struct viu_dev *dev)
 
 void viu_stop_dma(struct viu_dev *dev)
 {
-	struct viu_reg *vr = dev->vr;
+	struct viu_reg __iomem *vr = dev->vr;
 	int cnt = 100;
 	u32 status_cfg;
 
@@ -395,7 +395,7 @@ static void free_buffer(struct videobuf_queue *vq, struct viu_buf *buf)
 
 inline int buffer_activate(struct viu_dev *dev, struct viu_buf *buf)
 {
-	struct viu_reg *vr = dev->vr;
+	struct viu_reg __iomem *vr = dev->vr;
 	int bpp;
 
 	/* setup the DMA base address */
@@ -703,9 +703,9 @@ static int verify_preview(struct viu_dev *dev, struct v4l2_window *win)
 	return 0;
 }
 
-inline void viu_activate_overlay(struct viu_reg *viu_reg)
+inline void viu_activate_overlay(struct viu_reg __iomem *viu_reg)
 {
-	struct viu_reg *vr = viu_reg;
+	struct viu_reg __iomem *vr = viu_reg;
 
 	out_be32(&vr->field_base_addr, reg_val.field_base_addr);
 	out_be32(&vr->dma_inc, reg_val.dma_inc);
@@ -985,9 +985,9 @@ inline void viu_activate_next_buf(struct viu_dev *dev,
 	}
 }
 
-inline void viu_default_settings(struct viu_reg *viu_reg)
+inline void viu_default_settings(struct viu_reg __iomem *viu_reg)
 {
-	struct viu_reg *vr = viu_reg;
+	struct viu_reg __iomem *vr = viu_reg;
 
 	out_be32(&vr->luminance, 0x9512A254);
 	out_be32(&vr->chroma_r, 0x03310000);
@@ -1001,7 +1001,7 @@ inline void viu_default_settings(struct viu_reg *viu_reg)
 
 static void viu_overlay_intr(struct viu_dev *dev, u32 status)
 {
-	struct viu_reg *vr = dev->vr;
+	struct viu_reg __iomem *vr = dev->vr;
 
 	if (status & INT_DMA_END_STATUS)
 		dev->dma_done = 1;
@@ -1032,7 +1032,7 @@ static void viu_overlay_intr(struct viu_dev *dev, u32 status)
 static void viu_capture_intr(struct viu_dev *dev, u32 status)
 {
 	struct viu_dmaqueue *vidq = &dev->vidq;
-	struct viu_reg *vr = dev->vr;
+	struct viu_reg __iomem *vr = dev->vr;
 	struct viu_buf *buf;
 	int field_num;
 	int need_two;
@@ -1104,7 +1104,7 @@ static void viu_capture_intr(struct viu_dev *dev, u32 status)
 static irqreturn_t viu_intr(int irq, void *dev_id)
 {
 	struct viu_dev *dev  = (struct viu_dev *)dev_id;
-	struct viu_reg *vr = dev->vr;
+	struct viu_reg __iomem *vr = dev->vr;
 	u32 status;
 	u32 error;
 
@@ -1169,7 +1169,7 @@ static int viu_open(struct file *file)
 	struct video_device *vdev = video_devdata(file);
 	struct viu_dev *dev = video_get_drvdata(vdev);
 	struct viu_fh *fh;
-	struct viu_reg *vr;
+	struct viu_reg __iomem *vr;
 	int minor = vdev->minor;
 	u32 status_cfg;
 
@@ -1305,7 +1305,7 @@ static int viu_release(struct file *file)
 	return 0;
 }
 
-void viu_reset(struct viu_reg *reg)
+void viu_reset(struct viu_reg __iomem *reg)
 {
 	out_be32(&reg->status_cfg, 0);
 	out_be32(&reg->luminance, 0x9512a254);
-- 
2.9.0
