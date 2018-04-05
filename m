Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx48+RuKo1uEynwd8DsqcmlzBbBBwMnBtM3LFbsW/wG1nTcMzonPtn5r6CcHvcWFk48DBwJzk
ARC-Seal: i=1; a=rsa-sha256; t=1522963004; cv=none;
        d=google.com; s=arc-20160816;
        b=QIxuZjU+3C10oEIcazAs7v08DjW7hC3eZrvCrNf11ByPJfi0YZE1ewvxqzcS5NOjS3
         4IMk2/aT2Upqb17dO/ZFM2SExfs4Di7qAOPXtTRNykHrb+cwf+lSob6BJuWxmrsmW41V
         oHNcEedGmQKgpfkewLV0fpTgE5ZJ61WbITbZA/ZeNOkRh9uLKuFtrUyBnInRLJb2RbPq
         +7ve95qoqmwmP8NRx5UY+MbhwMwiORlCzgiD3yYim2SK8cc+jBA5WG9JP5tq/7Gd2ESn
         5EMA+0amkKdlpcN0oDyZHE6+M71TWY1+2hDUpL/zfydEcJhN4usU8joHrI7vHwad5UVZ
         qryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=c9Umqmp0OxU94XIfsoGLwXqZGLWlMEuee5lP9qkffG0=;
        b=hqecrznnDsiuzEuv6TyRIIcwsvENI+Uc4wJ9BWCWUms9D9Pvc1Bk64ZE7Hs2GVGrLO
         lSUHt2d5u/hRfG6RG/NO9azafq844gVGcP5w5VNnhl2f2u5ikfZszuxium8BK40h5guw
         65vhRXhKGBFIzHMBPmphdjk/AXY6v+e36SKMKuPeR4g/XxKuCEpITitNav8j9Qd8CrAx
         MX0L3dH556ZAtXuw535bBiXea8xKk4wx8ocXedxINGVEpZY6mmkIESQz0AmQUBzPlhpV
         fa4rFxcBb9GDELFZdVkGQjonoLgAem9i0HG/hKocd9TjRdxBsgtt6o49hXQe0X/XJLvW
         qsfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=h/XDA+lt;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.94 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=h/XDA+lt;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.94 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94247996"
Date: Thu, 5 Apr 2018 14:19:28 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 04/10] staging: fnic2 add fdls system
Message-ID: <20180405211928.GE12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942454911363410?=
X-GMAIL-MSGID: =?utf-8?q?1596942454911363410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain Fibre Channel discovery handling
and fabric services.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/fdls_disc.c  | 1539 ++++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/fdls_fc.h    |  403 +++++++++
 drivers/staging/fnic2/src/fdls_if.c    | 1254 ++++++++++++++++++++++++++
 drivers/staging/fnic2/src/fnic2_fdls.h |  232 +++++
 4 files changed, 3428 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/fdls_disc.c
 create mode 100644 drivers/staging/fnic2/src/fdls_fc.h
 create mode 100644 drivers/staging/fnic2/src/fdls_if.c
 create mode 100644 drivers/staging/fnic2/src/fnic2_fdls.h

diff --git a/drivers/staging/fnic2/src/fdls_disc.c b/drivers/staging/fnic2/src/fdls_disc.c
new file mode 100644
index 0000000..e955116
--- /dev/null
+++ b/drivers/staging/fnic2/src/fdls_disc.c
@@ -0,0 +1,1539 @@
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
+#include "fnic2.h"
+#include "fdls_fc.h"
+#include "fnic2_fdls.h"
+
+static void fdls_send_rpn_id(struct fnic2_lport *lport);
+struct fnic2_rport *fnic2_find_rport_by_fcid(struct fnic2_lport *lport, uint32_t fcid);
+struct fnic2_rport *fnic2_find_rport(struct fnic2_lport *lport, uint64_t wwpn);
+void fnic2_fdls_remove_rport(struct fnic2_lport *lport, struct fnic2_rport *rport);
+struct fnic2_rport *fnic2_fdls_add_rport(struct fnic2_lport *lport, struct fnic2_rport *rport);
+struct fnic2_rport *fdls_create_rport(struct fnic2_lport *lport, uint32_t fcid, uint64_t wwpn);
+void fdls_delete_rport(struct fnic2_lport *lport, struct fnic2_rport *rport);
+
+extern int fnic2_session_create(struct fnic2 *fnic2, struct fnic2_rport *rport);
+
+/* Frame initialization */
+
+/*
+ * Variables:
+ * s_id
+ */
+struct fc_els fnic2_flogi_req = {
+	.fchdr = {.r_ctl = 0x22, .d_id = {0xFF, 0xFF, 0xFE},
+		.type = 0x01, .f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00},
+	.ox_id = FNIC2_FLOGI_OXID, .rx_id = 0xFFFF},
+	.command = FC_ELS_FLOGI_REQ,
+	.u.csp_flogi = {.fc_ph_ver = FNIC2_FC_PH_VER,
+	.b2b_credits = FNIC2_FC_B2B_CREDIT,
+	.b2b_rdf_size = FNIC2_FC_B2B_RDF_SZ},
+	.spc3 = {0x88, 0x00}
+};
+
+/*
+ * Variables:
+ * s_id, d_id(nport logins), ox_id(nport logins), nport_name, node_name
+ */
+struct fc_els fnic2_plogi_req = {
+	.fchdr = {.r_ctl = 0x22, .d_id = {0xFF, 0xFF, 0xFC}, .type = 0x01,
+		.f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00}, .ox_id = FNIC2_PLOGI_FABRIC_OXID,
+		.rx_id = 0xFFFF},
+	.command = FC_ELS_PLOGI_REQ,
+	.u.csp_plogi = {.fc_ph_ver = FNIC2_FC_PH_VER,
+		.b2b_credits = FNIC2_FC_B2B_CREDIT, .features = 0x0080,
+		.b2b_rdf_size = FNIC2_FC_B2B_RDF_SZ,
+		.total_concur_seqs = FNIC2_FC_CONCUR_SEQS,
+		.ro_info = FNIC2_FC_RO_INFO, .e_d_tov = FNIC2_E_D_TOV},
+	.spc3 = {0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
+		 0x00, 0xFF, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00}
+};
+
+/*
+ * Variables:
+ * s_id, d_id(nport logins), ox_id(nport logins), nport_name, node_name
+ */
+struct fc_els fnic2_plogi_resp = {
+	.fchdr = {.r_ctl = 0x23, .type = 0x01,
+		.f_ctl = {FNIC2_ELS_REP_FCTL, 0x00, 0x00} },
+	.command = FC_LS_ACC,
+	.u.csp_plogi = {.fc_ph_ver = FNIC2_FC_PH_VER,
+		.b2b_credits = FNIC2_FC_B2B_CREDIT, .features = 0x0080,
+		.b2b_rdf_size = FNIC2_FC_B2B_RDF_SZ,
+	.total_concur_seqs = FNIC2_FC_CONCUR_SEQS,
+	.ro_info = FNIC2_FC_RO_INFO, .e_d_tov = FNIC2_E_D_TOV},
+	.spc3 = {0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
+		 0x00, 0xFF, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00}
+};
+
+/*
+ * Variables:
+ * s_id, port_id, port_name
+ */
+struct fc_rpn_id fnic2_rpn_id_req = {
+	.fchdr = {.r_ctl = 0x02, .d_id = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+		.f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00}, .ox_id = FNIC2_RPN_REQ_OXID,
+		.rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+			.command = FC_CT_RPN_CMD}
+};
+
+/*
+ * Variables:
+ * s_id, port_id, port_name
+ */
+struct fc_rft_id fnic2_rft_id_req = {
+	.fchdr = {.r_ctl = 0x02, .d_id = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+		.f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00}, .ox_id = FNIC2_RFT_REQ_OXID,
+		.rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+			.command = FC_CT_RFT_CMD}
+};
+
+/*
+ * Variables:
+ * s_id, port_id, port_name
+ */
+struct fc_rff_id fnic2_rff_id_req = {
+	.fchdr = {.r_ctl = 0x02, .d_id = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+		.f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00}, .ox_id = FNIC2_RFF_REQ_OXID,
+		.rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+			.command = FC_CT_RFF_CMD},
+	.tgt = 0x1,
+	.fc4_type = 0x8
+};
+
+/*
+ * Variables:
+ * d_id, s_id, ox_id
+ */
+struct fc_els_prli fnic2_prli_resp = {
+	.fchdr = {.r_ctl = 0x23, .type = 0x01,
+		.f_ctl = {FNIC2_ELS_REP_FCTL, 0x00, 0x00} },
+	.command = FC_LS_ACC,
+	.page_len = 16,
+	.payload_len = 0x1400,
+	.sp = {.type = 0x08, .flags = 0x0021, .csp = 0x12040000}
+};
+
+/*
+ * Variables:
+ * d_id, ox_id, rx_id
+ */
+struct fc_els_acc fnic2_els_acc = {
+	.fchdr = {.r_ctl = 0x23, .d_id = {0xFF, 0xFF, 0xFD}, .type = 0x01,
+		.f_ctl = {FNIC2_ELS_REP_FCTL, 0x00, 0x00} },
+	.command = FC_LS_ACC,
+};
+
+struct fc_els_reject fnic2_els_rjt = {
+	.fchdr = {.r_ctl = 0x23, .type = 0x01, .f_ctl = {FNIC2_ELS_REP_FCTL, 0x00, 0x00} },
+	.command = FC_LS_REJ,
+};
+
+/*
+ * Variables:
+ * d_id, ox_id, rx_id
+ */
+struct fc_abts_ba_acc fnic2_ba_acc = {
+	.fchdr = {.r_ctl = 0x84,
+		.f_ctl = {FNIC2_FCP_RSP_FCTL, 0x00, 0x00}},
+	.low_seq_cnt = 0, .high_seq_cnt = 0xFFFF,
+};
+
+
+/*
+ * Variables:
+ * d_id, ox_id, rx_id, fcid, wwpn
+ */
+struct fc_logo_req fnic2_logo_req = {
+	.fchdr = {.r_ctl = 0x22, .type = 0x01,
+		.f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00} },
+	.command = FC_ELS_LOGO,
+};
+
+#define FDLS_TGT_OXID_POOL_SZ   (0x800)
+#define FDLS_TGT_OXID_BLOCK_SZ  (0x200)
+#define FDLS_PLOGI_OXID_BASE    (0x2000)
+#define FDLS_PRLI_OXID_BASE     (0x2200)
+
+uint8_t tgt_ox_id_pool[FDLS_TGT_OXID_POOL_SZ];
+
+/* Private Functions */
+static void fnic2_fdls_start_plogi(struct fnic2_lport *lport);
+
+static void fdls_init_tgt_ox_id_pool(void)
+{
+	memset(tgt_ox_id_pool, 0, FDLS_TGT_OXID_POOL_SZ);
+}
+
+static uint16_t fdls_alloc_tgt_ox_id(uint16_t base)
+{
+	int i;
+	int start, end;
+
+	start = base - FDLS_PLOGI_OXID_BASE;
+	end = start + FDLS_TGT_OXID_BLOCK_SZ;
+
+	for (i = start; i < end; i++) {
+		if (tgt_ox_id_pool[i] == 0) {
+			tgt_ox_id_pool[i] = 1;
+			return (i + FDLS_PLOGI_OXID_BASE);
+		}
+	}
+	return 0xFFFF;
+}
+static void fdls_free_tgt_ox_id(uint16_t ox_id)
+{
+	if (tgt_ox_id_pool[ox_id - FDLS_PLOGI_OXID_BASE] != 1)
+		pr_debug("%s Free unused ox_id:%x\n",
+			 __func__, ox_id);
+	tgt_ox_id_pool[ox_id - FDLS_PLOGI_OXID_BASE] = 0;
+}
+
+static void fdls_process_flogi_rsp(struct fnic2_lport *lport, struct fc_hdr *fchdr, void *rx_frame)
+{
+	struct fnic2_fdls_fabric *fabric = &lport->fabric;
+	struct fc_els *flogi_rsp = (struct fc_els *)fchdr;
+	uint8_t *fcid;
+	int rdf_size;
+	struct fc_els_reject *els_rjt;
+	uint8_t fcmac[6] = {0x0E, 0XFC, 0x00, 0x00, 0x00, 0x00};
+
+	pr_debug("lport 0x%pK fnic2_fcoe_process_flogi_resp\n", lport);
+
+	if (fabric->state != FDLS_STATE_FABRIC_FLOGI) {
+		pr_debug("Flogi resp recvd in state %d. Dropping\n",
+			fabric->state);
+		return;
+	}
+
+	switch (flogi_rsp->command) {
+	case FC_LS_ACC:
+
+		if (lport->fabric.timer_pending) {
+			pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+			del_timer_sync(&fabric->retry_timer);
+		}
+		lport->fabric.timer_pending = 0;
+		lport->fabric.retry_counter = 0;
+
+		fcid = fchdr->d_id;
+		lport->fcid = ntoh24(fcid);
+
+		pr_debug("Flogi resp Accepted: 0x%08x\n", lport->fcid);
+
+		/* Learn the Service Params */
+		rdf_size = ntohl(flogi_rsp->u.csp_flogi.b2b_rdf_size);
+		if ((rdf_size >= FNIC2_FCOE_MIN_FRAME_SZ)  &&
+		    (rdf_size < FNIC2_FCOE_MAX_FRAME_SZ))
+			lport->mfs = rdf_size;
+
+		pr_debug("mfs from fabric:%d, set:%d\n", rdf_size, lport->mfs);
+		lport->r_a_tov = ntohl(flogi_rsp->u.csp_flogi.r_a_tov);
+		lport->e_d_tov = ntohl(flogi_rsp->u.csp_flogi.e_d_tov);
+
+		if (flogi_rsp->u.csp_flogi.features & FNIC2_FC_EDTOV_NSEC)
+			lport->e_d_tov = lport->e_d_tov / FNIC2_NSEC_TO_MSEC;
+
+		pr_debug("from fabric:%d, %d\n", lport->r_a_tov, lport->e_d_tov);
+
+		fnic2_fdls_learn_fcoe_macs(lport, rx_frame, fcid);
+
+		if (fnic2_fdls_register_portid(lport, lport->fcid, rx_frame) !=
+		    0) {
+			pr_debug("lport 0x%pK flogi registration failed\n", lport);
+			break;
+		}
+
+		memcpy(&fcmac[3], fcid, 3);
+		pr_debug("Adding vnic_dev_mac addr:%02x %02x %02x %02x %02x %02x\n",
+			fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4], fcmac[5]);
+		vnic_dev_add_addr(lport->fnic2->vdev, fcmac);
+
+		fnic2_fdls_start_plogi(lport);
+		break;
+
+	case FC_LS_REJ:
+		els_rjt = (struct fc_els_reject *)fchdr;
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY) ||
+		    (els_rjt->reason_code == FC_ELS_RJT_BUSY)) &&
+		    (fabric->retry_counter < lport->max_flogi_retries)) {
+
+			pr_debug("lport 0x%pK Flogi returned FC_LS_REJ BUSY retry from timer routine..\n",
+				lport);
+
+			/*Retry Flogi again from the timer routine.*/
+			fabric->flags |= FNIC2_FDLS_RETRY_FRAME;
+			// change the name , make it common
+		} else {
+			pr_debug("lport 0x%pK Flogi returned FC_LS_REJ... halting discovery.\n", lport);
+			if (fabric->timer_pending) {
+				pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+				del_timer_sync(&fabric->retry_timer);
+			}
+			fabric->timer_pending = 0;
+			fabric->retry_counter = 0;
+		}
+		break;
+
+	default:
+		pr_debug("Flogi resp Not Accepted: %x\n", flogi_rsp->command);
+		/* TBD Handle it */
+		break;
+	}
+}
+
+static void fdls_process_fabric_plogi_rsp(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_els *plogi_rsp = (struct fc_els *)fchdr;
+	struct fc_els_reject *els_rjt = (struct fc_els_reject *)fchdr;
+
+	pr_debug("lport 0x%pK fnic2_fcoe_process_fabric_plogi_resp", lport);
+	if (lport->fabric.state != FDLS_STATE_FABRIC_PLOGI) {
+		pr_debug("plogi resp recvd in state %d. dropping\n",
+			 lport->fabric.state);
+		return;
+	}
+
+	switch (plogi_rsp->command) {
+	case FC_LS_ACC:
+		if (lport->fabric.timer_pending) {
+			pr_debug("lport 0x%pK Canceling fabric disc timer", lport);
+			del_timer_sync(&(lport->fabric.retry_timer));
+		}
+		lport->fabric.timer_pending = 0;
+		lport->fabric.retry_counter = 0;
+		fdls_send_rpn_id(lport);
+		lport->fabric.state = FDLS_STATE_RPN_ID;
+		break;
+
+	case FC_LS_REJ:
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY) ||
+			(els_rjt->reason_code == FC_ELS_RJT_BUSY)) &&
+			(lport->fabric.retry_counter < lport->max_plogi_retries)) {
+			pr_debug("lport 0x%pK Fabric plogi returned FC_LS_REJ BUSY retry from timer routine..\n", lport);
+
+			/*Retry Fabric Plogi again from the timer routine.*/
+			lport->fabric.flags |= FNIC2_FDLS_RETRY_FRAME;
+			return;
+		} else {
+			pr_debug("lport 0x%pK Fabric Plogi returned FC_LS_REJ...halting discovery.\n", lport);
+			if (lport->fabric.timer_pending) {
+				pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+				del_timer_sync(&(lport->fabric.retry_timer));
+			}
+
+			lport->fabric.timer_pending = 0;
+			lport->fabric.retry_counter = 0;
+			return;
+		}
+		break;
+
+	default:
+		pr_debug("plogi resp Not Accepted: %x", plogi_rsp->command);
+		/* TBD Handle it */
+		break;
+	}
+}
+
+void fdls_send_logout(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_logo_req logo;
+	uint8_t s_id[3];
+
+	memcpy(&logo, &fnic2_logo_req, sizeof(struct fc_logo_req));
+
+	hton24(s_id, lport->fcid);
+
+	memcpy(logo.fchdr.s_id, s_id, 3);
+	memcpy(logo.fchdr.d_id, fchdr->s_id, 3);
+	logo.fchdr.ox_id = FNIC2_LOGO_REQ_OXID;
+
+	memcpy(&logo.fcid, s_id, 3);
+	logo.wwpn = lport->wwpn;
+
+	fnic2_send_fcoe_frame(lport, &logo, sizeof(struct fc_logo_req));
+}
+
+/*
+ * fdls_construct_logo_req - build a logo request for session timeout
+ *
+ * @lport - the fnic2 local fc port
+ * @fchdr - the fc_hdr from the machine we want to logo with
+ * @sess - the session that will hold the logo request
+ *
+ * This function is used primarily in the case of a session timeout
+ * where we don't have an explicit lport or fchdr, so we need to
+ * construct one at the time that we initiate a session timer.
+ * The logo will then be used in the event of a session
+ * timeout and be freed from there.
+ */
+void fdls_construct_logo_req(struct fnic2_lport *lport,
+			     struct fc_hdr *fchdr,
+			     struct fnic2_sess *sess)
+{
+	struct fc_logo_req logo;
+	uint8_t s_id[3];
+
+	memcpy(&logo, &fnic2_logo_req, sizeof(struct fc_logo_req));
+
+	hton24(s_id, lport->fcid);
+
+	memcpy(logo.fchdr.s_id, s_id, 3);
+        memcpy(logo.fchdr.d_id, fchdr->s_id, 3);
+        logo.fchdr.ox_id = FNIC2_LOGO_REQ_OXID;
+
+	memcpy(&logo.fcid, s_id, 3);
+	logo.wwpn = lport->wwpn;
+
+	memcpy(&sess->timer_logo_req, &logo, sizeof(struct fc_logo_req));
+
+	return;
+
+}
+
+static void fdls_send_logo_resp(struct fnic2_lport *lport, struct fc_hdr *req_fchdr)
+{
+	struct fc_els_acc logo_resp;
+	uint16_t  ox_id;
+	uint8_t fcid[3];
+
+	memcpy(&logo_resp, &fnic2_els_acc, sizeof(struct fc_els_acc));
+
+	hton24(fcid, lport->fcid);
+	memcpy(&logo_resp.fchdr.s_id, fcid, 3);
+
+	ox_id = req_fchdr->ox_id;
+	logo_resp.fchdr.ox_id = ox_id;
+
+	logo_resp.fchdr.rx_id = FNIC2_LOGO_RESP_OXID; //TBD_REVISIT
+	fnic2_send_fcoe_frame(lport, &logo_resp, sizeof(struct fc_els_acc));
+}
+
+static void fdls_start_fabric_timer(struct fnic2_lport *lport)
+{
+	uint32_t fabric_tov;
+
+	lport->fabric.retry_counter++;
+	fabric_tov = jiffies + msecs_to_jiffies(2 * lport->e_d_tov);
+	mod_timer(&lport->fabric.retry_timer, round_jiffies(fabric_tov));
+	lport->fabric.timer_pending = 1;
+}
+
+static void fdls_start_abort_timer(struct fnic2_lport *lport)
+{
+	uint32_t abort_tov;
+
+	abort_tov = jiffies + msecs_to_jiffies(2 * lport->r_a_tov);
+	mod_timer(&lport->fabric.retry_timer, round_jiffies(abort_tov));
+	lport->fabric.timer_pending = 1;
+}
+
+static void fdls_send_fabric_abts(struct fnic2_lport *lport)
+{
+
+	uint8_t fcid[3];
+	struct fc_hdr  fc_ABTS_s = {
+		.r_ctl  = 0x81, //ABTS
+		.d_id    = {0xFF, 0xFF, 0xFF},
+		.cs_ctl = 0x00,
+		.s_id = {0x00, 0x00, 0x00},
+		.type   = 0x00,
+		.f_ctl  = {FNIC2_REQ_ABTS_FCTL, 0x00, 0x00},
+		.seq_id = 0x00,
+		.df_ctl = 0x00,
+		.seq_cnt = 0x0000,
+		.rx_id  = 0xFFFF,
+		.param  = 0x00000000, // bit:0 =0 Abort a exchange
+	};
+
+	struct fc_hdr *pfc_ABTS = &fc_ABTS_s;
+
+	switch (lport->fabric.state) {
+	case FDLS_STATE_FABRIC_FLOGI:
+		fc_ABTS_s.ox_id = FNIC2_FLOGI_OXID;
+		fc_ABTS_s.d_id[2] = 0xFE;
+		lport->fabric.flags |= FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+		break;
+
+	case FDLS_STATE_FABRIC_PLOGI:
+		hton24(fcid, lport->fcid);
+		memcpy(pfc_ABTS->s_id, fcid, 3);
+		fc_ABTS_s.ox_id = FNIC2_PLOGI_FABRIC_OXID;
+		fc_ABTS_s.d_id[2] = 0xFC;
+		lport->fabric.flags |= FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+		break;
+
+	case FDLS_STATE_RPN_ID:
+		hton24(fcid, lport->fcid);
+		memcpy(pfc_ABTS->s_id, fcid, 3);
+		fc_ABTS_s.ox_id = FNIC2_RPN_REQ_OXID;
+		fc_ABTS_s.d_id[2] = 0xFC;
+		lport->fabric.flags |= FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+		break;
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		hton24(fcid, lport->fcid);
+		memcpy(pfc_ABTS->s_id, fcid, 3);
+		fc_ABTS_s.ox_id = FNIC2_RFT_REQ_OXID;
+		fc_ABTS_s.d_id[2] = 0xFC;
+		lport->fabric.flags |= FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+		break;
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		hton24(fcid, lport->fcid);
+		memcpy(pfc_ABTS->s_id, fcid, 3);
+		fc_ABTS_s.ox_id = FNIC2_RFF_REQ_OXID;
+		fc_ABTS_s.d_id[2] = 0xFC;
+		lport->fabric.flags |= FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+		break;
+	default:
+		break;
+	}
+	pr_debug("%s %d\n", __func__, lport->fabric.state);
+
+	fnic2_send_fcoe_frame(lport, &fc_ABTS_s, sizeof(struct fc_hdr));
+	fdls_start_abort_timer(lport);
+}
+
+static void fdls_send_fabric_flogi(struct fnic2_lport *lport)
+{
+	struct fc_els flogi;
+
+	memcpy(&flogi, &fnic2_flogi_req, sizeof(struct fc_els));
+	flogi.nport_name = cpu_to_be64(lport->wwpn);
+	flogi.node_name = cpu_to_be64(lport->wwnn);
+	flogi.u.csp_flogi.b2b_rdf_size = htons(lport->mfs);
+	flogi.u.csp_flogi.r_a_tov = htonl(lport->r_a_tov);
+	flogi.u.csp_flogi.e_d_tov = htonl(lport->e_d_tov);
+
+	fnic2_send_fcoe_frame(lport, &flogi, sizeof(struct fc_els));
+	fdls_start_fabric_timer(lport);
+}
+
+static void fdls_send_fabric_plogi(struct fnic2_lport *lport)
+{
+	struct fc_els plogi;
+	struct fc_hdr *fchdr = &plogi.fchdr;
+	uint8_t fcid[3];
+
+	pr_debug("%s lport 0x%pK\n", __func__, lport);
+
+	memcpy(&plogi, &fnic2_plogi_req, sizeof(struct fc_els));
+
+	hton24(fcid, lport->fcid);
+
+	memcpy(fchdr->s_id, fcid, 3);
+	plogi.nport_name = cpu_to_be64(lport->wwpn);
+	plogi.node_name = cpu_to_be64(lport->wwnn);
+
+	fnic2_send_fcoe_frame(lport, &plogi, sizeof(struct fc_els));
+	fdls_start_fabric_timer(lport);
+}
+
+static void fdls_send_rpn_id(struct fnic2_lport *lport)
+{
+	struct fc_rpn_id rpn_id;
+	uint8_t fcid[3];
+
+	memcpy(&rpn_id, &fnic2_rpn_id_req, sizeof(struct fc_rpn_id));
+
+	hton24(fcid, lport->fcid);
+
+	memcpy(&rpn_id.fchdr.s_id, fcid, 3);
+	memcpy(rpn_id.port_id, fcid, 3);
+	rpn_id.port_name = cpu_to_be64(lport->wwpn);
+
+	fnic2_send_fcoe_frame(lport, &rpn_id, sizeof(struct fc_rpn_id));
+	fdls_start_fabric_timer(lport);
+}
+
+static void fdls_send_register_fc4_types(struct fnic2_lport *lport)
+{
+	struct fc_rft_id rft_id;
+	uint8_t fcid[3];
+
+	memcpy(&rft_id, &fnic2_rft_id_req, sizeof(struct fc_rft_id));
+
+	hton24(fcid, lport->fcid);
+
+	memcpy(&rft_id.fchdr.s_id, fcid, 3);
+	memcpy(rft_id.port_id, fcid, 3);
+	rft_id.fc4_types[2] = 1;
+	fnic2_send_fcoe_frame(lport, &rft_id, sizeof(struct fc_rft_id));
+	fdls_start_fabric_timer(lport);
+}
+
+static void fdls_send_register_fc4_features(struct fnic2_lport *lport)
+{
+	struct fc_rff_id rff_id;
+	uint8_t fcid[3];
+
+	memcpy(&rff_id, &fnic2_rff_id_req, sizeof(struct fc_rff_id));
+
+	hton24(fcid, lport->fcid);
+
+	memcpy(&rff_id.fchdr.s_id, fcid, 3);
+	memcpy(rff_id.port_id, fcid, 3);
+
+	fnic2_send_fcoe_frame(lport, &rff_id, sizeof(struct fc_rff_id));
+	fdls_start_fabric_timer(lport);
+}
+
+static void fdls_process_rpn_id_rsp(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fnic2_fdls_fabric *fdls = &lport->fabric;
+	struct fc_rpn_id *rpn_rsp = (struct fc_rpn_id *)fchdr;
+	struct fc_els_reject *els_rjt = (struct fc_els_reject *)fchdr;
+	uint16_t rsp;
+
+	rsp = rpn_rsp->fc_ct_hdr.command;
+	pr_debug("%s 0x%04x\n", __func__, (uint32_t)rsp);
+
+	switch (rsp) {
+	case FC_CT_ACC:
+		if (lport->fabric.timer_pending) {
+			pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+			del_timer_sync(&fdls->retry_timer);
+		}
+		lport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_send_register_fc4_types(lport);
+		fdls->state = FDLS_STATE_REGISTER_FC4_TYPES;
+		break;
+	case FC_LS_REJ:
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY) ||
+			(els_rjt->reason_code == FC_ELS_RJT_BUSY)) &&
+			(fdls->retry_counter < FDLS_RETRY_COUNT)) {
+
+			pr_debug("lport 0x%pK Rpn_id returned FC_LS_REJ BUSY retry from timer routine..\n", lport);
+
+		/*Retry again from the timer routine.*/
+			fdls->flags |= FNIC2_FDLS_RETRY_FRAME;
+		} else {
+			pr_debug("lport 0x%pK Rpn_id returned FC_LS_REJ...halting discovery.\n", lport);
+			if (fdls->timer_pending) {
+				pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+				del_timer_sync(&fdls->retry_timer);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void fdls_process_rft_id_rsp(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fnic2_fdls_fabric *fdls = &lport->fabric;
+	struct fc_rft_id *rft_rsp = (struct fc_rft_id *)fchdr;
+	struct fc_els_reject *els_rjt = (struct fc_els_reject *)fchdr;
+	uint16_t rsp;
+
+	rsp = rft_rsp->fc_ct_hdr.command;
+	pr_debug("%s 0x%04x\n", __func__, (uint32_t)rsp);
+
+	switch (rsp) {
+	case FC_CT_ACC:
+		if (lport->fabric.timer_pending) {
+			pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+			del_timer_sync(&fdls->retry_timer);
+		}
+		lport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls->state = FDLS_STATE_REGISTER_FC4_FEATURES;
+		break;
+	case FC_LS_REJ:
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY) ||
+			(els_rjt->reason_code == FC_ELS_RJT_BUSY)) &&
+			(fdls->retry_counter < FDLS_RETRY_COUNT)) {
+
+			pr_debug("lport 0x%pK rft_id returned FC_LS_REJ BUSY retry from timer routine..\n",
+				lport);
+
+			/*Retry again from the timer routine.*/
+			fdls->flags |= FNIC2_FDLS_RETRY_FRAME;
+		} else {
+			pr_debug("lport 0x%pK rft_id returned FC_LS_REJ...halting discovery.\n", lport);
+			if (fdls->timer_pending) {
+				pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+				del_timer_sync(&fdls->retry_timer);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void fdls_process_rff_id_rsp(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fnic2_fdls_fabric *fdls = &lport->fabric;
+	struct fc_rff_id *rff_rsp = (struct fc_rff_id *)fchdr;
+	struct fc_els_reject *els_rjt = (struct fc_els_reject *)fchdr;
+	uint16_t rsp;
+
+	rsp = rff_rsp->fc_ct_hdr.command;
+	pr_debug("%s 0x%04x\n", __func__, (uint32_t)rsp);
+
+	switch (rsp) {
+	case FC_CT_ACC:
+		if (lport->fabric.timer_pending) {
+			pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+			del_timer_sync(&fdls->retry_timer);
+		}
+		lport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		// we are done
+		fdls->state = FDLS_STATE_TGT_ONLINE;
+		break;
+	case FC_LS_REJ:
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY) ||
+			(els_rjt->reason_code == FC_ELS_RJT_BUSY)) &&
+			(fdls->retry_counter < FDLS_RETRY_COUNT)) {
+
+			pr_debug("lport 0x%pK rff_id returned FC_LS_REJ BUSY retry from timer routine..\n", lport);
+
+			/*Retry again from the timer routine.*/
+			fdls->flags |= FNIC2_FDLS_RETRY_FRAME;
+		} else {
+			pr_debug("lport 0x%pK rff_id returned FC_LS_REJ...halting discovery.\n",
+				lport);
+			if (fdls->timer_pending) {
+				pr_debug("lport 0x%pK Canceling fabric disc timer\n", lport);
+				del_timer_sync(&fdls->retry_timer);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void fdls_error_fabric_disc(struct fnic2_lport *lport)
+{
+	pr_debug("FDLS discovery error from %d state\n", lport->fabric.state);
+
+	/* TBD_REVISIT what to do */
+
+}
+
+void fdls_fabric_timer_callback(struct timer_list *timer)
+{
+	struct fnic2_fdls_fabric *fabric = container_of(timer, struct fnic2_fdls_fabric, retry_timer);
+	struct fnic2_lport *lport = container_of(fabric, struct fnic2_lport, fabric);
+
+	pr_debug("%s %d %d %d %d\n", __func__,
+		lport->fabric.timer_pending, lport->fabric.state,
+		lport->fabric.retry_counter, lport->max_flogi_retries);
+
+
+	/* TBD - do we need this? timeout while rx frame in the queue? */
+	if (!lport->fabric.timer_pending)
+		return;
+
+	lport->fabric.timer_pending = 0;
+
+	/*The fabric state indicates which frames have time out, and we retry*/
+	switch (lport->fabric.state) {
+	case FDLS_STATE_FABRIC_FLOGI:
+		// Flogi received a LS_RJT with busy we retry from here
+		if ((lport->fabric.flags & FNIC2_FDLS_RETRY_FRAME) &&
+		    (lport->fabric.retry_counter < lport->max_flogi_retries)) {
+			lport->fabric.flags &= ~FNIC2_FDLS_RETRY_FRAME;
+			fdls_send_fabric_flogi(lport);
+			return;
+		}
+		// Flogi has time out 2*ed_tov send abts
+		if (!(lport->fabric.flags & FNIC2_FDLS_FABRIC_ABORT_ISSUED)) {
+			fdls_send_fabric_abts(lport);
+		} else {
+			/* Flogi ABTS have timed out and we have waited
+			 * (2 * ra_tov), we can retry safely with same
+			 * exchange id
+			 */
+			if (lport->fabric.retry_counter <
+			    lport->max_flogi_retries) {
+				lport->fabric.flags &=
+				    ~FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+				fdls_send_fabric_flogi(lport);
+			} else {
+				fdls_error_fabric_disc(lport);
+			}
+		}
+		break;
+	case FDLS_STATE_FABRIC_PLOGI:
+		// Plogi received a LS_RJT with busy we retry from here
+		if ((lport->fabric.flags & FNIC2_FDLS_RETRY_FRAME) &&
+		    (lport->fabric.retry_counter < lport->max_plogi_retries)) {
+			lport->fabric.flags &= ~FNIC2_FDLS_RETRY_FRAME;
+			fdls_send_fabric_plogi(lport);
+			return;
+		}
+		// Plogi has time out 2*ed_tov send abts
+		if (!(lport->fabric.flags & FNIC2_FDLS_FABRIC_ABORT_ISSUED)) {
+			fdls_send_fabric_abts(lport);
+		} else {
+			/* plogi ABTS has timed out and we have waited
+			 * (2 * ra_tov) can retry safely with same
+			 * exchange id
+			 */
+			if (lport->fabric.retry_counter <
+			    lport->max_plogi_retries) {
+				lport->fabric.flags &=
+				    ~FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+				fdls_send_fabric_plogi(lport);
+			} else {
+				fdls_error_fabric_disc(lport);
+			}
+		}
+		break;
+	case FDLS_STATE_RPN_ID:
+		//Rpn_id received a LS_RJT with busy we retry from here
+		if ((lport->fabric.flags & FNIC2_FDLS_RETRY_FRAME) &&
+		    (lport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			lport->fabric.flags &= ~FNIC2_FDLS_RETRY_FRAME;
+			fdls_send_rpn_id(lport);
+			return;
+		}
+		// RPN have timed out send abts
+		if (!(lport->fabric.flags & FNIC2_FDLS_FABRIC_ABORT_ISSUED))
+			fdls_send_fabric_abts(lport);
+		else // ABTS has timed out (2*ra_tov)
+			fnic2_fdls_start_plogi(lport); //go back to fabric Plogi
+		break;
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		// Register FC4 types received a LS_RJT with busy we retry from
+		if ((lport->fabric.flags & FNIC2_FDLS_RETRY_FRAME) &&
+			(lport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			lport->fabric.flags &= ~FNIC2_FDLS_RETRY_FRAME;
+			fdls_send_register_fc4_types(lport);
+			return;
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		// Register FC4 features received a LS_RJT with busy we retry from here
+		if ((lport->fabric.flags & FNIC2_FDLS_RETRY_FRAME) &&
+			(lport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			lport->fabric.flags &= ~FNIC2_FDLS_RETRY_FRAME;
+			fdls_send_register_fc4_features(lport);
+			return;
+		}
+		// Register FC4 features have timed out send abts
+		if (!(lport->fabric.flags & FNIC2_FDLS_FABRIC_ABORT_ISSUED))
+			fdls_send_fabric_abts(lport);
+		else // ABTS has timed out (2*ra_tov)
+			fnic2_fdls_start_plogi(lport); //go back to fabric Plogi
+		break;
+	default:
+		break;
+	}
+}
+
+static void fnic2_fdls_start_flogi(struct fnic2_lport *lport)
+{
+	lport->fabric.retry_counter = 0;
+	fdls_send_fabric_flogi(lport);
+	lport->fabric.state = FDLS_STATE_FABRIC_FLOGI;
+	lport->fabric.flags = 0;
+}
+
+static void fnic2_fdls_start_plogi(struct fnic2_lport *lport)
+{
+	lport->fabric.retry_counter = 0;
+	fdls_send_fabric_plogi(lport);
+	lport->fabric.state = FDLS_STATE_FABRIC_PLOGI;
+	lport->fabric.flags &= ~FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+}
+
+static void fdls_process_fabric_abts_rsp(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	uint32_t s_id;
+	struct fc_abts_ba_acc *ba_acc = (struct fc_abts_ba_acc *)fchdr;
+	struct fc_abts_ba_rjt *ba_rjt;
+	uint32_t fabric_state = lport->fabric.state;
+
+	s_id = ntoh24(fchdr->s_id);
+	ba_rjt = (struct fc_abts_ba_rjt *)fchdr;
+
+	if (!((s_id == FC_DIR_SERVER) || (s_id == FC_DOMAIN_CONTR) ||
+		(s_id == FC_FABRIC_CONTROLLER))) {
+		pr_debug("fdls received abts_rsp with invalid SID %x.. dropping the frame.\n",
+			s_id);
+		return;
+	}
+
+	if (lport->fabric.timer_pending) {
+		pr_debug("lport 0x%pK Canceling fabric disc timer", lport);
+		del_timer_sync(&(lport->fabric.retry_timer));
+	}
+	lport->fabric.timer_pending = 0;
+	lport->fabric.flags &= ~FNIC2_FDLS_FABRIC_ABORT_ISSUED;
+
+	if (fchdr->r_ctl == FNIC2_BA_ACC_RCTL) {
+		pr_debug("fdls received abts_rsp BA_ACC for fabric_state %d ox_id %x\n",
+			fabric_state, ba_acc->ox_id);
+	} else if (fchdr->r_ctl == FNIC2_BA_RJT_RCTL) {
+		pr_debug("fdls received BA_RJT for fabric_state %d ox_id %x with reason code:%x reason code explanation:%x\n",
+			fabric_state, ba_rjt->fchdr.ox_id, ba_rjt->reason_code, ba_rjt->reason_explanation);
+	}
+
+	//currently error handling/retry logic is same for ABTS BA_ACC & BA_RJT
+	switch (fabric_state) {
+	case FDLS_STATE_FABRIC_FLOGI:
+		if (fchdr->ox_id == FNIC2_FLOGI_OXID) {
+			if (lport->fabric.retry_counter < lport->max_flogi_retries)
+				fdls_send_fabric_flogi(lport);
+			else
+				fdls_error_fabric_disc(lport);
+		} else {
+			pr_debug("fdls received unknown abts_rsp ox_id %x in FDLS_STATE_FABRIC_FLOGI state.. dropping the frame\n",
+				fchdr->ox_id);
+		}
+		break;
+
+	case FDLS_STATE_FABRIC_PLOGI:
+		if (fchdr->ox_id == FNIC2_PLOGI_FABRIC_OXID) {
+			if (lport->fabric.retry_counter < lport->max_plogi_retries)
+				fdls_send_fabric_plogi(lport);
+			else
+				fdls_error_fabric_disc(lport);
+		} else {
+			pr_debug("fdls received unknown abts_rsp ox_id %x in FDLS_STATE_FABRIC_PLOGI state.. dropping the frame\n",
+				fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_RPN_ID:
+		if (ba_acc->ox_id == FNIC2_RPN_REQ_OXID) {
+			if (lport->fabric.retry_counter < FDLS_RETRY_COUNT) {
+				fdls_send_rpn_id(lport);
+			} else {
+				//go back to fabric Plogi
+				fnic2_fdls_start_plogi(lport);
+			}
+		} else {
+			pr_debug("fdls received unknown abts_rsp ox_id %x in FDLS_STATE_RPN_ID state.. dropping the frame\n",
+				fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		if (ba_acc->ox_id == FNIC2_RFT_REQ_OXID) {
+			if (lport->fabric.retry_counter < FDLS_RETRY_COUNT) {
+				fdls_send_register_fc4_types(lport);
+			} else {
+				//go back to fabric Plogi
+				fnic2_fdls_start_plogi(lport);
+			}
+		} else {
+			pr_debug("fdls received unknown abts_rsp ox_id %x in FDLS_STATE_REGISTER_FC4_TYPES state.. dropping the frame\n",
+				fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		if (ba_acc->ox_id == FNIC2_RFF_REQ_OXID) {
+			if (lport->fabric.retry_counter < FDLS_RETRY_COUNT) {
+				fdls_send_register_fc4_features(lport);
+			} else {
+				//go back to fabric Plogi
+				fnic2_fdls_start_plogi(lport);
+			}
+		} else {
+			pr_debug("fdls received unknown abts_rsp ox_id %x in FDLS_STATE_REGISTER_FC4_FEATURES state.. dropping the frame\n",
+				fchdr->ox_id);
+		}
+		break;
+	default:
+		return;
+	}
+}
+
+static void fdls_process_plogi_req(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_els_reject   plogi_rej;
+	struct fc_els       plogi_acc;
+	struct fc_els       *plogi_req;
+	struct fnic2_rport   *rport;
+
+	uint16_t  rx_id;
+
+	if (lport->fcid != ntoh24(fchdr->d_id)) {
+		pr_debug("lport 0x%pK fdls received Plogi with illegal frame bits dropping..\n",
+			lport);
+		return;
+	}
+	pr_debug("%s from fcid:%x\n", __func__, ntoh24(fchdr->s_id));
+
+	if (fchdr->s_id[0] != 0xFF) {
+
+		plogi_req = (struct fc_els *) fchdr;
+		rport = fnic2_find_rport(lport, plogi_req->nport_name);
+
+		if (rport != NULL)
+			fdls_delete_rport(lport, rport);
+
+		pr_err("Allocating rport\n");
+
+		rport = fdls_create_rport(lport, ntoh24(fchdr->s_id),
+					 plogi_req->nport_name);
+
+		if (rport == NULL)
+			goto send_plogi_rej;
+
+		pr_err("New rport %pK\n", rport);
+
+		memcpy(&plogi_acc, &fnic2_plogi_resp, sizeof(struct fc_els));
+
+		memcpy(plogi_acc.fchdr.s_id, fchdr->d_id, 3);
+		memcpy(&plogi_acc.fchdr.d_id, fchdr->s_id, 3);
+
+		rx_id = htons(fdls_alloc_tgt_ox_id(FDLS_PLOGI_OXID_BASE));
+		if (rx_id == 0xFFFF) {
+			// Log and Err TBD
+
+			pr_debug("lport 0x%pK fdls_tgt_send_plogi_acc.. rx_id not available\n", lport);
+			return;
+		}
+		pr_debug("fdls_tgt_send_plogi_acc rx_id %x\n", ntohs(rx_id));
+
+		plogi_acc.fchdr.ox_id = fchdr->ox_id;
+		plogi_acc.fchdr.rx_id = rx_id;
+		plogi_acc.nport_name = cpu_to_be64(lport->wwpn);
+		plogi_acc.node_name = cpu_to_be64(lport->wwnn);
+
+		fnic2_send_fcoe_frame(lport, &plogi_acc, sizeof(struct fc_els));
+
+		// TBD should we run a timer ???
+		fdls_free_tgt_ox_id(ntohs(rx_id));
+
+	} else {
+send_plogi_rej:
+		memcpy(&plogi_rej, &fnic2_els_rjt,
+			sizeof(struct fc_els_reject));
+		plogi_rej.reason_code = 0x0B;
+		plogi_rej.reason_expl = 0x0;
+		plogi_rej.vendor_specific = 0x0;
+		memcpy(&plogi_rej.fchdr.s_id, fchdr->d_id, 3);
+		memcpy(&plogi_rej.fchdr.d_id, fchdr->s_id, 3);
+
+		rx_id = fchdr->ox_id;
+		plogi_rej.fchdr.rx_id = rx_id;
+		plogi_rej.fchdr.ox_id = fchdr->ox_id;
+
+		fnic2_send_fcoe_frame(lport, &plogi_rej,
+					sizeof(struct fc_els_reject));
+	}
+}
+
+static void fdls_send_rej(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_els_reject els_rej;
+
+	memcpy(&els_rej, &fnic2_els_rjt, sizeof(struct fc_els_reject));
+
+	memcpy(&els_rej.fchdr.s_id, fchdr->d_id, 3);
+	memcpy(&els_rej.fchdr.d_id, fchdr->s_id, 3);
+
+	els_rej.reason_code = 0x0B;
+	els_rej.fchdr.rx_id = 0xFFFF;
+	els_rej.fchdr.ox_id = fchdr->ox_id;
+
+	fnic2_send_fcoe_frame(lport, &els_rej, sizeof(struct fc_els_reject));
+}
+
+static void fdls_send_els_acc(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_els_acc els_acc;
+
+	memcpy(&els_acc, &fnic2_els_acc, sizeof(struct fc_els_acc));
+
+	memcpy(&els_acc.fchdr.s_id, fchdr->d_id, 3);
+	memcpy(&els_acc.fchdr.d_id, fchdr->s_id, 3);
+
+	els_acc.fchdr.rx_id = 0xFFFF;
+	els_acc.fchdr.ox_id = fchdr->ox_id;
+
+	fnic2_send_fcoe_frame(lport, &els_acc, sizeof(struct fc_els_acc));
+
+}
+
+void fdls_send_ba_acc(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_abts_ba_acc ba_acc;
+
+	memcpy(&ba_acc, &fnic2_ba_acc, sizeof(struct fc_abts_ba_acc));
+
+	memcpy(&ba_acc.fchdr.s_id, fchdr->d_id, 3);
+	memcpy(&ba_acc.fchdr.d_id, fchdr->s_id, 3);
+
+	ba_acc.fchdr.rx_id = fchdr->rx_id;
+	ba_acc.rx_id = ba_acc.fchdr.rx_id;
+	ba_acc.fchdr.ox_id = fchdr->ox_id;
+	ba_acc.ox_id = ba_acc.fchdr.ox_id;
+
+	fnic2_send_fcoe_frame(lport, &ba_acc, sizeof(struct fc_abts_ba_acc));
+
+}
+
+static void fdls_process_prli_req(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_els_prli  prli_acc;
+	struct fnic2_rport   *rport;
+	uint16_t  rx_id;
+
+	if (lport->fcid != ntoh24(fchdr->d_id)) {
+		pr_debug("lport 0x%pK fdls received PRLI to wrong d_id - dropping..\n", lport);
+		return;
+	}
+	pr_debug("%s from fcid:%x\n", __func__, ntoh24(fchdr->s_id));
+
+	rport = fnic2_find_rport_by_fcid(lport, ntoh24(fchdr->s_id));
+
+	pr_err("Found rport %pK\n", rport);
+
+	if (rport) {
+
+		rx_id = htons(fdls_alloc_tgt_ox_id(FDLS_PRLI_OXID_BASE));
+		if (rx_id == 0xFFFF) {
+			// Log and Err TBD
+
+			pr_debug("lport 0x%pK fdls_tgt_send_prli_acc.. rx_id not available\n", lport);
+			fdls_send_rej(lport, fchdr);
+			return;
+		}
+		if (!fnic2_session_create(lport->fnic2, rport)) {
+
+			memcpy(&prli_acc, &fnic2_prli_resp, sizeof(struct fc_els_prli));
+
+			memcpy(&prli_acc.fchdr.s_id, fchdr->d_id, 3);
+			memcpy(&prli_acc.fchdr.d_id, fchdr->s_id, 3);
+
+			pr_debug("fdls_tgt_send_prli_acc..rx_id %x\n", ntohs(rx_id));
+
+			prli_acc.fchdr.rx_id = rx_id;
+			prli_acc.fchdr.ox_id = fchdr->ox_id;
+
+			fnic2_send_fcoe_frame(lport, &prli_acc, sizeof(struct fc_els_prli));
+
+
+			// TBD should we run a timer ???
+			fdls_free_tgt_ox_id(ntohs(rx_id));
+		} else {
+			fdls_send_rej(lport, fchdr);
+		}
+	} else {
+		fdls_send_logout(lport, fchdr);
+	}
+}
+
+
+static void fdls_process_logo_req(struct fnic2_lport *lport, struct fc_hdr *fchdr)
+{
+	struct fc_logo_req *logo = (struct fc_logo_req *)fchdr;
+	uint32_t nport_id;
+	uint64_t nport_name;
+	struct fnic2_rport *rport;
+
+	nport_id = ntoh24(logo->fcid);
+	nport_name = logo->wwpn;
+
+	pr_debug("%s fcid: %x\n", __func__, nport_id);
+	rport = fnic2_find_rport_by_fcid(lport, nport_id);
+
+	if (!rport) {
+		/* We are not logged in with the nport, log and drop...*/
+		pr_debug("fdls recevied LOGO from an rport not logged in: %x\n",
+			nport_id);
+		return;
+	}
+	if (rport->fcid != nport_id) {
+		/* nport_id changed. TBD_REVISIT */
+		pr_debug("fdls recevied LOGO with invalid source port fcid: %x\n",
+			nport_id);
+		return;
+	}
+
+	fdls_delete_rport(lport, rport);
+	fdls_send_logo_resp(lport, &logo->fchdr);
+}
+
+/* Public Functions */
+
+void fnic2_fdls_disc_start(struct fnic2_lport *lport)
+{
+	if (!lport->usefip)
+		fnic2_fdls_start_flogi(lport);
+	else //review: plogi to name server
+		fnic2_fdls_start_plogi(lport);
+}
+
+/*
+ * Performs a validation for all FCOE frames and return the frame type
+ */
+static int fnic2_fdls_validate_and_get_frame_type(struct fnic2_lport *lport, void *rx_frame,
+	int len, int fchdr_offset)
+{
+	struct fc_hdr *fchdr;
+	uint8_t type;
+	uint8_t *fc_payload;
+	uint16_t ox_id;
+	uint32_t s_id;
+	uint32_t d_id;
+
+	struct fnic2_fdls_fabric *fabric = &lport->fabric;
+
+	fchdr = (struct fc_hdr *)((uint8_t *)rx_frame + fchdr_offset);
+	ox_id = fchdr->ox_id;
+	fc_payload = (uint8_t *)fchdr + sizeof(struct fc_hdr);
+	type = *fc_payload;
+
+	s_id = ntoh24(fchdr->s_id);
+	d_id = ntoh24(fchdr->d_id);
+
+	//some common validation
+	if (lport->fcid)
+		if (fabric->state > FDLS_STATE_FABRIC_FLOGI) {
+			if ((lport->fcid != d_id) ||
+				(fchdr->cs_ctl != FNIC2_FC_CS_CTL)) {
+				pr_debug("Invalid frame received with DID %x IPortfcid %x fabric state %x R_CTL %x type %x OX_ID %x  RX_ID %x CS_CTL %x Dropping\n",
+					d_id, lport->fcid, fabric->state,
+					fchdr->r_ctl, fchdr->type, fchdr->ox_id,
+					fchdr->rx_id, fchdr->cs_ctl);
+				return -1;
+			}
+		}
+
+	// ABTS response
+	if ((fchdr->r_ctl == FNIC2_BA_ACC_RCTL) ||
+		(fchdr->r_ctl == FNIC2_BA_RJT_RCTL)) {
+		if (fchdr->type != FNIC2_FC_TYPE_BLS) {
+			pr_debug("fdls recevied ABTS with some Invalid frame bits S_ID %x FCTL %x R_CTL %x type %x. Dropping the frame\n",
+				s_id, ntoh24(fchdr->f_ctl), fchdr->r_ctl, fchdr->type);
+			return -1;
+
+		}
+		return FNIC2_BLS_ABTS_RSP;
+	}
+
+	//unsolicited requests frames
+	if (fchdr->r_ctl == FNIC2_R_CTL_UNSOLICITED) {
+		switch (type) {
+		case FC_ELS_LOGO:
+			if ((fchdr->f_ctl[0] != FNIC2_F_CTL_FIRST_LAST_SEQ_INIT) ||
+			    (fchdr->type != FNIC2_FC_TYPE_ELS)) {
+				pr_debug("fdls recevied LOGO with some Invalid frame bits S_ID %x FCTL %x R_CTL %x type %x. Dropping the frame\n",
+					s_id, ntoh24(fchdr->f_ctl), fchdr->r_ctl,
+					fchdr->type);
+				return -1;
+			}
+			return FNIC2_ELS_LOGO_REQ;
+		case FC_ELS_PLOGI_REQ:
+			return FNIC2_ELS_PLOGI_REQ;
+		case FC_ELS_PRLI_REQ:
+			return FNIC2_ELS_PRLI_REQ;
+		case FC_ELS_RTV_REQ:
+			return FNIC2_ELS_RTV_REQ;
+		case FC_ELS_RRQ_REQ:
+			return FNIC2_ELS_RRQ_REQ;
+		default:
+			pr_debug("fdls_recv_frame unsupported frame: %d\n", type);
+			return -1;
+		}
+	}
+
+	// Only responses for requests we sent
+	if (fchdr->f_ctl[0] & FNIC2_F_CTL_EXCH_RESPONDER) {
+
+		if (ntohs(ox_id) == FNIC2_LOGO_REQ_OXID)
+			return FNIC2_TPORT_LOGO_RSP;
+
+		/*response from fabric*/
+		switch (ox_id) {
+		case FNIC2_FLOGI_OXID:
+		if (type == FC_LS_ACC) {
+			if ((fchdr->f_ctl[0] != FNIC2_F_CTL_LAST_END_SEQ) ||
+				(fchdr->r_ctl != FNIC2_R_CTL_SOLICITED_CTRL_REPLY) ||
+				(s_id != FC_DOMAIN_CONTR) ||
+				(fchdr->type != FNIC2_FC_TYPE_ELS)) {
+				pr_debug("fdls recevied Flogi resp with some Invalid frame bits s_id %x FCTL %x R_CTL %x type %x. Dropping the frame.\n",
+					s_id, ntoh24(fchdr->f_ctl),
+					fchdr->r_ctl, fchdr->type);
+				return -1;
+			}
+		}
+		return FNIC2_FABRIC_FLOGI_RSP;
+
+		case FNIC2_PLOGI_FABRIC_OXID:
+		if (type == FC_LS_ACC) {
+			if ((fchdr->f_ctl[0] != FNIC2_F_CTL_LAST_END_SEQ) ||
+				(fchdr->r_ctl != FNIC2_R_CTL_SOLICITED_CTRL_REPLY) ||
+				(s_id != FC_DIR_SERVER) ||
+				(fchdr->type != FNIC2_FC_TYPE_ELS)) {
+				pr_debug("fdls recevied Plogi resp with some Invalid frame bits s_id %x FCTL %x R_CTL %x type %x. Dropping the frame.\n",
+					s_id, ntoh24(fchdr->f_ctl),
+					fchdr->r_ctl, fchdr->type);
+				return -1;
+			}
+		}
+		return FNIC2_FABRIC_PLOGI_RSP;
+
+		case FNIC2_RPN_REQ_OXID:
+		if (type == FC_LS_ACC) {
+			if ((fchdr->f_ctl[0] != FNIC2_F_CTL_LAST_END_SEQ) ||
+				(fchdr->r_ctl != FNIC2_R_CTL_SCTL) ||
+				(s_id != FC_DIR_SERVER) ||
+				(fchdr->type != FNIC2_FC_TYPE_FC_GS))  {
+				pr_debug("fdls recevied rpn_id_rsp with some Invalid frame bits s_id %x FCTL %x R_CTL %x type %x. Dropping the frame.\n",
+					s_id, ntoh24(fchdr->f_ctl),
+					fchdr->r_ctl, fchdr->type);
+				return -1;
+			}
+		}
+		return FNIC2_FABRIC_RPN_RSP;
+		case FNIC2_RFT_REQ_OXID:
+		if (type == FC_LS_ACC) {
+			if ((fchdr->f_ctl[0] != FNIC2_F_CTL_LAST_END_SEQ) ||
+				(fchdr->r_ctl != FNIC2_R_CTL_SCTL) ||
+				(s_id != FC_DIR_SERVER) ||
+				(fchdr->type != FNIC2_FC_TYPE_FC_GS))  {
+				pr_debug("fdls recevied rft_id_rsp with some Invalid frame bits s_id %x FCTL %x R_CTL %x type %x. Dropping the frame.\n",
+					s_id, ntoh24(fchdr->f_ctl),
+					fchdr->r_ctl, fchdr->type);
+				return -1;
+			}
+		}
+		return FNIC2_FABRIC_RFT_RSP;
+		case FNIC2_RFF_REQ_OXID:
+		if (type == FC_LS_ACC) {
+			if ((fchdr->f_ctl[0] != FNIC2_F_CTL_LAST_END_SEQ) ||
+				(fchdr->r_ctl != FNIC2_R_CTL_SCTL) ||
+				(s_id != FC_DIR_SERVER) ||
+				(fchdr->type != FNIC2_FC_TYPE_FC_GS))  {
+				pr_debug("fdls recevied rff_id_rsp with some Invalid frame bits s_id %x FCTL %x R_CTL %x type%x. Dropping the frame.\n",
+					s_id, ntoh24(fchdr->f_ctl),
+					fchdr->r_ctl, fchdr->type);
+				return -1;
+			}
+		}
+		return FNIC2_FABRIC_RFF_RSP;
+		default:
+		/* Drop the Rx frame and log/stats it */
+		pr_debug("fdls_recv_frame Solicited response Unknown ox_id: %x\n", ox_id);
+		return -1;
+		}
+	}
+	return -1;
+}
+
+void fnic2_fdls_recv_frame(struct fnic2_lport *lport, void *rx_frame, int len,
+	int fchdr_offset)
+{
+	uint16_t ox_id;
+	struct fc_hdr *fchdr;
+	uint32_t s_id = 0;
+	uint32_t d_id = 0;
+	char *frame_data = rx_frame;
+
+	int frame_type;
+
+	fchdr = (struct fc_hdr *)((uint8_t *)(frame_data + fchdr_offset));
+
+	s_id = ntoh24(fchdr->s_id);
+	d_id = ntoh24(fchdr->d_id);
+	pr_debug("fdls_recv_frame received frame of len %x with SID %x DID %x R_CTL %x F_CTL %x OX_ID %x RX_ID %x seq_id %x seq_cnt %x type %x offset %d\n",
+		len, s_id, d_id, fchdr->r_ctl, ntoh24(fchdr->f_ctl),
+		ntohs(fchdr->ox_id), fchdr->rx_id, fchdr->seq_id, fchdr->seq_cnt,
+		fchdr->type, fchdr_offset);
+
+	frame_type = fnic2_fdls_validate_and_get_frame_type(lport, frame_data,
+	    len, fchdr_offset);
+
+	switch (frame_type) {
+
+	case FNIC2_FABRIC_FLOGI_RSP:
+		fdls_process_flogi_rsp(lport, fchdr, frame_data);
+		break;
+
+	case FNIC2_FABRIC_PLOGI_RSP:
+		fdls_process_fabric_plogi_rsp(lport, fchdr);
+		break;
+	case FNIC2_FABRIC_RPN_RSP:
+		fdls_process_rpn_id_rsp(lport, fchdr);
+		break;
+	case FNIC2_FABRIC_RFT_RSP:
+		fdls_process_rft_id_rsp(lport, fchdr);
+		break;
+	case FNIC2_FABRIC_RFF_RSP:
+		fdls_process_rff_id_rsp(lport, fchdr);
+		break;
+	case FNIC2_BLS_ABTS_RSP:
+		ox_id = fchdr->ox_id;
+		if ((lport->fabric.flags & FNIC2_FDLS_FABRIC_ABORT_ISSUED) &&
+			(ox_id >= FNIC2_FLOGI_OXID && ox_id <= FNIC2_RFF_REQ_OXID)) {
+			fdls_process_fabric_abts_rsp(lport, fchdr);
+		}
+		break;
+
+	case FNIC2_ELS_PLOGI_REQ:
+		fdls_process_plogi_req(lport, fchdr);
+		break;
+	case FNIC2_ELS_PRLI_REQ:
+		fdls_process_prli_req(lport, fchdr);
+	break;
+	case FNIC2_ELS_RTV_REQ:
+		fdls_send_rej(lport, fchdr);
+		break;
+	case FNIC2_ELS_RRQ_REQ:
+		fdls_send_els_acc(lport, fchdr);
+		break;
+	case FNIC2_ELS_LOGO_REQ:
+		fdls_process_logo_req(lport, fchdr);
+		break;
+	default:
+		// pr_debug("Received unknown FCoE frame of len: %d. dropping.\n", len);
+		break;
+	}
+}
+
+void fnic2_fdls_disc_init(struct fnic2_lport *lport)
+{
+	fdls_init_tgt_ox_id_pool();
+	lport->fabric.state = FDLS_STATE_INIT;
+}
+
+void fnic2_fdls_link_down(struct fnic2_lport *lport)
+{
+	struct fnic2_rport *rport, *next;
+
+	pr_debug("%s lport 0x%pK\n", __func__, lport);
+
+	lport->fabric.state = FDLS_STATE_LINKDOWN;
+	lport->fabric.flags = 0;
+
+	fnic2_scsi_fcpio_reset(lport);
+
+	fdls_init_tgt_ox_id_pool();
+
+	list_for_each_entry_safe(rport, next, &lport->rport_list, links)   {
+		pr_debug("removing rport: %x", rport->fcid);
+		if (rport->state != fdls_rport_state_offlining)
+			fdls_delete_rport(lport, rport);
+	}
+
+	pr_debug("%s lport 0x%pK\n", __func__, lport);
+}
+
+struct fnic2_rport *fdls_create_rport(struct fnic2_lport *lport, uint32_t fcid, uint64_t wwpn)
+{
+	struct fnic2_rport rport;
+
+	pr_debug("%s fcid:%x, wwpn: %llx\n", __func__, fcid, wwpn);
+
+	memset(&rport, 0, sizeof(struct fnic2_rport));
+
+	rport.fcid = fcid;
+	rport.wwpn = wwpn;
+
+	rport.lport = lport;
+
+	rport.state = fdls_rport_state_plogi;
+	return fnic2_fdls_add_rport(lport, &rport);
+}
+
+void fdls_delete_rport(struct fnic2_lport *lport, struct fnic2_rport *rport)
+{
+	struct fnic2_sess *sess;
+	struct se_session *se_sess;
+
+	if (rport->state == fdls_rport_state_offlining)
+		return;
+	rport->state = fdls_rport_state_offlining;
+	// remove session, cleanup LIO
+	sess = fnic2_find_session(lport->fnic2, rport->wwpn);
+	if (sess) {
+		if ((try_to_del_timer_sync(&sess->sess_timer)) < 0)
+			pr_err("Failed to delete session %pK\n", sess);
+		se_sess = sess->se_sess;
+		target_sess_cmd_list_set_waiting(se_sess);
+		target_wait_for_sess_cmds(se_sess);
+
+		transport_deregister_session_configfs(se_sess);
+		transport_deregister_session(se_sess);
+		sess->se_sess = NULL;
+		list_del(&sess->list);
+		lport->fnic2->lio.sess_count--;
+		kfree(sess);
+	}
+	fnic2_fdls_remove_rport(lport, rport);
+}
+
+void fnic2_fdls_remove_rport(struct fnic2_lport *lport, struct fnic2_rport *rport)
+{
+	list_del(&rport->links);
+	kfree(rport);
+}
+
+
+struct fnic2_rport *fnic2_fdls_add_rport(struct fnic2_lport *lport, struct fnic2_rport *rport)
+{
+	struct fnic2_rport *new_rport;
+
+	new_rport = kmalloc(sizeof(struct fnic2_rport), GFP_ATOMIC);
+	if (new_rport == NULL)
+		return NULL;
+	pr_debug("created rport rport: %pK\n", new_rport);
+	memcpy(new_rport, rport, sizeof(struct fnic2_rport));
+
+	list_add_tail(&new_rport->links, &lport->rport_list);
+
+	return new_rport;
+}
+
+struct fnic2_rport *fnic2_find_rport(struct fnic2_lport *lport, uint64_t wwpn)
+{
+	struct fnic2_rport *rport;
+	struct list_head *init;
+
+	list_for_each(init, &lport->rport_list) {
+
+	rport =  list_entry(init, struct fnic2_rport, links);
+	if (rport->wwpn == wwpn)
+		return rport;
+	}
+	return NULL;
+}
+
+struct fnic2_rport *fnic2_find_rport_by_fcid(struct fnic2_lport *lport, uint32_t fcid)
+{
+	struct fnic2_rport *rport;
+	struct list_head *init;
+
+	list_for_each(init, &lport->rport_list) {
+
+		rport =  list_entry(init, struct fnic2_rport, links);
+		if (rport->fcid == fcid)
+			return rport;
+	}
+	return NULL;
+}
diff --git a/drivers/staging/fnic2/src/fdls_fc.h b/drivers/staging/fnic2/src/fdls_fc.h
new file mode 100644
index 0000000..2da1e4e
--- /dev/null
+++ b/drivers/staging/fnic2/src/fdls_fc.h
@@ -0,0 +1,403 @@
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
+#ifndef _FDLS_FC_H_
+#define _FDLS_FC_H_
+
+#include <scsi/scsi.h>
+#include "vnic_wq_copy.h"
+
+/* This file contains the declarations for FC fabric services */
+
+enum fcp_sp {
+	FNIC2_FCP_SP_RD_XRDY_DIS	= 0x00000002,
+	FNIC2_FCP_SP_INITIATOR		= 0x00000020,
+	FNIC2_FCP_SP_CONF_CMPL		= 0x00000080,
+	FNIC2_FCP_SP_RETRY		= 0x00000100
+};
+
+#ifdef _BIG_ENDIAN
+
+enum be_ox_id {
+	FNIC2_FLOGI_OXID	= 0x1001,
+	FNIC2_PLOGI_FABRIC_OXID	= 0x1002,
+	FNIC2_RPN_REQ_OXID	= 0x1003,
+	FNIC2_RFT_REQ_OXID	= 0x1004,
+	FNIC2_RFF_REQ_OXID	= 0x1005,
+	FNIC2_LOGO_REQ_OXID	= 0x1007,
+	FNIC2_LOGO_RESP_OXID	= 0x1008
+}
+
+enum be_f_ctl {
+	FNIC2_ELS_REQ_FCTL	= 0x290000,
+	FNIC2_ELS_REP_FCTL	= 0x980000,
+	FNIC2_FCP_RSP_FCTL	= 0x990000
+};
+
+#define FNIC2_FC_PH_VER         (0x2020)
+#define FNIC2_FC_B2B_CREDIT     (0x000A)
+#define FNIC2_FC_B2B_RDF_SZ     (0x0800)
+
+#define FNIC2_REQ_ABTS_FCTL     (0x090000)
+
+#define FNIC2_FC_CONCUR_SEQS    (0x00FF)
+
+#define FNIC2_FC_RO_INFO        (0x001F)
+#define FNIC2_E_D_TOV           (0x07D0)
+
+enum be_fc_ct {
+	FC_CT_RPN_CMD	= 0x0212,
+	FC_CT_RFT_CMD	= 0x0217,
+	FC_CT_RFT_CMD	= 0x021F,
+	FC_CT_ACC	= 0x8002
+};
+
+#else //_LITTLE_ENDIAN
+
+enum le_ox_id {
+	FNIC2_FLOGI_OXID	= 0x0110,
+	FNIC2_PLOGI_FABRIC_OXID	= 0x0210,
+	FNIC2_RPN_REQ_OXID	= 0x0310,
+	FNIC2_RFT_REQ_OXID	= 0x0410,
+	FNIC2_RFF_REQ_OXID	= 0x0510,
+	FNIC2_LOGO_REQ_OXID	= 0x0710,
+	FNIC2_LOGO_RESP_OXID	= 0x0810
+};
+
+enum le_f_ctl {
+	FNIC2_ELS_REQ_FCTL	= 0x000029,
+	FNIC2_ELS_REP_FCTL	= 0x000098,
+	FNIC2_FCP_RSP_FCTL	= 0x000099
+};
+
+#define FNIC2_REQ_ABTS_FCTL     (0x000009)
+
+#define FNIC2_FC_PH_VER         (0x2020)
+#define FNIC2_FC_B2B_CREDIT     (0x0A00)
+#define FNIC2_FC_B2B_RDF_SZ     (0x0008)
+
+#define FNIC2_FC_CONCUR_SEQS    (0xFF00)
+#define FNIC2_FC_RO_INFO        (0x1F00)
+#define FNIC2_E_D_TOV           (0xD0070000)
+
+enum le_fc_ct {
+	FC_CT_ACC       = 0x0280,
+	FC_CT_RPN_CMD	= 0x1202,
+	FC_CT_RFT_CMD	= 0x1702,
+	FC_CT_RFF_CMD	= 0x1F02
+};
+
+#endif /* Big Endian */
+
+enum fc_well_known_addr {
+	FC_DIR_SERVER		= 0xFFFFFC,
+	FC_FABRIC_CONTROLLER	= 0xFFFFFD,
+	FC_DOMAIN_CONTR		= 0xFFFFFE
+};
+
+#define FC_LS_REJ               0x01
+#define FC_LS_ACC               0x02
+
+enum fc_els_command {
+	FC_ELS_PLOGI_REQ        = 0x03,
+	FC_ELS_FLOGI_REQ	= 0x04,
+	FC_ELS_LOGO             = 0x05,
+        FC_ELS_RJT_LOGICAL_BUSY = 0x05,
+	FC_ELS_RJT_BUSY         = 0x09,
+	FC_ELS_RTV_REQ		= 0x0E,
+	FC_ELS_RRQ_REQ		= 0x12,
+	FC_ELS_PRLI_REQ		= 0x20
+};
+
+#define FNIC2_FCOE_EOF         (0x42)
+
+#define FNIC2_FCOE_MAX_FRAME_SZ  (2048)
+#define FNIC2_FCOE_MIN_FRAME_SZ  (280)
+
+enum fc_r_ctl {
+	FNIC2_R_CTL_SCTL			= 0x03,
+	FC_R_CTL_FC4_CMD			= 0x06,
+	FC_R_CTL_FC4_STATUS			= 0x07,
+	FNIC2_R_CTL_UNSOLICITED			= 0x22,
+	FNIC2_R_CTL_SOLICITED_CTRL_REPLY	= 0x23,
+	FNIC2_FC_R_CTL_ABTS			= 0x81,
+	FNIC2_BA_ACC_RCTL			= 0x84,
+	FNIC2_BA_RJT_RCTL			= 0x85
+};
+
+enum fc_f_ctl {
+	FNIC2_F_CTL_FIRST_LAST_SEQ_INIT	= 0x29,
+	FNIC2_F_CTL_EXCH_RESPONDER	= 0x80,
+	FNIC2_F_CTL_LAST_END_SEQ        = 0x98
+};
+
+enum fc_type {
+	FNIC2_FC_TYPE_BLS	= 0x00,
+	FNIC2_FC_TYPE_ELS	= 0x01,
+	FNIC2_FC_TYPE_FC_GS	= 0x20
+};
+
+#define FNIC2_FC_CS_CTL				0x00
+
+#define FNIC2_FC_C3_RDF         (0xfff)
+
+#define FCP_RSP_FLAG_OVERFLOW   (1 << 2)
+#define FCP_RSP_FLAG_UNDERFLOW  (1 << 3)
+
+#define FNIC2_FC_EDTOV_NSEC    (0x400)
+#define FNIC2_NSEC_TO_MSEC     (0x1000000)
+
+#define FNIC2_FCOE_FCHDR_OFFSET \
+    (sizeof(struct fnic2_eth_hdr) + sizeof(struct fnic2_fcoe_hdr))
+
+enum fc_cmnd_req {
+        FC_CMND_REQ_NONE        = 0x00,
+        FC_CMND_REQ_WR          = 0x01,
+        FC_CMND_REQ_RD          = 0x02
+};
+
+#define FC_CMND_ADDL_CDB_LEN(_val)      \
+        ((_val & 0xFC) >> 2)
+
+#define FC_CMND_TASK_ATTR       (0x03)
+
+enum fc_ta {
+        FC_TA_SIMPLE_TAG        = 0x0,
+        FC_TA_HEAD_OF_QUEUE     = 0x1,
+        FC_TA_ORDERED           = 0x2,
+        FC_TA_ACA               = 0x4
+};
+
+/* Frame header */
+
+struct fnic2_eth_hdr {
+	uint8_t		dst_mac[6];
+	uint8_t		src_mac[6];
+	uint16_t	ether_type;
+} __attribute__((__packed__));
+
+struct fnic2_fcoe_hdr {
+	uint8_t	ver;
+	uint8_t	rsvd[12];
+	uint8_t	sof;
+} __attribute__((__packed__));
+
+/* Big Endian */
+struct fc_hdr {
+	uint8_t 	r_ctl;
+	uint8_t 	d_id[3];
+
+	uint8_t		cs_ctl;
+	uint8_t		s_id[3];
+
+	uint8_t		type;
+	uint8_t		f_ctl[3];
+
+	uint8_t		seq_id;
+	uint8_t		df_ctl;
+	uint16_t	seq_cnt;
+
+	uint16_t	ox_id;
+	uint16_t	rx_id;
+
+	uint32_t	param;
+} __attribute__((__packed__));
+
+struct fc_csp_flogi {
+	uint16_t	fc_ph_ver;
+	uint16_t	b2b_credits;
+
+	uint16_t	features;
+	uint16_t	b2b_rdf_size;
+
+	uint32_t	r_a_tov;
+	uint32_t	e_d_tov;
+} __attribute__((__packed__));
+
+struct fc_csp_plogi {
+	uint16_t	fc_ph_ver;
+	uint16_t	b2b_credits;
+
+	uint16_t	features;
+	uint16_t	b2b_rdf_size;
+
+	uint16_t	total_concur_seqs;
+	uint16_t	ro_info;
+
+	uint32_t	e_d_tov;
+} __attribute__((__packed__));
+
+// Revisit the correctness of union(though its same size now)
+struct fc_els {
+	struct	fc_hdr fchdr;
+	uint8_t			command;
+	uint8_t			rsvd[3];
+
+	union {
+		struct fc_csp_flogi csp_flogi;
+		struct fc_csp_plogi csp_plogi;
+	} u;
+
+	uint64_t		nport_name;
+	uint64_t		node_name;
+
+	uint8_t			spc1[16];
+	uint8_t			spc2[16];
+	uint8_t			spc3[16];
+	uint8_t			spc4[16];
+
+	uint8_t  vendor_ver_level[16];
+} __attribute__((__packed__));
+
+struct fc_els_acc {
+	struct fc_hdr	fchdr;
+	uint8_t			command;
+	uint8_t 		rsvd[3];
+} __attribute__((__packed__));
+
+struct fc_els_reject {
+	struct fc_hdr   fchdr;
+	uint32_t		command;
+	uint8_t			reserved;
+	uint8_t			reason_code;
+	uint8_t			reason_expl;
+	uint8_t			vendor_specific;
+} __attribute__((__packed__));
+
+struct fc_abts_ba_acc {
+	struct fc_hdr	fchdr;
+	uint8_t			seq_id_validity;
+	uint8_t			seq_id;
+	uint16_t		reserved;
+	uint16_t		ox_id;
+	uint16_t		rx_id;
+	uint16_t		low_seq_cnt;
+	uint16_t		high_seq_cnt;
+
+} __attribute__((__packed__));
+
+struct fc_abts_ba_rjt {
+	struct fc_hdr	fchdr;
+	uint8_t			vend_uniq;
+	uint8_t			reason_explanation;
+	uint8_t			reason_code;
+	uint8_t			reserved;
+
+} __attribute__((__packed__));
+
+struct fc_prli_sp {
+	uint8_t		type;
+	uint8_t		type_ext;
+	uint16_t	flags;
+
+	uint32_t	ox_proc_assoc;
+	uint32_t	rx_proc_assoc;
+	uint32_t	csp;
+} __attribute__((__packed__));
+
+struct fc_els_prli {
+	struct fc_hdr	fchdr;
+	uint8_t			command;
+	uint8_t			page_len;
+	uint16_t		payload_len;
+	struct fc_prli_sp 	sp;
+} __attribute__((__packed__));
+
+struct fc_ct_hdr {
+	uint32_t	rev: 8;
+	uint32_t	in_id: 24;
+
+	uint8_t		fs_type;
+	uint8_t		fs_subtype;
+	uint8_t		options;
+	uint8_t		rsvd;
+
+	uint16_t	command;
+	uint16_t	max_res_size;
+
+	uint8_t		rsvd1;
+	uint8_t		reason_code;
+	uint8_t		reason_expl;
+	uint8_t		vendor_specific;
+} __attribute__((__packed__));
+
+struct fc_rpn_id {
+	struct fc_hdr	fchdr;
+	struct fc_ct_hdr	fc_ct_hdr;
+
+	uint8_t			rsvd;
+	uint8_t			port_id[3];
+
+	uint64_t		port_name;
+} __attribute__((__packed__));
+
+struct fc_rft_id {
+	struct fc_hdr	fchdr;
+	struct fc_ct_hdr	fc_ct_hdr;
+
+	uint8_t			rsvd;
+	uint8_t			port_id[3];
+	uint8_t			fc4_types[64];
+} __attribute__((__packed__));
+
+struct fc_rff_id {
+	struct fc_hdr	fchdr;
+	struct fc_ct_hdr	fc_ct_hdr;
+
+	uint8_t			rsvd;
+	uint8_t			port_id[3];
+	uint8_t			rsvd1;
+	uint8_t			rsvd2;
+	uint8_t			tgt;
+	uint8_t			fc4_type;
+} __attribute__((__packed__));
+
+struct fc_logo_req {
+	struct fc_hdr	fchdr;
+	uint8_t			command;
+	uint8_t			rsvd[3];
+
+	uint8_t			rsvd1;
+	uint8_t			fcid[3];
+
+	uint64_t		wwpn;
+}  __attribute__((__packed__));
+
+struct fc_fcp_cmnd {
+	struct fc_hdr	fchdr;
+	struct scsi_lun		fcp_lun;
+	uint8_t			cmd_ref;
+	uint8_t			pri_ta;
+	uint8_t			tm_flags;
+	uint8_t			add_cdblen_flags;
+	uint8_t			cdb[16];
+	uint32_t		dl;
+} __attribute__((__packed__));
+
+struct fc_fcp_rsp {
+	struct fc_hdr	fchdr;
+	uint8_t			rsvd[8];
+	uint16_t		retry_delay_tmr;	/* TBD this vs status_qual? */
+	uint8_t			flags;
+	uint8_t			scsi_status;
+	uint32_t		resid;
+	uint32_t		sense_len;
+	uint32_t		rsp_len;
+} __attribute__((__packed__));
+
+#endif /* _FDLS_FC_H */
diff --git a/drivers/staging/fnic2/src/fdls_if.c b/drivers/staging/fnic2/src/fdls_if.c
new file mode 100644
index 0000000..bd095f8
--- /dev/null
+++ b/drivers/staging/fnic2/src/fdls_if.c
@@ -0,0 +1,1254 @@
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
+#include "fnic2.h"
+#include "fnic2_res.h"
+#include "cq_enet_desc.h"
+#include "cq_exch_desc.h"
+#include "fdls_fc.h"
+#include "fnic2_fdls.h"
+
+static int fnic2_fcpio_cmpl_handler(struct vnic_dev *vdev,
+				    unsigned int cq_index,
+				    struct fcpio_fw_req *desc);
+static int fnic2_fcpio_fw_reset_cmpl_handler(struct fnic2 *fnic2, struct fcpio_fw_req *desc);
+
+const char *fnic2_state_str[] = {
+	[FNIC2_IN_FC_MODE] = "FNIC2_IN_FC_MODE",
+	[FNIC2_IN_FC_TRANS_ETH_MODE] = "FNIC2_IN_FC_TRANS_ETH_MODE",
+	[FNIC2_IN_ETH_MODE] = "FNIC2_IN_ETH_MODE",
+	[FNIC2_IN_ETH_TRANS_FC_MODE] = "FNIC2_IN_ETH_TRANS_FC_MODE",
+};
+
+static const char *fcpio_status_str[] =  {
+	[FCPIO_SUCCESS] = "FCPIO_SUCCESS", /*0x0*/
+	[FCPIO_INVALID_HEADER] = "FCPIO_INVALID_HEADER",
+	[FCPIO_OUT_OF_RESOURCE] = "FCPIO_OUT_OF_RESOURCE",
+	[FCPIO_INVALID_PARAM] = "FCPIO_INVALID_PARAM]",
+	[FCPIO_REQ_NOT_SUPPORTED] = "FCPIO_REQ_NOT_SUPPORTED",
+	[FCPIO_IO_NOT_FOUND] = "FCPIO_IO_NOT_FOUND",
+	[FCPIO_ABORTED] = "FCPIO_ABORTED", /*0x41*/
+	[FCPIO_TIMEOUT] = "FCPIO_TIMEOUT",
+	[FCPIO_SGL_INVALID] = "FCPIO_SGL_INVALID",
+	[FCPIO_MSS_INVALID] = "FCPIO_MSS_INVALID",
+	[FCPIO_DATA_CNT_MISMATCH] = "FCPIO_DATA_CNT_MISMATCH",
+	[FCPIO_FW_ERR] = "FCPIO_FW_ERR",
+	[FCPIO_ITMF_REJECTED] = "FCPIO_ITMF_REJECTED",
+	[FCPIO_ITMF_FAILED] = "FCPIO_ITMF_FAILED",
+	[FCPIO_ITMF_INCORRECT_LUN] = "FCPIO_ITMF_INCORRECT_LUN",
+	[FCPIO_CMND_REJECTED] = "FCPIO_CMND_REJECTED",
+	[FCPIO_NO_PATH_AVAIL] = "FCPIO_NO_PATH_AVAIL",
+	[FCPIO_PATH_FAILED] = "FCPIO_PATH_FAILED",
+	[FCPIO_LUNMAP_CHNG_PEND] = "FCPIO_LUNHMAP_CHNG_PEND",
+};
+
+static const char *fnic2_fcpio_status_to_str(unsigned int status)
+{
+    if (status >= ARRAY_SIZE(fcpio_status_str) || !fcpio_status_str[status])
+	return "unknown";
+
+    return fcpio_status_str[status];
+}
+
+const char *fnic2_state_to_str(unsigned int state)
+{
+    if (state >= ARRAY_SIZE(fnic2_state_str) || !fnic2_state_str[state])
+	return "unknown";
+
+    return fnic2_state_str[state];
+}
+
+/* Frame initialization */
+/*
+ * Variables:
+ * dst_mac, src_mac
+ */
+struct fnic2_eth_hdr fnic2_eth_hdr_fcoe = {
+	.ether_type = 0x0689
+};
+
+/*
+ * Variables:
+ * None
+ */
+struct fnic2_fcoe_hdr fnic2_fcoe_hdr = {
+	.sof = 0x2E
+};
+
+uint8_t fcoe_all_fcf_mac[6] = {0x0e, 0xfc, 0x00, 0xff, 0xff, 0xfe};
+
+struct workqueue_struct *fnic2_event_queue;
+struct workqueue_struct *fip_event_queue;
+
+/* external */
+extern int fnic2_fw_reset_handler(struct fnic2 *fnic2);
+extern void fnic2_fcpio_tcmd_cmpl_handler(struct work_struct *work);
+extern void fnic2_fcp_recv(struct fnic2 *fnic2, uint8_t *fp, int frame_len);
+extern struct fnic2_cmd *fnic2_find_tcmd(struct fnic2 *fnic2, uint32_t cmd_tag);
+
+static inline int fnic2_import_rq_eth_pkt(struct fnic2 *fnic2, void *fp);
+
+/*
+ * Internal Functions
+ * This function will initialize the src_mac address to be
+ * used in outgoing frames
+ */
+static inline void fnic2_fdls_set_fcoe_srcmac(struct fnic2 *fnic2, uint8_t *src_mac)
+{
+	pr_debug("setting src_mac %02x, %02x, %02x, %02x, %02x, %02x\n",
+		src_mac[0], src_mac[1], src_mac[2],
+		src_mac[3], src_mac[4], src_mac[5]);
+
+	memcpy(fnic2->lport.fpma, src_mac, 6);
+}
+
+
+/*
+ * This function will initialize the dst_mac address to be
+ * used in outgoing frames
+ */
+static inline void fnic2_fdls_set_fcoe_dstmac(struct fnic2 *fnic2, uint8_t *dst_mac)
+{
+	pr_debug("setting dst_mac %02x, %02x, %02x, %02x, %02x, %02x\n",
+		dst_mac[0], dst_mac[1], dst_mac[2],
+		dst_mac[3], dst_mac[4], dst_mac[5]);
+
+	memcpy(fnic2->lport.fcfmac, dst_mac, 6);
+}
+
+static void fnic2_fdls_link_status_change(struct fnic2 *fnic2, int linkup)
+{
+	struct fnic2_lport *lport = &fnic2->lport;
+
+	pr_debug("fnic2 %d: fdls_link_status_change linkup: %d, usefip: %d\n",
+		fnic2->fnic2_num, linkup, lport->usefip);
+
+	if (linkup) {
+	    if (lport->usefip) {
+		lport->state = FNIC2_IPORT_STATE_FIP;
+		fnic2_fcoe_send_vlan_req(fnic2);
+	     } else {
+		lport->state = FNIC2_IPORT_STATE_FABRIC_DISC;
+		fnic2_fdls_disc_start(lport);
+	    }
+	} else {
+	    lport->state = FNIC2_IPORT_STATE_LINK_WAIT;
+	    vnic_dev_del_addr(fnic2->vdev, lport->fpma);
+	    fnic2_common_fip_cleanup(fnic2);
+	    fnic2_fdls_link_down(lport);
+	}
+}
+
+/*
+ * fnic2_fcpio_flogi_reg_cmpl_handler
+ * Routine to handle flogi register completion
+ */
+static int fnic2_fcpio_flogi_reg_cmpl_handler(struct fnic2 *fnic2, struct fcpio_fw_req *desc)
+{
+	uint8_t type;
+	uint8_t hdr_status;
+	uint32_t fcpio_tag;
+	int ret = 0;
+	unsigned long flags;
+
+	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &fcpio_tag);
+
+	/* Update fnic2 state based on status of flogi reg completion */
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+
+	if (fnic2->state == FNIC2_IN_ETH_TRANS_FC_MODE) {
+
+		/* Check flogi registration completion status */
+		if (!hdr_status) {
+			pr_debug("flog reg succeeded\n");
+			fnic2->state = FNIC2_IN_FC_MODE;
+		} else {
+			pr_debug("fnic2 flogi reg: failed %s\n",
+				fnic2_fcpio_status_to_str(hdr_status));
+			fnic2->state = FNIC2_IN_ETH_MODE;
+			ret = -1;
+		}
+	} else {
+		pr_debug("Unexpected fnic2 state %s while processing flogi reg completion\n",
+			fnic2_state_to_str(fnic2->state));
+		ret = -1;
+	}
+
+	if (!ret) {
+		if (fnic2->stop_rx_link_events) {
+			spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+			goto reg_cmpl_handler_end;
+		}
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		fnic2_flush_tx(fnic2);
+		queue_work(fnic2_event_queue, &fnic2->frame_work);
+	} else {
+	    spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+	}
+
+reg_cmpl_handler_end:
+	return ret;
+}
+
+/*
+ * FPMA can be either taken from ethhdr(dst_mac) or flogi resp
+ * or derive from FC_MAP and FCID combination. While it should be
+ * same, revisit this if there is any possibility of not-correct.
+ */
+void fnic2_fdls_learn_fcoe_macs(struct fnic2_lport *lport, void *rx_frame, uint8_t *fcid)
+{
+	struct fnic2 *fnic2 = lport->fnic2;
+	struct fnic2_eth_hdr *ethhdr = (struct fnic2_eth_hdr *)rx_frame;
+	uint8_t fcmac[6] = {0x0E, 0xFC, 0x00, 0x00, 0x00, 0x00};
+
+	memcpy(&fcmac[3], fcid, 3);
+
+	pr_debug("learn_fcoe - dst_mac:%02x %02x %02x %02x %02x %02x\n",
+		ethhdr->dst_mac[0],  ethhdr->dst_mac[1],  ethhdr->dst_mac[2],
+		ethhdr->dst_mac[3],  ethhdr->dst_mac[4],  ethhdr->dst_mac[5]);
+
+	pr_debug("learn_fcoe - fc_mac:%02x %02x %02x %02x %02x %02x\n",
+		fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4], fcmac[5]);
+
+	fnic2_fdls_set_fcoe_srcmac(fnic2, fcmac);
+	fnic2_fdls_set_fcoe_dstmac(fnic2, ethhdr->src_mac);
+}
+
+
+/* Public Functions */
+void fnic2_fdls_init(struct fnic2 *fnic2, int usefip)
+{
+	struct fnic2_lport *lport = &fnic2->lport;
+	uint8_t dstmac[6] = {0x0e, 0xfc, 0x00, 0xff, 0xff, 0xfe};
+
+	/* Initialize iPort structure */
+	lport->state = FNIC2_IPORT_STATE_INIT;
+	lport->fnic2 = fnic2;
+	lport->usefip = usefip;
+
+	/* Send the FCPIO_RESET to the firmware */
+	fnic2_scsi_fcpio_reset(lport);
+
+	pr_debug("lportsrcmac:%02x %02x %02x %02x %02x %02x\n",
+		lport->hwmac[0], lport->hwmac[1], lport->hwmac[2],
+		lport->hwmac[3], lport->hwmac[4], lport->hwmac[5]);
+
+	/* Initialize the src, and dst mac addresses for frame sender */
+	fnic2_fdls_set_fcoe_srcmac(fnic2, lport->hwmac);
+	fnic2_fdls_set_fcoe_dstmac(fnic2, dstmac);
+
+	fnic2_fdls_disc_init(lport);
+}
+
+/* At this time, should be called only during driver unload */
+void fnic2_fdls_cleanup(struct fnic2 *fnic2)
+{
+    pr_debug("fnic2 0x%pK Entered fnic2_fdls_cleanup\n", fnic2);
+
+}
+
+void fnic2_handle_link(struct work_struct *work)
+{
+	struct fnic2 *fnic2 = container_of(work, struct fnic2, link_work);
+	int old_link_status;
+	uint32_t old_link_down_cnt;
+	unsigned long flags;
+
+	pr_info("started fnic2_handle_link\n");
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (fnic2->stop_rx_link_events) {
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		pr_debug("fnic2 0x%pK Stop RX link event", fnic2);
+		return;
+	 }
+
+	old_link_down_cnt = fnic2->link_down_cnt;
+	old_link_status = fnic2->link_status;
+	fnic2->link_status = vnic_dev_link_status(fnic2->vdev);
+	fnic2->link_down_cnt = vnic_dev_link_down_cnt(fnic2->vdev);
+
+	pr_debug("link status %d down cnt %d",
+		(int)fnic2->link_status, (int)fnic2->link_down_cnt);
+	pr_debug("old status %d old down cnt %d",
+		(int)old_link_status, old_link_down_cnt);
+
+	if (old_link_status == fnic2->link_status) {
+		if (!fnic2->link_status) {
+			/* DOWN -> DOWN */
+			spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		} else {
+			if (old_link_down_cnt != fnic2->link_down_cnt) {
+				/* UP -> DOWN -> UP */
+				spin_unlock_irqrestore(&fnic2->fnic2_lock,
+							flags);
+				pr_debug("fnic2 %d: link down",
+					fnic2->fnic2_num);
+				fnic2_fdls_link_status_change(fnic2, 0);
+
+				pr_debug("fnic2 %d: link up",
+					 fnic2->fnic2_num);
+				fnic2_fdls_link_status_change(fnic2, 1);
+
+			} else {
+				/* UP -> UP */
+				spin_unlock_irqrestore(&fnic2->fnic2_lock,
+							 flags);
+			}
+		}
+	 } else if (fnic2->link_status) {
+		/* DOWN -> UP */
+
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		pr_debug("fnic2 %d: link up", fnic2->fnic2_num);
+		fnic2_fdls_link_status_change(fnic2, 1);
+
+	 } else {
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		pr_debug("fnic2 %d: recvd up to down event", fnic2->fnic2_num);
+		/* UP -> DOWN */
+		fnic2_fdls_link_status_change(fnic2, 0);
+	}
+}
+
+void fnic2_handle_frame(struct work_struct *work)
+{
+	struct fnic2_frame_list *cur_frame, *next;
+	unsigned long flags;
+	struct fnic2 *fnic2 = container_of(work, struct fnic2, frame_work);
+	int fchdr_offset = 0;
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	list_for_each_entry_safe(cur_frame, next, &fnic2->frame_queue, links) {
+		if (fnic2->stop_rx_link_events) {
+			list_del(&cur_frame->links);
+			spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+			kfree(cur_frame->fp);
+			kfree(cur_frame);
+			return;
+		}
+
+		/*
+		 * If we're in a transitional state, just re-queue and return.
+		 * The queue will be serviced when we get to a stable state.
+		 */
+		if (fnic2->state != FNIC2_IN_FC_MODE &&
+		    fnic2->state != FNIC2_IN_ETH_MODE) {
+			spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+			return;
+		}
+
+		list_del(&cur_frame->links);
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		/* Frames from FCP_RQ will have ethhdrs stripped off */
+		fchdr_offset = (cur_frame->rx_ethhdr_stripped) ? 0 : FNIC2_FCOE_FCHDR_OFFSET;
+		fnic2_fdls_recv_frame(&fnic2->lport, cur_frame->fp,
+			cur_frame->frame_len, fchdr_offset);
+
+		kfree(cur_frame->fp);
+		kfree(cur_frame);
+		spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+}
+
+
+/* Process FIP frames */
+void fnic2_handle_fip_frame(struct work_struct *work)
+{
+	unsigned long flags;
+	struct fnic2_frame_list *cur_frame, *next;
+	struct fnic2 *fnic2 = container_of(work, struct fnic2, fip_work);
+
+	pr_debug("fnic2 0x%pK starting fnic2_handle_fip_frame\n", fnic2);
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	list_for_each_entry_safe(cur_frame, next, &fnic2->fip_frame_queue, links) {
+		pr_debug("fnic2 0x%pK got fip frame\n", fnic2);
+
+		if (fnic2->stop_rx_link_events) {
+		list_del(&cur_frame->links);
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		kfree(cur_frame->fp);
+		kfree(cur_frame);
+		return;
+		}
+
+		/*
+		 * If we're in a transitional state, just re-queue and return.
+		 * The queue will be serviced when we get to a stable state.
+		 */
+		if (fnic2->state != FNIC2_IN_FC_MODE &&
+		    fnic2->state != FNIC2_IN_ETH_MODE) {
+			spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+			return;
+		}
+
+		list_del(&cur_frame->links);
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		if (fdls_fip_recv_frame(fnic2, cur_frame->fp)) {
+			pr_debug("fnic2 0x%pK fip frame processed\n", fnic2);
+			kfree(cur_frame->fp);
+			kfree(cur_frame);
+		}
+		spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+}
+
+/**
+ * fnic2_import_rq_eth_pkt() - handle received FCoE or FIP frame.
+ * @fnic2:        fnic2 instance.
+ * @skb:        Ethernet Frame.
+ */
+static int fnic2_import_rq_eth_pkt(struct fnic2 *fnic2, void *fp)
+{
+	struct ethhdr *eh;
+	struct fnic2_frame_list *fip_fr_elem;
+
+	pr_debug("fnic2 0x%pK fnic2_import_rq_eth_pkt\n", fnic2);
+	eh = (struct ethhdr *) fp;
+	if (eh->h_proto ==  htons(0x8914)) {
+		pr_debug("fnic2 0x%pK fip frame enqueued\n", fnic2);
+		fip_fr_elem = (struct fnic2_frame_list *)
+		kmalloc(sizeof(struct fnic2_frame_list), __GFP_NOFAIL);
+		memset(fip_fr_elem, 0, sizeof(struct fnic2_frame_list));
+		fip_fr_elem->fp = fp;
+		list_add_tail(&fip_fr_elem->links, &fnic2->fip_frame_queue);
+		INIT_WORK(&fnic2->fip_work, fnic2_handle_fip_frame);
+		queue_work(fip_event_queue, &fnic2->fip_work);
+
+		return 1;               /* let caller know packet was used */
+	} else {
+		return 0;
+	}
+}
+
+static void fnic2_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc *cq_desc, struct vnic_rq_buf *buf, int skipped)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(rq->vdev);
+	uint8_t *fp;
+	unsigned int ethhdr_stripped;
+	uint8_t type, color, eop, sop, ingress_port, vlan_stripped;
+	uint8_t fcoe_fnic2_crc_ok = 1, fcoe_enc_error = 0;
+	uint8_t fcs_ok = 1, packet_error = 0;
+	uint16_t q_number, completed_index, vlan;
+	uint32_t rss_hash;
+	uint16_t checksum;
+	uint8_t csum_not_calc, rss_type, ipv4, ipv6, ipv4_fragment;
+	uint8_t tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
+	uint8_t fcoe = 0, fcoe_sof, fcoe_eof;
+	uint16_t exchange_id, tmpl;
+	uint8_t sof = 0;
+	uint8_t eof = 0;
+	uint32_t fcp_bytes_written = 0;
+	uint16_t enet_bytes_written = 0;
+	uint32_t bytes_written = 0;
+	unsigned long flags;
+	struct fnic2_frame_list *frame_elem = NULL;
+	struct fc_hdr *fchdr;
+	uint8_t fcp4_frame = 0;
+
+	pci_unmap_single(fnic2->pdev, buf->dma_addr, buf->len,
+		     PCI_DMA_FROMDEVICE);
+	fp = (uint8_t *)buf->os_buf;
+	buf->os_buf = NULL;
+
+	cq_desc_dec(cq_desc, &type, &color, &q_number, &completed_index);
+	if (type == CQ_DESC_TYPE_RQ_FCP) {
+		cq_fcp_rq_desc_dec((struct cq_fcp_rq_desc *)cq_desc,
+				   &type, &color, &q_number, &completed_index,
+				   &eop, &sop, &fcoe_fnic2_crc_ok, &exchange_id,
+				   &tmpl, &fcp_bytes_written, &sof, &eof,
+				   &ingress_port, &packet_error,
+				   &fcoe_enc_error, &fcs_ok, &vlan_stripped,
+				   &vlan);
+		ethhdr_stripped = 1;
+		bytes_written = fcp_bytes_written;
+
+		fchdr = (struct fc_hdr *)fp;
+		if (fchdr->r_ctl == FC_R_CTL_FC4_CMD ||
+		    fchdr->r_ctl == FNIC2_FC_R_CTL_ABTS ||
+		    fchdr->r_ctl == FC_R_CTL_FC4_STATUS) {
+			fcp4_frame = 1;
+		}
+
+		pr_debug("recvd FCP frame. rctl %x sz: %d, fcp4: %d\n", fchdr->r_ctl, fcp_bytes_written, fcp4_frame);
+	} else if (type == CQ_DESC_TYPE_RQ_ENET) {
+		cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc,
+				    &type, &color, &q_number, &completed_index,
+				    &ingress_port, &fcoe, &eop, &sop,
+				    &rss_type, &csum_not_calc, &rss_hash,
+				    &enet_bytes_written, &packet_error,
+				    &vlan_stripped, &vlan, &checksum,
+				    &fcoe_sof, &fcoe_fnic2_crc_ok,
+				    &fcoe_enc_error, &fcoe_eof,
+				    &tcp_udp_csum_ok, &udp, &tcp,
+				    &ipv4_csum_ok, &ipv6, &ipv4,
+				    &ipv4_fragment, &fcs_ok);
+
+		ethhdr_stripped = 0;
+		bytes_written = enet_bytes_written;
+
+		pr_debug("recvd ENET frame. sz: %d\n",
+			enet_bytes_written);
+
+		if (!fcs_ok) {
+			pr_debug("fnic2 0x%pK fcs error.  dropping packet.\n", fnic2);
+			goto drop;
+		}
+
+		if (fnic2_import_rq_eth_pkt(fnic2, fp)) {
+			return;
+	       }
+	} else {
+		/* wrong CQ type*/
+		pr_debug("fnic2 rq_cmpl wrong cq type 0x%x\n", type);
+		goto drop;
+	}
+
+	if (!fcs_ok || packet_error || !fcoe_fnic2_crc_ok || fcoe_enc_error) {
+		pr_debug("fnic2 rq_cmpl fcoe 0x%x fcsok 0x%x pkterr 0x%x fcoe_fnic2_crc_ok 0x%x, fcoe_enc_err 0x%x\n", fcoe, fcs_ok, packet_error,
+			fcoe_fnic2_crc_ok, fcoe_enc_error);
+		goto drop;
+	}
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (fnic2->stop_rx_link_events) {
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		pr_debug("fnic2->stop_rx_link_events %x\n",
+		fnic2->stop_rx_link_events);
+		goto drop;
+	}
+
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	if (fcp4_frame) {
+		fnic2_fcp_recv(fnic2, fp, bytes_written);
+	} else {
+
+		frame_elem = (struct fnic2_frame_list *)
+			kmalloc(sizeof(struct fnic2_frame_list), __GFP_NOFAIL);
+		memset(frame_elem, 0, sizeof(struct fnic2_frame_list));
+		frame_elem->fp = fp;
+		frame_elem->rx_ethhdr_stripped = ethhdr_stripped;
+		frame_elem->frame_len = bytes_written;
+
+		spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+		list_add_tail(&frame_elem->links, &fnic2->frame_queue);
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		queue_work(fnic2_event_queue, &fnic2->frame_work);
+	}
+	return;
+drop:
+	kfree(fp);
+}
+
+static int fnic2_rq_cmpl_handler_cont(struct vnic_dev *vdev, struct cq_desc *cq_desc, uint8_t type, uint16_t q_number, uint16_t completed_index)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(vdev);
+
+	vnic_rq_service(&fnic2->rq[q_number], cq_desc, completed_index,
+		VNIC_RQ_RETURN_DESC, fnic2_rq_cmpl_frame_recv);
+	return 0;
+}
+
+static inline int is_ack_index_in_range(struct vnic_wq_copy *wq, uint16_t request_out)
+{
+	if (wq->to_clean_index <= wq->to_use_index) {
+		/* out of range, stale request_out index */
+		if (request_out < wq->to_clean_index ||
+		    request_out >= wq->to_use_index)
+			return 0;
+	} else {
+		/* out of range, stale request_out index */
+		if (request_out < wq->to_clean_index &&
+		    request_out >= wq->to_use_index)
+			return 0;
+	}
+	/* request_out index is in range */
+	return 1;
+}
+
+
+/*
+ * Mark that ack received and store the Ack index. If there are multiple
+ * acks received before Tx thread cleans it up, the latest value will be
+ * used which is correct behavior. This state should be in the copy Wq
+ * instead of in the fnic2
+ */
+static inline void fnic2_fcpio_ack_handler(struct fnic2 *fnic2, unsigned int cq_index, struct fcpio_fw_req *desc)
+{
+	struct vnic_wq_copy *wq;
+	uint16_t request_out = desc->u.ack.request_out;
+	unsigned long flags;
+
+	/* mark the ack state */
+	wq = &fnic2->wq_copy[cq_index - fnic2->raw_wq_count - fnic2->rq_count];
+	spin_lock_irqsave(&fnic2->wq_copy_lock[0], flags);
+
+	if (is_ack_index_in_range(wq, request_out)) {
+		fnic2->fw_ack_index[0] = request_out;
+		fnic2->fw_ack_recd[0] = 1;
+	}
+
+	spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+}
+
+
+/* Free up Copy Wq descriptors. Called with copy_wq lock held */
+int free_wq_copy_descs(struct fnic2 *fnic2, struct vnic_wq_copy *wq)
+{
+	/* if no Ack received from firmware, then nothing to clean */
+	if (!fnic2->fw_ack_recd[0])
+		return 1;
+
+	/*
+	 * Update desc_available count based on number of freed descriptors
+	 * Account for wraparound
+	 */
+	if (wq->to_clean_index <= fnic2->fw_ack_index[0])
+		wq->ring.desc_avail += (fnic2->fw_ack_index[0]
+		    - wq->to_clean_index + 1);
+	else
+		wq->ring.desc_avail += (wq->ring.desc_count
+		    - wq->to_clean_index + fnic2->fw_ack_index[0] + 1);
+
+	/*
+	 * just bump clean index to ack_index+1 accounting for wraparound
+	 * this will essentially free up all descriptors between
+	 * to_clean_index and fw_ack_index, both inclusive
+	 */
+	wq->to_clean_index =
+		(fnic2->fw_ack_index[0] + 1) % wq->ring.desc_count;
+
+	/* we have processed the acks received so far */
+	fnic2->fw_ack_recd[0] = 0;
+	return 0;
+}
+
+
+/*
+ * fnic2_flogi_reg_handler
+ * Routine to send flogi register msg to fw
+ */
+static int fnic2_flogi_reg_handler(struct fnic2 *fnic2, uint32_t fnic2_id)
+{
+	struct vnic_wq_copy *wq = &fnic2->wq_copy[0];
+	enum fcpio_flogi_reg_format_type format;
+	uint8_t gw_mac[ETH_ALEN];
+	int ret = 0;
+
+
+	if (vnic_wq_copy_desc_avail(wq) <= fnic2->wq_copy_desc_low[0])
+		free_wq_copy_descs(fnic2, wq);
+
+	if (!vnic_wq_copy_desc_avail(wq)) {
+		ret = -1;
+		goto flogi_reg_ioreq_end;
+	}
+
+	memcpy(gw_mac, fnic2->lport.fcfmac, ETH_ALEN);
+	format = FCPIO_FLOGI_REG_GW_DEST;
+
+	if (fnic2->config.flags & VFCF_FIP_CAPABLE) {
+		fnic2_queue_wq_copy_desc_fip_reg(wq, SCSI_NO_TAG, fnic2_id,
+		    gw_mac, fnic2->lport.fpma, fnic2->lport.r_a_tov,
+		    fnic2->lport.e_d_tov);
+		pr_info("FLOGI FIP reg issued fcid %x src %pK dest %pK\n",
+			fnic2_id, fnic2->data_src_addr, gw_mac);
+	} else {
+		fnic2_queue_wq_copy_desc_flogi_reg(wq, SCSI_NO_TAG,
+		    format, fnic2_id, gw_mac);
+		pr_info("FLOGI reg issued fcid %x gw_mac %x %x %x %x %x %x",
+			fnic2_id, gw_mac[0], gw_mac[1],
+			gw_mac[2], gw_mac[3], gw_mac[4], gw_mac[5]);
+	}
+
+flogi_reg_ioreq_end:
+	return ret;
+}
+
+int fnic2_rq_cmpl_handler(struct fnic2 *fnic2, int rq_work_to_do)
+{
+	unsigned int tot_rq_work_done = 0, cur_work_done;
+	unsigned int i;
+
+	for (i = 0; i < fnic2->rq_count; i++) {
+		cur_work_done = vnic_cq_service(&fnic2->cq[i], rq_work_to_do,
+		    fnic2_rq_cmpl_handler_cont);
+		if (cur_work_done && fnic2->stop_rx_link_events != 1) {
+			vnic_rq_fill(&fnic2->rq[i], fnic2_alloc_rq_frame);
+		}
+		tot_rq_work_done += cur_work_done;
+	}
+	return tot_rq_work_done;
+}
+
+/*
+ * This function is called once at init time to allocate and fill RQ
+ * buffers. Subsequently, it is called in the interrupt context after RQ
+ * buffer processing to replenish the buffers in the RQ
+ */
+int fnic2_alloc_rq_frame(struct vnic_rq *rq)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(rq->vdev);
+	void *buf;
+	uint16_t len;
+	dma_addr_t pa;
+
+	len = FNIC2_RQ_FRAME_LEN;
+	buf = kmalloc(len, __GFP_NORETRY);
+	if (!buf) {
+		pr_debug("Unable to allocate RQ sk_buff\n");
+		return -ENOMEM;
+	}
+
+	pa = pci_map_single(fnic2->pdev, buf, len, PCI_DMA_FROMDEVICE);
+	fnic2_queue_rq_desc(rq, buf, pa, len);
+	return 0;
+}
+
+
+void fnic2_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
+{
+	void *rq_buf = buf->os_buf;
+	struct fnic2 *fnic2 = vnic_dev_priv(rq->vdev);
+
+	pci_unmap_single(fnic2->pdev, buf->dma_addr, buf->len,
+	PCI_DMA_FROMDEVICE);
+
+	kfree(rq_buf);
+	buf->os_buf = NULL;
+}
+
+static void fnic2_wq_complete_frame_send(struct vnic_wq *wq, struct cq_desc *cq_desc, struct vnic_wq_buf *buf)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(wq->vdev);
+
+	pci_unmap_single(fnic2->pdev, buf->dma_addr,
+	buf->len, PCI_DMA_TODEVICE);
+	kfree(buf->os_buf);
+	buf->os_buf = NULL;
+}
+
+
+static int fnic2_wq_cmpl_handler_cont(struct vnic_dev *vdev, struct cq_desc *cq_desc, uint8_t type, uint16_t q_number, uint16_t completed_index)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(vdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic2->wq_lock[q_number], flags);
+	vnic_wq_service(&fnic2->wq[q_number], cq_desc, completed_index,
+			fnic2_wq_complete_frame_send);
+	spin_unlock_irqrestore(&fnic2->wq_lock[q_number], flags);
+
+	return 0;
+}
+
+int fnic2_wq_cmpl_handler(struct fnic2 *fnic2, int work_to_do)
+{
+	unsigned int wq_work_done = 0;
+	unsigned int i;
+
+	for (i = 0; i < fnic2->raw_wq_count; i++) {
+		wq_work_done += vnic_cq_service(&fnic2->cq[fnic2->rq_count+i],
+		    work_to_do, fnic2_wq_cmpl_handler_cont);
+	}
+
+	return wq_work_done;
+}
+
+
+void fnic2_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(wq->vdev);
+
+	pci_unmap_single(fnic2->pdev, buf->dma_addr,
+			 buf->len, PCI_DMA_TODEVICE);
+
+	kfree(buf->os_buf);
+	buf->os_buf = NULL;
+}
+
+/*
+ * Send FC frame.
+ */
+int fnic2_send_frame(struct fnic2 *fnic2, void *frame, int frame_len)
+{
+	struct vnic_wq *wq = &fnic2->wq[0];
+	dma_addr_t pa;
+	int ret = 0;
+	unsigned long flags;
+
+	pa = pci_map_single(fnic2->pdev, frame, frame_len, PCI_DMA_TODEVICE);
+
+	spin_lock_irqsave(&fnic2->wq_lock[0], flags);
+
+	if (!vnic_wq_desc_avail(wq)) {
+		pci_unmap_single(fnic2->pdev, pa,
+			frame_len, PCI_DMA_TODEVICE);
+		pr_err("vnic work queue descriptor is not available");
+		ret = -1;
+		goto fnic2_send_frame_end;
+	}
+
+	fnic2_queue_wq_desc(wq, frame, pa, frame_len, FNIC2_FCOE_EOF,
+		0 /* hw inserts cos value */,
+		fnic2->vlan_id, 1, 1, 1);
+
+fnic2_send_frame_end:
+	spin_unlock_irqrestore(&fnic2->wq_lock[0], flags);
+
+	if (ret) {
+		// TBD free buffer
+	}
+
+	return ret;
+}
+
+int fdls_send_fcoe_frame(struct fnic2 *fnic2, void *payload, int payload_sz, uint8_t *srcmac, uint8_t *dstmac)
+{
+	uint8_t *frame;
+	struct fnic2_eth_hdr *ethhdr;
+	struct fnic2_frame_list *frame_elem;
+	int max_framesz = FNIC2_FCOE_FRAME_MAXSZ;
+	unsigned long flags;
+	int len = 0;
+	int ret;
+
+	frame = (uint8_t *) kmalloc(max_framesz, __GFP_NORETRY);
+	if (!frame) {
+		pr_debug("fnic2 0x%pK Failed to allocate frame for flogi\n", fnic2);
+		return -1;
+	}
+	memset(frame, 0, max_framesz);
+
+	ethhdr = (struct fnic2_eth_hdr *)frame;
+
+	memcpy(frame, (uint8_t *)&fnic2_eth_hdr_fcoe, sizeof(struct fnic2_eth_hdr));
+	len = sizeof(struct fnic2_eth_hdr);
+
+	memcpy(ethhdr->src_mac, srcmac, ETH_ALEN);
+	memcpy(ethhdr->dst_mac, dstmac, ETH_ALEN);
+
+	memcpy(frame + len, (uint8_t *)&fnic2_fcoe_hdr, sizeof(struct fnic2_fcoe_hdr));
+	len += sizeof(struct fnic2_fcoe_hdr);
+
+	memcpy(frame + len, (uint8_t *)payload, payload_sz);
+	len += payload_sz;
+
+	//review: Handle this with the state in fdls for reg_done, and remove
+	//this logic
+	/*
+	 * Queue frame if in a transitional state.
+	 * This occurs while registering the Port_ID / MAC address after FLOGI.
+	 */
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+
+	if ((fnic2->state != FNIC2_IN_FC_MODE) &&
+	    (fnic2->state != FNIC2_IN_ETH_MODE)) {
+		frame_elem = kmalloc(sizeof(struct fnic2_frame_list), __GFP_NORETRY);
+		if (frame_elem == NULL) {
+			spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+			return -ENOMEM;
+		}
+		memset(frame_elem, 0, sizeof(struct fnic2_frame_list));
+
+		pr_debug("Queueing frame: %pK\n", frame);
+
+		frame_elem->fp = frame;
+		frame_elem->frame_len = len;
+		list_add_tail(&frame_elem->links, &fnic2->tx_queue);
+
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	ret = fnic2_send_frame(fnic2, frame, len);
+	return ret;
+}
+
+int fdls_send_fip_frame(struct fnic2 *fnic2, void *payload, int payload_sz)
+{
+	uint8_t *frame;
+	int max_framesz = FNIC2_FCOE_FRAME_MAXSZ;
+	int ret;
+
+	frame = (uint8_t *) kmalloc(max_framesz, __GFP_NORETRY);
+	if (!frame) {
+		pr_debug("fnic2 0x%pK Failed to allocate fip frame\n", fnic2);
+		return -1;
+	}
+	memset(frame, 0, max_framesz);
+
+	memcpy(frame, (uint8_t *)payload, payload_sz);
+	ret = fnic2_send_frame(fnic2, frame, payload_sz);
+
+	return ret;
+}
+
+int fnic2_send_fcoe_frame(struct fnic2_lport *lport, void *payload, int payload_sz)
+{
+	struct fnic2 *fnic2 = lport->fnic2;
+	uint8_t *dstmac, *srcmac;
+	int ret = 0;
+
+	/* If module unload is in-progress, don't send */
+	if (fnic2->in_remove)
+		return -1;
+
+	if (lport->fabric.flags & FNIC2_FDLS_FPMA_LEARNT) {
+		srcmac = lport->fpma;
+		dstmac = lport->fcfmac;
+	} else {
+		srcmac = lport->hwmac;
+		dstmac = fcoe_all_fcf_mac;
+	}
+
+	ret = fdls_send_fcoe_frame(fnic2, payload, payload_sz, srcmac, dstmac);
+
+	return ret;
+}
+
+int fnic2_send_fip_frame(struct fnic2_lport *lport, void *payload, int payload_sz)
+{
+    struct fnic2 *fnic2 = lport->fnic2;
+
+    if (fnic2->in_remove) {
+	return -1;
+    }
+
+    return fdls_send_fip_frame(fnic2, payload, payload_sz);
+}
+
+/**
+ * fnic2_flush_tx() - send queued frames.
+ * @fnic2: fnic2 device
+ *
+ * Send frames that were waiting to go out in FC or Ethernet mode.
+ * Whenever changing modes we purge queued frames, so these frames should
+ * be queued for the stable mode that we're in, either FC or Ethernet.
+ *
+ * Called without fnic2_lock held.
+ */
+void fnic2_flush_tx(struct fnic2 *fnic2)
+{
+	return;
+}
+
+int fnic2_fdls_register_portid(struct fnic2_lport *lport, uint32_t port_id, void *fp)
+{
+	struct fnic2 *fnic2 = lport->fnic2;
+	struct fnic2_eth_hdr *ethhdr;
+	unsigned long flags;
+	int ret;
+
+	pr_debug("setting port id: %x and fp: %pK, fnic2 state: %d",
+		port_id, fp, fnic2->state);
+
+	if (fp) {
+		ethhdr = (struct fnic2_eth_hdr *)fp;
+		vnic_dev_add_addr(fnic2->vdev, ethhdr->dst_mac);
+	}
+
+	/* Change state to reflect transition to FC mode */
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (fnic2->state == FNIC2_IN_ETH_MODE || fnic2->state == FNIC2_IN_FC_MODE) {
+		fnic2->state = FNIC2_IN_ETH_TRANS_FC_MODE;
+	} else {
+		pr_debug("fnic2 0x%pK Unexpected fnic2 state while processing flogi resp\n",
+			 fnic2);
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		return -1;
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	/*
+	 * Send FLOGI registration to firmware to set up FC mode.
+	 * The new address will be set up when registration completes.
+	 */
+	ret = fnic2_flogi_reg_handler(fnic2, port_id);
+
+	if (ret < 0) {
+		spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+
+		pr_debug("flogi reg handeler Error ret: %d, fnic2 state: %d\n",
+			ret, fnic2->state);
+
+		if (fnic2->state == FNIC2_IN_ETH_TRANS_FC_MODE)
+			fnic2->state = FNIC2_IN_ETH_MODE;
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+		return -1;
+	}
+
+	pr_debug("fnic2 0x%pK Waiting for flogi registration\n", fnic2);
+
+	/* TODO: Use a timeout and handle it */
+	msleep(500);
+
+	lport->fabric.flags |= FNIC2_FDLS_FPMA_LEARNT;
+
+	pr_debug("fnic2 0x%pK flogi registration Success\n", fnic2);
+
+	return 0;
+}
+
+void fnic2_scsi_fcpio_reset(struct fnic2_lport *lport)
+{
+	int err = 0;
+	enum fnic2_state old_state;
+	struct fnic2 *fnic2 = lport->fnic2;
+	unsigned long flags;
+
+	/* Issue firmware reset for fnic2, wait for reset to complete */
+retry_fw_reset:
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (fnic2->state == FNIC2_IN_FC_TRANS_ETH_MODE) {
+		/* fw reset is in progress, poll for its completion */
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		goto retry_fw_reset;
+	}
+	old_state = fnic2->state;
+	fnic2->state = FNIC2_IN_FC_TRANS_ETH_MODE;
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	err = fnic2_fw_reset_handler(fnic2);
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (err) {
+		if (fnic2->state == FNIC2_IN_FC_TRANS_ETH_MODE)
+			fnic2->state = old_state;
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		return;
+	}
+
+	if (lport->state != FNIC2_IPORT_STATE_INIT) {
+	    //TBD
+	}
+
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+}
+
+void fnic2_wq_copy_cleanup_handler(struct vnic_wq_copy *wq, struct fcpio_host_req *desc)
+{
+    /* TBD */
+}
+
+void list_free_buffer(struct list_head *list)
+{
+	struct fnic2_frame_list *frame, *next;
+
+	if (!list_empty(list)) {
+		list_for_each_entry_safe(frame, next, list, links) {
+			kfree(frame->fp);
+			list_del(&frame->links);
+			kfree(frame);
+		}
+	}
+}
+
+/*
+ * fnic2_fw_reset_handler
+ * Routine to send reset msg to fw
+ */
+int fnic2_fw_reset_handler(struct fnic2 *fnic2)
+{
+	struct vnic_wq_copy *wq = &fnic2->wq_copy[0];
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	list_free_buffer(&fnic2->frame_queue);
+	list_free_buffer(&fnic2->tx_queue);
+	if (fnic2->config.flags & VFCF_FIP_CAPABLE) {
+	    list_free_buffer(&fnic2->fip_frame_queue);
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	/* wait for io cmpl */
+	while (atomic_read(&fnic2->in_flight))
+		schedule_timeout(msecs_to_jiffies(1));
+
+	spin_lock_irqsave(&fnic2->wq_copy_lock[0], flags);
+
+	if (vnic_wq_copy_desc_avail(wq) <= fnic2->wq_copy_desc_low[0])
+		free_wq_copy_descs(fnic2, wq);
+
+	if (!vnic_wq_copy_desc_avail(wq))
+		ret = -EAGAIN;
+	else
+		fnic2_queue_wq_copy_desc_fw_reset(wq, SCSI_NO_TAG);
+
+	spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+
+	if (!ret)
+		pr_debug("Issued fw reset\n");
+	else
+		pr_debug("Failed to issue fw reset\n");
+
+	return ret;
+}
+
+/*
+ * fnic2_wq_copy_cmpl_handler
+ * Routine to process wq copy
+ */
+int fnic2_wq_copy_cmpl_handler(struct fnic2 *fnic2, int copy_work_to_do)
+{
+	unsigned int wq_work_done = 0;
+	unsigned int i, cq_index;
+	unsigned int cur_work_done;
+
+	for (i = 0; i < fnic2->wq_copy_count; i++) {
+		cq_index = i + fnic2->raw_wq_count + fnic2->rq_count;
+		cur_work_done = vnic_cq_copy_service(&fnic2->cq[cq_index],
+						     fnic2_fcpio_cmpl_handler,
+						     copy_work_to_do);
+		wq_work_done += cur_work_done;
+	}
+	return wq_work_done;
+}
+
+/*
+ * fnic2_fcpio_cmpl_handler
+ * Routine to service the cq for wq_copy
+ */
+static int fnic2_fcpio_cmpl_handler(struct vnic_dev *vdev,
+				    unsigned int cq_index,
+				    struct fcpio_fw_req *desc)
+{
+	struct fnic2 *fnic2 = vnic_dev_priv(vdev);
+	struct fnic2_cmd *tcmd;
+	int cpu;
+
+	switch (desc->hdr.type) {
+	case FCPIO_ACK: /* fw copied copy wq desc to its queue */
+		fnic2_fcpio_ack_handler(fnic2, cq_index, desc);
+		break;
+
+	case FCPIO_ICMND_CMPL: /* fw completed a command */
+		break;
+
+	case FCPIO_ITMF_CMPL: /* fw completed itmf (abort cmd, lun reset)*/
+		break;
+
+	case FCPIO_FLOGI_REG_CMPL: /* fw completed flogi_reg */
+	case FCPIO_FLOGI_FIP_REG_CMPL: /* fw completed flogi_fip_reg */
+		fnic2_fcpio_flogi_reg_cmpl_handler(fnic2, desc);
+		break;
+
+	case FCPIO_RESET_CMPL: /* fw completed reset */
+		fnic2_fcpio_fw_reset_cmpl_handler(fnic2, desc);
+		break;
+
+	case FCPIO_TCMD_SEND_DATA: /* fw completed sending rd data */
+	case FCPIO_TCMD_RECV_DATA: /* fw completed recving wr data */
+	case FCPIO_TCMD_FREE_CMD: /* fw completed freeing a cmd */
+	case FCPIO_TCMD_ABORT_CMD: /* fw completed an abort request */
+	case FCPIO_TCMD_TASK_MGMT: /* fw completed a task mgmt request */
+
+		pr_debug("FW completion received FDLS fcpio_tag %x\n", desc->hdr.fcpio_tag);
+		if (desc->hdr.fcpio_tag != 0xFFFFFFFF && desc->hdr.status != FCPIO_ABORTED) {
+			tcmd = fnic2_find_tcmd(fnic2, desc->hdr.fcpio_tag);
+			memcpy(&tcmd->fw_desc, desc, sizeof(struct fcpio_fw_req));
+
+			cpu = get_cpu_to_queue(tcmd->cmd_tag);
+
+			INIT_WORK(&tcmd->work, fnic2_fcpio_tcmd_cmpl_handler);
+			queue_work_on(cpu, fnic2_tcmd_wq, &tcmd->work);
+		}
+		break;
+
+	default:
+		pr_debug("firmware completion type %d\n", desc->hdr.type);
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * fnic2_fcpio_fw_reset_cmpl_handler
+ * Routine to handle fw reset completion
+ */
+static int fnic2_fcpio_fw_reset_cmpl_handler(struct fnic2 *fnic2, struct fcpio_fw_req *desc)
+{
+	uint8_t type;
+	uint8_t hdr_status;
+	uint32_t fcpio_tag;
+	int ret = 0;
+	unsigned long flags;
+
+	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &fcpio_tag);
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+
+	/* fnic2 should be in FC_TRANS_ETH_MODE */
+	if (fnic2->state == FNIC2_IN_FC_TRANS_ETH_MODE) {
+		/* Check status of reset completion */
+		if (!hdr_status) {
+			pr_debug("reset cmpl success\n");
+			/* Ready to send flogi out */
+			fnic2->state = FNIC2_IN_ETH_MODE;
+		} else {
+			pr_debug("fnic2 fw_reset : failed %s\n",
+				fnic2_fcpio_status_to_str(hdr_status));
+
+			/*
+			* Unable to change to eth mode, cannot send out flogi
+			* Change state to fc mode, so that subsequent Flogi
+			* requests from libFC will cause more attempts to
+			* reset the firmware. Free the cached flogi
+			*/
+			fnic2->state = FNIC2_IN_FC_MODE;
+			ret = -1;
+		}
+	} else {
+		pr_debug("Unexpected state %s while processing reset cmpl\n",
+			 fnic2_state_to_str(fnic2->state));
+		ret = -1;
+	}
+
+	/* Thread removing device blocks till firmware reset is complete */
+	if (fnic2->remove_wait)
+		complete(fnic2->remove_wait);
+
+	/*
+	* If fnic2 is being removed, or fw reset failed
+	* free the flogi frame. Else, send it out
+	*/
+	if (fnic2->remove_wait || ret) {
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		list_free_buffer(&fnic2->tx_queue);
+		goto reset_cmpl_handler_end;
+	}
+
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	fnic2_flush_tx(fnic2);
+
+reset_cmpl_handler_end:
+	return ret;
+}
diff --git a/drivers/staging/fnic2/src/fnic2_fdls.h b/drivers/staging/fnic2/src/fnic2_fdls.h
new file mode 100644
index 0000000..bd6f797
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_fdls.h
@@ -0,0 +1,232 @@
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
+#ifndef _FNIC2_FDLS_H_
+#define _FNIC2_FDLS_H_
+
+#include <linux/list.h>
+#include "fdls_fc.h"
+#include "fcpio.h"
+#include "fnic2_lio.h"
+
+#define ntoh24(p) (((p)[0] << 16) | ((p)[1] << 8) | ((p)[2]))
+
+#define hton24(p, v)    do {                    \
+		p[0] = (((v) >> 16) & 0xFF);    \
+		p[1] = (((v) >> 8) & 0xFF);     \
+		p[2] = ((v) & 0xFF);            \
+	} while (0)
+
+/* FDLS - Fabric discovery and login services
+ * -> VLAN discovery
+ *   -> retry every retry delay seconds until it succeeds.
+ *                        <- List of VLANs
+ *
+ * -> Solicitation
+ *                        <- Solicitation response (Advertisement)
+ *
+ * -> FCF selection & FLOGI ( FLOGI timeout - 2 * E_D_TOV)
+ *                        <- FLOGI response
+ *
+ * -> FCF keep alive
+ *                         <- FCF keep alive
+ *
+ * -> PLOGI to FFFFFC (DNS) (PLOGI timeout - 2 * R_A_TOV)
+ *    -> ABTS if timeout (ABTS tomeout - 2 * R_A_TOV)
+ *                        <- PLOGI response
+ *    -> Retry PLOGI to FFFFFC (DNS) - Number of retries from vnic.cfg
+ *
+ * -> GPN_FT to FFFFFC (GPN_FT timeout - 2 * R_A_TOV)a
+ *    -> Retry on BUSY until it succeeds
+ *    -> Retry on BUSY until it succeeds
+ *    -> 2 retries on timeout
+ *
+ * -> RFT_ID to FFFFFC (DNS)        (RFT_ID timeout - 3 * R_A_TOV)
+ *    -> ABTS if timeout (ABTS tomeout - 2 * R_A_TOV)
+ *    -> Retry RFT_ID to FFFFFC (DNS) (Number of retries 2 )
+ *    -> Ignore if both retires fail.
+ *
+ */
+#define FDLS_RETRY_COUNT 2
+
+struct fnic2_fip_fcf {
+	uint16_t	vlan_id;
+	uint8_t		fcf_mac[6];
+	uint8_t		fcf_priority; //??
+	uint16_t	fka_adv_period;
+	uint8_t		ka_disabled;
+};
+
+/* FDLS structure - not visible to fnic2 driver */
+enum fnic2_fdls_state {
+	FDLS_STATE_INIT = 0,
+	FDLS_STATE_LINKDOWN,
+	FDLS_STATE_FABRIC_FLOGI,
+	FDLS_STATE_FABRIC_PLOGI,
+	FDLS_STATE_RPN_ID,
+	FDLS_STATE_REGISTER_FC4_TYPES,
+	FDLS_STATE_REGISTER_FC4_FEATURES,
+	FDLS_STATE_TGT_ONLINE
+};
+
+#define FNIC2_FDLS_FABRIC_ABORT_ISSUED     0x1
+#define FNIC2_FDLS_FPMA_LEARNT             0x2
+
+struct fnic2_fdls_fabric {
+	enum fnic2_fdls_state	state;
+	uint32_t		flags;
+	struct list_head	rport_list; /* List of logged rports */
+
+	struct timer_list	retry_timer;
+	int			retry_counter;
+	int			timer_pending;
+
+};
+
+struct fnic2_fdls_fip {
+	uint32_t	state;
+	uint32_t	flogi_retry;
+};
+
+enum fdls_tgt_state {
+	fdls_rport_state_plogi		= 1,
+	fdls_rport_state_offlining	= 6
+};
+
+/* rport flags */
+#define FNIC2_FDLS_RETRY_FRAME          0x8
+
+struct fnic2_rport {
+	struct list_head	links; /* To link the rports */
+
+	enum fdls_tgt_state	state;
+	uint32_t		flags;
+	uint32_t		fcid;
+	uint64_t		wwpn;
+	uint64_t		wwnn;
+
+	struct timer_list	retry_timer;
+	int			retry_counter;
+	int			timer_pending;
+
+	void			*lport;
+};
+
+/* lport */
+enum fnic2_lport_state {
+	FNIC2_IPORT_STATE_INIT = 0,
+	FNIC2_IPORT_STATE_LINK_WAIT,
+	FNIC2_IPORT_STATE_FIP,
+	FNIC2_IPORT_STATE_FABRIC_DISC
+};
+
+struct fnic2_lport {
+	enum fnic2_lport_state		state;
+	struct fnic2			*fnic2;
+	uint64_t			boot_time;
+	uint32_t			flags;
+	int				usefip;
+	uint8_t				hwmac[6];  /* HW MAC Addr */
+	uint8_t				fpma[6];   /* Fabric Provided MA */
+	uint8_t				fcfmac[6]; /* MAC addr of Fabric */
+	uint16_t			vlan_id;
+	uint32_t			fcid;
+
+	struct fnic2_fip_fcf		selected_fcf;
+	struct fnic2_fdls_fip		fip;
+
+	struct fnic2_fdls_fabric	fabric;
+	struct list_head		rport_list;
+
+	/* Config block: */
+	uint32_t			e_d_tov; //msec
+	uint32_t			r_a_tov; //msec
+	uint32_t			link_supported_speeds;
+	uint32_t			max_flogi_retries;
+	uint32_t			max_plogi_retries;
+	uint32_t			service_params;
+	uint64_t			wwpn;
+	uint64_t			wwnn;
+	uint16_t			mfs;
+
+	spinlock_t			lport_lock;
+
+	struct fnic2_lport		*lport;
+};
+
+enum fnic2_recv_frame_type {
+	FNIC2_FABRIC_FLOGI_RSP	= 0,
+	FNIC2_FABRIC_PLOGI_RSP,
+	FNIC2_FABRIC_RPN_RSP,
+	FNIC2_FABRIC_RFT_RSP,
+	FNIC2_FABRIC_RFF_RSP,
+	FNIC2_TPORT_LOGO_RSP	= 9,
+	FNIC2_BLS_ABTS_RSP,
+	FNIC2_ELS_PLOGI_REQ,
+	FNIC2_ELS_PRLI_REQ,
+	FNIC2_ELS_LOGO_REQ,
+	FNIC2_ELS_RTV_REQ,
+	FNIC2_ELS_RRQ_REQ
+};
+
+#define FNIC2_FDLS_RETRY_FRAME          0x8
+
+/* Function Declarations */
+
+/* fdls_disc.c */
+void fnic2_fdls_disc_init(struct fnic2_lport *lport);
+void fnic2_fdls_disc_start(struct fnic2_lport *lport);
+void fnic2_fdls_recv_frame(struct fnic2_lport *lport, void *rx_frame, int len, int fchdr_offset);
+void fnic2_fdls_link_down(struct fnic2_lport *lport);
+void fdls_send_ba_acc(struct fnic2_lport *lport, struct fc_hdr *fchdr);
+void fdls_fabric_timer_callback(struct timer_list *timer);
+
+/* fdls_if.c */
+void fnic2_fdls_init(struct fnic2 *fnic2, int usefip);
+void fnic2_fdls_cleanup(struct fnic2 *fnic2);
+void fnic2_scsi_fcpio_reset(struct fnic2_lport *lport);
+
+int fnic2_send_fcoe_frame(struct fnic2_lport *lport, void *payload, int payload_sz);
+int fnic2_send_fip_frame(struct fnic2_lport *lport, void *payload, int payload_sz);
+void fnic2_fdls_learn_fcoe_macs(struct fnic2_lport *lport, void *rx_frame, uint8_t *fcid);
+void fnic2_set_port_id(struct fnic2_lport *lport, uint32_t port_id, void *fp);
+void fnic2_exch_mgr_reset(struct fnic2_lport *lport, uint32_t s_id, uint32_t d_id);
+void fnic2_fdls_link_down(struct fnic2_lport *lport);
+void list_free_buffer(struct list_head *list);
+int free_wq_copy_descs(struct fnic2 *fnic2, struct vnic_wq_copy *wq);
+
+/* fip.c */
+void fnic2_fcoe_reset_vlans(struct fnic2 *fnic2);
+void fnic2_fcoe_send_vlan_req(struct fnic2 *fnic2);
+void fnic2_common_fip_cleanup(struct fnic2 *fnic2);
+int fdls_fip_recv_frame(struct fnic2 *fnic2, void *frame);
+void fnic2_handle_fcs_ka_timer(struct timer_list *timer);
+void fnic2_handle_enode_ka_timer(struct timer_list *timer);
+void fnic2_handle_vn_ka_timer(struct timer_list *timer);
+void fnic2_handle_fip_timer(struct timer_list *timer);
+void fdls_send_logout(struct fnic2_lport *lport, struct fc_hdr *fchdr);
+
+/* utils */
+void fnic2_fdls_learn_fcoe_macs(struct fnic2_lport *lport, void *rx_frame, uint8_t *fcid);
+int fnic2_fdls_register_portid(struct fnic2_lport *lport, uint32_t port_id, void *fp);
+
+#define FNIC2_PORTSPEED_10GBIT   1
+#define FNIC2_FCOE_MAX_PAYLOAD   2048
+#define FNIC2_FCOE_FRAME_MAXSZ   2112
+#define FNIC2_RQ_FRAME_LEN       2148 //FC_FRAME_HEADROOM + FC_MAX_FRAME + FC_FRAME_TAILROOM
+#endif /* _FNIC2_FDLS_H_ */
-- 
1.8.3.1
