Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E518C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA51124204
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA51124204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeFVMtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:49:04 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57234 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeFVMtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:49:02 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 911B7630E4;
        Fri, 22 Jun 2018 12:48:05 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 4/7] clk: sunxi-ng: add A64 compatible string
Date:   Fri, 22 Jun 2018 20:45:37 +0800
Message-Id: <20180622124540.56203-3-icenowy@aosc.io>
In-Reply-To: <20180622124540.56203-1-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As claiming Allwinner A64 SRAM C is a prerequisite for all sub-blocks of
the A64 DE2, not only the CCU sub-block, a bus driver is then written for
enabling the access to the whole DE2 part by claiming the SRAM.

In this situation, the A64 compatible string will be just added with no
other requirments, as they're processed by the parent bus driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
No changes since v1.

 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 468d1abaf0ee..8df7cd93453e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -292,13 +292,10 @@ static const struct of_device_id sunxi_de2_clk_ids[] = {
 		.compatible = "allwinner,sun50i-h5-de2-clk",
 		.data = &sun50i_a64_de2_clk_desc,
 	},
-	/*
-	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
-	 * DE2 really working.
-	 * So there's currently no A64 compatible here.
-	 * H5 shares the same reset line with A64, so here H5 is using the
-	 * clock description of A64.
-	 */
+	{
+		.compatible = "allwinner,sun50i-a64-de2-clk",
+		.data = &sun50i_a64_de2_clk_desc,
+	},
 	{ }
 };
 
-- 
2.17.1

