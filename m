Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6700C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F121477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0K+2WCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5F121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeIXGq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47018 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeIXGq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id v19-v6so671797ply.13;
        Sun, 23 Sep 2018 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2m75vP+vhO9R4rPd3Yk3+I0Wa14hKEFn6WSeRYz02s=;
        b=N0K+2WCe4CrfLi9FisR6f4c4hTp52HW5HGJYGJJD8roOZLd7l3wx0LcyJp+Ks4jFd8
         k0DqhamiCG6HqIGzW2WJSGZcLjiXuU6MUJMvZe9BIACn95mhOKpuyuB+RjXAN60p+7Ce
         vbeftHlAVlNhPHZflAG3S+xjCQddtCSm8HlVQ+WrAOXZdB4cQ7LEvt8LWUt0aInTcT4L
         rG7hpADppOnPxArSIC6pibykyDllaFO2BoAn/qBkn5Bjmj8EWLEaM4EkpNHN1hOdtEgU
         p/HQ/8mraNr4ob1l5vnbMx6K7mw8ZUXs2dM0AZ4NUE+bFE7CV56vYTbR8R2gCR6cpEPZ
         OnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2m75vP+vhO9R4rPd3Yk3+I0Wa14hKEFn6WSeRYz02s=;
        b=qs0wyeNTTcS/kJ8zC/CpbI+47ggCSyK+VdNF022Ak1KePgyhgrB1sojQnbf9iDpH8X
         3/CWnRpDVk6Devowidwv2jLg5n3yeqszo/u4SiwWSV1++k1NdA5YEAuHNiXU10VPjhjY
         ImrVVczIMOQc/9taiZasSSWiF5ENZxTSGX3Ma2gqrnpwy1EVf/8iRTjleN4U0LChBL+W
         U7f3nhUMO3CtXRyjwlY2S0y8hDsrVkjWF6TRLFQfZdtEBvqwgUt2vfc4IZYcrz4XR0S2
         8sztC1iKoG/W7Nmz6bNB4Hy5osVe1n7xjmRHmcJm3cvyJJyCPwmnqckK68OuCSCV3Qa2
         KLrA==
X-Gm-Message-State: ABuFfohRXVqcCMmP2dNmCx5PMSFj6jsjLuBl3SyZR064VvsmNu2Gmm7n
        Cb8Rd9vOLHZEiI6WDNvTtqQ=
X-Google-Smtp-Source: ACcGV63ZZqh2K8szyNPvFRWHz7tGVXlW5Ljgz/khYbm4n1rRCu3VqOsNtNZrOESZhE1GKnYZhtVkzg==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7-v6mr8312981pll.113.1537750011009;
        Sun, 23 Sep 2018 17:46:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/20] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date:   Mon, 24 Sep 2018 03:41:42 +0300
Message-Id: <20180924004153.8232-10-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra20-mc device-tree binding has been changed, GART has been
squashed into Memory Controller and now the clock property is mandatory
for Tegra20, the DT compatible has been changed as well. Adapt driver to
the DT changes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 21 ++++++++-------------
 drivers/memory/tegra/mc.h |  6 ------
 include/soc/tegra/mc.h    |  2 +-
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e56862495f36..1b4ceefd82f9 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -51,7 +51,7 @@
 
 static const struct of_device_id tegra_mc_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
+	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	{ .compatible = "nvidia,tegra30-mc", .data = &tegra30_mc_soc },
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
2.19.0

