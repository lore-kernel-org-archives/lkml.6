Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx48Y5FS4l4aHx4qeEX8zpVsKEgqB0zO/I4XxkR2IpW8NtiBFP4oh8J8pjTeZ/luuSpvYJRKl
ARC-Seal: i=1; a=rsa-sha256; t=1522963202; cv=none;
        d=google.com; s=arc-20160816;
        b=T3cOAAa8oihdgNdfd8r9SRaupCaO1RtgthsS3Bfh0eCU+uregnM5TQk4c0B0TkkNA4
         CmiPXpGjwYC2E7Z4a8KGfI7YT/eV0Z0R/qXPEsntKnaCaWUniYnJcEECLL0du5Vu2EzC
         CIV7QZoy5IMaGvG5WIJ2owCeR9C6yE81d0pVrSWfjZoLJGCv9lssCQGvlaZ5r+CPwfUt
         Pt7bnPPYA13hJwPoraVE2R5NeXG/xe62032HYZQe2BEbyWSvmTLHUU6lJspv154BMIYy
         6IDb4+wN1B3BMkFUpboBFcODDUgazIz8NcIwzMx6e21PgVc0F3AEPZMOKWPFNkI2CbnK
         /PrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=tRCHeP2t/aC7J+LLXXtQjy7VDKcy7wUmLFZd01jEWZg=;
        b=WIJawBk9lwA7QNuoQBqbtDAvZlWsBzjRo1jMATpa5oCvPG+it8PD5dIoAkCnP1Qutv
         w03BunkGmS4IlkOP8gg7VseLSHQ08LaaX1zW4w+6YWaSyWZoyya1l2lihO4lzG7Ajk7H
         tJfWWQvcW8nujgI4CXqrSvl6LeF2iOjTCxzB2O48nsV73FYTOAly+rO/nKv1aRecUkEJ
         j8p56dbepl4KMlKE9YS2F6YkYfyGSicK/s2X2Ly/rHKkH4QGNGXjmZxLkCMSOfBFcsIO
         2+tJSHFU6/pv/aOzxlgyhFm32MY26Rgy5K8gpctshTK3tght3gZ/TOpQip2KIX8YxWtW
         y1Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=X1TrIfEJ;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.77 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=X1TrIfEJ;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.77 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="377269305"
Date: Thu, 5 Apr 2018 14:22:47 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 08/10] staging: fnic2 add vnic queue interface
Message-ID: <20180405212247.GI12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942662945099275?=
X-GMAIL-MSGID: =?utf-8?q?1596942662945099275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain low level queueing interfaces
for hardware.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/vnic_cq.c      |  85 ++++++++++++
 drivers/staging/fnic2/src/vnic_cq.h      | 120 ++++++++++++++++
 drivers/staging/fnic2/src/vnic_cq_copy.h |  61 ++++++++
 drivers/staging/fnic2/src/vnic_rq.c      | 196 ++++++++++++++++++++++++++
 drivers/staging/fnic2/src/vnic_rq.h      | 231 +++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/vnic_wq.c      | 183 ++++++++++++++++++++++++
 drivers/staging/fnic2/src/vnic_wq.h      | 174 +++++++++++++++++++++++
 drivers/staging/fnic2/src/vnic_wq_copy.c | 115 +++++++++++++++
 drivers/staging/fnic2/src/vnic_wq_copy.h | 127 +++++++++++++++++
 9 files changed, 1292 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/vnic_cq.c
 create mode 100644 drivers/staging/fnic2/src/vnic_cq.h
 create mode 100644 drivers/staging/fnic2/src/vnic_cq_copy.h
 create mode 100644 drivers/staging/fnic2/src/vnic_rq.c
 create mode 100644 drivers/staging/fnic2/src/vnic_rq.h
 create mode 100644 drivers/staging/fnic2/src/vnic_wq.c
 create mode 100644 drivers/staging/fnic2/src/vnic_wq.h
 create mode 100644 drivers/staging/fnic2/src/vnic_wq_copy.c
 create mode 100644 drivers/staging/fnic2/src/vnic_wq_copy.h

diff --git a/drivers/staging/fnic2/src/vnic_cq.c b/drivers/staging/fnic2/src/vnic_cq.c
new file mode 100644
index 0000000..ac78b1b
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_cq.c
@@ -0,0 +1,85 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include "vnic_dev.h"
+#include "vnic_cq.h"
+
+void vnic_cq_free(struct vnic_cq *cq)
+{
+	vnic_dev_free_desc_ring(cq->vdev, &cq->ring);
+
+	cq->ctrl = NULL;
+}
+
+int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size)
+{
+	int err;
+
+	cq->index = index;
+	cq->vdev = vdev;
+
+	cq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_CQ, index);
+	if (!cq->ctrl) {
+		pr_err("Failed to hook CQ[%d] resource\n", index);
+		return -EINVAL;
+	}
+
+	err = vnic_dev_alloc_desc_ring(vdev, &cq->ring, desc_count, desc_size);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
+		  unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
+		  unsigned int cq_tail_color, unsigned int interrupt_enable,
+		  unsigned int cq_entry_enable, unsigned int cq_message_enable,
+		  unsigned int interrupt_offset, uint64_t cq_message_addr)
+{
+	uint64_t paddr;
+
+	paddr = (uint64_t)cq->ring.base_addr | VNIC_PADDR_TARGET;
+	writeq(paddr, &cq->ctrl->ring_base);
+	iowrite32(cq->ring.desc_count, &cq->ctrl->ring_size);
+	iowrite32(flow_control_enable, &cq->ctrl->flow_control_enable);
+	iowrite32(color_enable, &cq->ctrl->color_enable);
+	iowrite32(cq_head, &cq->ctrl->cq_head);
+	iowrite32(cq_tail, &cq->ctrl->cq_tail);
+	iowrite32(cq_tail_color, &cq->ctrl->cq_tail_color);
+	iowrite32(interrupt_enable, &cq->ctrl->interrupt_enable);
+	iowrite32(cq_entry_enable, &cq->ctrl->cq_entry_enable);
+	iowrite32(cq_message_enable, &cq->ctrl->cq_message_enable);
+	iowrite32(interrupt_offset, &cq->ctrl->interrupt_offset);
+	writeq(cq_message_addr, &cq->ctrl->cq_message_addr);
+}
+
+void vnic_cq_clean(struct vnic_cq *cq)
+{
+	cq->to_clean = 0;
+	cq->last_color = 0;
+
+	iowrite32(0, &cq->ctrl->cq_head);
+	iowrite32(0, &cq->ctrl->cq_tail);
+	iowrite32(1, &cq->ctrl->cq_tail_color);
+
+	vnic_dev_clear_desc_ring(&cq->ring);
+}
diff --git a/drivers/staging/fnic2/src/vnic_cq.h b/drivers/staging/fnic2/src/vnic_cq.h
new file mode 100644
index 0000000..010c044
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_cq.h
@@ -0,0 +1,120 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifndef _VNIC_CQ_H_
+#define _VNIC_CQ_H_
+
+#include "cq_desc.h"
+#include "vnic_dev.h"
+
+/*
+ * These defines avoid symbol clash between fnic2 and enic (Cisco 10G Eth
+ * Driver) when both are built with CONFIG options =y
+ */
+#define vnic_cq_service fnic2_cq_service
+#define vnic_cq_free fnic2_cq_free
+#define vnic_cq_alloc fnic2_cq_alloc
+#define vnic_cq_init fnic2_cq_init
+#define vnic_cq_clean fnic2_cq_clean
+
+/* Completion queue control */
+struct vnic_cq_ctrl {
+	uint64_t	ring_base;		/* 0x00 */
+	uint32_t	ring_size;		/* 0x08 */
+	uint32_t	pad0;
+	uint32_t	flow_control_enable;	/* 0x10 */
+	uint32_t	pad1;
+	uint32_t	color_enable;		/* 0x18 */
+	uint32_t	pad2;
+	uint32_t	cq_head;		/* 0x20 */
+	uint32_t	pad3;
+	uint32_t	cq_tail;		/* 0x28 */
+	uint32_t	pad4;
+	uint32_t	cq_tail_color;		/* 0x30 */
+	uint32_t	pad5;
+	uint32_t	interrupt_enable;	/* 0x38 */
+	uint32_t	pad6;
+	uint32_t	cq_entry_enable;	/* 0x40 */
+	uint32_t	pad7;
+	uint32_t	cq_message_enable;	/* 0x48 */
+	uint32_t	pad8;
+	uint32_t	interrupt_offset;	/* 0x50 */
+	uint32_t	pad9;
+	uint64_t	cq_message_addr;	/* 0x58 */
+	uint32_t	pad10;
+};
+
+struct vnic_cq {
+	unsigned int		index;
+	struct vnic_dev		*vdev;
+	struct vnic_cq_ctrl	__iomem *ctrl;	/* memory-mapped */
+	struct vnic_dev_ring	ring;
+	unsigned int		to_clean;
+	unsigned int		last_color;
+};
+
+static inline unsigned int vnic_cq_service(struct vnic_cq *cq,
+					   unsigned int work_to_do,
+					   int (*q_service)(struct vnic_dev *vdev, struct cq_desc *cq_desc,
+					   uint8_t type, uint16_t q_number, uint16_t completed_index))
+{
+	struct cq_desc *cq_desc;
+	unsigned int work_done = 0;
+	uint16_t q_number, completed_index;
+	uint8_t type, color;
+
+	cq_desc = (struct cq_desc *)((uint8_t *)cq->ring.descs +
+		cq->ring.desc_size * cq->to_clean);
+	cq_desc_dec(cq_desc, &type, &color,
+		&q_number, &completed_index);
+
+	while (color != cq->last_color) {
+
+		if ((*q_service)(cq->vdev, cq_desc, type,
+			q_number, completed_index))
+			break;
+
+		cq->to_clean++;
+		if (cq->to_clean == cq->ring.desc_count) {
+			cq->to_clean = 0;
+			cq->last_color = cq->last_color ? 0 : 1;
+		}
+
+		cq_desc = (struct cq_desc *)((uint8_t *)cq->ring.descs +
+			cq->ring.desc_size * cq->to_clean);
+		cq_desc_dec(cq_desc, &type, &color,
+			&q_number, &completed_index);
+
+		work_done++;
+		if (work_done >= work_to_do)
+			break;
+	}
+
+	return work_done;
+}
+
+void vnic_cq_free(struct vnic_cq *cq);
+int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size);
+void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
+		  unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
+		  unsigned int cq_tail_color, unsigned int interrupt_enable,
+		  unsigned int cq_entry_enable, unsigned int message_enable,
+		  unsigned int interrupt_offset, uint64_t message_addr);
+void vnic_cq_clean(struct vnic_cq *cq);
+
+#endif /* _VNIC_CQ_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_cq_copy.h b/drivers/staging/fnic2/src/vnic_cq_copy.h
new file mode 100644
index 0000000..2ddf0b5
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_cq_copy.h
@@ -0,0 +1,61 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifndef _VNIC_CQ_COPY_H_
+#define _VNIC_CQ_COPY_H_
+
+#include "fcpio.h"
+
+static inline unsigned int vnic_cq_copy_service(struct vnic_cq *cq,
+						int (*q_service)(struct vnic_dev *vdev,
+						unsigned int index,
+						struct fcpio_fw_req *desc),
+						unsigned int work_to_do)
+
+{
+	struct fcpio_fw_req *desc;
+	unsigned int work_done = 0;
+	uint8_t color;
+
+	desc = (struct fcpio_fw_req *)((uint8_t *)cq->ring.descs +
+		cq->ring.desc_size * cq->to_clean);
+	fcpio_color_dec(desc, &color);
+
+	while (color != cq->last_color) {
+
+		if ((*q_service)(cq->vdev, cq->index, desc))
+			break;
+
+		cq->to_clean++;
+		if (cq->to_clean == cq->ring.desc_count) {
+			cq->to_clean = 0;
+			cq->last_color = cq->last_color ? 0 : 1;
+		}
+
+		desc = (struct fcpio_fw_req *)((uint8_t *)cq->ring.descs +
+			cq->ring.desc_size * cq->to_clean);
+		fcpio_color_dec(desc, &color);
+
+		work_done++;
+		if (work_done >= work_to_do)
+			break;
+	}
+
+	return work_done;
+}
+
+#endif /* _VNIC_CQ_COPY_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_rq.c b/drivers/staging/fnic2/src/vnic_rq.c
new file mode 100644
index 0000000..1569091
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_rq.c
@@ -0,0 +1,196 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include "vnic_dev.h"
+#include "vnic_rq.h"
+
+static int vnic_rq_alloc_bufs(struct vnic_rq *rq)
+{
+	struct vnic_rq_buf *buf;
+	struct vnic_dev *vdev;
+	unsigned int i, j, count = rq->ring.desc_count;
+	unsigned int blks = VNIC_RQ_BUF_BLKS_NEEDED(count);
+
+	vdev = rq->vdev;
+
+	for (i = 0; i < blks; i++) {
+		rq->bufs[i] = kzalloc(VNIC_RQ_BUF_BLK_SZ, GFP_ATOMIC);
+		if (!rq->bufs[i]) {
+			pr_err("Failed to alloc rq_bufs\n");
+			return -ENOMEM;
+		}
+	}
+
+	for (i = 0; i < blks; i++) {
+		buf = rq->bufs[i];
+		for (j = 0; j < VNIC_RQ_BUF_BLK_ENTRIES; j++) {
+			buf->index = i * VNIC_RQ_BUF_BLK_ENTRIES + j;
+			buf->desc = (uint8_t *)rq->ring.descs +
+				rq->ring.desc_size * buf->index;
+			if (buf->index + 1 == count) {
+				buf->next = rq->bufs[0];
+				break;
+			} else if (j + 1 == VNIC_RQ_BUF_BLK_ENTRIES) {
+				buf->next = rq->bufs[i + 1];
+			} else {
+				buf->next = buf + 1;
+				buf++;
+			}
+		}
+	}
+
+	rq->to_use = rq->to_clean = rq->bufs[0];
+	rq->buf_index = 0;
+
+	return 0;
+}
+
+void vnic_rq_free(struct vnic_rq *rq)
+{
+	struct vnic_dev *vdev;
+	unsigned int i;
+
+	vdev = rq->vdev;
+
+	vnic_dev_free_desc_ring(vdev, &rq->ring);
+
+	for (i = 0; i < VNIC_RQ_BUF_BLKS_MAX; i++) {
+		kfree(rq->bufs[i]);
+		rq->bufs[i] = NULL;
+	}
+
+	rq->ctrl = NULL;
+}
+
+int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size)
+{
+	int err;
+
+	rq->index = index;
+	rq->vdev = vdev;
+
+	rq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_RQ, index);
+	if (!rq->ctrl) {
+		pr_err("Failed to hook RQ[%d] resource\n", index);
+		return -EINVAL;
+	}
+
+	vnic_rq_disable(rq);
+
+	err = vnic_dev_alloc_desc_ring(vdev, &rq->ring, desc_count, desc_size);
+	if (err)
+		return err;
+
+	err = vnic_rq_alloc_bufs(rq);
+	if (err) {
+		vnic_rq_free(rq);
+		return err;
+	}
+
+	return 0;
+}
+
+void vnic_rq_init(struct vnic_rq *rq, unsigned int cq_index,
+		  unsigned int error_interrupt_enable,
+		  unsigned int error_interrupt_offset)
+{
+	uint64_t paddr;
+	uint32_t fetch_index;
+
+	paddr = (uint64_t)rq->ring.base_addr | VNIC_PADDR_TARGET;
+	writeq(paddr, &rq->ctrl->ring_base);
+	iowrite32(rq->ring.desc_count, &rq->ctrl->ring_size);
+	iowrite32(cq_index, &rq->ctrl->cq_index);
+	iowrite32(error_interrupt_enable, &rq->ctrl->error_interrupt_enable);
+	iowrite32(error_interrupt_offset, &rq->ctrl->error_interrupt_offset);
+	iowrite32(0, &rq->ctrl->dropped_packet_count);
+	iowrite32(0, &rq->ctrl->error_status);
+
+	/* Use current fetch_index as the ring starting point */
+	fetch_index = ioread32(&rq->ctrl->fetch_index);
+	rq->to_use = rq->to_clean =
+		&rq->bufs[fetch_index / VNIC_RQ_BUF_BLK_ENTRIES]
+			[fetch_index % VNIC_RQ_BUF_BLK_ENTRIES];
+	iowrite32(fetch_index, &rq->ctrl->posted_index);
+
+	rq->buf_index = 0;
+}
+
+unsigned int vnic_rq_error_status(struct vnic_rq *rq)
+{
+	return ioread32(&rq->ctrl->error_status);
+}
+
+void vnic_rq_enable(struct vnic_rq *rq)
+{
+	iowrite32(1, &rq->ctrl->enable);
+}
+
+int vnic_rq_disable(struct vnic_rq *rq)
+{
+	unsigned int wait;
+
+	iowrite32(0, &rq->ctrl->enable);
+
+	/* Wait for HW to ACK disable request */
+	for (wait = 0; wait < 100; wait++) {
+		if (!(ioread32(&rq->ctrl->running)))
+			return 0;
+		udelay(1);
+	}
+
+	pr_err("Failed to disable RQ[%d]\n", rq->index);
+
+	return -ETIMEDOUT;
+}
+
+void vnic_rq_clean(struct vnic_rq *rq,
+		   void (*buf_clean)(struct vnic_rq *rq, struct vnic_rq_buf *buf))
+{
+	struct vnic_rq_buf *buf;
+	uint32_t fetch_index;
+
+	WARN_ON(ioread32(&rq->ctrl->enable));
+
+	buf = rq->to_clean;
+
+	while (vnic_rq_desc_used(rq) > 0) {
+
+		(*buf_clean)(rq, buf);
+
+		buf = rq->to_clean = buf->next;
+		rq->ring.desc_avail++;
+	}
+
+	/* Use current fetch_index as the ring starting point */
+	fetch_index = ioread32(&rq->ctrl->fetch_index);
+	rq->to_use = rq->to_clean =
+		&rq->bufs[fetch_index / VNIC_RQ_BUF_BLK_ENTRIES]
+			[fetch_index % VNIC_RQ_BUF_BLK_ENTRIES];
+	iowrite32(fetch_index, &rq->ctrl->posted_index);
+
+	rq->buf_index = 0;
+
+	vnic_dev_clear_desc_ring(&rq->ring);
+}
diff --git a/drivers/staging/fnic2/src/vnic_rq.h b/drivers/staging/fnic2/src/vnic_rq.h
new file mode 100644
index 0000000..4ffea9a
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_rq.h
@@ -0,0 +1,231 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifndef _VNIC_RQ_H_
+#define _VNIC_RQ_H_
+
+#include <linux/pci.h>
+#include "vnic_dev.h"
+#include "vnic_cq.h"
+
+/*
+ * These defines avoid symbol clash between fnic2 and enic (Cisco 10G Eth
+ * Driver) when both are built with CONFIG options =y
+ */
+#define vnic_rq_desc_avail fnic2_rq_desc_avail
+#define vnic_rq_desc_used fnic2_rq_desc_used
+#define vnic_rq_next_desc fnic2_rq_next_desc
+#define vnic_rq_next_index fnic2_rq_next_index
+#define vnic_rq_next_buf_index fnic2_rq_next_buf_index
+#define vnic_rq_post fnic2_rq_post
+#define vnic_rq_posting_soon fnic2_rq_posting_soon
+#define vnic_rq_return_descs fnic2_rq_return_descs
+#define vnic_rq_service fnic2_rq_service
+#define vnic_rq_fill fnic2_rq_fill
+#define vnic_rq_free fnic2_rq_free
+#define vnic_rq_alloc fnic2_rq_alloc
+#define vnic_rq_init fnic2_rq_init
+#define vnic_rq_error_status fnic2_rq_error_status
+#define vnic_rq_enable fnic2_rq_enable
+#define vnic_rq_disable fnic2_rq_disable
+#define vnic_rq_clean fnic2_rq_clean
+
+/* Receive queue control */
+struct vnic_rq_ctrl {
+	uint64_t ring_base;			/* 0x00 */
+	uint32_t ring_size;			/* 0x08 */
+	uint32_t pad0;
+	uint32_t posted_index;		/* 0x10 */
+	uint32_t pad1;
+	uint32_t cq_index;			/* 0x18 */
+	uint32_t pad2;
+	uint32_t enable;			/* 0x20 */
+	uint32_t pad3;
+	uint32_t running;			/* 0x28 */
+	uint32_t pad4;
+	uint32_t fetch_index;		/* 0x30 */
+	uint32_t pad5;
+	uint32_t error_interrupt_enable;	/* 0x38 */
+	uint32_t pad6;
+	uint32_t error_interrupt_offset;	/* 0x40 */
+	uint32_t pad7;
+	uint32_t error_status;		/* 0x48 */
+	uint32_t pad8;
+	uint32_t dropped_packet_count;	/* 0x50 */
+	uint32_t pad9;
+	uint32_t dropped_packet_count_rc;	/* 0x58 */
+	uint32_t pad10;
+};
+
+/* Break the vnic_rq_buf allocations into blocks of 64 entries */
+#define VNIC_RQ_BUF_BLK_ENTRIES 64
+#define VNIC_RQ_BUF_BLK_SZ \
+	(VNIC_RQ_BUF_BLK_ENTRIES * sizeof(struct vnic_rq_buf))
+#define VNIC_RQ_BUF_BLKS_NEEDED(entries) \
+	DIV_ROUND_UP(entries, VNIC_RQ_BUF_BLK_ENTRIES)
+#define VNIC_RQ_BUF_BLKS_MAX VNIC_RQ_BUF_BLKS_NEEDED(4096)
+
+#define VNIC_RQ_RETURN_DESC 0
+
+#ifndef VNIC_RQ_RETURN_RATE
+#define VNIC_RQ_RETURN_RATE             0xf     /* keep 2^n - 1 */
+#endif
+
+struct vnic_rq_buf {
+	struct vnic_rq_buf	*next;
+	dma_addr_t		dma_addr;
+	void			*os_buf;
+	unsigned int		os_buf_index;
+	unsigned int		len;
+	unsigned int		index;
+	void			*desc;
+};
+
+struct vnic_rq {
+	unsigned int			index;
+	struct vnic_dev			*vdev;
+	struct vnic_rq_ctrl __iomem	*ctrl;	/* memory-mapped */
+	struct vnic_dev_ring		ring;
+	struct vnic_rq_buf		*bufs[VNIC_RQ_BUF_BLKS_MAX];
+	struct vnic_rq_buf		*to_use;
+	struct vnic_rq_buf		*to_clean;
+	void				*os_buf_head;
+	unsigned int			buf_index;
+	unsigned int			pkts_outstanding;
+};
+
+static inline unsigned int vnic_rq_desc_avail(struct vnic_rq *rq)
+{
+	/* how many does SW own? */
+	return rq->ring.desc_avail;
+}
+
+static inline unsigned int vnic_rq_desc_used(struct vnic_rq *rq)
+{
+	/* how many does HW own? */
+	return rq->ring.desc_count - rq->ring.desc_avail - 1;
+}
+
+static inline void *vnic_rq_next_desc(struct vnic_rq *rq)
+{
+	return rq->to_use->desc;
+}
+
+static inline unsigned int vnic_rq_next_index(struct vnic_rq *rq)
+{
+	return rq->to_use->index;
+}
+
+static inline unsigned int vnic_rq_next_buf_index(struct vnic_rq *rq)
+{
+	return rq->buf_index++;
+}
+
+static inline void vnic_rq_post(struct vnic_rq *rq,
+				void *os_buf, unsigned int os_buf_index,
+				dma_addr_t dma_addr, unsigned int len)
+{
+	struct vnic_rq_buf *buf = rq->to_use;
+
+	buf->os_buf = os_buf;
+	buf->os_buf_index = os_buf_index;
+	buf->dma_addr = dma_addr;
+	buf->len = len;
+
+	buf = buf->next;
+	rq->to_use = buf;
+	rq->ring.desc_avail--;
+
+	/* Move the posted_index every nth descriptor
+	 */
+	if ((buf->index & VNIC_RQ_RETURN_RATE) == 0) {
+		/* Adding write memory barrier prevents compiler and/or CPU
+		 * reordering, thus avoiding descriptor posting before
+		 * descriptor is initialized. Otherwise, hardware can read
+		 * stale descriptor fields.
+		 */
+		wmb();
+		iowrite32(buf->index, &rq->ctrl->posted_index);
+	}
+}
+
+static inline int vnic_rq_posting_soon(struct vnic_rq *rq)
+{
+	return (rq->to_use->index & VNIC_RQ_RETURN_RATE) == 0;
+}
+
+static inline void vnic_rq_return_descs(struct vnic_rq *rq, unsigned int count)
+{
+	rq->ring.desc_avail += count;
+}
+
+static inline void vnic_rq_service(struct vnic_rq *rq,
+				   struct cq_desc *cq_desc, uint16_t completed_index,
+				   int desc_return, void (*buf_service)(struct vnic_rq *rq,
+				   struct cq_desc *cq_desc, struct vnic_rq_buf *buf,
+				   int skipped))
+{
+	struct vnic_rq_buf *buf;
+	int skipped;
+
+	buf = rq->to_clean;
+	while (1) {
+
+		skipped = (buf->index != completed_index);
+
+		(*buf_service)(rq, cq_desc, buf, skipped);
+
+		if (desc_return == VNIC_RQ_RETURN_DESC)
+			rq->ring.desc_avail++;
+
+		rq->to_clean = buf->next;
+
+		if (!skipped)
+			break;
+
+		buf = rq->to_clean;
+	}
+}
+
+static inline int vnic_rq_fill(struct vnic_rq *rq,
+			       int (*buf_fill)(struct vnic_rq *rq))
+{
+	int err;
+
+	while (vnic_rq_desc_avail(rq) > 1) {
+
+		err = (*buf_fill)(rq);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void vnic_rq_free(struct vnic_rq *rq);
+int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size);
+void vnic_rq_init(struct vnic_rq *rq, unsigned int cq_index,
+		  unsigned int error_interrupt_enable,
+		  unsigned int error_interrupt_offset);
+unsigned int vnic_rq_error_status(struct vnic_rq *rq);
+void vnic_rq_enable(struct vnic_rq *rq);
+int vnic_rq_disable(struct vnic_rq *rq);
+void vnic_rq_clean(struct vnic_rq *rq,
+		   void (*buf_clean)(struct vnic_rq *rq, struct vnic_rq_buf *buf));
+
+#endif /* _VNIC_RQ_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_wq.c b/drivers/staging/fnic2/src/vnic_wq.c
new file mode 100644
index 0000000..75138f0
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_wq.c
@@ -0,0 +1,183 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+
+static int vnic_wq_alloc_bufs(struct vnic_wq *wq)
+{
+	struct vnic_wq_buf *buf;
+	struct vnic_dev *vdev;
+	unsigned int i, j, count = wq->ring.desc_count;
+	unsigned int blks = VNIC_WQ_BUF_BLKS_NEEDED(count);
+
+	vdev = wq->vdev;
+
+	for (i = 0; i < blks; i++) {
+		wq->bufs[i] = kzalloc(VNIC_WQ_BUF_BLK_SZ, GFP_ATOMIC);
+		if (!wq->bufs[i]) {
+			pr_err("Failed to alloc wq_bufs\n");
+			return -ENOMEM;
+		}
+	}
+
+	for (i = 0; i < blks; i++) {
+		buf = wq->bufs[i];
+		for (j = 0; j < VNIC_WQ_BUF_BLK_ENTRIES; j++) {
+			buf->index = i * VNIC_WQ_BUF_BLK_ENTRIES + j;
+			buf->desc = (uint8_t *)wq->ring.descs +
+				wq->ring.desc_size * buf->index;
+			if (buf->index + 1 == count) {
+				buf->next = wq->bufs[0];
+				break;
+			} else if (j + 1 == VNIC_WQ_BUF_BLK_ENTRIES) {
+				buf->next = wq->bufs[i + 1];
+			} else {
+				buf->next = buf + 1;
+				buf++;
+			}
+		}
+	}
+
+	wq->to_use = wq->to_clean = wq->bufs[0];
+
+	return 0;
+}
+
+void vnic_wq_free(struct vnic_wq *wq)
+{
+	struct vnic_dev *vdev;
+	unsigned int i;
+
+	vdev = wq->vdev;
+
+	vnic_dev_free_desc_ring(vdev, &wq->ring);
+
+	for (i = 0; i < VNIC_WQ_BUF_BLKS_MAX; i++) {
+		kfree(wq->bufs[i]);
+		wq->bufs[i] = NULL;
+	}
+
+	wq->ctrl = NULL;
+
+}
+
+int vnic_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size)
+{
+	int err;
+
+	wq->index = index;
+	wq->vdev = vdev;
+
+	wq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_WQ, index);
+	if (!wq->ctrl) {
+		pr_err("Failed to hook WQ[%d] resource\n", index);
+		return -EINVAL;
+	}
+
+	vnic_wq_disable(wq);
+
+	err = vnic_dev_alloc_desc_ring(vdev, &wq->ring, desc_count, desc_size);
+	if (err)
+		return err;
+
+	err = vnic_wq_alloc_bufs(wq);
+	if (err) {
+		vnic_wq_free(wq);
+		return err;
+	}
+
+	return 0;
+}
+
+void vnic_wq_init(struct vnic_wq *wq, unsigned int cq_index,
+		  unsigned int error_interrupt_enable,
+		  unsigned int error_interrupt_offset)
+{
+	uint64_t paddr;
+
+	paddr = (uint64_t)wq->ring.base_addr | VNIC_PADDR_TARGET;
+	writeq(paddr, &wq->ctrl->ring_base);
+	iowrite32(wq->ring.desc_count, &wq->ctrl->ring_size);
+	iowrite32(0, &wq->ctrl->fetch_index);
+	iowrite32(0, &wq->ctrl->posted_index);
+	iowrite32(cq_index, &wq->ctrl->cq_index);
+	iowrite32(error_interrupt_enable, &wq->ctrl->error_interrupt_enable);
+	iowrite32(error_interrupt_offset, &wq->ctrl->error_interrupt_offset);
+	iowrite32(0, &wq->ctrl->error_status);
+}
+
+unsigned int vnic_wq_error_status(struct vnic_wq *wq)
+{
+	return ioread32(&wq->ctrl->error_status);
+}
+
+void vnic_wq_enable(struct vnic_wq *wq)
+{
+	iowrite32(1, &wq->ctrl->enable);
+}
+
+int vnic_wq_disable(struct vnic_wq *wq)
+{
+	unsigned int wait;
+
+	iowrite32(0, &wq->ctrl->enable);
+
+	/* Wait for HW to ACK disable request */
+	for (wait = 0; wait < 100; wait++) {
+		if (!(ioread32(&wq->ctrl->running)))
+			return 0;
+		udelay(1);
+	}
+
+	pr_err("Failed to disable WQ[%d]\n", wq->index);
+
+	return -ETIMEDOUT;
+}
+
+void vnic_wq_clean(struct vnic_wq *wq,
+		   void (*buf_clean)(struct vnic_wq *wq, struct vnic_wq_buf *buf))
+{
+	struct vnic_wq_buf *buf;
+
+	WARN_ON(ioread32(&wq->ctrl->enable));
+
+	buf = wq->to_clean;
+
+	while (vnic_wq_desc_used(wq) > 0) {
+
+		(*buf_clean)(wq, buf);
+
+		buf = wq->to_clean = buf->next;
+		wq->ring.desc_avail++;
+	}
+
+	wq->to_use = wq->to_clean = wq->bufs[0];
+
+	iowrite32(0, &wq->ctrl->fetch_index);
+	iowrite32(0, &wq->ctrl->posted_index);
+	iowrite32(0, &wq->ctrl->error_status);
+
+	vnic_dev_clear_desc_ring(&wq->ring);
+}
diff --git a/drivers/staging/fnic2/src/vnic_wq.h b/drivers/staging/fnic2/src/vnic_wq.h
new file mode 100644
index 0000000..bff2f4d
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_wq.h
@@ -0,0 +1,174 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifndef _VNIC_WQ_H_
+#define _VNIC_WQ_H_
+
+#include <linux/pci.h>
+#include "vnic_dev.h"
+#include "vnic_cq.h"
+
+/*
+ * These defines avoid symbol clash between fnic2 and enic (Cisco 10G Eth
+ * Driver) when both are built with CONFIG options =y
+ */
+#define vnic_wq_desc_avail fnic2_wq_desc_avail
+#define vnic_wq_desc_used fnic2_wq_desc_used
+#define vnic_wq_next_desc fni_cwq_next_desc
+#define vnic_wq_post fnic2_wq_post
+#define vnic_wq_service fnic2_wq_service
+#define vnic_wq_free fnic2_wq_free
+#define vnic_wq_alloc fnic2_wq_alloc
+#define vnic_wq_init fnic2_wq_init
+#define vnic_wq_error_status fnic2_wq_error_status
+#define vnic_wq_enable fnic2_wq_enable
+#define vnic_wq_disable fnic2_wq_disable
+#define vnic_wq_clean fnic2_wq_clean
+
+/* Work queue control */
+struct vnic_wq_ctrl {
+	uint64_t ring_base;			/* 0x00 */
+	uint32_t ring_size;			/* 0x08 */
+	uint32_t pad0;
+	uint32_t posted_index;			/* 0x10 */
+	uint32_t pad1;
+	uint32_t cq_index;			/* 0x18 */
+	uint32_t pad2;
+	uint32_t enable;			/* 0x20 */
+	uint32_t pad3;
+	uint32_t running;			/* 0x28 */
+	uint32_t pad4;
+	uint32_t fetch_index;			/* 0x30 */
+	uint32_t pad5;
+	uint32_t dca_value;			/* 0x38 */
+	uint32_t pad6;
+	uint32_t error_interrupt_enable;	/* 0x40 */
+	uint32_t pad7;
+	uint32_t error_interrupt_offset;	/* 0x48 */
+	uint32_t pad8;
+	uint32_t error_status;			/* 0x50 */
+	uint32_t pad9;
+};
+
+struct vnic_wq_buf {
+	struct vnic_wq_buf	*next;
+	dma_addr_t		dma_addr;
+	void			*os_buf;
+	unsigned int		len;
+	unsigned int		index;
+	int			sop;
+	void			*desc;
+};
+
+/* Break the vnic_wq_buf allocations into blocks of 64 entries */
+#define VNIC_WQ_BUF_BLK_ENTRIES 64
+#define VNIC_WQ_BUF_BLK_SZ \
+	(VNIC_WQ_BUF_BLK_ENTRIES * sizeof(struct vnic_wq_buf))
+#define VNIC_WQ_BUF_BLKS_NEEDED(entries) \
+	DIV_ROUND_UP(entries, VNIC_WQ_BUF_BLK_ENTRIES)
+#define VNIC_WQ_BUF_BLKS_MAX VNIC_WQ_BUF_BLKS_NEEDED(4096)
+
+struct vnic_wq {
+	unsigned int			index;
+	struct vnic_dev			*vdev;
+	struct vnic_wq_ctrl __iomem	*ctrl;	/* memory-mapped */
+	struct vnic_dev_ring		ring;
+	struct vnic_wq_buf		*bufs[VNIC_WQ_BUF_BLKS_MAX];
+	struct vnic_wq_buf		*to_use;
+	struct vnic_wq_buf		*to_clean;
+	unsigned int			pkts_outstanding;
+};
+
+static inline unsigned int vnic_wq_desc_avail(struct vnic_wq *wq)
+{
+	/* how many does SW own? */
+	return wq->ring.desc_avail;
+}
+
+static inline unsigned int vnic_wq_desc_used(struct vnic_wq *wq)
+{
+	/* how many does HW own? */
+	return wq->ring.desc_count - wq->ring.desc_avail - 1;
+}
+
+static inline void *vnic_wq_next_desc(struct vnic_wq *wq)
+{
+	return wq->to_use->desc;
+}
+
+static inline void vnic_wq_post(struct vnic_wq *wq,
+				void *os_buf, dma_addr_t dma_addr,
+				unsigned int len, int sop, int eop)
+{
+	struct vnic_wq_buf *buf = wq->to_use;
+
+	buf->sop = sop;
+	buf->os_buf = eop ? os_buf : NULL;
+	buf->dma_addr = dma_addr;
+	buf->len = len;
+
+	buf = buf->next;
+	if (eop) {
+		/* Adding write memory barrier prevents compiler and/or CPU
+		 * reordering, thus avoiding descriptor posting before
+		 * descriptor is initialized. Otherwise, hardware can read
+		 * stale descriptor fields.
+		 */
+		wmb();
+		iowrite32(buf->index, &wq->ctrl->posted_index);
+	}
+	wq->to_use = buf;
+
+	wq->ring.desc_avail--;
+}
+
+static inline void vnic_wq_service(struct vnic_wq *wq,
+				   struct cq_desc *cq_desc, uint16_t completed_index,
+				   void (*buf_service)(struct vnic_wq *wq,
+				   struct cq_desc *cq_desc, struct vnic_wq_buf *buf))
+{
+	struct vnic_wq_buf *buf;
+
+	buf = wq->to_clean;
+	while (1) {
+
+		(*buf_service)(wq, cq_desc, buf);
+
+		wq->ring.desc_avail++;
+
+		wq->to_clean = buf->next;
+
+		if (buf->index == completed_index)
+			break;
+
+		buf = wq->to_clean;
+	}
+}
+
+void vnic_wq_free(struct vnic_wq *wq);
+int vnic_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size);
+void vnic_wq_init(struct vnic_wq *wq, unsigned int cq_index,
+		  unsigned int error_interrupt_enable,
+		  unsigned int error_interrupt_offset);
+unsigned int vnic_wq_error_status(struct vnic_wq *wq);
+void vnic_wq_enable(struct vnic_wq *wq);
+int vnic_wq_disable(struct vnic_wq *wq);
+void vnic_wq_clean(struct vnic_wq *wq,
+		   void (*buf_clean)(struct vnic_wq *wq, struct vnic_wq_buf *buf));
+
+#endif /* _VNIC_WQ_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_wq_copy.c b/drivers/staging/fnic2/src/vnic_wq_copy.c
new file mode 100644
index 0000000..605c693
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_wq_copy.c
@@ -0,0 +1,115 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include "vnic_wq_copy.h"
+
+void vnic_wq_copy_enable(struct vnic_wq_copy *wq)
+{
+	iowrite32(1, &wq->ctrl->enable);
+}
+
+int vnic_wq_copy_disable(struct vnic_wq_copy *wq)
+{
+	unsigned int wait;
+
+	iowrite32(0, &wq->ctrl->enable);
+
+	/* Wait for HW to ACK disable request */
+	for (wait = 0; wait < 100; wait++) {
+		if (!(ioread32(&wq->ctrl->running)))
+			return 0;
+		udelay(1);
+	}
+
+	pr_err("Failed to disable Copy WQ[%d], fetch index = %d, posted_index = %d\n",
+	       wq->index, ioread32(&wq->ctrl->fetch_index),
+	       ioread32(&wq->ctrl->posted_index));
+
+	return -ENODEV;
+}
+
+void vnic_wq_copy_clean(struct vnic_wq_copy *wq,
+			void (*q_clean)(struct vnic_wq_copy *wq,
+			struct fcpio_host_req *wq_desc))
+{
+	WARN_ON(ioread32(&wq->ctrl->enable));
+
+	if (vnic_wq_copy_desc_in_use(wq))
+		vnic_wq_copy_service(wq, -1, q_clean);
+
+	wq->to_use_index = wq->to_clean_index = 0;
+
+	iowrite32(0, &wq->ctrl->fetch_index);
+	iowrite32(0, &wq->ctrl->posted_index);
+	iowrite32(0, &wq->ctrl->error_status);
+
+	vnic_dev_clear_desc_ring(&wq->ring);
+}
+
+void vnic_wq_copy_free(struct vnic_wq_copy *wq)
+{
+	struct vnic_dev *vdev;
+
+	vdev = wq->vdev;
+	vnic_dev_free_desc_ring(vdev, &wq->ring);
+	wq->ctrl = NULL;
+}
+
+int vnic_wq_copy_alloc(struct vnic_dev *vdev, struct vnic_wq_copy *wq,
+		       unsigned int index, unsigned int desc_count,
+		       unsigned int desc_size)
+{
+	int err;
+
+	wq->index = index;
+	wq->vdev = vdev;
+	wq->to_use_index = wq->to_clean_index = 0;
+	wq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_WQ, index);
+	if (!wq->ctrl) {
+		pr_err("Failed to hook COPY WQ[%d] resource\n", index);
+		return -EINVAL;
+	}
+
+	vnic_wq_copy_disable(wq);
+
+	err = vnic_dev_alloc_desc_ring(vdev, &wq->ring, desc_count, desc_size);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+void vnic_wq_copy_init(struct vnic_wq_copy *wq, unsigned int cq_index,
+		       unsigned int error_interrupt_enable,
+		       unsigned int error_interrupt_offset)
+{
+	uint64_t paddr;
+
+	paddr = (uint64_t)wq->ring.base_addr | VNIC_PADDR_TARGET;
+	writeq(paddr, &wq->ctrl->ring_base);
+	iowrite32(wq->ring.desc_count, &wq->ctrl->ring_size);
+	iowrite32(0, &wq->ctrl->fetch_index);
+	iowrite32(0, &wq->ctrl->posted_index);
+	iowrite32(cq_index, &wq->ctrl->cq_index);
+	iowrite32(error_interrupt_enable, &wq->ctrl->error_interrupt_enable);
+	iowrite32(error_interrupt_offset, &wq->ctrl->error_interrupt_offset);
+}
diff --git a/drivers/staging/fnic2/src/vnic_wq_copy.h b/drivers/staging/fnic2/src/vnic_wq_copy.h
new file mode 100644
index 0000000..2ef670c
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_wq_copy.h
@@ -0,0 +1,127 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifndef _VNIC_WQ_COPY_H_
+#define _VNIC_WQ_COPY_H_
+
+#include <linux/pci.h>
+#include "vnic_wq.h"
+#include "fcpio.h"
+
+struct vnic_wq_copy {
+	unsigned int			index;
+	struct vnic_dev			*vdev;
+	struct vnic_wq_ctrl __iomem	*ctrl;	/* memory-mapped */
+	struct vnic_dev_ring		ring;
+	unsigned int			to_use_index;
+	unsigned int			to_clean_index;
+};
+
+static inline unsigned int vnic_wq_copy_desc_avail(struct vnic_wq_copy *wq)
+{
+	return wq->ring.desc_avail;
+}
+
+static inline unsigned int vnic_wq_copy_desc_in_use(struct vnic_wq_copy *wq)
+{
+	return wq->ring.desc_count - 1 - wq->ring.desc_avail;
+}
+
+static inline void *vnic_wq_copy_next_desc(struct vnic_wq_copy *wq)
+{
+	struct fcpio_host_req *desc = wq->ring.descs;
+
+	return &desc[wq->to_use_index];
+}
+
+static inline void vnic_wq_copy_post(struct vnic_wq_copy *wq)
+{
+
+	((wq->to_use_index + 1) == wq->ring.desc_count) ?
+		(wq->to_use_index = 0) : (wq->to_use_index++);
+	wq->ring.desc_avail--;
+
+	/* Adding write memory barrier prevents compiler and/or CPU
+	 * reordering, thus avoiding descriptor posting before
+	 * descriptor is initialized. Otherwise, hardware can read
+	 * stale descriptor fields.
+	 */
+	wmb();
+
+	iowrite32(wq->to_use_index, &wq->ctrl->posted_index);
+}
+
+static inline void vnic_wq_copy_desc_process(struct vnic_wq_copy *wq, uint16_t index)
+{
+	unsigned int cnt;
+
+	if (wq->to_clean_index <= index)
+		cnt = (index - wq->to_clean_index) + 1;
+	else
+		cnt = wq->ring.desc_count - wq->to_clean_index + index + 1;
+
+	wq->to_clean_index = ((index + 1) % wq->ring.desc_count);
+	wq->ring.desc_avail += cnt;
+
+}
+
+static inline void vnic_wq_copy_service(struct vnic_wq_copy *wq,
+					uint16_t completed_index,
+					void (*q_service)(struct vnic_wq_copy *wq,
+					struct fcpio_host_req *wq_desc))
+{
+	struct fcpio_host_req *wq_desc = wq->ring.descs;
+	unsigned int curr_index;
+
+	while (1) {
+
+		if (q_service)
+			(*q_service)(wq, &wq_desc[wq->to_clean_index]);
+
+		wq->ring.desc_avail++;
+
+		curr_index = wq->to_clean_index;
+
+		/* increment the to-clean index so that we start
+		 * with an unprocessed index next time we enter the loop
+		 */
+		((wq->to_clean_index + 1) == wq->ring.desc_count) ?
+			(wq->to_clean_index = 0) : (wq->to_clean_index++);
+
+		if (curr_index == completed_index)
+			break;
+
+		/* we have cleaned all the entries */
+		if ((completed_index == (uint16_t)-1) &&
+		    (wq->to_clean_index == wq->to_use_index))
+			break;
+	}
+}
+
+void vnic_wq_copy_enable(struct vnic_wq_copy *wq);
+int vnic_wq_copy_disable(struct vnic_wq_copy *wq);
+void vnic_wq_copy_free(struct vnic_wq_copy *wq);
+int vnic_wq_copy_alloc(struct vnic_dev *vdev, struct vnic_wq_copy *wq,
+		       unsigned int index, unsigned int desc_count, unsigned int desc_size);
+void vnic_wq_copy_init(struct vnic_wq_copy *wq, unsigned int cq_index,
+		       unsigned int error_interrupt_enable,
+		       unsigned int error_interrupt_offset);
+void vnic_wq_copy_clean(struct vnic_wq_copy *wq,
+			void (*q_clean)(struct vnic_wq_copy *wq,
+			struct fcpio_host_req *wq_desc));
+
+#endif /* _VNIC_WQ_COPY_H_ */
-- 
1.8.3.1
