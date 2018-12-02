Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61149206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTDhgVUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61149206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeLBG7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:59:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43408 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:59:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so4798524pfk.10;
        Sat, 01 Dec 2018 22:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gUqqp6ntqbUTModFv8ymqQ+wmczs9IhawQehCqR6DXw=;
        b=uTDhgVUkKlSxoLSuefTKtDaGMMik6z2sJrnjGpvwwALgKsxq8O9T0WxLo/DyJC85Tz
         R/4w6vRBMxFU7/PEo/Ebz3+23GkNBdjzTUL7AULa4y4pPZLB0rWkwCQN8R0O9ll6U9iT
         lXzDPcIpct7r9CCzLpc0DciAmS81Mwwf34gB+xcHZF9YnVxyvCTeyaTqP7TcnRQVYgPD
         vvAalIdpDVjei0ZvOkdJC1+03MSNbXyn8C45Fy/A5Tckn834HvHuc/mVm9vGZjHc+J0c
         6bj0pN3g7Wl7kqKzGXILvtya3dBse9JC7RW+CvLewuWwfiazpxvLhpWtmEnZYU/S1hhI
         5/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gUqqp6ntqbUTModFv8ymqQ+wmczs9IhawQehCqR6DXw=;
        b=QxOTv0p9gEbsYzm4D9oXJqRlj0nUjBpdBJp7mmkNRHt85JpdbMeYhYD3Luw4eEv50U
         5zONbabp/vrWR3ZZ3gekRLfBRc8m6aTjDZXgANvZCwvDze6hIAz1fC04b0+lCrNHlcCu
         ZTIU0pOvRM5P6ZnA1mKARj6YwN+5x0S+QdnVoaqD93SQ3zBjMmyIGTtNKVupgGr0zxUT
         iUA+TNSjF+2ttv3k54pSkg04CKCntRePQt9dxo9YPkc7KNDu1k2OY6XskR29q1yt+1RT
         1nfV3BglJn5lHuOw6h0K3a8yusyDY2IDLQmb9l0zb/Y2k9D22g5UpBVCwHDFpopZcNgB
         O9RQ==
X-Gm-Message-State: AA+aEWYYoa3Yf3hP1v8DfqwqAhBgBb0i2N72gpB/fG0KuSsaiR7Du4RB
        Qh+r+iXl1JlzAuHac2qLp30=
X-Google-Smtp-Source: AFSGD/V2PdX5zFaZy1lntCnIDWFFyvW8Rd+b7CyF3FcT86X0oAAOTXB5zO9Fjxl1f0OWCBKjvM9HAQ==
X-Received: by 2002:a62:7e93:: with SMTP id z141mr11272782pfc.239.1543733956138;
        Sat, 01 Dec 2018 22:59:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t90sm20572134pfj.23.2018.12.01.22.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 22:59:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, kartilak@cisco.com, sebaddel@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] scsi: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sun,  2 Dec 2018 01:59:13 -0500
Message-Id: <20181202065913.10377-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/scsi/qla2xxx/qla_dfs.c   | 77 +++++---------------------------
 drivers/scsi/snic/snic_debugfs.c | 20 +--------
 2 files changed, 13 insertions(+), 84 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 0b190082aa8d..5703650a9e51 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -12,8 +12,7 @@
 static struct dentry *qla2x00_dfs_root;
 static atomic_t qla2x00_dfs_root_count;
 
-static int
-qla2x00_dfs_tgt_sess_show(struct seq_file *s, void *unused)
+static int dfs_tgt_sess_show(struct seq_file *s, void *unused)
 {
 	scsi_qla_host_t *vha = s->private;
 	struct qla_hw_data *ha = vha->hw;
@@ -37,22 +36,9 @@ qla2x00_dfs_tgt_sess_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int
-qla2x00_dfs_tgt_sess_open(struct inode *inode, struct file *file)
-{
-	scsi_qla_host_t *vha = inode->i_private;
-	return single_open(file, qla2x00_dfs_tgt_sess_show, vha);
-}
-
-static const struct file_operations dfs_tgt_sess_ops = {
-	.open		= qla2x00_dfs_tgt_sess_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dfs_tgt_sess);
 
-static int
-qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
+static int dfs_tgt_port_database_show(struct seq_file *s, void *unused)
 {
 	scsi_qla_host_t *vha = s->private;
 	struct qla_hw_data *ha = vha->hw;
@@ -108,23 +94,9 @@ qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int
-qla2x00_dfs_tgt_port_database_open(struct inode *inode, struct file *file)
-{
-	scsi_qla_host_t *vha = inode->i_private;
+DEFINE_SHOW_ATTRIBUTE(dfs_tgt_port_database);
 
-	return single_open(file, qla2x00_dfs_tgt_port_database_show, vha);
-}
-
-static const struct file_operations dfs_tgt_port_database_ops = {
-	.open		= qla2x00_dfs_tgt_port_database_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int
-qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
+static int dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 {
 	struct scsi_qla_host *vha = s->private;
 	uint16_t mb[MAX_IOCB_MB_REG];
@@ -157,22 +129,9 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int
-qla_dfs_fw_resource_cnt_open(struct inode *inode, struct file *file)
-{
-	struct scsi_qla_host *vha = inode->i_private;
-	return single_open(file, qla_dfs_fw_resource_cnt_show, vha);
-}
+DEFINE_SHOW_ATTRIBUTE(dfs_fw_resource_cnt);
 
-static const struct file_operations dfs_fw_resource_cnt_ops = {
-	.open           = qla_dfs_fw_resource_cnt_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
-
-static int
-qla_dfs_tgt_counters_show(struct seq_file *s, void *unused)
+static int dfs_tgt_counters_show(struct seq_file *s, void *unused)
 {
 	struct scsi_qla_host *vha = s->private;
 	struct qla_qpair *qpair = vha->hw->base_qpair;
@@ -244,19 +203,7 @@ qla_dfs_tgt_counters_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int
-qla_dfs_tgt_counters_open(struct inode *inode, struct file *file)
-{
-	struct scsi_qla_host *vha = inode->i_private;
-	return single_open(file, qla_dfs_tgt_counters_show, vha);
-}
-
-static const struct file_operations dfs_tgt_counters_ops = {
-	.open           = qla_dfs_tgt_counters_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dfs_tgt_counters);
 
 static int
 qla2x00_dfs_fce_show(struct seq_file *s, void *unused)
@@ -468,7 +415,7 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 
 create_nodes:
 	ha->dfs_fw_resource_cnt = debugfs_create_file("fw_resource_count",
-	    S_IRUSR, ha->dfs_dir, vha, &dfs_fw_resource_cnt_ops);
+	    S_IRUSR, ha->dfs_dir, vha, &dfs_fw_resource_cnt_fops);
 	if (!ha->dfs_fw_resource_cnt) {
 		ql_log(ql_log_warn, vha, 0x00fd,
 		    "Unable to create debugFS fw_resource_count node.\n");
@@ -476,7 +423,7 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	}
 
 	ha->dfs_tgt_counters = debugfs_create_file("tgt_counters", S_IRUSR,
-	    ha->dfs_dir, vha, &dfs_tgt_counters_ops);
+	    ha->dfs_dir, vha, &dfs_tgt_counters_fops);
 	if (!ha->dfs_tgt_counters) {
 		ql_log(ql_log_warn, vha, 0xd301,
 		    "Unable to create debugFS tgt_counters node.\n");
@@ -484,7 +431,7 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	}
 
 	ha->tgt.dfs_tgt_port_database = debugfs_create_file("tgt_port_database",
-	    S_IRUSR,  ha->dfs_dir, vha, &dfs_tgt_port_database_ops);
+	    S_IRUSR,  ha->dfs_dir, vha, &dfs_tgt_port_database_fops);
 	if (!ha->tgt.dfs_tgt_port_database) {
 		ql_log(ql_log_warn, vha, 0xd03f,
 		    "Unable to create debugFS tgt_port_database node.\n");
@@ -500,7 +447,7 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	}
 
 	ha->tgt.dfs_tgt_sess = debugfs_create_file("tgt_sess",
-		S_IRUSR, ha->dfs_dir, vha, &dfs_tgt_sess_ops);
+		S_IRUSR, ha->dfs_dir, vha, &dfs_tgt_sess_fops);
 	if (!ha->tgt.dfs_tgt_sess) {
 		ql_log(ql_log_warn, vha, 0xd040,
 		    "Unable to create debugFS tgt_sess node.\n");
diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 0abe17c1a73b..268b5075a6f5 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -354,25 +354,7 @@ snic_stats_show(struct seq_file *sfp, void *data)
 	return 0;
 }
 
-/*
- * snic_stats_open - Open the stats file for specific host
- *
- * Description:
- * This routine opens a debugfs file stats of specific host
- */
-static int
-snic_stats_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, snic_stats_show, inode->i_private);
-}
-
-static const struct file_operations snic_stats_fops = {
-	.owner	= THIS_MODULE,
-	.open	= snic_stats_open,
-	.read	= seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(snic_stats);
 
 static const struct file_operations snic_reset_stats_fops = {
 	.owner = THIS_MODULE,
-- 
2.17.0

