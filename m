Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F082133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="EWg6ueg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeLSInU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:43:20 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54018 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:43:19 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so8487684ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddJJKRBZKFVE0EAC9YSD6keBJ7y9nWFWSn8IjUTuVvY=;
        b=EWg6ueg6iZMTDACSnpvXdMYDELRXmuIizn4k+d7k2cnjE97lYBwQBtBsaBi16ipCVR
         zaaha3Rga8Gzb3gwjIbGkkSwc9lUhZJxnDe0A7NB7uEnZKHrPsGBMMHyuX7o76Q28K4t
         pkSuUMyhxlDsMLbHQEZSr+0D7I+7DLuAcpJ0N/YPEKd6zhamNGk+CrYXfi+62GAZDQLb
         o72WPA0SmDA0gWT8LG+vW9avrpNYEeAri+hGdqhdevVZp4iqrpz4fDESR9jxJn1fBE6z
         u6UlKBgOPtBjUu7UgAHrGHSCAV/V9FYalpxLO/BKBQ3mlxsmX4xWPXiZMEIbcViCgT09
         FG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddJJKRBZKFVE0EAC9YSD6keBJ7y9nWFWSn8IjUTuVvY=;
        b=gpQ0Nkbn9kvWF5G4d9YrVpYo/Hmb13vdKNgy5qcTLTDAPkVwXl7o1VZc19WSQL+AoX
         C1ZSya5jMY2K4Vy8IoK6fJnV3easBW2f+o4KzUDpYh2QdLQ3j3R9NTCI0ozz27MethcN
         +dUEYw+2UMdgcQis0WM5C5AFVxNymgLTXhi87Dz7PLMlvJQH/lMoLyEsbpra9HHqQPB0
         22vX4ipenbHFsdPECRbOngYZR9+zJuyt0EJjQmgA8qZWgCQajW090B4GDaFxcoykRp3i
         MNFbIST65y8p/KdIQ28mmcIqWyomSWPm7K4bQwfgwcWyYaxpiIvqKATj/HUJLH5xgsZF
         /ovQ==
X-Gm-Message-State: AA+aEWatkzWAlOj/nNaA4h+rjP1EgLTfU9bKrMLnJ01DqD59b3JCoCbX
        ZcHZTNPp+x5OpyhbC67UVjX/iw==
X-Google-Smtp-Source: AFSGD/WZM7H3zQ7NipGec4/iT6Zf5xZcuCl7lnLeSc0PIwl3yyqwC5yPc6GtXFh1sEcoBAB7GO/YrQ==
X-Received: by 2002:a05:660c:fd2:: with SMTP id m18mr5831878itn.1.1545208998692;
        Wed, 19 Dec 2018 00:43:18 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id p19sm4245408itp.13.2018.12.19.00.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:43:18 -0800 (PST)
Subject: [PATCH 5/12] scsi: arcmsr: Update for ACB_ADAPTER_TYPE_A that ccb
 address can above 4GB
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:43:15 +0800
Message-ID: <1545208995.4457.29.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update for ACB_ADAPTER_TYPE_A that ccb address can above 4GB

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 5353dbb..2ff1c9a 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1382,10 +1382,12 @@ static void arcmsr_drain_donequeue(struct AdapterControlBlock *acb, struct Comma
 static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 {
 	int i = 0;
-	uint32_t flag_ccb, ccb_cdb_phy;
+	uint32_t flag_ccb;
 	struct ARCMSR_CDB *pARCMSR_CDB;
 	bool error;
 	struct CommandControlBlock *pCCB;
+	unsigned long ccb_cdb_phy, cdb_phy_hipart;
+
 	switch (acb->adapter_type) {
 
 	case ACB_ADAPTER_TYPE_A: {
@@ -1397,7 +1399,10 @@ static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 		writel(outbound_intstatus, &reg->outbound_intstatus);/*clear interrupt*/
 		while(((flag_ccb = readl(&reg->outbound_queueport)) != 0xFFFFFFFF)
 				&& (i++ < acb->maxOutstanding)) {
-			pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset + (flag_ccb << 5));/*frame must be 32 bytes aligned*/
+			ccb_cdb_phy = (flag_ccb << 5) & 0xffffffff;
+			if (acb->cdb_phyadd_hipart)
+				ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
+			pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);
 			pCCB = container_of(pARCMSR_CDB, struct CommandControlBlock, arcmsr_cdb);
 			error = (flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR_MODE0) ? true : false;
 			arcmsr_drain_donequeue(acb, pCCB, error);
@@ -2333,8 +2338,13 @@ static void arcmsr_hbaA_postqueue_isr(struct AdapterControlBlock *acb)
 	struct ARCMSR_CDB *pARCMSR_CDB;
 	struct CommandControlBlock *pCCB;
 	bool error;
+	unsigned long cdb_phy_addr;
+
 	while ((flag_ccb = readl(&reg->outbound_queueport)) != 0xFFFFFFFF) {
-		pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset + (flag_ccb << 5));/*frame must be 32 bytes aligned*/
+		cdb_phy_addr = (flag_ccb << 5) & 0xffffffff;
+		if (acb->cdb_phyadd_hipart)
+			cdb_phy_addr = cdb_phy_addr | acb->cdb_phyadd_hipart;
+		pARCMSR_CDB = (struct ARCMSR_CDB *)(acb->vir2phy_offset + cdb_phy_addr);
 		pCCB = container_of(pARCMSR_CDB, struct CommandControlBlock, arcmsr_cdb);
 		error = (flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR_MODE0) ? true : false;
 		arcmsr_drain_donequeue(acb, pCCB, error);
@@ -3258,7 +3268,9 @@ static int arcmsr_hbaA_polling_ccbdone(struct AdapterControlBlock *acb,
 	uint32_t flag_ccb, outbound_intstatus, poll_ccb_done = 0, poll_count = 0;
 	int rtn;
 	bool error;
-	polling_hba_ccb_retry:
+	unsigned long ccb_cdb_phy;
+
+polling_hba_ccb_retry:
 	poll_count++;
 	outbound_intstatus = readl(&reg->outbound_intstatus) & acb->outbound_int_enable;
 	writel(outbound_intstatus, &reg->outbound_intstatus);/*clear interrupt*/
@@ -3276,7 +3288,10 @@ static int arcmsr_hbaA_polling_ccbdone(struct AdapterControlBlock *acb,
 				goto polling_hba_ccb_retry;
 			}
 		}
-		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset + (flag_ccb << 5));
+		ccb_cdb_phy = (flag_ccb << 5) & 0xffffffff;
+		if (acb->cdb_phyadd_hipart)
+			ccb_cdb_phy = ccb_cdb_phy | acb->cdb_phyadd_hipart;
+		arcmsr_cdb = (struct ARCMSR_CDB *)(acb->vir2phy_offset + ccb_cdb_phy);
 		ccb = container_of(arcmsr_cdb, struct CommandControlBlock, arcmsr_cdb);
 		poll_ccb_done |= (ccb == poll_ccb) ? 1 : 0;
 		if ((ccb->acb != acb) || (ccb->startdone != ARCMSR_CCB_START)) {


