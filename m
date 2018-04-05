Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx49aS4wv0EnSunNueP/HZOl2eLHq3SU/q5/i18Sdf70LRLzPVvH83dvTh7uAiiMGjnwjA4+n
ARC-Seal: i=1; a=rsa-sha256; t=1522963248; cv=none;
        d=google.com; s=arc-20160816;
        b=XwEYqhqSYhmvT9CRm+cij/eWm7hoUnFCma9kwQdRW3nMXSZBV+HyEimlOngyPMkGCB
         kFzQEISc7DQlEXODRzhfvL3sc8CYBNaH87vxicZm/vtB9pB+5WY+pcy00Px6ulf19nTc
         CHNELCtJigvdvo8NGJ8etMNJaKCaYCkz5In0Uk8JW5LUMuy+IaDmPJmyeSDhiwzTV6Lr
         A3D0aB9Z+QGnrifsJjKyHayJbuKTmJyIWailRybjdyanOxCuODj2TM0wcMMc3ypv5AD6
         dkv1juqfPFA07DwNFLm9Ckui6cB4iL99OQPGE5vLYpP42xBD+4kzDJQEMfVh+24F+vZ6
         wKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Rsaf/Y511HvGKBIxr8xLdVzIy02zCmYrja3UP5vPK68=;
        b=pm33FERhtcqXps+/5C1fBdcJg/GZ+ml9WWHP7y4djxGc4ly0St76Voo28SeDXq5SmL
         HTxOL0maz2hykMk63LtqfJ6siT20yiYI9gx4OZ2dhVDIB6XdlANAOBzEPxCAi6xRtdoG
         5iTvbvtjBC8LZiPMBKwdmYikqqPGPrz40IsbucnTcc+B1SuRjnd1Mx+vwFnlVWzPJe6R
         8IstOzgQgGcnq8Tv1kCERh2KWQGEClyXsQns/s6ZBrUh98wXdxIbGRepBfULRMmNPzQR
         RRPNwERVtaDNp7tNsjAqGjn5jjvfmPCwWjDOq9FPZ31s6QzzUYgUO0kUjBGrLr00hmpk
         RIxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=kFYuER1j;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.80 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=kFYuER1j;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.80 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="370272377"
Date: Thu, 5 Apr 2018 14:23:33 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 09/10] staging: fnic2 add vnic handling
Message-ID: <20180405212333.GJ12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942711724471823?=
X-GMAIL-MSGID: =?utf-8?q?1596942711724471823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain low level interfaces for managing
hardware and firmware features.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/vnic_dev.c      | 701 ++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/vnic_dev.h      | 163 +++++++
 drivers/staging/fnic2/src/vnic_devcmd.h   | 349 +++++++++++++++
 drivers/staging/fnic2/src/vnic_intr.c     |  61 +++
 drivers/staging/fnic2/src/vnic_intr.h     | 116 +++++
 drivers/staging/fnic2/src/vnic_nic.h      |  78 ++++
 drivers/staging/fnic2/src/vnic_resource.h |  50 +++
 drivers/staging/fnic2/src/vnic_scsi.h     |  88 ++++
 drivers/staging/fnic2/src/vnic_stats.h    |  68 +++
 9 files changed, 1674 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/vnic_dev.c
 create mode 100644 drivers/staging/fnic2/src/vnic_dev.h
 create mode 100644 drivers/staging/fnic2/src/vnic_devcmd.h
 create mode 100644 drivers/staging/fnic2/src/vnic_intr.c
 create mode 100644 drivers/staging/fnic2/src/vnic_intr.h
 create mode 100644 drivers/staging/fnic2/src/vnic_nic.h
 create mode 100644 drivers/staging/fnic2/src/vnic_resource.h
 create mode 100644 drivers/staging/fnic2/src/vnic_scsi.h
 create mode 100644 drivers/staging/fnic2/src/vnic_stats.h

diff --git a/drivers/staging/fnic2/src/vnic_dev.c b/drivers/staging/fnic2/src/vnic_dev.c
new file mode 100644
index 0000000..5e04d63
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_dev.c
@@ -0,0 +1,701 @@
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
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/if_ether.h>
+#include <linux/slab.h>
+#include "vnic_resource.h"
+#include "vnic_devcmd.h"
+#include "vnic_dev.h"
+#include "vnic_stats.h"
+
+struct vnic_res {
+	void __iomem	*vaddr;
+	unsigned int	count;
+};
+
+struct vnic_dev {
+	void				*priv;
+	struct pci_dev			*pdev;
+	struct vnic_res			res[RES_TYPE_MAX];
+	enum vnic_dev_intr_mode		intr_mode;
+	struct vnic_devcmd __iomem	*devcmd;
+	struct vnic_devcmd_notify	*notify;
+	struct vnic_devcmd_notify	notify_copy;
+	dma_addr_t			notify_pa;
+	uint32_t			*linkstatus;
+	dma_addr_t			linkstatus_pa;
+	struct vnic_stats		*stats;
+	dma_addr_t			stats_pa;
+	struct vnic_devcmd_fw_info	*fw_info;
+	dma_addr_t			fw_info_pa;
+};
+
+#define VNIC_MAX_RES_HDR_SIZE \
+	(sizeof(struct vnic_resource_header) + \
+	sizeof(struct vnic_resource) * RES_TYPE_MAX)
+#define VNIC_RES_STRIDE	128
+
+void *vnic_dev_priv(struct vnic_dev *vdev)
+{
+	return vdev->priv;
+}
+
+static int vnic_dev_discover_res(struct vnic_dev *vdev,
+				 struct vnic_dev_bar *bar)
+{
+	struct vnic_resource_header __iomem *rh;
+	struct vnic_resource __iomem *r;
+	uint8_t type;
+
+	if (bar->len < VNIC_MAX_RES_HDR_SIZE) {
+		pr_err("vNIC BAR0 res hdr length error\n");
+		return -EINVAL;
+	}
+
+	rh = bar->vaddr;
+	if (!rh) {
+		pr_err("vNIC BAR0 res hdr not mem-mapped\n");
+		return -EINVAL;
+	}
+
+	if (ioread32(&rh->magic) != VNIC_RES_MAGIC ||
+		ioread32(&rh->version) != VNIC_RES_VERSION) {
+		pr_err("vNIC BAR0 res magic/version error exp %lx/%lx curr %x/%x\n",
+			VNIC_RES_MAGIC, VNIC_RES_VERSION,
+			ioread32(&rh->magic), ioread32(&rh->version));
+		return -EINVAL;
+	}
+
+	r = (struct vnic_resource __iomem *)(rh + 1);
+
+	while ((type = ioread8(&r->type)) != RES_TYPE_EOL) {
+
+		uint8_t bar_num = ioread8(&r->bar);
+		uint32_t bar_offset = ioread32(&r->bar_offset);
+		uint32_t count = ioread32(&r->count);
+		uint32_t len;
+
+		r++;
+
+		if (bar_num != 0)  /* only mapping in BAR0 resources */
+			continue;
+
+		switch (type) {
+		case RES_TYPE_WQ:
+		case RES_TYPE_RQ:
+		case RES_TYPE_CQ:
+		case RES_TYPE_INTR_CTRL:
+			/* each count is stride bytes long */
+			len = count * VNIC_RES_STRIDE;
+			if (len + bar_offset > bar->len) {
+				pr_err("vNIC BAR0 resource %d out-of-bounds, offset 0x%x + size 0x%x > bar len 0x%lx\n",
+					type, bar_offset,
+					len,
+					bar->len);
+				return -EINVAL;
+			}
+			break;
+		case RES_TYPE_INTR_PBA_LEGACY:
+		case RES_TYPE_DEVCMD:
+			len = count;
+			break;
+		default:
+			continue;
+		}
+
+		vdev->res[type].count = count;
+		vdev->res[type].vaddr = (char __iomem *)bar->vaddr + bar_offset;
+	}
+
+	return 0;
+}
+
+unsigned int vnic_dev_get_res_count(struct vnic_dev *vdev,
+				    enum vnic_res_type type)
+{
+	return vdev->res[type].count;
+}
+
+void __iomem *vnic_dev_get_res(struct vnic_dev *vdev, enum vnic_res_type type,
+			       unsigned int index)
+{
+	if (!vdev->res[type].vaddr)
+		return NULL;
+
+	switch (type) {
+	case RES_TYPE_WQ:
+	case RES_TYPE_RQ:
+	case RES_TYPE_CQ:
+	case RES_TYPE_INTR_CTRL:
+		return (char __iomem *)vdev->res[type].vaddr +
+					index * VNIC_RES_STRIDE;
+	default:
+		return (char __iomem *)vdev->res[type].vaddr;
+	}
+}
+
+unsigned int vnic_dev_desc_ring_size(struct vnic_dev_ring *ring,
+				     unsigned int desc_count,
+				     unsigned int desc_size)
+{
+	/* The base address of the desc rings must be 512 byte aligned.
+	 * Descriptor count is aligned to groups of 32 descriptors.  A
+	 * count of 0 means the maximum 4096 descriptors.  Descriptor
+	 * size is aligned to 16 bytes.
+	 */
+
+	unsigned int count_align = 32;
+	unsigned int desc_align = 16;
+
+	ring->base_align = 512;
+
+	if (desc_count == 0)
+		desc_count = 4096;
+
+	ring->desc_count = ALIGN(desc_count, count_align);
+
+	ring->desc_size = ALIGN(desc_size, desc_align);
+
+	ring->size = ring->desc_count * ring->desc_size;
+	ring->size_unaligned = ring->size + ring->base_align;
+
+	return ring->size_unaligned;
+}
+
+void vnic_dev_clear_desc_ring(struct vnic_dev_ring *ring)
+{
+	memset(ring->descs, 0, ring->size);
+}
+
+int vnic_dev_alloc_desc_ring(struct vnic_dev *vdev, struct vnic_dev_ring *ring,
+			     unsigned int desc_count, unsigned int desc_size)
+{
+	vnic_dev_desc_ring_size(ring, desc_count, desc_size);
+
+	ring->descs_unaligned = pci_alloc_consistent(vdev->pdev,
+		ring->size_unaligned,
+		&ring->base_addr_unaligned);
+
+	if (!ring->descs_unaligned) {
+		pr_err("Failed to allocate ring. size = %d, aborting\n",
+			(int)ring->size);
+		return -ENOMEM;
+	}
+
+	ring->base_addr = ALIGN(ring->base_addr_unaligned,
+		ring->base_align);
+	ring->descs = (uint8_t *)ring->descs_unaligned +
+		(ring->base_addr - ring->base_addr_unaligned);
+
+	vnic_dev_clear_desc_ring(ring);
+
+	ring->desc_avail = ring->desc_count - 1;
+
+	return 0;
+}
+
+void vnic_dev_free_desc_ring(struct vnic_dev *vdev, struct vnic_dev_ring *ring)
+{
+	if (ring->descs) {
+		pci_free_consistent(vdev->pdev,
+			ring->size_unaligned,
+			ring->descs_unaligned,
+			ring->base_addr_unaligned);
+		ring->descs = NULL;
+	}
+}
+
+int vnic_dev_cmd(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
+		 uint64_t *a0, uint64_t *a1, int wait)
+{
+	struct vnic_devcmd __iomem *devcmd = vdev->devcmd;
+	int delay;
+	uint32_t status;
+	int dev_cmd_err[] = {
+		/* convert from fw's version of error.h to host's version */
+		0,	/* ERR_SUCCESS */
+		EINVAL,	/* ERR_EINVAL */
+		EFAULT,	/* ERR_EFAULT */
+		EPERM,	/* ERR_EPERM */
+		EBUSY,  /* ERR_EBUSY */
+	};
+	int err;
+
+	status = ioread32(&devcmd->status);
+	if (status & STAT_BUSY) {
+		pr_err("Busy devcmd %d\n", _CMD_N(cmd));
+		return -EBUSY;
+	}
+
+	if (_CMD_DIR(cmd) & _CMD_DIR_WRITE) {
+		writeq(*a0, &devcmd->args[0]);
+		writeq(*a1, &devcmd->args[1]);
+		wmb();
+	}
+
+	iowrite32(cmd, &devcmd->cmd);
+
+	if ((_CMD_FLAGS(cmd) & _CMD_FLAGS_NOWAIT))
+			return 0;
+
+	for (delay = 0; delay < wait; delay++) {
+
+		udelay(100);
+
+		status = ioread32(&devcmd->status);
+		if (!(status & STAT_BUSY)) {
+
+			if (status & STAT_ERROR) {
+				err = dev_cmd_err[(int)readq(&devcmd->args[0])];
+				pr_err("Error %d devcmd %d\n",
+					err, _CMD_N(cmd));
+				return -err;
+			}
+
+			if (_CMD_DIR(cmd) & _CMD_DIR_READ) {
+				rmb();
+				*a0 = readq(&devcmd->args[0]);
+				*a1 = readq(&devcmd->args[1]);
+			}
+
+			return 0;
+		}
+	}
+
+	pr_err("Timedout devcmd %d\n", _CMD_N(cmd));
+	return -ETIMEDOUT;
+}
+
+int vnic_dev_fw_info(struct vnic_dev *vdev, struct vnic_devcmd_fw_info **fw_info)
+{
+	uint64_t a0, a1 = 0;
+	int wait = 1000;
+	int err = 0;
+
+	if (!vdev->fw_info) {
+		vdev->fw_info = pci_alloc_consistent(vdev->pdev,
+			sizeof(struct vnic_devcmd_fw_info),
+			&vdev->fw_info_pa);
+		if (!vdev->fw_info)
+			return -ENOMEM;
+
+		a0 = vdev->fw_info_pa;
+
+		/* only get fw_info once and cache it */
+		err = vnic_dev_cmd(vdev, CMD_MCPU_FW_INFO, &a0, &a1, wait);
+	}
+
+	*fw_info = vdev->fw_info;
+
+	return err;
+}
+
+int vnic_dev_spec(struct vnic_dev *vdev, unsigned int offset, unsigned int size,
+		  void *value)
+{
+	uint64_t a0, a1;
+	int wait = 1000;
+	int err;
+
+	a0 = offset;
+	a1 = size;
+
+	err = vnic_dev_cmd(vdev, CMD_DEV_SPEC, &a0, &a1, wait);
+
+	switch (size) {
+	case 1:
+		*(uint8_t *)value = (uint8_t)a0;
+		break;
+	case 2:
+		*(uint16_t *)value = (uint16_t)a0;
+		break;
+	case 4:
+		*(uint32_t *)value = (uint32_t)a0;
+		break;
+	case 8:
+		*(uint64_t *)value = a0;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return err;
+}
+
+int vnic_dev_stats_clear(struct vnic_dev *vdev)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_STATS_CLEAR, &a0, &a1, wait);
+}
+
+int vnic_dev_stats_dump(struct vnic_dev *vdev, struct vnic_stats **stats)
+{
+	uint64_t a0, a1;
+	int wait = 1000;
+
+	if (!vdev->stats) {
+		vdev->stats = pci_alloc_consistent(vdev->pdev,
+			sizeof(struct vnic_stats), &vdev->stats_pa);
+		if (!vdev->stats)
+			return -ENOMEM;
+	}
+
+	*stats = vdev->stats;
+	a0 = vdev->stats_pa;
+	a1 = sizeof(struct vnic_stats);
+
+	return vnic_dev_cmd(vdev, CMD_STATS_DUMP, &a0, &a1, wait);
+}
+
+int vnic_dev_close(struct vnic_dev *vdev)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_CLOSE, &a0, &a1, wait);
+}
+
+int vnic_dev_enable(struct vnic_dev *vdev)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_ENABLE, &a0, &a1, wait);
+}
+
+int vnic_dev_disable(struct vnic_dev *vdev)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_DISABLE, &a0, &a1, wait);
+}
+
+int vnic_dev_open(struct vnic_dev *vdev, int arg)
+{
+	uint64_t a0 = (uint32_t)arg, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_OPEN, &a0, &a1, wait);
+}
+
+int vnic_dev_open_done(struct vnic_dev *vdev, int *done)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+	int err;
+
+	*done = 0;
+
+	err = vnic_dev_cmd(vdev, CMD_OPEN_STATUS, &a0, &a1, wait);
+	if (err)
+		return err;
+
+	*done = (a0 == 0);
+
+	return 0;
+}
+
+int vnic_dev_soft_reset(struct vnic_dev *vdev, int arg)
+{
+	uint64_t a0 = (uint32_t)arg, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_SOFT_RESET, &a0, &a1, wait);
+}
+
+int vnic_dev_soft_reset_done(struct vnic_dev *vdev, int *done)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+	int err;
+
+	*done = 0;
+
+	err = vnic_dev_cmd(vdev, CMD_SOFT_RESET_STATUS, &a0, &a1, wait);
+	if (err)
+		return err;
+
+	*done = (a0 == 0);
+
+	return 0;
+}
+
+int vnic_dev_hang_notify(struct vnic_dev *vdev)
+{
+	uint64_t a0, a1;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_HANG_NOTIFY, &a0, &a1, wait);
+}
+
+int vnic_dev_mac_addr(struct vnic_dev *vdev, uint8_t *mac_addr)
+{
+	uint64_t a0, a1;
+	int wait = 1000;
+	int err, i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_addr[i] = 0;
+
+	err = vnic_dev_cmd(vdev, CMD_MAC_ADDR, &a0, &a1, wait);
+	if (err)
+		return err;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_addr[i] = ((uint8_t *)&a0)[i];
+
+	return 0;
+}
+
+void vnic_dev_packet_filter(struct vnic_dev *vdev, int directed, int multicast,
+			    int broadcast, int promisc, int allmulti)
+{
+	uint64_t a0, a1 = 0;
+	int wait = 1000;
+	int err;
+
+	a0 = (directed ? CMD_PFILTER_DIRECTED : 0) |
+	     (multicast ? CMD_PFILTER_MULTICAST : 0) |
+	     (broadcast ? CMD_PFILTER_BROADCAST : 0) |
+	     (promisc ? CMD_PFILTER_PROMISCUOUS : 0) |
+	     (allmulti ? CMD_PFILTER_ALL_MULTICAST : 0);
+
+	err = vnic_dev_cmd(vdev, CMD_PACKET_FILTER, &a0, &a1, wait);
+	if (err)
+		pr_err("Can't set packet filter\n");
+}
+
+void vnic_dev_add_addr(struct vnic_dev *vdev, uint8_t *addr)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+	int err;
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		((uint8_t *)&a0)[i] = addr[i];
+
+	err = vnic_dev_cmd(vdev, CMD_ADDR_ADD, &a0, &a1, wait);
+	if (err)
+		pr_err("Can't add addr %02x:%02x:%02x:%02x:%02x:%02x, %d\n",
+			addr[0], addr[1], addr[2], addr[3], addr[4], addr[5],
+			err);
+}
+
+void vnic_dev_del_addr(struct vnic_dev *vdev, uint8_t *addr)
+{
+	uint64_t a0 = 0, a1 = 0;
+	int wait = 1000;
+	int err;
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		((uint8_t *)&a0)[i] = addr[i];
+
+	err = vnic_dev_cmd(vdev, CMD_ADDR_DEL, &a0, &a1, wait);
+	if (err)
+		pr_err("Can't del addr %02x:%02x:%02x:%02x:%02x:%02x, %d\n",
+			addr[0], addr[1], addr[2], addr[3], addr[4], addr[5],
+			err);
+}
+
+int vnic_dev_notify_set(struct vnic_dev *vdev, uint16_t intr)
+{
+	uint64_t a0, a1;
+	int wait = 1000;
+
+	if (!vdev->notify) {
+		vdev->notify = pci_alloc_consistent(vdev->pdev,
+			sizeof(struct vnic_devcmd_notify),
+			&vdev->notify_pa);
+		if (!vdev->notify)
+			return -ENOMEM;
+	}
+
+	a0 = vdev->notify_pa;
+	a1 = ((uint64_t)intr << 32) & 0x0000ffff00000000ULL;
+	a1 += sizeof(struct vnic_devcmd_notify);
+
+	return vnic_dev_cmd(vdev, CMD_NOTIFY, &a0, &a1, wait);
+}
+
+void vnic_dev_notify_unset(struct vnic_dev *vdev)
+{
+	uint64_t a0, a1;
+	int wait = 1000;
+
+	a0 = 0;  /* paddr = 0 to unset notify buffer */
+	a1 = 0x0000ffff00000000ULL; /* intr num = -1 to unreg for intr */
+	a1 += sizeof(struct vnic_devcmd_notify);
+
+	vnic_dev_cmd(vdev, CMD_NOTIFY, &a0, &a1, wait);
+}
+
+static int vnic_dev_notify_ready(struct vnic_dev *vdev)
+{
+	uint32_t *words;
+	unsigned int nwords = sizeof(struct vnic_devcmd_notify) / 4;
+	unsigned int i;
+	uint32_t csum;
+
+	if (!vdev->notify)
+		return 0;
+
+	do {
+		csum = 0;
+		memcpy(&vdev->notify_copy, vdev->notify,
+			sizeof(struct vnic_devcmd_notify));
+		words = (uint32_t *)&vdev->notify_copy;
+		for (i = 1; i < nwords; i++)
+			csum += words[i];
+	} while (csum != words[0]);
+
+	return 1;
+}
+
+int vnic_dev_init(struct vnic_dev *vdev, int arg)
+{
+	uint64_t a0 = (uint32_t)arg, a1 = 0;
+	int wait = 1000;
+
+	return vnic_dev_cmd(vdev, CMD_INIT, &a0, &a1, wait);
+}
+
+uint16_t vnic_dev_set_default_vlan(struct vnic_dev *vdev, uint16_t new_default_vlan)
+{
+	uint64_t a0 = new_default_vlan, a1 = 0;
+	int wait = 1000;
+	int old_vlan = 0;
+
+	old_vlan = vnic_dev_cmd(vdev, CMD_SET_DEFAULT_VLAN, &a0, &a1, wait);
+	return (uint16_t)old_vlan;
+}
+
+int vnic_dev_link_status(struct vnic_dev *vdev)
+{
+	if (vdev->linkstatus)
+		return *vdev->linkstatus;
+
+	if (!vnic_dev_notify_ready(vdev))
+		return 0;
+
+	return vdev->notify_copy.link_state;
+}
+
+uint32_t vnic_dev_port_speed(struct vnic_dev *vdev)
+{
+	if (!vnic_dev_notify_ready(vdev))
+		return 0;
+
+	return vdev->notify_copy.port_speed;
+}
+
+uint32_t vnic_dev_msg_lvl(struct vnic_dev *vdev)
+{
+	if (!vnic_dev_notify_ready(vdev))
+		return 0;
+
+	return vdev->notify_copy.msglvl;
+}
+
+uint32_t vnic_dev_mtu(struct vnic_dev *vdev)
+{
+	if (!vnic_dev_notify_ready(vdev))
+		return 0;
+
+	return vdev->notify_copy.mtu;
+}
+
+uint32_t vnic_dev_link_down_cnt(struct vnic_dev *vdev)
+{
+	if (!vnic_dev_notify_ready(vdev))
+		return 0;
+
+	return vdev->notify_copy.link_down_cnt;
+}
+
+void vnic_dev_set_intr_mode(struct vnic_dev *vdev, enum vnic_dev_intr_mode intr_mode)
+{
+	vdev->intr_mode = intr_mode;
+}
+
+enum vnic_dev_intr_mode vnic_dev_get_intr_mode(
+	struct vnic_dev *vdev)
+{
+	return vdev->intr_mode;
+}
+
+void vnic_dev_unregister(struct vnic_dev *vdev)
+{
+	if (vdev) {
+		if (vdev->notify)
+			pci_free_consistent(vdev->pdev,
+				sizeof(struct vnic_devcmd_notify),
+				vdev->notify,
+				vdev->notify_pa);
+		if (vdev->linkstatus)
+			pci_free_consistent(vdev->pdev,
+				sizeof(uint32_t),
+				vdev->linkstatus,
+				vdev->linkstatus_pa);
+		if (vdev->stats)
+			pci_free_consistent(vdev->pdev,
+				sizeof(struct vnic_stats),
+				vdev->stats, vdev->stats_pa);
+		if (vdev->fw_info)
+			pci_free_consistent(vdev->pdev,
+				sizeof(struct vnic_devcmd_fw_info),
+				vdev->fw_info, vdev->fw_info_pa);
+		kfree(vdev);
+	}
+}
+
+struct vnic_dev *vnic_dev_register(struct vnic_dev *vdev,
+				   void *priv, struct pci_dev *pdev, struct vnic_dev_bar *bar)
+{
+	if (!vdev) {
+		vdev = kzalloc(sizeof(struct vnic_dev), GFP_KERNEL);
+		if (!vdev)
+			return NULL;
+	}
+
+	vdev->priv = priv;
+	vdev->pdev = pdev;
+
+	if (vnic_dev_discover_res(vdev, bar))
+		goto err_out;
+
+	vdev->devcmd = vnic_dev_get_res(vdev, RES_TYPE_DEVCMD, 0);
+	if (!vdev->devcmd)
+		goto err_out;
+
+	return vdev;
+
+err_out:
+	vnic_dev_unregister(vdev);
+	return NULL;
+}
diff --git a/drivers/staging/fnic2/src/vnic_dev.h b/drivers/staging/fnic2/src/vnic_dev.h
new file mode 100644
index 0000000..9543909
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_dev.h
@@ -0,0 +1,163 @@
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
+#ifndef _VNIC_DEV_H_
+#define _VNIC_DEV_H_
+
+#include "vnic_resource.h"
+#include "vnic_devcmd.h"
+
+/*
+ * These defines avoid symbol clash between fnic2 and enic (Cisco 10G Eth
+ * Driver) when both are built with CONFIG options =y
+ */
+#define vnic_dev_priv fnic2_dev_priv
+#define vnic_dev_get_res_count fnic2_dev_get_res_count
+#define vnic_dev_get_res fnic2_dev_get_res
+#define vnic_dev_desc_ring_size fnic2_dev_desc_ring_siz
+#define vnic_dev_clear_desc_ring fnic2_dev_clear_desc_ring
+#define vnic_dev_alloc_desc_ring fnic2_dev_alloc_desc_ring
+#define vnic_dev_free_desc_ring fnic2_dev_free_desc_ring
+#define vnic_dev_cmd fnic2_dev_cmd
+#define vnic_dev_fw_info fnic2_dev_fw_info
+#define vnic_dev_spec fnic2_dev_spec
+#define vnic_dev_stats_clear fnic2_dev_stats_clear
+#define vnic_dev_stats_dump fnic2_dev_stats_dump
+#define vnic_dev_hang_notify fnic2_dev_hang_notify
+#define vnic_dev_packet_filter fnic2_dev_packet_filter
+#define vnic_dev_add_addr fnic2_dev_add_addr
+#define vnic_dev_del_addr fnic2_dev_del_addr
+#define vnic_dev_mac_addr fnic2_dev_mac_addr
+#define vnic_dev_notify_set fnic2_dev_notify_set
+#define vnic_dev_notify_unset fnic2_dev_notify_unset
+#define vnic_dev_link_status fnic2_dev_link_status
+#define vnic_dev_port_speed fnic2_dev_port_speed
+#define vnic_dev_msg_lvl fnic2_dev_msg_lvl
+#define vnic_dev_mtu fnic2_dev_mtu
+#define vnic_dev_link_down_cnt fnic2_dev_link_down_cnt
+#define vnic_dev_close fnic2_dev_close
+#define vnic_dev_enable fnic2_dev_enable
+#define vnic_dev_disable fnic2_dev_disable
+#define vnic_dev_open fnic2_dev_open
+#define vnic_dev_open_done fnic2_dev_open_done
+#define vnic_dev_init fnic2_dev_init
+#define vnic_dev_soft_reset fnic2_dev_soft_reset
+#define vnic_dev_soft_reset_done fnic2_dev_soft_reset_done
+#define vnic_dev_set_intr_mode fnic2_dev_set_intr_mode
+#define vnic_dev_get_intr_mode fnic2_dev_get_intr_mode
+#define vnic_dev_unregister fnic2_dev_unregister
+#define vnic_dev_register fnic2_dev_register
+
+#ifndef VNIC_PADDR_TARGET
+#define VNIC_PADDR_TARGET	0x0000000000000000ULL
+#endif
+
+#ifndef readq
+static inline uint64_t readq(void __iomem *reg)
+{
+	return ((uint64_t)readl(reg + 0x4UL) << 32) | (uint64_t)readl(reg);
+}
+
+static inline void writeq(uint64_t val, void __iomem *reg)
+{
+	writel(val & 0xffffffff, reg);
+	writel(val >> 32, reg + 0x4UL);
+}
+#endif
+
+enum vnic_dev_intr_mode {
+	VNIC_DEV_INTR_MODE_UNKNOWN,
+	VNIC_DEV_INTR_MODE_INTX,
+	VNIC_DEV_INTR_MODE_MSI,
+	VNIC_DEV_INTR_MODE_MSIX,
+};
+
+struct vnic_dev_bar {
+	void __iomem	*vaddr;
+	dma_addr_t	bus_addr;
+	unsigned long	len;
+};
+
+struct vnic_dev_ring {
+	void		*descs;
+	size_t		size;
+	dma_addr_t	base_addr;
+	size_t		base_align;
+	void		*descs_unaligned;
+	size_t		size_unaligned;
+	dma_addr_t	base_addr_unaligned;
+	unsigned int	desc_size;
+	unsigned int	desc_count;
+	unsigned int	desc_avail;
+};
+
+struct vnic_dev;
+struct vnic_stats;
+
+void *vnic_dev_priv(struct vnic_dev *vdev);
+unsigned int vnic_dev_get_res_count(struct vnic_dev *vdev,
+				    enum vnic_res_type type);
+void __iomem *vnic_dev_get_res(struct vnic_dev *vdev, enum vnic_res_type type,
+			       unsigned int index);
+unsigned int vnic_dev_desc_ring_size(struct vnic_dev_ring *ring,
+				     unsigned int desc_count,
+				     unsigned int desc_size);
+void vnic_dev_clear_desc_ring(struct vnic_dev_ring *ring);
+int vnic_dev_alloc_desc_ring(struct vnic_dev *vdev, struct vnic_dev_ring *ring,
+			     unsigned int desc_count, unsigned int desc_size);
+void vnic_dev_free_desc_ring(struct vnic_dev *vdev,
+			     struct vnic_dev_ring *ring);
+int vnic_dev_cmd(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
+		 uint64_t *a0, uint64_t *a1, int wait);
+int vnic_dev_fw_info(struct vnic_dev *vdev,
+		     struct vnic_devcmd_fw_info **fw_info);
+int vnic_dev_spec(struct vnic_dev *vdev, unsigned int offset,
+		  unsigned int size, void *value);
+int vnic_dev_stats_clear(struct vnic_dev *vdev);
+int vnic_dev_stats_dump(struct vnic_dev *vdev, struct vnic_stats **stats);
+int vnic_dev_hang_notify(struct vnic_dev *vdev);
+void vnic_dev_packet_filter(struct vnic_dev *vdev, int directed, int multicast,
+			    int broadcast, int promisc, int allmulti);
+void vnic_dev_add_addr(struct vnic_dev *vdev, uint8_t *addr);
+void vnic_dev_del_addr(struct vnic_dev *vdev, uint8_t *addr);
+int vnic_dev_mac_addr(struct vnic_dev *vdev, uint8_t *mac_addr);
+int vnic_dev_notify_set(struct vnic_dev *vdev, uint16_t intr);
+void vnic_dev_notify_unset(struct vnic_dev *vdev);
+int vnic_dev_link_status(struct vnic_dev *vdev);
+uint32_t vnic_dev_port_speed(struct vnic_dev *vdev);
+uint32_t vnic_dev_msg_lvl(struct vnic_dev *vdev);
+uint32_t vnic_dev_mtu(struct vnic_dev *vdev);
+uint32_t vnic_dev_link_down_cnt(struct vnic_dev *vdev);
+int vnic_dev_close(struct vnic_dev *vdev);
+int vnic_dev_enable(struct vnic_dev *vdev);
+int vnic_dev_disable(struct vnic_dev *vdev);
+int vnic_dev_open(struct vnic_dev *vdev, int arg);
+int vnic_dev_open_done(struct vnic_dev *vdev, int *done);
+int vnic_dev_init(struct vnic_dev *vdev, int arg);
+uint16_t vnic_dev_set_default_vlan(struct vnic_dev *vdev,
+				uint16_t new_default_vlan);
+int vnic_dev_soft_reset(struct vnic_dev *vdev, int arg);
+int vnic_dev_soft_reset_done(struct vnic_dev *vdev, int *done);
+void vnic_dev_set_intr_mode(struct vnic_dev *vdev,
+			    enum vnic_dev_intr_mode intr_mode);
+enum vnic_dev_intr_mode vnic_dev_get_intr_mode(struct vnic_dev *vdev);
+void vnic_dev_unregister(struct vnic_dev *vdev);
+struct vnic_dev *vnic_dev_register(struct vnic_dev *vdev,
+				   void *priv, struct pci_dev *pdev,
+				   struct vnic_dev_bar *bar);
+
+#endif /* _VNIC_DEV_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_devcmd.h b/drivers/staging/fnic2/src/vnic_devcmd.h
new file mode 100644
index 0000000..1872523
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_devcmd.h
@@ -0,0 +1,349 @@
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
+#ifndef _VNIC_DEVCMD_H_
+#define _VNIC_DEVCMD_H_
+
+#define _CMD_NBITS      14
+#define _CMD_VTYPEBITS	10
+#define _CMD_FLAGSBITS  6
+#define _CMD_DIRBITS	2
+
+#define _CMD_NMASK      ((1 << _CMD_NBITS)-1)
+#define _CMD_VTYPEMASK  ((1 << _CMD_VTYPEBITS)-1)
+#define _CMD_FLAGSMASK  ((1 << _CMD_FLAGSBITS)-1)
+#define _CMD_DIRMASK    ((1 << _CMD_DIRBITS)-1)
+
+#define _CMD_NSHIFT     0
+#define _CMD_VTYPESHIFT (_CMD_NSHIFT+_CMD_NBITS)
+#define _CMD_FLAGSSHIFT (_CMD_VTYPESHIFT+_CMD_VTYPEBITS)
+#define _CMD_DIRSHIFT   (_CMD_FLAGSSHIFT+_CMD_FLAGSBITS)
+
+/*
+ * Direction bits (from host perspective).
+ */
+#define _CMD_DIR_NONE   0U
+#define _CMD_DIR_WRITE  1U
+#define _CMD_DIR_READ   2U
+#define _CMD_DIR_RW     (_CMD_DIR_WRITE | _CMD_DIR_READ)
+
+/*
+ * Flag bits.
+ */
+#define _CMD_FLAGS_NONE 0U
+#define _CMD_FLAGS_NOWAIT 1U
+
+/*
+ * vNIC type bits.
+ */
+#define _CMD_VTYPE_NONE  0U
+#define _CMD_VTYPE_ENET  1U
+#define _CMD_VTYPE_FC    2U
+#define _CMD_VTYPE_SCSI  4U
+#define _CMD_VTYPE_ALL   (_CMD_VTYPE_ENET | _CMD_VTYPE_FC | _CMD_VTYPE_SCSI)
+
+/*
+ * Used to create cmds..
+*/
+#define _CMDCF(dir, flags, vtype, nr)  \
+	(((dir)   << _CMD_DIRSHIFT) | \
+	((flags) << _CMD_FLAGSSHIFT) | \
+	((vtype) << _CMD_VTYPESHIFT) | \
+	((nr)    << _CMD_NSHIFT))
+#define _CMDC(dir, vtype, nr)    _CMDCF(dir, 0, vtype, nr)
+#define _CMDCNW(dir, vtype, nr)  _CMDCF(dir, _CMD_FLAGS_NOWAIT, vtype, nr)
+
+/*
+ * Used to decode cmds..
+*/
+#define _CMD_DIR(cmd)            (((cmd) >> _CMD_DIRSHIFT) & _CMD_DIRMASK)
+#define _CMD_FLAGS(cmd)          (((cmd) >> _CMD_FLAGSSHIFT) & _CMD_FLAGSMASK)
+#define _CMD_VTYPE(cmd)          (((cmd) >> _CMD_VTYPESHIFT) & _CMD_VTYPEMASK)
+#define _CMD_N(cmd)              (((cmd) >> _CMD_NSHIFT) & _CMD_NMASK)
+
+enum vnic_devcmd_cmd {
+	CMD_NONE                = _CMDC(_CMD_DIR_NONE, _CMD_VTYPE_NONE, 0),
+
+	/* mcpu fw info in mem: (uint64_t)a0=paddr to struct vnic_devcmd_fw_info */
+	CMD_MCPU_FW_INFO        = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 1),
+
+	/* dev-specific block member:
+	 *    in: (uint16_t)a0=offset,(uint8_t)a1=size
+	 *    out: a0=value */
+	CMD_DEV_SPEC            = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 2),
+
+	/* stats clear */
+	CMD_STATS_CLEAR         = _CMDCNW(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 3),
+
+	/* stats dump in mem: (uint64_t)a0=paddr to stats area,
+	 *                    (uint16_t)a1=sizeof stats area */
+	CMD_STATS_DUMP          = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 4),
+
+	/* set Rx packet filter: (uint32_t)a0=filters (see CMD_PFILTER_*) */
+	CMD_PACKET_FILTER       = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 7),
+
+	/* hang detection notification */
+	CMD_HANG_NOTIFY         = _CMDC(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 8),
+
+	/* MAC address in (u48)a0 */
+	CMD_MAC_ADDR            = _CMDC(_CMD_DIR_READ,
+					_CMD_VTYPE_ENET | _CMD_VTYPE_FC, 9),
+
+	/* disable/enable promisc mode: (uint8_t)a0=0/1 */
+/***** XXX DEPRECATED *****/
+	CMD_PROMISC_MODE        = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 10),
+
+	/* disable/enable all-multi mode: (uint8_t)a0=0/1 */
+/***** XXX DEPRECATED *****/
+	CMD_ALLMULTI_MODE       = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 11),
+
+	/* add addr from (u48)a0 */
+	CMD_ADDR_ADD            = _CMDCNW(_CMD_DIR_WRITE,
+					_CMD_VTYPE_ENET | _CMD_VTYPE_FC, 12),
+
+	/* del addr from (u48)a0 */
+	CMD_ADDR_DEL            = _CMDCNW(_CMD_DIR_WRITE,
+					_CMD_VTYPE_ENET | _CMD_VTYPE_FC, 13),
+
+	/* add VLAN id in (uint16_t)a0 */
+	CMD_VLAN_ADD            = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 14),
+
+	/* del VLAN id in (uint16_t)a0 */
+	CMD_VLAN_DEL            = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 15),
+
+	/* nic_cfg in (uint32_t)a0 */
+	CMD_NIC_CFG             = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 16),
+
+	/* union vnic_rss_key in mem: (uint64_t)a0=paddr, (uint16_t)a1=len */
+	CMD_RSS_KEY             = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 17),
+
+	/* union vnic_rss_cpu in mem: (uint64_t)a0=paddr, (uint16_t)a1=len */
+	CMD_RSS_CPU             = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 18),
+
+	/* initiate softreset */
+	CMD_SOFT_RESET          = _CMDCNW(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 19),
+
+	/* softreset status:
+	 *    out: a0=0 reset complete, a0=1 reset in progress */
+	CMD_SOFT_RESET_STATUS   = _CMDC(_CMD_DIR_READ, _CMD_VTYPE_ALL, 20),
+
+	/* set struct vnic_devcmd_notify buffer in mem:
+	 * in:
+	 *   (uint64_t)a0=paddr to notify (set paddr=0 to unset)
+	 *   (uint32_t)a1 & 0x00000000ffffffff=sizeof(struct vnic_devcmd_notify)
+	 *   (uint16_t)a1 & 0x0000ffff00000000=intr num (-1 for no intr)
+	 * out:
+	 *   (uint32_t)a1 = effective size
+	 */
+	CMD_NOTIFY              = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 21),
+
+	/* UNDI API: (uint64_t)a0=paddr to s_PXENV_UNDI_ struct,
+	 *           (uint8_t)a1=PXENV_UNDI_xxx */
+	CMD_UNDI                = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 22),
+
+	/* initiate open sequence (uint32_t)a0=flags (see CMD_OPENF_*) */
+	CMD_OPEN		= _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 23),
+
+	/* open status:
+	 *    out: a0=0 open complete, a0=1 open in progress */
+	CMD_OPEN_STATUS		= _CMDC(_CMD_DIR_READ, _CMD_VTYPE_ALL, 24),
+
+	/* close vnic */
+	CMD_CLOSE		= _CMDC(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 25),
+
+	/* initialize virtual link: (uint32_t)a0=flags (see CMD_INITF_*) */
+	CMD_INIT		= _CMDCNW(_CMD_DIR_READ, _CMD_VTYPE_ALL, 26),
+
+	/* variant of CMD_INIT, with provisioning info
+	 *     (uint64_t)a0=paddr of vnic_devcmd_provinfo
+	 *     (uint32_t)a1=sizeof provision info */
+	CMD_INIT_PROV_INFO	= _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 27),
+
+	/* enable virtual link */
+	CMD_ENABLE		= _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 28),
+
+	/* disable virtual link */
+	CMD_DISABLE		= _CMDC(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 29),
+
+	/* stats dump all vnics on uplink in mem: (uint64_t)a0=paddr (uint32_t)a1=uif */
+	CMD_STATS_DUMP_ALL	= _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 30),
+
+	/* init status:
+	 *    out: a0=0 init complete, a0=1 init in progress
+	 *         if a0=0, a1=errno */
+	CMD_INIT_STATUS		= _CMDC(_CMD_DIR_READ, _CMD_VTYPE_ALL, 31),
+
+	/* INT13 API: (uint64_t)a0=paddr to vnic_int13_params struct
+	 *            (uint8_t)a1=INT13_CMD_xxx */
+	CMD_INT13               = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_FC, 32),
+
+	/* logical uplink enable/disable: (uint64_t)a0: 0/1=disable/enable */
+	CMD_LOGICAL_UPLINK      = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 33),
+
+	/* undo initialize of virtual link */
+	CMD_DEINIT		= _CMDCNW(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 34),
+
+	/* check fw capability of a cmd:
+	 * in:  (uint32_t)a0=cmd
+	 * out: (uint32_t)a0=errno, 0:valid cmd, a1=supported VNIC_STF_* bits */
+	CMD_CAPABILITY      = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 36),
+
+	/* persistent binding info
+	 * in:  (uint64_t)a0=paddr of arg
+	 *      (uint32_t)a1=CMD_PERBI_XXX */
+	CMD_PERBI       = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_FC, 37),
+
+	/* Interrupt Assert Register functionality
+	 * in: (uint16_t)a0=interrupt number to assert
+	 */
+	CMD_IAR         = _CMDCNW(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 38),
+
+	/* initiate hangreset, like softreset after hang detected */
+	CMD_HANG_RESET      = _CMDC(_CMD_DIR_NONE, _CMD_VTYPE_ALL, 39),
+
+	/* hangreset status:
+	 *    out: a0=0 reset complete, a0=1 reset in progress */
+	CMD_HANG_RESET_STATUS   = _CMDC(_CMD_DIR_READ, _CMD_VTYPE_ALL, 40),
+
+	/*
+	 * Set hw ingress packet vlan rewrite mode:
+	 * in:  (uint32_t)a0=new vlan rewrite mode
+	 * out: (uint32_t)a0=old vlan rewrite mode */
+	CMD_IG_VLAN_REWRITE_MODE = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ENET, 41),
+
+	/*
+	 * in:  (uint16_t)a0=bdf of target vnic
+	 *      (uint32_t)a1=cmd to proxy
+	 *      a2-a15=args to cmd in a1
+	 * out: (uint32_t)a0=status of proxied cmd
+	 *      a1-a15=out args of proxied cmd */
+	CMD_PROXY_BY_BDF =  _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 42),
+
+	/*
+	 * As for BY_BDF except a0 is index of hvnlink subordinate vnic
+	 * or SR-IOV virtual vnic
+	 */
+	CMD_PROXY_BY_INDEX =    _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 43),
+
+	/*
+	 * For HPP toggle:
+	 * adapter-info-get
+	 * in:  (uint64_t)a0=phsical address of buffer passed in from caller.
+	 *      (uint16_t)a1=size of buffer specified in a0.
+	 * out: (uint64_t)a0=phsical address of buffer passed in from caller.
+	 *      (uint16_t)a1=actual bytes from VIF-CONFIG-INFO TLV, or
+	 *              0 if no VIF-CONFIG-INFO TLV was ever received. */
+	CMD_CONFIG_INFO_GET = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 44),
+
+	/*
+	 * INT13 API: (uint64_t)a0=paddr to vnic_int13_params struct
+	 *            (uint32_t)a1=INT13_CMD_xxx
+	 */
+	CMD_INT13_ALL = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ALL, 45),
+
+	/*
+	 * Set default vlan:
+	 * in: (uint16_t)a0=new default vlan
+	 *     (uint16_t)a1=zero for overriding vlan with param a0,
+	 *             non-zero for resetting vlan to the default
+	 * out: (uint16_t)a0=old default vlan
+	 */
+	CMD_SET_DEFAULT_VLAN = _CMDC(_CMD_DIR_RW, _CMD_VTYPE_ALL, 46)
+};
+
+/* flags for CMD_OPEN */
+#define CMD_OPENF_OPROM		 0x1	/* open coming from option rom */
+#define CMD_OPENF_RQ_ENABLE_FILL 0x2    /* Driver that posts RQ buffers after Enable */
+
+/* flags for CMD_INIT */
+#define CMD_INITF_DEFAULT_MAC	0x1	/* init with default mac addr */
+
+/* flags for CMD_PACKET_FILTER */
+#define CMD_PFILTER_DIRECTED		0x01
+#define CMD_PFILTER_MULTICAST		0x02
+#define CMD_PFILTER_BROADCAST		0x04
+#define CMD_PFILTER_PROMISCUOUS		0x08
+#define CMD_PFILTER_ALL_MULTICAST	0x10
+
+enum vnic_devcmd_status {
+	STAT_NONE = 0,
+	STAT_BUSY = 1 << 0,	/* cmd in progress */
+	STAT_ERROR = 1 << 1,	/* last cmd caused error (code in a0) */
+};
+
+enum vnic_devcmd_error {
+	ERR_SUCCESS = 0,
+	ERR_EINVAL = 1,
+	ERR_EFAULT = 2,
+	ERR_EPERM = 3,
+	ERR_EBUSY = 4,
+	ERR_ECMDUNKNOWN = 5,
+	ERR_EBADSTATE = 6,
+	ERR_ENOMEM = 7,
+	ERR_ETIMEDOUT = 8,
+	ERR_ELINKDOWN = 9,
+};
+
+struct vnic_devcmd_fw_info {
+	char fw_version[32];
+	char fw_build[32];
+	char hw_version[32];
+	char hw_serial_number[32];
+};
+
+struct vnic_devcmd_notify {
+	uint32_t csum;		/* checksum over following words */
+
+	uint32_t link_state;		/* link up == 1 */
+	uint32_t port_speed;		/* effective port speed (rate limit) */
+	uint32_t mtu;		/* MTU */
+	uint32_t msglvl;		/* requested driver msg lvl */
+	uint32_t uif;		/* uplink interface */
+	uint32_t status;		/* status bits (see VNIC_STF_*) */
+	uint32_t error;		/* error code (see ERR_*) for first ERR */
+	uint32_t link_down_cnt;	/* running count of link down transitions */
+};
+#define VNIC_STF_FATAL_ERR	0x0001	/* fatal fw error */
+
+struct vnic_devcmd_provinfo {
+	uint8_t oui[3];
+	uint8_t type;
+	uint8_t data[0];
+};
+
+/*
+ * Writing cmd register causes STAT_BUSY to get set in status register.
+ * When cmd completes, STAT_BUSY will be cleared.
+ *
+ * If cmd completed successfully STAT_ERROR will be clear
+ * and args registers contain cmd-specific results.
+ *
+ * If cmd error, STAT_ERROR will be set and args[0] contains error code.
+ *
+ * status register is read-only.  While STAT_BUSY is set,
+ * all other register contents are read-only.
+ */
+
+/* Make sizeof(vnic_devcmd) a power-of-2 for I/O BAR. */
+#define VNIC_DEVCMD_NARGS 15
+struct vnic_devcmd {
+	uint32_t status;			/* RO */
+	uint32_t cmd;				/* RW */
+	uint64_t args[VNIC_DEVCMD_NARGS];	/* RW cmd args (little-endian) */
+};
+
+#endif /* _VNIC_DEVCMD_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_intr.c b/drivers/staging/fnic2/src/vnic_intr.c
new file mode 100644
index 0000000..6cdebf7
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_intr.c
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
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include "vnic_dev.h"
+#include "vnic_intr.h"
+
+void vnic_intr_free(struct vnic_intr *intr)
+{
+	intr->ctrl = NULL;
+}
+
+int vnic_intr_alloc(struct vnic_dev *vdev, struct vnic_intr *intr,
+		    unsigned int index)
+{
+	intr->index = index;
+	intr->vdev = vdev;
+
+	intr->ctrl = vnic_dev_get_res(vdev, RES_TYPE_INTR_CTRL, index);
+	if (!intr->ctrl) {
+		pr_err("Failed to hook INTR[%d].ctrl resource\n",
+			index);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void vnic_intr_init(struct vnic_intr *intr, unsigned int coalescing_timer,
+		    unsigned int coalescing_type,
+		    unsigned int mask_on_assertion)
+{
+	iowrite32(coalescing_timer, &intr->ctrl->coalescing_timer);
+	iowrite32(coalescing_type, &intr->ctrl->coalescing_type);
+	iowrite32(mask_on_assertion, &intr->ctrl->mask_on_assertion);
+	iowrite32(0, &intr->ctrl->int_credits);
+}
+
+void vnic_intr_clean(struct vnic_intr *intr)
+{
+	iowrite32(0, &intr->ctrl->int_credits);
+}
diff --git a/drivers/staging/fnic2/src/vnic_intr.h b/drivers/staging/fnic2/src/vnic_intr.h
new file mode 100644
index 0000000..d806465
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_intr.h
@@ -0,0 +1,116 @@
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
+#ifndef _VNIC_INTR_H_
+#define _VNIC_INTR_H_
+
+#include <linux/pci.h>
+#include "vnic_dev.h"
+
+/*
+ * These defines avoid symbol clash between fnic2 and enic (Cisco 10G Eth
+ * Driver) when both are built with CONFIG options =y
+ */
+#define vnic_intr_unmask fnic2_intr_unmask
+#define vnic_intr_mask fnic2_intr_mask
+#define vnic_intr_return_credits fnic2_intr_return_credits
+#define vnic_intr_credits fnic2_intr_credits
+#define vnic_intr_return_all_credits fnic2_intr_return_all_credits
+#define vnic_intr_legacy_pba fnic2_intr_legacy_pba
+#define vnic_intr_free fnic2_intr_free
+#define vnic_intr_alloc fnic2_intr_alloc
+#define vnic_intr_init fnic2_intr_init
+#define vnic_intr_clean fnic2_intr_clean
+
+#define VNIC_INTR_TIMER_MAX		0xffff
+
+/* Interrupt control */
+struct vnic_intr_ctrl {
+	uint32_t coalescing_timer;	/* 0x00 */
+	uint32_t pad0;
+	uint32_t coalescing_value;	/* 0x08 */
+	uint32_t pad1;
+	uint32_t coalescing_type;	/* 0x10 */
+	uint32_t pad2;
+	uint32_t mask_on_assertion;	/* 0x18 */
+	uint32_t pad3;
+	uint32_t mask;			/* 0x20 */
+	uint32_t pad4;
+	uint32_t int_credits;		/* 0x28 */
+	uint32_t pad5;
+	uint32_t int_credit_return;	/* 0x30 */
+	uint32_t pad6;
+};
+
+struct vnic_intr {
+	unsigned int			index;
+	struct vnic_dev			*vdev;
+	struct vnic_intr_ctrl __iomem	*ctrl;	/* memory-mapped */
+};
+
+static inline void vnic_intr_unmask(struct vnic_intr *intr)
+{
+	iowrite32(0, &intr->ctrl->mask);
+}
+
+static inline void vnic_intr_mask(struct vnic_intr *intr)
+{
+	iowrite32(1, &intr->ctrl->mask);
+}
+
+static inline void vnic_intr_return_credits(struct vnic_intr *intr,
+					    unsigned int credits,
+					    int unmask, int reset_timer)
+{
+#define VNIC_INTR_UNMASK_SHIFT		16
+#define VNIC_INTR_RESET_TIMER_SHIFT	17
+
+	uint32_t int_credit_return = (credits & 0xffff) |
+		(unmask ? (1 << VNIC_INTR_UNMASK_SHIFT) : 0) |
+		(reset_timer ? (1 << VNIC_INTR_RESET_TIMER_SHIFT) : 0);
+
+	iowrite32(int_credit_return, &intr->ctrl->int_credit_return);
+}
+
+static inline unsigned int vnic_intr_credits(struct vnic_intr *intr)
+{
+	return ioread32(&intr->ctrl->int_credits);
+}
+
+static inline void vnic_intr_return_all_credits(struct vnic_intr *intr)
+{
+	unsigned int credits = vnic_intr_credits(intr);
+	int unmask = 1;
+	int reset_timer = 1;
+
+	vnic_intr_return_credits(intr, credits, unmask, reset_timer);
+}
+
+static inline uint32_t vnic_intr_legacy_pba(uint32_t __iomem *legacy_pba)
+{
+	/* read PBA without clearing */
+	return ioread32(legacy_pba);
+}
+
+void vnic_intr_free(struct vnic_intr *intr);
+int vnic_intr_alloc(struct vnic_dev *vdev, struct vnic_intr *intr,
+		    unsigned int index);
+void vnic_intr_init(struct vnic_intr *intr, unsigned int coalescing_timer,
+		    unsigned int coalescing_type, unsigned int mask_on_assertion);
+void vnic_intr_clean(struct vnic_intr *intr);
+
+#endif /* _VNIC_INTR_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_nic.h b/drivers/staging/fnic2/src/vnic_nic.h
new file mode 100644
index 0000000..aa5794c
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_nic.h
@@ -0,0 +1,78 @@
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
+#ifndef _VNIC_NIC_H_
+#define _VNIC_NIC_H_
+
+/*
+ * These defines avoid symbol clash between fnic2 and enic (Cisco 10G Eth
+ * Driver) when both are built with CONFIG options =y
+ */
+#define vnic_set_nic_cfg fnic2_set_nic_cfg
+
+enum nic_cfg_rss {
+	NIC_CFG_RSS_DEFAULT_CPU_MASK_FIELD	= 0xffUL,
+	NIC_CFG_RSS_HASH_TYPE_MASK_FIELD	= 0xffUL,
+	NIC_CFG_RSS_HASH_TYPE_SHIFT		= 8,
+	NIC_CFG_RSS_HASH_BITS			= (7UL << 16),
+	NIC_CFG_RSS_HASH_BITS_MASK_FIELD	= 7UL,
+	NIC_CFG_RSS_HASH_BITS_SHIFT		= 16,
+	NIC_CFG_RSS_BASE_CPU			= (7UL << 19),
+	NIC_CFG_RSS_BASE_CPU_MASK_FIELD		= 7UL,
+	NIC_CFG_RSS_BASE_CPU_SHIFT		= 19,
+	NIC_CFG_RSS_ENABLE			= (1UL << 22),
+	NIC_CFG_RSS_ENABLE_MASK_FIELD		= 1UL,
+	NIC_CFG_RSS_ENABLE_SHIFT		= 22
+};
+
+enum nic_cfg_tso {
+	NIC_CFG_TSO_IPID_SPLIT_EN		= (1UL << 23),
+	NIC_CFG_TSO_IPID_SPLIT_EN_MASK_FIELD	= 1UL,
+	NIC_CFG_TSO_IPID_SPLIT_EN_SHIFT		= 23
+};
+
+enum nic_cfg_ig_vlan_strip {
+	NIC_CFG_IG_VLAN_STRIP_EN		= (1UL << 24),
+	NIC_CFG_IG_VLAN_STRIP_EN_MASK_FIELD	= 1UL,
+	NIC_CFG_IG_VLAN_STRIP_EN_SHIFT		= 24
+};
+
+static inline void vnic_set_nic_cfg(uint32_t *nic_cfg,
+				    uint8_t rss_default_cpu,
+				    uint8_t rss_hash_type,
+				    uint8_t rss_hash_bits,
+				    uint8_t rss_base_cpu,
+				    uint8_t rss_enable,
+				    uint8_t tso_ipid_split_en,
+				    uint8_t ig_vlan_strip_en)
+{
+	*nic_cfg = (rss_default_cpu & NIC_CFG_RSS_DEFAULT_CPU_MASK_FIELD) |
+		((rss_hash_type & NIC_CFG_RSS_HASH_TYPE_MASK_FIELD)
+			<< NIC_CFG_RSS_HASH_TYPE_SHIFT) |
+		((rss_hash_bits & NIC_CFG_RSS_HASH_BITS_MASK_FIELD)
+			<< NIC_CFG_RSS_HASH_BITS_SHIFT) |
+		((rss_base_cpu & NIC_CFG_RSS_BASE_CPU_MASK_FIELD)
+			<< NIC_CFG_RSS_BASE_CPU_SHIFT) |
+		((rss_enable & NIC_CFG_RSS_ENABLE_MASK_FIELD)
+			<< NIC_CFG_RSS_ENABLE_SHIFT) |
+		((tso_ipid_split_en & NIC_CFG_TSO_IPID_SPLIT_EN_MASK_FIELD)
+			<< NIC_CFG_TSO_IPID_SPLIT_EN_SHIFT) |
+		((ig_vlan_strip_en & NIC_CFG_IG_VLAN_STRIP_EN_MASK_FIELD)
+			<< NIC_CFG_IG_VLAN_STRIP_EN_SHIFT);
+}
+
+#endif /* _VNIC_NIC_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_resource.h b/drivers/staging/fnic2/src/vnic_resource.h
new file mode 100644
index 0000000..4e6a05d
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_resource.h
@@ -0,0 +1,50 @@
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
+#ifndef _VNIC_RESOURCE_H_
+#define _VNIC_RESOURCE_H_
+
+#define VNIC_RES_MAGIC		0x766E6963L	/* 'vnic' */
+#define VNIC_RES_VERSION	0x00000000L
+
+/* vNIC resource types */
+enum vnic_res_type {
+	RES_TYPE_EOL,				/* End-of-list */
+	RES_TYPE_WQ,				/* Work queues */
+	RES_TYPE_RQ,				/* Receive queues */
+	RES_TYPE_CQ,				/* Completion queues */
+	RES_TYPE_INTR_CTRL		= 10,	/* Interrupt ctrl table */
+	RES_TYPE_INTR_PBA		= 12,	/* MSI/MSI-X PBA table */
+	RES_TYPE_INTR_PBA_LEGACY,		/* Legacy intr status */
+	RES_TYPE_DEVCMD = 16,			/* Device command region */
+	RES_TYPE_MAX = 18			/* Count of resource types */
+};
+
+struct vnic_resource_header {
+	uint32_t magic;
+	uint32_t version;
+};
+
+struct vnic_resource {
+	uint8_t		type;
+	uint8_t		bar;
+	uint8_t		pad[2];
+	uint32_t	bar_offset;
+	uint32_t	count;
+};
+
+#endif /* _VNIC_RESOURCE_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_scsi.h b/drivers/staging/fnic2/src/vnic_scsi.h
new file mode 100644
index 0000000..49e2304
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_scsi.h
@@ -0,0 +1,88 @@
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
+#ifndef _VNIC_SCSI_H_
+#define _VNIC_SCSI_H_
+
+#define VNIC_FNIC2_WQ_DESCS_MIN              64
+#define VNIC_FNIC2_WQ_DESCS_MAX              128
+
+#define VNIC_FNIC2_WQ_COPY_DESCS_MIN         64
+#define VNIC_FNIC2_WQ_COPY_DESCS_MAX         512
+
+#define VNIC_FNIC2_RQ_DESCS_MIN              64
+#define VNIC_FNIC2_RQ_DESCS_MAX              128
+
+#define VNIC_FNIC2_EDTOV_MIN                 1000
+#define VNIC_FNIC2_EDTOV_MAX                 255000
+
+#define VNIC_FNIC2_RATOV_MIN                 1000
+#define VNIC_FNIC2_RATOV_MAX                 255000
+
+#define VNIC_FNIC2_MAXDATAFIELDSIZE_MIN      256
+#define VNIC_FNIC2_MAXDATAFIELDSIZE_MAX      2112
+
+#define VNIC_FNIC2_FLOGI_RETRIES_MAX         0xffffffff
+
+#define VNIC_FNIC2_FLOGI_TIMEOUT_MIN         1000
+#define VNIC_FNIC2_FLOGI_TIMEOUT_MAX         255000
+
+#define VNIC_FNIC2_PLOGI_RETRIES_MAX         255
+
+#define VNIC_FNIC2_PLOGI_TIMEOUT_MIN         1000
+#define VNIC_FNIC2_PLOGI_TIMEOUT_MAX         255000
+
+#define VNIC_FNIC2_IO_THROTTLE_COUNT_MIN     1
+#define VNIC_FNIC2_IO_THROTTLE_COUNT_MAX     2048
+
+#define VNIC_FNIC2_LINK_DOWN_TIMEOUT_MAX     240000
+
+#define VNIC_FNIC2_PORT_DOWN_TIMEOUT_MAX     240000
+
+#define VNIC_FNIC2_PORT_DOWN_IO_RETRIES_MAX  255
+
+#define VNIC_FNIC2_LUNS_PER_TARGET_MIN       1
+#define VNIC_FNIC2_LUNS_PER_TARGET_MAX       1024
+
+/* Device-specific region: scsi configuration */
+struct vnic_fc_config {
+	uint64_t	node_wwn;
+	uint64_t	port_wwn;
+	uint32_t	flags;
+	uint32_t	wq_enet_desc_count;
+	uint32_t	wq_copy_desc_count;
+	uint32_t	rq_desc_count;
+	uint32_t	flogi_retries;
+	uint32_t	flogi_timeout;
+	uint32_t	plogi_retries;
+	uint32_t	plogi_timeout;
+	uint32_t	io_throttle_count;
+	uint32_t	link_down_timeout;
+	uint32_t	port_down_timeout;
+	uint32_t	port_down_io_retries;
+	uint32_t	luns_per_tgt;
+	uint16_t	maxdatafieldsize;
+	uint16_t	ed_tov;
+	uint16_t	ra_tov;
+	uint16_t	intr_timer;
+	uint8_t		intr_timer_type;
+};
+
+#define VFCF_FCP_SEQ_LVL_ERR	0x1	/* Enable FCP-2 Error Recovery */
+#define VFCF_FIP_CAPABLE	0x4	/* firmware can handle FIP */
+
+#endif /* _VNIC_SCSI_H_ */
diff --git a/drivers/staging/fnic2/src/vnic_stats.h b/drivers/staging/fnic2/src/vnic_stats.h
new file mode 100644
index 0000000..c608a20
--- /dev/null
+++ b/drivers/staging/fnic2/src/vnic_stats.h
@@ -0,0 +1,68 @@
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
+#ifndef _VNIC_STATS_H_
+#define _VNIC_STATS_H_
+
+/* Tx statistics */
+struct vnic_tx_stats {
+	uint64_t tx_frames_ok;
+	uint64_t tx_unicast_frames_ok;
+	uint64_t tx_multicast_frames_ok;
+	uint64_t tx_broadcast_frames_ok;
+	uint64_t tx_bytes_ok;
+	uint64_t tx_unicast_bytes_ok;
+	uint64_t tx_multicast_bytes_ok;
+	uint64_t tx_broadcast_bytes_ok;
+	uint64_t tx_drops;
+	uint64_t tx_errors;
+	uint64_t tx_tso;
+	uint64_t rsvd[16];
+};
+
+/* Rx statistics */
+struct vnic_rx_stats {
+	uint64_t rx_frames_ok;
+	uint64_t rx_frames_total;
+	uint64_t rx_unicast_frames_ok;
+	uint64_t rx_multicast_frames_ok;
+	uint64_t rx_broadcast_frames_ok;
+	uint64_t rx_bytes_ok;
+	uint64_t rx_unicast_bytes_ok;
+	uint64_t rx_multicast_bytes_ok;
+	uint64_t rx_broadcast_bytes_ok;
+	uint64_t rx_drop;
+	uint64_t rx_no_bufs;
+	uint64_t rx_errors;
+	uint64_t rx_rss;
+	uint64_t rx_crc_errors;
+	uint64_t rx_frames_64;
+	uint64_t rx_frames_127;
+	uint64_t rx_frames_255;
+	uint64_t rx_frames_511;
+	uint64_t rx_frames_1023;
+	uint64_t rx_frames_1518;
+	uint64_t rx_frames_to_max;
+	uint64_t rsvd[16];
+};
+
+struct vnic_stats {
+	struct vnic_tx_stats tx;
+	struct vnic_rx_stats rx;
+};
+
+#endif /* _VNIC_STATS_H_ */
-- 
1.8.3.1
