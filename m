Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EDECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC7820838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUYUcdi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC7820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeJVCr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44879 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id d23-v6so4581872pls.11;
        Sun, 21 Oct 2018 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEwcLFOAaCqxgb6mEVzp6w7Jf6rGm4wd5jHFaPxWspo=;
        b=vUYUcdi3IAPk/dhZwBQc78hd4su9hOa8HEvFs+Ax7vviVIFymetYZQf1O8Cx8x0Z3S
         j/yBO3Z8ck1ZhkVSNIwBw2K4QtMMjnJh0GKBG2MMTphcZ0KNieHIclwFBD8Hut8LcT9s
         N6Wqn8W1nas9HvHq9f9oKw9BXose4JPS3HPgFxrkHVZ1e9U0Ql0NFlLNMYFIT3I2HzCP
         MLPSrb8ANWfFbgOOVsP2pbVjscTxBjQX0D/fTvNS7TqSDSaQTzNZT0EEiAbdkeBmE5vn
         tUdkJZFewy7bmWX0bPaB/4RHhnBe98TdJuZccRm91aTqvvi838wcEF4HZI/jjJyw5eCj
         7j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEwcLFOAaCqxgb6mEVzp6w7Jf6rGm4wd5jHFaPxWspo=;
        b=Z+yRfYNVyPPdN3g38oSz4K8/ip0GgdMSbireqMU0zO1wRdGN3zRszBSXYKkROPPwoD
         /rIzsLL7jbZ0nx5oQ8WepCrklhtc0w8EUJ3GwCZrHiesvR6VdL9qk+E1iMQXrpUSE/A/
         3hsv9TajmzMz7XYQMb/8MDK5Y+xYpO/XF0LKJ2eQnRtnMb+RC99rUosCxQ49cth3ZRTE
         F14kgyUn4zjh3swZcm+xZuGuB3pSIfnY6BCFU+DsgnMUaXLPkrU3UnoxpUBvarMN0hAd
         bpilPB7JZBcgQZc+D3xfHd28a8+yfcbTdPgPGMslpbjQWKZfruOenbwmM6aotYVncGRz
         xdSQ==
X-Gm-Message-State: ABuFfoj72bCDfAPah+KcRo2gIeB4xBJGmaP6qLR5Nxcc/t+PRrl7IKn3
        G5b7nzOKeHsg6cOZ8qoxm60=
X-Google-Smtp-Source: ACcGV61hLkp0cl4ShqAK9YpdIcMZwP1jdluP2rBE34B1Me95AMjaah9VRk6kxplm/Dz6vpkVyLYdsg==
X-Received: by 2002:a17:902:b403:: with SMTP id x3-v6mr42468206plr.237.1540146734056;
        Sun, 21 Oct 2018 11:32:14 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:32:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Sun, 21 Oct 2018 21:30:50 +0300
Message-Id: <20181021183052.32023-7-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel should never gate the EMC clock as it causes immediate lockup, so
removing clk-gate functionality doesn't affect anything. Turning EMC clk
gate into divider allows to implement glitch-less EMC scaling, avoiding
reparenting to a backup clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/tegra/clk-tegra20.c | 36 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cfde3745a0db..d3df56b6f2d1 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -584,7 +584,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present = true },
 	[tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
 	[tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA20_CLK_EMC, .present = true },
 };
 
 static unsigned long tegra20_clk_measure_input_freq(void)
@@ -805,6 +804,31 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 	TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2, 26,  0, TEGRA20_CLK_DISP2),
 };
 
+static void __init tegra20_emc_clk_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
+			       ARRAY_SIZE(mux_pllmcp_clkm),
+			       CLK_SET_RATE_NO_REPARENT,
+			       clk_base + CLK_SOURCE_EMC,
+			       30, 2, 0, &emc_lock);
+
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+				    &emc_lock);
+	clks[TEGRA20_CLK_MC] = clk;
+
+	/*
+	 * Note that 'emc_mux' source and 'emc' rate shouldn't be changed at
+	 * the same time due to a HW bug, this won't happen because we're
+	 * defining 'emc_mux' and 'emc' as distinct clocks.
+	 */
+	clk = tegra_clk_register_divider("emc", "emc_mux",
+				clk_base + CLK_SOURCE_EMC, CLK_IS_CRITICAL,
+				TEGRA_DIVIDER_INT, 0, 8, 1, &emc_lock);
+	clks[TEGRA20_CLK_EMC] = clk;
+}
+
 static void __init tegra20_periph_clk_init(void)
 {
 	struct tegra_periph_init_data *data;
@@ -818,15 +842,7 @@ static void __init tegra20_periph_clk_init(void)
 	clks[TEGRA20_CLK_AC97] = clk;
 
 	/* emc */
-	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
-			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, &emc_lock);
-
-	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
-				    &emc_lock);
-	clks[TEGRA20_CLK_MC] = clk;
+	tegra20_emc_clk_init();
 
 	/* dsi */
 	clk = tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
-- 
2.19.0

