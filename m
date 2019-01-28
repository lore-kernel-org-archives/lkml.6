Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6952147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690678;
	bh=erUnjmWMM4EK60WS+qexEeg+GIott08M6ICGnnF2XrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZDYPDbs26OvtpEbeKIKb1IZ8hpQqTO+QlRPgk5CxlU4VVWui0rJz0U35sD9WdCYM
	 6enZmMKOOSZRRr/CsAYIqwOr2bJqT//2sguptdO2gOaqgkIzbspMo5K/pJgSd9SHFn
	 CA9uRHWfWPPqhPmwoa725/2TRUPQk2B9qgzyKMM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfA1PvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfA1PvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5414520880;
        Mon, 28 Jan 2019 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690672;
        bh=erUnjmWMM4EK60WS+qexEeg+GIott08M6ICGnnF2XrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooxQ2SpkGKdew8tgdCR0nC7WOYHFAuVQbRySB8T1HslWFCNxAEFqbr6IfFiznGaFt
         wz8K7SvcwPipmO1DvtTKwSFqTdSrnTxLEWSxER8Be4r4TOFd/WZAfsGK0BiHZFcIOJ
         ppTko1dc3oKcPhGKuanR3XHpScS6IXKuINlfappA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 161/304] drm/msm/dsi: fix dsi clock names in DSI 10nm PLL driver
Date:   Mon, 28 Jan 2019 10:41:18 -0500
Message-Id: <20190128154341.47195-161-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

