Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A3DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE93E2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwdFZiuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE93E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeLLUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38846 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLLUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so9438868pfi.5;
        Wed, 12 Dec 2018 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzJ2UJcv0IijldET0TY8b0MrUWAwCpAgCdaywzTWseI=;
        b=pwdFZiuWIZ1MXZY0988tnB23jPnPkyVrQb1lDChIDFUAQ6Fp2DjIRe2xc+fETMmuXV
         6xFIKci8lGm+3m2ySaNg4G/lEmLB7t6WODZNRwUTqyDepDTwrEYfaBRAOO9sCezeunik
         7z9zurFp6z8zB762CGztQcEOsIWFhPsFdkndgqG24own2ONsZG9PsSMfqQ3cQ7exLxBN
         +uyU22OzsjJqHiB2xu9dDbB4iz5g5I5f2Sapj4NloHvGfsYZCqJcSBZH4nmJb/2Zp+S9
         d4hR47vZPw2EbT1TCifEZRuVwpyDRmqR+jAr3TMOO1iIXtvy5uSvMzOTLfyP7rNHChR7
         rLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzJ2UJcv0IijldET0TY8b0MrUWAwCpAgCdaywzTWseI=;
        b=VpgRMaFqZTJ3VOJ5P6qXrnL3XcUOiiM915NysWcGklglO7wKFk9SuGk2595aebxfnG
         iHThQsWB1XJ9KrRR8AGkLu5Mu5bvR9VCip1e+8JEUaQpJgEjWXGhevifk/URBfxcjrjl
         h8gaGflntnUX3RChkoBkYBPmN1Lj4PIVCkK51dvCPszS8jP+w4j/8kFBuqBguRl5r4mv
         GA5UX/sUOnuLZzEVHZAjglE66GWPCNpHUlouxCrrqCCjI+e7TOnbz18bVfjBdv9XBqoq
         V2nrMVjB+KfxDuE2ue463QxJKLJeJeil5tkinZ3pclUrqd9AdFmWtqSu/quGrmGWToLZ
         34xA==
X-Gm-Message-State: AA+aEWZiPLPkpDkbB95z9o2TMZzDImTM37k69XZU2oSGd31yHK9IgNy8
        tMrlp61fhxDznWMhloqpNo4=
X-Google-Smtp-Source: AFSGD/Vs0pcO5uQEfs3Pq+La8WohBZQKN/10LscKS+7S3pxW6hazjzOWG3Aw2UzdIv/JUaX788p2iw==
X-Received: by 2002:a62:938f:: with SMTP id r15mr21453642pfk.27.1544647987548;
        Wed, 12 Dec 2018 12:53:07 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/24] memory: tegra: Use of_device_get_match_data()
Date:   Wed, 12 Dec 2018 23:38:54 +0300
Message-Id: <20181212203907.23461-12-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to match device with the DT node since it was already
matched, use of_device_get_match_data() helper to get the match-data.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ce8cf81b55d7..55ecfb2d8cfd 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -619,23 +620,18 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 
 static int tegra_mc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct resource *res;
 	struct tegra_mc *mc;
 	void *isr;
 	int err;
 
-	match = of_match_node(tegra_mc_of_match, pdev->dev.of_node);
-	if (!match)
-		return -ENODEV;
-
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mc);
 	spin_lock_init(&mc->lock);
-	mc->soc = match->data;
+	mc->soc = of_device_get_match_data(&pdev->dev);
 	mc->dev = &pdev->dev;
 
 	/* length of MC tick in nanoseconds */
-- 
2.20.0

