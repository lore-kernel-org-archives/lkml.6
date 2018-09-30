Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84EC64EB5
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60181206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmKLeeyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60181206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeJAFXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43899 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJAFXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so10355153ljc.10;
        Sun, 30 Sep 2018 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2m75vP+vhO9R4rPd3Yk3+I0Wa14hKEFn6WSeRYz02s=;
        b=DmKLeeyycrzy/XxaaiFE7lOj6uWrRNkXXBdbFydNjnxxkZ686/odiq67joUUly52hK
         aTlcEUyO7OFneQU2Od3Clu82ixKJnFkLvO4SDensuauoZlGk1wvkITtEHkxBcN4RIHoJ
         gEqzkufCx5U9TtTiFMEE2JgIKkaNKRSWtcdpl69bpGR3CEu5uPh4kULHAwnDWPdi/RP1
         grYGefmScTgfk8EBFL9lo2OKD2DM65DTuTycNUbaDLdrJzoReVWBRK6ABT/A+Q0FSeM6
         FcV1kE+B0AI2/ArHKUwYVdOpB7soIS+gl3HuDJva6kvI7eas9AjppMUGVi0HEZBGcBrx
         rfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2m75vP+vhO9R4rPd3Yk3+I0Wa14hKEFn6WSeRYz02s=;
        b=dax9S2dzfLaXaB6WtDhxuBGsxACHy3u1gc0xvbYe1kcVGJp/s2BfnEIm/AImRa2Nbx
         SuaVN3YSaQGpX+q1Bk3wV5POCcMKA+b5lTq1/Eo18hUa4IwJ60s5rbi6AJmmvS2JXpQO
         mi6lR2kXBwwM4SiijLi1kThAhWj6jwQs7PgGaKEk8fWvnqi5pdv5NB66wciFXdC7LEmb
         hfo27ZGZuHN6hV17zbX+YJ0j7ydT6s9N7acM0e0TFPgo2IiebJEtMQXIwf5TLEOZdnHo
         CtgxEcVvfPGKzT0QG1Cb4v3QLDMSYufpqrgwcCB7KCIEJWJhV4+7lTngmzlr78dwuARy
         D2aw==
X-Gm-Message-State: ABuFfogdXe8KQTyDjb3SsnmgFfPWz2ZJ8DxJfuRobNob60F5IvPlPTuz
        dLOBNf3kst9pqt/pbVke4Jc=
X-Google-Smtp-Source: ACcGV61/kbMQ9h/LkkWOl5SVOdF5wAWcMMh+NWvhmsfd6u4JA9gb8LKsz2mMbxuwOd7zMe1T5QYzAg==
X-Received: by 2002:a2e:47:: with SMTP id 68-v6mr5006247lja.123.1538347742551;
        Sun, 30 Sep 2018 15:49:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/21] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date:   Mon,  1 Oct 2018 01:48:21 +0300
Message-Id: <20180930224833.28809-10-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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

