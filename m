Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2779E2173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3gDNu0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfADKsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:48:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfADKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:47:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so743904wmc.5;
        Fri, 04 Jan 2019 02:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmIKRkHjPNoHY17G01o1jvoarrqTR1poeaUem5PMPwA=;
        b=I3gDNu0J9giu2WdEDLJMwTUUZgvxOh8sHkZ4Sm2u5nB43vJFz80+z9MVSs2mxf2OM7
         rUZzyhif+FhOZMXuqDs453H5hnCw7IBDiQIhTq6213MxrGCzvZl19mtwI0p9B3we8UKJ
         CpVg9rFE6rOQRF2h/M5NmrdoYwVEI4ppzdZFqaoINRdOwCpiS8kWXXWiExv0E+7nMa2O
         biUap0T1GRLJ3+NyI3fQwQZNKuKRUXAG77KLO9FvNZy9zoaFiHcNR2NLBpNa2KMhi/Oe
         LDwB8VycpGuzhTn3NzKjP4eKrTirnWF4Nf1VO4Nqdy3O++lvbz36B+ALwn8qNqqEQewd
         lHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmIKRkHjPNoHY17G01o1jvoarrqTR1poeaUem5PMPwA=;
        b=CJoVNJ/28/1nM3O6KQK0Nc19jkwSKzcncY3o6TZ3wk0P9EqQ4Wd9TsRv1vV57TrL9/
         3y/n8RFlefvTTWrj332WK4EHmLrZ36kbGcKQeAlOvNyB8ctasjbIX1M6irXMqrIB8jhc
         uV7Oy7wc1z1kdVGZ3+Zjd/ohry0YcBy3MvvNs9iFysN7fbm3v6RmKTcfpxaZbs8S690R
         39JOV38u1gSQ3FCjc0xTbNW3CuqUvh3Z7v+afuWthzppOkbftkLGJ8g5FRaNNzvtTJLV
         BaJv8Ca5/CixNT/Y6Xw+e5HsugLjxyqecvBYBgbYtKb8j05nu3dTu10uCV9PrsPv8cbp
         8LxQ==
X-Gm-Message-State: AJcUukcFSvj9vwcqh5FD8FxIoe/4eBiKsUjxpu5dOq1p6DfJ6hWaT+E4
        hRyZ2ea3bIgpzp050YFF+Xg=
X-Google-Smtp-Source: ALg8bN6msobFyqiI06na9J1Rj8PxG5Wq5+FFcA7jE0KazXeewLKWHuj+sSSMBEFlb4fgllqK+TlkwQ==
X-Received: by 2002:a1c:2856:: with SMTP id o83mr1026268wmo.45.1546598876563;
        Fri, 04 Jan 2019 02:47:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c15sm648660wml.27.2019.01.04.02.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 02:47:55 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci: tegra: Set DMA mask depending on generation
Date:   Fri,  4 Jan 2019 11:47:53 +0100
Message-Id: <20190104104753.3383-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190104104753.3383-1-thierry.reding@gmail.com>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The SDHCI controller found in early Tegra SoCs (from Tegra20 through
Tegra114) used an AHB interface to the memory controller, which allowed
only 32 bits of memory to be addressed.

Starting with Tegra124, this limitation was removed by making the SDHCI
controllers native MCCIF clients, which means that they got increased
bandwidth and better arbitration to the memory controller as well as an
address range extended to 40 bits, out of which only 34 were actually
used (bits 34-39 are tied to 0 in the controller).

Starting with Tegra186, all of the 40 bits can be used.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 35 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e6ace31e2a41..c861e0ee7ef2 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -92,6 +93,7 @@
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 nvquirks;
+	u64 dma_mask;
 };
 
 /* Magic pull up and pull down pad calibration offsets */
@@ -862,6 +864,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
@@ -890,6 +893,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
 		    NVQUIRK_HAS_PADCALIB,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
@@ -919,6 +923,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
@@ -928,22 +933,13 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   /*
-		    * The TRM states that the SD/MMC controller found on
-		    * Tegra124 can address 34 bits (the maximum supported by
-		    * the Tegra memory controller), but tests show that DMA
-		    * to or from above 4 GiB doesn't work. This is possibly
-		    * caused by missing programming, though it's not obvious
-		    * what sequence is required. Mark 64-bit DMA broken for
-		    * now to fix this for existing users (e.g. Nyan boards).
-		    */
-		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra114_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 	.pdata = &sdhci_tegra124_pdata,
+	.dma_mask = DMA_BIT_MASK(34),
 };
 
 static const struct sdhci_ops tegra210_sdhci_ops = {
@@ -977,6 +973,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104,
+	.dma_mask = DMA_BIT_MASK(34),
 };
 
 static const struct sdhci_ops tegra186_sdhci_ops = {
@@ -998,15 +995,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   /* SDHCI controllers on Tegra186 support 40-bit addressing.
-		    * IOVA addresses are 48-bit wide on Tegra186.
-		    * With 64-bit dma mask used for SDHCI, accesses can
-		    * be broken. Disable 64-bit dma, which would fall back
-		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
-		    * But it is not supported as of now.
-		    */
-		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra186_sdhci_ops,
 };
 
@@ -1017,6 +1006,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104,
+	.dma_mask = DMA_BIT_MASK(40),
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
@@ -1045,6 +1035,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		return -EINVAL;
 	soc_data = match->data;
 
+	rc = dma_set_mask_and_coherent(&pdev->dev, soc_data->dma_mask);
+	if (rc)
+		dev_warn(&pdev->dev, "failed to set DMA mask %llx: %d\n",
+			 soc_data->dma_mask, rc);
+
 	host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*tegra_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
2.19.1

