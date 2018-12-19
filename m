Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861C52133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="mL0luIlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeLSIsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:48:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37412 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:48:20 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so8293647iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91cK41622Bk30nY4GR93PRNznxMen4Yel0Dtj/7xX2Y=;
        b=mL0luIlFVzJcf8vj4/E4SbMghbqNLeICtYgWfLB/FY559V2fA4T85aENrqwMqD+DR7
         gMWu5AjX4N5lmvy6b2A1Vz9AgUhW3WcVSGX7L4brTjeS2Z979WfBHg69YuLG/eXw76OJ
         CJ6MCDO3Q+73fgCBqntqPv4Mt65mtW1/Q9t5PA+W03vDUlo+zPBFXYzlRlMx0miwM7lV
         4OPOU/3eXcvzvAAb22R9sTcOni536FbgALjBWIULzWJBpNZlqp4GTyqpY/4Zm/6sBSN0
         2zuLCk8RnRt84G6izYW9NlmFevoRGamE4TS87aZu3eTffU122ChDvhxqXtRffowYZuM0
         mZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91cK41622Bk30nY4GR93PRNznxMen4Yel0Dtj/7xX2Y=;
        b=q6asCOxB91OaXgPVmO0JQtLGpPjWgF65z/iaYie3GHVQBcqKKwFOLgF/pq2vAg6CGt
         GdESPd3PNVXPLkYM3zyGblJpm0+CHIuie3xI1IK/OYrgQE52td1tTOw0txFCl4qMB3Lk
         pCzV5POxCcO3AXJcjAMXD+3zHATKh8B5CThQpf9y7RIPL+hddtWHvrZtLEH8vHVWumk4
         SM0H8vvOas9XthT3WH/PdpAWxGutvJYu3EKExNpLdC1H54XYnbuPj55qSf6c4HzHh6gM
         JvlFeIRg59KbJoOetfvzmXKrI3RwlCaSJ5/lBJL3sNhQBDy4XopiaMWSkWQn3Yc7YFR+
         oAPA==
X-Gm-Message-State: AA+aEWavsWWoa0qZ7BtJGksJYWXt1vx9MRC1DH0VNCT/Ddq+xBjH+zVo
        zN2Si8WH4PVkIvNpzFU99RP1mRdXw2B18Q==
X-Google-Smtp-Source: AFSGD/V/u840ciNhqwMR+gG8+aWHVuGMAcLz95CsCxu2ocLECKaQaqPJiaumky9uRwQKKYQ1WoMi8w==
X-Received: by 2002:a24:ce42:: with SMTP id v63mr5683665itg.136.1545209299818;
        Wed, 19 Dec 2018 00:48:19 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id u25sm7902103iob.23.2018.12.19.00.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:48:19 -0800 (PST)
Subject: [PATCH 7/12] scsi: arcmsr: Update for ACB_ADAPTER_TYPE_C that ccb
 address can above 4GB
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:48:16 +0800
Message-ID: <1545209296.4457.35.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update for ACB_ADAPTER_TYPE_C that ccb address can above 4GB

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 3d2727c..39f3cd0 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1438,7 +1438,9 @@ static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 			/*need to do*/
 			flag_ccb = readl(&reg->outbound_queueport_low);
 			ccb_cdb_phy = (flag_ccb & 0xFFFFFFF0);
-			pARCMSR_CDB = (struct  ARCMSR_CDB *)(acb->vir2phy_offset+ccb_cdb_phy);/*frame must be 32 bytes aligned*/
+			if (acb->cdb_phyadd_hipart)
+				ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
+			pARCMSR_CDB = (struct  ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);
 			pCCB = container_of(pARCMSR_CDB, struct CommandControlBlock, arcmsr_cdb);
 			error = (flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR_MODE1) ? true : false;
 			arcmsr_drain_donequeue(acb, pCCB, error);
@@ -1786,12 +1788,8 @@ static void arcmsr_post_ccb(struct AdapterControlBlock *acb, struct CommandContr
 
 		arc_cdb_size = (ccb->arc_cdb_size > 0x300) ? 0x300 : ccb->arc_cdb_size;
 		ccb_post_stamp = (cdb_phyaddr | ((arc_cdb_size - 1) >> 6) | 1);
-		if (acb->cdb_phyaddr_hi32) {
-			writel(acb->cdb_phyaddr_hi32, &phbcmu->inbound_queueport_high);
-			writel(ccb_post_stamp, &phbcmu->inbound_queueport_low);
-		} else {
-			writel(ccb_post_stamp, &phbcmu->inbound_queueport_low);
-		}
+		writel(upper_32_bits(ccb->cdb_phyaddr), &phbcmu->inbound_queueport_high);
+		writel(ccb_post_stamp, &phbcmu->inbound_queueport_low);
 		}
 		break;
 	case ACB_ADAPTER_TYPE_D: {
@@ -2384,7 +2382,8 @@ static void arcmsr_hbaC_postqueue_isr(struct AdapterControlBlock *acb)
 	struct MessageUnit_C __iomem *phbcmu;
 	struct ARCMSR_CDB *arcmsr_cdb;
 	struct CommandControlBlock *ccb;
-	uint32_t flag_ccb, ccb_cdb_phy, throttling = 0;
+	uint32_t flag_ccb, throttling = 0;
+	unsigned long ccb_cdb_phy;
 	int error;
 
 	phbcmu = acb->pmuC;
@@ -2394,6 +2393,8 @@ static void arcmsr_hbaC_postqueue_isr(struct AdapterControlBlock *acb)
 	while ((flag_ccb = readl(&phbcmu->outbound_queueport_low)) !=
 			0xFFFFFFFF) {
 		ccb_cdb_phy = (flag_ccb & 0xFFFFFFF0);
+		if (acb->cdb_phyadd_hipart)
+			ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
 		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset
 			+ ccb_cdb_phy);
 		ccb = container_of(arcmsr_cdb, struct CommandControlBlock,
@@ -3401,12 +3402,14 @@ static int arcmsr_hbaC_polling_ccbdone(struct AdapterControlBlock *acb,
 		struct CommandControlBlock *poll_ccb)
 {
 	struct MessageUnit_C __iomem *reg = acb->pmuC;
-	uint32_t flag_ccb, ccb_cdb_phy;
+	uint32_t flag_ccb;
 	struct ARCMSR_CDB *arcmsr_cdb;
 	bool error;
 	struct CommandControlBlock *pCCB;
 	uint32_t poll_ccb_done = 0, poll_count = 0;
 	int rtn;
+	unsigned long ccb_cdb_phy;
+
 polling_hbc_ccb_retry:
 	poll_count++;
 	while (1) {
@@ -3425,7 +3428,9 @@ polling_hbc_ccb_retry:
 		}
 		flag_ccb = readl(&reg->outbound_queueport_low);
 		ccb_cdb_phy = (flag_ccb & 0xFFFFFFF0);
-		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);/*frame must be 32 bytes aligned*/
+		if (acb->cdb_phyadd_hipart)
+			ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
+		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);
 		pCCB = container_of(arcmsr_cdb, struct CommandControlBlock, arcmsr_cdb);
 		poll_ccb_done |= (pCCB == poll_ccb) ? 1 : 0;
 		/* check ifcommand done with no error*/
@@ -3801,7 +3806,6 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 		}
 		break;
 	case ACB_ADAPTER_TYPE_C: {
-		if (cdb_phyaddr_hi32 != 0) {
 			struct MessageUnit_C __iomem *reg = acb->pmuC;
 
 			printk(KERN_NOTICE "arcmsr%d: cdb_phyaddr_hi32=0x%x\n",
@@ -3816,7 +3820,6 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 				return 1;
 			}
 		}
-		}
 		break;
 	case ACB_ADAPTER_TYPE_D: {
 		uint32_t __iomem *rwbuffer;


