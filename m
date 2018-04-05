Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx4+TR+B9AYSNECe9VDh/MzKG3dDYsF822avgyNiOj+/7jfyDuN2Kp8tRs4y+2AIOWiu26nnb
ARC-Seal: i=1; a=rsa-sha256; t=1522963149; cv=none;
        d=google.com; s=arc-20160816;
        b=c90s+QdIkyBmZEHOmZd2QSJHPHrCE1MvSQNGlcVZcGglG+de41vJoWOtisEnA4ktu8
         IaCuintD4CX9Wpd7JWumn9h4juxEfjXYSnyFqzvqiXqX65pA+RUtsXAtnWIIAhqd5Byj
         VeLktnUPDcdyLHeWH06ZETCRkRTBOm37AtaJ8S6GemsjdGwuhqW8h3WTXdHnWjdcix9e
         6K46DxigsFeCb9YWGa4QxZZsnmSApJzzjyEHo4TcWVI4dOsfiftN8ARJZoNtA6oneqH1
         jfxlc7PNW1SQ4zAav+ejHQUeR5jdGMtFxrOLDs6rCPpCfwSuVba0cqeNmTkZOqh3RmaC
         kWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dzzWux0lllsWfYQZVJnqrJr7ez4uqD+SrIJ/7FB54a4=;
        b=ijL6xriZ3p3p46xCD3GA/d5u7TeQgOtq2i9brFVld2dGidxQ6VDPYQ+rNUK4JHjiVA
         3NsCeRkUsF/XYBaEvPQ9jn7RBkBoGTGAUJ4ixExoIf8zUxxgRn4OJHK4oEoXDI6h1cc/
         NP64LXReF5V5CCeJzjRkmCJUHn38XhC7XtTnA9Y25ansbZ7pBq4WIIju8ACUAfHQUURM
         pCvaaGX2eGY8DlHzC0kPLRniiWE0Kcnwn3l19pf8DFj1tC7H7o8+sjHrxIveiBi4ED4O
         hHy1GXZCoN646X42kdUakGKafaECpInAieC3/MD9bZVkIxmx9fTKZWHsTkzxvjoB+rOc
         RtZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=FROL38jA;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.74 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=FROL38jA;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.74 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="366728819"
Date: Thu, 5 Apr 2018 14:21:54 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 07/10] staging: fnic2 add queue descriptors
Message-ID: <20180405212154.GH12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942607544161703?=
X-GMAIL-MSGID: =?utf-8?q?1596942607544161703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain queueing interfaces for software.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/cq_desc.h      |  74 +++++++++++++++
 drivers/staging/fnic2/src/cq_enet_desc.h | 158 +++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/cq_exch_desc.h | 104 ++++++++++++++++++++
 drivers/staging/fnic2/src/rq_enet_desc.h |  45 +++++++++
 drivers/staging/fnic2/src/wq_enet_desc.h |  69 ++++++++++++++
 5 files changed, 450 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/cq_desc.h
 create mode 100644 drivers/staging/fnic2/src/cq_enet_desc.h
 create mode 100644 drivers/staging/fnic2/src/cq_exch_desc.h
 create mode 100644 drivers/staging/fnic2/src/rq_enet_desc.h
 create mode 100644 drivers/staging/fnic2/src/wq_enet_desc.h

diff --git a/drivers/staging/fnic2/src/cq_desc.h b/drivers/staging/fnic2/src/cq_desc.h
new file mode 100644
index 0000000..638753d
--- /dev/null
+++ b/drivers/staging/fnic2/src/cq_desc.h
@@ -0,0 +1,74 @@
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
+#ifndef _CQ_DESC_H_
+#define _CQ_DESC_H_
+
+/*
+ * Completion queue descriptor types
+ */
+enum cq_desc_types {
+	CQ_DESC_TYPE_RQ_ENET = 3,
+	CQ_DESC_TYPE_RQ_FCP = 4,
+};
+
+/* Completion queue descriptor: 16B
+ *
+ * All completion queues have this basic layout.  The
+ * type_specific area is unique for each completion
+ * queue type.
+ */
+struct cq_desc {
+	__le16 completed_index;
+	__le16 q_number;
+	uint8_t type_specific[11];
+	uint8_t type_color;
+};
+
+#define CQ_DESC_TYPE_BITS        4
+#define CQ_DESC_TYPE_MASK        ((1 << CQ_DESC_TYPE_BITS) - 1)
+#define CQ_DESC_COLOR_MASK       1
+#define CQ_DESC_COLOR_SHIFT      7
+#define CQ_DESC_Q_NUM_BITS       10
+#define CQ_DESC_Q_NUM_MASK       ((1 << CQ_DESC_Q_NUM_BITS) - 1)
+#define CQ_DESC_COMP_NDX_BITS    12
+#define CQ_DESC_COMP_NDX_MASK    ((1 << CQ_DESC_COMP_NDX_BITS) - 1)
+
+static inline void cq_desc_dec(const struct cq_desc *desc_arg, uint8_t *type, uint8_t *color, uint16_t *q_number, uint16_t *completed_index)
+{
+	const struct cq_desc *desc = desc_arg;
+	const uint8_t type_color = desc->type_color;
+
+	*color = (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
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
+	*type = type_color & CQ_DESC_TYPE_MASK;
+	*q_number = le16_to_cpu(desc->q_number) & CQ_DESC_Q_NUM_MASK;
+	*completed_index = le16_to_cpu(desc->completed_index) &
+		CQ_DESC_COMP_NDX_MASK;
+}
+
+#endif /* _CQ_DESC_H_ */
diff --git a/drivers/staging/fnic2/src/cq_enet_desc.h b/drivers/staging/fnic2/src/cq_enet_desc.h
new file mode 100644
index 0000000..606cb89
--- /dev/null
+++ b/drivers/staging/fnic2/src/cq_enet_desc.h
@@ -0,0 +1,158 @@
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
+#ifndef _CQ_ENET_DESC_H_
+#define _CQ_ENET_DESC_H_
+
+#include "cq_desc.h"
+
+/* Ethernet completion queue descriptor: 16B */
+struct cq_enet_wq_desc {
+	__le16 completed_index;
+	__le16 q_number;
+	uint8_t reserved[11];
+	uint8_t type_color;
+};
+
+/* Completion queue descriptor: Ethernet receive queue, 16B */
+struct cq_enet_rq_desc {
+	__le16 completed_index_flags;
+	__le16 q_number_rss_type_flags;
+	__le32 rss_hash;
+	__le16 bytes_written_flags;
+	__le16 vlan;
+	__le16 checksum_fcoe;
+	uint8_t flags;
+	uint8_t type_color;
+};
+
+#define CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT          (0x1 << 12)
+#define CQ_ENET_RQ_DESC_FLAGS_FCOE                  (0x1 << 13)
+#define CQ_ENET_RQ_DESC_FLAGS_EOP                   (0x1 << 14)
+#define CQ_ENET_RQ_DESC_FLAGS_SOP                   (0x1 << 15)
+
+#define CQ_ENET_RQ_DESC_RSS_TYPE_BITS               4
+#define CQ_ENET_RQ_DESC_RSS_TYPE_MASK \
+	((1 << CQ_ENET_RQ_DESC_RSS_TYPE_BITS) - 1)
+
+#define CQ_ENET_RQ_DESC_FLAGS_CSUM_NOT_CALC         (0x1 << 14)
+
+#define CQ_ENET_RQ_DESC_BYTES_WRITTEN_BITS          14
+#define CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK \
+	((1 << CQ_ENET_RQ_DESC_BYTES_WRITTEN_BITS) - 1)
+#define CQ_ENET_RQ_DESC_FLAGS_TRUNCATED             (0x1 << 14)
+#define CQ_ENET_RQ_DESC_FLAGS_VLAN_STRIPPED         (0x1 << 15)
+
+#define CQ_ENET_RQ_DESC_FCOE_SOF_BITS               4
+#define CQ_ENET_RQ_DESC_FCOE_SOF_MASK \
+	((1 << CQ_ENET_RQ_DESC_FCOE_SOF_BITS) - 1)
+#define CQ_ENET_RQ_DESC_FCOE_EOF_BITS               8
+#define CQ_ENET_RQ_DESC_FCOE_EOF_MASK \
+	((1 << CQ_ENET_RQ_DESC_FCOE_EOF_BITS) - 1)
+#define CQ_ENET_RQ_DESC_FCOE_EOF_SHIFT              8
+
+#define CQ_ENET_RQ_DESC_FLAGS_TCP_UDP_CSUM_OK       (0x1 << 0)
+#define CQ_ENET_RQ_DESC_FCOE_FC_CRC_OK              (0x1 << 0)
+#define CQ_ENET_RQ_DESC_FLAGS_UDP                   (0x1 << 1)
+#define CQ_ENET_RQ_DESC_FCOE_ENC_ERROR              (0x1 << 1)
+#define CQ_ENET_RQ_DESC_FLAGS_TCP                   (0x1 << 2)
+#define CQ_ENET_RQ_DESC_FLAGS_IPV4_CSUM_OK          (0x1 << 3)
+#define CQ_ENET_RQ_DESC_FLAGS_IPV6                  (0x1 << 4)
+#define CQ_ENET_RQ_DESC_FLAGS_IPV4                  (0x1 << 5)
+#define CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT         (0x1 << 6)
+#define CQ_ENET_RQ_DESC_FLAGS_FCS_OK                (0x1 << 7)
+
+static inline void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc, uint8_t *type,
+				       uint8_t *color, uint16_t *q_number,
+				       uint16_t *completed_index, uint8_t *ingress_port,
+				       uint8_t *fcoe, uint8_t *eop, uint8_t *sop,
+				       uint8_t *rss_type, uint8_t *csum_not_calc,
+				       uint32_t *rss_hash, uint16_t *bytes_written,
+				       uint8_t *packet_error, uint8_t *vlan_stripped,
+				       uint16_t *vlan, uint16_t *checksum, uint8_t *fcoe_sof,
+				       uint8_t *fcoe_fc_crc_ok, uint8_t *fcoe_enc_error,
+				       uint8_t *fcoe_eof,
+				       uint8_t *tcp_udp_csum_ok, uint8_t *udp, uint8_t *tcp,
+				       uint8_t *ipv4_csum_ok, uint8_t *ipv6, uint8_t *ipv4,
+				       uint8_t *ipv4_fragment, uint8_t *fcs_ok)
+{
+	uint16_t completed_index_flags = le16_to_cpu(desc->completed_index_flags);
+	uint16_t q_number_rss_type_flags =
+		le16_to_cpu(desc->q_number_rss_type_flags);
+	uint16_t bytes_written_flags = le16_to_cpu(desc->bytes_written_flags);
+
+	cq_desc_dec((struct cq_desc *)desc, type,
+		color, q_number, completed_index);
+
+	*ingress_port = (completed_index_flags &
+		CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT) ? 1 : 0;
+	*fcoe = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_FCOE) ?
+		1 : 0;
+	*eop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_EOP) ?
+		1 : 0;
+	*sop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_SOP) ?
+		1 : 0;
+
+	*rss_type = (uint8_t)((q_number_rss_type_flags >> CQ_DESC_Q_NUM_BITS) &
+		CQ_ENET_RQ_DESC_RSS_TYPE_MASK);
+	*csum_not_calc = (q_number_rss_type_flags &
+		CQ_ENET_RQ_DESC_FLAGS_CSUM_NOT_CALC) ? 1 : 0;
+
+	*rss_hash = le32_to_cpu(desc->rss_hash);
+
+	*bytes_written = bytes_written_flags &
+		CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
+	*packet_error = (bytes_written_flags &
+		CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) ? 1 : 0;
+	*vlan_stripped = (bytes_written_flags &
+		CQ_ENET_RQ_DESC_FLAGS_VLAN_STRIPPED) ? 1 : 0;
+
+	*vlan = le16_to_cpu(desc->vlan);
+
+	if (*fcoe) {
+		*fcoe_sof = (uint8_t)(le16_to_cpu(desc->checksum_fcoe) &
+			CQ_ENET_RQ_DESC_FCOE_SOF_MASK);
+		*fcoe_fc_crc_ok = (desc->flags &
+			CQ_ENET_RQ_DESC_FCOE_FC_CRC_OK) ? 1 : 0;
+		*fcoe_enc_error = (desc->flags &
+			CQ_ENET_RQ_DESC_FCOE_ENC_ERROR) ? 1 : 0;
+		*fcoe_eof = (uint8_t)((desc->checksum_fcoe >>
+			CQ_ENET_RQ_DESC_FCOE_EOF_SHIFT) &
+			CQ_ENET_RQ_DESC_FCOE_EOF_MASK);
+		*checksum = 0;
+	} else {
+		*fcoe_sof = 0;
+		*fcoe_fc_crc_ok = 0;
+		*fcoe_enc_error = 0;
+		*fcoe_eof = 0;
+		*checksum = le16_to_cpu(desc->checksum_fcoe);
+	}
+
+	*tcp_udp_csum_ok =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP_UDP_CSUM_OK) ? 1 : 0;
+	*udp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_UDP) ? 1 : 0;
+	*tcp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP) ? 1 : 0;
+	*ipv4_csum_ok =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_CSUM_OK) ? 1 : 0;
+	*ipv6 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV6) ? 1 : 0;
+	*ipv4 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4) ? 1 : 0;
+	*ipv4_fragment =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT) ? 1 : 0;
+	*fcs_ok = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK) ? 1 : 0;
+}
+
+#endif /* _CQ_ENET_DESC_H_ */
diff --git a/drivers/staging/fnic2/src/cq_exch_desc.h b/drivers/staging/fnic2/src/cq_exch_desc.h
new file mode 100644
index 0000000..bc7e005c
--- /dev/null
+++ b/drivers/staging/fnic2/src/cq_exch_desc.h
@@ -0,0 +1,104 @@
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
+#ifndef _CQ_EXCH_DESC_H_
+#define _CQ_EXCH_DESC_H_
+
+#include "cq_desc.h"
+
+#define CQ_EXCH_WQ_STATUS_BITS      2
+#define CQ_EXCH_WQ_STATUS_MASK      ((1 << CQ_EXCH_WQ_STATUS_BITS) - 1)
+
+struct cq_fcp_rq_desc {
+	uint16_t completed_index_eop_sop_prt;
+	uint16_t q_number;
+	uint16_t exchange_id;
+	uint16_t tmpl;
+	uint16_t bytes_written;
+	uint16_t vlan;
+	uint8_t  sof;
+	uint8_t  eof;
+	uint8_t  fcs_fer_fck;
+	uint8_t  type_color;
+};
+
+#define CQ_FCP_RQ_DESC_FLAGS_SOP		(1 << 15)
+#define CQ_FCP_RQ_DESC_FLAGS_EOP		(1 << 14)
+#define CQ_FCP_RQ_DESC_FLAGS_PRT		(1 << 12)
+#define CQ_FCP_RQ_DESC_TMPL_MASK		0x1f
+#define CQ_FCP_RQ_DESC_BYTES_WRITTEN_MASK	0x3fff
+#define CQ_FCP_RQ_DESC_PACKET_ERR_SHIFT		14
+#define CQ_FCP_RQ_DESC_PACKET_ERR_MASK (1 << CQ_FCP_RQ_DESC_PACKET_ERR_SHIFT)
+#define CQ_FCP_RQ_DESC_VS_STRIPPED_SHIFT	15
+#define CQ_FCP_RQ_DESC_VS_STRIPPED_MASK (1 << CQ_FCP_RQ_DESC_VS_STRIPPED_SHIFT)
+#define CQ_FCP_RQ_DESC_FC_CRC_OK_MASK		0x1
+#define CQ_FCP_RQ_DESC_FCOE_ERR_SHIFT		1
+#define CQ_FCP_RQ_DESC_FCOE_ERR_MASK (1 << CQ_FCP_RQ_DESC_FCOE_ERR_SHIFT)
+#define CQ_FCP_RQ_DESC_FCS_OK_SHIFT		7
+#define CQ_FCP_RQ_DESC_FCS_OK_MASK (1 << CQ_FCP_RQ_DESC_FCS_OK_SHIFT)
+
+static inline void cq_fcp_rq_desc_dec(struct cq_fcp_rq_desc *desc_ptr,
+				      uint8_t  *type,
+				      uint8_t  *color,
+				      uint16_t *q_number,
+				      uint16_t *completed_index,
+				      uint8_t  *eop,
+				      uint8_t  *sop,
+				      uint8_t  *fck,
+				      uint16_t *exchange_id,
+				      uint16_t *tmpl,
+				      uint32_t *bytes_written,
+				      uint8_t  *sof,
+				      uint8_t  *eof,
+				      uint8_t  *ingress_port,
+				      uint8_t  *packet_err,
+				      uint8_t  *fcoe_err,
+				      uint8_t  *fcs_ok,
+				      uint8_t  *vlan_stripped,
+				      uint16_t *vlan)
+{
+	cq_desc_dec((struct cq_desc *)desc_ptr, type,
+		    color, q_number, completed_index);
+	*eop = (desc_ptr->completed_index_eop_sop_prt &
+		CQ_FCP_RQ_DESC_FLAGS_EOP) ? 1 : 0;
+	*sop = (desc_ptr->completed_index_eop_sop_prt &
+		CQ_FCP_RQ_DESC_FLAGS_SOP) ? 1 : 0;
+	*ingress_port =
+		(desc_ptr->completed_index_eop_sop_prt &
+		 CQ_FCP_RQ_DESC_FLAGS_PRT) ? 1 : 0;
+	*exchange_id = desc_ptr->exchange_id;
+	*tmpl = desc_ptr->tmpl & CQ_FCP_RQ_DESC_TMPL_MASK;
+	*bytes_written =
+		desc_ptr->bytes_written & CQ_FCP_RQ_DESC_BYTES_WRITTEN_MASK;
+	*packet_err =
+		(desc_ptr->bytes_written & CQ_FCP_RQ_DESC_PACKET_ERR_MASK) >>
+		CQ_FCP_RQ_DESC_PACKET_ERR_SHIFT;
+	*vlan_stripped =
+		(desc_ptr->bytes_written & CQ_FCP_RQ_DESC_VS_STRIPPED_MASK) >>
+		CQ_FCP_RQ_DESC_VS_STRIPPED_SHIFT;
+	*vlan = desc_ptr->vlan;
+	*sof = desc_ptr->sof;
+	*fck = desc_ptr->fcs_fer_fck & CQ_FCP_RQ_DESC_FC_CRC_OK_MASK;
+	*fcoe_err = (desc_ptr->fcs_fer_fck & CQ_FCP_RQ_DESC_FCOE_ERR_MASK) >>
+		CQ_FCP_RQ_DESC_FCOE_ERR_SHIFT;
+	*eof = desc_ptr->eof;
+	*fcs_ok =
+		(desc_ptr->fcs_fer_fck & CQ_FCP_RQ_DESC_FCS_OK_MASK) >>
+		CQ_FCP_RQ_DESC_FCS_OK_SHIFT;
+}
+
+#endif /* _CQ_EXCH_DESC_H_ */
diff --git a/drivers/staging/fnic2/src/rq_enet_desc.h b/drivers/staging/fnic2/src/rq_enet_desc.h
new file mode 100644
index 0000000..c8d6e30
--- /dev/null
+++ b/drivers/staging/fnic2/src/rq_enet_desc.h
@@ -0,0 +1,45 @@
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
+#ifndef _RQ_ENET_DESC_H_
+#define _RQ_ENET_DESC_H_
+
+/* Ethernet receive queue descriptor: 16B */
+struct rq_enet_desc {
+	__le64	address;
+	__le16	length_type;
+	uint8_t	reserved[6];
+};
+
+#define	RQ_ENET_TYPE_ONLY_SOP	0
+
+#define RQ_ENET_LEN_BITS	14
+#define RQ_ENET_LEN_MASK	((1 << RQ_ENET_LEN_BITS) - 1)
+#define RQ_ENET_TYPE_BITS	2
+#define RQ_ENET_TYPE_MASK	((1 << RQ_ENET_TYPE_BITS) - 1)
+
+static inline void rq_enet_desc_enc(struct rq_enet_desc *desc,
+				    uint64_t address,
+				    uint8_t type,
+				    uint16_t length)
+{
+	desc->address = cpu_to_le64(address);
+	desc->length_type = cpu_to_le16((length & RQ_ENET_LEN_MASK) |
+		((type & RQ_ENET_TYPE_MASK) << RQ_ENET_LEN_BITS));
+}
+
+#endif /* _RQ_ENET_DESC_H_ */
diff --git a/drivers/staging/fnic2/src/wq_enet_desc.h b/drivers/staging/fnic2/src/wq_enet_desc.h
new file mode 100644
index 0000000..51384c6
--- /dev/null
+++ b/drivers/staging/fnic2/src/wq_enet_desc.h
@@ -0,0 +1,69 @@
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
+#ifndef _WQ_ENET_DESC_H_
+#define _WQ_ENET_DESC_H_
+
+/* Ethernet work queue descriptor: 16B */
+struct wq_enet_desc {
+	__le64 address;
+	__le16 length;
+	__le16 mss_loopback;
+	__le16 header_length_flags;
+	__le16 vlan_tag;
+};
+
+enum wq_enet {
+	WQ_ENET_LEN_BITS			= 14,
+	WQ_ENET_LEN_MASK			= ((1 << WQ_ENET_LEN_BITS) - 1),
+	WQ_ENET_MSS_BITS			= 14,
+	WQ_ENET_MSS_MASK			= ((1 << WQ_ENET_MSS_BITS) - 1),
+	WQ_ENET_MSS_SHIFT			= 2,
+	WQ_ENET_LOOPBACK_SHIFT			= 1,
+	WQ_ENET_HDRLEN_BITS			= 10,
+	WQ_ENET_HDRLEN_MASK			= ((1 << WQ_ENET_HDRLEN_BITS) - 1),
+	WQ_ENET_FLAGS_OM_BITS			= 2,
+	WQ_ENET_FLAGS_OM_MASK			= ((1 << WQ_ENET_FLAGS_OM_BITS) - 1),
+	WQ_ENET_FLAGS_EOP_SHIFT			= 12,
+	WQ_ENET_FLAGS_CQ_ENTRY_SHIFT		= 13,
+	WQ_ENET_FLAGS_FCOE_ENCAP_SHIFT		= 14,
+	WQ_ENET_FLAGS_VLAN_TAG_INSERT_SHIFT	= 15
+};
+
+static inline void wq_enet_desc_enc(struct wq_enet_desc *desc,
+				    uint64_t address, uint16_t length,
+				    uint16_t mss, uint16_t header_length,
+				    uint8_t offload_mode, uint8_t eop,
+				    uint8_t cq_entry, uint8_t fcoe_encap,
+				    uint8_t vlan_tag_insert, uint16_t vlan_tag,
+				    uint8_t loopback)
+{
+	desc->address = cpu_to_le64(address);
+	desc->length = cpu_to_le16(length & WQ_ENET_LEN_MASK);
+	desc->mss_loopback = cpu_to_le16((mss & WQ_ENET_MSS_MASK) <<
+		WQ_ENET_MSS_SHIFT | (loopback & 1) << WQ_ENET_LOOPBACK_SHIFT);
+	desc->header_length_flags = cpu_to_le16(
+		(header_length & WQ_ENET_HDRLEN_MASK) |
+		(offload_mode & WQ_ENET_FLAGS_OM_MASK) << WQ_ENET_HDRLEN_BITS |
+		(eop & 1) << WQ_ENET_FLAGS_EOP_SHIFT |
+		(cq_entry & 1) << WQ_ENET_FLAGS_CQ_ENTRY_SHIFT |
+		(fcoe_encap & 1) << WQ_ENET_FLAGS_FCOE_ENCAP_SHIFT |
+		(vlan_tag_insert & 1) << WQ_ENET_FLAGS_VLAN_TAG_INSERT_SHIFT);
+	desc->vlan_tag = cpu_to_le16(vlan_tag);
+}
+
+#endif /* _WQ_ENET_DESC_H_ */
-- 
1.8.3.1
