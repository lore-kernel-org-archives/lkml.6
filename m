Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbeCGM1Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:27:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754189AbeCGM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:26:02 -0500
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <hare@suse.de>
CC: <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 10/10] scsi: hisi_sas: add v3 hw MODULE_DEVICE_TABLE()
Date: Wed, 7 Mar 2018 20:25:14 +0800
Message-ID: <1520425514-205565-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520425514-205565-1-git-send-email-john.garry@huawei.com>
References: <1520425514-205565-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Export device table of v3 hw to userspace, or auto probe will fail
for v3 hw.

Also change the module alias to include "pci", instead of "platform".

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 5ce5ef2c..6f3e5ba 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2394,6 +2394,7 @@ static int hisi_sas_v3_resume(struct pci_dev *pdev)
 	{ PCI_VDEVICE(HUAWEI, 0xa230), hip08 },
 	{}
 };
+MODULE_DEVICE_TABLE(pci, sas_v3_pci_table);
 
 static const struct pci_error_handlers hisi_sas_err_handler = {
 	.error_detected	= hisi_sas_error_detected_v3_hw,
@@ -2416,4 +2417,4 @@ static int hisi_sas_v3_resume(struct pci_dev *pdev)
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Garry <john.garry@huawei.com>");
 MODULE_DESCRIPTION("HISILICON SAS controller v3 hw driver based on pci device");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("pci:" DRV_NAME);
-- 
1.9.1
