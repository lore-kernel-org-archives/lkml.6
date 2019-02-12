Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE51C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED712222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="Oa4Y5ebK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfBLVqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:46:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56192 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBLVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:46:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so215978wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hGQFyApiJOx4wOZwH/AKFByNuGb0n4xpe2975ACzvkI=;
        b=Oa4Y5ebKEoFcqrglFY4/g0w+659gVLad0Qkt9rgd8pKRTOZ9Ap2gVuBILaAkXczh3K
         +dtB1nhAznJfNO7o1RdjmS4btKQXHgo6aSf068svtNNDWiSffEiP1nK2rB47rCxHvobr
         R/t2Rcr8uNDV+qtO9ExGGVhjDnYTF33OXJGpS7B15pUOinyLEJHWeFACdY/4UE7h8mPD
         FjvdgBJFP7ezqUQXQ7/GmqXi2mCJhU0BSYbXPChA8tzEw6+7oP6zH+libxJt/CtJSXCQ
         sHN/Q7wKt00L3xXyWFSql6wHm6evMDgb7slktrNEw9jhfCVle5TXpXlmOQC12LyRC8n+
         lmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hGQFyApiJOx4wOZwH/AKFByNuGb0n4xpe2975ACzvkI=;
        b=hTY/bNqyQJEQyviRQA7XfGMt0ugMjuj3SdwzL7fBxjBml7JuxxQeIhneXH8FIv0Ylv
         8Kk8zmTNjC95iblEmr2q/mS2pR0x/k+EyU2hMo5V2oMYG4n2zx885DNTXIroS1jgTr6k
         L+kpXHMxpAfx9LI8SXmbbAPMKBo5gRxBv/hLeEfYn5lfmU19MvMq13LIRjRq8/JcMFfH
         bROF47CPARg7LAHaJY5FRguo4z39c2RRPorC2WmftvcC8MWyr3/fzR+OTHpFoxGMvBEh
         VeT8/HKxTnaAuuT2j2CRVm25wuUNBZZW0BCskpyJp6tZjpXEXHjRMhaoDV3EeOTsUVGo
         IE4A==
X-Gm-Message-State: AHQUAubTUPVpUII5a7WpFICfVABlXlOZ9VTxi8bLOFXX5yh2BfFRCUy0
        3Ep4hJ4lfeKzSnf2DQKo2NLJfA==
X-Google-Smtp-Source: AHgI3IaqcTOlAWLL/3ycfOEwzQHdfRrrkdzVUtmzRlt0W1SbO2zMh90OlbG4/xXm5m1axi5+KRLSWg==
X-Received: by 2002:a1c:d147:: with SMTP id i68mr727700wmg.41.1550008010998;
        Tue, 12 Feb 2019 13:46:50 -0800 (PST)
Received: from localhost.localdomain (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id q24sm3685753wmq.16.2019.02.12.13.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 13:46:49 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH v2] mfd: sec: Add support for the RTC on S2MPA01
Date:   Tue, 12 Feb 2019 21:46:39 +0000
Message-Id: <20190212214639.9613-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC portion of the S2MPA01 appears to have the same
register layout as the S2MPS14.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/mfd/sec-core.c | 2 ++
 drivers/mfd/sec-irq.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index e0835c9df7a1..08621ef5d822 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -103,6 +103,8 @@ static const struct mfd_cell s2mps15_devs[] = {
 static const struct mfd_cell s2mpa01_devs[] = {
 	{
 		.name = "s2mpa01-pmic",
+	}, {
+		.name = "s2mps14-rtc",
 	},
 };
 
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index ad0099077e7e..a98c5d165039 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -455,6 +455,9 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 	case S5M8767X:
 		sec_irq_chip = &s5m8767_irq_chip;
 		break;
+	case S2MPA01:
+		sec_irq_chip = &s2mps14_irq_chip;
+		break;
 	case S2MPS11X:
 		sec_irq_chip = &s2mps11_irq_chip;
 		break;
-- 
2.13.6

