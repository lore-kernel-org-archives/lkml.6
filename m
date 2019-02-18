Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC77C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F228217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498374;
	bh=k0kS+lbmoOEvUDJCWLHxYWk3lPy6tFiRVOZfAgXSmYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KnaN4v07axOZU5uIAd3JUuR0n/hjk9SBaFn4qS7m7IyYFf8VoLKwvaxnSw0xT69IZ
	 qzC5swTlhmH2ksgWPPzrwxwH+EVZ7x4KZ+PgDQxqYdJWApRTdPRlWpxomyS6FnWQkF
	 A1czm0C95B9L4O41vZtFa7x5QToPEg0mjyhnxTgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbfBRN7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388573AbfBRN7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE5E2070D;
        Mon, 18 Feb 2019 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498369;
        bh=k0kS+lbmoOEvUDJCWLHxYWk3lPy6tFiRVOZfAgXSmYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jCHWcAcSsiR81r69cTt1cJOhWGfRy7wz/2R1/44cJQMWGls3oqbEP3UQgdi1hxZX
         A18r6cVLwh/FEcu7y2r2ftytziKOK2HQYwH5Rse2YoMNWewcJyGxGDDX11FX/XAzY6
         4cbrxQwZ+XNSBF5/DJV7pctiNrWRZbtgYcQ3Aqbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 25/58] drm/bridge: tc358767: fix single lane configuration
Date:   Mon, 18 Feb 2019 14:43:46 +0100
Message-Id: <20190218133510.525419877@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4d9d54a730434cc068dd3515ba6116697196f77b ]

PHY_2LANE bit is always set in DP_PHY_CTRL, breaking 1 lane use.

Set PHY_2LANE only when 2 lanes are used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-4-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index e67b163a8ce8..8098297c5fe5 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -541,6 +541,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	unsigned long rate;
 	u32 value;
 	int ret;
+	u32 dp_phy_ctrl;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
@@ -565,7 +566,10 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 	tc_write(SYS_PLLPARAM, value);
 
-	tc_write(DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_2LANE | PHY_A0_EN);
+	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN;
+	if (tc->link.base.num_lanes == 2)
+		dp_phy_ctrl |= PHY_2LANE;
+	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 
 	/*
 	 * Initially PLLs are in bypass. Force PLL parameter update,
@@ -858,7 +862,9 @@ static int tc_main_link_setup(struct tc_data *tc)
 	tc_write(SYS_PLLPARAM, value);
 
 	/* Setup Main Link */
-	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_2LANE | PHY_A0_EN |  PHY_M0_EN;
+	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN | PHY_M0_EN;
+	if (tc->link.base.num_lanes == 2)
+		dp_phy_ctrl |= PHY_2LANE;
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 	msleep(100);
 
-- 
2.19.1



