Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212DDC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E155F21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ObyUoR2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBGNgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:36:32 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55626 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfBGNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:36:27 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B25B025BEDF;
        Fri,  8 Feb 2019 00:36:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549546574; bh=yFX6KmdU35CAIDBP1IV9ZVOnGkQjhxvM824RijvRTws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObyUoR2qY62UZK4kD+z159NNDRx8Ef8lPYbjTc0ZImp/clcladSkupm63JZk/V+5J
         fVbU5m80OdzAGyl+WU15+oPHIVjZ8ummrVDHXbIOpE3g+zwgLOuph2ZxTKgSrL7Xw4
         JOog9n0MunGZHkXGIAfCWO2T0WhD3Z8swgg7Eqkg=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 9E7769406FE; Thu,  7 Feb 2019 14:36:07 +0100 (CET)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 5/5] clk: renesas: r8a774c0: Add Z2 clock
Date:   Thu,  7 Feb 2019 14:35:50 +0100
Message-Id: <20190207133550.13967-6-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190207133550.13967-1-horms+renesas@verge.net.au>
References: <20190207133550.13967-1-horms+renesas@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for R-Car RZ/G2E (r8a774c0) Z2 clock.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3: New patch
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 10b96895d452..24634ca94f69 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -79,6 +79,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_FIXED("za2",       R8A774C0_CLK_ZA2,   CLK_PLL0D24,    1, 1),
 	DEF_FIXED("za8",       R8A774C0_CLK_ZA8,   CLK_PLL0D8,     1, 1),
+	DEF_GEN3_Z("z2",       R8A774C0_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL0, 4, 8),
 	DEF_FIXED("ztr",       R8A774C0_CLK_ZTR,   CLK_PLL1,       6, 1),
 	DEF_FIXED("zt",        R8A774C0_CLK_ZT,    CLK_PLL1,       4, 1),
 	DEF_FIXED("zx",        R8A774C0_CLK_ZX,    CLK_PLL1,       3, 1),
-- 
2.11.0

