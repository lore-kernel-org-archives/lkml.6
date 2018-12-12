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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3970C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8278E2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpNTgT+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8278E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeLLUw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41346 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLLUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so8884520pgh.8;
        Wed, 12 Dec 2018 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggBfXP6l/+oP1F4ldRTa0ftP5Vt/IYY0ozY6n85+iyU=;
        b=rpNTgT+NQyXqIWwz22oROpL3JLgvy9BKEupuosVRTfj/NlnsJB8xOPlKbDc3vAOy1N
         5/r8FmfcJHw6yZ4nQLKhtX2UPvmCAZozBNOod/JsDbqGP9HbchJLz9gUkrDFrX1X7bWF
         fWWOZ8BOKhhsm+ZXIN6XCLjIqKk+NgfOBc8V1hHDaOINTolKCj2RTGlEBo+TrGvqL1cg
         5LDP/dMH8+N7JwGj6a5hrI3IsK7gSmH+twhqRAYSVDraZ4/Tf2NPMJS6+uoVUNy69eWt
         89HqEOV+KKIW1SS7hygBorvMVYjJ9gSN/b5nEzxptfeLdpPSDJaEie8xbQcVgynaWGtV
         HOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggBfXP6l/+oP1F4ldRTa0ftP5Vt/IYY0ozY6n85+iyU=;
        b=stttoLPSFIitrX74KY57JK3IzvpvQv2cfWeb0R7WxczXkzZdRS/PfyRjXc0e0aTGew
         wUCrIFE9xuWOECdn9yXTqlrvuvPQVfzW7H1SQfyT3JDtZ8oi0qD4PWTI8I2lCM67IRPo
         4ojKCd/z8wcv3gzYTmDr5tAxqZDoLQMBaISy+vDMUQG+HCR5imJr8JLrp1r9fAoorqfa
         xGvQtzEYxED/UuDYexdpG+l6Est1w40s4u7fTfuful9uQgFz1/lxhsZ11BWfAZ4YIaSP
         FwW6pOvm9ym/bh9brAM52YnLc2QFLBp/UlYvhFwT/ajLIE9opHFojuKcrX40fz7DDzyJ
         7gfQ==
X-Gm-Message-State: AA+aEWbBbykihDExkGImzqCLbjHlgPwa61m89qLy4T7h8YzG+7ahliN5
        DfiYJXSAfWLfVS5dPWer/F8=
X-Google-Smtp-Source: AFSGD/VzKpAO++Ma3czxRvbNiHQQ8r++yIiBIo5InVyA5jbS1ku3/nX8VLEnPISnwWJz5hVQxDvwhg==
X-Received: by 2002:a65:49cd:: with SMTP id t13mr19824703pgs.376.1544647975017;
        Wed, 12 Dec 2018 12:52:55 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/24] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date:   Wed, 12 Dec 2018 23:38:52 +0300
Message-Id: <20181212203907.23461-10-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c | 21 ++++++++-------------
 drivers/memory/tegra/mc.h |  6 ------
 include/soc/tegra/mc.h    |  2 +-
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index b99f3c620f6c..59db13287b47 100644
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
2.20.0

