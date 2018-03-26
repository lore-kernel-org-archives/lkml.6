Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCZOG4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:06:56 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:60558 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeCZOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:06:55 -0400
X-IronPort-AV: E=Sophos;i="5.48,364,1517875200";
   d="scan'208";a="467288257"
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector blacklist
Date: Mon, 26 Mar 2018 14:56:51 +0100
Message-ID: <20180326135651.8193-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Windows Server 2016 iSCSI target doesn't work with the Linux kernel
initiator since the kernel started sending larger requests by default,
nor does it implement the block limits VPD page. Apply the sector limit
workaround for these targets.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/scsi/scsi_devinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index f3b1172..5cb748a 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -213,7 +213,7 @@ static struct {
 	{"Medion", "Flash XL  MMC/SD", "2.6D", BLIST_FORCELUN},
 	{"MegaRAID", "LD", NULL, BLIST_FORCELUN},
 	{"MICROP", "4110", NULL, BLIST_NOTQ},
-	{"MSFT", "Virtual HD", NULL, BLIST_NO_RSOC},
+	{"MSFT", "Virtual HD", NULL, BLIST_MAX_1024 | BLIST_NO_RSOC},
 	{"MYLEX", "DACARMRB", "*", BLIST_REPORTLUN2},
 	{"nCipher", "Fastness Crypto", NULL, BLIST_FORCELUN},
 	{"NAKAMICH", "MJ-4.8S", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
-- 
2.9.5
