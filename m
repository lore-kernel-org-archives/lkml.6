Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE90C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8100820877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="NGqZ+Lld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8100820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=areca.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeGIKZA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:25:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35394 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932996AbeGIKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:24:57 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so16590503iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WrIyDofz5VI1M5T6hRvL9mvV674AHFx1aRK8rbQu/NU=;
        b=NGqZ+LldDBTybWNY90sxZEvDB2vVNM+5eGLfh7DDNzQcHsTpIh1UoMwfdHC2lxfYQ1
         eO/hijXdyWe3iE+5FFMkuBys5MyGoAbHObO51xkU462frppCmbvlIGjbzmrZ+hXQTwsq
         Bol6uNhw0dqkW1JjJ+5HtMQR5Y9jAwP6z0wlIZ5jXPliEarH67iYK3SjQmSaR8xdnAq0
         FmmKbwjREII7uY+Q5YEDAAXF49M9giWeN2Ygf7nyarE+JTDRtufMUIeo1+gql//KH1hi
         cAx1HewgsGDmyTckGMbDbpJ1jE0drkn+M61BIHr9ldQzWm6/rCKnSHXOkxhWFNfif6xu
         dpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WrIyDofz5VI1M5T6hRvL9mvV674AHFx1aRK8rbQu/NU=;
        b=Exe0Q0oKKubvzFVxMoIeLoz2R5h4YYsaYGaWXREgMm6zHj1HETb8APppe7TzhKIByk
         NxqgZl6atBy4tlR9yzAzyradaXQupvIwDMYv1hCEtgwtKP9qiRqDP6BWZOuDweYEO5BV
         oVRxfJ0tmiW9ASlFqwU1tvYse9j/WYA3xIW7v2HEESSEAPMC4a9/0DmzzBfJs1v37KN2
         HTewU30ZvZtA/OFnSxuJogY/lqZF8JThGRuEyQnZlhNL0hkSqA17C3yCHgWn9g+28pdO
         u8ybPij3Y5vircppOTo5uAGr/qr3Dnxb6g0CA3sf0Tjev+ojzj/TY0AM6MbouK2Lk01l
         1+SA==
X-Gm-Message-State: AOUpUlEIJMPCuTqFLCluJaMWAdT2D/M4PVEToUH1JhqvB1kYPg5aGy8O
        5HN19wLWK6qqGaueHH9JE/9B2g==
X-Google-Smtp-Source: AAOMgpdizl6+Zx0l4XoQDRM9WFMlVI6G8vBbvPbDozxxVpZvv3ClrR+KywXiSyLi2G5DRvSe61IXag==
X-Received: by 2002:a6b:b0c5:: with SMTP id z188-v6mr16319599ioe.220.1531131897325;
        Mon, 09 Jul 2018 03:24:57 -0700 (PDT)
Received: from [192.168.0.108] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id h194-v6sm6481061ioe.11.2018.07.09.03.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:24:56 -0700 (PDT)
Subject: [PATCH 1/2] scsi: arcmsr: Fix error of resuming from hibernation
 for adapter type E
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 09 Jul 2018 18:24:53 +0800
Message-ID: <1531131893.5779.13.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Fix error of resuming from hibernation for adapter type E.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 732b5d9..12316ef 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1061,6 +1061,13 @@ static int arcmsr_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	if (arcmsr_request_irq(pdev, acb) == FAILED)
 		goto controller_stop;
+	if (acb->adapter_type == ACB_ADAPTER_TYPE_E) {
+		writel(0, &acb->pmuE->host_int_status);
+		writel(ARCMSR_HBEMU_DOORBELL_SYNC, &acb->pmuE->iobound_doorbell);
+		acb->in_doorbell = 0;
+		acb->out_doorbell = 0;
+		acb->doneq_index = 0;
+	}
 	arcmsr_iop_init(acb);
 	arcmsr_init_get_devmap_timer(acb);
 	if (set_date_time)



