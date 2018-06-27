Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB9263BD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="inXGHoNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FB9263BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbeF0MP0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:15:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54322 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964848AbeF0MPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:15:24 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] clk: ingenic: Add missing flag for UDC clock
Date:   Wed, 27 Jun 2018 14:14:59 +0200
Message-Id: <20180627121459.13987-2-paul@crapouillou.net>
In-Reply-To: <20180627121459.13987-1-paul@crapouillou.net>
References: <20180627121459.13987-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530101723; bh=scJgrJhYS8PHKmZhMhSVTWUoIdqLz5j2N6aI1eHIfmM=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=inXGHoNXgzoU/zakAC2B93L2gqWR2d1VcHHxpkOJAi22uSN3UvyVcx8JZ8Q/0310dsCyIifuTYGly+JmP1rU/VcqPstC/6KPcws8IcN5HDLvPs61735KIUnqYxM8NZaMPjxv8xKekU7oP0Rd0K9FRUBDbyst8fuG9QvYJ5FIkWo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDC clock of the JZ4740 SoC can be gated, but the data structure
representing it was missing the CGU_CLK_GATE flag to make it work.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4740-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index bc073dd4470d..4479c102e899 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -161,7 +161,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 	},
 
 	[JZ4740_CLK_UDC] = {
-		"udc", CGU_CLK_MUX | CGU_CLK_DIV,
+		"udc", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1, -1 },
 		.mux = { CGU_REG_CPCCR, 29, 1 },
 		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
-- 
2.11.0

