Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA07C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E0E20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="QH/nbSrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfARC6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:58:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:58:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so5813536pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4VpzqOOpFHSKfG6lkiV1ToMp9cD2QVH4F/ND1wf9NQ=;
        b=QH/nbSrGQ/A75EADukmRuF1tQn2+B+X14yho9ytOmOpitNcLlJOlqfbTlafIyQtq0E
         5QwVpWnl+pVwD5AETrTdLXL/bQNf88y+ZEN94rDxieRVDVgbpOjF9qEWJf2K9KO/6vnH
         BEN2LCuGZa8IJCnf6bhKS2sUMhP9z9XgzTdBwR9byeGPztiPdK8W/jOYnXxWrrM2K3TS
         bTL9i2lNcHoCvACoqTBeFSBIE0suDYXe/J1XYGQ2X8Xt/dnD2JiM9NsFAzyw5xfeu1Vz
         dyqPjivNYk+XyAevXdyB3MDk8wtZFFmLA+uvc3TDn7H3HkqzeNa81/Ee/LRWOCEa93Gu
         gWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4VpzqOOpFHSKfG6lkiV1ToMp9cD2QVH4F/ND1wf9NQ=;
        b=XD7u8MY7hZC8lJ1jSIPrpXQ03SSCYVtlqcLpv6yEsATzKyo+zsWbRGoiUiYhklUOFF
         aD1YjT1O6MUFc7J0MSbVKxUVuhzmk9aY1zni4M/rU8I3Kjt3LLqGtO7ihFFo2QN3z2dE
         EKnhEy3ZnUuXmyheZDuDkExO3ixSzgj1P4B0shjgizJ3G8YNbhtab8Okkj8kM5ezFbR2
         orCQMWtewS1dMpLOICrgVyduTISYm0vhFUn5287VBlGuegY8qIAnRjWlo7Sb2VbBxqcI
         pbl5iw1/a7KbBc6tJnrlpWAubF0LAMWSr7tHRVQvQQ9GEU6ncpMGe8ViPQiOySzu2PYH
         JS/w==
X-Gm-Message-State: AJcUukdlu/tKzHLhkMk0FnVg96JHRBeL79FJRU7BFv1Oex58SJm8/lok
        OekkYJA/MIluCHogLRY1TceEVg==
X-Google-Smtp-Source: ALg8bN4Ny1fg/tE288LKcy+Dgm0VqIGEkfPU96o6d0bRBskkJ07OUrNhGeA9LVad9Hz4ZdwFXhzONw==
X-Received: by 2002:a63:d157:: with SMTP id c23mr15813305pgj.170.1547780334009;
        Thu, 17 Jan 2019 18:58:54 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id u29sm3938054pgn.23.2019.01.17.18.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 18:58:53 -0800 (PST)
Subject: [PATCH v2 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 18 Jan 2019 10:58:51 +0800
Message-ID: <1547780331.4532.19.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

For ACB_ADAPTER_TYPE_B controller, the read/write after hibernate and resume may
got 'isr get an illegal ccb command' in log/messages sometimes. This patch fix it.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

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


