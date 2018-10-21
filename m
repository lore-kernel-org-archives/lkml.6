Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54530ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A24520838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2KRu5+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A24520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeJVCrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40279 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id o14-v6so2243368pgv.7;
        Sun, 21 Oct 2018 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1dMzsI6EI//I62W+sNHuK8Y+078XhPwUHJAfIFzlgA=;
        b=N2KRu5+uzy++FFU1IohY42d2bVPkKGm+YxspmeC76W9dd1y288HU35OyIG2JrRIviC
         7tHtgrCp4Wyxbdxk7CELLUXY5amMa+iRFCLED5WwdjXCi/yZpXo5eyEmQcZtW11YQHFC
         Vh9WGxAVSXIv2BWffkAhZ7zapUJ39Jl+kWw+vCXIBe/ugydB6yeJvu+MhSr7EP0IrsIm
         tobRnvDGPSHq5kFMs54TLGvPg3tHnfL99TinGe166W/gD8Afk8ly1AY8bgMuT73qLMzA
         IssT8iiSrxymbYkRbENlOr9i7M4F8WXbhCDBDA8+kS6whYYflC/ORMmv1XllwvZ/VcOv
         O6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1dMzsI6EI//I62W+sNHuK8Y+078XhPwUHJAfIFzlgA=;
        b=aMF3DY5vurQSz2kD1tJ/OQ439AXVC0pGuDPOAeNUgC7zQvPfMqFGRYdZFH/RxdIN1I
         Si5ffCQMVZBeHeUURGjtOu621xBHtCe7mDCHtWMxibcdAiVw9bUalekyN/KgtDwQ82qZ
         /OhuRWgPy+oQevQDij99ylilV5ZswLgQUmSohTEJPdQ7uYFbss4rhVTvaqesGa81Qoly
         8RkHqD4xsV0roTWrm4GfaNsBsDl3U/XI15ywd1BQJHopA5CX0sMv9zAtskB4/ky5zOYJ
         IAV3iSvKwl4PxzdIo/i613qxCAVIjOi+8IVmonp5jLTkSrtYmRsIJA73dEiEewhVvHRz
         L6sw==
X-Gm-Message-State: ABuFfohPJI0RfCQUP1npmgZwWk4ys4sKcFmNFW73zNGBqjK+gSrfDgeI
        5DeNI2DFvjflbO65Wto7lrU=
X-Google-Smtp-Source: ACcGV609ImJKMZ9dkXrOHqIHy5kBmGu7gTlbuowC7TO9aMSnDs1qCgnjaz3p8ioJYDBs9q3SgvypRw==
X-Received: by 2002:a63:fa4e:: with SMTP id g14-v6mr40246320pgk.18.1540146740192;
        Sun, 21 Oct 2018 11:32:20 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:32:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
Date:   Sun, 21 Oct 2018 21:30:51 +0300
Message-Id: <20181021183052.32023-8-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that direct PLLM sourcing is turned off for EMC as we don't support
that configuration in the clk driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/tegra/clk-tegra20.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index d3df56b6f2d1..f987ed361df6 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -806,7 +806,9 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 
 static void __init tegra20_emc_clk_init(void)
 {
+	const u32 use_pllm_ud = BIT(29);
 	struct clk *clk;
+	u32 emc_reg;
 
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
@@ -818,6 +820,14 @@ static void __init tegra20_emc_clk_init(void)
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
2.19.0

