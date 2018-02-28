Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934621AbeB1Ryq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:54:46 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:39788 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeB1Ryo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:54:44 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/2] drm/sun4i: increase lvds dclk max divisor
Date: Wed, 28 Feb 2018 18:53:51 +0100
Message-Id: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment both min and max dclk div are set to 7.
This doesn't allow to have lower frequencies.

Increase dclk_max_div to 18 to achieve 30Mhz.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 029d2ce..bb35f41 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -278,7 +278,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	u32 reg, val = 0;
 
 	tcon->dclk_min_div = 7;
-	tcon->dclk_max_div = 7;
+	tcon->dclk_max_div = 18;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
-- 
2.7.4
