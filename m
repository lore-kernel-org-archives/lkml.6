Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6E208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OshHu/0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6E208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934223AbeFQPAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:00:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41540 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbeFQO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so20977381lfa.8;
        Sun, 17 Jun 2018 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U8guvA3QSPbQam4GL6funZK7ex1FuKPm9OCklaz8lhE=;
        b=OshHu/0M0Emuzq8qWRTfR43jT//NVh+6nq2z0Yc5Hcmn58WBCqz3PwxbY5ncoz+QQA
         TVDimaGdm3xQViSicWm3TizjNqI3IYlh3gUEBEAkH7E2KwsKiy1hD0uBztXyJ5zloED8
         1GXffpxO8/HzqqrKyyo9bKelj283Mvm/mfEOZtqJHoMEC8NncktDz1lcIY8UCNenhdr+
         E1Uw+KFXhawK+BEI+Qa6UlV5Dpfx3KVMG95INEPJFAaVAGKDSP3tXtSBBofKMttqT3Z/
         o4vhXEcEtKyK46f9THrznaMNJ0VNsugfogY9o/54secRfrg67HY29Sr/TGEal8J1Jgma
         q4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U8guvA3QSPbQam4GL6funZK7ex1FuKPm9OCklaz8lhE=;
        b=Kwpp1WJY8HNMYry/TXwDQwDW1AZF1mm1Mwof66zYLv1qrwv+C6P18lkBMLG6u5PLTn
         nPef5noH+qwyShCKjMxXSg/Q3FHZNmQ+ijSS8giTH3E8GsIQ1G1F64Kl5C+oUEZQkB4b
         hFic+be81iNvAI65Mbnke+4nITne/i92PrtldnSoiPtZDeKqqetk8bWJgOhXTR/xXMy3
         sbBI+r1RZx06MQEtBPSg+iM2bJBgPFQTKl+oh5C+R8W0LvEnz9qm7RPwCMsyJEk7Hxi5
         CNMgehGA+1KP/KWlXbhEd6pSG+jUNQmS3wPwPkjsp3mr0AFQlSD88nZmkA2uGMSZeOz1
         ul4g==
X-Gm-Message-State: APt69E0w9gLoUU+1HgJU0zIdxmjYhY26OF5VLvjmxy4kjt4Kl3BVehCh
        QFDa5wMmc758UYnXLFp5NEI=
X-Google-Smtp-Source: ADUXVKIMAEBP9B58DkgZxJKpdKDQ3/oczGDr3/p763RjPqZCNvg/nDkbQjcSfsqUEgy4Oeuo50dVzQ==
X-Received: by 2002:a2e:cf:: with SMTP id e76-v6mr5750426lji.82.1529247584403;
        Sun, 17 Jun 2018 07:59:44 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Sun, 17 Jun 2018 17:55:37 +0300
Message-Id: <20180617145539.4758-7-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
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
index cc857d4d4a86..2bd35418716a 100644
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
+	 * defining 'emc_mux' and 'emc' as a distinct clocks.
+	 */
+	clk = clk_register_divider(NULL, "emc", "emc_mux", CLK_IS_CRITICAL,
+				   clk_base + CLK_SOURCE_EMC, 0, 7,
+				   0, &emc_lock);
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
2.17.1

