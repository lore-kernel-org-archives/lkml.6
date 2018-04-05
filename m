Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx49zyXKIA3sOfsIFCR+DGR/XibX9HHwW4WIaG3hm2lPkPQ1GBXaDU48O8APmr4XSOup0vU83
ARC-Seal: i=1; a=rsa-sha256; t=1522963101; cv=none;
        d=google.com; s=arc-20160816;
        b=YmLaHxNV/34BA4TqYnnFE6WyCxeq8/Pmez/DKsCggkVpNrXSke1+0xr1Nbhx59L1aR
         0/heNklVaAS0xM3X1q5D/TCJLMge3lflWPwjWRlQwq/ps3Ddf8Qk4muf37ucfL3xzh2u
         U2mXlKyiS7fQzi5zR2xv7FNaEaM6ChN9R9BoNliASw4PICFbqdfscPk0jFCD8UgAlTT2
         X7GhtmKEMhLXFFSESozmYuVjGglR9KuiJaIRLqKIbVFxXcPM50DXtlEw+aBb2fjFSfTd
         flJwrKLPOAzPhoD7MzhevsEnHyWG0PvI3P7ADz+3vgzgNwXfhFPntLCIfv/zTq8/HO3F
         4wCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=UTar1gJ+dMisblNftFk26iq/xw1s5D3BSh7CdTEy30s=;
        b=XeKyL/8QLzgYAedopJ9Umo+G2WIZNw0INbXn1wj+8vunfgjf7BsxhDlJWAZS3yryqB
         1ggHLDF4o6deU55PjXebPe6SHKOXJe4uAt517OeX6S6DFx43nwzxVT9P7+ZAhJyrgIhY
         dnt8XEsPs+yqhg+HcIjIwDw5zqsUq3z4wFERBbR6bt3/lIHhaRytwXQK9CwganI0hYes
         +CCCxXEVnclGMtoBigyx0f703WUYLMmAqXwkcNyH8vc5WTHeYk/Q+K4tvXK1FLs1eRrF
         T2xc4t+CrazrtIZ9ryIxG/43gGw8a9rM+CUJ0ZTNsexNQydg7SO7BfClZ+jE1nuh6qpM
         H7dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=YOibU2PD;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.79 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=YOibU2PD;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.79 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="375237779"
Date: Thu, 5 Apr 2018 14:21:05 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 06/10] staging: fnic2 add main frame processing
Message-ID: <20180405212105.GG12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942556366104880?=
X-GMAIL-MSGID: =?utf-8?q?1596942556366104880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain logic for handling Fibre Channel frames
and communication with firmware and LIO.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/fcpio.h     |  347 ++++++++++
 drivers/staging/fnic2/src/fnic2_cmd.c | 1164 +++++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/fnic2_io.h  |   32 +
 3 files changed, 1543 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/fcpio.h
 create mode 100644 drivers/staging/fnic2/src/fnic2_cmd.c
 create mode 100644 drivers/staging/fnic2/src/fnic2_io.h

diff --git a/drivers/staging/fnic2/src/fcpio.h b/drivers/staging/fnic2/src/fcpio.h
new file mode 100644
index 0000000..7c8b879
--- /dev/null
+++ b/drivers/staging/fnic2/src/fcpio.h
@@ -0,0 +1,347 @@
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
+#ifndef _FCPIO_H_
+#define _FCPIO_H_
+
+#include <linux/if_ether.h>
+
+/*
+ * This header file includes all of the data structures used for
+ * communication by the host driver to the fcp firmware.
+ */
+
+/*
+ * Exchange and sequence id space allocated to the host driver
+ */
+#define FCPIO_HOST_EXCH_RANGE_START         0x1000
+
+/*
+ * Command entry type
+ */
+enum fcpio_type {
+	/*
+	 * Initiator request types
+	 */
+	FCPIO_ICMND_16 = 0x1,
+	FCPIO_ICMND_32,
+	FCPIO_ICMND_CMPL,
+	FCPIO_ITMF,
+	FCPIO_ITMF_CMPL,
+
+	/*
+	 * Target request types
+	 */
+	FCPIO_TCMD_SEND_DATA = 0x11,	/* Send RD DATA, Send Resp, Free Xchg */
+	FCPIO_TCMD_RECV_DATA,	/* Send Xfer Rdy, Xfer recvd data to SGL */
+	FCPIO_TCMD_FREE_CMD,	/* Free the resources of cmd with given tag */
+	FCPIO_TCMD_SEND_RESP,	/* Send Resp for Cmd, Free Xchg */
+	FCPIO_TCMD_ABORT_CMD,
+	FCPIO_TCMD_TASK_MGMT,
+
+	/*
+	 * Misc request types
+	 */
+	FCPIO_ACK = 0x20,
+	FCPIO_RESET,
+	FCPIO_RESET_CMPL,
+	FCPIO_FLOGI_REG,
+	FCPIO_FLOGI_REG_CMPL,
+	FCPIO_ECHO,
+	FCPIO_ECHO_CMPL,
+	FCPIO_LUNMAP_CHNG,
+	FCPIO_LUNMAP_REQ,
+	FCPIO_LUNMAP_REQ_CMPL,
+	FCPIO_FLOGI_FIP_REG,
+	FCPIO_FLOGI_FIP_REG_CMPL,
+};
+
+/*
+ * Header status codes from the firmware
+ */
+enum fcpio_status {
+	FCPIO_SUCCESS = 0,              /* request was successful */
+
+	/*
+	 * If a request to the firmware is rejected, the original request
+	 * header will be returned with the status set to one of the following:
+	 */
+	FCPIO_INVALID_HEADER,    /* header contains invalid data */
+	FCPIO_OUT_OF_RESOURCE,   /* out of resources to complete request */
+	FCPIO_INVALID_PARAM,     /* some parameter in request is invalid */
+	FCPIO_REQ_NOT_SUPPORTED, /* request type is not supported */
+	FCPIO_IO_NOT_FOUND,      /* requested I/O was not found */
+
+	/*
+	 * Once a request is processed, the firmware will usually return
+	 * a cmpl message type.  In cases where errors occurred,
+	 * the header status field would be filled in with one of the following:
+	 */
+	FCPIO_ABORTED = 0x41,     /* request was aborted */
+	FCPIO_TIMEOUT,            /* request was timed out */
+	FCPIO_SGL_INVALID,        /* request was aborted due to sgl error */
+	FCPIO_MSS_INVALID,        /* request was aborted due to mss error */
+	FCPIO_DATA_CNT_MISMATCH,  /* recv/sent more/less data than exp. */
+	FCPIO_FW_ERR,             /* request was terminated due to fw error */
+	FCPIO_ITMF_REJECTED,      /* itmf req was rejected by remote node */
+	FCPIO_ITMF_FAILED,        /* itmf req was failed by remote node */
+	FCPIO_ITMF_INCORRECT_LUN, /* itmf req targeted incorrect LUN */
+	FCPIO_CMND_REJECTED,      /* request was invalid and rejected */
+	FCPIO_NO_PATH_AVAIL,      /* no paths to the lun was available */
+	FCPIO_PATH_FAILED,        /* i/o sent to current path failed */
+	FCPIO_LUNMAP_CHNG_PEND,   /* i/o rejected due to lunmap change */
+};
+
+/*
+ * The header for an fcpio request, whether from the firmware or from the
+ * host driver
+ */
+struct fcpio_header {
+	uint8_t            type;	/* enum fcpio_type */
+	uint8_t            status;	/* header status entry */
+	uint16_t           _resvd;	/* reserved */
+	uint32_t	   fcpio_tag;	/* header tag */
+};
+
+static inline void fcpio_header_enc(struct fcpio_header *hdr,
+				    uint8_t type, uint8_t status,
+				    uint32_t tag)
+{
+	hdr->type = type;
+	hdr->status = status;
+	hdr->_resvd = 0;
+	hdr->fcpio_tag = tag;
+}
+
+static inline void fcpio_header_dec(struct fcpio_header *hdr,
+				    uint8_t *type, uint8_t *status,
+				    uint32_t *tag)
+{
+	*type = hdr->type;
+	*status = hdr->status;
+	*tag = hdr->fcpio_tag;
+}
+
+#define CDB_16      16
+#define CDB_32      32
+#define LUN_ADDRESS 8
+
+/*
+ * fcpio_tcmd_data: host -> firmware request
+ * used to request the firmware to send data (rd) or receive data(wr)
+ * in target mode
+ * Used by: FCPIO_TCMD_SEND_DATA & FCPIO_TCMD_RECV_DATA
+ */
+
+struct fcpio_tcmd_data {
+	uint8_t		d_id[3];
+	uint8_t		rsvd;
+	uint8_t		s_id[3];
+	uint8_t		rsvd1;
+	uint16_t	ox_id;
+	uint8_t		rsvd2[2];
+	uint32_t	data_len;
+	uint64_t	sgl_pa;
+	uint16_t	sgl_cnt;
+	uint8_t		send_resp;	/* change it to common flags? */
+	uint8_t		rsp_iu_flags;
+	uint32_t	resid;
+	uint8_t		rsvd3[2];
+	u_int8_t        type;		/* command type read/Write */
+	u_int8_t        rsvd4;		/* reserved */
+	u_int32_t       rel_offset;	/* data sequence relative offset */
+	u_int16_t       npiv_id;	/* FC vNIC only: npiv id of request */
+	u_int16_t       mss;		/* FC vNIC only: max burst */
+	u_int32_t       r_a_tov;	/* FC vNIC only: R_A_TOV in msec */
+	u_int32_t       e_d_tov;
+} __attribute__((__packed__));
+
+/*
+ * fcpio_tcmd_fw_resp: firmware -> host response
+ * used by firmware to send response for a tcmd request
+ * Used as a response for:
+ * FCPIO_TCMD_SEND_DATA
+ * FCPIO_TCMD_RECV_DATA
+ * FCPIO_TCMD_FREE_CMD
+ *
+ */
+struct fcpio_tcmd_fw_rsp {
+	uint8_t		error_code;
+	uint8_t		rsvd;
+	uint16_t	rx_id;
+};
+
+/*
+ * fcpio_tabort: host -> firmware request
+ *
+ * used by the host to request the firmware to abort a target request that was
+ * received by the firmware
+ */
+struct fcpio_tabort {
+	uint32_t   cmd_tag;	/* tag of the target request */
+};
+
+enum fcpio_flogi_reg_format_type {
+	FCPIO_FLOGI_REG_DEF_DEST = 0,	/* Use the oui | s_id mac format */
+	FCPIO_FLOGI_REG_GW_DEST,	/* Use the fixed gateway mac */
+};
+
+/*
+ * fcpio_flogi_reg: host -> firmware request
+ *
+ * fc vnic only
+ * used by the host to notify the firmware of the lif's s_id
+ * and destination mac address format
+ */
+struct fcpio_flogi_reg {
+	uint8_t format;
+	uint8_t s_id[3];		/* FC vNIC only: Source S_ID */
+	uint8_t gateway_mac[ETH_ALEN];	/* Destination gateway mac */
+	uint16_t _resvd;
+	uint32_t r_a_tov;		/* R_A_TOV in msec */
+	uint32_t e_d_tov;		/* E_D_TOV in msec */
+};
+
+/*
+ * fcpio_flogi_fip_reg: host -> firmware request
+ *
+ * fc vnic only
+ * used by the host to notify the firmware of the lif's s_id
+ * and destination mac address format
+ */
+struct fcpio_flogi_fip_reg {
+	uint8_t    _resvd0;
+	uint8_t     s_id[3];		/* FC vNIC only: Source S_ID */
+	uint8_t     fcf_mac[ETH_ALEN];	/* FCF Target destination mac */
+	uint16_t   _resvd1;
+	uint32_t   r_a_tov;		/* R_A_TOV in msec */
+	uint32_t   e_d_tov;		/* E_D_TOV in msec */
+	uint8_t    ha_mac[ETH_ALEN];	/* Host adapter source mac */
+	uint16_t   _resvd2;
+};
+
+/*
+ * Basic structure for all fcpio structures that are sent from the host to the
+ * firmware.  They are 128 bytes per structure.
+ */
+#define FCPIO_HOST_REQ_LEN      128     /* expected length of host requests */
+
+struct fcpio_host_req {
+	struct fcpio_header hdr;
+
+	union {
+		/*
+		 * Defines space needed for request
+		 */
+		uint8_t buf[FCPIO_HOST_REQ_LEN - sizeof(struct fcpio_header)];
+
+		/*
+		 * Target host requests
+		 */
+		struct fcpio_tabort		tabort;
+		struct fcpio_tcmd_data		tdata;
+
+		/*
+		 * Misc requests
+		 */
+		struct fcpio_flogi_reg		flogi_reg;
+		struct fcpio_flogi_fip_reg	flogi_fip_reg;
+	} u;
+};
+
+/*
+ * Task Management request
+ */
+enum tmr_type {
+	FCPIO_TTMF_ABT_TASK             = 0x01,	/* abort task */
+	FCPIO_TTMF_ABT_TASK_SET         = 0x02,	/* abort task set */
+	FCPIO_TTMF_CLR_TASK_SET         = 0x04,	/* clear task set */
+	FCPIO_TTMF_LUN_RESET            = 0x10,	/* logical unit reset task mgmt */
+	FCPIO_TTMF_CLR_ACA		= 0x40	/* Clear ACA condition */
+};
+
+/*
+ * fcpio_ack: firmware -> host response
+ *
+ * used by firmware to notify the host of the last work request received
+ */
+struct fcpio_ack {
+	uint16_t  request_out;	/* last host entry received */
+	uint16_t  _resvd;
+};
+
+/*
+ * fcpio_reset_cmpl: firmware -> host response
+ *
+ * use by firmware to respond to the host's reset request
+ */
+struct fcpio_reset_cmpl {
+	uint16_t   vnic_id;
+};
+
+/*
+ * Basic structure for all fcpio structures that are sent from the firmware to
+ * the host.  They are 64 bytes per structure.
+ */
+#define FCPIO_FW_REQ_LEN        64      /* expected length of fw requests */
+struct fcpio_fw_req {
+	struct fcpio_header hdr;
+
+	union {
+		/*
+		 * Defines space needed for request
+		 */
+		uint8_t buf[FCPIO_FW_REQ_LEN - sizeof(struct fcpio_header)];
+
+		/*
+		 * Target firmware responses
+		 */
+		struct fcpio_tcmd_fw_rsp	trsp;
+
+		/*
+		 * Firmware response to work received
+		 */
+		struct fcpio_ack		ack;
+
+		/*
+		 * Misc requests
+		 */
+	} u;
+};
+
+static inline void fcpio_color_dec(struct fcpio_fw_req *fw_req, uint8_t *color)
+{
+	uint8_t *c = ((uint8_t *) fw_req) + sizeof(struct fcpio_fw_req) - 1;
+
+	*color = *c >> 7;
+
+	/*
+	 * Make sure color bit is read from desc *before* other fields
+	 * are read from desc.  Hardware guarantees color bit is last
+	 * bit (byte) written.  Adding the rmb() prevents the compiler
+	 * and/or CPU from reordering the reads which would potentially
+	 * result in reading stale values.
+	 */
+
+	rmb();
+
+}
+
+#define FNIC2_SGL_SZ	(256 * 16)
+#define FNIC2_SGL_ALIGN	(16)
+
+#endif /* _FCPIO_H_ */
diff --git a/drivers/staging/fnic2/src/fnic2_cmd.c b/drivers/staging/fnic2/src/fnic2_cmd.c
new file mode 100644
index 0000000..0315825
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_cmd.c
@@ -0,0 +1,1164 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2017 Cisco Systems, Inc. All rights reserved
+ */
+#include <linux/workqueue.h>
+#include "fnic2.h"
+#include "fcpio.h"
+#include "fnic2_io.h"
+#include "fdls_fc.h"
+#include <asm/unaligned.h>
+#include <target/target_core_base.h>
+#include <target/target_core_fabric.h>
+#include <linux/highmem.h>
+
+static void fnic2_format_wwnn(char *buf, int len, uint64_t wwn);
+static struct fcpio_host_req *fnic2_host_req_alloc_init(struct fnic2_cmd *tcmd, int req_type);
+static void fnic2_process_fcp_cmd(struct work_struct *work);
+static void fnic2_unmap_free_sgl(struct fnic2 *fnic2, struct fnic2_cmd *tcmd);
+static void tcmd_process_abts_req(struct fnic2_cmd *abort_tcmd);
+static void fnic2_send_tm(struct fnic2_cmd *tcmd);
+static void fnic2_process_tcmd_timeout(struct work_struct *work);
+static void fnic2_recv_sess_timer_intr(struct timer_list *timer);
+
+extern void fdls_construct_logo_req(struct fnic2_lport *lport, struct fc_hdr *fchdr, struct fnic2_sess *sess);
+extern void fdls_delete_rport(struct fnic2_lport *lport, struct fnic2_rport *rport);
+
+extern struct list_head fnic2_list;
+
+/* Frame Initialization */
+
+/* FCP RESP */
+struct fc_fcp_rsp fnic2_fcp_rsp = {
+	.fchdr = {.r_ctl = 0x07, .type = 0x08,
+		.f_ctl = {FNIC2_FCP_RSP_FCTL, 0x00, 0x00},
+		.seq_id = 0x02}
+};
+
+#define BUF_ALIGN_16(_addr)	(((uint64_t)_addr + 16 - 1) & ~0x0F)
+
+static int total_cmds;
+
+static struct fnic2_cmd *fnic2_get_tcmd_from_pool(struct fnic2 *fnic2)
+{
+	struct fnic2_cmd *tcmd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic2->free_list_lock, flags);
+
+	tcmd = list_first_entry_or_null(&fnic2->tcmd_list_free,
+		struct fnic2_cmd, free_list);
+	if (tcmd) {
+		list_del(&tcmd->free_list);
+		fnic2->freecmds--;
+		pr_debug("Got tcmd from pool tag %x freecmds %d fnic2->fnic2_num %d\n", tcmd->cmd_tag, fnic2->freecmds, fnic2->fnic2_num);
+		total_cmds++;
+
+		tcmd->abort_tag = 0xFFFFFFFF;
+	}
+
+	spin_unlock_irqrestore(&fnic2->free_list_lock, flags);
+
+	return tcmd;
+}
+
+/*
+ * fnic2_free_tcmd - free tcmd memory and add to fnic2 free list
+ *
+ * @tcmd - tcmd to be freed
+ *
+ * It will delete the I/O timer and maintain the state of
+ * the spinlock.
+ */
+void fnic2_free_tcmd(struct fnic2_cmd *tcmd)
+{
+	uint32_t tag;
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	unsigned long flags;
+	unsigned long flags2;
+
+	/* Delete I/O timer on tcmd if it is active */
+	if ((try_to_del_timer_sync(&tcmd->io_timer)) < 0)
+		pr_err("Could not delete timer on tcmd tag %x\n", tcmd->cmd_tag);
+
+	spin_lock_irqsave(&tcmd->lock, flags2);
+
+	pr_err("freeing %pK tag %x\n", tcmd, tcmd->cmd_tag);
+
+	if (tcmd->rx_frame)
+		kfree(tcmd->rx_frame);
+
+	if (tcmd->sgcnt)
+		fnic2_unmap_free_sgl(fnic2, tcmd);
+
+	if (tcmd->host_req) {
+		kfree(tcmd->host_req);
+		tcmd->host_req = NULL;
+	}
+
+	tag = tcmd->cmd_tag;
+
+	/* Don't erase lock or timer */
+	memset(tcmd, 0, sizeof(struct fnic2_cmd) - sizeof(spinlock_t) - sizeof(struct timer_list));
+
+	tcmd->cmd_tag = tag;
+	tcmd->fnic2 = fnic2;
+
+	spin_unlock_irqrestore(&tcmd->lock, flags2);
+
+	spin_lock_irqsave(&fnic2->free_list_lock, flags);
+	list_add_tail(&tcmd->free_list, &fnic2->tcmd_list_free);
+	fnic2->freecmds++;
+	pr_debug("fnic2 num: %d freecmds %d tag %x rx_frame %pK\n", fnic2->fnic2_num, fnic2->freecmds, tcmd->cmd_tag, tcmd->rx_frame);
+	spin_unlock_irqrestore(&fnic2->free_list_lock, flags);
+
+}
+
+/*
+ * Send error or task management response.
+ * Always frees the cmd and associated state.
+ */
+static void fnic2_send_tmr_resp_and_free(struct fnic2_cmd *tcmd,
+					 int code)
+{
+	fnic2_send_tmr_resp(tcmd, SAM_STAT_GOOD, code);
+	fnic2_free_tcmd(tcmd);
+
+}
+
+void fnic2_fcp_recv(struct fnic2 *fnic2, uint8_t *fp, int frame_len)
+{
+	struct fc_hdr *fchdr = (struct fc_hdr *)fp;
+	struct fnic2_cmd *tcmd;
+	int cpu;
+	bool found;
+	struct fnic2_cmd *tcmd_idx;
+	int tag_idx;
+	struct fc_fcp_cmnd *fc_cmnd;
+
+	/* Get a tcmd from free pool */
+	tcmd = fnic2_get_tcmd_from_pool(fnic2);
+	if (!tcmd) {
+		pr_err("No TCMD Available\n");
+	        // TBD return BUSY
+		kfree(fp);
+		return;
+	}
+
+	/* Initial settings of the cmd */
+	tcmd->ox_id = ntohs(fchdr->ox_id);
+	tcmd->s_id = ntoh24(fchdr->s_id);
+	tcmd->rx_frame = fp;
+	tcmd->frame_len = frame_len;
+
+	/* Setup tcmd timeout */
+	tcmd->io_timer.expires = jiffies + JIFFIES_PER_MINUTE;
+	tcmd->io_timer.function = (void *)fnic2_recv_tcmd_timeout_intr;
+
+	fchdr = (struct fc_hdr *)tcmd->rx_frame;
+
+	fc_cmnd = (struct fc_fcp_cmnd *)fchdr;
+
+	/* Only start the I/O timer if this tcmd is representing a R/W */
+	if (IS_SCSI_READ_CMD(fc_cmnd) || IS_SCSI_WRITE_CMD(fc_cmnd))
+		add_timer(&tcmd->io_timer);
+
+	/* Queue */
+	cpu = get_cpu_to_queue(tcmd->cmd_tag);
+
+	if (fchdr->r_ctl == FNIC2_FC_R_CTL_ABTS) {
+
+		// BGC TEST
+		// fnic2_free_tcmd(tcmd);
+		// return;
+
+		tcmd->ox_id |= ABTS_MASK;
+		tcmd_idx = &fnic2->tcmd_pool[0];
+		found = 0;
+		for (tag_idx = 0; tag_idx < FNIC2_MAX_TCMDS; tag_idx++, tcmd_idx++) {
+			if ((ntohs(fchdr->ox_id) == tcmd_idx->ox_id) &&
+			   (tcmd_idx->s_id == ntoh24(fchdr->s_id))) {
+				cpu = get_cpu_to_queue(tcmd_idx->cmd_tag);
+				found = 1;
+				break;
+			}
+		}
+		if (!found) {
+			pr_debug("Did not find I/O ox_id %x to ABORT\n", tcmd->ox_id);
+			fdls_send_ba_acc(&fnic2->lport, fchdr);
+			fnic2_free_tcmd(tcmd);
+			return;
+		}
+	}
+
+	pr_err("New cmd %pK tag %x\n", tcmd, tcmd->cmd_tag);
+
+	INIT_WORK(&tcmd->work, fnic2_process_fcp_cmd);
+	queue_work_on(cpu, fnic2_tcmd_wq, &tcmd->work);
+}
+
+static void fnic2_process_fcp_cmd(struct work_struct *work)
+{
+	struct fnic2_cmd *tcmd =
+		container_of(work, struct fnic2_cmd, work);
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	struct fc_fcp_cmnd *fcp_cmd_req;
+	struct fc_hdr *fchdr;
+	struct fnic2_sess *sess;
+	uint32_t s_id;
+	int addl_len;
+	int task_attr = 0;
+	int flags = 0;
+	int ret;
+
+	fchdr = (struct fc_hdr *)tcmd->rx_frame;
+
+	if (fchdr->r_ctl == FNIC2_FC_R_CTL_ABTS) {
+		tcmd_process_abts_req(tcmd);
+		return;
+	}
+
+	/* Find the session that the request belongs to */
+	s_id = ntoh24(fchdr->s_id);
+	sess = fnic2_find_sess_s_id(fnic2, s_id);
+	if (!sess) {
+		/* We shouldn't be here */
+		pr_err("%s Could not find the login for: %x\n",
+			__func__, s_id);
+		fdls_send_logout(&fnic2->lport, fchdr);
+		//WARN_ON(!sess);
+		goto err;
+	}
+
+	if ((try_to_del_timer_sync(&sess->sess_timer)) < 0)
+		pr_err("%s failed to delete sess %pK timer\n", __func__, sess);
+
+	fcp_cmd_req = (struct fc_fcp_cmnd *)fchdr;
+	addl_len = FC_CMND_ADDL_CDB_LEN(fcp_cmd_req->add_cdblen_flags);
+	if (addl_len > 0) {
+		pr_err("Addl. len CDB not supported ini: %x, ox_id: %x\n",
+			s_id, fchdr->ox_id);
+		goto err;
+	}
+
+	tcmd->sess = sess;
+	tcmd->data_len_req = ntohl(fcp_cmd_req->dl);
+	tcmd->se_cmd.tag = tcmd->cmd_tag;
+
+	/*
+	 * Check for FCP task management flags
+	 */
+	if (fcp_cmd_req->tm_flags) {
+	    fnic2_send_tm(tcmd);
+	    return;
+	}
+
+	if (ntohl(fcp_cmd_req->dl) > MAX_DATA_LENGTH) {
+		pr_err("DEBUG Unsupported length: %x\n", ntohl(fcp_cmd_req->dl));
+		goto err;
+	}
+
+	/* Initialize tcmd based on the request received */
+	switch (fcp_cmd_req->add_cdblen_flags &
+		(FC_CMND_REQ_RD | FC_CMND_REQ_WR)) {
+		case FC_CMND_REQ_NONE:
+			pr_debug("DEBUG neither read nor write recvd! ln: %d\n", __LINE__);
+		case FC_CMND_REQ_RD:
+			tcmd->data_dir = DMA_FROM_DEVICE;
+		break;
+		case FC_CMND_REQ_WR:
+			tcmd->data_dir = DMA_TO_DEVICE;
+			tcmd->flags |= FNIC2_TCMD_WRITECMD;
+		break;
+		default:
+			pr_debug("DEBUG Bidirectional cmd recvd ln: %d\n", __LINE__);
+			/* Bi-directional not supported */
+			goto err;
+		break;
+	}
+
+	switch (fcp_cmd_req->pri_ta & FC_CMND_TASK_ATTR) {
+		case FC_TA_SIMPLE_TAG:
+			task_attr = TCM_SIMPLE_TAG;
+		break;
+		case FC_TA_HEAD_OF_QUEUE:
+			task_attr = TCM_HEAD_TAG;
+		break;
+		case FC_TA_ORDERED:
+			task_attr =  TCM_ORDERED_TAG;
+		break;
+		case FC_TA_ACA:
+			task_attr = TCM_ACA_TAG;
+		break;
+		default:
+		break;
+	}
+
+	flags = TARGET_SCF_ACK_KREF;
+
+	pr_err("New Cmd tag: %x, is_write: %d, ox_id: %x, op %x len: %d\n",
+		tcmd->cmd_tag, tcmd->flags & FNIC2_TCMD_WRITECMD, tcmd->ox_id, fcp_cmd_req->cdb[0],
+		tcmd->data_len_req);
+
+	/* Submit */
+	ret = target_submit_cmd(&tcmd->se_cmd, sess->se_sess, fcp_cmd_req->cdb,
+		tcmd->sense_buf, scsilun_to_int(&fcp_cmd_req->fcp_lun),
+		tcmd->data_len_req, task_attr, tcmd->data_dir, flags);
+
+	if (ret) {
+		pr_err("target_submit_cmd returned failure %d\n",
+			ret);
+		goto err;
+	}
+
+	return;
+err:
+	pr_err("ERROR fn: %s, ln: %d\n", __func__, __LINE__);
+	fnic2_free_tcmd(tcmd);
+	return;
+}
+
+/*
+ * tcmd_process_abts_req
+ * An ABTS request was received
+ * Lookup the tcmd in the LIO queue and start the abort process in fw
+ */
+static void tcmd_process_abts_req(struct fnic2_cmd *abort_tcmd)
+{
+	struct fc_hdr *fchdr = (struct fc_hdr *)abort_tcmd->rx_frame;
+	struct fnic2 *fnic2 = abort_tcmd->fnic2;
+	struct fnic2_sess *sess;
+	struct se_cmd *se_cmd;
+	struct fnic2_cmd *tcmd_loop;
+	uint32_t s_id;
+	unsigned long flags;
+	unsigned long abts_flags;
+	struct fc_fcp_cmnd *fcp_cmd_req;
+
+	pr_err("processing ABTS s_id %x ox_id %x\n",
+		ntoh24(fchdr->s_id), ntohs(fchdr->ox_id));
+
+	s_id = ntoh24(fchdr->s_id);
+	sess = fnic2_find_sess_s_id(fnic2, s_id);
+	if (!sess) {
+		/* We shouldn't be here */
+		WARN_ON(!sess);
+		goto abts_error;
+	}
+	pr_err("processing ABTS found session %pK\n",
+		sess);
+
+	if ((try_to_del_timer_sync(&sess->sess_timer)) < 0)
+		pr_err("%s failed to delete sess %pK timer\n", __func__, sess);
+
+	spin_lock_irqsave(&sess->se_sess->sess_cmd_lock, flags);
+
+	list_for_each_entry(se_cmd, &sess->se_sess->sess_cmd_list, se_cmd_list) {
+		tcmd_loop = container_of(se_cmd, struct fnic2_cmd, se_cmd);
+		pr_err("scan tcmd ox_id %x\n", tcmd_loop->ox_id);
+		if (tcmd_loop->ox_id == ntohs(fchdr->ox_id)) {
+
+			fcp_cmd_req = (struct fc_fcp_cmnd *)tcmd_loop->rx_frame;
+			pr_err("ABORTING original tag: %x abort_tag %x\n",
+				tcmd_loop->cmd_tag, abort_tcmd->cmd_tag);
+			pr_err("se_cmd %pK se_sess %pK lun %llu\n",
+				&tcmd_loop->se_cmd, sess->se_sess,
+				(unsigned long long)scsilun_to_int(&fcp_cmd_req->fcp_lun));
+
+			spin_unlock_irqrestore(&sess->se_sess->sess_cmd_lock, flags);
+
+			/* Delete I/O timer on original command if active */
+			if ((try_to_del_timer_sync(&tcmd_loop->io_timer)) < 0)
+				pr_err("Could not delete timer on tcmd tag %x\n", tcmd_loop->cmd_tag);
+
+			abort_tcmd->flags |= FNIC2_TCMD_IS_ABTS;
+
+			spin_lock_irqsave(&tcmd_loop->lock, abts_flags);
+
+			if (tcmd_loop->flags & FNIC2_TCMD_ABORTED) {
+				pr_err("tcmd %x already being aborted\n", tcmd_loop->abort_tag);
+				spin_unlock_irqrestore(&tcmd_loop->lock, abts_flags);
+				goto abts_error;
+			}
+
+			tcmd_loop->flags |= FNIC2_TCMD_ABORTED;
+
+			tcmd_loop->abort_tag = abort_tcmd->cmd_tag;
+			abort_tcmd->killed_tcmd = tcmd_loop;
+			tcmd_loop->abort_tcmd = abort_tcmd;
+
+			spin_unlock_irqrestore(&tcmd_loop->lock, abts_flags);
+
+			fnic2_send_abort_to_fw(tcmd_loop);
+
+			return;
+		}
+	}
+
+	spin_unlock_irqrestore(&sess->se_sess->sess_cmd_lock, flags);
+	pr_err("ABTS for ox_id %x NOT FOUND\n",
+		ntohs(fchdr->ox_id));
+
+abts_error:
+
+	fdls_send_ba_acc(&fnic2->lport, fchdr);
+	fnic2_free_tcmd(abort_tcmd);
+
+	return;
+}
+
+void fnic2_send_abort_to_fw(struct fnic2_cmd *tcmd)
+{
+	struct fnic2 *fnic2 = tcmd->fnic2;
+
+	unsigned long flags;
+	struct fcpio_host_req *host_req;
+	struct fcpio_host_req *desc;
+	struct vnic_wq_copy *wq;
+
+	pr_err("tcmd %pK send abort to fw\n", tcmd);
+	pr_err("cmd_tag %x abort_tag %x\n", tcmd->cmd_tag, tcmd->abort_tag);
+
+	/* Fill the structure to send it to fw */
+	host_req = kzalloc(sizeof(struct fcpio_host_req), GFP_KERNEL);
+	WARN_ON(host_req == NULL);
+	host_req->hdr.type = FCPIO_TCMD_ABORT_CMD;
+	host_req->hdr.fcpio_tag = tcmd->abort_tag;
+	host_req->u.tabort.cmd_tag = tcmd->cmd_tag;
+
+	spin_lock_irqsave(&fnic2->wq_copy_lock[0], flags);
+	/* Use the Copy WQ to send it to FW */
+	wq = &fnic2->wq_copy[0];
+
+	if (vnic_wq_copy_desc_avail(wq) <= fnic2->wq_copy_desc_low[0])
+		free_wq_copy_descs(fnic2, wq);
+
+	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
+		pr_err("DEBUG ERROR no wq desc for free_cmd\n");
+		kfree(host_req);
+		spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+		return;
+	}
+
+	desc = vnic_wq_copy_next_desc(wq);
+	memcpy(desc, host_req, sizeof(struct fcpio_host_req));
+
+	vnic_wq_copy_post(wq);
+	spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+
+	kfree(host_req);
+}
+
+static int fnic2_session_alloc_cb(struct se_portal_group *se_tpg,
+				  struct se_session *se_sess, void *arg)
+{
+	struct fnic2_sess *sess = (struct fnic2_sess *)arg;
+	struct fnic2 *fnic2;
+
+	fnic2 = sess->fnic2;
+	list_add_tail(&sess->list, &fnic2->lio.sess_list);
+	fnic2->lio.sess_count++;
+	return 0;
+}
+
+int fnic2_session_create(struct fnic2 *fnic2, struct fnic2_rport *rport)
+{
+	struct fnic2_sess *sess;
+	struct fnic2_tpg *tpg = fnic2->lio.tpg;
+	uint8_t portname_initiator[36];
+	unsigned int flags;
+
+	sess = fnic2_find_session(fnic2, rport->wwpn);
+	if (sess) {
+		pr_err("%s: Session already found %llx\n",
+			__func__, rport->wwpn);
+		return -1;
+	}
+
+	fnic2_format_wwnn(portname_initiator, 36, rport->wwpn);
+	pr_debug("Creating session for %s\n", portname_initiator);
+
+	if (tpg == NULL) {
+		pr_err("No tpg\n");
+		return -1;
+	}
+
+	sess = kzalloc(sizeof(struct fnic2_sess), GFP_KERNEL);
+	if (!sess) {
+		pr_err("%s: Unable to alloc memory for sess\n",
+			__func__);
+		WARN_ON(1);
+		return -1;
+	}
+
+	kref_init(&sess->kref); /* ref for table entry */
+	sess->rport = rport;
+	sess->lport = tpg->lport;
+	sess->fnic2 = fnic2;
+	INIT_LIST_HEAD(&sess->cmd_list);
+
+	sess->se_sess = target_alloc_session(&tpg->se_tpg, FNIC2_MAX_TCMDS,
+		sizeof(struct fnic2_cmd),
+		TARGET_PROT_NORMAL, portname_initiator,
+		sess, fnic2_session_alloc_cb);
+
+	if (IS_ERR(sess->se_sess)) {
+		pr_err("Session creating failed wwpn: %llx\n",
+			rport->wwpn);
+		kfree(sess);
+		return -1;
+	}
+
+	timer_setup(&sess->sess_timer, fnic2_recv_sess_timer_intr, flags);
+
+	return 0;
+}
+
+int fnic2_send_to_fw(struct fnic2_cmd *tcmd, int req_type)
+{
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	struct vnic_wq_copy *wq;
+	struct fcpio_host_req *desc;
+	unsigned long flags;
+
+	pr_debug("sending tag %x to FW\n", tcmd->cmd_tag);
+
+	tcmd->host_req = fnic2_host_req_alloc_init(tcmd, req_type);
+	if (!tcmd->host_req) {
+		return -1;
+	}
+
+	spin_lock_irqsave(&fnic2->wq_copy_lock[0], flags);
+
+	/* Use the Copy WQ to send it to FW */
+	wq = &fnic2->wq_copy[0];
+
+	if (vnic_wq_copy_desc_avail(wq) <= fnic2->wq_copy_desc_low[0]) {
+		pr_debug("Freeing the copy wq desc avail: %d\n", vnic_wq_copy_desc_avail(wq));
+		free_wq_copy_descs(fnic2, wq);
+	}
+
+	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
+		pr_err("DEBUG %s FAILED No WQ_COPY desc\n", __func__);
+		WARN_ON(0);
+		spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+		return -1;
+	}
+
+	desc = vnic_wq_copy_next_desc(wq);
+	memcpy(desc, tcmd->host_req, sizeof(struct fcpio_host_req));
+
+	vnic_wq_copy_post(wq);
+
+	spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+
+	return 0;
+}
+
+static struct fcpio_host_req *fnic2_host_req_alloc_init(struct fnic2_cmd *tcmd, int req_type)
+{
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	struct fcpio_host_req *host_req;
+	struct fcpio_tcmd_data *tdata;
+	int i, len, offset;
+	struct page *page = NULL;
+	void *page_addr;
+	struct host_sg_desc *desc_sge;
+	uint64_t page_addr_pa;
+	int remaining;
+	int j;
+	struct scatterlist *sg = NULL;
+	struct se_cmd *se_cmd = &tcmd->se_cmd;
+
+	host_req = kzalloc(sizeof(struct fcpio_host_req), GFP_KERNEL);
+	if (!host_req)
+		return NULL;
+
+
+	host_req->hdr.type = req_type;
+	host_req->hdr.fcpio_tag = tcmd->cmd_tag;
+
+	tdata = &host_req->u.tdata;
+	hton24(tdata->d_id, tcmd->sess->rport->fcid);
+	hton24(tdata->s_id, fnic2->lport.fcid);
+	tdata->ox_id = tcmd->ox_id;
+
+	tdata->data_len = tcmd->data_len_xfer;
+	tdata->mss = FNIC2_FCOE_MAX_PAYLOAD;
+
+	tcmd->sg_desc_va_unaligned = (struct host_sg_desc *)kzalloc(FNIC2_SGL_SZ + FNIC2_SGL_ALIGN, GFP_KERNEL);
+	if (!tcmd->sg_desc_va_unaligned)
+		return NULL;
+
+	tcmd->sg_desc_va = (struct host_sg_desc *)BUF_ALIGN_16(tcmd->sg_desc_va_unaligned);
+
+	pr_debug("DEBUG fn: %s, ln: %d, tag: %d, va_unal: %pK, va: %pK\n",
+		__func__, __LINE__, tcmd->cmd_tag, tcmd->sg_desc_va_unaligned, tcmd->sg_desc_va);
+	pr_debug("DEBUG tag: %x, sgcnt: %d\n", tcmd->cmd_tag, tcmd->sgcnt);
+
+
+	desc_sge = &tcmd->sg_desc_va[0];
+
+	tcmd->sg_desc_count = tcmd->sgcnt;
+
+	i = 0; j = 0;
+	remaining = tcmd->se_cmd.data_length;
+	pr_debug("DEBUG datalenxfer: %d\n", remaining);
+
+	sg = tcmd->se_cmd.t_data_sg;
+	len = sg->length;
+	offset = sg->offset;
+	page = sg_page(sg);
+	if (len == 0) {
+		pr_debug("DEBUG zero len first entry: %d\n", 0);
+	} else {
+		page_addr =  kmap_atomic(page + (offset >> PAGE_SHIFT));
+		tcmd->kmap_addr[j] = page_addr;
+
+		page_addr_pa = pci_map_single(fnic2->pdev, page_addr, len, tcmd->dma_direction);
+		desc_sge->addr = page_addr_pa;
+
+		desc_sge->len =  len;
+		pr_debug("DEBUG addr: %llx len: %d\n", desc_sge->addr, len);
+		pr_debug("DEBUG page %pK pa %llx sge len %x rmain: %d", page_addr, page_addr_pa, desc_sge->len, remaining);
+		desc_sge++;
+		j++;
+
+	}
+	remaining = remaining - len;
+
+	pr_debug("DEBUG remaining: %d\n", remaining);
+
+	while (remaining) {
+
+		sg = sg_next(sg);
+		if (sg == NULL) {
+			pr_debug("DEBUG no mpre entry: %d\n", i);
+			break;
+		}
+		len = sg->length;
+		offset = sg->offset;
+		page = sg_page(sg);
+		pr_debug("DEBUG parse sge i: %d, len: %d\n", i, len);
+		if (!len) {
+			i++;
+			continue;
+		}
+		page_addr =  kmap_atomic(page + (offset >> PAGE_SHIFT));
+		tcmd->kmap_addr[j] = page_addr;
+
+		page_addr_pa = pci_map_single(fnic2->pdev, page_addr, len, tcmd->dma_direction);
+		desc_sge->addr = page_addr_pa;
+
+		desc_sge->len =  len;
+		pr_debug("DEBUG page %pK pa %llx sge len %x rmain: %d", page_addr, page_addr_pa, desc_sge->len, remaining);
+		desc_sge++;
+
+		remaining = remaining - len;
+		j++; i++;
+
+	}
+
+	tcmd->sg_desc_pa = pci_map_single(fnic2->pdev, tcmd->sg_desc_va,
+		sizeof(struct host_sg_desc) * tcmd->sgcnt,
+		PCI_DMA_TODEVICE);
+
+	pr_debug("DEBUG sg_desc %llx", tcmd->sg_desc_pa);
+
+	if (se_cmd->se_cmd_flags & (SCF_OVERFLOW_BIT | SCF_UNDERFLOW_BIT)) {
+		pr_debug("DBEUG resid valid flag: %x, count: %d\n",
+			se_cmd->se_cmd_flags, se_cmd->residual_count);
+		if (se_cmd->se_cmd_flags & SCF_OVERFLOW_BIT)
+			tdata->rsp_iu_flags |= FCP_RSP_FLAG_OVERFLOW;
+		else
+			tdata->rsp_iu_flags |= FCP_RSP_FLAG_UNDERFLOW;
+		tdata->resid = se_cmd->residual_count;
+	}
+
+	tdata->sgl_pa = tcmd->sg_desc_pa;
+	tdata->sgl_cnt = tcmd->sgcnt;
+	tdata->send_resp = (req_type == FCPIO_TCMD_SEND_DATA) ? 1 : 0;
+
+	return host_req;
+}
+
+static void fnic2_send_rd_data_cmpl(struct fnic2_cmd *tcmd)
+{
+	/* Notify LIO that the cmd is completed */
+	transport_generic_free_cmd(&tcmd->se_cmd, 0);
+}
+
+static void fnic2_recv_wr_data_cmpl(struct fnic2_cmd *tcmd)
+{
+#if 0
+	// BGC
+	static int x = 0;
+
+	if (x++%10 == 0) {
+	    return;
+	}
+#endif
+
+	pr_debug("DEBUG wr_data_cmpl tag: %x\n", tcmd->cmd_tag);
+
+	/* Notify LIO that the cmd is completed */
+	target_execute_cmd(&tcmd->se_cmd);
+}
+
+void fnic2_send_tmr_resp(struct fnic2_cmd *tcmd, u32 status, u8 code)
+{
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	struct fnic2_sess *sess = tcmd->sess;
+	struct fnic2_rport *rport = sess->rport;
+	struct fc_fcp_rsp *fcp_rsp;
+	uint8_t s_id[3];
+	uint8_t d_id[3];
+	struct fc_hdr *fchdr;
+	struct se_cmd *se_cmd = &tcmd->se_cmd;
+	int addl_len = 0;
+	struct fcp_resp_rsp_info *info;
+
+	pr_err("SEND_TMR_RESP tcmd %pK fnic %pK sess %pK se_cmd%pK\n",
+		tcmd, fnic2, sess, se_cmd);
+
+	fcp_rsp = (struct fc_fcp_rsp *)kzalloc(2112, GFP_ATOMIC);
+	WARN_ON(!fcp_rsp);
+	fchdr = &fcp_rsp->fchdr;
+
+	hton24(s_id, fnic2->lport.fcid);
+	hton24(d_id, rport->fcid);
+
+	memcpy(fcp_rsp, &fnic2_fcp_rsp, sizeof(struct fc_fcp_rsp));
+	memcpy(fchdr->d_id, d_id, 3);
+	memcpy(fchdr->s_id, s_id, 3);
+	fchdr->ox_id = htons(tcmd->ox_id);
+	fchdr->rx_id = htons(tcmd->rx_id);
+
+	fcp_rsp->scsi_status = status;
+
+	if (se_cmd->scsi_status == SAM_STAT_GOOD) {
+		fcp_rsp->flags |= FCP_RSP_LEN_VAL;
+		addl_len = sizeof(struct fcp_resp_rsp_info);
+		info = (struct fcp_resp_rsp_info *)(fcp_rsp + 1);
+		info->rsp_code = code;
+	}
+
+	fnic2_send_fcoe_frame(&fnic2->lport, fcp_rsp, sizeof(struct fc_fcp_rsp) + addl_len);
+	kfree(fcp_rsp);
+}
+
+void fnic2_send_fcp_resp(struct fnic2_cmd *tcmd)
+{
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	struct fnic2_sess *sess = tcmd->sess;
+	struct fnic2_rport *rport = sess->rport;
+	struct fc_fcp_rsp *fcp_rsp;
+	uint8_t s_id[3];
+	uint8_t d_id[3];
+	struct fc_hdr *fchdr;
+	struct se_cmd *se_cmd = &tcmd->se_cmd;
+	int sense_len = 0;
+
+	fcp_rsp = (struct fc_fcp_rsp *)kzalloc(2112, GFP_ATOMIC);
+	WARN_ON(!fcp_rsp);
+	fchdr = &fcp_rsp->fchdr;
+
+	hton24(s_id, fnic2->lport.fcid);
+	hton24(d_id, rport->fcid);
+
+	memcpy(fcp_rsp, &fnic2_fcp_rsp, sizeof(struct fc_fcp_rsp));
+	memcpy(fchdr->d_id, d_id, 3);
+	memcpy(fchdr->s_id, s_id, 3);
+	fchdr->ox_id = htons(tcmd->ox_id);
+	fchdr->rx_id = htons(tcmd->rx_id);
+
+	fcp_rsp->scsi_status = se_cmd->scsi_status;
+
+	if (se_cmd->se_cmd_flags & (SCF_OVERFLOW_BIT | SCF_UNDERFLOW_BIT)) {
+		pr_debug("DBEUG resid valid flag: %x, count: %d\n",
+			se_cmd->se_cmd_flags, se_cmd->residual_count);
+		if (se_cmd->se_cmd_flags & SCF_OVERFLOW_BIT)
+			fcp_rsp->flags |= FCP_RSP_FLAG_OVERFLOW;
+		else
+			fcp_rsp->flags |= FCP_RSP_FLAG_UNDERFLOW;
+		fcp_rsp->resid = htonl(se_cmd->residual_count);
+	}
+
+	if (se_cmd->scsi_status != SAM_STAT_GOOD) {
+		sense_len = se_cmd->scsi_sense_length;
+		if (sense_len > 0) {
+			fcp_rsp->flags |= FCP_SNS_LEN_VAL;
+			fcp_rsp->sense_len = htonl(sense_len);
+			memcpy((fcp_rsp + 1), se_cmd->sense_buffer, sense_len);
+		}
+	}
+
+	fnic2_send_fcoe_frame(&fnic2->lport, fcp_rsp, sizeof(struct fc_fcp_rsp) + sense_len);
+	kfree(fcp_rsp);
+}
+
+void fnic2_free_fw_res(struct fnic2_cmd *tcmd)
+{
+	struct fcpio_host_req *host_req;
+	struct fcpio_host_req *desc;
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	struct vnic_wq_copy *wq;
+	unsigned long flags;
+
+	/* Fill the structure to send it to fw */
+	host_req = kzalloc(sizeof(struct fcpio_host_req), GFP_KERNEL);
+	WARN_ON(host_req == NULL);
+
+	host_req->hdr.type = FCPIO_TCMD_FREE_CMD;
+	/* FW uses rx_id for freeing write commands */
+	host_req->hdr.fcpio_tag = tcmd->rx_id;
+
+	spin_lock_irqsave(&fnic2->wq_copy_lock[0], flags);
+
+	/* Use the Copy WQ to send it to FW */
+	wq = &fnic2->wq_copy[0];
+
+	if (vnic_wq_copy_desc_avail(wq) <= fnic2->wq_copy_desc_low[0])
+		free_wq_copy_descs(fnic2, wq);
+
+	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
+		pr_err("DEBUG ERROR no wq desc for free_cmd\n");
+		spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+		kfree(host_req);
+		return;
+	}
+
+	desc = vnic_wq_copy_next_desc(wq);
+	memcpy(desc, host_req, sizeof(struct fcpio_host_req));
+
+	pr_debug("Sent free req to FW\n");
+
+	vnic_wq_copy_post(wq);
+
+	spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+
+	kfree(host_req);
+}
+
+static void fnic2_unmap_free_sgl(struct fnic2 *fnic2, struct fnic2_cmd *tcmd)
+{
+	struct host_sg_desc *desc_sge;
+	int i;
+
+	pci_unmap_single(fnic2->pdev, tcmd->sg_desc_pa, sizeof(struct host_sg_desc) * tcmd->sgcnt,
+		PCI_DMA_TODEVICE);
+
+	desc_sge = &tcmd->sg_desc_va[0];
+
+	/* Now, each entries in the sglist pci_unmap and kunmap */
+	for (i = 0; i < tcmd->sgcnt; i++) {
+		pci_unmap_single(fnic2->pdev, desc_sge->addr, desc_sge->len, tcmd->dma_direction);
+		desc_sge++;
+		kunmap(tcmd->kmap_addr[i]);
+	}
+
+	/* free the descriptor list */
+	kfree(tcmd->sg_desc_va_unaligned);
+}
+
+void fnic2_fcpio_tcmd_cmpl_handler(struct work_struct *work)
+{
+	struct fnic2_cmd *tcmd =
+		container_of(work, struct fnic2_cmd, work);
+	struct fcpio_fw_req *desc = &tcmd->fw_desc;
+
+	if (!desc) {
+		pr_err("Cmd tag %x freed before %s\n", tcmd->cmd_tag, __func__ );
+		return;
+	}
+
+	pr_debug("DEBUG FW completion tcmd: %pK, tag: %x, hdrtype: %d, hdrstatus: %x\n",
+		tcmd, tcmd->cmd_tag, desc->hdr.type, desc->hdr.status);
+
+	/* For now, only success cases */
+	if (desc->hdr.status != FCPIO_SUCCESS) {
+		pr_debug("ERROR hdrstatus not success: %d\n",
+			desc->hdr.status);
+	}
+
+	switch (desc->hdr.type) {
+
+	case FCPIO_TCMD_SEND_DATA:
+		fnic2_send_rd_data_cmpl(tcmd);
+	break;
+
+	case FCPIO_TCMD_RECV_DATA:
+
+		pr_debug("recv_data cmpl hdrtype: %d, tag: %x, rx_id: %x\nWrite completed ox_id %x\n",
+			desc->hdr.type, tcmd->cmd_tag, desc->u.trsp.rx_id,
+			tcmd->ox_id);
+
+		tcmd->rx_id = desc->u.trsp.rx_id;
+		fnic2_recv_wr_data_cmpl(tcmd);
+	break;
+
+	case FCPIO_TCMD_FREE_CMD:
+		pr_debug("free_cmd cmpl hdrtype: %d, tag: %x\n",
+			desc->hdr.type, tcmd->cmd_tag);
+
+		transport_generic_free_cmd(&tcmd->se_cmd, 0);
+	break;
+
+	case FCPIO_TCMD_ABORT_CMD:
+		pr_debug("abort_cmd cmpl hdrtype: %d, tag: %x\n",
+			desc->hdr.type, tcmd->cmd_tag);
+		fnic2_fw_abort_done(tcmd);
+		break;
+
+	case FCPIO_TCMD_TASK_MGMT:
+                pr_debug("task mgmt cmpl hdrtype: %d, tag: %x\n",
+                        desc->hdr.type, tcmd->cmd_tag);
+		fnic2_complete_tm_rsp(tcmd);
+                break;
+
+	default:
+		break;
+	}
+}
+
+/* Utilities */
+
+struct fnic2_cmd *fnic2_find_tcmd(struct fnic2 *fnic2, uint32_t cmd_tag)
+{
+	struct fnic2_cmd *tcmd;
+
+	pr_debug("DEBUG find tcmd: tag: %d\n", cmd_tag);
+
+	WARN_ON(cmd_tag >= FNIC2_MAX_TCMDS);
+
+	tcmd = &fnic2->tcmd_pool[cmd_tag];
+	pr_debug("DEBUG tcmd: %pK\n", tcmd);
+	return tcmd;
+}
+
+/*
+ * find_fnic2 - Routine to find fnic2 structure using wwpn provided
+ */
+struct fnic2 *find_fnic2_wwpn(uint64_t wwpn)
+{
+	struct fnic2 *fnic2;
+	struct fnic2_lport *lport;
+
+	list_for_each_entry(fnic2, &fnic2_list, list) {
+		lport = &fnic2->lport;
+		if (wwpn == lport->wwpn) {
+			return fnic2;
+		}
+	}
+	return NULL;
+}
+
+struct fnic2_sess *fnic2_find_sess_s_id(struct fnic2 *fnic2, uint32_t s_id)
+{
+	struct fnic2_sess *sess;
+
+	list_for_each_entry(sess, &fnic2->lio.sess_list, list) {
+		if (sess->rport->fcid == s_id)
+			return sess;
+	}
+	return NULL;
+}
+
+struct fnic2_sess *fnic2_find_session(struct fnic2 *fnic2, uint64_t wwpn)
+{
+	struct fnic2_sess *sess;
+
+	list_for_each_entry(sess, &fnic2->lio.sess_list, list) {
+		if (sess->rport && sess->lport->lport_wwpn == wwpn)
+			return sess;
+	}
+	return NULL;
+}
+
+static void fnic2_format_wwnn(char *buf, int len, uint64_t wwn)
+{
+	uint8_t b[8];
+
+	put_unaligned_be64(wwn, b);
+	snprintf(buf, len,
+		 "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+		 b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]);
+}
+
+/*
+ * Handle Task Management Request.
+ */
+static void fnic2_send_tm(struct fnic2_cmd *tcmd)
+{
+	struct fc_fcp_cmnd *fcp_cmd_req;
+	uint8_t tm_func;
+	int rc;
+
+	fcp_cmd_req = (struct fc_fcp_cmnd *) tcmd->rx_frame;
+
+	pr_err("GOT TASK MANAGEMENT %x", fcp_cmd_req->tm_flags);
+
+	switch (fcp_cmd_req->tm_flags) {
+	case FCP_TMF_LUN_RESET:
+		tm_func = TMR_LUN_RESET;
+		break;
+	case FCP_TMF_TGT_RESET:
+		tm_func = TMR_TARGET_WARM_RESET;
+		break;
+	case FCP_TMF_CLR_TASK_SET:
+		tm_func = TMR_CLEAR_TASK_SET;
+		break;
+	case FCP_TMF_ABT_TASK_SET:
+		tm_func = TMR_ABORT_TASK_SET;
+		break;
+	case FCP_TMF_CLR_ACA:
+		tm_func = TMR_CLEAR_ACA;
+		break;
+	default:
+		pr_err("invalid FCP tm_flags %x\n", fcp_cmd_req->tm_flags);
+		fnic2_send_tmr_resp_and_free(tcmd, FCP_CMND_FIELDS_INVALID);
+		return;
+	}
+
+	rc = target_submit_tmr(&tcmd->se_cmd, tcmd->sess->se_sess,
+			       tcmd->sense_buf, scsilun_to_int(&fcp_cmd_req->fcp_lun),
+			       tcmd, tm_func, GFP_KERNEL, tcmd->cmd_tag,
+			       TARGET_SCF_ACK_KREF);
+
+	if (rc) {
+		pr_err("target_submit_tmr FAILED rc %d\n", rc);
+		fnic2_send_tmr_resp_and_free(tcmd, FCP_CMND_FIELDS_INVALID);
+	}
+}
+
+
+/*
+ * fnic2_recv_tcmd_timeout_intr - Process intr from tcmd timeout
+ *
+ * @intr_data - pointer to a tcmd that
+ * received an interrupt
+ *
+ * This function is called in an interrupt context when a tcmd
+ * exceeds the timeout value. It queues work on another
+ * function to clean up fnic2 resources.
+ */
+void fnic2_recv_tcmd_timeout_intr(struct timer_list *timer)
+{
+	struct fnic2_cmd *tcmd = container_of(timer, struct fnic2_cmd, io_timer);
+	int cpu;
+
+	pr_debug("Got interrupt on tag %x on fnic2 %d tcmds left: %d\n", tcmd->cmd_tag, tcmd->fnic2->fnic2_num, tcmd->fnic2->freecmds);
+
+	/* Queue on proper cpu */
+	cpu = get_cpu_to_queue(tcmd->cmd_tag);
+
+	INIT_WORK(&tcmd->work, fnic2_process_tcmd_timeout);
+	queue_work_on(cpu, fnic2_tcmd_wq, &tcmd->work);
+
+	return;
+}
+
+/*
+ * fnic2_process_tcmd_timeout - Process a tcmd that has timed out
+ *
+ * @work - work_struct that this function was queued with
+ *
+ * Free a tcmd that has been held by driver for the timeout period
+ * Create a dummy ABTS command and submit to LIO and FW
+ */
+static void fnic2_process_tcmd_timeout(struct work_struct *work)
+{
+	/* tcmd is original IO to be aborted, abort_tcmd is used as the ABTS cmd */
+	struct fnic2_cmd *tcmd, *abort_tcmd;
+	struct fnic2 *fnic2;
+	struct fnic2_sess *sess;
+	unsigned long flags;
+	unsigned long fnic2_flags;
+
+	tcmd = container_of(work, struct fnic2_cmd, work);
+
+	spin_lock_irqsave(&tcmd->lock, flags);
+
+	if (tcmd->abort_tag == 0) {
+		pr_err("tcmd tag %x freed before timeout\n", tcmd->cmd_tag);
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return;
+	}
+
+	fnic2 = tcmd->fnic2;
+	abort_tcmd = fnic2_get_tcmd_from_pool(fnic2);
+
+	if (!abort_tcmd) {
+		pr_err("No TCMDs available! %s\n", __func__);
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return;
+	}
+
+	abort_tcmd->flags |= FNIC2_TCMD_IS_ABTS;
+
+	pr_err("Got tcmd tag %x for timeout for io %x on fnic %d, tcmd->abort_tag %x ox_id %x\n", abort_tcmd->cmd_tag, tcmd->cmd_tag, fnic2->fnic2_num, tcmd->abort_tag, tcmd->ox_id);
+
+	if (tcmd->flags & FNIC2_TCMD_ABORTED) {
+		pr_err("tcmd tag %x already being freed not in timeout\n", tcmd->cmd_tag);
+		goto timeout_error;
+	}
+
+	tcmd->flags |= FNIC2_TCMD_ABORTED;
+
+	sess = fnic2_find_sess_s_id(fnic2, tcmd->s_id);
+
+        if (!sess) {
+		pr_err("No session found for %s\n", __func__);
+		goto timeout_error;
+        }
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, fnic2_flags);
+
+	if (!timer_pending(&sess->sess_timer)) {
+
+		fdls_construct_logo_req(&fnic2->lport, (struct fc_hdr *)tcmd->rx_frame, sess);
+
+		sess->sess_timer.expires = jiffies + (JIFFIES_PER_MINUTE * 5);
+
+		add_timer(&sess->sess_timer);
+	}
+
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, fnic2_flags);
+
+	tcmd->abort_tag = abort_tcmd->cmd_tag;
+	abort_tcmd->killed_tcmd = tcmd;
+	tcmd->abort_tcmd = abort_tcmd;
+
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+
+	fnic2_send_abort_to_fw(tcmd);
+
+	return;
+
+timeout_error:
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+	fnic2_free_tcmd(abort_tcmd);
+	return;
+}
+
+/*
+ * fnic2_recv_sess_timer_intr - receive an interrupt on a dead session
+ *
+ * @timer - timer inside session that received interrupt
+ *
+ * Session has sat idle for extended period of time
+ * Send a logo and delete the session
+ */
+static void fnic2_recv_sess_timer_intr(struct timer_list *timer)
+{
+	struct fnic2_sess *sess = container_of(timer, struct fnic2_sess, sess_timer);
+	struct fnic2 *fnic2 = sess->fnic2;
+
+	pr_err("Got sess %pK timer interrupt\n", sess);
+
+	fnic2_send_fcoe_frame(&fnic2->lport, &sess->timer_logo_req, sizeof(struct fc_logo_req));
+
+	fdls_delete_rport(&fnic2->lport, sess->rport);
+
+	return;
+}
diff --git a/drivers/staging/fnic2/src/fnic2_io.h b/drivers/staging/fnic2/src/fnic2_io.h
new file mode 100644
index 0000000..59cb97e
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_io.h
@@ -0,0 +1,32 @@
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
+#ifndef _FNIC2_IO_H_
+#define _FNIC2_IO_H_
+
+#include <scsi/fc/fc_fcp.h>
+
+#define FNIC2_DFLT_SG_DESC_CNT	32
+#define FNIC2_MAX_SG_DESC_CNT	256	/* Maximum descriptors per sgl */
+
+struct host_sg_desc {
+	__le64		addr;
+	__le32		len;
+	uint32_t	_resvd;
+};
+
+#endif /* _FNIC2_IO_H_ */
-- 
1.8.3.1
