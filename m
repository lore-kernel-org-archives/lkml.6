Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F596ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D85208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCp/cYfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D85208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIOI7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:59:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42249 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeIOI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:59:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so5229391pgp.9;
        Fri, 14 Sep 2018 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UtezC0Jkv5pu9jw2uBFqaZbSmBAo1ptYXuNR2V30cIU=;
        b=NCp/cYfnqj0Xtw8iyaQH/aC3D2tWF3e33lgovtam+CilidPkogfsgnLzDvNR+rvcaO
         ZYDjm9cwK3vOSR5nQLFD88sJQo/cEu1HLmxHOpm2tZP0dfV7AvebaN5ncq321pEDcLyr
         n0dVMe+Te5/P/qt9bdnLz6RKFgNvEgwlofsmDR9c2pbCjS/2aui7pie08qRN7n1Y9cSs
         J46khZJrj+g0dtb7PWWsKmyul6lXRvdLMbUBkj4bt5bmTaKCMkyjwIbriuWuuaSfYhqI
         fvrze+L8el8pkpI1OsN1laJ6a6R0oAKu8R/Q0gSXe7945WfZFq31BlFNPyA3ubCvg+W9
         u0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UtezC0Jkv5pu9jw2uBFqaZbSmBAo1ptYXuNR2V30cIU=;
        b=Cr3cclb0N5HJFx0Bmoo4E6vsr2LTeJwq5epG2fCLdLl9+ZcWnQzZT98EHpzrPlpxVd
         kcOpwbSpUWAeJfLnHl+3Z982eCoF6dpyO7QT/Th62Fj+lQoTYpsGktn3OsPRvpUhs/nx
         z4LWasrDYEGzYkgBUF7uxIRXVjMFx9l6i+WtIP9XFp1TvBjITi7B/Cz0X2rwafsA7SUF
         lyS9LaYMsIioH5+ACXcCK/GUMHiI6UNA4AHvMa0pAcXYn/kQYcJDpYEeKaIbyhejyu1w
         HC4wytfkANLQAh6PzeyWjWxVqZX8aUKev/5XcCfui32qyqd+guRNAKcWU4avkYnHbXNO
         9UVg==
X-Gm-Message-State: APzg51BabjacRUHGTwZJOT4jyWtAdRj8B8BI5S5nE53ptyrm+VbJw4tv
        E25vsgCq4fsl3EYh66eYpSA=
X-Google-Smtp-Source: ANB0VdaaTykczA0rAjSYsFaLSTAq/D9gy7Ieuio2TyqYEwrOfurxua98Oh2EhvFCv6he04YJry22uw==
X-Received: by 2002:a63:b95e:: with SMTP id v30-v6mr14091596pgo.221.1536982926717;
        Fri, 14 Sep 2018 20:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id j15-v6sm9935066pfn.52.2018.09.14.20.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 20:42:06 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix a possible sleep-in-atomic-context bug in lpfc_mbuf_alloc()
Date:   Sat, 15 Sep 2018 11:42:00 +0800
Message-Id: <20180915034200.6706-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] dma_pool_alloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_mem.c, 400: 
	dma_pool_alloc in lpfc_mbuf_alloc
drivers/scsi/lpfc/lpfc_els.c, 228: 
	lpfc_mbuf_alloc in lpfc_prep_els_iocb
drivers/scsi/lpfc/lpfc_els.c, 2010: 
	lpfc_prep_els_iocb in lpfc_issue_els_plogi
drivers/scsi/lpfc/lpfc_els.c, 4914: 
	lpfc_issue_els_plogi in lpfc_els_disc_plogi
drivers/scsi/lpfc/lpfc_els.c, 1486: 
	lpfc_els_disc_plogi in lpfc_more_plogi
drivers/scsi/lpfc/lpfc_els.c, 3123: 
	lpfc_more_plogi in lpfc_cancel_retry_delay_tmo
drivers/scsi/lpfc/lpfc_nportdisc.c, 279: 
	lpfc_cancel_retry_delay_tmo in lpfc_els_abort
drivers/scsi/lpfc/lpfc_nportdisc.c, 236: 
	spin_lock_irq in lpfc_els_abort

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/lpfc/lpfc_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index 9c22a2c93462..7eae5508bfa3 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -398,7 +398,7 @@ lpfc_mbuf_alloc(struct lpfc_hba *phba, int mem_flags, dma_addr_t *handle)
 	unsigned long iflags;
 	void *ret;
 
-	ret = dma_pool_alloc(phba->lpfc_mbuf_pool, GFP_KERNEL, handle);
+	ret = dma_pool_alloc(phba->lpfc_mbuf_pool, GFP_ATOMIC, handle);
 
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (!ret && (mem_flags & MEM_PRI) && pool->current_count) {
-- 
2.17.0

