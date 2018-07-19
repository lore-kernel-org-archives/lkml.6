Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CABC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33062084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd+OEi5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33062084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGSOFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:05:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46613 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeGSOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so7430584ljj.13;
        Thu, 19 Jul 2018 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iy0/BWeQr0SbOjZJetKjJ9Vt81xpcKueGzQTC6/ud8M=;
        b=sd+OEi5bTfHih9WxQhHt42dfwJWnUC5IxdRKbVFBGYvzYr81Ot8nAcz7L0dtpdl94v
         MEclbtomGUpobWcimbatoDC+hTv82Rdnqeu4a7Cmp5Loo+WIDbLGTF6EXZLbPb3lLwx8
         DY4CqitNmff6VsYUm+NbHMX0MvebHAFrdP+AvUq+ySTu/t0uYERkwL/FJvNi1PFSQIbb
         9FTuSGi4RZeikFcUCe8Ncf0Uz4xUn/6Mh63sTIhGUyUrIKJoUacJXXcVD1kseXvoVaj1
         hYEAIY+8ZJdc7kRi1dyrb4OR0RQf3nCsXW5TvvNQ2NKofk6xxx/hN9UvY84E5jC00xs0
         1qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iy0/BWeQr0SbOjZJetKjJ9Vt81xpcKueGzQTC6/ud8M=;
        b=Hdxe2Kct/Md0RKtn/S4sxeiKkQHOR3wI5GMfizRyapisfkngyGtIxKeipMCPMw6//K
         nOWe7rcjSsmQy3KLG08SdrCGH2AEAEyt0uB9rUw4g4m7Gft38aWIqIResm+npXmKGCMK
         AMNWiOd6nJyg6xiloh9PCC9D8cq2MJevsNL+mP6f3WU+T3M1p3kRvnWo3IHYZ13g3eIr
         Y36LdhkQm87gWcSipsEZxI7pnGi0yu1fLKtBJ20S5sYktoAauKiPlVPT+FYPwRkyKJQd
         gXbaWk6Ao7YTfsQE+Ar7JxlbGnpAhgG59d+RTizJsuom9dTXVH6NUREMhdCT8tX9TrE0
         HS2A==
X-Gm-Message-State: AOUpUlFEBJLODeQ/M6rBlq7MaOVczrFe3xR7oil1w7LdxrwZmggAWJvy
        h+THargJA3EN75hd3CmsAOU=
X-Google-Smtp-Source: AAOMgpdCGirIrzxG6vfHNm6YphWNST4C7zvMmr+dyipzLjwQOxirrfPht9X2BCeShpgPt9K7eCLS7w==
X-Received: by 2002:a19:26d2:: with SMTP id m201-v6mr6499352lfm.43.1532006558197;
        Thu, 19 Jul 2018 06:22:38 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:37 -0700 (PDT)
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
Subject: [PATCH v4 7/8] clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
Date:   Thu, 19 Jul 2018 16:21:31 +0300
Message-Id: <20180719132132.16153-8-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that direct PLLM sourcing is turned off for EMC as we don't support
that configuration in the clk driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index ebea97016d58..e1f039aa8ca9 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -800,7 +800,9 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 
 static void __init tegra20_emc_clk_init(void)
 {
+	const u32 use_pllm_ud = BIT(29);
 	struct clk *clk;
+	u32 emc_reg;
 
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
@@ -812,6 +814,14 @@ static void __init tegra20_emc_clk_init(void)
 				    &emc_lock);
 	clks[TEGRA20_CLK_MC] = clk;
 
+	/* un-divided pll_m_out0 is currently unsupported */
+	emc_reg = readl_relaxed(clk_base + CLK_SOURCE_EMC);
+	if (emc_reg & use_pllm_ud) {
+		pr_err("%s: un-divided PllM_out0 used as clock source\n",
+		       __func__);
+		return;
+	}
+
 	/*
 	 * Note that 'emc_mux' source and 'emc' rate shouldn't be changed at
 	 * the same time due to a HW bug, this won't happen because we're
-- 
2.18.0

