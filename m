Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D86C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E7B2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="e5MakDuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLXRmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:42:08 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57944 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:42:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id A0F84C23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 17:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wNAwaOXFkNqD for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 11:42:06 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 70B4FB15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 11:42:06 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id d20so7482895iom.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8QjjT23wv/He9U30eaP5xrnf114GfLg4s3GO8+mU3xs=;
        b=e5MakDuY20+UCt5z30utVEceDvdHABm+onyTnmFo+sRgNGdAvO4LSL0AvcebIOpmfE
         4EM/eUvpSHKexzBRKgYkwvNr2VYR5Fl1ZDQZY/pCYZWKgSRH9eyLn+pszRgcRiVIo2JN
         4D0/pvBAm9YEJQ/gfcxMfGDMr66fzk5RK2yPUGKzq5k/abXavJXUvnM9WUsaCGnMpR+o
         AvlqIjMKCK6sbL8ZdKL3DDS0uOMVNWIHUrZevlg2TM1b5qQ/e/VdURVbmnJE42Kd5fMO
         0k2KB7f22QdDzuhzZofOqN77kRfxBUTixDMawU4TpoYj69QZhgDWDBNdECEp4yP7w8Wa
         sISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8QjjT23wv/He9U30eaP5xrnf114GfLg4s3GO8+mU3xs=;
        b=DGRMT6C8sFKSRjXKHK9JfPz6embGSz/rB00Hv810g1/IirqxVz68n1uwZLyghQyzpb
         HAOA3cW+EbEFe+1+yZl53S8fRK8r0pjzmjb9RcS4W3UBHeUFIvDSGHWuHL7ok2FZkYEt
         RNIyNWp5Vl/6kP5UNj6V7hhFpXdocykEIK5iZzZHdyZBUZaqEbfTH7++k5wgKGnyohmC
         Lne96BKvY2W/wFUxcLIxAraFAOlqTtLhic3VG9q8DC1QISgf6kVsbnvyNo8H2K3deyZn
         aUcfnlPUFp5SEF07HOc5W+e6rV8nZx7quQ/yiED6Dlt0Ew2xv6Wu6Gl5OwVhMYbNGWya
         ohzw==
X-Gm-Message-State: AA+aEWYGwmNXrdyVNDZnoQd1O84RFN8bq2vRKaZ2b8kY+5CknELT93mI
        VtgNA0WQA3L8JusmmL1iHWX7kfWYE30WZQLIQE/y6t60N2pMMCShfce9AYl3DeLeBxxoMmwE+c6
        9cRNcDfolqEBNEYr/i3ghgewn+dOZ
X-Received: by 2002:a02:8c4a:: with SMTP id j10mr9146932jal.129.1545673326063;
        Mon, 24 Dec 2018 09:42:06 -0800 (PST)
X-Google-Smtp-Source: AFSGD/U+ZLR3n2/tCBlAOfS1FTWPmfYDJlrdcTU/ZiwiVtX8pRXC/Jt/2R0MNMdY7Ne/Tt9x7nwTLg==
X-Received: by 2002:a02:8c4a:: with SMTP id j10mr9146923jal.129.1545673325851;
        Mon, 24 Dec 2018 09:42:05 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id j129sm10902936itb.41.2018.12.24.09.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 09:42:05 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma/mv_xor: Fix a missing check in mv_xor_channel_add
Date:   Mon, 24 Dec 2018 11:41:54 -0600
Message-Id: <20181224174154.19904-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_async_device_register() may fail and return an error. The capabilities
checked in mv_xor_channel_add() are not complete. The fix handles the
error by freeing the resources.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/dma/mv_xor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7f595355fb79..e733c5eeaabc 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1153,7 +1153,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		 dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
 		 dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
 
-	dma_async_device_register(dma_dev);
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto err_free_irq;
+
 	return mv_chan;
 
 err_free_irq:
-- 
2.17.1

