Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEBUbW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:31:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32912 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:31:18 -0400
X-Google-Smtp-Source: AB8JxZoRzVzviweIVMwibyVwvm4WspVScj1VmC1br7p4QbXPiiG6fSue3iFHIUYYV2T68mMm9TmBHg==
From: Andrei Vagin <avagin@openvz.org>
To: qla2xxx-upstream@qlogic.com
Cc: linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>
Subject: [PATCH] scsi: qla2xxx: remove the unused tcm_qla2xxx_cmd_wq
Date: Wed,  2 May 2018 13:31:13 -0700
Message-Id: <20180502203113.13183-1-avagin@openvz.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrei Vagin <avagin@openvz.org>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index aadfeaac3898..b63440fec18e 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -48,7 +48,6 @@
 #include "tcm_qla2xxx.h"
 
 static struct workqueue_struct *tcm_qla2xxx_free_wq;
-static struct workqueue_struct *tcm_qla2xxx_cmd_wq;
 
 /*
  * Parse WWN.
@@ -1976,16 +1975,8 @@ static int tcm_qla2xxx_register_configfs(void)
 		goto out_fabric_npiv;
 	}
 
-	tcm_qla2xxx_cmd_wq = alloc_workqueue("tcm_qla2xxx_cmd", 0, 0);
-	if (!tcm_qla2xxx_cmd_wq) {
-		ret = -ENOMEM;
-		goto out_free_wq;
-	}
-
 	return 0;
 
-out_free_wq:
-	destroy_workqueue(tcm_qla2xxx_free_wq);
 out_fabric_npiv:
 	target_unregister_template(&tcm_qla2xxx_npiv_ops);
 out_fabric:
@@ -1995,7 +1986,6 @@ static int tcm_qla2xxx_register_configfs(void)
 
 static void tcm_qla2xxx_deregister_configfs(void)
 {
-	destroy_workqueue(tcm_qla2xxx_cmd_wq);
 	destroy_workqueue(tcm_qla2xxx_free_wq);
 
 	target_unregister_template(&tcm_qla2xxx_ops);
-- 
2.14.3
