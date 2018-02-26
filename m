Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBZCpu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:45:50 -0500
Received: from out20-15.mail.aliyun.com ([115.124.20.15]:46059 "EHLO
        out20-15.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeBZCpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:45:49 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2722042|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.B59llfC_1519613133;
From: Yong Deng <yong.deng@magewell.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Yong Deng <yong.deng@magewell.com>
Subject: [PATCH] ASoC: sun4i-i2s: Fix RX slot number of SUN8I
Date: Mon, 26 Feb 2018 10:43:52 +0800
Message-Id: <1519613032-10244-1-git-send-email-yong.deng@magewell.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S's RX slot number of SUN8I should be shifted 4 bit to left.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index dca1143c1150..a4aa931ebfae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -104,7 +104,7 @@
 
 #define SUN8I_I2S_CHAN_CFG_REG		0x30
 #define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK	GENMASK(6, 4)
-#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	(chan - 1)
+#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	((chan - 1) << 4)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK	GENMASK(2, 0)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(chan)	(chan - 1)
 
-- 
1.8.3.1
