Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F14C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A702177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="b5tPvmp1";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="b5tPvmp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbeLTLQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:16:43 -0500
Received: from fallback15.mail.ru ([94.100.179.50]:54886 "EHLO
        fallback15.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLTLQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Yb1P2aSIuTxnGxja0jTXn2FS4rN7Q+U8PKpZNQ52e3k=;
        b=b5tPvmp1zj04swzA/r1sSvlfeL5d0gaR2nBk21A8Qmrmvbq+9AWNXOJgRAQ7u1+u3LQqaf32GZO0YtyKonpMCo0koD8BLYZmNw2UjleXbasvHjh+aBdJ98OtmQW+ntrRBf+Buy1gNttwoYTpihPGZfpydO8c4GgKtiLlsk0sSTE=;
Received: from [10.161.64.61] (port=45212 helo=smtp53.i.mail.ru)
        by fallback15.m.smailru.net with esmtp (envelope-from <shc_work@mail.ru>)
        id 1gZwJj-0002EA-CF
        for linux-kernel@vger.kernel.org; Thu, 20 Dec 2018 14:16:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Yb1P2aSIuTxnGxja0jTXn2FS4rN7Q+U8PKpZNQ52e3k=;
        b=b5tPvmp1zj04swzA/r1sSvlfeL5d0gaR2nBk21A8Qmrmvbq+9AWNXOJgRAQ7u1+u3LQqaf32GZO0YtyKonpMCo0koD8BLYZmNw2UjleXbasvHjh+aBdJ98OtmQW+ntrRBf+Buy1gNttwoYTpihPGZfpydO8c4GgKtiLlsk0sSTE=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
        id 1gZwJb-0003Vf-Dc; Thu, 20 Dec 2018 14:16:31 +0300
From:   Alexander Shiyan <shc_work@mail.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] clocksource: clps711x: Remove board support
Date:   Thu, 20 Dec 2018 14:16:26 +0300
Message-Id: <20181220111626.17140-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.13.0
X-77F55803: 2D1AD755E866B1545A78504BD2AC2941AC9F5C0DA9FA9AD2E7AC7A8BB2BD5317A66BE2BC3FF8BB7C592F5F1828F7DFC7
X-7FA49CB5: 0D63561A33F958A511F4A34DC5082C85A1A93E28E2F85D2ACCB126939EC2412B8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249CE66FDB1904541E03AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE79383FD4D963104D4CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7C9A2B4115E0ACE2E939314D80A623AB475ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 8261CADE3D3FA0B4C2F1292954F703E98697CD375B7CF8D9FF3218203CE65191762A45175564275F6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDC60DDF8F2F021D8E7EAB3B4457305C87F4D86EEA66FF75675D5145E3F8FD384A3
X-7FA49CB5: 0D63561A33F958A5A70C0BE57F555D4EA1A56BDBB7A808FAF91E8C5B4B34F81E8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: A5480F10D64C9005756D98BBC07C3822332ABE724A08D241EAB3B4457305C87F6565FCDE7E403FA13786569BE0651809D50E20E2BC48EF5AFF3C6AF3E48A3A73EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since board support for the CLPS711X platform was removed,
remove the board support from the clps711x-timer driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/clocksource/clps711x-timer.c | 44 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index a8dd80576c95..857f8c086274 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -31,16 +31,9 @@ static u64 notrace clps711x_sched_clock_read(void)
 	return ~readw(tcd);
 }
 
-static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
+static void __init clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 {
-	unsigned long rate;
-
-	if (!base)
-		return -ENOMEM;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
-	rate = clk_get_rate(clock);
+	unsigned long rate = clk_get_rate(clock);
 
 	tcd = base;
 
@@ -48,8 +41,6 @@ static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 			      clocksource_mmio_readw_down);
 
 	sched_clock_register(clps711x_sched_clock_read, 16, rate);
-
-	return 0;
 }
 
 static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
@@ -67,13 +58,6 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 	struct clock_event_device *clkevt;
 	unsigned long rate;
 
-	if (!irq)
-		return -EINVAL;
-	if (!base)
-		return -ENOMEM;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
 	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
 	if (!clkevt)
 		return -ENOMEM;
@@ -93,31 +77,29 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 			   "clps711x-timer", clkevt);
 }
 
-void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
-				 unsigned int irq)
-{
-	struct clk *tc1 = clk_get_sys("clps711x-timer.0", NULL);
-	struct clk *tc2 = clk_get_sys("clps711x-timer.1", NULL);
-
-	BUG_ON(_clps711x_clksrc_init(tc1, tc1_base));
-	BUG_ON(_clps711x_clkevt_init(tc2, tc2_base, irq));
-}
-
-#ifdef CONFIG_TIMER_OF
 static int __init clps711x_timer_init(struct device_node *np)
 {
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
 
+	if (!base)
+		return -ENOMEM;
+	if (!irq)
+		return -EINVAL;
+	if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
-		return _clps711x_clksrc_init(clock, base);
+		clps711x_clksrc_init(clock, base);
+		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
 		return _clps711x_clkevt_init(clock, base, irq);
 	default:
 		return -EINVAL;
 	}
+
+	return 0;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
-#endif
-- 
2.13.0

