Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7F6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82033208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrXqtk49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82033208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936747AbeFQPBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:01:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46337 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933715AbeFQO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id j13-v6so20957788lfb.13;
        Sun, 17 Jun 2018 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f5Y06rz9UG2HFUIxiIjhxYgMyTYg8+uiJlAH88a2J14=;
        b=JrXqtk49HbbYs7dALrRK/6o/ErC1t+3b4jONU0SMj9HAZWRP2EA8Pugz9AnSbIXlpE
         tOawOGic4eqXAFSHWS9vfDPAaz3DH0VR0N5alDSE1jdkRkljIGHFPpHfYvM0QRzT8f3w
         jVtVom9QRqdl2gZBMBTEIQlB4/QIO/mbxMpgD4hXbyVIJd2vB96md1q/lp++qJc4QKeu
         RR2fP5mGI3+/mKUV05a9hx3E3Azd7IPukOvm2v9klvpLP3FyIpCt7ZZflSl/yJ2tEmtF
         19FLKLUcsDHBJt5IxGLf6gT0ndkpR1v167uxVNhORCrTJ2vPQVJgqOVY9vC80HZZtE+q
         gDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f5Y06rz9UG2HFUIxiIjhxYgMyTYg8+uiJlAH88a2J14=;
        b=hhEvPUu42aISfvqC+GstVmMWtZtP6aln56BrMylTZgst/74uYwA0DaBa0SsHSP9+aL
         useIYql0TRM0cea+nT7mbSU/M/ZV82iSbXzrz8wYLwBDRX3heqea3pCTRylQzyWSN/B0
         MlyIupARKV9hP4nwDsG+BN6Vp58Jph2J/jN0NRBz14EJqYFip38L4J2Jm+GDU2KuljlO
         TyjlDeZ5aPartiEwUwNBsClQ8vDG279fybC7LBKcsqZvnl9gU+GvcZnfZtP741yQBuLb
         clsi5ganwaChyCUyC4RZ0JmgSjYrY3OpVWasaqldsWQ4CtUrBXktu98DmWybk3sHm/WQ
         86XA==
X-Gm-Message-State: APt69E3Jx01UTNKKJes2Zpbh49mmKpPPdffoMU1+feVOQtOt/A9F0Kl5
        28uZMfrFNOdn2w/FlEkutB4=
X-Google-Smtp-Source: ADUXVKKGjvunYUYEl7qYcOmQOP7IMVEDyUln4h6qDhitK0CCC8rUry9NvBST8wkLUlyeWROETJI4pw==
X-Received: by 2002:a2e:560d:: with SMTP id k13-v6mr5723589ljb.124.1529247585472;
        Sun, 17 Jun 2018 07:59:45 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:44 -0700 (PDT)
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
Subject: [PATCH v3 7/8] clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
Date:   Sun, 17 Jun 2018 17:55:38 +0300
Message-Id: <20180617145539.4758-8-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
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
index 2bd35418716a..ca4eadb9520e 100644
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
2.17.1

