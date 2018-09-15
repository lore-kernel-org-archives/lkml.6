Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EBBECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157EF208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbIOi1rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157EF208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIOI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:59:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43049 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeIOI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:59:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id f66-v6so5015505plb.10;
        Fri, 14 Sep 2018 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vfr12jueS7IwKDDThU1niCwYcDuAznByJMLt5etNfo8=;
        b=BbIOi1rsP7IkJO8zT51b63Bj7XlEqbe0cIes+kvODE+zIX20UYpQFkLp2yEHGIv6Dz
         /ZfKIcWyCmvFJVOZdrg5r5VSDYkVL4p8ngpqNOnSyTXQIZx3Z4a02G4RqepR7C6ZxQWl
         xKYjgoIXbu+WkIdAkopQXiE6poDKmDDb7vH07RwdJeimHKv6GI4ZN0BZogV/EwKANYvE
         XXd3WHLMUGVXgmE21O/ktKzvOR3ppf0DYDWhvpY+1YMkxv6N37HQ+X5Bn3lgAh8hVUdF
         Q80T0lBupYlKRP0rh5IFHAqfgTWuLuJjwNbCjbHEW/exx13vLONtZee11DMeD1y7Zk+e
         rgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vfr12jueS7IwKDDThU1niCwYcDuAznByJMLt5etNfo8=;
        b=JYwnzGSzazyOABz8jiZjANiy6d0rabq/VYUzNuhuhJp16ZWHy90IfOxq0uRrEIxApw
         Lk8ZNuWsxYPL/iiap068yI75u9EX9dXir7KT9deGQjKqOZKmyTTgY6fBrQFp3iohMvzj
         QuHRsx+pIh7ISN7M5pdxnO/nJSF2sIpORDV5UyY2C3IJS/uCn9DkzvUJIiF9fyzA4V8s
         n2YeJqmrqKsC8/KDhyrkID5QHM8+o0YmX6l9zY9BZkwHJGGV2Fcr0TA8BKF2Qydzmqg/
         yMKavgp0tbD+lju9ho40mqqp+h5YTo4LrfMzLwtxaSNKBKeKBpUeWzCDJEWm6vqthqeB
         3YNw==
X-Gm-Message-State: APzg51BWIOewTUCUkOsEx442lO+zxlPYPqN6zp0c4rNrK28kIPdLWnpB
        BPEDw0DycHTbcfMTW4Petr6BY+ej
X-Google-Smtp-Source: ANB0VdYOLIdIkdQ5qSqBMomfTHr6auumTw2xH3KBWUbA3WyjzhHLleMT5cEZcbYtY8NqKHuYF4QDsA==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12-v6mr14559921plo.94.1536982907076;
        Fri, 14 Sep 2018 20:41:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id y69-v6sm11949912pfd.36.2018.09.14.20.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 20:41:46 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix three sleep-in-atomic-context bugs in lpfc_prep_els_iocb()
Date:   Sat, 15 Sep 2018 11:41:27 +0800
Message-Id: <20180915034127.6597-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] kmalloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_els.c, 205: 
	kmalloc in lpfc_prep_els_iocb
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
drivers/scsi/lpfc/lpfc_nportdisc.c, 259: 
	spin_lock_irq in lpfc_els_abort

[FUNC] kmalloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_els.c, 226: 
	kmalloc in lpfc_prep_els_iocb
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
drivers/scsi/lpfc/lpfc_nportdisc.c, 259: 
	spin_lock_irq in lpfc_els_abort

[FUNC] kmalloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_els.c, 215: 
	kmalloc in lpfc_prep_els_iocb
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
drivers/scsi/lpfc/lpfc_nportdisc.c, 259: 
	spin_lock_irq in lpfc_els_abort

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 4dda969e947c..e21b360eb764 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -202,7 +202,7 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, uint8_t expectRsp,
 
 	/* fill in BDEs for command */
 	/* Allocate buffer for command payload */
-	pcmd = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
+	pcmd = kmalloc(sizeof(struct lpfc_dmabuf), GFP_ATOMIC);
 	if (pcmd)
 		pcmd->virt = lpfc_mbuf_alloc(phba, MEM_PRI, &pcmd->phys);
 	if (!pcmd || !pcmd->virt)
@@ -212,7 +212,7 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, uint8_t expectRsp,
 
 	/* Allocate buffer for response payload */
 	if (expectRsp) {
-		prsp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
+		prsp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_ATOMIC);
 		if (prsp)
 			prsp->virt = lpfc_mbuf_alloc(phba, MEM_PRI,
 						     &prsp->phys);
@@ -223,7 +223,7 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, uint8_t expectRsp,
 		prsp = NULL;
 
 	/* Allocate buffer for Buffer ptr list */
-	pbuflist = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
+	pbuflist = kmalloc(sizeof(struct lpfc_dmabuf), GFP_ATOMIC);
 	if (pbuflist)
 		pbuflist->virt = lpfc_mbuf_alloc(phba, MEM_PRI,
 						 &pbuflist->phys);
-- 
2.17.0

