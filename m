Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx49yyMZHmmqWn6IXkUdpR1uayrQA4KkRI8J9uGlNAqeqU1t07gMFj6PF1nYPzKWFQXmyF1Eo
ARC-Seal: i=1; a=rsa-sha256; t=1522963052; cv=none;
        d=google.com; s=arc-20160816;
        b=abYkfdgupsk+9FjJx3F926mwdKU58iz9JTViQMjJr1h+xPKyJSG6hAtbM37EMl8R1P
         WYdHQlB9pV9grSjoAqQRpwmMvXMCKHlm6qAP/fXUtr1Z22AZrnljg+QdX5UBqZGka8Km
         gYhn+6kfBunaIHvOQhPbi2pT8HDgdDBzO/+oauNhiYGTaqfCALwK45BDwl/t7Hyqb69R
         GyuzOi4qG+ReJnoo2HbNNsXJZ0DAsjUNegjpn3DC1NTVk4U+A9zWykfGvucMgRCXnLy5
         opS0Y37BDKUDYqoPbmtpdUPslJ+CaO8gKLKtuOpuzWF7gvRneZv7PrgHGnFT7lbgDGa3
         6ADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=P75YwNPBmDuPgNqm9/HBBHkL/TOLyeer/mISq+obdiU=;
        b=L/Z592Nb8knv8UpLTGIK9pgbfzJ0A7lfbuDCQMY5PDsGJJVFyUsgHuVGLDHjDfwcMg
         XSa2vtWOrQADUDlY0jrq0jydKGQtgQL+ymGhGUZWUDRNyou1P0NxPpb0kh5zPWb113q0
         dDB01lKyz4MDpszJn68zbIE6FUpo/Z6PMk+a/tE59/p1pz7DgHSgUEJxjizYPAkJuqEC
         1WdzazYw/UMHnpL3yGuTto+y7YySrmR1YD47JejY5FEJs0H6A7OAIiVnwxg7ukLsdVYI
         rzLr7xo78nj5QXyEHe9hxAliD9x6MnRcFcShOgdoszc0pxkrfV+oZmmX/Wd3pv9/+yAd
         6pyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=LCaS8n3P;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.94 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=LCaS8n3P;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.94 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94248464"
Date: Thu, 5 Apr 2018 14:20:17 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 05/10] staging: fnic2 add LIO interface
Message-ID: <20180405212017.GF12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942506165863565?=
X-GMAIL-MSGID: =?utf-8?q?1596942506165863565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contains structures and callback functions
for communicating with LIO.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/fnic2_lio.c | 815 ++++++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/fnic2_lio.h | 113 +++++
 2 files changed, 928 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/fnic2_lio.c
 create mode 100644 drivers/staging/fnic2/src/fnic2_lio.h

diff --git a/drivers/staging/fnic2/src/fnic2_lio.c b/drivers/staging/fnic2/src/fnic2_lio.c
new file mode 100644
index 0000000..64ca5d2
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_lio.c
@@ -0,0 +1,815 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2017 Cisco Systems, Inc.  All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <generated/utsrelease.h>
+#include <linux/utsname.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/configfs.h>
+#include <linux/ctype.h>
+#include <asm/unaligned.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_common.h>
+#include <scsi/scsi_proto.h>
+#include <scsi/fc/fc_fcp.h>
+#include "fnic2.h"
+#include "fnic2_lio.h"
+
+extern struct fnic2 *find_fnic2_wwpn(uint64_t wwpn);
+extern int fnic2_send_to_fw(struct fnic2_cmd *tcmd, int req_type);
+extern void fnic2_free_fw_res(struct fnic2_cmd *tcmd);
+extern void fnic2_free_tcmd(struct fnic2_cmd *tcmd);
+
+#define FT_VERSION "0.1"
+
+static const struct target_core_fabric_ops fnic2_ops;
+
+/*
+ * Parse WWN.
+ * If strict, we require lower-case hex and colon separators to be sure
+ * the name is the same as what would be generated by ft_format_wwn()
+ * so the name and wwn are mapped one-to-one.
+ */
+static ssize_t ft_parse_wwn(const char *name, uint64_t *wwn, int strict)
+{
+	const char *cp;
+	char c;
+	uint32_t byte = 0;
+	uint32_t pos = 0;
+	uint32_t err;
+	int val;
+
+	*wwn = 0;
+	for (cp = name; cp < &name[FNIC2_NAMELEN - 1]; cp++) {
+		c = *cp;
+		if (c == '\n' && cp[1] == '\0')
+			continue;
+		if (strict && pos++ == 2 && byte++ < 7) {
+			pos = 0;
+			if (c == ':')
+				continue;
+			err = 1;
+			goto fail;
+		}
+		if (c == '\0') {
+			err = 2;
+			if (strict && byte != 8)
+				goto fail;
+			return cp - name;
+		}
+		err = 3;
+		val = hex_to_bin(c);
+		if (val < 0 || (strict && isupper(c)))
+			goto fail;
+		*wwn = (*wwn << 4) | val;
+	}
+	err = 4;
+fail:
+	pr_debug("err %u len %zu pos %u byte %u\n",
+		err, cp - name, pos, byte);
+	return -1;
+}
+
+static int fnic2_parse_wwpn(const char *wwn, uint64_t *wwpn)
+{
+	int i;
+	int shift = 60;
+	unsigned char c;
+	unsigned long long uint64_t = 0, d64;
+
+	for (i = 0; i < 23; i++) {
+		c = wwn[i];
+		if (c == ':')
+			continue;
+
+		if (c >= '0' && c <= '9') {
+			d64 = c - '0';
+		} else if (c >= 'A' && c <= 'F') {
+			d64 = 0xA + (c - 'A');
+		} else if (c >= 'a' && c <= 'f') {
+			d64 = 0xA + (c - 'a');
+		} else {
+			pr_err("Invalid WWPN %c\n", c);
+			return -1;
+		}
+
+		uint64_t = (d64 << shift) | uint64_t;
+		shift = shift - 4;
+	}
+	*wwpn = uint64_t;
+	return 0;
+
+}
+
+static ssize_t ft_format_wwn(char *buf, size_t len, uint64_t wwn)
+{
+	uint8_t b[8];
+
+	put_unaligned_be64(wwn, b);
+	return snprintf(buf, len,
+		 "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+		 b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7]);
+}
+
+static ssize_t ft_wwn_show(void *arg, char *buf)
+{
+	uint64_t *wwn = arg;
+	ssize_t len;
+
+	len = ft_format_wwn(buf, PAGE_SIZE - 2, *wwn);
+	buf[len++] = '\n';
+	return len;
+}
+
+static ssize_t ft_wwn_store(void *arg, const char *buf, size_t len)
+{
+	ssize_t ret;
+	uint64_t wwn;
+
+	ret = ft_parse_wwn(buf, &wwn, 0);
+	if (ret > 0)
+		*(uint64_t *)arg = wwn;
+	return ret;
+}
+
+/*
+ * ACL auth ops.
+ */
+
+static ssize_t ft_nacl_port_name_show(struct config_item *item, char *page)
+{
+	struct se_node_acl *se_nacl = acl_to_nacl(item);
+	struct ft_node_acl *acl = container_of(se_nacl,
+			struct ft_node_acl, se_node_acl);
+
+	return ft_wwn_show(&acl->node_auth.port_name, page);
+}
+
+static ssize_t ft_nacl_port_name_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct se_node_acl *se_nacl = acl_to_nacl(item);
+	struct ft_node_acl *acl = container_of(se_nacl,
+			struct ft_node_acl, se_node_acl);
+
+	return ft_wwn_store(&acl->node_auth.port_name, page, count);
+}
+
+static ssize_t ft_nacl_node_name_show(struct config_item *item,
+		char *page)
+{
+	struct se_node_acl *se_nacl = acl_to_nacl(item);
+	struct ft_node_acl *acl = container_of(se_nacl,
+			struct ft_node_acl, se_node_acl);
+
+	return ft_wwn_show(&acl->node_auth.node_name, page);
+}
+
+static ssize_t ft_nacl_node_name_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct se_node_acl *se_nacl = acl_to_nacl(item);
+	struct ft_node_acl *acl = container_of(se_nacl,
+			struct ft_node_acl, se_node_acl);
+
+	return ft_wwn_store(&acl->node_auth.node_name, page, count);
+}
+
+CONFIGFS_ATTR(ft_nacl_, node_name);
+CONFIGFS_ATTR(ft_nacl_, port_name);
+
+static ssize_t ft_nacl_tag_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s", acl_to_nacl(item)->acl_tag);
+}
+
+static ssize_t ft_nacl_tag_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct se_node_acl *se_nacl = acl_to_nacl(item);
+	int ret;
+
+	ret = core_tpg_set_initiator_node_tag(se_nacl->se_tpg, se_nacl, page);
+
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+CONFIGFS_ATTR(ft_nacl_, tag);
+
+static struct configfs_attribute *ft_nacl_base_attrs[] = {
+	&ft_nacl_attr_port_name,
+	&ft_nacl_attr_node_name,
+	&ft_nacl_attr_tag,
+	NULL,
+};
+
+/*
+ * ACL ops.
+ */
+
+static int ft_init_nodeacl(struct se_node_acl *nacl, const char *name)
+{
+	struct ft_node_acl *acl =
+		container_of(nacl, struct ft_node_acl, se_node_acl);
+	uint64_t wwpn;
+
+	pr_err("Creating ACL for %s\n", name);
+
+	if (ft_parse_wwn(name, &wwpn, 1) < 0)
+		return -EINVAL;
+	pr_err("Created ACL for %s %llx\n", name, wwpn);
+
+	acl->node_auth.port_name = wwpn;
+	return 0;
+}
+
+static ssize_t ft_wwn_version_show(struct config_item *item, char *page)
+{
+        return sprintf(page, "CISCO SYSTEMS, INC. " FT_VERSION " on %s/%s on "
+                ""UTS_RELEASE"\n",  utsname()->sysname, utsname()->machine);
+}
+
+CONFIGFS_ATTR_RO(ft_wwn_, version);
+
+static struct configfs_attribute *ft_wwn_attrs[] = {
+	&ft_wwn_attr_version,
+	NULL,
+};
+
+/* fabric */
+static int fnic2_check_true(struct se_portal_group *se_tpg)
+{
+	return 1;
+}
+
+static int fnic2_check_false(struct se_portal_group *se_tpg)
+{
+	return 0;
+}
+
+static char *fnic2_get_fabric_name(void)
+{
+	return "fnic2";
+}
+
+static char *fnic2_get_fabric_wwn(struct se_portal_group *se_tpg)
+{
+	struct fnic2_tpg *tpg = container_of(se_tpg,
+				struct fnic2_tpg, se_tpg);
+	struct fnic2_lio_lport *lport = tpg->lport;
+
+
+	return &lport->lport_name[0];
+}
+
+static uint16_t fnic2_get_tag(struct se_portal_group *se_tpg)
+{
+	struct fnic2_tpg *tpg = container_of(se_tpg,
+				struct fnic2_tpg, se_tpg);
+	return tpg->lport_tpgt;
+}
+
+static uint32_t fnic2_tpg_get_inst_index(struct se_portal_group *se_tpg)
+{
+	return 1;
+}
+
+static int fnic2_check_stop_free(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *tcmd = container_of(se_cmd,
+                struct fnic2_cmd, se_cmd);
+	pr_debug("check stop free for tag %x\n", tcmd->cmd_tag);
+	return target_put_sess_cmd(se_cmd);
+}
+
+static void fnic2_release_cmd(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *tcmd = container_of(se_cmd,
+		struct fnic2_cmd, se_cmd);
+
+	pr_debug("DEBUG %s: %x, is_write: %d, rx_id: %x\n",
+		__func__, tcmd->cmd_tag, tcmd->flags & FNIC2_TCMD_WRITECMD, tcmd->rx_id);
+
+	if (tcmd->se_cmd.t_data_sg)
+		pr_err("t_data_sg not NULL\n");
+	fnic2_free_tcmd(tcmd);
+
+	return;
+}
+
+static uint32_t fnic2_sess_get_index(struct se_session *se_sess)
+{
+	return 0;
+}
+
+static int fnic2_write_pending(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *tcmd = container_of(se_cmd,
+		struct fnic2_cmd, se_cmd);
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tcmd->lock, flags);
+
+	if (tcmd->flags & FNIC2_TCMD_ABORTED) {
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+
+	pr_debug("DEBUG write_pending tag: %x\n", tcmd->cmd_tag);
+
+	/* Check the se->cmd status and process accordingly */
+	if (se_cmd->scsi_status != SAM_STAT_GOOD) {
+		pr_err("ERROR fn: %s ln: %d, sts: %d\n",
+			__func__, __LINE__, se_cmd->scsi_status);
+		/* TBD send_resp or wait for q_sts? */
+		return 0;
+	}
+
+	tcmd->data_len_xfer = se_cmd->data_length;
+	if (tcmd->data_len_req != tcmd->data_len_xfer) {
+		/* TBD */
+		pr_err("ERROR fn: %s ln: %d\n", __func__, __LINE__);
+	}
+
+	tcmd->sgcnt = se_cmd->t_data_nents;
+	tcmd->sgl = se_cmd->t_data_sg;
+	tcmd->dma_direction = PCI_DMA_FROMDEVICE;
+
+	ret = fnic2_send_to_fw(tcmd, FCPIO_TCMD_RECV_DATA);
+
+	return ret;
+}
+
+static int fnic2_queue_status(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *tcmd = container_of(se_cmd,
+		struct fnic2_cmd, se_cmd);
+	unsigned long flags;
+
+	pr_debug("DEBUG queue_status tag: %x\n", tcmd->cmd_tag);
+
+	spin_lock_irqsave(&tcmd->lock, flags);
+
+	if (tcmd->flags & FNIC2_TCMD_ABORTED) {
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+
+	if (se_cmd->scsi_status != SAM_STAT_GOOD) {
+		pr_err("WARNING: Cmd %x SCSI Status Error: %x, cmd_tag: %x\n",
+			tcmd->ox_id, se_cmd->scsi_status, tcmd->cmd_tag);
+	}
+
+	fnic2_send_fcp_resp(tcmd);
+
+	/* Delete I/O timer if it is active */
+	if ((try_to_del_timer_sync(&tcmd->io_timer)) < 0)
+                pr_err("Could not delete timer on tcmd tag %x\n", tcmd->cmd_tag);
+
+	if (tcmd->flags & FNIC2_TCMD_WRITECMD)
+		fnic2_free_fw_res(tcmd);
+	else
+		transport_generic_free_cmd(se_cmd, 0);
+
+	return 0;
+}
+
+/*
+ * fnic2_queue_tm_rsp
+ * LIO has completed a task management command
+ * send a "bubble" command to fw that will be processed after
+ * all the aborted commands, then send the task mgmt response to initiator
+ */
+static void fnic2_queue_tm_rsp(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *tcmd = container_of(se_cmd,
+				 struct fnic2_cmd, se_cmd);
+	struct fnic2 *fnic2 = tcmd->fnic2;
+	unsigned long flags;
+	struct fcpio_host_req *host_req;
+        struct fcpio_host_req *desc;
+        struct vnic_wq_copy *wq;
+
+        pr_err("TMR RESPONSE se_cmd %pK tcmd %pK\n", se_cmd, tcmd);
+
+	spin_lock_irqsave(&tcmd->lock, flags);
+
+	if (tcmd->flags & (FNIC2_TCMD_IS_ABTS | FNIC2_TCMD_ABORTED)) {
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+
+        /* Fill the structure to send it to fw */
+        host_req = kzalloc(sizeof(struct fcpio_host_req), GFP_KERNEL);
+        WARN_ON(host_req == NULL);
+        host_req->hdr.type = FCPIO_TCMD_TASK_MGMT;
+        host_req->hdr.fcpio_tag = tcmd->cmd_tag;
+
+        spin_lock_irqsave(&fnic2->wq_copy_lock[0], flags);
+        /* Use the Copy WQ to send it to FW */
+        wq = &fnic2->wq_copy[0];
+
+        if (vnic_wq_copy_desc_avail(wq) <= fnic2->wq_copy_desc_low[0])
+                free_wq_copy_descs(fnic2, wq);
+
+        if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
+                pr_err("DEBUG ERROR no wq desc for free_cmd\n");
+                kfree(host_req);
+                spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+                return;
+        }
+
+        desc = vnic_wq_copy_next_desc(wq);
+        memcpy(desc, host_req, sizeof(struct fcpio_host_req));
+
+        vnic_wq_copy_post(wq);
+        spin_unlock_irqrestore(&fnic2->wq_copy_lock[0], flags);
+
+        kfree(host_req);
+}
+
+void fnic2_send_abort_to_lio(struct fnic2_cmd *abort_tcmd)
+{
+	int tmr_flags, ret;
+	struct fnic2_cmd *killed_tcmd = abort_tcmd->killed_tcmd;
+	struct fc_hdr *fchdr = (struct fc_hdr *)killed_tcmd->rx_frame;
+	struct fnic2 *fnic2 = killed_tcmd->fnic2;
+	struct fnic2_sess *sess;
+	uint32_t s_id;
+
+	s_id = ntoh24(fchdr->s_id);
+	sess = fnic2_find_sess_s_id(fnic2, s_id);
+
+	if (!sess) {
+	    // TBD cleanup
+	    return;
+	}
+
+	// TBD sanity check on killed_tcmd ???
+
+	tmr_flags = TARGET_SCF_ACK_KREF | TARGET_SCF_LOOKUP_LUN_FROM_TAG;
+
+	ret= target_submit_tmr(&abort_tcmd->se_cmd, sess->se_sess, NULL,
+			0,
+			killed_tcmd,
+			TMR_ABORT_TASK, GFP_ATOMIC,
+			killed_tcmd->cmd_tag,
+			tmr_flags);
+
+	if (ret) {
+		pr_err("%s submitting tmr failed\n", __func__);
+		/* LIO failed the ABTS req, but I/O will be
+		* handled by Lun Reset or I/O timer reaper
+		*/
+	}
+}
+
+/*
+ * fnic2_complete_tm_rsp
+ * fw has aborted all exchanges
+ * send the final task management function response to initiator
+ */
+void fnic2_complete_tm_rsp(struct fnic2_cmd *tcmd)
+{
+	struct se_cmd *se_cmd = &tcmd->se_cmd;
+        struct se_tmr_req *tmr = se_cmd->se_tmr_req;
+        enum fcp_resp_rsp_codes code;
+	unsigned long flags;
+
+        pr_err("TMR RESPONSE fw completed - se_cmd %pK tcmd %pK tmr %pK\n",
+                se_cmd, tcmd, tmr);
+
+	spin_lock_irqsave(&tcmd->lock, flags);
+
+	if (tcmd->flags & (FNIC2_TCMD_IS_ABTS | FNIC2_TCMD_ABORTED)) {
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+
+        switch (tmr->response) {
+        case TMR_FUNCTION_COMPLETE:
+                code = FCP_TMF_CMPL;
+                break;
+        case TMR_LUN_DOES_NOT_EXIST:
+                code = FCP_TMF_INVALID_LUN;
+                break;
+        case TMR_FUNCTION_REJECTED:
+                code = FCP_TMF_REJECTED;
+                break;
+        case TMR_TASK_DOES_NOT_EXIST:
+        case TMR_TASK_MGMT_FUNCTION_NOT_SUPPORTED:
+        default:
+                code = FCP_TMF_FAILED;
+                break;
+        }
+        pr_err("TMR RESPONSE fn %d resp %d fcp code %d\n",
+                  tmr->function, tmr->response, code);
+
+        fnic2_send_tmr_resp(tcmd, SAM_STAT_GOOD, code);
+
+        transport_generic_free_cmd(se_cmd, 0);
+}
+
+/*
+ * fnic2_aborted_task
+ * callback from LIO for each aborted real task (by ABTS or LUN RESET)
+ */
+static void fnic2_aborted_task(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *killed_tcmd = container_of(se_cmd, struct fnic2_cmd, se_cmd);
+	struct fnic2_cmd *abort_tcmd;
+
+	pr_err("tcmd %pK aborted by LIO\n", killed_tcmd);
+
+	if (killed_tcmd->flags & FNIC2_TCMD_ABORTED) {
+		/* ABTS path - already aborted with fw */
+		abort_tcmd = killed_tcmd->abort_tcmd;
+		transport_generic_free_cmd(&abort_tcmd->se_cmd, 0);
+	} else {
+		/* LUN RESET path - must abort with fw */
+		fnic2_send_abort_to_fw(killed_tcmd);
+	}
+}
+
+/*
+ * fnic2_fw_abort_done
+ * callback from fw for each aborted task (ABTS or LUN RESET)
+ */
+void fnic2_fw_abort_done(struct fnic2_cmd *tcmd)
+{
+	struct fnic2 *fnic2;
+	struct fc_hdr *fchdr;
+	struct fnic2_cmd *killed_tcmd;
+
+	pr_err("tcmd %pK aborted by fw\n", tcmd);
+
+	if (tcmd->flags & FNIC2_TCMD_IS_ABTS) {
+                /* ABTS path */
+		/* send ba_acc and abort with LIO */
+
+		killed_tcmd = tcmd->killed_tcmd;
+		// TBD killed_cmd sanity check
+
+		fnic2 = killed_tcmd->fnic2;
+		fchdr = (struct fc_hdr *)killed_tcmd->rx_frame;
+
+		fdls_send_ba_acc(&fnic2->lport, fchdr);
+		fnic2_send_abort_to_lio(tcmd);
+        }
+}
+
+/* configfs */
+
+static struct se_portal_group *fnic2_make_tpg(struct se_wwn *wwn,
+					      struct config_group *group,
+					      const char *name)
+{
+	struct fnic2_lio_lport *lport = container_of(wwn,
+			struct fnic2_lio_lport, lport_wwn);
+
+	struct fnic2_tpg *tpg;
+	unsigned long tpgt;
+	struct fnic2 *fnic2 = lport->fnic2;
+	int ret;
+
+	pr_debug("name: %s\n", name);
+
+	if (strstr(name, "tpgt_") != name)
+		return ERR_PTR(-EINVAL);
+	if (kstrtoul(name + 5, 10, &tpgt) || tpgt > UINT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	tpg = kzalloc(sizeof(struct fnic2_tpg), GFP_KERNEL);
+	if (!tpg) {
+		pr_err("Unable to allocate struct fnic2_tpg\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	tpg->lport = lport;
+	tpg->lport_tpgt = tpgt;
+
+	ret = core_tpg_register(wwn, &tpg->se_tpg, SCSI_PROTOCOL_FCP);
+	if (ret < 0) {
+		pr_err("Error returned by core_tpg_register: %d\n",
+			ret);
+		kfree(tpg);
+		return ERR_PTR(-EFAULT);
+	}
+
+	fnic2 = lport->fnic2;
+	fnic2->lio.tpg = tpg;
+
+	return &tpg->se_tpg;
+}
+
+static void fnic2_drop_tpg(struct se_portal_group *se_tpg)
+{
+	struct fnic2_tpg *tpg = container_of(se_tpg,
+				struct fnic2_tpg, se_tpg);
+
+	core_tpg_deregister(se_tpg);
+	kfree(tpg);
+}
+
+static struct se_wwn *fnic2_make_lport(struct target_fabric_configfs *tf,
+				       struct config_group *group,
+				       const char *name)
+{
+	struct fnic2 *fnic2;
+	struct fnic2_lio_lport *lport;
+	uint64_t wwpn;
+
+	if (!name) {
+		pr_err("%s Null lport name received\n", __func__);
+		return NULL;
+
+	}
+	pr_debug("%s: lport name %s\n", __func__, name);
+
+	if (fnic2_parse_wwpn(name, &wwpn) < 0)
+		return ERR_PTR(-EINVAL);
+
+	pr_debug("%s: wwpn %llx\n", __func__, wwpn);
+
+	fnic2 = find_fnic2_wwpn(wwpn);
+	if (!fnic2) {
+		pr_err("Could not find fnic2 with wwpn: %llx\n",
+			wwpn);
+		return ERR_PTR(-EINVAL);
+	}
+	if (fnic2->lio.lport) {
+		pr_err("%s: lport already created %llx\n",
+			__func__, wwpn);
+		return ERR_PTR(-EEXIST);
+	}
+	lport = kzalloc(sizeof(struct fnic2_lio_lport), GFP_KERNEL);
+	if (!lport) {
+		pr_err("Unable to allocate struct fnic2_lio_lport\n");
+		WARN_ON(1);
+		return ERR_PTR(-ENOMEM);
+	}
+	lport->lport_wwpn = wwpn;
+
+	fnic2->lio.lport = lport;
+	lport->fnic2 = fnic2;
+
+	return (&lport->lport_wwn);
+}
+
+int fnic2_write_pending_status(struct se_cmd *se_cmd)
+{
+	return 0;
+}
+
+void fnic2_set_default_node_attrs(struct se_node_acl *nacl)
+{
+	return;
+}
+
+int fnic2_get_cmd_state(struct se_cmd *se_cmd)
+{
+	return 0;
+}
+
+int fnic2_queue_data_in(struct se_cmd *se_cmd)
+{
+	struct fnic2_cmd *tcmd = container_of(se_cmd,
+		struct fnic2_cmd, se_cmd);
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tcmd->lock, flags);
+
+	if (tcmd->flags & (FNIC2_TCMD_IS_ABTS | FNIC2_TCMD_ABORTED)) {
+		spin_unlock_irqrestore(&tcmd->lock, flags);
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&tcmd->lock, flags);
+
+	pr_debug("DEBUG data_in tag: %x, sts: %x\n",
+		tcmd->cmd_tag, se_cmd->scsi_status);
+
+	/* Check the se->cmd status and process accordingly */
+	if (se_cmd->scsi_status != SAM_STAT_GOOD) {
+		/* TBD would LIO call data_in in case of error status? */
+		pr_err("Scsi status: %x, cmdtag: %d\n",
+			se_cmd->scsi_status, tcmd->cmd_tag);
+		return 0;
+	}
+
+	tcmd->data_len_xfer = se_cmd->data_length;
+
+	if (tcmd->data_len_xfer == 0) {
+		pr_debug("DEBUG Zero len Data tag: %x\n", tcmd->cmd_tag);
+		tcmd->rx_id = 0xffff;
+		fnic2_send_fcp_resp(tcmd);
+		transport_generic_free_cmd(&tcmd->se_cmd, 0);
+		return 0;
+	}
+
+	if (tcmd->data_len_req != tcmd->data_len_xfer) {
+		pr_debug("%s data_len_req: %d, data_len_xfer: %d\n",
+			__func__, tcmd->data_len_req, tcmd->data_len_xfer);
+	}
+	tcmd->sgcnt = se_cmd->t_data_nents;
+	tcmd->sgl = se_cmd->t_data_sg;
+	tcmd->dma_direction = PCI_DMA_TODEVICE;
+
+	ret = fnic2_send_to_fw(tcmd, FCPIO_TCMD_SEND_DATA);
+	return ret;
+}
+
+static void fnic2_drop_lport(struct se_wwn *wwn)
+{
+	struct fnic2_lio_lport *lport = container_of(wwn,
+				struct fnic2_lio_lport, lport_wwn);
+	struct fnic2 *fnic2;
+
+	/* Free from the corresponding fnic2 */
+	fnic2 = find_fnic2_wwpn(lport->lport_wwpn);
+	if (!fnic2) {
+		pr_err("%s: Unable to find fnic2 for the wwpn %llx\n",
+			__func__, lport->lport_wwpn);
+		return;
+	}
+	if (!fnic2->lio.lport) {
+		pr_err("%s lport does not exist %llx\n",
+			__func__, lport->lport_wwpn);
+		return;
+	}
+
+	fnic2->lio.lport = NULL;
+	kfree(lport);
+}
+
+
+/* Registration */
+
+static const struct target_core_fabric_ops fnic2_ops = {
+	.module                         	= THIS_MODULE,
+	.name                           	= "fnic2",
+	.node_acl_size				= sizeof(struct ft_node_acl),
+	.get_fabric_name                	= fnic2_get_fabric_name,
+	.tpg_get_wwn                    	= fnic2_get_fabric_wwn,
+	.tpg_get_tag                    	= fnic2_get_tag,
+	.tpg_check_demo_mode            	= fnic2_check_false,
+	.tpg_check_demo_mode_cache      	= fnic2_check_true,
+	.tpg_check_demo_mode_write_protect	= fnic2_check_false,
+	.tpg_check_prod_mode_write_protect	= fnic2_check_false,
+	.tpg_get_inst_index             	= fnic2_tpg_get_inst_index,
+	.check_stop_free			= fnic2_check_stop_free,
+	.release_cmd                    	= fnic2_release_cmd,
+	.sess_get_index                 	= fnic2_sess_get_index,
+	.sess_get_initiator_sid         	= NULL,
+	.write_pending                  	= fnic2_write_pending,
+	.write_pending_status           	= fnic2_write_pending_status,
+	.set_default_node_attributes    	= fnic2_set_default_node_attrs,
+	.get_cmd_state                  	= fnic2_get_cmd_state,
+	.queue_data_in                  	= fnic2_queue_data_in,
+	.queue_status                  		= fnic2_queue_status,
+	.queue_tm_rsp                   	= fnic2_queue_tm_rsp,
+	.aborted_task                   	= fnic2_aborted_task,
+	/*
+	 * Setup function pointers for generic logic in target_core_fabric_configfs.c
+	 */
+	.fabric_make_wwn                	= fnic2_make_lport,
+	.fabric_drop_wwn                	= fnic2_drop_lport,
+	.fabric_make_tpg                	= fnic2_make_tpg,
+	.fabric_drop_tpg                	= fnic2_drop_tpg,
+	.fabric_init_nodeacl			= &ft_init_nodeacl,
+
+	.tfc_wwn_attrs                  	= ft_wwn_attrs,
+	.tfc_tpg_nacl_base_attrs        	= ft_nacl_base_attrs,
+};
+
+int fnic2_lio_init(void)
+{
+	int ret = 0;
+
+	ret = target_register_template(&fnic2_ops);
+	return ret;
+};
+
+void fnic2_lio_cleanup(void)
+{
+	target_unregister_template(&fnic2_ops);
+};
diff --git a/drivers/staging/fnic2/src/fnic2_lio.h b/drivers/staging/fnic2/src/fnic2_lio.h
new file mode 100644
index 0000000..82f7c01
--- /dev/null
+++ b/drivers/staging/fnic2/src/fnic2_lio.h
@@ -0,0 +1,113 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.
+ */
+#ifndef _FNIC2_LIO_H_
+#define _FNIC2_LIO_H_
+
+#define FNIC2_VERSION	"v0.1"
+#define FNIC2_NAMELEN	32
+
+#include <target/target_core_base.h>
+#include <target/target_core_fabric.h>
+
+enum fnic2_cmd_flags {
+	FNIC2_TCMD_ABORTED	= (1 << 0),
+	FNIC2_TCMD_IS_ABTS	= (1 << 1),
+	FNIC2_TCMD_WRITECMD	= (1 << 2)
+};
+
+struct fnic2_tpg {
+	/* FC lport target portal group tag for TCM */
+	uint16_t		lport_tpgt;
+	/* Pointer back to fnic2_lport */
+	struct fnic2_lio_lport	*lport;
+	/* Returned by fnic2_make_tpg() */
+	struct se_portal_group	se_tpg;
+};
+
+/*
+ * Node ID and authentication.
+ */
+struct ft_node_auth {
+	uint64_t	port_name;
+	uint64_t	node_name;
+};
+
+/*
+ * Node ACL for remote port session.
+ */
+struct ft_node_acl {
+	struct se_node_acl	se_node_acl;
+	struct ft_node_auth	node_auth;
+};
+
+
+struct fnic2_lio_lport {
+	/* Binary World Wide unique Port Name for FC Target Lport */
+	uint64_t	lport_wwpn;
+	/* ASCII formatted WWPN for FC Target Lport */
+	char		lport_name[FNIC2_NAMELEN];
+	/* Returned by fnic2_make_lport() */
+	struct se_wwn	lport_wwn;
+
+	struct fnic2	*fnic2;
+};
+
+struct fnic2_sess {
+	struct list_head	list;
+	struct se_session	*se_sess;
+	struct kref		kref;	/* ref for hash and outstanding I/Os */
+	struct fnic2_lio_lport	*lport;
+	struct fnic2_rport	*rport;
+	struct list_head	cmd_list;
+	struct fnic2		*fnic2;
+	struct fc_logo_req	timer_logo_req;
+	struct timer_list	sess_timer;
+};
+
+struct fnic2_lio {
+	struct fnic2_tpg	*tpg;
+	struct fnic2_lio_lport	*lport;
+	struct list_head	sess_list;
+	int			sess_count;
+};
+
+struct fnic2_cmd {
+	struct list_head	free_list;
+	struct fnic2		*fnic2;
+	struct fnic2_sess	*sess;
+	uint32_t		cmd_tag;
+	struct fnic2_cmd        *killed_tcmd;
+	struct fnic2_cmd        *abort_tcmd;
+	uint32_t                abort_tag;
+	struct se_cmd		se_cmd;
+	uint32_t		ox_id;
+	uint32_t                s_id;
+	uint16_t		rx_id;
+	uint8_t			flags;		/* See #define above */
+	uint8_t			data_dir;
+	uint32_t		data_len_req;	/* Requested Data Len */
+	struct scatterlist	*sgl;
+	int			sgcnt;
+	int			data_len_xfer;	/* Xfered Data Len */
+	uint8_t			sense_buf[TRANSPORT_SENSE_BUFFER];
+	void			*host_req;
+	void			*rx_frame;
+	int			frame_len;
+	int			sg_desc_count;
+	struct host_sg_desc	*sg_desc_va_unaligned;
+	struct host_sg_desc	*sg_desc_va;
+	uint64_t		sg_desc_pa;
+	int			dma_direction;
+
+	void			*kmap_addr[256];
+
+	struct work_struct	work;
+	struct fcpio_fw_req	fw_desc;
+
+	spinlock_t		lock;
+	struct timer_list	io_timer;
+};
+
+#endif /* _FNIC2_LIO_ */
-- 
1.8.3.1
