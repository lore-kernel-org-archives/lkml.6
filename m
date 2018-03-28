Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeC1Qlr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:41:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbeC1Qlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:41:46 -0400
From: Colin King <colin.king@canonical.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][scsi-next] scsi: core: remove redundant assignment to shost->use_blk_mq
Date: Wed, 28 Mar 2018 17:41:42 +0100
Message-Id: <20180328164142.27201-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The first assignment to shost->use_blk_mq is redundant as it is
overwritten by the following statement. Remove this redundant code.

Detected by CoverityScan, CID#1466993 ("Unused value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/hosts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 7649d63a1b8d..3771e59a9fae 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -472,7 +472,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	else
 		shost->dma_boundary = 0xffffffff;
 
-	shost->use_blk_mq = scsi_use_blk_mq;
 	shost->use_blk_mq = scsi_use_blk_mq || shost->hostt->force_blk_mq;
 
 	device_initialize(&shost->shost_gendev);
-- 
2.15.1
