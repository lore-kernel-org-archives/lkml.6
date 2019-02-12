Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D9C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68F7222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993875;
	bh=wdBGAn6LPu5DlmekMMQ2Nmm/ROb3O2h/2jhToyeSOKc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lbIc0j126dxRR8n6R/Jeudtzm667TIflVLbhMZWisjCi7x0kFq5mBI47fsga8WdBn
	 YuR66Cdvcwl4ShQ5e5Y8tMBxsQVlkk57oi3fBVVpcBJq5JTqFLxeEaCwNmrkHroWRR
	 /5HC8wXRZS5hK3RQNYiskXdKF3MDt+9UCRwYdACE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfBLRvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbfBLRvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:51:12 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C0D20842;
        Tue, 12 Feb 2019 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993871;
        bh=wdBGAn6LPu5DlmekMMQ2Nmm/ROb3O2h/2jhToyeSOKc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YoJJZ7j9E6vl6bXUz40FkjJ0rwcMHQGYrPIDLW/paTc4mzcTi7ru5RwQ2JW14en4h
         8d04k0q3ML+pWl7UQP5dJtR7DAdpbLe9MkOzjx93dZnU+/po8vjWP0QvJFRyF6YsxB
         oG34Ao2YPWCBKwJQjv5M2TjkzdN0xnch7I/scaPg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 3/4] clk: samsung: exynos5410: Add gate clock for ADC
Date:   Tue, 12 Feb 2019 18:50:51 +0100
Message-Id: <20190212175052.6310-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212175052.6310-1-krzk@kernel.org>
References: <20190212175052.6310-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gate clock for ADC block on Exynos5410.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 0a0b09591e6f..b2da2c8fa0c7 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -209,6 +209,7 @@ static const struct samsung_gate_clock exynos5410_gate_clks[] __initconst = {
 	GATE(CLK_USI1, "usi1", "aclk66", GATE_IP_PERIC, 11, 0, 0),
 	GATE(CLK_USI2, "usi2", "aclk66", GATE_IP_PERIC, 12, 0, 0),
 	GATE(CLK_USI3, "usi3", "aclk66", GATE_IP_PERIC, 13, 0, 0),
+	GATE(CLK_TSADC, "tsadc", "aclk66", GATE_IP_PERIC, 15, 0, 0),
 	GATE(CLK_PWM, "pwm", "aclk66", GATE_IP_PERIC, 24, 0, 0),
 
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
-- 
2.17.1

