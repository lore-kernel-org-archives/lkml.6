Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F9A21527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLsjMr1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F9A21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeKVB3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33839 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbeKVB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so5139342ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2EwwsLBwBer8z1z07IXta+Tj2VvEVIyAWVTe+k8hyU=;
        b=cLsjMr1Q/kSvxNrxhE9FmIoaUyBOLq8eWEPJ97xlPViDY1dHYTAQTh7Zk4kM5wTRT3
         moc28pg0FrMxIC+/tgwRHpgbAhynlRVvgojGH7trWbxlYoesCZ/TVndNwWz1tpVxXiTg
         6oI2e4kVfElWZ4PGbI/oKSD6moNWa9Q5Ukg/P0Q6efd+JtvqLqMplcki5S9IcGnLN+fM
         m0p1h/bsF2v2ecihYnSptEH4pf97s3Q5Vp+xQWioxC00jXm+g+mV7tB/SeESXHOv+5A3
         0puFRGqnJyQRbx8ORo4E6XYRmLc7XXRTBgodJ8vVncsocs5XjEyo2G8BNy9+t7ZeMQHV
         rtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2EwwsLBwBer8z1z07IXta+Tj2VvEVIyAWVTe+k8hyU=;
        b=YRo4toHMXzUtRrncfjajOy3khcJmvVbnZt7MZbVNd0RCL8X3w2l2vzFctnxn/BsHKd
         jY8cuvsiC1tmM30bRRYY7Ur5o/HyVn/Mx8kdDsWNxHsHMrBLAn4Mejy8QsbAev0XsOar
         lRVtXevNKoEMXwMmJ7GbUaU0k4Na4c4fpbM8uZa1pLyIPoCqY1vHw1aQ0ubhYeENetEw
         DhuKf/2F3so1kV2adh4yfZN38xqnMj0SYkluCPKlBSNpgWZUYg+S10l/jDZTC/Kbz0Hc
         3pH+BRUmF6b/oyW0nSjgW2yL2x3snbmQ6P1WctBf+a4QyUHHIxod4q3dSh2SI+7LC2nJ
         nTow==
X-Gm-Message-State: AGRZ1gKH0UMYUjL/ZZyuUS9SebKUPPeeb/MkdVSU8hyp5Esb05TCI47+
        8/puEMHWN1sNDhMxd0mIM/t4mfOg
X-Google-Smtp-Source: AJdET5f6fp+3xcyka6YaHMsTFetB6QWpP8FDPx3M0BIJl5Eps9USr2tnHsi2WXRDJOIyWFkHcMzSnw==
X-Received: by 2002:a17:906:3603:: with SMTP id q3-v6mr5374528ejb.164.1542812090459;
        Wed, 21 Nov 2018 06:54:50 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id k31sm12295989ede.5.2018.11.21.06.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:49 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] mailbox: mtk-cmdq: Remove needless devm_kfree() calls
Date:   Wed, 21 Nov 2018 15:54:23 +0100
Message-Id: <20181121145429.7582-14-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Memory allocated through device-managed functions doesn't need to be
explicitly freed, so these calls can be removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d9c3ec3667a8..22811784dc7d 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -339,14 +339,6 @@ static int cmdq_remove(struct platform_device *pdev)
 
 	clk_unprepare(cmdq->clock);
 
-	if (cmdq->mbox.chans)
-		devm_kfree(&pdev->dev, cmdq->mbox.chans);
-
-	if (cmdq->thread)
-		devm_kfree(&pdev->dev, cmdq->thread);
-
-	devm_kfree(&pdev->dev, cmdq);
-
 	return 0;
 }
 
-- 
2.19.1

