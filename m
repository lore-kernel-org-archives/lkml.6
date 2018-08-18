Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37695C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C3921788
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouWlUdJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C3921788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeHRTD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40672 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeHRTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so6113064edq.7;
        Sat, 18 Aug 2018 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1MAWcfVfJUFZrQlUo3pk0BirfPzXjLJCuoxdU02t/wQ=;
        b=ouWlUdJAjnIpRrGoBYl5qIDeXuv6luhoXUMCscXEQM1ekQ8EZNctwPeM+MZWPXn1Gf
         cwlpIZelegvwRQK7l+9hsJ8bJswIeN0YMaQj4IoDIH7Eil/qi5xH3AIi09J/SkT/MR+F
         ouedy3PH7Xaw+i1X/9Xy1bogXmMORfttQ95zXjBIy/nymmKNddU5/a8eMCMofwpcZT8w
         XT+4CaKaAWFcU8Plt+AXLKr76yfCB2buIoFUQTUD9yppckFv+iXPM9tMmpWm8n45JrL7
         4GbCu+6jz3sMNchtP36vxI0cF6cTVKQON+rHTFsTrAG5TWzO7pIFATZJ3jKLXFRbRPrw
         fdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1MAWcfVfJUFZrQlUo3pk0BirfPzXjLJCuoxdU02t/wQ=;
        b=U0NnEK5Fkom72hV9wmcmiPxzxRF2hdLkFyR9S8hw/dkqDgVd/MF3Tjj0b1kbtyOVxh
         b8FMhWXnbDRKLKVL0PHQG18cIPzfaqQ6Nih/pr3ttaOAukWW3I69+mOT6QtOQiypcex1
         ZOGBhFNHsVEiQ3vlQ7MKbuQcfpF1E95YajYVduoPx+E18f62p+0vd3t5mBmAofrZmqdo
         2nMq42ktEcDmMBrDFKIQJA5bxcAHO1KZcPH0d5x8WJ82NKAJH8wYavLzo8mNZuGNu6Kw
         8QSW7Q0ZIAfOYYDL2YqNBZd/peWcKz0m8qDSRg3HB7yrtgz3hYPHhtiuioMEpbYEWb2A
         uZGQ==
X-Gm-Message-State: AOUpUlHAr4uj2fgAnaXhauLZzE9D2ub8CqMdLG6OM5wwsewsKS90YYRk
        Plvz168Mt13cdsC4tD4b4nI=
X-Google-Smtp-Source: AA+uWPzA9V1jj27vW3mxnVt/TUrGWcPgUdzL0oU1bRSE0eK50gfS+HqHq2Dl9htt7VVyeNP/e8Ftfg==
X-Received: by 2002:aa7:c910:: with SMTP id b16-v6mr49130020edt.22.1534607747881;
        Sat, 18 Aug 2018 08:55:47 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/19] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date:   Sat, 18 Aug 2018 18:54:20 +0300
Message-Id: <20180818155430.5586-10-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra20-mc DT binding has been changed, GART has been squashed
into Memory Controller and now the clock property is mandatory for
Tegra20. Adapt driver the to DT changes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 19 +++++++------------
 drivers/memory/tegra/mc.h |  6 ------
 include/soc/tegra/mc.h    |  2 +-
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e56862495f36..3bf3138769f4 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -638,24 +638,19 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
+	mc->clk = devm_clk_get(&pdev->dev, "mc");
+	if (IS_ERR(mc->clk)) {
+		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
+			PTR_ERR(mc->clk));
+		return PTR_ERR(mc->clk);
+	}
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	if (mc->soc == &tegra20_mc_soc) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		mc->regs2 = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mc->regs2))
-			return PTR_ERR(mc->regs2);
-
 		isr = tegra20_mc_irq;
 	} else
 #endif
 	{
-		mc->clk = devm_clk_get(&pdev->dev, "mc");
-		if (IS_ERR(mc->clk)) {
-			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
-				PTR_ERR(mc->clk));
-			return PTR_ERR(mc->clk);
-		}
-
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 01065f12ebeb..9856f085e487 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -26,18 +26,12 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
-	if (mc->regs2 && offset >= 0x24)
-		return readl(mc->regs2 + offset - 0x3c);
-
 	return readl(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
-	if (mc->regs2 && offset >= 0x24)
-		return writel(value, mc->regs2 + offset - 0x3c);
-
 	writel(value, mc->regs + offset);
 }
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index b43f37fea096..db5bfdf589b4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -144,7 +144,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
-	void __iomem *regs, *regs2;
+	void __iomem *regs;
 	struct clk *clk;
 	int irq;
 
-- 
2.18.0

