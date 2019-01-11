Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55841C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315A82183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfAKOX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:23:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbfAKOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:23 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054K-7A; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002w6-2a; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 02/11] MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc init
Date:   Fri, 11 Jan 2019 15:22:31 +0100
Message-Id: <20190111142240.10908-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111142240.10908-1-o.rempel@pengutronix.de>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

Preparation for reusing functions for DT

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 50bc3b01a4c4..e02b819b2f5d 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -110,9 +110,6 @@ static void __init ar71xx_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
@@ -140,9 +137,6 @@ static void __init ar724x_clocks_init(void)
 	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
 
 	ar724x_clk_init(ref_clk, ath79_pll_base);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
@@ -218,9 +212,6 @@ static void __init ar933x_clocks_init(void)
 	ref_clk = ath79_set_clk(ATH79_CLK_REF, ref_rate);
 
 	ar9330_clk_init(ref_clk, ath79_pll_base);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
@@ -353,9 +344,6 @@ static void __init ar934x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
-
 	iounmap(dpll_base);
 }
 
@@ -439,9 +427,6 @@ static void __init qca953x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static void __init qca955x_clocks_init(void)
@@ -524,9 +509,6 @@ static void __init qca955x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static void __init qca956x_clocks_init(void)
@@ -628,13 +610,13 @@ static void __init qca956x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 void __init ath79_clocks_init(void)
 {
+	const char *wdt;
+	const char *uart;
+
 	if (soc_is_ar71xx())
 		ar71xx_clocks_init();
 	else if (soc_is_ar724x() || soc_is_ar913x())
@@ -651,6 +633,20 @@ void __init ath79_clocks_init(void)
 		qca956x_clocks_init();
 	else
 		BUG();
+
+	if (soc_is_ar71xx() || soc_is_ar724x() || soc_is_ar913x()) {
+		wdt = "ahb";
+		uart = "ahb";
+	} else if (soc_is_ar933x()) {
+		wdt = "ahb";
+		uart = "ref";
+	} else {
+		wdt = "ref";
+		uart = "ref";
+	}
+
+	clk_add_alias("wdt", NULL, wdt, NULL);
+	clk_add_alias("uart", NULL, uart, NULL);
 }
 
 unsigned long __init
-- 
2.20.1

