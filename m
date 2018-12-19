Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5CE20656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="WgPhDiu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeLSI7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:59:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44624 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbeLSI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:59:52 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so15007438iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+h2YCxm7+KpXp0tpxHu9VDkXi6qv8hQffWn/Z4nLN0=;
        b=WgPhDiu3u8HpvnFgSU8q6nLjj/UySTp0J7S1jP9t3jdAx3EVTLe7kFVkWBcJadqLSb
         NOyJ+IA1UaCBPt2FVj0z9ZsliPMyP3nx7zQ9c9HRq/7JtuFtD2GsTQ+1TaswQ3EJ5SoA
         RgvXz50Sp01aAboPCKYDmwDY2ORc6z22NlDfB0bp0vBgqMMEH7270ZAtQdIEBF6hUFNf
         U8+VsbIHHTeqa9cLWli0eQpl47iOHkv+iwV07jLMPtP9PmKNo6NBZEVAC6gJwWlpitzs
         8LcBSfRS/AvO5PEGCnb8mA2I+k740jsv8TuF2/Q2BEmQ65tzYRiVHHpSoWTCO838o/s4
         Cfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+h2YCxm7+KpXp0tpxHu9VDkXi6qv8hQffWn/Z4nLN0=;
        b=Z+gLr0pFOk6dhxyvIloTjZg7AwvNdUW5LR+3yWmw2AZnJJPrGl5/lZtmej6GsBub1C
         BPHbjhPEW4w0No6yNtD4SworvEd886vmwFWdfue4dh73ISfW1kpRc5EEi4X+efaaawps
         eAuNO0xblHUXa7atM8Cfw/hEoV1Yj6vg+7eMSiCa+FBi6wTVFyvfRynXj8GH7QugdM71
         RWc0F/aTHDvEuexw8rD2n9b72u2/fNgU3wJ+546H5lzkQG1u3N4cIVBWNmG6QFRoU7ZW
         pIVecsUlmOfuTdq5reeBgZLZdw2kymCNdXSgL0Pbha8smUFH0cpd6yM2eZ5n+kvUR62d
         HiEA==
X-Gm-Message-State: AA+aEWb6Ktz7RV3VIu33gXDRH+cOX2XhCoR6kFUV4f0Etnfw8dlrJnKK
        kTCbXP8WFW8024jkFaCOF9bD3g==
X-Google-Smtp-Source: AFSGD/XIe+NpHvwiMLYBpxZgq4jj1S03ZnKMnKJdBZN+GekYQifgn7n8PmADqhV6GPCic23Ur/OUwA==
X-Received: by 2002:a5d:91c7:: with SMTP id k7mr18720489ior.31.1545209991385;
        Wed, 19 Dec 2018 00:59:51 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id a16sm403683iol.11.2018.12.19.00.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:59:50 -0800 (PST)
Subject: [PATCH 11/12] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:59:48 +0800
Message-ID: <1545209988.4457.47.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Fix suspend/resume of ACB_ADAPTER_TYPE_B

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 30dff6c..9f85d5a 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1110,12 +1110,21 @@ static int arcmsr_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	if (arcmsr_request_irq(pdev, acb) == FAILED)
 		goto controller_stop;
-	if (acb->adapter_type == ACB_ADAPTER_TYPE_E) {
+	switch (acb->adapter_type) {
+	case ACB_ADAPTER_TYPE_B: {
+		struct MessageUnit_B *reg = acb->pmuB;
+		reg->post_qbuffer[0] = 0;
+		reg->postq_index = 0;
+		reg->doneq_index = 0;
+		break;
+		}
+	case ACB_ADAPTER_TYPE_E:
 		writel(0, &acb->pmuE->host_int_status);
 		writel(ARCMSR_HBEMU_DOORBELL_SYNC, &acb->pmuE->iobound_doorbell);
 		acb->in_doorbell = 0;
 		acb->out_doorbell = 0;
 		acb->doneq_index = 0;
+		break;
 	}
 	arcmsr_iop_init(acb);
 	arcmsr_init_get_devmap_timer(acb);


