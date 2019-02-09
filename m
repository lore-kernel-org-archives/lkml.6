Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C075E2192C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738182;
	bh=tUx12bVnbbLFkzoRzsrwPJiet+rJdOBuv99npxw6BM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QJuLl4pKzs9pU9CE1euweHj+UtouJodjYoQ+RFI4daIAmRkFq1kaBzWbsi4q4uSjJ
	 mW2i0XTZp3TuVQMJy8gnXtGTca9raqQE9GYz6uOin7ciYM2QVf9uh6sJy0SEPrqGMd
	 lcWa6ojvrz5YGwR4TYm3/jemhm4OM6IlEXcLk6s4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfBIStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfBIStf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A640C20821;
        Sat,  9 Feb 2019 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738174;
        bh=tUx12bVnbbLFkzoRzsrwPJiet+rJdOBuv99npxw6BM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6i64oH566YW1Q+GsvD8tr012zwoJbXY8CPv/YeuXRrO/oGaWgoOVasqj+9SqzrKY
         X8fbymK8hqDuEoOjJmA3vzavg/4UEzMfAiYU56tRwjxIwNPZAyOS7gBrSwv89wlLZE
         WB/hZgZMwg1a9Kmfw7GWdfiMLWm8pszcFeOypKUk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 04/16] drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
Date:   Sat,  9 Feb 2019 13:49:15 -0500
Message-Id: <20190209184927.126791-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184927.126791-1-sashal@kernel.org>
References: <20190209184927.126791-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit adf4109896bbee27fd2ac3b48d22d6a0062fe517 ]

DP1_SRCCTRL register and PHY_2LANE field did not have matching defines.
Add these.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-3-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 8636e7eeb731..e697c7c6ca52 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -140,6 +140,8 @@
 #define DP0_LTLOOPCTRL		0x06d8
 #define DP0_SNKLTCTRL		0x06e4
 
+#define DP1_SRCCTRL		0x07a0
+
 /* PHY */
 #define DP_PHY_CTRL		0x0800
 #define DP_PHY_RST			BIT(28)  /* DP PHY Global Soft Reset */
@@ -148,6 +150,7 @@
 #define PHY_M1_RST			BIT(12)  /* Reset PHY1 Main Channel */
 #define PHY_RDY				BIT(16)  /* PHY Main Channels Ready */
 #define PHY_M0_RST			BIT(8)   /* Reset PHY0 Main Channel */
+#define PHY_2LANE			BIT(2)   /* PHY Enable 2 lanes */
 #define PHY_A0_EN			BIT(1)   /* PHY Aux Channel0 Enable */
 #define PHY_M0_EN			BIT(0)   /* PHY Main Channel0 Enable */
 
@@ -562,7 +565,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 	tc_write(SYS_PLLPARAM, value);
 
-	tc_write(DP_PHY_CTRL, BGREN | PWR_SW_EN | BIT(2) | PHY_A0_EN);
+	tc_write(DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_2LANE | PHY_A0_EN);
 
 	/*
 	 * Initially PLLs are in bypass. Force PLL parameter update,
@@ -832,7 +835,7 @@ static int tc_main_link_setup(struct tc_data *tc)
 		 DP0_SRCCTRL_LANESKEW | DP0_SRCCTRL_LANES_2 |
 		 DP0_SRCCTRL_BW27 | DP0_SRCCTRL_AUTOCORRECT);
 	/* from excel file - DP1_SrcCtrl */
-	tc_write(0x07a0, 0x00003083);
+	tc_write(DP1_SRCCTRL, 0x00003083);
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
@@ -853,8 +856,9 @@ static int tc_main_link_setup(struct tc_data *tc)
 	}
 	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 	tc_write(SYS_PLLPARAM, value);
+
 	/* Setup Main Link */
-	dp_phy_ctrl = BGREN | PWR_SW_EN | BIT(2) | PHY_A0_EN |  PHY_M0_EN;
+	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_2LANE | PHY_A0_EN |  PHY_M0_EN;
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 	msleep(100);
 
-- 
2.19.1

