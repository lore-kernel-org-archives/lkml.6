Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB673208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxHughbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB673208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeIOI6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:58:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41020 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:58:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so5012239plr.8;
        Fri, 14 Sep 2018 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PG75NBZAQXGS57U08M9CJ+QkfhHgTs56HWq6D4D4LPc=;
        b=BxHughbXL95eAczzkLTIcO9wzR1muAkVmo0FYrnK20TOy/K+kXlLpZMRdAufU1JSIM
         8QDCUB5DpxAjI4XtlTzoDoea4MsADud/zVNbYR+02jjgomHrup3Xt1z8H9PfTFzhwt0D
         tHOl4Ij7YJ+SyPwpx/N5NMQUEsHnstuuAYOT1xcreTjz7Epmuk6RXUo//OdnFu3BTQ5m
         6Kr7zdVCSW8xKF/02odEf6WvUZzssASJbMzZzSNGPHDlZeosUhs0eJE79kuExCyEDzQM
         1uIy3rrEwW2EkGOaw4k+bScMqyDxAvfa/nxR1H4aK+QmOX679bH07+NJxsFMULZzAF+h
         e36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PG75NBZAQXGS57U08M9CJ+QkfhHgTs56HWq6D4D4LPc=;
        b=HMvwMoOoO2dZkhGLaHdR05JypOPXQp5i9IbEzitLJjV/f2j/t7y1Xo+EQuK2dGhgNV
         ky09N+s/10MauqP/ZxAieWqMGJ33GtXYxfp4LOP9uBGWqDTj/x6St4h63C8Lr6HZ1pmR
         vMAcvDI6gjacWw1jNzdiEwu9McSzAu04jpDeMPQFj35bFW+HCBJcsno9aI029TVKLeTv
         D/qpmjuXNoPTR+MNqlmK8BbxvxgMdu3f91YZeld/6jaZTSBOHWZbFJFxzA6PVFGxhVER
         SzcepAA0lqN4IJiHgfqpjqPX7xQtFMkeNKoS5lnyDGZiMwzetggUbj6KO29l7GpCgIlV
         kP4g==
X-Gm-Message-State: APzg51BpnBTr8bVvfWhiOAUbO8S+GpUXuGRRFx4AjgJA0MVqgLdOWuCW
        SrQ6qc1FbhX6WnvtztArMhY=
X-Google-Smtp-Source: ANB0VdYt6CfqaA6+RMXnGNEery6f3O6wVUgDPtVr6qk+3UzyHM6pdHf5xqxOClUgNbdQwZ9w4mRk8w==
X-Received: by 2002:a17:902:900a:: with SMTP id a10-v6mr14801298plp.143.1536982884556;
        Fri, 14 Sep 2018 20:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id c8-v6sm10255767pfb.147.2018.09.14.20.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 20:41:23 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix three sleep-in-atomic-context bugs in lpfc_sli4_nvmet_alloc()
Date:   Sat, 15 Sep 2018 11:41:15 +0800
Message-Id: <20180915034115.6543-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] kzalloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_mem.c, 633: 
	kzalloc in lpfc_sli4_nvmet_alloc
drivers/scsi/lpfc/lpfc_sli.c, 6729: 
	[FUNC_PTR]lpfc_sli4_nvmet_alloc in lpfc_post_rq_buffer
drivers/scsi/lpfc/lpfc_sli.c, 6723: 
	_raw_spin_lock_irqsave in lpfc_post_rq_buffer

[FUNC] dma_pool_alloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_mem.c, 637: 
	dma_pool_alloc in lpfc_sli4_nvmet_alloc
drivers/scsi/lpfc/lpfc_sli.c, 6729: 
	[FUNC_PTR]lpfc_sli4_nvmet_alloc in lpfc_post_rq_buffer
drivers/scsi/lpfc/lpfc_sli.c, 6723: 
	_raw_spin_lock_irqsave in lpfc_post_rq_buffer

[FUNC] dma_pool_alloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_mem.c, 643: 
	dma_pool_alloc in lpfc_sli4_nvmet_alloc
drivers/scsi/lpfc/lpfc_sli.c, 6729: 
	[FUNC_PTR]lpfc_sli4_nvmet_alloc in lpfc_post_rq_buffer
drivers/scsi/lpfc/lpfc_sli.c, 6723: 
	_raw_spin_lock_irqsave in lpfc_post_rq_buffer

Note that [FUNC_PTR] means a function pointer call is used.

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/lpfc/lpfc_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index 9c22a2c93462..20359e5d0016 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -631,18 +631,18 @@ lpfc_sli4_nvmet_alloc(struct lpfc_hba *phba)
 {
 	struct rqb_dmabuf *dma_buf;
 
-	dma_buf = kzalloc(sizeof(struct rqb_dmabuf), GFP_KERNEL);
+	dma_buf = kzalloc(sizeof(struct rqb_dmabuf), GFP_ATOMIC);
 	if (!dma_buf)
 		return NULL;
 
-	dma_buf->hbuf.virt = dma_pool_alloc(phba->lpfc_hrb_pool, GFP_KERNEL,
+	dma_buf->hbuf.virt = dma_pool_alloc(phba->lpfc_hrb_pool, GFP_ATOMIC,
 					    &dma_buf->hbuf.phys);
 	if (!dma_buf->hbuf.virt) {
 		kfree(dma_buf);
 		return NULL;
 	}
 	dma_buf->dbuf.virt = dma_pool_alloc(phba->lpfc_nvmet_drb_pool,
-					    GFP_KERNEL, &dma_buf->dbuf.phys);
+					    GFP_ATOMIC, &dma_buf->dbuf.phys);
 	if (!dma_buf->dbuf.virt) {
 		dma_pool_free(phba->lpfc_hrb_pool, dma_buf->hbuf.virt,
 			      dma_buf->hbuf.phys);
-- 
2.17.0

