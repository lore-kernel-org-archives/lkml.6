Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1804DC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41032084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfBLP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:29:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41178 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBLP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:29:50 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gta0H-0000AQ-Ue; Tue, 12 Feb 2019 15:29:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: fix a handful of indentation issues
Date:   Tue, 12 Feb 2019 15:29:45 +0000
Message-Id: <20190212152945.11362-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a handful of statements that are indented incorrectly. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c     | 4 ++--
 drivers/scsi/lpfc/lpfc_debugfs.c | 4 ++--
 drivers/scsi/lpfc/lpfc_init.c    | 2 +-
 drivers/scsi/lpfc/lpfc_mbox.c    | 4 ++--
 drivers/scsi/lpfc/lpfc_sli.c     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 2dc564e59430..f2494d3b365c 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2947,7 +2947,7 @@ static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 			cmd->un.cont64[i].addrLow = putPaddrLow(mp[i]->phys);
 			cmd->un.cont64[i].tus.f.bdeSize =
 				((struct lpfc_dmabufext *)mp[i])->size;
-					cmd->ulpBdeCount = ++i;
+			cmd->ulpBdeCount = ++i;
 
 			if ((--num_bde > 0) && (i < 2))
 				continue;
@@ -4682,7 +4682,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
 	 * Don't allow mailbox commands to be sent when blocked or when in
 	 * the middle of discovery
 	 */
-	 if (phba->sli.sli_flag & LPFC_BLOCK_MGMT_IO) {
+	if (phba->sli.sli_flag & LPFC_BLOCK_MGMT_IO) {
 		rc = -EAGAIN;
 		goto job_done;
 	}
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index ee98ea1c68f9..1215eaa530db 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -1833,7 +1833,7 @@ lpfc_debugfs_disc_trc_open(struct inode *inode, struct file *file)
 	int rc = -ENOMEM;
 
 	if (!lpfc_debugfs_max_disc_trc) {
-		 rc = -ENOSPC;
+		rc = -ENOSPC;
 		goto out;
 	}
 
@@ -1883,7 +1883,7 @@ lpfc_debugfs_slow_ring_trc_open(struct inode *inode, struct file *file)
 	int rc = -ENOMEM;
 
 	if (!lpfc_debugfs_max_slow_ring_trc) {
-		 rc = -ENOSPC;
+		rc = -ENOSPC;
 		goto out;
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 900edae7ccc4..18424020ae40 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -10118,7 +10118,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 			dev_printk(KERN_ERR, &pdev->dev,
 				"ioremap failed for SLI4 PCI config "
 				"registers.\n");
-				goto out;
+			goto out;
 		}
 		lpfc_sli4_bar0_register_memmap(phba, if_type);
 	}
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index 4d3b94317515..8abe933bad09 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -2095,8 +2095,8 @@ lpfc_request_features(struct lpfc_hba *phba, struct lpfcMboxq *mboxq)
 	if (phba->nvmet_support) {
 		bf_set(lpfc_mbx_rq_ftr_rq_mrqp, &mboxq->u.mqe.un.req_ftrs, 1);
 		/* iaab/iaar NOT set for now */
-		 bf_set(lpfc_mbx_rq_ftr_rq_iaab, &mboxq->u.mqe.un.req_ftrs, 0);
-		 bf_set(lpfc_mbx_rq_ftr_rq_iaar, &mboxq->u.mqe.un.req_ftrs, 0);
+		bf_set(lpfc_mbx_rq_ftr_rq_iaab, &mboxq->u.mqe.un.req_ftrs, 0);
+		bf_set(lpfc_mbx_rq_ftr_rq_iaar, &mboxq->u.mqe.un.req_ftrs, 0);
 	}
 	return;
 }
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3596822605c3..d0817facdae3 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1008,7 +1008,7 @@ lpfc_test_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	if (!ndlp->active_rrqs_xri_bitmap)
 		return 0;
 	if (test_bit(xritag, ndlp->active_rrqs_xri_bitmap))
-			return 1;
+		return 1;
 	else
 		return 0;
 }
-- 
2.20.1

