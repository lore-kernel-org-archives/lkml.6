Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC482075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbYukac4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC482075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeKQXEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:04:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeKQXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:04:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so12703637pfk.0;
        Sat, 17 Nov 2018 04:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=bu4IbrWa1ZTI+K96nWVl7AHAx8DAHzjVhBaPXw8WmYQ=;
        b=MbYukac4k6Pg+X4STEgpTdzHi6zqJF/+ZtYqEzz9boTc2NpfknXP4O860Uxw31ZGDR
         xg1bOrt+RYZ6iAK85poFSAmixtg7vVUNXK4jVoepjVtVQCc+2OROQAF3LxVa1SWQiGrn
         fKtHth5rsa/nuGzKmwGiW4FN9KEwNY3cQDIWQdOIG2qSka/1zsRZz2DaIVS3XM8ooyxO
         H6omWu5h7v02WKpPoTsJJHiNW3issnZJsuqFhsmBMWGx30BQ30ZkugT7VIuLJtpj/FPa
         QiFJAGJFmQwhfGxhyo/VfdMG1u5Qu6gjQM7dffeNlBbp8TUim+iizRfCOy8AxKGn2ofb
         zmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=bu4IbrWa1ZTI+K96nWVl7AHAx8DAHzjVhBaPXw8WmYQ=;
        b=SuMUaWxK8EJAUsnjR0kIEZ6oUn5FKlAnxI+POaUMiiJYh6St8bXIsXqzYNHDF0fIYX
         5fqFnNaC61LJKuzMO7Zyan+Fby/yPxaFofOAe+21vLj61Rw6Gdh5/68luVA/lP28Wbc5
         uEbosX8KMHGVFvr3ihq2H20XrJ9KPjdSU8dlj5IGSc5h+rsdaFctgO6Xz5nVJSrBSWTO
         dGiXy2EtKqlY+oQNnWkokF7hsEVGv53RZOkot/rtwPmiw6XeYp4Hh03G5a1H6VA8Pf7P
         3WDZdfn7C0Zu75+sPj2zX/2kOs8Gxv/fHO5d2P90r75vwRd8xZe6zmK8hAMQDXp+celt
         lLcw==
X-Gm-Message-State: AGRZ1gLBKEEsjUqqZBiHn/zFj5W4UWeJ8Ejskxl2K0jGKMk6UGqwuABH
        VfG8yYGdvriUMHQVxlEKG8Y=
X-Google-Smtp-Source: AJdET5ezT8DuHFl7slz91VLfujbcelRhe5gqfiDSzUGIEFvwvy3XB/EPe+eclEDI3Snh8PKrLMpnZg==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr13568014pgq.189.1542458853508;
        Sat, 17 Nov 2018 04:47:33 -0800 (PST)
Received: from sabyasachi ([45.116.191.203])
        by smtp.gmail.com with ESMTPSA id c67sm9096389pfg.170.2018.11.17.04.47.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Nov 2018 04:47:32 -0800 (PST)
Message-ID: <5bf00de4.1c69fb81.7dd65.5785@mx.google.com>
X-Google-Original-Message-ID: <20181117124728.GA3056@sabyasachi.linux@gmail.com>
Date:   Sat, 17 Nov 2018 18:17:28 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     aacraid@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] scsi/dpt_i2o.c: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/scsi/dpt_i2o.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 37de8fb..056383a 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1370,13 +1370,12 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
 		schedule_timeout_uninterruptible(1);
 	} while (m == EMPTY_QUEUE);
 
-	status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
+	status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
 	if(status == NULL) {
 		adpt_send_nop(pHba, m);
 		printk(KERN_ERR"IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
-	memset(status,0,4);
 
 	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
 	msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
@@ -2836,14 +2835,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 
 	msg=(u32 __iomem *)(pHba->msg_addr_virt+m);
 
-	status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
+	status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
 	if (!status) {
 		adpt_send_nop(pHba, m);
 		printk(KERN_WARNING"%s: IOP reset failed - no free memory.\n",
 			pHba->name);
 		return -ENOMEM;
 	}
-	memset(status, 0, 4);
 
 	writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
 	writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
@@ -2890,14 +2888,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 			pHba->reply_pool, pHba->reply_pool_pa);
 	}
 
-	pHba->reply_pool = dma_alloc_coherent(&pHba->pDev->dev,
+	pHba->reply_pool = dma_zalloc_coherent(&pHba->pDev->dev,
 				pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4,
 				&pHba->reply_pool_pa, GFP_KERNEL);
 	if (!pHba->reply_pool) {
 		printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
 		return -ENOMEM;
 	}
-	memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
 
 	for(i = 0; i < pHba->reply_fifo_size; i++) {
 		writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
@@ -3126,13 +3123,12 @@ static int adpt_i2o_build_sys_table(void)
 	sys_tbl_len = sizeof(struct i2o_sys_tbl) +	// Header + IOPs
 				(hba_count) * sizeof(struct i2o_sys_tbl_entry);
 
-	sys_tbl = dma_alloc_coherent(&pHba->pDev->dev,
+	sys_tbl = dma_zalloc_coherent(&pHba->pDev->dev,
 				sys_tbl_len, &sys_tbl_pa, GFP_KERNEL);
 	if (!sys_tbl) {
 		printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");	
 		return -ENOMEM;
 	}
-	memset(sys_tbl, 0, sys_tbl_len);
 
 	sys_tbl->num_entries = hba_count;
 	sys_tbl->version = I2OVERSION;
-- 
2.7.4

