Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A012171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691552;
	bh=erUnjmWMM4EK60WS+qexEeg+GIott08M6ICGnnF2XrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QstHr2dbke3yyI7mvsTe1f9D+wV60qBOAj3VlCXw9uIxNxlAfZj6wBRqrtlDKua7r
	 Hb1OZrTjb60cAb9uegNsEPcp4Dz8SDQWetipFntduKD0sB5kvIBgplZYxBiIJXMvLC
	 9s5dAoBGfm3ul3kdL1zpXesHZexs6S2PIhHh5oec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfA1QFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbfA1QFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA21F20989;
        Mon, 28 Jan 2019 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691545;
        bh=erUnjmWMM4EK60WS+qexEeg+GIott08M6ICGnnF2XrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzJji+dqok7vG7sueEAYUG0xtnWtj1J17siEiWMak3YTTeaC06+o7s+RiUNJZNRZC
         7pnPHB/vjLa27mv9UhhmBJL0mUtEGRpFNYqa7w/aqi2wORminV5nZvfzUvMXRw9X1y
         3xUBqxGSl/6e+e+P7Ldb32YGV9uU8dNzdJP2OAWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 137/258] drm/msm/dsi: fix dsi clock names in DSI 10nm PLL driver
Date:   Mon, 28 Jan 2019 10:57:23 -0500
Message-Id: <20190128155924.51521-137-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Kumar <abhinavk@codeaurora.org>

[ Upstream commit c1866d44d149a1ea5c303632114fb6aa08cfd263 ]

Fix the dsi clock names in the DSI 10nm PLL driver to
match the names in the dispcc driver as those are
according to the clock plan of the chipset.

Changes in v2:
- Update the clock diagram with the new clock name

Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 41bec570c518..31205625c734 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -17,7 +17,7 @@
  *                              |                |
  *                              |                |
  *                 +---------+  |  +----------+  |  +----+
- *  dsi0vco_clk ---| out_div |--o--| divl_3_0 |--o--| /8 |-- dsi0pllbyte
+ *  dsi0vco_clk ---| out_div |--o--| divl_3_0 |--o--| /8 |-- dsi0_phy_pll_out_byteclk
  *                 +---------+  |  +----------+  |  +----+
  *                              |                |
  *                              |                |         dsi0_pll_by_2_bit_clk
@@ -25,7 +25,7 @@
  *                              |                |  +----+  |  |\  dsi0_pclk_mux
  *                              |                |--| /2 |--o--| \   |
  *                              |                |  +----+     |  \  |  +---------+
- *                              |                --------------|  |--o--| div_7_4 |-- dsi0pll
+ *                              |                --------------|  |--o--| div_7_4 |-- dsi0_phy_pll_out_dsiclk
  *                              |------------------------------|  /     +---------+
  *                              |          +-----+             | /
  *                              -----------| /4? |--o----------|/
@@ -690,7 +690,7 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
 
 	hws[num++] = hw;
 
-	snprintf(clk_name, 32, "dsi%dpllbyte", pll_10nm->id);
+	snprintf(clk_name, 32, "dsi%d_phy_pll_out_byteclk", pll_10nm->id);
 	snprintf(parent, 32, "dsi%d_pll_bit_clk", pll_10nm->id);
 
 	/* DSI Byte clock = VCO_CLK / OUT_DIV / BIT_DIV / 8 */
@@ -739,7 +739,7 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
 
 	hws[num++] = hw;
 
-	snprintf(clk_name, 32, "dsi%dpll", pll_10nm->id);
+	snprintf(clk_name, 32, "dsi%d_phy_pll_out_dsiclk", pll_10nm->id);
 	snprintf(parent, 32, "dsi%d_pclk_mux", pll_10nm->id);
 
 	/* PIX CLK DIV : DIV_CTRL_7_4*/
-- 
2.19.1

