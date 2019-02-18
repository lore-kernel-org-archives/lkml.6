Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06FD20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498182;
	bh=N3YORAeTjpitFbr58bZ41zJFdXxu9o23+fEC6L5Y070=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uHuvDlSQS+58oRAJUsThOLd7uo+KnIm3SGtKwwKtTttTdVjLDNaj9HMQnc9SuKsb
	 7tK9SxTGGKjmnGOl8cud0S/JyMONtOQ2jrIiFYO3s6iFJQuGhfMgWjvULSkMWtNpgR
	 FvsYuTuPP/KIrGDJlxzt0OMbPcMMLt1byIL/iVs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfBRN4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbfBRN4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607642077B;
        Mon, 18 Feb 2019 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498176;
        bh=N3YORAeTjpitFbr58bZ41zJFdXxu9o23+fEC6L5Y070=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNshSJI3dij/OHUhfRxHvpQV/jLdBUxE54Pa+dINAdS3IRaSw2JHF6szoxAAb//Zf
         wkADpnb+qZqEgKQi111vDaVnpVYRub7lGBRdfx9TNd4/uPUZrFdPwyHYumpESNiVxs
         v61ALN1iXRUw9qfLLELjTUnAMxK+Xn8wIGtUBkRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/62] drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
Date:   Mon, 18 Feb 2019 14:43:33 +0100
Message-Id: <20190218133508.311207028@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



