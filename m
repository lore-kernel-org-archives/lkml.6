Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeCNQj6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:39:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40872 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeCNQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:39:57 -0400
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: evea: add switch for changing source of line-in" to the asoc tree
In-Reply-To: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
Message-Id: <20180314163950.001CB44007C@finisterre.ee.mobilebroadband>
Date: Wed, 14 Mar 2018 16:39:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: evea: add switch for changing source of line-in

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 90e0fb05e5c1b1cf6a59c4f888f500e2b1feffc4 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 14 Mar 2018 21:39:00 +0900
Subject: [PATCH] ASoC: uniphier: evea: add switch for changing source of
 line-in

This patch adds mixer switch for changing audio source of line-in.
We can choose one of LIN1, 2, 3, default is LIN1.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/evea.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index 439f14f91b23..73fd6730095c 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -18,6 +18,8 @@
 
 #define AADCPOW(n)                           (0x0078 + 0x04 * (n))
 #define   AADCPOW_AADC_POWD                   BIT(0)
+#define ALINSW1                              0x0088
+#define   ALINSW1_SEL1_SHIFT                  3
 #define AHPOUTPOW                            0x0098
 #define   AHPOUTPOW_HP_ON                     BIT(4)
 #define ALINEPOW                             0x009c
@@ -278,7 +280,16 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 	return evea_update_switch_hp(evea);
 }
 
+static const char * const linsw1_sel1_text[] = {
+	"LIN1", "LIN2", "LIN3"
+};
+
+static SOC_ENUM_SINGLE_DECL(linsw1_sel1_enum,
+	ALINSW1, ALINSW1_SEL1_SHIFT,
+	linsw1_sel1_text);
+
 static const struct snd_kcontrol_new evea_controls[] = {
+	SOC_ENUM("Line Capture Source", linsw1_sel1_enum),
 	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
 			    evea_get_switch_lin, evea_set_switch_lin),
 	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
-- 
2.16.2
