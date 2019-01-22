Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71351C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B95A20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfAVIQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:16:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54579 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfAVIQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:16:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 08FEC207B2; Tue, 22 Jan 2019 09:16:30 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id B55CE206DC;
        Tue, 22 Jan 2019 09:16:19 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] clk: sunxi-ng: v3s: Fix TCON reset de-assert bit
Date:   Tue, 22 Jan 2019 09:16:19 +0100
Message-Id: <20190122081619.27653-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet and the reference code from Allwinner, the
bit used to de-assert the TCON reset is bit 4, not bit 3.

Fix it in the V3s CCU driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 621b1cd996db..ac12f261f8ca 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -542,7 +542,7 @@ static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
 	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
 
 	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
-	[RST_BUS_TCON0]		=  { 0x2c4, BIT(3) },
+	[RST_BUS_TCON0]		=  { 0x2c4, BIT(4) },
 	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
 	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
 	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
-- 
2.20.1

