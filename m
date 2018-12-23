Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229FF218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeLWJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:34:00 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44311
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727199AbeLWJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:33:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991766"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:53 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     James Smart <james.smart@broadcom.com>
Cc:     kernel-janitors@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] scsi: lpfc: lpfc_scsi: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:56:59 +0100
Message-Id: <1545555435-24576-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

These were introduced in 8a9d2e8003040 ("[SCSI] lpfc 8.3.31:
Correct handling of SLI4-port XRI resource-provisioning profile
change"), but were not even used at that time.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: 8a9d2e8003040 ("[SCSI] lpfc 8.3.31: Correct handling of SLI4-port XRI resource-provisioning profile change")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/scsi/lpfc/lpfc_scsi.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index b4f1a840b3b4..dd415d783593 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -805,9 +805,7 @@ lpfc_new_scsi_buf_s4(struct lpfc_vport *vport, int num_to_alloc)
 	dma_addr_t pdma_phys_bpl;
 	uint16_t iotag, lxri = 0;
 	int bcnt, num_posted, sgl_size;
-	LIST_HEAD(prep_sblist);
 	LIST_HEAD(post_sblist);
-	LIST_HEAD(scsi_sblist);
 
 	sgl_size = phba->cfg_sg_dma_buf_size -
 		(sizeof(struct fcp_cmnd) + sizeof(struct fcp_rsp));

