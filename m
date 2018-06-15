Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 17523C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C04208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C04208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756163AbeFOLqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:46:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755850AbeFOLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:45:45 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.43.150]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0LqYDd-1g6zk81lir-00e91g; Fri, 15 Jun 2018 13:45:37 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH RFC 2/2] regulator: pfuze100: add pfuze3001 support
Date:   Fri, 15 Jun 2018 13:44:53 +0200
Message-Id: <1529063093-19582-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
References: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:7iNxQYdDyATmBYlWUGqqY9chOJh4qkTmkrykYmTpY5z6VBKfEXX
 vKxrlY1+6yd/rLdUlrAjp1V2NUHpOOQJReCaiHHcaizJEI/MYN0EUt8pXr3RJbH8HiXtPez
 d/hSKqDikkvUKSH+s9808szGF9AfuEe+EJpPGJ1zwnCjTS+shXmkCGcEZkm9I7erR0xhUdx
 43kosOqVAgnFeDCBXHkqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Eon4r6FIz28=:26lRKDr9OuBvwxx82o5bz0
 9Tlbwxe3dbk9FwUBB5LZeIg7NpAOQRh3y/DfBz7HcA1NSu+GCGcH4matiMK47EPFq09yYi6wE
 mtM1wPBRXbIbSPGoJgw6XdulDXOaOHiSF4sSvC4wOTwne47Ec3u3xVM4DqLQ2por2stRgj5RL
 lV5dXVG2T2TFI92WdAHEHKHvrtdlWAzbtrIeTIqO0CWynO6Em+QHwkblujTZaMwBl/H/dULz6
 HuP0UlCGJp0nKWPn1gsvc1zZNMoLTvwYzthXNUlKtVffLnvy/rybkbPc+3Pj4jpX/AMcjjBvN
 77EVhuw30DeJDqGwJuopezhYJgIb/THHF7RFPNT3LxUj41S9wFAtahcqHUlxYnqzNnKK7jDSX
 tGOk2vU+P16sWJ0E7PkrlYxjVWz/MpxcpCNUD6UciyCjY4ccHz5a7fpCG3Dj1mYKpYEC2HaAg
 EYfym8eA9a4lgVDuC7o7L+4AgzqfIzh065WVS5gXB96vZ72DGuAaeVZMShQLBWqgyVsP51PKs
 6Of8JFp3Tra1FPP6IPv6tAJZspGlR9rZ9uT+xhije7ov4zOtgoXGqrU/CoowoFGKJiJ9Zpc3U
 VVns03psV8Vz70dqVrLwmJSID9YXjfJtT6c6Th4c4puKQ5qK2EIONT1U59QzBbR4CaGACkRbq
 +34172X46YserbEL0viZnLzAK+JBiZz1M7rWuvzj66Un19UJtKX9LDHI1Xl1ZiApyMXM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the pfuze100 driver with pfuze3001 support.

Latest datasheet:
https://www.nxp.com/docs/en/data-sheet/PF3001.pdf

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/regulator/Kconfig              |  4 +-
 drivers/regulator/pfuze100-regulator.c | 78 +++++++++++++++++++++++++++++++---
 include/linux/regulator/pfuze100.h     | 11 +++++
 3 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5dbccf5..2964eaea 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -633,12 +633,12 @@ config REGULATOR_PCF50633
 	 on PCF50633
 
 config REGULATOR_PFUZE100
-	tristate "Freescale PFUZE100/200/3000 regulator driver"
+	tristate "Freescale PFUZE100/200/3000/3001 regulator driver"
 	depends on I2C
 	select REGMAP_I2C
 	help
 	  Say y here to support the regulators found on the Freescale
-	  PFUZE100/200/3000 PMIC.
+	  PFUZE100/200/3000/3001 PMIC.
 
 config REGULATOR_PV88060
 	tristate "Powerventure Semiconductor PV88060 regulator"
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 8d9dbcc..32f9af7 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -44,7 +44,7 @@
 #define PFUZE100_VGEN5VOL	0x70
 #define PFUZE100_VGEN6VOL	0x71
 
-enum chips { PFUZE100, PFUZE200, PFUZE3000 = 3 };
+enum chips { PFUZE100, PFUZE200, PFUZE3000 = 3, PFUZE3001 = 0x31, };
 
 struct pfuze_regulator {
 	struct regulator_desc desc;
@@ -92,6 +92,7 @@ static const struct i2c_device_id pfuze_device_id[] = {
 	{.name = "pfuze100", .driver_data = PFUZE100},
 	{.name = "pfuze200", .driver_data = PFUZE200},
 	{.name = "pfuze3000", .driver_data = PFUZE3000},
+	{.name = "pfuze3001", .driver_data = PFUZE3001},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pfuze_device_id);
@@ -100,6 +101,7 @@ static const struct of_device_id pfuze_dt_ids[] = {
 	{ .compatible = "fsl,pfuze100", .data = (void *)PFUZE100},
 	{ .compatible = "fsl,pfuze200", .data = (void *)PFUZE200},
 	{ .compatible = "fsl,pfuze3000", .data = (void *)PFUZE3000},
+	{ .compatible = "fsl,pfuze3001", .data = (void *)PFUZE3001},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pfuze_dt_ids);
@@ -108,10 +110,28 @@ static int pfuze100_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 {
 	struct pfuze_chip *pfuze100 = rdev_get_drvdata(rdev);
 	int id = rdev_get_id(rdev);
+	bool reg_has_ramp_delay;
 	unsigned int ramp_bits;
 	int ret;
 
-	if (id < PFUZE100_SWBST) {
+	switch (pfuze100->chip_id) {
+	case PFUZE3001:
+		/* no dynamic voltage scaling for PF3001 */
+		reg_has_ramp_delay = false;
+		break;
+	case PFUZE3000:
+		reg_has_ramp_delay = (id < PFUZE3000_SWBST);
+		break;
+	case PFUZE200:
+		reg_has_ramp_delay = (id < PFUZE200_SWBST);
+		break;
+	case PFUZE100:
+	default:
+		reg_has_ramp_delay = (id < PFUZE100_SWBST);
+		break;
+	}
+
+	if (reg_has_ramp_delay) {
 		ramp_delay = 12500 / ramp_delay;
 		ramp_bits = (ramp_delay >> 1) - (ramp_delay >> 3);
 		ret = regmap_update_bits(pfuze100->regmap,
@@ -119,8 +139,9 @@ static int pfuze100_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 					 0xc0, ramp_bits << 6);
 		if (ret < 0)
 			dev_err(pfuze100->dev, "ramp failed, err %d\n", ret);
-	} else
+	} else {
 		ret = -EACCES;
+	}
 
 	return ret;
 }
@@ -361,6 +382,19 @@ static struct pfuze_regulator pfuze3000_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE3000, VLDO4, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
 };
 
+static struct pfuze_regulator pfuze3001_regulators[] = {
+	PFUZE100_SWB_REG(PFUZE3001, SW1, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
+	PFUZE100_SWB_REG(PFUZE3001, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
+	PFUZE3000_SW3_REG(PFUZE3001, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
+	PFUZE100_SWB_REG(PFUZE3001, VSNVS, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
+	PFUZE100_VGEN_REG(PFUZE3001, VLDO1, PFUZE100_VGEN1VOL, 1800000, 3300000, 100000),
+	PFUZE100_VGEN_REG(PFUZE3001, VLDO2, PFUZE100_VGEN2VOL, 800000, 1550000, 50000),
+	PFUZE3000_VCC_REG(PFUZE3001, VCCSD, PFUZE100_VGEN3VOL, 2850000, 3300000, 150000),
+	PFUZE3000_VCC_REG(PFUZE3001, V33, PFUZE100_VGEN4VOL, 2850000, 3300000, 150000),
+	PFUZE100_VGEN_REG(PFUZE3001, VLDO3, PFUZE100_VGEN5VOL, 1800000, 3300000, 100000),
+	PFUZE100_VGEN_REG(PFUZE3001, VLDO4, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
+};
+
 #ifdef CONFIG_OF
 /* PFUZE100 */
 static struct of_regulator_match pfuze100_matches[] = {
@@ -418,6 +452,21 @@ static struct of_regulator_match pfuze3000_matches[] = {
 	{ .name = "vldo4",	},
 };
 
+/* PFUZE3001 */
+static struct of_regulator_match pfuze3001_matches[] = {
+
+	{ .name = "sw1",	},
+	{ .name = "sw2",	},
+	{ .name = "sw3",	},
+	{ .name = "vsnvs",	},
+	{ .name = "vldo1",	},
+	{ .name = "vldo2",	},
+	{ .name = "vccsd",	},
+	{ .name = "v33",	},
+	{ .name = "vldo3",	},
+	{ .name = "vldo4",	},
+};
+
 static struct of_regulator_match *pfuze_matches;
 
 static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
@@ -437,6 +486,11 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	}
 
 	switch (chip->chip_id) {
+	case PFUZE3001:
+		pfuze_matches = pfuze3001_matches;
+		ret = of_regulator_match(dev, parent, pfuze3001_matches,
+					 ARRAY_SIZE(pfuze3001_matches));
+		break;
 	case PFUZE3000:
 		pfuze_matches = pfuze3000_matches;
 		ret = of_regulator_match(dev, parent, pfuze3000_matches,
@@ -508,7 +562,8 @@ static int pfuze_identify(struct pfuze_chip *pfuze_chip)
 		 */
 		dev_info(pfuze_chip->dev, "Assuming misprogrammed ID=0x8");
 	} else if ((value & 0x0f) != pfuze_chip->chip_id &&
-		   (value & 0xf0) >> 4 != pfuze_chip->chip_id) {
+		   (value & 0xf0) >> 4 != pfuze_chip->chip_id &&
+		   (value != pfuze_chip->chip_id)) {
 		/* device id NOT match with your setting */
 		dev_warn(pfuze_chip->dev, "Illegal ID: %x\n", value);
 		return -ENODEV;
@@ -588,6 +643,13 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 
 	/* use the right regulators after identify the right device */
 	switch (pfuze_chip->chip_id) {
+	case PFUZE3001:
+		pfuze_chip->pfuze_regulators = pfuze3001_regulators;
+		regulator_num = ARRAY_SIZE(pfuze3001_regulators);
+		sw_check_start = PFUZE3001_SW2;
+		sw_check_end = PFUZE3001_SW2;
+		sw_hi = 1 << 3;
+		break;
 	case PFUZE3000:
 		pfuze_chip->pfuze_regulators = pfuze3000_regulators;
 		regulator_num = ARRAY_SIZE(pfuze3000_regulators);
@@ -611,7 +673,8 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 	}
 	dev_info(&client->dev, "pfuze%s found.\n",
 		(pfuze_chip->chip_id == PFUZE100) ? "100" :
-		((pfuze_chip->chip_id == PFUZE200) ? "200" : "3000"));
+		(((pfuze_chip->chip_id == PFUZE200) ? "200" :
+		((pfuze_chip->chip_id == PFUZE3000) ? "3000" : "3001"))));
 
 	memcpy(pfuze_chip->regulator_descs, pfuze_chip->pfuze_regulators,
 		sizeof(pfuze_chip->regulator_descs));
@@ -636,7 +699,8 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 		if (i >= sw_check_start && i <= sw_check_end) {
 			regmap_read(pfuze_chip->regmap, desc->vsel_reg, &val);
 			if (val & sw_hi) {
-				if (pfuze_chip->chip_id == PFUZE3000) {
+				if (pfuze_chip->chip_id == PFUZE3000 ||
+					pfuze_chip->chip_id == PFUZE3001) {
 					desc->volt_table = pfuze3000_sw2hi;
 					desc->n_voltages = ARRAY_SIZE(pfuze3000_sw2hi);
 				} else {
@@ -675,5 +739,5 @@ static struct i2c_driver pfuze_driver = {
 module_i2c_driver(pfuze_driver);
 
 MODULE_AUTHOR("Robin Gong <b38343@freescale.com>");
-MODULE_DESCRIPTION("Regulator Driver for Freescale PFUZE100/200/3000 PMIC");
+MODULE_DESCRIPTION("Regulator Driver for Freescale PFUZE100/200/3000/3001 PMIC");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regulator/pfuze100.h b/include/linux/regulator/pfuze100.h
index e0ccf46..cb5aecd 100644
--- a/include/linux/regulator/pfuze100.h
+++ b/include/linux/regulator/pfuze100.h
@@ -64,6 +64,17 @@
 #define PFUZE3000_VLDO3		11
 #define PFUZE3000_VLDO4		12
 
+#define PFUZE3001_SW1		0
+#define PFUZE3001_SW2		1
+#define PFUZE3001_SW3		2
+#define PFUZE3001_VSNVS		3
+#define PFUZE3001_VLDO1		4
+#define PFUZE3001_VLDO2		5
+#define PFUZE3001_VCCSD		6
+#define PFUZE3001_V33		7
+#define PFUZE3001_VLDO3		8
+#define PFUZE3001_VLDO4		9
+
 struct regulator_init_data;
 
 struct pfuze_regulator_platform_data {
-- 
2.7.4

