Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D060C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4777A20817
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4777A20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbeKNXvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:51:04 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732604AbeKNXvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:51:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2779C0F1550F;
        Wed, 14 Nov 2018 21:46:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Nov 2018 21:46:45 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <hare@suse.com>, <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] scsi: libsas: Delete sas_dump.{c, h}
Date:   Wed, 14 Nov 2018 21:47:45 +0800
Message-ID: <1542203269-174932-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
References: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in these files is not longer referenced, so delete them.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/Makefile    |  1 -
 drivers/scsi/libsas/sas_dump.c  | 63 -----------------------------------------
 drivers/scsi/libsas/sas_dump.h  | 29 -------------------
 drivers/scsi/libsas/sas_event.c |  1 -
 4 files changed, 94 deletions(-)
 delete mode 100644 drivers/scsi/libsas/sas_dump.c
 delete mode 100644 drivers/scsi/libsas/sas_dump.h

diff --git a/drivers/scsi/libsas/Makefile b/drivers/scsi/libsas/Makefile
index 2e70140..c1db9027 100644
--- a/drivers/scsi/libsas/Makefile
+++ b/drivers/scsi/libsas/Makefile
@@ -26,7 +26,6 @@ libsas-y +=  sas_init.o     \
 		sas_phy.o      \
 		sas_port.o     \
 		sas_event.o    \
-		sas_dump.o     \
 		sas_discover.o \
 		sas_expander.o \
 		sas_scsi_host.o \
diff --git a/drivers/scsi/libsas/sas_dump.c b/drivers/scsi/libsas/sas_dump.c
deleted file mode 100644
index 7e5d262..0000000
--- a/drivers/scsi/libsas/sas_dump.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Serial Attached SCSI (SAS) Dump/Debugging routines
- *
- * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
- * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include "sas_dump.h"
-
-static const char *sas_porte_str[] = {
-	[0] = "PORTE_BYTES_DMAED",
-	[1] = "PORTE_BROADCAST_RCVD",
-	[2] = "PORTE_LINK_RESET_ERR",
-	[3] = "PORTE_TIMER_EVENT",
-	[4] = "PORTE_HARD_RESET",
-};
-
-static const char *sas_phye_str[] = {
-	[0] = "PHYE_LOSS_OF_SIGNAL",
-	[1] = "PHYE_OOB_DONE",
-	[2] = "PHYE_OOB_ERROR",
-	[3] = "PHYE_SPINUP_HOLD",
-	[4] = "PHYE_RESUME_TIMEOUT",
-};
-
-void sas_dprint_porte(int phyid, enum port_event pe)
-{
-	SAS_DPRINTK("phy%d: port event: %s\n", phyid, sas_porte_str[pe]);
-}
-void sas_dprint_phye(int phyid, enum phy_event pe)
-{
-	SAS_DPRINTK("phy%d: phy event: %s\n", phyid, sas_phye_str[pe]);
-}
-
-void sas_dump_port(struct asd_sas_port *port)
-{
-	SAS_DPRINTK("port%d: class:0x%x\n", port->id, port->class);
-	SAS_DPRINTK("port%d: sas_addr:%llx\n", port->id,
-		    SAS_ADDR(port->sas_addr));
-	SAS_DPRINTK("port%d: attached_sas_addr:%llx\n", port->id,
-		    SAS_ADDR(port->attached_sas_addr));
-	SAS_DPRINTK("port%d: iproto:0x%x\n", port->id, port->iproto);
-	SAS_DPRINTK("port%d: tproto:0x%x\n", port->id, port->tproto);
-	SAS_DPRINTK("port%d: oob_mode:0x%x\n", port->id, port->oob_mode);
-	SAS_DPRINTK("port%d: num_phys:%d\n", port->id, port->num_phys);
-}
diff --git a/drivers/scsi/libsas/sas_dump.h b/drivers/scsi/libsas/sas_dump.h
deleted file mode 100644
index 6aaee6b..0000000
--- a/drivers/scsi/libsas/sas_dump.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Serial Attached SCSI (SAS) Dump/Debugging routines header file
- *
- * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
- * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include "sas_internal.h"
-
-void sas_dprint_porte(int phyid, enum port_event pe);
-void sas_dprint_phye(int phyid, enum phy_event pe);
-void sas_dump_port(struct asd_sas_port *port);
diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
index ae923eb..b1e0f7d 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -25,7 +25,6 @@
 #include <linux/export.h>
 #include <scsi/scsi_host.h>
 #include "sas_internal.h"
-#include "sas_dump.h"
 
 int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
 {
-- 
1.9.1

