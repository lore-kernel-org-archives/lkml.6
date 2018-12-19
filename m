Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532952133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="F69AxDLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeLSIvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:51:19 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46144 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbeLSIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:51:18 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so14960598ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaH33yW1of+eoMa7Moo1ZSWkoDveProhv9xq3bpPJ6Y=;
        b=F69AxDLhhE3m0HTekc4vMSIdVcDSajs9bD0sVoBRzQM5dj8upaNQoItFr2j8XhHNr5
         TYYY18+SQZ+Eu/vs+yJZyIsPDTrX6t27134RP9/ifrBSd2Kdlc1qpHsi4YfBKQXwYrKD
         NQSm2v4OvbxWqx97uBRlwlom6pdhE3xBZ0yD2dkglxFSfbLVTq8awPPnj/NpGegrYc0C
         DgmSj5kXkCH4Zm+tjO9Fx6ZsKlDXh2eRXMtjoImIzzbtWrmVLAmUS31Oco6QCro1ap7W
         UmUCaF8GiYa/o4iADEv+LU3Sdi7LFhHDweHrH18B3EBYwopkzYAEE096J/NcO5iaz4EJ
         8m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaH33yW1of+eoMa7Moo1ZSWkoDveProhv9xq3bpPJ6Y=;
        b=IaBJyDihVmwyYDO4px6uCfDYVF0Rh6NEzRX3PuGboECLLXQzunmkizqnySxiIdgLoK
         aQaKYmjhhQdvgVfl1Tp4FLossrm+StuCZ+l/VuU3Gvo/HoXNipmtnbShLGYnxpRkTeWK
         QgGQZNAc7dN4h25lPY+xiYszrRVCOUbsFyU7hWGr5RyzIXmSn+mqi1end75V1BLdgUvb
         KKD17pOIRvTQzrOillmFJu7DjvKdGrS9jBp5rPkc9SW2YatLArI7za1qisUinOnRszUQ
         wR3NBs8aMtb6UN8bCAL3WB7evAVNYMySg9B0Ni/xbfiF3wnoxQ9DjCbFqanIvdCtYEe5
         Q0Og==
X-Gm-Message-State: AJcUukeZnqP3lAjuLJbaSUx+JQY6MP+6rxvlGUBuB6Vnr9WIl8l1Oi3s
        DnDhljgyLI7ZzJnwHHAUe1F4DA==
X-Google-Smtp-Source: AFSGD/VuOzGiiVFsyeQ2+TkWCGL4zKsGWOYVnPq5blPY4iZ8JGblhIXf4JJvF0DJGao96HIqp4+t4w==
X-Received: by 2002:a6b:e607:: with SMTP id g7mr478508ioh.292.1545209477469;
        Wed, 19 Dec 2018 00:51:17 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id a25sm202358iod.63.2018.12.19.00.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:51:17 -0800 (PST)
Subject: [PATCH 8/12] scsi: arcmsr: Update for ACB_ADAPTER_TYPE_D that ccb
 address can above 4GB
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:51:14 +0800
Message-ID: <1545209474.4457.38.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update for ACB_ADAPTER_TYPE_D that ccb address can above 4GB

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 39f3cd0..8cc2134 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1468,9 +1468,13 @@ static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 					((toggle ^ 0x4000) + 1);
 				doneq_index = pmu->doneq_index;
 				spin_unlock_irqrestore(&acb->doneq_lock, flags);
+				cdb_phy_hipart = pmu->done_qbuffer[doneq_index &
+					0xFFF].addressHigh;
 				addressLow = pmu->done_qbuffer[doneq_index &
 					0xFFF].addressLow;
 				ccb_cdb_phy = (addressLow & 0xFFFFFFF0);
+				if (acb->cdb_phyadd_hipart)
+					ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
 				pARCMSR_CDB = (struct  ARCMSR_CDB *)
 					(acb->vir2phy_offset + ccb_cdb_phy);
 				pCCB = container_of(pARCMSR_CDB,
@@ -1802,8 +1806,8 @@ static void arcmsr_post_ccb(struct AdapterControlBlock *acb, struct CommandContr
 		spin_lock_irqsave(&acb->postq_lock, flags);
 		postq_index = pmu->postq_index;
 		pinbound_srb = (struct InBound_SRB *)&(pmu->post_qbuffer[postq_index & 0xFF]);
-		pinbound_srb->addressHigh = dma_addr_hi32(cdb_phyaddr);
-		pinbound_srb->addressLow = dma_addr_lo32(cdb_phyaddr);
+		pinbound_srb->addressHigh = upper_32_bits(ccb->cdb_phyaddr);
+		pinbound_srb->addressLow = cdb_phyaddr;
 		pinbound_srb->length = ccb->arc_cdb_size >> 2;
 		arcmsr_cdb->msgContext = dma_addr_lo32(cdb_phyaddr);
 		toggle = postq_index & 0x4000;
@@ -2415,12 +2419,12 @@ static void arcmsr_hbaC_postqueue_isr(struct AdapterControlBlock *acb)
 static void arcmsr_hbaD_postqueue_isr(struct AdapterControlBlock *acb)
 {
 	u32 outbound_write_pointer, doneq_index, index_stripped, toggle;
-	uint32_t addressLow, ccb_cdb_phy;
+	uint32_t addressLow;
 	int error;
 	struct MessageUnit_D  *pmu;
 	struct ARCMSR_CDB *arcmsr_cdb;
 	struct CommandControlBlock *ccb;
-	unsigned long flags;
+	unsigned long flags, ccb_cdb_phy, cdb_phy_hipart;
 
 	spin_lock_irqsave(&acb->doneq_lock, flags);
 	pmu = acb->pmuD;
@@ -2434,9 +2438,13 @@ static void arcmsr_hbaD_postqueue_isr(struct AdapterControlBlock *acb)
 			pmu->doneq_index = index_stripped ? (index_stripped | toggle) :
 				((toggle ^ 0x4000) + 1);
 			doneq_index = pmu->doneq_index;
+			cdb_phy_hipart = pmu->done_qbuffer[doneq_index &
+				0xFFF].addressHigh;
 			addressLow = pmu->done_qbuffer[doneq_index &
 				0xFFF].addressLow;
 			ccb_cdb_phy = (addressLow & 0xFFFFFFF0);
+			if (acb->cdb_phyadd_hipart)
+				ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
 			arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset
 				+ ccb_cdb_phy);
 			ccb = container_of(arcmsr_cdb,
@@ -3464,9 +3472,9 @@ static int arcmsr_hbaD_polling_ccbdone(struct AdapterControlBlock *acb,
 				struct CommandControlBlock *poll_ccb)
 {
 	bool error;
-	uint32_t poll_ccb_done = 0, poll_count = 0, flag_ccb, ccb_cdb_phy;
+	uint32_t poll_ccb_done = 0, poll_count = 0, flag_ccb;
 	int rtn, doneq_index, index_stripped, outbound_write_pointer, toggle;
-	unsigned long flags;
+	unsigned long flags, ccb_cdb_phy, cdb_phy_hipart;
 	struct ARCMSR_CDB *arcmsr_cdb;
 	struct CommandControlBlock *pCCB;
 	struct MessageUnit_D *pmu = acb->pmuD;
@@ -3498,8 +3506,12 @@ polling_hbaD_ccb_retry:
 				((toggle ^ 0x4000) + 1);
 		doneq_index = pmu->doneq_index;
 		spin_unlock_irqrestore(&acb->doneq_lock, flags);
+		cdb_phy_hipart = pmu->done_qbuffer[doneq_index &
+				0xFFF].addressHigh;
 		flag_ccb = pmu->done_qbuffer[doneq_index & 0xFFF].addressLow;
 		ccb_cdb_phy = (flag_ccb & 0xFFFFFFF0);
+		if (acb->cdb_phyadd_hipart)
+			ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
 		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset +
 			ccb_cdb_phy);
 		pCCB = container_of(arcmsr_cdb, struct CommandControlBlock,


