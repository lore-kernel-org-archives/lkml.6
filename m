Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D54C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876902080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWvYH8K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876902080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeLLUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36440 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeLLUxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so8885712pgm.3;
        Wed, 12 Dec 2018 12:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVwmO7SZrAhknWmyPu5SI5ep1kjQEGZC07hnwWCuuv4=;
        b=lWvYH8K+7wCWACvoPEET68iOMpRIJpbyCErsnsNg3QAm/R4PRrwxisc4xT42VmMNUd
         D/OP6zxKXcWiHA1Gt6rWWaCMR4gk+GYs1iBU7rMklnLvcwXvFyF3/B6MnCxIrdhylthT
         OBCk8NIV+fdAdIn9EzrhtQXgO2PrN8DPK3zg2/r8nJSVo4YacJ3Vj67yYHumkOmBmt33
         HhnbIGB0MLe4l2H2Pc72Zz9oW+FoMCEvapWVz/pss+FAAnkldFqY4vFcwYkoWnGegZ5D
         JmSESP7uqu6uS2EIymwkvRRgSZkFAmOtHViavJ/O/sT43Otu4MSv+4rv/b2JjgJArOet
         lctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVwmO7SZrAhknWmyPu5SI5ep1kjQEGZC07hnwWCuuv4=;
        b=iRSH9QSgDuF9TXrcLg6aM8ptQqOBPLu5u9PlF4NVzzM7U44JxWTy9DyLcyD1yZd/Jq
         1QirCGjELYG+NNfE7kgPLJeeCJy39GdSnrUR3lbeFbk6yPiQgib8OXmy5WT6zPOFovmG
         SduYOs3hHWdB7W/o37Sa5fI7BPijx2KS3RR3l6kqav2qZYZNQrEAiMr9JFGLzejGQYur
         bCblZciusJbFM7JJ/PhBH4kY0lv5j81UrZWA/amzgTnRsSki08M4jWcOJkniElWZSE39
         hjtpq2dC3zyB5AAek017dgkIQ/jtkQ7rCY6i747eZJY0rNEOlnOToJIU7sJgdYD+kbSG
         mLRA==
X-Gm-Message-State: AA+aEWbvnj24o/E3T2EklWi5Uyr8i7dn9Y4w6jyoffwEsV/L+nrDv9/E
        uJlxwSNZuYVIGxMgVP0diG8=
X-Google-Smtp-Source: AFSGD/VfRKcHD2+uU5g37UpRBlVIIVhi9bpTJbCRAYd7HtVaGU3qlN9PCSx+0sFEnUdkVJWw9wyPdg==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr19769127pgd.416.1544648012949;
        Wed, 12 Dec 2018 12:53:32 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 15/24] memory: tegra: Do not ask for IRQ sharing
Date:   Wed, 12 Dec 2018 23:38:58 +0300
Message-Id: <20181212203907.23461-16-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller driver never shared IRQ with any other driver and very
unlikely that it will. Hence there is no need to request IRQ sharing and
the corresponding flag can be dropped safely.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3545868c51c0..570da2129fa6 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -682,7 +682,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 	mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
-	err = devm_request_irq(&pdev->dev, mc->irq, isr, IRQF_SHARED,
+	err = devm_request_irq(&pdev->dev, mc->irq, isr, 0,
 			       dev_name(&pdev->dev), mc);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
-- 
2.20.0

