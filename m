Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A065C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D532064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXF6t5cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D532064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbeGXRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:51:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36744 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbeGXRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:51:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id d14-v6so983096pfo.3;
        Tue, 24 Jul 2018 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZvIZKJEwpMIpohq/LdYvTtmJaLs5qZc4iqS3mjg1E9g=;
        b=hXF6t5cjrR8pCnFh4OmOIMeVh3OyISEe9Xxmo0Uy4jjPF5AUXwH3V4uZHJqZXXNJqH
         HjfqPcHpQMEjnPY0yg/du0uH9OclQM+XJ053dBFOSvgpVAKlX8Q3S3GJCUaeWLtWfT0V
         1bCFiks9sCkeTc3cITWOGk2SRWh2m9/dD1TFPRLKdkiEDDHiVDOw6Wi5EMJzK70QVQXh
         M1xhc2uI9tlGaKwqnIdTbHK340OfD8fBI3sBNEd8eghElxnyZB4NsOYYhg6UZgzVo9zo
         RkfUb28rAyO9PUdqbRHsIb7i9qs4PjGn0XVgeDHXMDGkSU7C27bbJeykNMtZCo6A3XIq
         7/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZvIZKJEwpMIpohq/LdYvTtmJaLs5qZc4iqS3mjg1E9g=;
        b=K56tYW78B7m+suy8i0ZupPbPscX8Zn1So/tggX15xwXw0EjmxO7PRaJrAOaVR7PQJQ
         JL89TWlkRk4yj/H4mO4Eoi63gP/7uUwT7MhZ9/nlYJx/sQvsa6IXncciDS5WeMhnl+is
         Acqg6QIVxwwXBfonpzYfHfYpsvsdsUdVGbo+o7pn1F6yOx6Wg2uo09MuYferW7rOlmvm
         0n5aKFT648WVmJai+a664Q1wPP8pebx8XNKxYOIoOsaKas3jTRjzBhHBUFbtqkc57Y8N
         7/+xNI0M9DUREP4YqdxFxcRrM+fH7gYh7CZ/wn1wGP7PFEj3Vb+ZfjjRnJonUo3LcpiG
         VG4Q==
X-Gm-Message-State: AOUpUlFT7+S05YLnlTX/Q6PQf+GxGw6cB1dOGys5JbF9egcYsg8BSYVr
        BSheV1tMQozrR8TdXBF+jCw=
X-Google-Smtp-Source: AAOMgpdWxjh7j0n/11RQ7ldGUxwer27Du/uChLHjeB9tkCuhJsAe0NleEDSkbVZnmxFuhshI5TVIkw==
X-Received: by 2002:a65:6211:: with SMTP id d17-v6mr17445108pgv.450.1532450629144;
        Tue, 24 Jul 2018 09:43:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:48 -0700 (PDT)
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
Subject: [PATCH v5 7/8] clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
Date:   Tue, 24 Jul 2018 19:42:20 +0300
Message-Id: <20180724164221.3307-8-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
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
index 68551effb5ca..c71b61162a32 100644
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

