Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeDRL6n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:58:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39160 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeDRL6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:58:40 -0400
From: Mark Brown <broonie@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Robin Gong <yibin.gong@nxp.com>, Mark Brown <broonie@kernel.org>,
        yibin.gong@nxp.com, shawnguo@kernel.org, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100: update voltage setting for pfuze3000 sw1a" to the regulator tree
In-Reply-To: <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com>
Message-Id: <E1f8ljG-0002hm-G4@debutante>
Date: Wed, 18 Apr 2018 12:58:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100: update voltage setting for pfuze3000 sw1a

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

>From 1dced996ee702e6af82a57c7b6c56b0cceaa6425 Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang@nxp.com>
Date: Sun, 18 Mar 2018 11:23:21 +0800
Subject: [PATCH] regulator: pfuze100: update voltage setting for pfuze3000
 sw1a

pfuze3000 datasheet(Rev.9.0) from:

https://www.nxp.com/docs/en/data-sheet/PF3000.pdf

updates sw1a's voltage range, the settings for 1.450V and 1.475V
are replaced with 1.8V and 3.3V:

5b'11110 1.450 (SW1B), 1.8 (SW1A/SW1AB)
5b'11111 1.475 (SW1B), 3.3 (SW1A/SW1AB)

the voltage calculation using steps is NOT available for sw1a now,
use voltage table instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 63922a2167e5..680f076e3d85 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -86,6 +86,13 @@ static const int pfuze100_coin[] = {
 	2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
 };
 
+static const int pfuze3000_sw1a[] = {
+	700000, 725000, 750000, 775000, 800000, 825000, 850000, 875000,
+	900000, 925000, 950000, 975000, 1000000, 1025000, 1050000, 1075000,
+	1100000, 1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000,
+	1300000, 1325000, 1350000, 1375000, 1400000, 1425000, 1800000, 3300000,
+};
+
 static const int pfuze3000_sw2lo[] = {
 	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000,
 };
@@ -343,7 +350,7 @@ static struct pfuze_regulator pfuze200_regulators[] = {
 };
 
 static struct pfuze_regulator pfuze3000_regulators[] = {
-	PFUZE100_SW_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 700000, 1475000, 25000),
+	PFUZE100_SWB_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
 	PFUZE100_SW_REG(PFUZE3000, SW1B, PFUZE100_SW1CVOL, 700000, 1475000, 25000),
 	PFUZE100_SWB_REG(PFUZE3000, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
 	PFUZE3000_SW3_REG(PFUZE3000, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
-- 
2.17.0
