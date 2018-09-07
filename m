Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35907C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCB20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYsOIGq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FCB20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeIHLWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 07:22:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40333 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 07:22:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so8002157pga.7;
        Fri, 07 Sep 2018 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C5SdN+OjFt2ji9pDfHLvVliUhy/o+6TROPtuwJ0hyZA=;
        b=EYsOIGq0WqlAM22SeWH5M7QE5W3kaK3GJuc6i8Ab8aBNuz9aSYObcNvfr1Mam/qqau
         jVlMX9aPh5R2H8c+BiF4JoIXx7cv1ufHUF3GpfiS5Hnm1DUrff6gYFndpJ/0brVFM2/w
         uy0GNqsU9iB170f78CLbFwl2KDthThp8gyiJrQWYiBA2Q64CEdFSFxHc5hD+kkzP5OrX
         qmnPnVXb+AkjGN2XTurXw65C3xfU+Tha/QzBSyjJP1r23QAeen+BWj3mIEWgfEbkDMz2
         Uxw2I5IaKTZl6yyQCc0bb6FkQkzS8zdcemLD7DKXL8KUvnsqOYHstZUkOWXMnBW2j6Nl
         btbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C5SdN+OjFt2ji9pDfHLvVliUhy/o+6TROPtuwJ0hyZA=;
        b=VqsDD1KHrUZufp2DsV41OQ2zPT9HlanRBFoSRQopZ9mEcjUk94WLqtZ3YVkABk+4F8
         ZqTpkH9zxQ0EK2djqX18kzWJuCWE30B36lGA1DAngqFh50mDWGub32MLuh6x35sAN7Jv
         ZoWTVaxFilMydfxasDPcUBWH1V4v+C9a2r95ci6QR1fZqlEYDrUwSiRTh+DDwsLNNb12
         PlEzDLay+TiXUX2vsCpZxKXWrmBkJImUf2Sv5EreielOpOMBYvjqCh25R13ANj+NkAAb
         fXo+fzu5vcYyVhfcYQwhNgMCWvCKyDzm9qxX5UHzm0YQCeEyJFOS55RnVG03qIXhXqgo
         swGQ==
X-Gm-Message-State: APzg51AGeVNMBConKuclGe61EErgKAabpdGj0YaSZDAB2dV3M/3grWzO
        h/5zBNbyw5SdMTlHO7Z7EFI=
X-Google-Smtp-Source: ANB0VdYHsF+LMff+LwyGV38thrHx0nlkj/uJbnvXsXzwHRaTJSIrwhSuIAtaHiTpjAhe2OV55HQBMg==
X-Received: by 2002:a62:83ca:: with SMTP id h193-v6mr12417607pfe.123.1536388674601;
        Fri, 07 Sep 2018 23:37:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:2a51:f4a:7c2c:f4b6:91c4:bb76])
        by smtp.gmail.com with ESMTPSA id g7-v6sm12199975pfi.175.2018.09.07.23.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 23:37:53 -0700 (PDT)
From:   Zhaoxiong Yuan <yuanzhx326@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhaoxiong Yuan <yuanzhx326@gmail.com>
Subject: [PATCH] dma: idma64: replace spin_lock_irqsave with spin_lock
Date:   Sat,  8 Sep 2018 06:02:10 +1100
Message-Id: <1536346930-6842-1-git-send-email-yuanzhx326@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idma64_chan_irq() is invoked in hardirq handle function, it is unnecessary 
to call spin_lock_irqsave.
Signed-off-by: Zhaoxiong Yuan <yuanzhx326@gmail.com>
---
 drivers/dma/idma64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 1fbf9cb..5b9c156 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -142,9 +142,8 @@ static void idma64_chan_irq(struct idma64 *idma64, unsigned short c,
 {
 	struct idma64_chan *idma64c = &idma64->chan[c];
 	struct idma64_desc *desc;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idma64c->vchan.lock, flags);
+	spin_lock(&idma64c->vchan.lock);
 	desc = idma64c->desc;
 	if (desc) {
 		if (status_err & (1 << c)) {
@@ -161,7 +160,7 @@ static void idma64_chan_irq(struct idma64 *idma64, unsigned short c,
 		if (idma64c->desc == NULL || desc->status == DMA_ERROR)
 			idma64_stop_transfer(idma64c);
 	}
-	spin_unlock_irqrestore(&idma64c->vchan.lock, flags);
+	spin_unlock(&idma64c->vchan.lock);
 }
 
 static irqreturn_t idma64_irq(int irq, void *dev)
-- 
1.9.1

