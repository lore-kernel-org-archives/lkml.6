Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeDWSFa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:05:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeDWSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:05:18 -0400
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "mfd: bd9571mwv: Add DDR Backup Power register bit definitions" to the regulator tree
In-Reply-To: <1507649178-31473-3-git-send-email-geert+renesas@glider.be>
Message-Id: <E1fAfpr-0004EG-QZ@debutante>
Date: Mon, 23 Apr 2018 19:05:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mfd: bd9571mwv: Add DDR Backup Power register bit definitions

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 2ff0dab80a8999e99a93fd70f8d701ec3deab207 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Apr 2018 15:18:02 +0200
Subject: [PATCH] mfd: bd9571mwv: Add DDR Backup Power register bit definitions

Add definitions for the KEEPON_* bits in the "BKUP Mode Cnt" register,
which control the DDR rails to be kept powered when backup mode is
enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mfd/bd9571mwv.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/bd9571mwv.h b/include/linux/mfd/bd9571mwv.h
index f0708ba4cbba..eb05569f752b 100644
--- a/include/linux/mfd/bd9571mwv.h
+++ b/include/linux/mfd/bd9571mwv.h
@@ -33,6 +33,11 @@
 #define BD9571MWV_I2C_MD2_E1_BIT_2		0x12
 
 #define BD9571MWV_BKUP_MODE_CNT			0x20
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK	GENMASK(3, 0)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR0	BIT(0)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR1	BIT(1)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR0C	BIT(2)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR1C	BIT(3)
 #define BD9571MWV_BKUP_MODE_STATUS		0x21
 #define BD9571MWV_BKUP_RECOVERY_CNT		0x22
 #define BD9571MWV_BKUP_CTRL_TIM_CNT		0x23
-- 
2.17.0
