Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505CE2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAb+uQba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505CE2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbeGXRvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:51:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45455 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbeGXRvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:51:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so3279388pgq.12;
        Tue, 24 Jul 2018 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEntl0EBSh+VHmSftZDapg3XX86cjd85caaA6ut9+wE=;
        b=HAb+uQbaNoo5JjjX0w8fE4dvLBGMrH/tRwbsUWkpw8/d0kR12JFfomSAb1jlwQsDqE
         0IS+0wUjhHYs3uFMFQzUG3GzphnFjcehPFHKMHWO70tr/HEXtp6gttycAQ+rINRq8AZU
         9RaT7oD+7SrK2x7V6tbRxlY/bTZCHSS8Tn7pyrQssxv19m1mhoDY92fLBU/HYLoZxzNu
         lxc4FxVjJ4KcWJE7wUYSZKe6ZgbN/NSgzGtgr1wQkb8Vp21RhxFc+cwn0zsquxzTCULg
         D73Hko58sg3KtYfvMitSTd/9EUXx56fkeZsXUeRmK1fV1ykVy2PCKnTcaBKXHJiy3VQU
         QnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HEntl0EBSh+VHmSftZDapg3XX86cjd85caaA6ut9+wE=;
        b=TgYJyfRc3kWpO2MluVghXy8T/aTaEGl8ujVBMztECeTfNfXi3Q3men49ODyuQmsTRb
         hS1AKgVfBAlk+/oRp7r85yPwBQ7TcgPoNgILdFIAuMc0+mJaetMnhF8FDivZhGkXmBvF
         aAF/QW90Eg0qqVLKn0o/nmGcBTcgZxVKwLE4WHami6EfH61r8dYx7pjUODwKYreQAWwd
         wi4Vl37EYqk5RxMqKLaLwpz0G2pE8pq8dGrr0yEpmjNS+KiHv4AjKj/BQOQIYOnmFy5d
         51yDfTTRsEpcsUoVoqe8DJUHPS53uA6886n6VHnjjpZJGwCpwAgCcLjGOHlPEqfyzsg9
         LEbQ==
X-Gm-Message-State: AOUpUlFS5hSJcxSgdjpnpaMiXntHShQ4JgdZTr9/t1y/DgaGsZ8mAnRq
        1ludf79ZwoALwEGFA5joDUc=
X-Google-Smtp-Source: AAOMgpeIBDbao+5on9tpmdkH5Av/6Q2iCKpKNAEvOXbYWOMp/rLQoxWcmMoZkCpGe7jBh2vZu2tn+Q==
X-Received: by 2002:a62:9849:: with SMTP id q70-v6mr18405953pfd.178.1532450621447;
        Tue, 24 Jul 2018 09:43:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Tue, 24 Jul 2018 19:42:19 +0300
Message-Id: <20180724164221.3307-7-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
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
---
 drivers/clk/tegra/clk-tegra20.c | 36 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cc857d4d4a86..68551effb5ca 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -578,7 +578,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present = true },
 	[tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
 	[tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA20_CLK_EMC, .present = true },
 };
 
 static unsigned long tegra20_clk_measure_input_freq(void)
@@ -799,6 +798,31 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
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
@@ -812,15 +836,7 @@ static void __init tegra20_periph_clk_init(void)
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
2.18.0

