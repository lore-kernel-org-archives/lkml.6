Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1EA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeLQMhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:37:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57706 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732462AbeLQMhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:37:19 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8s-0003o4-8E; Mon, 17 Dec 2018 13:37:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 04/15] clk: rockchip: use clock id for 24m dsi on rk3368
Date:   Mon, 17 Dec 2018 13:36:39 +0100
Message-Id: <20181217123650.6773-5-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the clock using the newly added clock id.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3368.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 58debf7daf85..56ca10fe3e96 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -532,7 +532,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
 			RK3368_CLKGATE_CON(3), 1, GFLAGS),
 
-	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3368_CLKGATE_CON(4), 14, GFLAGS),
+	GATE(SCLK_MIPIDSI_24M, "sclk_mipidsi_24m", "xin24m", 0, RK3368_CLKGATE_CON(4), 14, GFLAGS),
 
 	/*
 	 * Clock-Architecture Diagram 4
-- 
2.19.2

