Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55824C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262C62075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895375;
	bh=LbBO602P+1/SOa7ljn0z4kMdYKnm2GzcsSVEpdio3eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1Jp0OR27jGawjokE7NZrBFFh5Vogsask++sJfdbU/wzSwDMT+YGono/uP/Q3KukT
	 AMAreTgOI40NuyoyV0NKAHm7aZ8hgCjG7H/oKTOZxLzV9V5PA0IvwLLT+gylcGi0uv
	 Dz33bw6H887AZjHqVrYqWuqbsOwhL0bw84BZVZu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfBKO3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbfBKO3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1738B2075C;
        Mon, 11 Feb 2019 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895369;
        bh=LbBO602P+1/SOa7ljn0z4kMdYKnm2GzcsSVEpdio3eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03JYkLObJnVKS/JlZR0Ps5YUJIoekIE7kkAViq9ONoAdeU8O5vrrDRCU66IiPxjAT
         wurld0XnQgmz1l7mIYgKgTsbiJw2RFzudZTTlzvzPMW5WuSnC/oBzuoVrk56lSKnsp
         IgrgAXzp0uFXTSiTzFucman3yecvLfs8/2il9IFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 151/352] drm/msm/dsi: fix dsi clock names in DSI 10nm PLL driver
Date:   Mon, 11 Feb 2019 15:16:18 +0100
Message-Id: <20190211141856.290488145@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



