Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EBCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0BB20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="VSDwgXPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfAQDpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:45:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46195 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfAQDpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:45:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so4032068ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRQzgU5z/NPfrgHuTm6KB2ev9Kvfh2XOpogWLR16sW0=;
        b=VSDwgXPRL7nvx3InzaIyIsQE23gxqDSgXdfCmNA4OnDDpKM0LR8JiTiiluaxLz4uv3
         OxLLi/sguygzU/1Zyd6qsAUznRr1zo34K2Qy5nUxE3Vbr2ud/PRtwDU2G+um/8UDYM+Y
         PS4y1BegoIOXFAZakosjoYvIQ3KUCfmktTwyPLj0pI1W2v5MoiIax0zI8v8kAi4iMl4G
         aAGGC7eopCGKE36ZlrwAPDIw3M8dKKAiFs/dDceVKLH8tCDRmftLo26svfTDTEF8/gR5
         SLTB6b/4h00gz2B3pJcPYNc9MzHhPX3EQRVmuwBz0vPnkGCfhWs93r8bFqZoIt/FC4A/
         gikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRQzgU5z/NPfrgHuTm6KB2ev9Kvfh2XOpogWLR16sW0=;
        b=J0qUMFpzfdSP0TWRQIxYoXJPKP3m043qYwP9xEga5Riekck1T+MIcbdgswU/lgQKZt
         C0H4LCoOtZZt3PMSmtfjX1QKyPktJu+LWOOLcdDlWejN2CWVPs5ODQoAVjzjZKb1tJ5a
         3Jzed9s/rgRzMvsHqIaOveWel6Q4z43rMBWrCf821L10xg0BqA8+2tKJyfz1lCr0TmHY
         1MR6a8aWUhGH2Gx4UMzZpLY7vFIWF7CcJpkkmUQ60vU1qLirp7TSEEz6JN4jRUK4BleU
         4IYLYANlCHjMfycnskIjupTnsI2O/iNAA5LEatqQZw9Jb/X/g/9xgp7pOENa2fkXf0p9
         qoTw==
X-Gm-Message-State: AJcUukdxZzR+yW3VfKJpzLTai851p3Ir0vC+N1CRZS5PlKzk25VR26Eo
        r+RQXcQVdhDMyF2/SQTGfLZWLQ==
X-Google-Smtp-Source: ALg8bN5HR0uPxjHjxRvpxBsAh5HlMO/3slRbg4XfHYIHiIKVpmKl8wjjiOu1X/O+djHadlM9BtoMlA==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr13325644plb.192.1547696706020;
        Wed, 16 Jan 2019 19:45:06 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id w23sm253702pgc.72.2019.01.16.19.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 19:45:05 -0800 (PST)
Subject: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of ACB_ADAPTER_TYPE_B
 part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 11:45:03 +0800
Message-ID: <1547696703.4339.21.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index a94c513..b98c632 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -508,9 +508,9 @@ struct MessageUnit_A
 struct MessageUnit_B
 {
 	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
-	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
+	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
 	uint32_t	postq_index;
-	uint32_t	doneq_index;
+	volatile uint32_t	doneq_index;
 	uint32_t	__iomem *drv2iop_doorbell;
 	uint32_t	__iomem *drv2iop_doorbell_mask;
 	uint32_t	__iomem *iop2drv_doorbell;
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 5736434..88053b1 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1113,7 +1113,11 @@ static int arcmsr_resume(struct pci_dev *pdev)
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_B: {
 		struct MessageUnit_B *reg = acb->pmuB;
-		reg->post_qbuffer[0] = 0;
+		uint32_t i;
+		for (i = 0; i < ARCMSR_MAX_HBB_POSTQUEUE; i++) {
+			reg->post_qbuffer[i] = 0;
+			reg->done_qbuffer[i] = 0;
+		}
 		reg->postq_index = 0;
 		reg->doneq_index = 0;
 		break;


