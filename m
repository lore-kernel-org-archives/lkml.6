Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5521ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D983208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5abTl/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D983208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIOI7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:59:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46626 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeIOI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:59:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so5224107pga.13;
        Fri, 14 Sep 2018 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mFxUoShxz81AGHb0A/JO8jFUzCf4xUSa+8A9TpkwZgo=;
        b=L5abTl/yOG3f/T5Ra/JReWIzkhQ//FiwZCMXkXUxLNt/CpJ3SS4SIpXgcjkQC0bZYh
         568Zdk0gXTQ3tczaRgiImBLL6zKhW9DRQDQ+incGdcfB3SUwBVZ3l1LYOLOVG9hKxXlJ
         bzsi2Hv84c+U7jQclSd81EkMLc960ALWDHt0/KshRrl00seSMRw6zwqT0/iHCgXXLy9f
         LXQ6hZrZBpEHQ4JwRcSYySZYm/vL8CAdrm0x3NbL9nUk7/LVfoMnV8CWOiQtSOGP4xVh
         qMAzSHKjwLBjHVloidF5l3C9LTPG/kX+QITg7RlgGCaKd4CkBOLgutvutwDFDE3wNY8K
         msKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mFxUoShxz81AGHb0A/JO8jFUzCf4xUSa+8A9TpkwZgo=;
        b=RedprmhodyXR/1oe8WR7tsUQpHOBGqIdxQKMMt9n8sbhB72HlOpH4LMByLyRdCuk0J
         O2mRr3UZb9svsM68eXW2nqtgjWaN9AMc8ZOz+dYwBQ9xURh8dMeuLz+ZgcUH+sZtBeox
         NipyILhxYU4OjT9aeqIWgaCggU/sWmAvbHD3jWPwiOxM9TwFifxaQDbGTuvxyBGOZy0A
         13Z+DLgM2LDycbhqbFYYo2WHoiYQYe8CXvw4RqAEz5qhz1ieS6oSmNS8U0thcF4dKzyB
         uNvRn5kIqefMf6dP4X3/j0+yYzRW6pGeLsAOrETbNv5mH760XUL4m2cDqXiTVIbj5HkW
         mHMw==
X-Gm-Message-State: APzg51Aqxa++P3NxnmP4jR638VCGCF9eTy1GzeBjTDqJI/2zKPO2thPg
        2bIpbx4urLz26BUyDUoXd3k=
X-Google-Smtp-Source: ANB0VdbEUAaHS0IUfi9P5rOaixbJn14jLvqsjpn+13twISQwdPCY0diWRq5qMJmj6X80nHUgAW/sSQ==
X-Received: by 2002:a62:fc5:: with SMTP id 66-v6mr15169205pfp.237.1536982917160;
        Fri, 14 Sep 2018 20:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id n80-v6sm13134175pfb.95.2018.09.14.20.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 20:41:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix a sleep-in-atomic-context bug in lpfc_unreg_rpi()
Date:   Sat, 15 Sep 2018 11:41:50 +0800
Message-Id: <20180915034150.6652-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] mempool_alloc(GFP_KERNEL)
drivers/scsi/lpfc/lpfc_hbadisc.c, 4738:
	 mempool_alloc in lpfc_unreg_rpi
drivers/scsi/lpfc/lpfc_els.c, 2825: 
	lpfc_unreg_rpi in lpfc_issue_els_logo
drivers/scsi/lpfc/lpfc_els.c, 9488: 
	lpfc_issue_els_logo in lpfc_sli_abts_recover_port
drivers/scsi/lpfc/lpfc_sli.c, 9806: 
	lpfc_sli_abts_recover_port in lpfc_sli_abts_err_handler
drivers/scsi/lpfc/lpfc_sli.c, 9914: 
	lpfc_sli_abts_err_handler in lpfc_sli_async_event_handler
drivers/scsi/lpfc/lpfc_sli.c, 2755:
	[FUNC_PTR]lpfc_sli_async_event_handler in lpfc_sli_process_unsol_iocb
drivers/scsi/lpfc/lpfc_sli.c, 3359: 
	lpfc_sli_process_unsol_iocb in lpfc_sli_handle_fast_ring_event
drivers/scsi/lpfc/lpfc_sli.c, 12383: 
	lpfc_sli_handle_fast_ring_event in lpfc_sli_fp_intr_handler 
	(interrupt handler)

Note that [FUNC_PTR] means a function pointer call is used.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index eb71877f12f8..b10122e13d02 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4730,7 +4730,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 					 "did x%x\n",
 					 ndlp->nlp_rpi, ndlp->nlp_flag,
 					 ndlp->nlp_DID);
-		mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
+		mbox = mempool_alloc(phba->mbox_mem_pool, GFP_ATOMIC);
 		if (mbox) {
 			/* SLI4 ports require the physical rpi value. */
 			rpi = ndlp->nlp_rpi;
-- 
2.17.0

