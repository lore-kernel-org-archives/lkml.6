Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CBC282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 00:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB020856
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 00:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfBCAGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 19:06:54 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:36180 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfBCAGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 19:06:54 -0500
Received: from gentoo.cpe.tdp.com (unknown [181.67.136.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: chrisadr)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 5B3E8335D95;
        Sun,  3 Feb 2019 00:06:46 +0000 (UTC)
From:   Christopher Diaz Riveros <chrisadr@gentoo.org>
To:     airlied@linux.ie, daniel@ffwll.ch, wens@csie.org
Cc:     Christopher Diaz Riveros <chrisadr@gentoo.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH-next] drm/sun4i: Use PTR_ERR_OR_ZERO in sun8i_phy_clk_create()
Date:   Sat,  2 Feb 2019 19:06:22 -0500
Message-Id: <20190203000622.30856-1-chrisadr@gentoo.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
index a4d31fe3abff..d52f581797f0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
@@ -171,8 +171,6 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
 	priv->hw.init = &init;
 
 	phy->clk_phy = devm_clk_register(dev, &priv->hw);
-	if (IS_ERR(phy->clk_phy))
-		return PTR_ERR(phy->clk_phy);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(phy->clk_phy);
 }
-- 
2.20.1

