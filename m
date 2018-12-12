Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246EC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E99B2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8UlK5qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E99B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeLLUx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38403 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeLLUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so8894209pgc.5;
        Wed, 12 Dec 2018 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BswpiJIyXYCwIJYSExUCFoa3NjAwWquTTA/r0TBkUb8=;
        b=V8UlK5qPGIR9B1+BVZ2tdP1Q1DKqmRhq7y8yzoINTF83u9MqgyAUEO9T5KzNArzxW7
         0gYOYjC0Ek8wUIoSuxI9f/H2eXR+elh0WvUjSwyq7toHHYRD2+umGUMMfcX1mZBbkD0x
         wFOr3jFGtDlKPhqMKGzqEWNppcW0Cd4OsWyXdbqJHeY+UNwv3mo7+mcpOLN3MgnpoKjJ
         7wPDF1N39YkI0WoZaTkfP4Z7TtAD5EYtF3/cjYpsPbxWgk7Ucgl6MX8AtT5eTNeoFr7H
         mJM/6htgcyWdlVO3BGjGwAjl5hH7cnLt9VQiQzhc9mC32eYLOeRYIPNARM/H4vImNBdn
         aEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BswpiJIyXYCwIJYSExUCFoa3NjAwWquTTA/r0TBkUb8=;
        b=NnKBDTuJk2Cg7xbHgoTBeImc2ZVkultPt0fbceUkEz8ECVCQHUfwhRhj+Pb1uzdpal
         qO1yMGlb+2YqTUMsVB5PWRnXHcZ05tXAGe8+fPc/Ehh7FGq1fOkrytzf6+Auvwhi4Wsd
         z/aSTUUK4SZxK11RJXCLCvBoRGJg6rriCWgbpmcQts7wKO1wFr8Jirj639UrqiDD30ms
         vHMKAoyov7grpLoPVTIa0krbKzXY1p4uy9TphX6Ev/Q3O6ksfKb7tAe3fvNe3kIAuTfh
         GPnJAz2FFQzOg47PLazY7w2zMIxCyprhXu6YMRv5jsTet0xirlFVP6xmzop2ylijLoAy
         buWg==
X-Gm-Message-State: AA+aEWbkZBKe5EohjHDuDTdHt80bnwOKCLVHDuUhA6I5sx5m0TgVbpyP
        M6gm1ZwxBVEWOifY9BdZ/jOU31Hm
X-Google-Smtp-Source: AFSGD/V380Pkd448YVbrBCv3pPw7+vpOrVKBaj/cNNSqiAYckPEYC+iA7HPXQfT/e0MuzJIVpPs5Ng==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr18989426pgc.15.1544648006717;
        Wed, 12 Dec 2018 12:53:26 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/24] memory: tegra: Do not try to probe SMMU on Tegra20
Date:   Wed, 12 Dec 2018 23:38:57 +0300
Message-Id: <20181212203907.23461-15-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 doesn't have SMMU. Move out checking of the SMMU presence from
the SMMU driver into the Memory Controller driver. This change makes code
consistent in regards to how GART/SMMU presence checking is performed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 4 ----
 drivers/memory/tegra/mc.c  | 6 ++++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 97b3c0461831..32ea81e9f012 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -982,10 +982,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	u32 value;
 	int err;
 
-	/* This can happen on Tegra20 which doesn't have an SMMU */
-	if (!soc)
-		return NULL;
-
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e684e234361a..3545868c51c0 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -695,11 +695,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
 			err);
 
-	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) && mc->soc->smmu) {
 		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
-		if (IS_ERR(mc->smmu))
+		if (IS_ERR(mc->smmu)) {
 			dev_err(&pdev->dev, "failed to probe SMMU: %ld\n",
 				PTR_ERR(mc->smmu));
+			mc->smmu = NULL;
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && !mc->soc->smmu) {
-- 
2.20.0

