Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx4++uk2zSt90gZg5Lx5epOf7DONTk+xixCobKZVM3h800FyPq7ftJj+wp1NsgVRB61x/tOtI
ARC-Seal: i=1; a=rsa-sha256; t=1522962841; cv=none;
        d=google.com; s=arc-20160816;
        b=roSxf7iEpu/Fvsm7Qh3Z69ip7XSu598DtU+IdltKLVqOMBtd8d+jbFqcE59D7Y/cAQ
         UvZeembnxZXj999zwTLHx2g3EgWWp3KqX5p3YIoP+V2bbsR8g0lQDK2wG1RydTo/Hc5g
         n7q1X2VlYOxNk0bO44Bn1VB8CxklNH3a9CB5hvrb1VUUnKlKnr062MdqSeseY9Gox0fM
         cQgxEd69v3+aJUBBElCUvjgLGaWyIKltxcfDaBn5BTywd/gWJy/5FSSG5JwM/c9E3Wli
         RXz4b2yZB/Fs74O3EypNHMsxsduvvjJX8E+nghLHcbPiws47tiuG0rMC70wlu7DyUa19
         lVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=f5hcZ7xcPIJjMuFzKKqmrAPX98ulUhtG63U58edffRY=;
        b=XBy/kwxxMzFeEEXmBUKhIJV/K8PUHa540+PAEzSYAiI53ftKiGVI/oYnF8bVmIkJ3+
         fTBhNysepvXh+Jj3Qwr6Ei0uxO4sSP+1EflwiwD9r0Ymt6v9+AYhRUiSQH2/annY7DKP
         W+MxtIZ8G32w8LLBLllykyxXLf7t9YWOyWuBes/tNOTs/NlxQKXLa8sgegKjGtMVH6fd
         HfoM2ceKILVzheySviFW34jeY8u8WTk8RDrFyqHDEp1mcBw+WLw2dyUpAGlvLJhyKRnQ
         3U17oka87irPfAEtW7EU6Aw49j9noP66WMwywuZ4C/DmpY8EB3+BVtsvhMohKPkkfqwp
         O1+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=FdcZBzfI;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.89 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=FdcZBzfI;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.89 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94770244"
Date: Thu, 5 Apr 2018 14:16:45 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 01/10] staging: fnic2 add initialization
Message-ID: <20180405211644.GB12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942284542554315?=
X-GMAIL-MSGID: =?utf-8?q?1596942284542554315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain module load and unload, global driver context,
PCI registration, PCI probe and remove, and definitions of
the fnic2 global context.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/fnic2.h      | 256 ++++++++++++
 drivers/staging/fnic2/src/fnic2_main.c | 711 +++++++++++++++++++++++++++++++++
 2 files changed, 967 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/fnic2.h
 create mode 100644 drivers/staging/fnic2/src/fnic2_main.c

diff --git a/drivers/staging/fnic2/src/fnic2.h b/drivers/staging/fnic2/src/fnic2.h
new file mode 100644
index 0000000..81b54da
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2.h
@@ -0,0 +1,256 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2017 Cisco Systems, Inc.  All rights reserved.
+ */
+#ifndef _FNIC2_H_
+#define _FNIC2_H_
+
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/workqueue.h>
+#include <linux/bitops.h>
+#include <linux/version.h>
+#include <linux/mempool.h>
+#include <linux/cpumask.h>
+#include "fnic2_fdls.h"
+#include "fnic2_res.h"
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_rq.h"
+#include "vnic_cq.h"
+#include "vnic_wq_copy.h"
+#include "vnic_intr.h"
+#include "vnic_stats.h"
+#include "vnic_scsi.h"
+#include "fnic2_lio.h"
+
+#define DRV_NAME			"fnic2"
+#define DRV_DESCRIPTION		"Cisco FCoE Target Driver"
+#define DRV_VERSION			"0.0.0.1"
+#define JIFFIES_PER_MINUTE      	(60 * HZ)
+
+#define DESC_CLEAN_LOW_WATERMARK	8
+#define FNIC2_MAX_TCMDS 		1024
+#define MAX_FNIC2S 			16
+#define MAX_DATA_LENGTH		(1024 * 1024)
+#define ABTS_MASK			0x10000
+
+#define SCSI_READ_MASK	0x08
+#define SCSI_WRITE_MASK	0x0A
+#define IS_SCSI_READ_CMD(_cmd_)  ((_cmd_->fchdr.r_ctl == FC_R_CTL_FC4_CMD) && ((_cmd_->cdb[0] & 0x1F) == SCSI_READ_MASK))
+#define IS_SCSI_WRITE_CMD(_cmd_) ((_cmd_->fchdr.r_ctl == FC_R_CTL_FC4_CMD) && ((_cmd_->cdb[0] & 0x1F) == SCSI_WRITE_MASK))
+
+extern const char *fnic2_state_str[];
+extern unsigned int fnic2_log_level;
+
+enum fnic2_intx_intr_index {
+	FNIC2_INTX_WQ_RQ_COPYWQ,
+	FNIC2_INTX_ERR,
+	FNIC2_INTX_NOTIFY
+};
+
+enum fnic2_msix_intr_index {
+	FNIC2_MSIX_RQ,
+	FNIC2_MSIX_WQ,
+	FNIC2_MSIX_WQ_COPY,
+	FNIC2_MSIX_ERR_NOTIFY,
+	FNIC2_MSIX_INTR_MAX
+};
+
+struct fnic2_msix_entry {
+	int		requested;
+	char		devname[IFNAMSIZ];
+	irqreturn_t	(*isr)(int, void *);
+	void		*devid;
+};
+
+enum fnic2_state {
+	FNIC2_IN_FC_MODE = 0,
+	FNIC2_IN_FC_TRANS_ETH_MODE,
+	FNIC2_IN_ETH_MODE,
+	FNIC2_IN_ETH_TRANS_FC_MODE
+};
+
+#define SCSI_NO_TAG -1
+
+#define FNIC2_WQ_COPY_MAX 1
+#define FNIC2_WQ_MAX 1
+#define FNIC2_RQ_MAX 1
+#define FNIC2_CQ_MAX (FNIC2_WQ_COPY_MAX + FNIC2_WQ_MAX + FNIC2_RQ_MAX)
+
+struct fnic2_frame_list {
+	/*
+	 * Link to frame lists
+	 */
+	struct list_head	links;
+	void			*fp;
+	int			frame_len;
+	int			rx_ethhdr_stripped;
+};
+
+/* Per-instance private data structure */
+struct fnic2 {
+	int						fnic2_num;
+	struct fnic2_lport				lport;
+	struct vnic_dev_bar				bar0;
+
+	struct msix_entry				msix_entry[FNIC2_MSIX_INTR_MAX];
+	struct fnic2_msix_entry				msix[FNIC2_MSIX_INTR_MAX];
+
+	struct vnic_stats				*stats;
+
+	/* time of stats update */
+	unsigned long					stats_time;
+
+	/* time of stats reset */
+	unsigned long					stats_reset_time;
+
+	struct vnic_nic_cfg				*nic_cfg;
+	char						name[IFNAMSIZ];
+
+	/* used for MSI interrupts */
+	struct timer_list				notify_timer;
+
+	unsigned int					fnic2_max_tag_id;
+	unsigned int					err_intr_offset;
+	unsigned int					link_intr_offset;
+
+	unsigned int					wq_count;
+	unsigned int					cq_count;
+
+	atomic64_t					io_cmpl_skip;
+
+	/* fnic2 device in removal */
+	uint32_t					in_remove:1;
+
+	/* stop proc. rx frames, link events */
+	uint32_t					stop_rx_link_events:1;
+
+	/* Device remove thread blocks */
+	struct completion				*remove_wait;
+
+	/* IO Counter */
+	atomic_t					in_flight;
+
+	bool						internal_reset_progress;
+
+	/* fill hole */
+	uint32_t _reserved;
+
+	enum						fnic2_state state;
+	spinlock_t					fnic2_lock;
+
+	/* VLAN tag including priority */
+	uint16_t					vlan_id;
+
+	uint8_t						data_src_addr[ETH_ALEN];
+
+	/* Internal statistics */
+	uint64_t					fcp_input_bytes;
+	uint64_t 					fcp_output_bytes;
+
+	uint32_t					link_down_cnt;
+	int						link_status;
+
+	struct list_head				list;
+	struct pci_dev					*pdev;
+	struct vnic_fc_config				config;
+	struct vnic_dev					*vdev;
+	unsigned int					raw_wq_count;
+	unsigned int					wq_copy_count;
+	unsigned int					rq_count;
+	int						fw_ack_index[FNIC2_WQ_COPY_MAX];
+	unsigned short					fw_ack_recd[FNIC2_WQ_COPY_MAX];
+	unsigned short					wq_copy_desc_low[FNIC2_WQ_COPY_MAX];
+	unsigned int					intr_count;
+	uint32_t __iomem				*legacy_pba;
+	struct fnic2_host_tag				*tags;
+
+	struct work_struct				link_work;
+	struct work_struct				frame_work;
+	struct list_head				frame_queue;
+	struct list_head				tx_queue;
+
+	/*** FIP related data members  -- start ***/
+	void						(*set_vlan)(struct fnic2 *, uint16_t vlan);
+	struct work_struct				fip_work;
+	struct list_head				fip_frame_queue;
+	struct list_head				vlan_list;
+	spinlock_t					vlans_lock;
+	struct timer_list				retry_fip_timer;
+	struct timer_list				fcs_ka_timer;
+	struct timer_list				enode_ka_timer;
+	struct timer_list				vn_ka_timer;
+
+	struct work_struct				event_work;
+	/*** FIP related data members  -- end ***/
+
+	/* copy work queue cache line section */
+	____cacheline_aligned struct vnic_wq_copy	wq_copy[FNIC2_WQ_COPY_MAX];
+	/* completion queue cache line section */
+	____cacheline_aligned struct vnic_cq		cq[FNIC2_CQ_MAX];
+
+	spinlock_t 					wq_copy_lock[FNIC2_WQ_COPY_MAX];
+
+	/* work queue cache line section */
+	____cacheline_aligned struct vnic_wq		wq[FNIC2_WQ_MAX];
+	spinlock_t					wq_lock[FNIC2_WQ_MAX];
+
+	/* receive queue cache line section */
+	____cacheline_aligned struct vnic_rq		rq[FNIC2_RQ_MAX];
+
+	/* interrupt resource cache line section */
+	____cacheline_aligned struct vnic_intr		intr[FNIC2_MSIX_INTR_MAX];
+
+       /* fnic2 related structures */
+	struct fnic2_lio				lio;
+	struct list_head				tcmd_list_free;
+	struct fnic2_cmd				*tcmd_pool;
+	spinlock_t					free_list_lock;
+
+	/* DBG related, temp */
+	int						freecmds;
+};
+
+static inline int get_cpu_to_queue(uint32_t tag)
+{
+	return tag % num_online_cpus();
+}
+
+extern struct workqueue_struct *fnic2_event_queue;
+extern struct workqueue_struct *fip_event_queue;
+extern struct workqueue_struct *fnic2_tcmd_wq;
+
+void fnic2_clear_intr_mode(struct fnic2 *fnic2);
+int fnic2_set_intr_mode(struct fnic2 *fnic2);
+void fnic2_free_intr(struct fnic2 *fnic2);
+int fnic2_request_intr(struct fnic2 *fnic2);
+
+void fnic2_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf);
+void fnic2_handle_frame(struct work_struct *work);
+void fnic2_handle_fip_frame(struct work_struct *work);
+void fnic2_handle_link(struct work_struct *work);
+int fnic2_rq_cmpl_handler(struct fnic2 *fnic2, int);
+int fnic2_alloc_rq_frame(struct vnic_rq *rq);
+void fnic2_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
+void fnic2_flush_tx(struct fnic2 *);
+int fnic2_wq_copy_cmpl_handler(struct fnic2 *fnic2, int);
+int fnic2_wq_cmpl_handler(struct fnic2 *fnic2, int);
+void fnic2_wq_copy_cleanup_handler(struct vnic_wq_copy *wq, struct fcpio_host_req *desc);
+int fnic2_fw_reset_handler(struct fnic2 *fnic2);
+const char *fnic2_state_to_str(unsigned int state);
+
+void fnic2_log_q_error(struct fnic2 *fnic2);
+void fnic2_handle_link_event(struct fnic2 *fnic2);
+
+void fnic2_send_fcp_resp(struct fnic2_cmd *tcmd);
+void fnic2_send_tmr_resp(struct fnic2_cmd *tcmd, u32 status, u8 code);
+void fnic2_complete_tm_rsp(struct fnic2_cmd *tcmd);
+void fnic2_send_abort_to_lio(struct fnic2_cmd *tcmd);
+void fnic2_send_abort_to_fw(struct fnic2_cmd *tcmd);
+void fnic2_fw_abort_done(struct fnic2_cmd *tcmd);
+void fnic2_recv_tcmd_timeout_intr(struct timer_list *timer);
+
+struct fnic2_sess *fnic2_find_session(struct fnic2 *fnic2, uint64_t wwpn);
+struct fnic2_sess *fnic2_find_sess_s_id(struct fnic2 *fnic2, uint32_t s_id);
+#endif /* _FNIC2_H_ */
diff --git a/drivers/staging/fnic2/src/fnic2_main.c b/drivers/staging/fnic2/src/fnic2_main.c
new file mode 100644
index 0000000..2643772
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_main.c
@@ -0,0 +1,711 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ */
+#include <linux/module.h>
+#include <linux/mempool.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/skbuff.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/if_ether.h>
+#include <linux/timer.h>
+#include "vnic_dev.h"
+#include "vnic_intr.h"
+#include "vnic_stats.h"
+#include "fnic2.h"
+
+uint8_t fip_all_enode_macs[6] = {0x01, 0x10, 0x18, 0x01, 0x00, 0x01};
+#define PCI_DEVICE_ID_CISCO_TNIC	0x0045
+
+/* Timer to poll notification area for events. Used for MSI interrupts */
+#define FNIC2_NOTIFY_TIMER_PERIOD	(2 * HZ)
+
+LIST_HEAD(fnic2_list);
+DEFINE_SPINLOCK(fnic2_list_lock);
+
+/* Supported devices by fnic2 module */
+static struct pci_device_id fnic2_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CISCO, PCI_DEVICE_ID_CISCO_TNIC) },
+	{ 0, }
+};
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_AUTHOR("Arulprabhu Ponnusamy <arulponn@cisco.com>");
+MODULE_AUTHOR("Gian Carlo Boffa <gcboffa@cisco.com>");
+MODULE_AUTHOR("Oliver Smith-Denny <osmithde@cisco.com>");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, fnic2_id_table);
+MODULE_LICENSE("GPL v2");
+
+extern void fnic2_lio_init(void);
+extern void fnic2_lio_cleanup(void);
+
+struct workqueue_struct *fnic2_tcmd_wq;
+
+static struct fnic2 *fnic2_alloc(void)
+{
+	struct fnic2 *fnic2;
+
+	fnic2 = kzalloc(sizeof(struct fnic2), GFP_KERNEL);
+	if (fnic2 == NULL) {
+		pr_err("ERROR Unable to create memory for fnic2 structure\n");
+		return NULL;
+
+	}
+	return fnic2;
+}
+
+static int fnic2_alloc_tcmd_pool(struct fnic2 *fnic2)
+{
+	struct fnic2_cmd *tcmd;
+	int tag;
+	int sz;
+	unsigned int flags;
+
+	/* Allocate Cmd pool and initialize them with cmd_tag */
+	sz = sizeof(struct fnic2_cmd) * FNIC2_MAX_TCMDS;
+	fnic2->tcmd_pool =
+		(struct fnic2_cmd *)kzalloc(sz, GFP_KERNEL);
+	if (!fnic2->tcmd_pool) {
+		pr_err("Unable to allocate tcmd pool\n");
+		WARN_ON(1);
+		return -ENOMEM;
+	}
+	pr_err("fnic2_alloc_tcmd_pool of total size: %d, pool: %pK\n", sz, fnic2->tcmd_pool);
+
+	/* Initialize free list */
+	INIT_LIST_HEAD(&fnic2->tcmd_list_free);
+
+	tcmd = &fnic2->tcmd_pool[0];
+	for (tag = 0; tag < FNIC2_MAX_TCMDS; tag++, tcmd++) {
+		tcmd->cmd_tag = tag;
+		tcmd->fnic2 = fnic2;
+		timer_setup(&tcmd->io_timer, fnic2_recv_tcmd_timeout_intr, flags);
+		list_add_tail(&tcmd->free_list, &fnic2->tcmd_list_free);
+	}
+	spin_lock_init(&fnic2->free_list_lock);
+	fnic2->freecmds = FNIC2_MAX_TCMDS;
+
+	pr_err("fnic2_alloc_tcmd_pool done\n");
+
+	return 0;
+}
+
+void fnic2_log_q_error(struct fnic2 *fnic2)
+{
+	unsigned int i;
+	uint32_t error_status;
+
+	for (i = 0; i < fnic2->raw_wq_count; i++) {
+		error_status = ioread32(&fnic2->wq[i].ctrl->error_status);
+		if (error_status)
+			pr_err("WQ[%d] error_status %d\n",
+				i, error_status);
+	}
+
+	for (i = 0; i < fnic2->rq_count; i++) {
+		error_status = ioread32(&fnic2->rq[i].ctrl->error_status);
+		if (error_status)
+			pr_err("RQ[%d] error_status %d\n",
+				i, error_status);
+	}
+
+	for (i = 0; i < fnic2->wq_copy_count; i++) {
+		error_status = ioread32(&fnic2->wq_copy[i].ctrl->error_status);
+		if (error_status)
+			pr_err("CWQ[%d] error_status %d\n",
+				i, error_status);
+	}
+}
+
+void fnic2_handle_link_event(struct fnic2 *fnic2)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (fnic2->stop_rx_link_events) {
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	queue_work(fnic2_event_queue, &fnic2->link_work);
+
+	pr_info("fnic2_handle_link_event\n");
+
+}
+
+static int fnic2_notify_set(struct fnic2 *fnic2)
+{
+	int err;
+
+	switch (vnic_dev_get_intr_mode(fnic2->vdev)) {
+	case VNIC_DEV_INTR_MODE_INTX:
+		err = vnic_dev_notify_set(fnic2->vdev, FNIC2_INTX_NOTIFY);
+		break;
+	case VNIC_DEV_INTR_MODE_MSI:
+		err = vnic_dev_notify_set(fnic2->vdev, -1);
+		break;
+	case VNIC_DEV_INTR_MODE_MSIX:
+		err = vnic_dev_notify_set(fnic2->vdev, FNIC2_MSIX_ERR_NOTIFY);
+		break;
+	default:
+		pr_err("Interrupt mode should be set up before devcmd notify set %d\n",
+			     vnic_dev_get_intr_mode(fnic2->vdev));
+		err = -1;
+		break;
+	}
+
+	return err;
+}
+
+static void fnic2_notify_timer(struct timer_list *timer)
+{
+	struct fnic2 *fnic2 = container_of(timer, struct fnic2, notify_timer);
+
+	fnic2_handle_link_event(fnic2);
+	mod_timer(&fnic2->notify_timer,
+		  round_jiffies(jiffies + FNIC2_NOTIFY_TIMER_PERIOD));
+}
+
+static void fnic2_notify_timer_start(struct fnic2 *fnic2)
+{
+	switch (vnic_dev_get_intr_mode(fnic2->vdev)) {
+	case VNIC_DEV_INTR_MODE_MSI:
+		/*
+		 * Schedule first timeout immediately. The driver is
+		 * initiatialized and ready to look for link up notification
+		 */
+		mod_timer(&fnic2->notify_timer, jiffies);
+		break;
+	default:
+		/* Using intr for notification for INTx/MSI-X */
+		break;
+	};
+}
+
+static int fnic2_dev_wait(struct vnic_dev *vdev,
+			  int (*start)(struct vnic_dev *, int),
+			  int (*finished)(struct vnic_dev *, int *),
+			  int arg)
+{
+	unsigned long time;
+	int done;
+	int err;
+	int count = 0;
+
+	err = start(vdev, arg);
+	if (err)
+		return err;
+
+	/* Wait for func to complete...2 seconds max */
+	/*
+	* Sometime schedule_timeout_uninterruptible take long time
+	* to wake up so we do not retry as we are only waiting for
+	* 2 seconds in while loop. By adding count, we make sure
+	* we try atleast two times before returning -ETIMEDOUT
+	*/
+	time = jiffies + (HZ * 2);
+	do {
+		err = finished(vdev, &done);
+		count++;
+		if (err)
+			return err;
+		if (done)
+			return 0;
+		schedule_timeout_uninterruptible(HZ / 10);
+	} while (time_after(time, jiffies) || (count < 3));
+
+	return -ETIMEDOUT;
+}
+
+static int fnic2_cleanup(struct fnic2 *fnic2)
+{
+	unsigned int i;
+	int err;
+
+	vnic_dev_disable(fnic2->vdev);
+	for (i = 0; i < fnic2->intr_count; i++)
+		vnic_intr_mask(&fnic2->intr[i]);
+
+	for (i = 0; i < fnic2->rq_count; i++) {
+		err = vnic_rq_disable(&fnic2->rq[i]);
+		if (err)
+			return err;
+	}
+	for (i = 0; i < fnic2->raw_wq_count; i++) {
+		err = vnic_wq_disable(&fnic2->wq[i]);
+		if (err)
+			return err;
+	}
+	for (i = 0; i < fnic2->wq_copy_count; i++) {
+		err = vnic_wq_copy_disable(&fnic2->wq_copy[i]);
+		if (err)
+			return err;
+	}
+
+	/* Clean up completed IOs and FCS frames */
+	fnic2_wq_copy_cmpl_handler(fnic2, -1);
+	fnic2_wq_cmpl_handler(fnic2, -1);
+	fnic2_rq_cmpl_handler(fnic2, -1);
+
+	/* Clean up the IOs and FCS frames that have not completed */
+	for (i = 0; i < fnic2->raw_wq_count; i++)
+		vnic_wq_clean(&fnic2->wq[i], fnic2_free_wq_buf);
+	for (i = 0; i < fnic2->rq_count; i++)
+		vnic_rq_clean(&fnic2->rq[i], fnic2_free_rq_buf);
+	for (i = 0; i < fnic2->wq_copy_count; i++)
+		vnic_wq_copy_clean(&fnic2->wq_copy[i],
+				   fnic2_wq_copy_cleanup_handler);
+
+	for (i = 0; i < fnic2->cq_count; i++)
+		vnic_cq_clean(&fnic2->cq[i]);
+	for (i = 0; i < fnic2->intr_count; i++)
+		vnic_intr_clean(&fnic2->intr[i]);
+
+	return 0;
+}
+
+static void fnic2_iounmap(struct fnic2 *fnic2)
+{
+	if (fnic2->bar0.vaddr)
+		iounmap(fnic2->bar0.vaddr);
+}
+
+static void fnic2_set_vlan(struct fnic2 *fnic2, uint16_t vlan_id)
+{
+	uint16_t old_vlan;
+
+	old_vlan = vnic_dev_set_default_vlan(fnic2->vdev, vlan_id);
+}
+
+static int fnic2_probe(struct pci_dev *pdev,
+		       const struct pci_device_id *ent)
+{
+	struct fnic2 *fnic2;
+	struct fnic2_lport *lport;
+	int err;
+	int i;
+	unsigned long flags;
+	int fnic2_count = 0;
+	unsigned int fip_flags, fcs_ka_flags, enode_ka_flags, vn_ka_flags, notify_flags, fabric_flags;
+	struct list_head *counter_head; /* Used to determine which fnic2 number this is */
+	uint32_t open_flags = CMD_OPENF_RQ_ENABLE_FILL;
+
+	fnic2 = fnic2_alloc();
+	if (!fnic2) {
+	    pr_err("%s: Unable to allocate memory for fnic2\n", __func__);
+	    return  0;
+	}
+
+	/* Setup PCI resources */
+	pci_set_drvdata(pdev, fnic2);
+
+	fnic2->pdev = pdev;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		pr_err("Cannot enable PCI device, aborting.\n");
+		goto err_out_free_hba;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		pr_err("Cannot enable PCI resources, aborting\n");
+		goto err_out_disable_device;
+	}
+
+	pci_set_master(pdev);
+
+	/* Query PCI controller on system for DMA addressing
+	 * limitation for the device.  Try 64-bit first, and
+	 * fail to 32-bit.
+	 */
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (err) {
+		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (err) {
+			pr_err("No usable DMA configuration aborting\n");
+			goto err_out_release_regions;
+		}
+		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (err) {
+			pr_err("Unable to obtain 32-bit DMA for consistent allocations, aborting.\n");
+			goto err_out_release_regions;
+		}
+	} else {
+		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		if (err) {
+			pr_err("Unable to obtain 64-bit DMA for consistent allocations, aborting.\n");
+			goto err_out_release_regions;
+		}
+	}
+
+	/* Map vNIC resources from BAR0 */
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
+		pr_err("BAR0 not memory-map'able, aborting.\n");
+		err = -ENODEV;
+		goto err_out_release_regions;
+	}
+
+	fnic2->bar0.vaddr = pci_iomap(pdev, 0, 0);
+	fnic2->bar0.bus_addr = pci_resource_start(pdev, 0);
+	fnic2->bar0.len = pci_resource_len(pdev, 0);
+
+	if (!fnic2->bar0.vaddr) {
+		pr_err("Cannot memory-map BAR0 res hdr, aborting.\n");
+		err = -ENODEV;
+		goto err_out_release_regions;
+	}
+
+	fnic2->vdev = vnic_dev_register(NULL, fnic2, pdev, &fnic2->bar0);
+	if (!fnic2->vdev) {
+		pr_err("vNIC registration failed, aborting.\n");
+		err = -ENODEV;
+		goto err_out_iounmap;
+	}
+
+	err = fnic2_dev_wait(fnic2->vdev, vnic_dev_open,
+			    vnic_dev_open_done, open_flags);
+	if (err) {
+		pr_err("vNIC dev open failed, aborting.\n");
+		goto err_out_vnic_unregister;
+	}
+
+	err = vnic_dev_init(fnic2->vdev, 0);
+	if (err) {
+		pr_err("vNIC dev init failed, aborting.\n");
+		goto err_out_dev_close;
+	}
+
+	lport = &fnic2->lport;
+	err = vnic_dev_mac_addr(fnic2->vdev, lport->hwmac);
+	if (err) {
+		pr_err("vNIC get MAC addr failed\n");
+		goto err_out_dev_close;
+	}
+	/* set data_src for point-to-point mode and to keep it non-zero */
+	memcpy(fnic2->data_src_addr, lport->hwmac, ETH_ALEN);
+
+	/* Get vNIC configuration */
+	err = fnic2_get_vnic_config(fnic2);
+	if (err) {
+		pr_err("Get vNIC configuration failed, aborting.\n");
+		goto err_out_dev_close;
+	}
+
+	fnic2_get_res_counts(fnic2);
+
+	err = fnic2_set_intr_mode(fnic2);
+	if (err) {
+		pr_err("Failed to set intr mode, aborting.\n");
+		goto err_out_dev_close;
+	}
+
+	err = fnic2_alloc_vnic_resources(fnic2);
+	if (err) {
+		pr_err("Failed to alloc vNIC resources, aborting.\n");
+		goto err_out_clear_intr;
+	}
+
+	/* initialize all fnic2 locks */
+	spin_lock_init(&fnic2->fnic2_lock);
+
+	for (i = 0; i < FNIC2_WQ_MAX; i++)
+		spin_lock_init(&fnic2->wq_lock[i]);
+
+	for (i = 0; i < FNIC2_WQ_COPY_MAX; i++) {
+		spin_lock_init(&fnic2->wq_copy_lock[i]);
+		fnic2->wq_copy_desc_low[i] = DESC_CLEAN_LOW_WATERMARK;
+		fnic2->fw_ack_recd[i] = 0;
+		fnic2->fw_ack_index[i] = -1;
+	}
+
+	fnic2->vlan_id = 0;
+
+	if (fnic2->config.flags & VFCF_FIP_CAPABLE) {
+		pr_info("firmware supports FIP\n");
+		/* enable directed and multicast
+		 * vdev, directed, multicast, broadcast, promisc, allmulti
+		 */
+		vnic_dev_packet_filter(fnic2->vdev, 1, 1, 0, 0, 0);
+		vnic_dev_add_addr(fnic2->vdev, fip_all_enode_macs);
+		vnic_dev_add_addr(fnic2->vdev, lport->hwmac);
+		fnic2->set_vlan = fnic2_set_vlan;
+
+		spin_lock_init(&fnic2->vlans_lock);
+		INIT_WORK(&fnic2->fip_work, fnic2_handle_fip_frame);
+		INIT_LIST_HEAD(&fnic2->fip_frame_queue);
+		INIT_LIST_HEAD(&fnic2->vlan_list);
+		timer_setup(&fnic2->retry_fip_timer, fnic2_handle_fip_timer,
+			    fip_flags);
+		timer_setup(&fnic2->fcs_ka_timer, fnic2_handle_fcs_ka_timer,
+			    fcs_ka_flags);
+		timer_setup(&fnic2->enode_ka_timer, fnic2_handle_enode_ka_timer,
+			    enode_ka_flags);
+		timer_setup(&fnic2->vn_ka_timer, fnic2_handle_vn_ka_timer,
+			    vn_ka_flags);
+	} else {
+		pr_info("firmware uses non-FIP mode\n");
+	}
+	fnic2->state = FNIC2_IN_FC_MODE;
+
+	atomic_set(&fnic2->in_flight, 0);
+
+	/* Enable hardware stripping of vlan header on ingress
+	 * fnic2, rss: default cpu, hash_type, hash_bits, base cpu
+	 * rss enable, tso_ipid_split_en, ig_vlan_strip_en
+	 */
+	fnic2_set_nic_config(fnic2, 0, 0, 0, 0, 0, 0, 1);
+
+	/* Setup notification buffer area */
+	err = fnic2_notify_set(fnic2);
+	if (err) {
+		pr_err("Failed to alloc notify buffer, aborting.\n");
+		goto err_out_free_resources;
+	}
+
+	/* Setup notify timer when using MSI interrupts */
+	if (vnic_dev_get_intr_mode(fnic2->vdev) == VNIC_DEV_INTR_MODE_MSI)
+		timer_setup(&fnic2->notify_timer,
+			    fnic2_notify_timer, notify_flags);
+
+	/* Start local port initiatialization */
+	lport->max_flogi_retries =  fnic2->config.flogi_retries;
+	lport->max_plogi_retries = fnic2->config.plogi_retries;
+
+	lport->service_params =
+	    (FNIC2_FCP_SP_INITIATOR | FNIC2_FCP_SP_RD_XRDY_DIS |
+	    FNIC2_FCP_SP_CONF_CMPL);
+	if (fnic2->config.flags & VFCF_FCP_SEQ_LVL_ERR)
+		lport->service_params |= FNIC2_FCP_SP_RETRY;
+	lport->boot_time = jiffies;
+	lport->e_d_tov = fnic2->config.ed_tov;
+	lport->r_a_tov = fnic2->config.ra_tov;
+	lport->link_supported_speeds = FNIC2_PORTSPEED_10GBIT;
+	lport->wwpn = fnic2->config.port_wwn;
+	lport->wwnn = fnic2->config.node_wwn;
+
+	pr_debug("lport wwpn: %llx\n", lport->wwpn);
+
+	lport->mfs = fnic2->config.maxdatafieldsize;
+
+	timer_setup(&(lport->fabric.retry_timer), fdls_fabric_timer_callback,
+		    fabric_flags);
+	if ((lport->mfs < FNIC2_FCOE_MIN_FRAME_SZ) ||
+	    (lport->mfs > FNIC2_FCOE_MAX_FRAME_SZ))
+		lport->mfs = FNIC2_FCOE_MAX_FRAME_SZ;
+
+	spin_lock_irqsave(&fnic2_list_lock, flags);
+	list_add_tail(&fnic2->list, &fnic2_list);
+	list_for_each(counter_head, &fnic2_list) {
+		fnic2_count++;
+	}
+	fnic2->fnic2_num = fnic2_count;
+	spin_unlock_irqrestore(&fnic2_list_lock, flags);
+
+	INIT_WORK(&fnic2->link_work, fnic2_handle_link);
+	INIT_WORK(&fnic2->frame_work, fnic2_handle_frame);
+
+	INIT_LIST_HEAD(&fnic2->frame_queue);
+	INIT_LIST_HEAD(&fnic2->tx_queue);
+	INIT_LIST_HEAD(&lport->rport_list);
+
+	INIT_LIST_HEAD(&fnic2->lio.sess_list);
+
+	err = fnic2_alloc_tcmd_pool(fnic2);
+	if (err < 0) {
+		pr_err("Failure allocating tcmd pool\n");
+		WARN_ON(1);
+		//goto err_tcmd_pool;
+	}
+	pr_err("initializing fdls\n");
+
+	fnic2_fdls_init(fnic2, (fnic2->config.flags & VFCF_FIP_CAPABLE));
+
+	/* Enable all queues */
+	for (i = 0; i < fnic2->raw_wq_count; i++)
+		vnic_wq_enable(&fnic2->wq[i]);
+	for (i = 0; i < fnic2->rq_count; i++)
+		vnic_rq_enable(&fnic2->rq[i]);
+	for (i = 0; i < fnic2->wq_copy_count; i++)
+		vnic_wq_copy_enable(&fnic2->wq_copy[i]);
+
+	/* allocate RQ buffers and post them to RQ*/
+	for (i = 0; i < fnic2->rq_count; i++) {
+		err = vnic_rq_fill(&fnic2->rq[i], fnic2_alloc_rq_frame);
+		if (err) {
+			pr_err("%s can't alloc frame\n", __func__);
+			goto err_out_free_rq_buf;
+		}
+	}
+
+	vnic_dev_enable(fnic2->vdev);
+
+	err = fnic2_request_intr(fnic2);
+	if (err) {
+		pr_err("Unable to request irq.\n");
+		goto err_out_free_rq_buf;
+	}
+
+	for (i = 0; i < fnic2->intr_count; i++)
+		vnic_intr_unmask(&fnic2->intr[i]);
+
+	fnic2_notify_timer_start(fnic2);
+
+	return 0;
+
+err_out_free_rq_buf:
+	for (i = 0; i < fnic2->rq_count; i++)
+		vnic_rq_clean(&fnic2->rq[i], fnic2_free_rq_buf);
+	vnic_dev_notify_unset(fnic2->vdev);
+err_out_free_resources:
+	fnic2_free_vnic_resources(fnic2);
+err_out_clear_intr:
+	fnic2_clear_intr_mode(fnic2);
+err_out_dev_close:
+	vnic_dev_close(fnic2->vdev);
+err_out_vnic_unregister:
+	vnic_dev_unregister(fnic2->vdev);
+err_out_iounmap:
+	fnic2_iounmap(fnic2);
+err_out_release_regions:
+	pci_release_regions(pdev);
+err_out_disable_device:
+	pci_disable_device(pdev);
+err_out_free_hba:
+	return err;
+}
+
+static void fnic2_remove(struct pci_dev *pdev)
+{
+	struct fnic2 *fnic2 = pci_get_drvdata(pdev);
+	unsigned long flags;
+
+	/*
+	 * Mark state so that the workqueue thread stops forwarding
+	 * received frames and link events to the local port. ISR and
+	 * other threads that can queue work items will also stop
+	 * creating work items on the fnic2 workqueue
+	 */
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	fnic2->stop_rx_link_events = 1;
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	if (vnic_dev_get_intr_mode(fnic2->vdev) == VNIC_DEV_INTR_MODE_MSI)
+		del_timer_sync(&fnic2->notify_timer);
+
+	/*
+	 * Flush the fnic2 event queue. After this call, there should
+	 * be no event queued for this fnic2 device in the workqueue
+	 */
+	flush_workqueue(fnic2_event_queue);
+	flush_workqueue(fip_event_queue);
+	flush_workqueue(fnic2_tcmd_wq);
+	list_free_buffer(&fnic2->frame_queue);
+	list_free_buffer(&fnic2->tx_queue);
+	list_free_buffer(&fnic2->lport.rport_list);
+
+	if (fnic2->config.flags & VFCF_FIP_CAPABLE) {
+		del_timer_sync(&fnic2->retry_fip_timer);
+		del_timer_sync(&fnic2->fcs_ka_timer);
+		del_timer_sync(&fnic2->enode_ka_timer);
+		del_timer_sync(&fnic2->vn_ka_timer);
+		list_free_buffer(&fnic2->fip_frame_queue);
+		fnic2_fcoe_reset_vlans(fnic2);
+		flush_workqueue(fip_event_queue);
+	}
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	fnic2->in_remove = 1;
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	fnic2_cleanup(fnic2);
+	fnic2_fdls_cleanup(fnic2);
+
+	spin_lock_irqsave(&fnic2_list_lock, flags);
+	list_del(&fnic2->list);
+	spin_unlock_irqrestore(&fnic2_list_lock, flags);
+
+	vnic_dev_notify_unset(fnic2->vdev);
+	fnic2_free_intr(fnic2);
+	fnic2_free_vnic_resources(fnic2);
+	fnic2_clear_intr_mode(fnic2);
+	vnic_dev_close(fnic2->vdev);
+	vnic_dev_unregister(fnic2->vdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static struct pci_driver fnic2_driver = {
+	.name = DRV_NAME,
+	.id_table = fnic2_id_table,
+	.probe = fnic2_probe,
+	.remove = fnic2_remove,
+};
+
+static int __init fnic2_init_module(void)
+{
+	int err = 0;
+
+	pr_info("%s, ver %s\n", DRV_DESCRIPTION, DRV_VERSION);
+
+	fnic2_event_queue = create_singlethread_workqueue("fnic2_event_wq");
+	if (!fnic2_event_queue) {
+		pr_err("fnic2 work queue create failed\n");
+		err = -ENOMEM;
+		goto err_return;
+	}
+
+	fip_event_queue = create_singlethread_workqueue("fip_event_wq");
+	if (!fip_event_queue) {
+		pr_err("fip work queue create failed\n");
+		err = -ENOMEM;
+		goto err_fnic2_wq;
+	}
+
+	fnic2_tcmd_wq = alloc_workqueue("fnic2_tcmd", 0, 0);
+	if (!fnic2_tcmd_wq) {
+		err = -ENOMEM;
+		goto err_tcmd_wq;
+	}
+
+	fnic2_lio_init();
+
+	/* register the driver with PCI system */
+	err = pci_register_driver(&fnic2_driver);
+	if (err < 0) {
+		pr_err("pci register error\n");
+		goto err_pci_reg;
+	}
+
+	return err;
+
+err_pci_reg:
+	destroy_workqueue(fnic2_tcmd_wq);
+err_tcmd_wq:
+	destroy_workqueue(fip_event_queue);
+err_fnic2_wq:
+	destroy_workqueue(fnic2_event_queue);
+err_return:
+	return err;
+}
+
+static void __exit fnic2_cleanup_module(void)
+{
+	fnic2_lio_cleanup();
+	pci_unregister_driver(&fnic2_driver);
+	destroy_workqueue(fnic2_event_queue);
+	destroy_workqueue(fip_event_queue);
+	destroy_workqueue(fnic2_tcmd_wq);
+}
+module_init(fnic2_init_module);
+module_exit(fnic2_cleanup_module);
-- 
1.8.3.1
