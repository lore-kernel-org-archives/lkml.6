Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ABCECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk6IfjVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E44C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbeIUQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50825 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so2523108wmc.0;
        Fri, 21 Sep 2018 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmRuSD8EMihenFkLdU/jKTXF74csBfSkzLsp6aRLNdw=;
        b=kk6IfjVZl2lGG5hDD3r2ISCb72ubwB1aR4N/g3XOPC8qwwKWGv7tGyZyfnP96E27qj
         fGqYMYyRCoMKLgrOg9bLhtYg+BdR4dYGD6zxffJYFV91VeS8wyIGGrgPvHkBole/0Y5b
         oxz4XY4tZxrwJT6gWVeOqM2tCwqXnTAlp//Jo3f2R1BCBRR/IVyCgDiw6L6a9Eyk5ktH
         GbSSwRlTEtwrtIj7ctEYbqI0kcosxiVmVRfONSi2dqhnECf5krv9AqN3itEptI/DU+o+
         y2tl95YU8gZqlacsF95Kxq0YNTm1E5WhyOfCrvEluKNpwPdg6I51hxMBYS/q6V3lF6tR
         YZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmRuSD8EMihenFkLdU/jKTXF74csBfSkzLsp6aRLNdw=;
        b=oamH4mWB+Y5BQ5AL49WxasaODBrBZPbFZ4IZ55QC7BqtRM8PeGkyeMt/CNstrcbgsH
         V7jlqkqIUhabBQonGYMKKtl7B7AEajO2Z/i0Ui/V+f8tn75+LXY+Nbb8okUbtwPIT+1L
         EyKrsUAGUXfIDdJkv9uXSd4LTi5jBC85Gjp3Cl8M3S/3rACDS2t6bNe+pa+NHhBRBppi
         AfXptGjYC9wBjlMMI5tpteJtHOcy7aKV2iJlGKsZVdjfzm1YKFxwGR4t4TMeu0eRowqs
         7Xl0EDjoUbfuaUGaKTlm+tvgVifTEna0/1dLHquI31EfNGxjxXk9kFzJslkZiMn7lHF+
         8qEA==
X-Gm-Message-State: APzg51D3yhfn990Q5md8gOmej0bHpGYP8TZUh30mWT65JB+IepkcGN0T
        Oyz1Ybk8+ow/uZJoyxjUVvU=
X-Google-Smtp-Source: ANB0VdYFvFzSfI/FwLZ7Yb64x8VMRjk3xh825kVd0iNUKPAv5FJPDeTUdyExrjLrLCzO4IQQQl/LxA==
X-Received: by 2002:a7b:c248:: with SMTP id b8-v6mr6843361wmj.21.1537525551434;
        Fri, 21 Sep 2018 03:25:51 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id h18-v6sm38600387wru.42.2018.09.21.03.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:50 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] soc/tegra: pmc: Add Tegra194 support
Date:   Fri, 21 Sep 2018 12:25:39 +0200
Message-Id: <20180921102546.12745-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The PMC controller on Tegra194 has a couple of new I/O pads and drops
others compared to Tegra186.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 66 ++++++++++++++++++++++++++++++++++++++++-
 include/soc/tegra/pmc.h | 21 +++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ab719fa90150..c08f0b942020 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2138,8 +2138,72 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
 };
 
+static const struct tegra_io_pad_soc tegra194_io_pads[] = {
+	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CLK_BIAS, .dpd = 4, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CLK3, .dpd = 5, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 7, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_EQOS, .dpd = 8, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CLK2_BIAS, .dpd = 9, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 10, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_DAP3, .dpd = 11, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_DAP5, .dpd = 12, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PWR_CTL, .dpd = 15, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SOC_GPIO53, .dpd = 16, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_GP_PWM2, .dpd = 18, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_GP_PWM3, .dpd = 19, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SOC_GPIO12, .dpd = 20, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SOC_GPIO13, .dpd = 21, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SOC_GPIO10, .dpd = 22, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_UART4, .dpd = 23, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_UART5, .dpd = 24, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_HDMI_DP3, .dpd = 26, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_HDMI_DP2, .dpd = 27, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_HDMI_DP0, .dpd = 28, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_HDMI_DP1, .dpd = 29, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_CTL2, .dpd = 33, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_L0_RST_N, .dpd = 34, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_L1_RST_N, .dpd = 35, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 36, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_PEX_L5_RST_N, .dpd = 37, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 43, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSID, .dpd = 44, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 45, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 46, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SPI, .dpd = 47, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_UFS, .dpd = 49, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSIG, .dpd = 50, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CSIH, .dpd = 51, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_EDP, .dpd = 53, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_CONN, .dpd = 60, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = UINT_MAX },
+};
+
+static const struct tegra_pmc_soc tegra194_pmc_soc = {
+	.num_powergates = 0,
+	.powergates = NULL,
+	.num_cpu_powergates = 0,
+	.cpu_powergates = NULL,
+	.has_tsense_reset = false,
+	.has_gpu_clamps = false,
+	.num_io_pads = ARRAY_SIZE(tegra194_io_pads),
+	.io_pads = tegra194_io_pads,
+	.regs = &tegra186_pmc_regs,
+	.init = NULL,
+	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+};
+
 static const struct of_device_id tegra_pmc_match[] = {
-	{ .compatible = "nvidia,tegra194-pmc", .data = &tegra186_pmc_soc },
+	{ .compatible = "nvidia,tegra194-pmc", .data = &tegra194_pmc_soc },
 	{ .compatible = "nvidia,tegra186-pmc", .data = &tegra186_pmc_soc },
 	{ .compatible = "nvidia,tegra210-pmc", .data = &tegra210_pmc_soc },
 	{ .compatible = "nvidia,tegra132-pmc", .data = &tegra124_pmc_soc },
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 562426812ab2..fd816f6aa9cc 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -90,6 +90,10 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_CSID,
 	TEGRA_IO_PAD_CSIE,
 	TEGRA_IO_PAD_CSIF,
+	TEGRA_IO_PAD_CSIG,
+	TEGRA_IO_PAD_CSIH,
+	TEGRA_IO_PAD_DAP3,
+	TEGRA_IO_PAD_DAP5,
 	TEGRA_IO_PAD_DBG,
 	TEGRA_IO_PAD_DEBUG_NONAO,
 	TEGRA_IO_PAD_DMIC,
@@ -102,10 +106,15 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_EDP,
 	TEGRA_IO_PAD_EMMC,
 	TEGRA_IO_PAD_EMMC2,
+	TEGRA_IO_PAD_EQOS,
 	TEGRA_IO_PAD_GPIO,
+	TEGRA_IO_PAD_GP_PWM2,
+	TEGRA_IO_PAD_GP_PWM3,
 	TEGRA_IO_PAD_HDMI,
 	TEGRA_IO_PAD_HDMI_DP0,
 	TEGRA_IO_PAD_HDMI_DP1,
+	TEGRA_IO_PAD_HDMI_DP2,
+	TEGRA_IO_PAD_HDMI_DP3,
 	TEGRA_IO_PAD_HSIC,
 	TEGRA_IO_PAD_HV,
 	TEGRA_IO_PAD_LVDS,
@@ -115,8 +124,14 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_PEX_CLK_BIAS,
 	TEGRA_IO_PAD_PEX_CLK1,
 	TEGRA_IO_PAD_PEX_CLK2,
+	TEGRA_IO_PAD_PEX_CLK2_BIAS,
 	TEGRA_IO_PAD_PEX_CLK3,
 	TEGRA_IO_PAD_PEX_CNTRL,
+	TEGRA_IO_PAD_PEX_CTL2,
+	TEGRA_IO_PAD_PEX_L0_RST_N,
+	TEGRA_IO_PAD_PEX_L1_RST_N,
+	TEGRA_IO_PAD_PEX_L5_RST_N,
+	TEGRA_IO_PAD_PWR_CTL,
 	TEGRA_IO_PAD_SDMMC1,
 	TEGRA_IO_PAD_SDMMC1_HV,
 	TEGRA_IO_PAD_SDMMC2,
@@ -124,10 +139,16 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_SDMMC3,
 	TEGRA_IO_PAD_SDMMC3_HV,
 	TEGRA_IO_PAD_SDMMC4,
+	TEGRA_IO_PAD_SOC_GPIO10,
+	TEGRA_IO_PAD_SOC_GPIO12,
+	TEGRA_IO_PAD_SOC_GPIO13,
+	TEGRA_IO_PAD_SOC_GPIO53,
 	TEGRA_IO_PAD_SPI,
 	TEGRA_IO_PAD_SPI_HV,
 	TEGRA_IO_PAD_SYS_DDC,
 	TEGRA_IO_PAD_UART,
+	TEGRA_IO_PAD_UART4,
+	TEGRA_IO_PAD_UART5,
 	TEGRA_IO_PAD_UFS,
 	TEGRA_IO_PAD_USB0,
 	TEGRA_IO_PAD_USB1,
-- 
2.19.0

