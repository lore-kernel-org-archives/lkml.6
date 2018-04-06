Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDFHyh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeDFHyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:54:36 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] qla2xxx: correctly shift host byte
Date: Fri,  6 Apr 2018 09:52:22 +0200
Message-Id: <20180406075222.7358-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host byte has to be shifted by 16 not 6.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/qla2xxx/qla_isr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 89f93ebd819d..49d67e1d571f 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2368,7 +2368,7 @@ qla25xx_process_bidir_status_iocb(scsi_qla_host_t *vha, void *pkt,
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	/* Always return DID_OK, bsg will send the vendor specific response
 	 * in this case only */
-	sp->done(sp, DID_OK << 6);
+	sp->done(sp, DID_OK << 16);
 
 }
 
-- 
2.16.2
