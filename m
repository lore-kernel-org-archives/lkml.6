Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEBP6m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:58:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54592 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751985AbeEBP5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:57:30 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 04/11] scsi: hisi_sas: fix PI memory size
Date: Wed, 2 May 2018 23:56:27 +0800
Message-ID: <1525276594-92173-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
References: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

There are 28 bytes of protection information record of SSP for
v3 hw, 16 bytes for v2 hw, and probably 24 for v1 hw (forgotten
now).

So use a value big enough in hisi_sas_command_table_ssp.prot to
cover all cases.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 147cfaf..04a40c4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -410,7 +410,7 @@ struct hisi_sas_command_table_ssp {
 	union {
 		struct {
 			struct ssp_command_iu task;
-			u32 prot[6];
+			u32 prot[7];
 		};
 		struct ssp_tmf_iu ssp_task;
 		struct xfer_rdy_iu xfer_rdy;
-- 
1.9.1
