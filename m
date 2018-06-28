Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5BAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F59627A5C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJDsK2t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F59627A5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967131AbeF1XPx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:15:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45129 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeF1XPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:15:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so3107525pgv.12;
        Thu, 28 Jun 2018 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYHmEfwyTRZ2qUDtn+3Srp2bHdRirZCZ1+7PwhwO5Yw=;
        b=bJDsK2t/b2eO+wapQnUgAn2kb2/gACPDaGEA+jNOA8yyOttUubToqkyTn907OVigW1
         sidqEHbabFsBlpZIySUbmJ4CZ5H26/xTqDvAgNTdwZfYnTpMEUL1PiTSklSMakNkPGoi
         RJHGvvKvJHhPyu3PnCASlnVEweuFCswlOIiuMkeJmjXaKtudUNMbML5w+fMad1iuZl5r
         8aBCHRUAsLOJn8q0A6TpINSlSFzwOPwgq8nhyYMfhlf34BMY0IN/ilmt0G4vXYlJDRcu
         UtsNlggFZvl+Ak1M6+73aK2tWMm4DLe40fgzCTybMJKbFQR4wDmm0XQUdZ0/bD9dqL5d
         aQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GYHmEfwyTRZ2qUDtn+3Srp2bHdRirZCZ1+7PwhwO5Yw=;
        b=ka2FCbYK/vY9+GKxt4dEhg6CGrgMjNGolfdlUJfcXY3A+K3SW5VT0o3QlqZWkB42Hu
         7clyf5we34v3U5jKBHInLud3fpxKesXXCeYdgWKPJwSXLfTMMTttnrKgY9Dz13SSTk5Q
         c3S7rIPAZDE/3BJ/h8+cHrjOx3/7fCvvlHQJLeiULhX1awTqOQn9yhh1DEgNNA5hAGUc
         Nnvj3HwDh52kdXhzt4KsceKatB2pFe8PhUxY7j7IYTA2TDaArrooEJnhCmYhR0wxn3SR
         i+8xkQsx48JRAoEDuBkA4IgbQ7YPZQFTkTqOwnH/P4yrTO0Thdo/nLn2gP9Fd/uYub3y
         9nEg==
X-Gm-Message-State: APt69E1yoft8C9OdmEosx6IiZcb4SOenTOIrwF99aMCUXyLnSH6wiKHz
        hSAmjzRAKhX1jFyiJHkUZWs=
X-Google-Smtp-Source: ADUXVKKysZC1UX+252EUEE1WC3cuimzFQlTjYoIpHShYayHIlBuI61JN3F5OWkz9DKrUUPPbu4LoJg==
X-Received: by 2002:a65:63cd:: with SMTP id n13-v6mr10345735pgv.185.1530227750412;
        Thu, 28 Jun 2018 16:15:50 -0700 (PDT)
Received: from aurora.jms.id.au ([203.0.153.9])
        by smtp.gmail.com with ESMTPSA id m7-v6sm7993378pfj.25.2018.06.28.16.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 16:15:49 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Fri, 29 Jun 2018 08:45:43 +0930
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] clk: aspeed: Support HPLL strapping on ast2400
Date:   Fri, 29 Jun 2018 08:45:40 +0930
Message-Id: <20180628231540.26633-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPLL can be configured through a register (SCU24), however some
platforms chose to configure it through the strapping settings and do
not use the register. This was not noticed as the logic for bit 18 in
SCU24 was confused: set means programmed, but the driver read it as set
means strapped.

This gives us the correct HPLL value on Palmetto systems, from which
most of the peripheral clocks are generated.

Fixes: 5eda5d79e4be ("clk: Add clock driver for ASPEED BMC SoCs")
Cc: stable@vger.kernel.org # v4.15
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-aspeed.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 38b366b00c57..2ef4ad7bdbdc 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -24,7 +24,7 @@
 #define ASPEED_MPLL_PARAM	0x20
 #define ASPEED_HPLL_PARAM	0x24
 #define  AST2500_HPLL_BYPASS_EN	BIT(20)
-#define  AST2400_HPLL_STRAPPED	BIT(18)
+#define  AST2400_HPLL_PROGRAMMED BIT(18)
 #define  AST2400_HPLL_BYPASS_EN	BIT(17)
 #define ASPEED_MISC_CTRL	0x2c
 #define  UART_DIV13_EN		BIT(12)
@@ -565,29 +565,45 @@ builtin_platform_driver(aspeed_clk_driver);
 static void __init aspeed_ast2400_cc(struct regmap *map)
 {
 	struct clk_hw *hw;
-	u32 val, freq, div;
+	u32 val, div, clkin, hpll;
+	const u16 hpll_rates[][4] = {
+		{384, 360, 336, 408},
+		{400, 375, 350, 425},
+	};
+	int rate;
 
 	/*
 	 * CLKIN is the crystal oscillator, 24, 48 or 25MHz selected by
 	 * strapping
 	 */
 	regmap_read(map, ASPEED_STRAP, &val);
-	if (val & CLKIN_25MHZ_EN)
-		freq = 25000000;
-	else if (val & AST2400_CLK_SOURCE_SEL)
-		freq = 48000000;
-	else
-		freq = 24000000;
-	hw = clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, freq);
-	pr_debug("clkin @%u MHz\n", freq / 1000000);
+	rate = (val >> 8) & 3;
+	if (val & CLKIN_25MHZ_EN) {
+		clkin = 25000000;
+		hpll = hpll_rates[1][rate];
+	} else if (val & AST2400_CLK_SOURCE_SEL) {
+		clkin = 48000000;
+		hpll = hpll_rates[0][rate];
+	} else {
+		clkin = 24000000;
+		hpll = hpll_rates[0][rate];
+	}
+	hw = clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, clkin);
+	pr_debug("clkin @%u MHz\n", clkin / 1000000);
 
 	/*
 	 * High-speed PLL clock derived from the crystal. This the CPU clock,
-	 * and we assume that it is enabled
+	 * and we assume that it is enabled. It can be configured through the
+	 * HPLL_PARAM register, or set to a specified frequency by strapping.
 	 */
 	regmap_read(map, ASPEED_HPLL_PARAM, &val);
-	WARN(val & AST2400_HPLL_STRAPPED, "hpll is strapped not configured");
-	aspeed_clk_data->hws[ASPEED_CLK_HPLL] = aspeed_ast2400_calc_pll("hpll", val);
+	if (val & AST2400_HPLL_PROGRAMMED)
+		hw = aspeed_ast2400_calc_pll("hpll", val);
+	else
+		hw = clk_hw_register_fixed_rate(NULL, "hpll", "clkin", 0,
+				hpll * 1000000);
+
+	aspeed_clk_data->hws[ASPEED_CLK_HPLL] = hw;
 
 	/*
 	 * Strap bits 11:10 define the CPU/AHB clock frequency ratio (aka HCLK)
-- 
2.17.1

