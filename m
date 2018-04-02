Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeDBJh7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:37:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:40405 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbeDBJh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:37:57 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] scsi: hosts: remove redundant assingment of shost->use_blk_mq
Date: Mon,  2 Apr 2018 11:37:49 +0200
Message-Id: <20180402093749.6862-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity reports that we're assigning shost->use_blk_mq twice. This
looks like the result of a bad merge of commit 2f31115e940c ("scsi:
core: introduce force_blk_mq")

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/hosts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ef22b275d050..c36f2a44e5ed 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -473,7 +473,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	else
 		shost->dma_boundary = 0xffffffff;
 
-	shost->use_blk_mq = scsi_use_blk_mq;
 	shost->use_blk_mq = scsi_use_blk_mq || shost->hostt->force_blk_mq;
 
 	device_initialize(&shost->shost_gendev);
-- 
2.16.2
