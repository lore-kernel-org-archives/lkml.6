Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CE4C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A32081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLHSCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:02:35 -0500
Received: from mailoutvs27.siol.net ([185.57.226.218]:58616 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726172AbeLHSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:02:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 22D025210AA;
        Sat,  8 Dec 2018 19:02:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EXdHMH6Q5ElZ; Sat,  8 Dec 2018 19:02:29 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C62A652115E;
        Sat,  8 Dec 2018 19:02:29 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 040345210AA;
        Sat,  8 Dec 2018 19:02:27 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] clk: sunxi-ng: a64: Allow parent change for VE clock
Date:   Sat,  8 Dec 2018 19:02:22 +0100
Message-Id: <20181208180222.12608-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cedrus driver wants to set VE clock higher than it's possible without
changing parent rate.

Allow changing parent rate for VE clock, so clock rate can be set
freely.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
index 5f80eb018014..1e2cd37cf0b8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -554,7 +554,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-m=
clk", csi_mclk_parents,
 				 0x134, 0, 5, 8, 3, BIT(15), 0);
=20
 static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
-			     0x13c, 16, 3, BIT(31), 0);
+			     0x13c, 16, 3, BIT(31), CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), CLK_SET_RATE_PARENT);
--=20
2.19.2

