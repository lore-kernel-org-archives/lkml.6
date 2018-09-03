Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5130C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2520658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeICV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:56:43 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:48866 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbeICV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:56:42 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id X5bY1y0093XaVaC065bYpQ; Mon, 03 Sep 2018 19:35:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fwslA-0001BP-11; Mon, 03 Sep 2018 19:35:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fwslA-00023b-03; Mon, 03 Sep 2018 19:35:32 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] scsi: arcmsr: Spelling s/rebulid/rebuild/
Date:   Mon,  3 Sep 2018 19:35:29 +0200
Message-Id: <20180903173529.7865-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 12316ef4c8931853..cc0be46511281050 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1798,7 +1798,7 @@ static void arcmsr_hbaA_stop_bgrb(struct AdapterControlBlock *acb)
 	writel(ARCMSR_INBOUND_MESG0_STOP_BGRB, &reg->inbound_msgaddr0);
 	if (!arcmsr_hbaA_wait_msgint_ready(acb)) {
 		printk(KERN_NOTICE
-			"arcmsr%d: wait 'stop adapter background rebulid' timeout\n"
+			"arcmsr%d: wait 'stop adapter background rebuild' timeout\n"
 			, acb->host->host_no);
 	}
 }
@@ -1811,7 +1811,7 @@ static void arcmsr_hbaB_stop_bgrb(struct AdapterControlBlock *acb)
 
 	if (!arcmsr_hbaB_wait_msgint_ready(acb)) {
 		printk(KERN_NOTICE
-			"arcmsr%d: wait 'stop adapter background rebulid' timeout\n"
+			"arcmsr%d: wait 'stop adapter background rebuild' timeout\n"
 			, acb->host->host_no);
 	}
 }
@@ -1824,7 +1824,7 @@ static void arcmsr_hbaC_stop_bgrb(struct AdapterControlBlock *pACB)
 	writel(ARCMSR_HBCMU_DRV2IOP_MESSAGE_CMD_DONE, &reg->inbound_doorbell);
 	if (!arcmsr_hbaC_wait_msgint_ready(pACB)) {
 		printk(KERN_NOTICE
-			"arcmsr%d: wait 'stop adapter background rebulid' timeout\n"
+			"arcmsr%d: wait 'stop adapter background rebuild' timeout\n"
 			, pACB->host->host_no);
 	}
 	return;
@@ -1837,7 +1837,7 @@ static void arcmsr_hbaD_stop_bgrb(struct AdapterControlBlock *pACB)
 	pACB->acb_flags &= ~ACB_F_MSG_START_BGRB;
 	writel(ARCMSR_INBOUND_MESG0_STOP_BGRB, reg->inbound_msgaddr0);
 	if (!arcmsr_hbaD_wait_msgint_ready(pACB))
-		pr_notice("arcmsr%d: wait 'stop adapter background rebulid' "
+		pr_notice("arcmsr%d: wait 'stop adapter background rebuild' "
 			"timeout\n", pACB->host->host_no);
 }
 
@@ -1850,7 +1850,7 @@ static void arcmsr_hbaE_stop_bgrb(struct AdapterControlBlock *pACB)
 	pACB->out_doorbell ^= ARCMSR_HBEMU_DRV2IOP_MESSAGE_CMD_DONE;
 	writel(pACB->out_doorbell, &reg->iobound_doorbell);
 	if (!arcmsr_hbaE_wait_msgint_ready(pACB)) {
-		pr_notice("arcmsr%d: wait 'stop adapter background rebulid' "
+		pr_notice("arcmsr%d: wait 'stop adapter background rebuild' "
 			"timeout\n", pACB->host->host_no);
 	}
 }
@@ -3927,7 +3927,7 @@ static void arcmsr_hbaA_start_bgrb(struct AdapterControlBlock *acb)
 	writel(ARCMSR_INBOUND_MESG0_START_BGRB, &reg->inbound_msgaddr0);
 	if (!arcmsr_hbaA_wait_msgint_ready(acb)) {
 		printk(KERN_NOTICE "arcmsr%d: wait 'start adapter background \
-				rebulid' timeout \n", acb->host->host_no);
+				rebuild' timeout \n", acb->host->host_no);
 	}
 }
 
@@ -3938,7 +3938,7 @@ static void arcmsr_hbaB_start_bgrb(struct AdapterControlBlock *acb)
 	writel(ARCMSR_MESSAGE_START_BGRB, reg->drv2iop_doorbell);
 	if (!arcmsr_hbaB_wait_msgint_ready(acb)) {
 		printk(KERN_NOTICE "arcmsr%d: wait 'start adapter background \
-				rebulid' timeout \n",acb->host->host_no);
+				rebuild' timeout \n",acb->host->host_no);
 	}
 }
 
@@ -3950,7 +3950,7 @@ static void arcmsr_hbaC_start_bgrb(struct AdapterControlBlock *pACB)
 	writel(ARCMSR_HBCMU_DRV2IOP_MESSAGE_CMD_DONE, &phbcmu->inbound_doorbell);
 	if (!arcmsr_hbaC_wait_msgint_ready(pACB)) {
 		printk(KERN_NOTICE "arcmsr%d: wait 'start adapter background \
-				rebulid' timeout \n", pACB->host->host_no);
+				rebuild' timeout \n", pACB->host->host_no);
 	}
 	return;
 }
@@ -3963,7 +3963,7 @@ static void arcmsr_hbaD_start_bgrb(struct AdapterControlBlock *pACB)
 	writel(ARCMSR_INBOUND_MESG0_START_BGRB, pmu->inbound_msgaddr0);
 	if (!arcmsr_hbaD_wait_msgint_ready(pACB)) {
 		pr_notice("arcmsr%d: wait 'start adapter "
-			"background rebulid' timeout\n", pACB->host->host_no);
+			"background rebuild' timeout\n", pACB->host->host_no);
 	}
 }
 
@@ -3977,7 +3977,7 @@ static void arcmsr_hbaE_start_bgrb(struct AdapterControlBlock *pACB)
 	writel(pACB->out_doorbell, &pmu->iobound_doorbell);
 	if (!arcmsr_hbaE_wait_msgint_ready(pACB)) {
 		pr_notice("arcmsr%d: wait 'start adapter "
-			"background rebulid' timeout \n", pACB->host->host_no);
+			"background rebuild' timeout \n", pACB->host->host_no);
 	}
 }
 
-- 
2.17.1

