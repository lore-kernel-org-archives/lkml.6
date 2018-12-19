Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99B12184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="hgtiqqFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeLSIpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:45:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35580 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLSIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:45:50 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so8294950itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPs1z8W9DxRbdbZ1U32ivf/6EzPqQhb6/E45VHEIBPo=;
        b=hgtiqqFRxYp/SgXIncNJvbCAAEGDgFM/yTs4p0VvNDJMcCoQ4obgLlht0KweIpcvtt
         Eb9y+Bxrbv9qahCAPQweWSi0/kl8q22X4r8czdYH9xtpejP/yWdttE+aaQIHduALHnWU
         XVjwRSlpbZF2s06tPxQe4V7X6OflzBQ1FzOoaFK00wuhmlg+cNGi79yqYnTNOJnl6ogO
         pGYA9xCRqoUYpRJaKGQD8j087yU8gxYuqZslGiyRCAqVxX982rB70W55+L5vckk8qX4A
         7ktaYAjP2h/XpPIIwn+92a2Crm05XMnPGdnCWZlMhyABXq6OWA4zedMzQFJH7AuHVs53
         JvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPs1z8W9DxRbdbZ1U32ivf/6EzPqQhb6/E45VHEIBPo=;
        b=PcUHf4ez3MYuCF9Psys8515005ywk8zQ65yYwJm+Bp624+0CzIgXYohZGd5KtiY5MB
         LJu/0zpl5rOrgtEdf6RQWNwp+qkQEd6Phc69cOKH65BPjDxkcdb/bjPCgxzqzvIHKerB
         5uxCM7jOMHT9LtgAHRh0kR3LIOJ/EhITLszXnM/nlHvIPBNHBKKavKLQaJzUsBF/7w04
         3vlbaJP124vfXJfga0fvzE3Arsdf9JfMODjvPqhWA9N9Cg0qjQCjdnW7tttXTSQxfUuC
         mKegenihRkbk1YQ1sV46hgkzvTSE0fYrzjrPg6sgdDGDIGiDd2AMp5oHW1C9RsB6PXwD
         8kow==
X-Gm-Message-State: AA+aEWYaT0RzWqhtfl1kgrVaKVkdkGpm9SnBEVpDx2u2kZ0O5ldIitvs
        wxow1US36XabA8te9EdDgrYDbQ==
X-Google-Smtp-Source: AFSGD/VFGJepoPdjx8afDt7UCcO0IZ0e1du3O3Bh5p/pvbeG/E0sSk7XSYD5NqUN6rhYCzlFy3BMJg==
X-Received: by 2002:a24:bc1:: with SMTP id 184mr6115613itd.50.1545209149213;
        Wed, 19 Dec 2018 00:45:49 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id b192sm2848377itb.12.2018.12.19.00.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:45:48 -0800 (PST)
Subject: [PATCH 6/12] scsi: arcmsr: Update for ACB_ADAPTER_TYPE_B that ccb
 address can above 4GB
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:45:46 +0800
Message-ID: <1545209146.4457.32.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update for ACB_ADAPTER_TYPE_B that ccb address can above 4GB

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 2ff1c9a..3d2727c 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1418,7 +1418,10 @@ static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 			flag_ccb = reg->done_qbuffer[i];
 			if (flag_ccb != 0) {
 				reg->done_qbuffer[i] = 0;
-				pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset+(flag_ccb << 5));/*frame must be 32 bytes aligned*/
+				ccb_cdb_phy = (flag_ccb << 5) & 0xffffffff;
+				if (acb->cdb_phyadd_hipart)
+					ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
+				pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);
 				pCCB = container_of(pARCMSR_CDB, struct CommandControlBlock, arcmsr_cdb);
 				error = (flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR_MODE0) ? true : false;
 				arcmsr_drain_donequeue(acb, pCCB, error);
@@ -2358,13 +2361,18 @@ static void arcmsr_hbaB_postqueue_isr(struct AdapterControlBlock *acb)
 	struct ARCMSR_CDB *pARCMSR_CDB;
 	struct CommandControlBlock *pCCB;
 	bool error;
+	unsigned long cdb_phy_addr;
+
 	index = reg->doneq_index;
 	while ((flag_ccb = reg->done_qbuffer[index]) != 0) {
-		reg->done_qbuffer[index] = 0;
-		pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset+(flag_ccb << 5));/*frame must be 32 bytes aligned*/
+		cdb_phy_addr = (flag_ccb << 5) & 0xffffffff;
+		if (acb->cdb_phyadd_hipart)
+			cdb_phy_addr = cdb_phy_addr | acb->cdb_phyadd_hipart;
+		pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset + cdb_phy_addr);
 		pCCB = container_of(pARCMSR_CDB, struct CommandControlBlock, arcmsr_cdb);
 		error = (flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR_MODE0) ? true : false;
 		arcmsr_drain_donequeue(acb, pCCB, error);
+		reg->done_qbuffer[index] = 0;
 		index++;
 		index %= ARCMSR_MAX_HBB_POSTQUEUE;
 		reg->doneq_index = index;
@@ -3329,8 +3337,9 @@ static int arcmsr_hbaB_polling_ccbdone(struct AdapterControlBlock *acb,
 	uint32_t flag_ccb, poll_ccb_done = 0, poll_count = 0;
 	int index, rtn;
 	bool error;
-	polling_hbb_ccb_retry:
+	unsigned long ccb_cdb_phy;
 
+polling_hbb_ccb_retry:
 	poll_count++;
 	/* clear doorbell interrupt */
 	writel(ARCMSR_DOORBELL_INT_CLEAR_PATTERN, reg->iop2drv_doorbell);
@@ -3356,7 +3365,10 @@ static int arcmsr_hbaB_polling_ccbdone(struct AdapterControlBlock *acb,
 		index %= ARCMSR_MAX_HBB_POSTQUEUE;
 		reg->doneq_index = index;
 		/* check if command done with no error*/
-		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset + (flag_ccb << 5));
+		ccb_cdb_phy = (flag_ccb << 5) & 0xffffffff;
+		if (acb->cdb_phyadd_hipart)
+			ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
+		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);
 		ccb = container_of(arcmsr_cdb, struct CommandControlBlock, arcmsr_cdb);
 		poll_ccb_done |= (ccb == poll_ccb) ? 1 : 0;
 		if ((ccb->acb != acb) || (ccb->startdone != ARCMSR_CCB_START)) {


