Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx48OCEVUFXMm7HCVrH5ZS/LerwuZnDDo1CpJwqxxH/m87UYoTyy6v1kw1f/0xbck1eV5MzxA
ARC-Seal: i=1; a=rsa-sha256; t=1522962907; cv=none;
        d=google.com; s=arc-20160816;
        b=VsJCzZOHK1aE9lgjfU3O5Q2L+hRr4j9Jg4mSwFP7+dNzDksSwU2Q/tsKbcZb+BPgj1
         7xM1WMSQWlX+yiwFnp42Wns0daFzhmShVM9+TlhasAuq79UZJHEvi0qClftbQowvg6O/
         HzIatHe1p7jELtmup1qnYdFlSS3LaZBVrrokr+nLGu1Fl21LBjKTOZSGfF149OIcIsir
         aBgOWAgfjP9+xYagf+GUpA1aw98yFIFZJ5r2gU962aFXBU9Yj3M9ostW4r27umvbJn2K
         HDNK8A2BtXZTFmVdSB4qFMkbehGPo9ohv9qakbEFv5/LlsLI40MTDga/49IIY0pHQOeR
         j//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8nzBieCiVyqfou0JUQx//rEpAmjs5tbAotAKgLsLNYw=;
        b=VZZ7ql9+yMkIQa3pR6UVSKrt6YX95UCAdLyh0hNw4K9cu4/6TraxWHUETqtc2lhTEd
         XK45AAOs95Ac/k/yyPBUYEL743mLMXIhgrq2yhQTRceUTdc8N3qHxGMzQqyaH51BAJoe
         YMeY1tXBqIeKAmOa8HFq3GKi6qQMYRCCH/mFHrXt+GqZPIYrre6Lwo9uQHczLhoZsKmk
         VesQ/Fvim6sFKLHi58m+fKA9m8v9OxzZUYRuR5XMHumgHPywjKE9cHAVJDvyxx6ktGM5
         oW1Eo91KbJQbt+G3R9vGZ6/qvRG0sBFlSrrz1vYJQ6jxSOcJ31K3uh9BtolDD5Fh2UMh
         18jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=hTCyI1S7;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.91 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=hTCyI1S7;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.91 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94807723"
Date: Thu, 5 Apr 2018 14:17:52 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 02/10] staging: fnic2 add resource allocation
Message-ID: <20180405211752.GC12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942353596056356?=
X-GMAIL-MSGID: =?utf-8?q?1596942353596056356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain logic for interrupts, resource allocation,
and initialization of hardware queues.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/fnic2_isr.c | 324 +++++++++++++++++++++++++
 drivers/staging/fnic2/src/fnic2_res.c | 430 ++++++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/fnic2_res.h | 120 ++++++++++
 3 files changed, 874 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/fnic2_isr.c
 create mode 100644 drivers/staging/fnic2/src/fnic2_res.c
 create mode 100644 drivers/staging/fnic2/src/fnic2_res.h

diff --git a/drivers/staging/fnic2/src/fnic2_isr.c b/drivers/staging/fnic2/src/fnic2_isr.c
new file mode 100644
index 0000000..07cf1a4
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_isr.c
@@ -0,0 +1,324 @@
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
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include "vnic_dev.h"
+#include "vnic_intr.h"
+#include "vnic_stats.h"
+#include "fnic2.h"
+
+static irqreturn_t fnic2_isr_legacy(int irq, void *data)
+{
+	struct fnic2 *fnic2 = data;
+	uint32_t pba;
+	unsigned long work_done = 0;
+
+	pba = vnic_intr_legacy_pba(fnic2->legacy_pba);
+	if (!pba)
+		return IRQ_NONE;
+
+	if (pba & (1 << FNIC2_INTX_NOTIFY)) {
+		vnic_intr_return_all_credits(&fnic2->intr[FNIC2_INTX_NOTIFY]);
+		fnic2_handle_link_event(fnic2);
+	}
+
+	if (pba & (1 << FNIC2_INTX_ERR)) {
+		vnic_intr_return_all_credits(&fnic2->intr[FNIC2_INTX_ERR]);
+		fnic2_log_q_error(fnic2);
+	}
+
+	if (pba & (1 << FNIC2_INTX_WQ_RQ_COPYWQ)) {
+		work_done += fnic2_wq_copy_cmpl_handler(fnic2, -1);
+		work_done += fnic2_wq_cmpl_handler(fnic2, -1);
+		work_done += fnic2_rq_cmpl_handler(fnic2, -1);
+
+		vnic_intr_return_credits(&fnic2->intr[FNIC2_INTX_WQ_RQ_COPYWQ],
+					 work_done,
+					 1 /* unmask intr */,
+					 1 /* reset intr timer */);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fnic2_isr_msi(int irq, void *data)
+{
+	struct fnic2 *fnic2 = data;
+	unsigned long work_done = 0;
+
+	work_done += fnic2_wq_copy_cmpl_handler(fnic2, -1);
+	work_done += fnic2_wq_cmpl_handler(fnic2, -1);
+	work_done += fnic2_rq_cmpl_handler(fnic2, -1);
+
+	vnic_intr_return_credits(&fnic2->intr[0],
+				 work_done,
+				 1 /* unmask intr */,
+				 1 /* reset intr timer */);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fnic2_isr_msix_rq(int irq, void *data)
+{
+	struct fnic2 *fnic2 = data;
+	unsigned long rq_work_done = 0;
+
+	rq_work_done = fnic2_rq_cmpl_handler(fnic2, -1);
+	vnic_intr_return_credits(&fnic2->intr[FNIC2_MSIX_RQ],
+				 rq_work_done,
+				 1 /* unmask intr */,
+				 1 /* reset intr timer */);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fnic2_isr_msix_wq(int irq, void *data)
+{
+	struct fnic2 *fnic2 = data;
+	unsigned long wq_work_done = 0;
+
+	wq_work_done = fnic2_wq_cmpl_handler(fnic2, -1);
+	vnic_intr_return_credits(&fnic2->intr[FNIC2_MSIX_WQ],
+				 wq_work_done,
+				 1 /* unmask intr */,
+				 1 /* reset intr timer */);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fnic2_isr_msix_wq_copy(int irq, void *data)
+{
+	struct fnic2 *fnic2 = data;
+	unsigned long wq_copy_work_done = 0;
+
+	wq_copy_work_done = fnic2_wq_copy_cmpl_handler(fnic2, -1);
+	vnic_intr_return_credits(&fnic2->intr[FNIC2_MSIX_WQ_COPY],
+				 wq_copy_work_done,
+				 1 /* unmask intr */,
+				 1 /* reset intr timer */);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fnic2_isr_msix_err_notify(int irq, void *data)
+{
+	struct fnic2 *fnic2 = data;
+
+	vnic_intr_return_all_credits(&fnic2->intr[FNIC2_MSIX_ERR_NOTIFY]);
+	fnic2_log_q_error(fnic2);
+	fnic2_handle_link_event(fnic2);
+
+	return IRQ_HANDLED;
+}
+
+void fnic2_free_intr(struct fnic2 *fnic2)
+{
+	int i;
+
+	switch (vnic_dev_get_intr_mode(fnic2->vdev)) {
+	case VNIC_DEV_INTR_MODE_INTX:
+	case VNIC_DEV_INTR_MODE_MSI:
+		free_irq(fnic2->pdev->irq, fnic2);
+		break;
+
+	case VNIC_DEV_INTR_MODE_MSIX:
+		for (i = 0; i < ARRAY_SIZE(fnic2->msix); i++)
+			if (fnic2->msix[i].requested)
+				free_irq(fnic2->msix_entry[i].vector,
+					 fnic2->msix[i].devid);
+		break;
+
+	default:
+		break;
+	}
+}
+
+int fnic2_request_intr(struct fnic2 *fnic2)
+{
+	int err = 0;
+	int i;
+
+	switch (vnic_dev_get_intr_mode(fnic2->vdev)) {
+
+	case VNIC_DEV_INTR_MODE_INTX:
+		err = request_irq(fnic2->pdev->irq, &fnic2_isr_legacy,
+				  IRQF_SHARED, DRV_NAME, fnic2);
+		break;
+
+	case VNIC_DEV_INTR_MODE_MSI:
+		err = request_irq(fnic2->pdev->irq, &fnic2_isr_msi,
+				  0, fnic2->name, fnic2);
+		break;
+
+	case VNIC_DEV_INTR_MODE_MSIX:
+
+		sprintf(fnic2->msix[FNIC2_MSIX_RQ].devname,
+			"%.11s-fcs-rq", fnic2->name);
+		fnic2->msix[FNIC2_MSIX_RQ].isr = fnic2_isr_msix_rq;
+		fnic2->msix[FNIC2_MSIX_RQ].devid = fnic2;
+
+		sprintf(fnic2->msix[FNIC2_MSIX_WQ].devname,
+			"%.11s-fcs-wq", fnic2->name);
+		fnic2->msix[FNIC2_MSIX_WQ].isr = fnic2_isr_msix_wq;
+		fnic2->msix[FNIC2_MSIX_WQ].devid = fnic2;
+
+		sprintf(fnic2->msix[FNIC2_MSIX_WQ_COPY].devname,
+			"%.11s-scsi-wq", fnic2->name);
+		fnic2->msix[FNIC2_MSIX_WQ_COPY].isr = fnic2_isr_msix_wq_copy;
+		fnic2->msix[FNIC2_MSIX_WQ_COPY].devid = fnic2;
+
+		sprintf(fnic2->msix[FNIC2_MSIX_ERR_NOTIFY].devname,
+			"%.11s-err-notify", fnic2->name);
+		fnic2->msix[FNIC2_MSIX_ERR_NOTIFY].isr =
+			fnic2_isr_msix_err_notify;
+		fnic2->msix[FNIC2_MSIX_ERR_NOTIFY].devid = fnic2;
+
+		for (i = 0; i < ARRAY_SIZE(fnic2->msix); i++) {
+			err = request_irq(fnic2->msix_entry[i].vector,
+					  fnic2->msix[i].isr, 0,
+					  fnic2->msix[i].devname,
+					  fnic2->msix[i].devid);
+			if (err) {
+				pr_err("MSIX: request_irq failed %d\n",
+					err);
+				fnic2_free_intr(fnic2);
+				break;
+			}
+			fnic2->msix[i].requested = 1;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return err;
+}
+
+int fnic2_set_intr_mode(struct fnic2 *fnic2)
+{
+	unsigned int n = ARRAY_SIZE(fnic2->rq);
+	unsigned int m = ARRAY_SIZE(fnic2->wq);
+	unsigned int o = ARRAY_SIZE(fnic2->wq_copy);
+	unsigned int i;
+
+	/*
+	 * Set interrupt mode (INTx, MSI, MSI-X) depending
+	 * system capabilities.
+	 *
+	 * Try MSI-X first
+	 *
+	 * We need n RQs, m WQs, o Copy WQs, n+m+o CQs, and n+m+o+1 INTRs
+	 * (last INTR is used for WQ/RQ errors and notification area)
+	 */
+
+	WARN_ON(ARRAY_SIZE(fnic2->msix_entry) < n + m + o + 1);
+	for (i = 0; i < n + m + o + 1; i++)
+		fnic2->msix_entry[i].entry = i;
+
+	if (fnic2->rq_count >= n &&
+	    fnic2->raw_wq_count >= m &&
+	    fnic2->wq_copy_count >= o &&
+	    fnic2->cq_count >= n + m + o) {
+		if (!pci_enable_msix_exact(fnic2->pdev, fnic2->msix_entry,
+				    n + m + o + 1)) {
+			fnic2->rq_count = n;
+			fnic2->raw_wq_count = m;
+			fnic2->wq_copy_count = o;
+			fnic2->wq_count = m + o;
+			fnic2->cq_count = n + m + o;
+			fnic2->intr_count = n + m + o + 1;
+			fnic2->err_intr_offset = FNIC2_MSIX_ERR_NOTIFY;
+
+			pr_debug("Using MSI-X Interrupts\n");
+			vnic_dev_set_intr_mode(fnic2->vdev,
+					       VNIC_DEV_INTR_MODE_MSIX);
+			return 0;
+		}
+	}
+
+	/*
+	 * Next try MSI
+	 * We need 1 RQ, 1 WQ, 1 WQ_COPY, 3 CQs, and 1 INTR
+	 */
+	if (fnic2->rq_count >= 1 &&
+	    fnic2->raw_wq_count >= 1 &&
+	    fnic2->wq_copy_count >= 1 &&
+	    fnic2->cq_count >= 3 &&
+	    fnic2->intr_count >= 1 &&
+	    !pci_enable_msi(fnic2->pdev)) {
+
+		fnic2->rq_count = 1;
+		fnic2->raw_wq_count = 1;
+		fnic2->wq_copy_count = 1;
+		fnic2->wq_count = 2;
+		fnic2->cq_count = 3;
+		fnic2->intr_count = 1;
+		fnic2->err_intr_offset = 0;
+
+		pr_debug("Using MSI Interrupts\n");
+		vnic_dev_set_intr_mode(fnic2->vdev, VNIC_DEV_INTR_MODE_MSI);
+
+		return 0;
+	}
+
+	/*
+	 * Next try INTx
+	 * We need 1 RQ, 1 WQ, 1 WQ_COPY, 3 CQs, and 3 INTRs
+	 * 1 INTR is used for all 3 queues, 1 INTR for queue errors
+	 * 1 INTR for notification area
+	 */
+
+	if (fnic2->rq_count >= 1 &&
+	    fnic2->raw_wq_count >= 1 &&
+	    fnic2->wq_copy_count >= 1 &&
+	    fnic2->cq_count >= 3 &&
+	    fnic2->intr_count >= 3) {
+
+		fnic2->rq_count = 1;
+		fnic2->raw_wq_count = 1;
+		fnic2->wq_copy_count = 1;
+		fnic2->cq_count = 3;
+		fnic2->intr_count = 3;
+
+		pr_debug("Using Legacy Interrupts\n");
+		vnic_dev_set_intr_mode(fnic2->vdev, VNIC_DEV_INTR_MODE_INTX);
+
+		return 0;
+	}
+
+	vnic_dev_set_intr_mode(fnic2->vdev, VNIC_DEV_INTR_MODE_UNKNOWN);
+
+	return -EINVAL;
+}
+
+void fnic2_clear_intr_mode(struct fnic2 *fnic2)
+{
+	switch (vnic_dev_get_intr_mode(fnic2->vdev)) {
+	case VNIC_DEV_INTR_MODE_MSIX:
+		pci_disable_msix(fnic2->pdev);
+		break;
+	case VNIC_DEV_INTR_MODE_MSI:
+		pci_disable_msi(fnic2->pdev);
+		break;
+	default:
+		break;
+	}
+
+	vnic_dev_set_intr_mode(fnic2->vdev, VNIC_DEV_INTR_MODE_INTX);
+}
diff --git a/drivers/staging/fnic2/src/fnic2_res.c b/drivers/staging/fnic2/src/fnic2_res.c
new file mode 100644
index 0000000..65b9a26
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_res.c
@@ -0,0 +1,430 @@
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
+#include "wq_enet_desc.h"
+#include "rq_enet_desc.h"
+#include "cq_enet_desc.h"
+#include "vnic_resource.h"
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_rq.h"
+#include "vnic_cq.h"
+#include "vnic_intr.h"
+#include "vnic_stats.h"
+#include "vnic_nic.h"
+#include "fnic2.h"
+
+int fnic2_get_vnic_config(struct fnic2 *fnic2)
+{
+	struct vnic_fc_config *c = &fnic2->config;
+	int err;
+
+#define GET_CONFIG(m) \
+	do { \
+		err = vnic_dev_spec(fnic2->vdev, \
+				    offsetof(struct vnic_fc_config, m), \
+				    sizeof(c->m), &c->m); \
+		if (err) { \
+			pr_err("Error getting %s, %d\n", #m, \
+				     err); \
+			return err; \
+		} \
+	} while (0);
+
+	GET_CONFIG(node_wwn);
+	GET_CONFIG(port_wwn);
+	GET_CONFIG(wq_enet_desc_count);
+	GET_CONFIG(wq_copy_desc_count);
+	GET_CONFIG(rq_desc_count);
+	GET_CONFIG(maxdatafieldsize);
+	GET_CONFIG(ed_tov);
+	GET_CONFIG(ra_tov);
+	GET_CONFIG(intr_timer);
+	GET_CONFIG(intr_timer_type);
+	GET_CONFIG(flags);
+	GET_CONFIG(flogi_retries);
+	GET_CONFIG(flogi_timeout);
+	GET_CONFIG(plogi_retries);
+	GET_CONFIG(plogi_timeout);
+	GET_CONFIG(io_throttle_count);
+	GET_CONFIG(link_down_timeout);
+	GET_CONFIG(port_down_timeout);
+	GET_CONFIG(port_down_io_retries);
+	GET_CONFIG(luns_per_tgt);
+
+	c->wq_enet_desc_count =
+		min_t(uint32_t, VNIC_FNIC2_WQ_DESCS_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_WQ_DESCS_MIN,
+			    c->wq_enet_desc_count));
+	c->wq_enet_desc_count = ALIGN(c->wq_enet_desc_count, 16);
+
+	c->wq_copy_desc_count =
+		min_t(uint32_t, VNIC_FNIC2_WQ_COPY_DESCS_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_WQ_COPY_DESCS_MIN,
+			    c->wq_copy_desc_count));
+	c->wq_copy_desc_count = ALIGN(c->wq_copy_desc_count, 16);
+
+	c->rq_desc_count =
+		min_t(uint32_t, VNIC_FNIC2_RQ_DESCS_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_RQ_DESCS_MIN,
+			    c->rq_desc_count));
+	c->rq_desc_count = ALIGN(c->rq_desc_count, 16);
+
+	c->maxdatafieldsize =
+		min_t(uint16_t, VNIC_FNIC2_MAXDATAFIELDSIZE_MAX,
+		      max_t(uint16_t, VNIC_FNIC2_MAXDATAFIELDSIZE_MIN,
+			    c->maxdatafieldsize));
+	c->ed_tov =
+		min_t(uint32_t, VNIC_FNIC2_EDTOV_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_EDTOV_MIN,
+			    c->ed_tov));
+
+	c->ra_tov =
+		min_t(uint32_t, VNIC_FNIC2_RATOV_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_RATOV_MIN,
+			    c->ra_tov));
+
+	c->flogi_retries =
+		min_t(uint32_t, VNIC_FNIC2_FLOGI_RETRIES_MAX, c->flogi_retries);
+
+	c->flogi_timeout =
+		min_t(uint32_t, VNIC_FNIC2_FLOGI_TIMEOUT_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_FLOGI_TIMEOUT_MIN,
+			    c->flogi_timeout));
+
+	c->plogi_retries =
+		min_t(uint32_t, VNIC_FNIC2_PLOGI_RETRIES_MAX, c->plogi_retries);
+
+	c->plogi_timeout =
+		min_t(uint32_t, VNIC_FNIC2_PLOGI_TIMEOUT_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_PLOGI_TIMEOUT_MIN,
+			    c->plogi_timeout));
+
+	c->io_throttle_count =
+		min_t(uint32_t, VNIC_FNIC2_IO_THROTTLE_COUNT_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_IO_THROTTLE_COUNT_MIN,
+			    c->io_throttle_count));
+
+	c->link_down_timeout =
+		min_t(uint32_t, VNIC_FNIC2_LINK_DOWN_TIMEOUT_MAX,
+		      c->link_down_timeout);
+
+	c->port_down_timeout =
+		min_t(uint32_t, VNIC_FNIC2_PORT_DOWN_TIMEOUT_MAX,
+		      c->port_down_timeout);
+
+	c->port_down_io_retries =
+		min_t(uint32_t, VNIC_FNIC2_PORT_DOWN_IO_RETRIES_MAX,
+		      c->port_down_io_retries);
+
+	c->luns_per_tgt =
+		min_t(uint32_t, VNIC_FNIC2_LUNS_PER_TARGET_MAX,
+		      max_t(uint32_t, VNIC_FNIC2_LUNS_PER_TARGET_MIN,
+			    c->luns_per_tgt));
+
+	c->intr_timer = min_t(uint16_t, VNIC_INTR_TIMER_MAX, c->intr_timer);
+	c->intr_timer_type = c->intr_timer_type;
+
+	pr_info("vNIC wq/wq_copy/rq %d/%d/%d\n",
+		c->wq_enet_desc_count, c->wq_copy_desc_count,
+		c->rq_desc_count);
+	pr_info("vNIC node wwn %llx port wwn %llx\n",
+		c->node_wwn, c->port_wwn);
+	pr_info("vNIC ed_tov %d ra_tov %d\n",
+		c->ed_tov, c->ra_tov);
+	pr_info("vNIC mtu %d intr timer %d\n",
+		c->maxdatafieldsize, c->intr_timer);
+	pr_info("vNIC flags 0x%x luns per tgt %d\n",
+		c->flags, c->luns_per_tgt);
+	pr_info("vNIC flogi_retries %d flogi timeout %d\n",
+		c->flogi_retries, c->flogi_timeout);
+	pr_info("vNIC plogi retries %d plogi timeout %d\n",
+		c->plogi_retries, c->plogi_timeout);
+	pr_info("vNIC io throttle count %d link dn timeout %d\n",
+		c->io_throttle_count, c->link_down_timeout);
+	pr_info("vNIC port dn io retries %d port dn timeout %d\n",
+		c->port_down_io_retries, c->port_down_timeout);
+	return 0;
+}
+
+int fnic2_set_nic_config(struct fnic2 *fnic2, uint8_t rss_default_cpu,
+			 uint8_t rss_hash_type,
+			 uint8_t rss_hash_bits, uint8_t rss_base_cpu, uint8_t rss_enable,
+			 uint8_t tso_ipid_split_en, uint8_t ig_vlan_strip_en)
+{
+	uint64_t a0, a1;
+	uint32_t nic_cfg;
+	int wait = 1000;
+
+	vnic_set_nic_cfg(&nic_cfg, rss_default_cpu,
+		rss_hash_type, rss_hash_bits, rss_base_cpu,
+		rss_enable, tso_ipid_split_en, ig_vlan_strip_en);
+
+	a0 = nic_cfg;
+	a1 = 0;
+
+	return vnic_dev_cmd(fnic2->vdev, CMD_NIC_CFG, &a0, &a1, wait);
+}
+
+void fnic2_get_res_counts(struct fnic2 *fnic2)
+{
+	fnic2->wq_count = vnic_dev_get_res_count(fnic2->vdev, RES_TYPE_WQ);
+	fnic2->raw_wq_count = fnic2->wq_count - 1;
+	fnic2->wq_copy_count = fnic2->wq_count - fnic2->raw_wq_count;
+	fnic2->rq_count = vnic_dev_get_res_count(fnic2->vdev, RES_TYPE_RQ);
+	fnic2->cq_count = vnic_dev_get_res_count(fnic2->vdev, RES_TYPE_CQ);
+	fnic2->intr_count = vnic_dev_get_res_count(fnic2->vdev,
+		RES_TYPE_INTR_CTRL);
+}
+
+void fnic2_free_vnic_resources(struct fnic2 *fnic2)
+{
+	unsigned int i;
+
+	for (i = 0; i < fnic2->raw_wq_count; i++)
+		vnic_wq_free(&fnic2->wq[i]);
+
+	for (i = 0; i < fnic2->wq_copy_count; i++)
+		vnic_wq_copy_free(&fnic2->wq_copy[i]);
+
+	for (i = 0; i < fnic2->rq_count; i++)
+		vnic_rq_free(&fnic2->rq[i]);
+
+	for (i = 0; i < fnic2->cq_count; i++)
+		vnic_cq_free(&fnic2->cq[i]);
+
+	for (i = 0; i < fnic2->intr_count; i++)
+		vnic_intr_free(&fnic2->intr[i]);
+}
+
+int fnic2_alloc_vnic_resources(struct fnic2 *fnic2)
+{
+	enum vnic_dev_intr_mode intr_mode;
+	unsigned int mask_on_assertion;
+	unsigned int interrupt_offset;
+	unsigned int error_interrupt_enable;
+	unsigned int error_interrupt_offset;
+	unsigned int i, cq_index;
+	unsigned int wq_copy_cq_desc_count;
+	int err;
+
+	intr_mode = vnic_dev_get_intr_mode(fnic2->vdev);
+
+	pr_info("vNIC interrupt mode: %s\n",
+		     intr_mode == VNIC_DEV_INTR_MODE_INTX ? "legacy PCI INTx" :
+		     intr_mode == VNIC_DEV_INTR_MODE_MSI ? "MSI" :
+		     intr_mode == VNIC_DEV_INTR_MODE_MSIX ?
+		     "MSI-X" : "unknown");
+
+	pr_info("vNIC resources avail: wq %d cp_wq %d raw_wq %d rq %d cq %d intr %d\n",
+		     fnic2->wq_count, fnic2->wq_copy_count, fnic2->raw_wq_count,
+		     fnic2->rq_count, fnic2->cq_count, fnic2->intr_count);
+
+	pr_info("Copy WQ desc count: %d\n",
+		fnic2->config.wq_copy_desc_count);
+
+	/* Allocate Raw WQ used for FCS frames */
+	for (i = 0; i < fnic2->raw_wq_count; i++) {
+		err = vnic_wq_alloc(fnic2->vdev, &fnic2->wq[i], i,
+			fnic2->config.wq_enet_desc_count,
+			sizeof(struct wq_enet_desc));
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	/* Allocate Copy WQs used for SCSI IOs */
+	for (i = 0; i < fnic2->wq_copy_count; i++) {
+		err = vnic_wq_copy_alloc(fnic2->vdev, &fnic2->wq_copy[i],
+			(fnic2->raw_wq_count + i),
+			fnic2->config.wq_copy_desc_count,
+			sizeof(struct fcpio_host_req));
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	/* RQ for receiving FCS and FCP frames */
+	for (i = 0; i < fnic2->rq_count; i++) {
+		err = vnic_rq_alloc(fnic2->vdev, &fnic2->rq[i], i,
+			fnic2->config.rq_desc_count,
+			sizeof(struct rq_enet_desc));
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	/* CQ for each RQ */
+	for (i = 0; i < fnic2->rq_count; i++) {
+		cq_index = i;
+		err = vnic_cq_alloc(fnic2->vdev,
+			&fnic2->cq[cq_index], cq_index,
+			fnic2->config.rq_desc_count,
+			sizeof(struct cq_enet_rq_desc));
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	/* CQ for each WQ */
+	for (i = 0; i < fnic2->raw_wq_count; i++) {
+		cq_index = fnic2->rq_count + i;
+		err = vnic_cq_alloc(fnic2->vdev, &fnic2->cq[cq_index], cq_index,
+			fnic2->config.wq_enet_desc_count,
+			sizeof(struct cq_enet_wq_desc));
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	/* CQ for each COPY WQ */
+	wq_copy_cq_desc_count = (fnic2->config.wq_copy_desc_count * 3);
+	for (i = 0; i < fnic2->wq_copy_count; i++) {
+		cq_index = fnic2->raw_wq_count + fnic2->rq_count + i;
+		err = vnic_cq_alloc(fnic2->vdev, &fnic2->cq[cq_index],
+			cq_index,
+			wq_copy_cq_desc_count,
+			sizeof(struct fcpio_fw_req));
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	for (i = 0; i < fnic2->intr_count; i++) {
+		err = vnic_intr_alloc(fnic2->vdev, &fnic2->intr[i], i);
+		if (err)
+			goto err_out_cleanup;
+	}
+
+	fnic2->legacy_pba = vnic_dev_get_res(fnic2->vdev,
+				RES_TYPE_INTR_PBA_LEGACY, 0);
+
+	if (!fnic2->legacy_pba && intr_mode == VNIC_DEV_INTR_MODE_INTX) {
+		pr_info("Failed to hook legacy pba resource\n");
+		err = -ENODEV;
+		goto err_out_cleanup;
+	}
+
+	/*
+	 * Init RQ/WQ resources.
+	 *
+	 * RQ[0 to n-1] point to CQ[0 to n-1]
+	 * WQ[0 to m-1] point to CQ[n to n+m-1]
+	 * WQ_COPY[0 to k-1] points to CQ[n+m to n+m+k-1]
+	 *
+	 * Note for copy wq we always initialize with cq_index = 0
+	 *
+	 * Error interrupt is not enabled for MSI.
+	 */
+
+	switch (intr_mode) {
+	case VNIC_DEV_INTR_MODE_INTX:
+	case VNIC_DEV_INTR_MODE_MSIX:
+		error_interrupt_enable = 1;
+		error_interrupt_offset = fnic2->err_intr_offset;
+		break;
+	default:
+		error_interrupt_enable = 0;
+		error_interrupt_offset = 0;
+		break;
+	}
+
+	for (i = 0; i < fnic2->rq_count; i++) {
+		cq_index = i;
+		vnic_rq_init(&fnic2->rq[i],
+			     cq_index,
+			     error_interrupt_enable,
+			     error_interrupt_offset);
+	}
+
+	for (i = 0; i < fnic2->raw_wq_count; i++) {
+		cq_index = i + fnic2->rq_count;
+		vnic_wq_init(&fnic2->wq[i],
+			     cq_index,
+			     error_interrupt_enable,
+			     error_interrupt_offset);
+	}
+
+	for (i = 0; i < fnic2->wq_copy_count; i++) {
+		vnic_wq_copy_init(&fnic2->wq_copy[i],
+				  0 /* cq_index 0 - always */,
+				  error_interrupt_enable,
+				  error_interrupt_offset);
+	}
+
+	for (i = 0; i < fnic2->cq_count; i++) {
+
+		switch (intr_mode) {
+		case VNIC_DEV_INTR_MODE_MSIX:
+			interrupt_offset = i;
+			break;
+		default:
+			interrupt_offset = 0;
+			break;
+		}
+
+		vnic_cq_init(&fnic2->cq[i],
+			0 /* flow_control_enable */,
+			1 /* color_enable */,
+			0 /* cq_head */,
+			0 /* cq_tail */,
+			1 /* cq_tail_color */,
+			1 /* interrupt_enable */,
+			1 /* cq_entry_enable */,
+			0 /* cq_message_enable */,
+			interrupt_offset,
+			0 /* cq_message_addr */);
+	}
+
+	/*
+	 * Init INTR resources
+	 *
+	 * mask_on_assertion is not used for INTx due to the level-
+	 * triggered nature of INTx
+	 */
+
+	switch (intr_mode) {
+	case VNIC_DEV_INTR_MODE_MSI:
+	case VNIC_DEV_INTR_MODE_MSIX:
+		mask_on_assertion = 1;
+		break;
+	default:
+		mask_on_assertion = 0;
+		break;
+	}
+
+	for (i = 0; i < fnic2->intr_count; i++) {
+		vnic_intr_init(&fnic2->intr[i],
+			fnic2->config.intr_timer,
+			fnic2->config.intr_timer_type,
+			mask_on_assertion);
+	}
+
+	/* init the stats memory by making the first call here */
+	err = vnic_dev_stats_dump(fnic2->vdev, &fnic2->stats);
+	if (err) {
+		pr_info("vnic_dev_stats_dump failed - 0x%x\n", err);
+		goto err_out_cleanup;
+	}
+
+	/* Clear LIF stats */
+	vnic_dev_stats_clear(fnic2->vdev);
+
+	return 0;
+
+err_out_cleanup:
+	fnic2_free_vnic_resources(fnic2);
+
+	return err;
+}
diff --git a/drivers/staging/fnic2/src/fnic2_res.h b/drivers/staging/fnic2/src/fnic2_res.h
new file mode 100644
index 0000000..dab106c
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_res.h
@@ -0,0 +1,120 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2017 Cisco Systems, Inc.  All rights reserved.
+ */
+#ifndef _FNIC2_RES_H_
+#define _FNIC2_RES_H_
+
+#include "wq_enet_desc.h"
+#include "rq_enet_desc.h"
+#include "vnic_wq.h"
+#include "vnic_rq.h"
+#include "fcpio.h"
+#include "vnic_wq_copy.h"
+#include "vnic_cq_copy.h"
+#include "fnic2_fdls.h"
+
+static inline void fnic2_queue_wq_desc(struct vnic_wq *wq,
+				       void *os_buf, dma_addr_t dma_addr,
+				       unsigned int len, unsigned int fc_eof,
+				       int vlan_tag_insert,
+				       unsigned int vlan_tag,
+				       int cq_entry, int sop, int eop)
+{
+	struct wq_enet_desc *desc = vnic_wq_next_desc(wq);
+
+	wq_enet_desc_enc(desc,
+			 (uint64_t)dma_addr | VNIC_PADDR_TARGET,
+			 (uint16_t)len,
+			 0, /* mss_or_csum_offset */
+			 (uint16_t)fc_eof,
+			 0, /* offload_mode */
+			 (uint8_t)eop, (uint8_t)cq_entry,
+			 1, /* fcoe_encap */
+			 (uint8_t)vlan_tag_insert,
+			 (uint16_t)vlan_tag,
+			 0 /* loopback */);
+
+	vnic_wq_post(wq, os_buf, dma_addr, len, sop, eop);
+}
+
+static inline void fnic2_queue_wq_copy_desc_flogi_reg(struct vnic_wq_copy *wq,
+						      uint32_t fcpio_tag, uint8_t format,
+						      uint32_t s_id, uint8_t *gw_mac)
+{
+	struct fcpio_host_req *desc = vnic_wq_copy_next_desc(wq);
+
+	desc->hdr.type = FCPIO_FLOGI_REG;     /* enum fcpio_type */
+	desc->hdr.status = 0;                 /* header status entry */
+	desc->hdr._resvd = 0;                 /* reserved */
+	desc->hdr.fcpio_tag = fcpio_tag;      /* id for this request */
+
+	desc->u.flogi_reg.format = format;
+	desc->u.flogi_reg._resvd = 0;
+	hton24(desc->u.flogi_reg.s_id, s_id);
+	memcpy(desc->u.flogi_reg.gateway_mac, gw_mac, ETH_ALEN);
+
+	vnic_wq_copy_post(wq);
+}
+
+static inline void fnic2_queue_wq_copy_desc_fip_reg(struct vnic_wq_copy *wq,
+						    uint32_t fcpio_tag, uint32_t s_id,
+						    uint8_t *fcf_mac, uint8_t *ha_mac,
+						    uint32_t r_a_tov, uint32_t e_d_tov)
+{
+	struct fcpio_host_req *desc = vnic_wq_copy_next_desc(wq);
+
+	desc->hdr.type = FCPIO_FLOGI_FIP_REG; /* enum fcpio_type */
+	desc->hdr.status = 0;                 /* header status entry */
+	desc->hdr._resvd = 0;                 /* reserved */
+	desc->hdr.fcpio_tag = fcpio_tag;      /* id for this request */
+
+	desc->u.flogi_fip_reg._resvd0 = 0;
+	hton24(desc->u.flogi_fip_reg.s_id, s_id);
+	memcpy(desc->u.flogi_fip_reg.fcf_mac, fcf_mac, ETH_ALEN);
+	desc->u.flogi_fip_reg._resvd1 = 0;
+	desc->u.flogi_fip_reg.r_a_tov = r_a_tov;
+	desc->u.flogi_fip_reg.e_d_tov = e_d_tov;
+	memcpy(desc->u.flogi_fip_reg.ha_mac, ha_mac, ETH_ALEN);
+	desc->u.flogi_fip_reg._resvd2 = 0;
+
+	vnic_wq_copy_post(wq);
+}
+
+static inline void fnic2_queue_wq_copy_desc_fw_reset(struct vnic_wq_copy *wq,
+						     uint32_t fcpio_tag)
+{
+	struct fcpio_host_req *desc = vnic_wq_copy_next_desc(wq);
+
+	desc->hdr.type = FCPIO_RESET;     /* enum fcpio_type */
+	desc->hdr.status = 0;             /* header status entry */
+	desc->hdr._resvd = 0;             /* reserved */
+	desc->hdr.fcpio_tag = fcpio_tag;  /* id for this request */
+
+	vnic_wq_copy_post(wq);
+}
+
+static inline void fnic2_queue_rq_desc(struct vnic_rq *rq,
+				       void *os_buf, dma_addr_t dma_addr,
+				       uint16_t len)
+{
+	struct rq_enet_desc *desc = vnic_rq_next_desc(rq);
+
+	rq_enet_desc_enc(desc,
+		(uint64_t)dma_addr | VNIC_PADDR_TARGET,
+		RQ_ENET_TYPE_ONLY_SOP,
+		(uint16_t)len);
+
+	vnic_rq_post(rq, os_buf, 0, dma_addr, len);
+}
+
+int fnic2_get_vnic_config(struct fnic2 *);
+int fnic2_alloc_vnic_resources(struct fnic2 *);
+void fnic2_free_vnic_resources(struct fnic2 *);
+void fnic2_get_res_counts(struct fnic2 *);
+int fnic2_set_nic_config(struct fnic2 *fnic2, uint8_t rss_default_cpu,
+			 uint8_t rss_hash_type, uint8_t rss_hash_bits, uint8_t rss_base_cpu,
+			 uint8_t rss_enable, uint8_t tso_ipid_split_en,
+			 uint8_t ig_vlan_strip_en);
+
+#endif /* _FNIC2_RES_H_ */
-- 
1.8.3.1
