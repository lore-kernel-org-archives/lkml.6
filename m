Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F345AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44985214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44985214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJQJab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:30:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:9243 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbeJQJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:30:30 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 01/89-09191-74296CB5; Wed, 17 Oct 2018 01:37:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleJIrShJLcpLzFFi42IJ73Q4rOs26Vi
  0wZcjxhbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzVj4pIe9oHsuc8WjzX2MDYxbLjN1MXJxCAmsZZT4e+IESxcjJ5BTI
  dF5cRkTiM0rECHx59BxNhCbU8BMYv76yewQNaYSm9/tAouzCehIPJq5HqyeRUBVomnTKUYQW1
  jATmLWh4esILaIQJDE40dnWUCWMQvsZpT4cOEAM8QCQYmTM5+ALWYWkJA4+OIFM8QCLYlza1a
  BDZIQsJeY/v4qM4StL/Hy60YmCNtQ4vusbywQtrnEqk+n2SBsa4nrH2axTWAUmoVkxSwkKxYw
  Mq1itEgqykzPKMlNzMzRNTQw0DU0NNI1tDTTNTQx1kus0k3SSy3VLU8tLtE11EssL9YrrsxNz
  knRy0st2cQIjJWUgiP9OxifLU8/xCjJwaQkylvbdixaiC8pP6UyI7E4I76oNCe1+BCjDAeHkg
  TvowlAOcGi1PTUirTMHGDUwqQlOHiURHhP9AOleYsLEnOLM9MhUqcYjTnanl6fwczRASKFWPL
  y81KlxHm/gEwSACnNKM2DGwRLJpcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfMeBpnCk5lX
  ArfvFdApTECnuNseATmlJBEhJdXAGGnWF3xvuq7Nfv37D3NPzr6rFlwQ9OxMBjerlvWeiQfEB
  H0bd/54GmHrmXqgRJNZvfvakV1vHVdEfp5gN4tzc0JYih7fxJtHfv0r2R2xZpHsV934Yzfl61
  4FHbZcePyU/tXJwb/XGgdOqJv6TveP3pejfnv609QS0/8u+XCiQUWoLEfYYbNGnhJLcUaioRZ
  zUXEiADap8QwhAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-20.tower-288.messagelabs.com!1539740229!556224!4
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17716 invoked from network); 17 Oct 2018 01:37:10 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-20.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 17 Oct 2018 01:37:10 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 17 Oct 2018 03:37:08 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 27D545F800; Wed, 17 Oct 2018 10:37:07 +0900 (KST)
Message-ID: <700523007cc551de4c48b2b94a946357e27f5062.1539737877.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1539737877.git.Roy.Im@diasemi.com>
References: <cover.1539737877.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 17 Oct 2018 09:57:57 +0900
Subject: [RESEND PATCH V7 3/3] Input: new da7280 haptic driver
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16.10.2018 22:03:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
multiple mode and integrated waveform memory and wideband support.
It communicates via an I2C bus to the device.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v7: 
	- Added more attributes to handle one value per file.
	- Replaced and updated the dt-related code and functions called.
	- Fixed error/functions.
	- Rebased to v4.19-rc6.
v6: No changes.
v5: Fixed errors in Kconfig file.
v4: Updated code as dt-bindings are changed.
v3: No changes.
v2: Fixed kbuild error/warning


 drivers/input/misc/Kconfig  |   13 +
 drivers/input/misc/Makefile |    1 +
 drivers/input/misc/da7280.c | 1409 +++++++++++++++++++++++++++++++++++++++++++
 drivers/input/misc/da7280.h |  412 +++++++++++++
 4 files changed, 1835 insertions(+)
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2b..751cac6 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -851,4 +851,17 @@ config INPUT_SC27XX_VIBRA
 	  To compile this driver as a module, choose M here. The module will
 	  be called sc27xx_vibra.
 
+config INPUT_DA7280_HAPTICS
+	tristate "Dialog Semiconductor DA7280 haptics support"
+	depends on INPUT && I2C
+	select INPUT_FF_MEMLESS
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Dialog DA7280 haptics driver.
+	  The haptics can be controlled by i2c communication,
+	  or by PWM input, or by GPI.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called da7280.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 9d0f9d1..d941348 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
+obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
new file mode 100644
index 0000000..b1072ef
--- /dev/null
+++ b/drivers/input/misc/da7280.c
@@ -0,0 +1,1409 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DA7280 Haptic device driver
+ *
+ * Copyright (c) 2018 Dialog Semiconductor.
+ * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+#include "da7280.h"
+
+/* uV unit for voltage rate */
+#define DA7280_VOLTAGE_RATE_MAX		6000000
+#define DA7280_VOLTAGE_RATE_STEP	23400
+#define DA7280_NOMMAX_DFT		0x6B
+#define DA7280_ABSMAX_DFT		0x78
+
+#define DA7280_IMPD_MAX			1500000000
+#define DA7280_IMPD_DEFAULT		22000000
+
+#define DA7280_IMAX_DEFAULT		0x0E
+/* uA unit step and limit for IMAX*/
+#define DA7280_IMAX_STEP		7200
+#define DA7280_IMAX_LIMIT		252000
+
+#define DA7280_RESONT_FREQH_DFT		0x39
+#define DA7280_RESONT_FREQL_DFT		0x32
+#define DA7280_MIN_RESONAT_FREQ_HZ	50
+#define DA7280_MAX_RESONAT_FREQ_HZ	300
+#define DA7280_MIN_PWM_FREQ_KHZ		10
+#define DA7280_MAX_PWM_FREQ_KHZ		250
+
+#define DA7280_SEQ_ID_MAX		15
+#define DA7280_SEQ_LOOP_MAX		15
+#define DA7280_GPI1_SEQ_ID_DEFT	0x0
+
+#define DA7280_SNP_MEM_SIZE		100
+#define DA7280_SNP_MEM_MAX		DA7280_SNP_MEM_99
+
+#define IRQ_NUM				3
+
+#define DA7280_SKIP_INIT		0x100
+
+enum da7280_haptic_dev_t {
+	DA7280_LRA	= 0,
+	DA7280_ERM_BAR	= 1,
+	DA7280_ERM_COIN	= 2,
+	DA7280_DEV_MAX,
+};
+
+enum da7280_op_mode {
+	DA7280_INACTIVE		= 0,
+	DA7280_DRO_MODE		= 1,
+	DA7280_PWM_MODE		= 2,
+	DA7280_RTWM_MODE	= 3,
+	DA7280_ETWM_MODE	= 4,
+	DA7280_OPMODE_MAX,
+};
+
+struct da7280_gpi_ctl {
+	u8 seq_id;
+	u8 mode;
+	u8 polarity;
+};
+
+struct da7280_haptic {
+	struct regmap *regmap;
+	struct input_dev *input_dev;
+	struct device *dev;
+	struct i2c_client *client;
+	struct pwm_device *pwm_dev;
+	bool	legacy;
+	int pwm_id;
+	struct work_struct work;
+
+	unsigned int magnitude;
+
+	u8 dev_type;
+	u8 op_mode;
+	u16 nommax;
+	u16 absmax;
+	u32 imax;
+	u32 impd;
+	u32 resonant_freq_h;
+	u32 resonant_freq_l;
+	bool bemf_sense_en;
+	bool freq_track_en;
+	bool acc_en;
+	bool rapid_stop_en;
+	bool amp_pid_en;
+	u8 ps_seq_id;
+	u8 ps_seq_loop;
+	struct da7280_gpi_ctl gpi_ctl[3];
+	bool mem_update;
+	u8 snp_mem[DA7280_SNP_MEM_SIZE];
+	u8 enabled;
+};
+
+static bool da7280_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DA7280_IRQ_EVENT1:
+	case DA7280_IRQ_EVENT_WARNING_DIAG:
+	case DA7280_IRQ_EVENT_SEQ_DIAG:
+	case DA7280_IRQ_STATUS1:
+	case DA7280_TOP_CTL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config da7280_haptic_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = DA7280_SNP_MEM_MAX,
+	.volatile_reg = da7280_volatile_register,
+};
+
+static int da7280_haptic_mem_update(struct da7280_haptic *haptics)
+{
+	int error;
+	unsigned int val;
+
+	/* It is recommended to update the patterns
+	 * during haptic is not working in order to avoid conflict
+	 */
+	error = regmap_read(haptics->regmap, DA7280_IRQ_STATUS1, &val);
+	if (error)
+		return error;
+	if (val & DA7280_STA_WARNING_MASK) {
+		dev_warn(haptics->dev,
+			 "Warning! Please check HAPTIC status.\n");
+		return -EBUSY;
+	}
+
+	/* Patterns are not updated if the lock bit is enabled */
+	val = 0;
+	error = regmap_read(haptics->regmap, DA7280_MEM_CTL2, &val);
+	if (error)
+		return error;
+	if (~val & DA7280_WAV_MEM_LOCK_MASK) {
+		dev_warn(haptics->dev,
+			 "Please unlock the bit first\n");
+		return -EACCES;
+	}
+
+	/* Set to Inactive mode to make sure safety */
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK,
+				   0);
+	if (error)
+		return error;
+
+	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
+	if (error)
+		return error;
+
+	return regmap_bulk_write(haptics->regmap, val,
+			haptics->snp_mem, DA7280_SNP_MEM_MAX - val + 1);
+}
+
+static int da7280_haptic_set_pwm(struct da7280_haptic *haptics)
+{
+	struct pwm_args pargs;
+	u64 period_mag_multi;
+	unsigned int pwm_duty;
+	int error;
+
+	pwm_get_args(haptics->pwm_dev, &pargs);
+	period_mag_multi =
+		(u64)(pargs.period * haptics->magnitude);
+	if (haptics->acc_en)
+		pwm_duty =
+			(unsigned int)(period_mag_multi >> 16);
+	else
+		pwm_duty =
+			(unsigned int)((period_mag_multi >> 16)
+				+ pargs.period) / 2;
+
+	error = pwm_config(haptics->pwm_dev,
+			   pwm_duty, pargs.period);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to configure pwm : %d\n", error);
+		return error;
+	}
+
+	error = pwm_enable(haptics->pwm_dev);
+	if (error) {
+		pwm_disable(haptics->pwm_dev);
+		dev_err(haptics->dev,
+			"failed to enable haptics pwm device : %d\n", error);
+	}
+
+	return error;
+}
+
+static void da7280_haptic_enable(struct da7280_haptic *haptics)
+{
+	int error = 0;
+
+	if (haptics->enabled)
+		return;
+
+	switch (haptics->op_mode) {
+	case DA7280_DRO_MODE:
+		/* the valid range check when acc_en is enabled */
+		if (haptics->acc_en && haptics->magnitude > 0x7F)
+			haptics->magnitude = 0x7F;
+		else if (haptics->magnitude > 0xFF)
+			haptics->magnitude = 0xFF;
+
+		/* Set driver level
+		 * as a % of ACTUATOR_NOMMAX(nommax)
+		 */
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2,
+				     haptics->magnitude);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for driving level set : %d\n",
+				error);
+			return;
+		}
+		break;
+	case DA7280_PWM_MODE:
+		if (da7280_haptic_set_pwm(haptics))
+			return;
+		break;
+	case DA7280_RTWM_MODE:
+		/* PS_SEQ_ID will be played
+		 * as many times as the PS_SEQ_LOOP
+		 */
+	case DA7280_ETWM_MODE:
+		/* Now users are able to control the GPI(N)
+		 * assigned to GPI_0, GPI1 and GPI2 accordingly
+		 * please see the datasheet for details.
+		 * GPI(N)_SEQUENCE_ID will be played
+		 * as many times as the PS_SEQ_LOOP
+		 */
+		break;
+	default:
+		dev_err(haptics->dev,
+			"Invalid Mode(%d)\n", haptics->op_mode);
+		return;
+	}
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK,
+				   haptics->op_mode);
+	if (error) {
+		dev_err(haptics->dev,
+			"i2c err for op_mode setting : %d\n", error);
+		return;
+	}
+
+	if (haptics->op_mode == DA7280_PWM_MODE ||
+	    haptics->op_mode == DA7280_RTWM_MODE) {
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CTL1,
+					   DA7280_SEQ_START_MASK,
+					   DA7280_SEQ_START_MASK);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for sequence triggering : %d\n",
+				error);
+			return;
+		}
+	}
+
+	haptics->enabled = true;
+}
+
+static void da7280_haptic_disable(struct da7280_haptic *haptics)
+{
+	int error;
+
+	if (!haptics->enabled)
+		return;
+
+	/* Set to Inactive mode */
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK, 0);
+	if (error) {
+		dev_err(haptics->dev,
+			"i2c err for op_mode off : %d\n", error);
+		return;
+	}
+
+	switch (haptics->op_mode) {
+	case DA7280_RTWM_MODE:
+	case DA7280_ETWM_MODE:
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CTL1,
+					   DA7280_SEQ_START_MASK, 0);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for RTWM or ETWM mode off : %d\n",
+				error);
+			return;
+		}
+		break;
+	case DA7280_DRO_MODE:
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2, 0);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for DRO mode off : %d\n",
+				error);
+			return;
+		}
+		break;
+	case DA7280_PWM_MODE:
+		pwm_disable(haptics->pwm_dev);
+		break;
+	default:
+		dev_err(haptics->dev,
+			"Invalid Mode(%d)\n", haptics->op_mode);
+		break;
+	}
+
+	if (haptics->op_mode < DA7280_OPMODE_MAX)
+		haptics->enabled = false;
+}
+
+static void da7280_haptic_work(struct work_struct *work)
+{
+	struct da7280_haptic *haptics =
+			container_of(work, struct da7280_haptic, work);
+
+	if (haptics->magnitude)
+		da7280_haptic_enable(haptics);
+	else
+		da7280_haptic_disable(haptics);
+}
+
+static int da7280_haptic_play(struct input_dev *dev, void *data,
+			      struct ff_effect *effect)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+
+	if (effect->u.rumble.strong_magnitude > 0)
+		haptics->magnitude = effect->u.rumble.strong_magnitude;
+	else if (effect->u.rumble.weak_magnitude > 0)
+		haptics->magnitude = effect->u.rumble.weak_magnitude;
+	else
+		haptics->magnitude = 0;
+
+	schedule_work(&haptics->work);
+
+	return 0;
+}
+
+static int da7280_haptic_open(struct input_dev *dev)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	int error;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK,
+				   DA7280_STANDBY_EN_MASK);
+	if (error)
+		dev_err(haptics->dev,
+			"Failed to open haptic, i2c error : %d\n", error);
+
+	return error;
+}
+
+static void da7280_haptic_close(struct input_dev *dev)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	int error;
+
+	cancel_work_sync(&haptics->work);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK, 0);
+	if (error)
+		goto error_i2c;
+
+	if (haptics->op_mode == DA7280_DRO_MODE) {
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2, 0);
+
+		if (error)
+			goto error_i2c;
+	}
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK, 0);
+	if (error)
+		goto error_i2c;
+
+	return;
+
+error_i2c:
+	dev_err(haptics->dev, "DA7280-haptic i2c error : %d\n", error);
+}
+
+static u8 da7280_haptic_of_mode_str(struct device *dev,
+				    const char *str)
+{
+	if (!strcmp(str, "LRA"))
+		return DA7280_LRA;
+	else if (!strcmp(str, "ERM-bar"))
+		return DA7280_ERM_BAR;
+	else if (!strcmp(str, "ERM-coin"))
+		return DA7280_ERM_COIN;
+
+	dev_warn(dev, "Invalid string - set to default\n");
+	return DA7280_LRA;
+}
+
+static u8 da7280_haptic_of_gpi_mode_str(struct device *dev,
+					const char *str)
+{
+	if (!strcmp(str, "Single-pattern"))
+		return 0;
+	else if (!strcmp(str, "Multi-pattern"))
+		return 1;
+
+	dev_warn(dev, "Invalid string - set to default\n");
+	return 0;
+}
+
+static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
+				       const char *str)
+{
+	if (!strcmp(str, "Rising-edge"))
+		return 0;
+	else if (!strcmp(str, "Falling-edge"))
+		return 1;
+	else if (!strcmp(str, "Both-edge"))
+		return 2;
+
+	dev_warn(dev, "Invalid string - set to default\n");
+	return 0;
+}
+
+static u8 da7280_haptic_of_volt_rating_set(u32 val)
+{
+	u32 voltage;
+
+	voltage = val / DA7280_VOLTAGE_RATE_STEP + 1;
+
+	if (voltage > 0xFF)
+		return 0xFF;
+	return (u8)voltage;
+}
+
+static void da7280_parse_properties(struct device *dev,
+				    struct da7280_haptic *haptics)
+{
+	char gpi_str1[] = "dlg,gpi0-seq-id";
+	char gpi_str2[] = "dlg,gpi0-mode";
+	char gpi_str3[] = "dlg,gpi0-polarity";
+	unsigned int i, mem[DA7280_SNP_MEM_SIZE];
+	const char *str;
+	u32 val;
+
+	if (!device_property_read_string(dev, "dlg,actuator-type", &str))
+		haptics->dev_type =
+			da7280_haptic_of_mode_str(dev, str);
+	else /* if no property, then use the mode inside chip */
+		haptics->dev_type = DA7280_DEV_MAX;
+
+	if (device_property_read_u32(dev, "dlg,op-mode", &val) >= 0)
+		if (val > 0 && val < DA7280_OPMODE_MAX)
+			haptics->op_mode = val;
+		else
+			haptics->op_mode = DA7280_DRO_MODE;
+	else
+		haptics->op_mode = DA7280_DRO_MODE;
+
+	if (device_property_read_u32(dev, "dlg,nom-microvolt", &val) >= 0)
+		if (val < DA7280_VOLTAGE_RATE_MAX)
+			haptics->nommax =
+				da7280_haptic_of_volt_rating_set(val);
+		else
+			haptics->nommax = DA7280_SKIP_INIT;
+	else /* if no property, then use the value inside chip */
+		haptics->nommax = DA7280_SKIP_INIT;
+
+	if (device_property_read_u32(dev, "dlg,abs-max-microvolt",
+				     &val) >= 0)
+		if (val < DA7280_VOLTAGE_RATE_MAX)
+			haptics->absmax =
+				da7280_haptic_of_volt_rating_set(val);
+		else
+			haptics->absmax = DA7280_SKIP_INIT;
+	else
+		haptics->absmax = DA7280_SKIP_INIT;
+
+	if (device_property_read_u32(dev, "dlg,imax-microamp", &val) >= 0)
+		if (val < DA7280_IMAX_LIMIT)
+			haptics->imax = (val - 28600)
+					/ DA7280_IMAX_STEP + 1;
+		else
+			haptics->imax = DA7280_IMAX_DEFAULT;
+	else
+		haptics->imax = DA7280_IMAX_DEFAULT;
+
+	if (device_property_read_u32(dev, "dlg,impd-micro-ohms", &val) >= 0)
+		if (val <= DA7280_IMPD_MAX)
+			haptics->impd = val;
+		else
+			haptics->impd = DA7280_IMPD_DEFAULT;
+	else
+		haptics->impd = DA7280_IMPD_DEFAULT;
+
+	if (device_property_read_u32(dev, "dlg,resonant-freq-hz",
+				     &val) >= 0) {
+		if (val < DA7280_MAX_RESONAT_FREQ_HZ &&
+		    val > DA7280_MIN_RESONAT_FREQ_HZ) {
+			haptics->resonant_freq_h =
+				((1000000000 / (val * 1333)) >> 7) & 0xFF;
+			haptics->resonant_freq_l =
+				(1000000000 / (val * 1333)) & 0x7F;
+		} else {
+			haptics->resonant_freq_h =
+				DA7280_RESONT_FREQH_DFT;
+			haptics->resonant_freq_l =
+				DA7280_RESONT_FREQL_DFT;
+		}
+	} else {
+		haptics->resonant_freq_h = DA7280_SKIP_INIT;
+		haptics->resonant_freq_l = DA7280_SKIP_INIT;
+	}
+
+	if (device_property_read_u32(dev, "dlg,ps-seq-id", &val) >= 0)
+		if (val <= DA7280_SEQ_ID_MAX)
+			haptics->ps_seq_id = val;
+		else
+			haptics->ps_seq_id = 0;
+	else /* if no property, set to zero as a default do nothing */
+		haptics->ps_seq_id = 0;
+
+	if (device_property_read_u32(dev, "dlg,ps-seq-loop", &val) >= 0)
+		if (val <= DA7280_SEQ_LOOP_MAX)
+			haptics->ps_seq_loop = val;
+		else
+			haptics->ps_seq_loop = 0;
+	else /* if no property, then do nothing */
+		haptics->ps_seq_loop = 0;
+
+	/* GPI0~2 Control */
+	for (i = 0; i < 3; i++) {
+		gpi_str1[7] = '0' + i;
+		if (device_property_read_u32 (dev, gpi_str1, &val) >= 0)
+			if (val <= DA7280_SEQ_ID_MAX)
+				haptics->gpi_ctl[i].seq_id = val;
+			else
+				haptics->gpi_ctl[i].seq_id =
+					DA7280_GPI1_SEQ_ID_DEFT + i;
+		else /* if no property, then do nothing */
+			haptics->gpi_ctl[i].seq_id =
+				DA7280_GPI1_SEQ_ID_DEFT + i;
+
+		gpi_str2[7] = '0' + i;
+		if (!device_property_read_string(dev, gpi_str2, &str))
+			haptics->gpi_ctl[i].mode =
+				da7280_haptic_of_gpi_mode_str(dev, str);
+		else
+			haptics->gpi_ctl[i].mode = 0;
+
+		gpi_str3[7] = '0' + i;
+		if (!device_property_read_string(dev, gpi_str3, &str))
+			haptics->gpi_ctl[i].polarity =
+				da7280_haptic_of_gpi_pol_str(dev, str);
+		else
+			haptics->gpi_ctl[i].polarity = 0;
+	}
+
+	haptics->bemf_sense_en =
+		device_property_read_bool(dev, "dlg,bemf-sens-enable");
+	haptics->freq_track_en =
+		device_property_read_bool(dev, "dlg,freq-track-enable");
+	haptics->acc_en =
+		device_property_read_bool(dev, "dlg,acc-enable");
+	haptics->rapid_stop_en =
+		device_property_read_bool(dev, "dlg,rapid-stop-enable");
+	haptics->amp_pid_en =
+		device_property_read_bool(dev, "dlg,amp-pid-enable");
+
+	if (device_property_read_u32_array(dev, "dlg,mem-array",
+					   &mem[0],
+					   DA7280_SNP_MEM_SIZE) >= 0) {
+		haptics->mem_update = true;
+		for (i = 0; i < DA7280_SNP_MEM_SIZE; i++) {
+			if (mem[i] > 0xff)
+				haptics->snp_mem[i] = 0x0;
+			else
+				haptics->snp_mem[i] = (u8)mem[i];
+		}
+	} else {
+		haptics->mem_update = false;
+	}
+}
+
+static irqreturn_t da7280_irq_handler(int irq, void *data)
+{
+	struct da7280_haptic *haptics = data;
+	u8 events[IRQ_NUM];
+	int error;
+
+	/* Check what events have happened */
+	error = regmap_bulk_read(haptics->regmap,
+				 DA7280_IRQ_EVENT1,
+				 events, IRQ_NUM);
+	if (error)
+		goto error_i2c;
+
+	/* Empty check due to shared interrupt */
+	if ((events[0] | events[1] | events[2]) == 0x00)
+		return IRQ_HANDLED;
+
+	if (events[0] & DA7280_E_SEQ_FAULT_MASK) {
+		/* Stop first if Haptic is working
+		 * Otherwise, the fault may happen continually
+		 * even though the bit is cleared.
+		 */
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CTL1,
+					   DA7280_OPERATION_MODE_MASK, 0);
+		if (error)
+			goto error_i2c;
+	}
+
+	/* Clear events */
+	error = regmap_write(haptics->regmap,
+			     DA7280_IRQ_EVENT1, events[0]);
+	if (error)
+		goto error_i2c;
+
+	return IRQ_HANDLED;
+
+error_i2c:
+	dev_err(haptics->dev, "da7280 i2c error : %d\n", error);
+	return IRQ_NONE;
+}
+
+static int da7280_init(struct da7280_haptic *haptics)
+{
+	int error, i;
+	unsigned int val = 0;
+	u32 v2i_factor;
+	u8 mask = 0;
+
+	/* If device type is DA7280_DEV_MAX,
+	 * then just use default value inside chip.
+	 */
+	if (haptics->dev_type == DA7280_DEV_MAX) {
+		error = regmap_read(haptics->regmap, DA7280_TOP_CFG1, &val);
+		if (error)
+			goto error_i2c;
+		if (val & DA7280_ACTUATOR_TYPE_MASK)
+			haptics->dev_type = DA7280_ERM_COIN;
+		else
+			haptics->dev_type = DA7280_LRA;
+	}
+
+	/* Apply user settings */
+	if (haptics->dev_type == DA7280_LRA) {
+		if (haptics->resonant_freq_l != DA7280_SKIP_INIT) {
+			error = regmap_write(haptics->regmap,
+					     DA7280_FRQ_LRA_PER_H,
+					     haptics->resonant_freq_h);
+			if (error)
+				goto error_i2c;
+			error = regmap_write(haptics->regmap,
+					     DA7280_FRQ_LRA_PER_L,
+					     haptics->resonant_freq_l);
+			if (error)
+				goto error_i2c;
+		}
+	} else if (haptics->dev_type == DA7280_ERM_COIN) {
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_INT_CFG1,
+					   DA7280_BEMF_FAULT_LIM_MASK, 0);
+		if (error)
+			goto error_i2c;
+
+		mask = DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
+			DA7280_V2I_FACTOR_FREEZE_MASK;
+		val = DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
+			DA7280_V2I_FACTOR_FREEZE_MASK;
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CFG4,
+					   mask, val);
+		if (error)
+			goto error_i2c;
+
+		haptics->acc_en = false;
+		haptics->rapid_stop_en = false;
+		haptics->amp_pid_en = false;
+	}
+
+	/* Should be set to 0 only
+	 * in custom waveform and wideband operation
+	 */
+	if (haptics->op_mode >= DA7280_RTWM_MODE)
+		haptics->bemf_sense_en = false;
+
+	mask = DA7280_ACTUATOR_TYPE_MASK |
+			DA7280_BEMF_SENSE_EN_MASK |
+			DA7280_FREQ_TRACK_EN_MASK |
+			DA7280_ACCELERATION_EN_MASK |
+			DA7280_RAPID_STOP_EN_MASK |
+			DA7280_AMP_PID_EN_MASK;
+
+	val = (haptics->dev_type ? 1 : 0)
+			<< DA7280_ACTUATOR_TYPE_SHIFT |
+		(haptics->bemf_sense_en ? 1 : 0)
+			<< DA7280_BEMF_SENSE_EN_SHIFT |
+		(haptics->freq_track_en ? 1 : 0)
+			<< DA7280_FREQ_TRACK_EN_SHIFT |
+		(haptics->acc_en ? 1 : 0)
+			<< DA7280_ACCELERATION_EN_SHIFT |
+		(haptics->rapid_stop_en ? 1 : 0)
+			<< DA7280_RAPID_STOP_EN_SHIFT |
+		(haptics->amp_pid_en ? 1 : 0)
+			<< DA7280_AMP_PID_EN_SHIFT;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CFG1, mask, val);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CFG5,
+				   DA7280_V2I_FACTOR_OFFSET_EN_MASK,
+				   haptics->acc_en ?
+				   DA7280_V2I_FACTOR_OFFSET_EN_MASK : 0);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CFG2,
+				   DA7280_MEM_DATA_SIGNED_MASK,
+				   haptics->acc_en ?
+				   0 : DA7280_MEM_DATA_SIGNED_MASK);
+	if (error)
+		goto error_i2c;
+
+	if (haptics->nommax != DA7280_SKIP_INIT) {
+		error = regmap_write(haptics->regmap,
+				     DA7280_ACTUATOR1,
+				     haptics->nommax);
+		if (error)
+			goto error_i2c;
+	}
+
+	if (haptics->absmax != DA7280_SKIP_INIT) {
+		error = regmap_write(haptics->regmap, DA7280_ACTUATOR2,
+				     haptics->absmax);
+		if (error)
+			goto error_i2c;
+	}
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_ACTUATOR3,
+				   DA7280_IMAX_MASK,
+				   haptics->imax);
+	if (error)
+		goto error_i2c;
+
+	v2i_factor =
+		haptics->impd * (haptics->imax + 4) / 1610400;
+	error = regmap_write(haptics->regmap,
+			     DA7280_CALIB_V2I_L,
+			     v2i_factor & 0xff);
+	if (error)
+		goto error_i2c;
+	error = regmap_write(haptics->regmap,
+			     DA7280_CALIB_V2I_H,
+			     v2i_factor >> 8);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK,
+				   DA7280_STANDBY_EN_MASK);
+	if (error)
+		goto error_i2c;
+
+	if (haptics->mem_update) {
+		error = da7280_haptic_mem_update(haptics);
+		if (error)
+			goto error_i2c;
+	}
+
+	/* Set  PS_SEQ_ID and PS_SEQ_LOOP */
+	val = haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
+		haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
+	error = regmap_write(haptics->regmap,
+			     DA7280_SEQ_CTL2, val);
+	if (error)
+		goto error_i2c;
+
+	/* GPI(N) CTL */
+	for (i = 0; i < 3; i++) {
+		val = haptics->gpi_ctl[i].seq_id
+				<< DA7280_GPI0_SEQUENCE_ID_SHIFT |
+			haptics->gpi_ctl[i].mode
+				<< DA7280_GPI0_MODE_SHIFT |
+			haptics->gpi_ctl[i].polarity
+				<< DA7280_GPI0_POLARITY_SHIFT;
+		error = regmap_write(haptics->regmap,
+				     DA7280_GPI_0_CTL + i, val);
+		if (error)
+			goto error_i2c;
+	}
+
+	/* Clear Interrupts */
+	error = regmap_write(haptics->regmap, DA7280_IRQ_EVENT1, 0xff);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_IRQ_MASK1,
+				   DA7280_SEQ_FAULT_M_MASK
+				   | DA7280_SEQ_DONE_M_MASK, 0);
+	if (error)
+		goto error_i2c;
+
+	haptics->enabled = false;
+	return 0;
+
+error_i2c:
+	dev_err(haptics->dev, "haptic init - I2C error : %d\n", error);
+	return error;
+}
+
+/* Valid format for ps_seq_id
+ * echo X > ps_seq_id
+ * ex) echo 2 > /sys/class/..../ps_seq_id
+ * 0 <= X <= 15.
+ */
+static ssize_t ps_seq_id_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_SEQ_CTL2,
+				   DA7280_PS_SEQ_ID_MASK,
+				   (val & 0xf) >> DA7280_PS_SEQ_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %d\n", error);
+		return error;
+	}
+
+	haptics->ps_seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t ps_seq_id_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %d\n", error);
+		return error;
+	}
+	val = (val & DA7280_PS_SEQ_ID_MASK)
+		>> DA7280_PS_SEQ_ID_SHIFT;
+
+	return sprintf(buf, "ps_seq_id is %d\n", val);
+}
+
+/* Valid format for ps_seq_loop
+ * echo X > ps_seq_loop
+ * ex) echo 2 > /sys/class/..../ps_seq_loop
+ * 0 <= X <= 15.
+ */
+static ssize_t ps_seq_loop_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_SEQ_CTL2,
+				   DA7280_PS_SEQ_LOOP_MASK,
+				   (val & 0xF) << DA7280_PS_SEQ_LOOP_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %d\n", error);
+		return error;
+	}
+
+	haptics->ps_seq_loop = (val & 0xF);
+
+	return count;
+err:
+	dev_err(dev, "Invalid input value!\n");
+	return count;
+}
+
+static ssize_t ps_seq_loop_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %d\n", error);
+		return error;
+	}
+	val = (val & DA7280_PS_SEQ_LOOP_MASK)
+				>> DA7280_PS_SEQ_LOOP_SHIFT;
+
+	return sprintf(buf, "ps_seq_loop is %d\n", val);
+}
+
+/* Valid format for GPIx_SEQUENCE_ID
+ * echo X > ./gpi_seq_id0
+ * Range of X: 0 <= X <= 15
+ * ex)
+ *	echo 1 > /sys/class/..../gpi_seq_id0
+ *	echo 2 > /sys/class/..../gpi_seq_id1
+ *	echo 3 > /sys/class/..../gpi_seq_id2
+ */
+static ssize_t gpi_seq_id0_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_GPI_0_CTL,
+				   DA7280_GPI0_SEQUENCE_ID_MASK,
+				   (val & 0xf)
+				   << DA7280_GPI0_SEQUENCE_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %d\n", error);
+		return error;
+	}
+
+	haptics->gpi_ctl[0].seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t gpi_seq_id0_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_GPI_0_CTL, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %d\n", error);
+		return error;
+	}
+	val = (val & DA7280_GPI0_SEQUENCE_ID_MASK)
+		>> DA7280_GPI0_SEQUENCE_ID_SHIFT;
+
+	return sprintf(buf, "gpi_seq_id0 is %d\n", val);
+}
+
+static ssize_t gpi_seq_id1_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_GPI_1_CTL,
+				   DA7280_GPI1_SEQUENCE_ID_MASK,
+				   (val & 0xf)
+				   << DA7280_GPI1_SEQUENCE_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %d\n", error);
+		return error;
+	}
+
+	haptics->gpi_ctl[1].seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t gpi_seq_id1_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_GPI_1_CTL, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %d\n", error);
+		return error;
+	}
+	val = (val & DA7280_GPI1_SEQUENCE_ID_MASK)
+		>> DA7280_GPI1_SEQUENCE_ID_SHIFT;
+
+	return sprintf(buf, "gpi_seq_id1 is %d\n", val);
+}
+
+static ssize_t gpi_seq_id2_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_GPI_2_CTL,
+				   DA7280_GPI2_SEQUENCE_ID_MASK,
+				   (val & 0xf)
+				   << DA7280_GPI2_SEQUENCE_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %d\n", error);
+		return error;
+	}
+
+	haptics->gpi_ctl[2].seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t gpi_seq_id2_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_GPI_2_CTL, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %d\n", error);
+		return error;
+	}
+	val = (val & DA7280_GPI2_SEQUENCE_ID_MASK)
+		>> DA7280_GPI2_SEQUENCE_ID_SHIFT;
+
+	return sprintf(buf, "gpi_seq_id2 is %d\n", val);
+}
+
+#define MAX_PTN_REGS DA7280_SNP_MEM_SIZE
+#define MAX_USER_INPUT_LEN (5 * DA7280_SNP_MEM_SIZE)
+struct parse_data_t {
+	int len;
+	u8 val[MAX_PTN_REGS];
+};
+
+static int da7280_parse_args(struct device *dev,
+			     char *cmd, struct parse_data_t *ptn)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	char *tok;		/* used to separate tokens */
+	const char ct[] = " \t"; /* space or tab delimits the tokens */
+	int tok_count = 0;	/* total number of tokens parsed */
+	int i = 0, val;
+
+	ptn->len = 0;
+
+	/* parse the input string */
+	while ((tok = strsep(&cmd, ct)) != NULL) {
+		/* this is a value to be written to the register */
+		if (kstrtouint(tok, 0, &val) < 0) {
+			dev_err(haptics->dev,
+				"failed to read from %s\n", tok);
+			break;
+		}
+
+		if (i < MAX_PTN_REGS) {
+			ptn->val[i] = val;
+			i++;
+		}
+		tok_count++;
+	}
+
+	/* decide whether it is a read or write operation based on the
+	 * value of tok_count and count_flag.
+	 * tok_count = 0: no inputs, invalid case.
+	 * tok_count = 1: write one value.
+	 * tok_count > 1: write multiple values/patterns.
+	 */
+	switch (tok_count) {
+	case 0:
+		return -EINVAL;
+	case 1:
+		ptn->len = 1;
+		break;
+	default:
+		ptn->len = i;
+	}
+	return 0;
+}
+
+static ssize_t
+patterns_store(struct device *dev,
+	       struct device_attribute *attr,
+	       const char *buf,
+	       size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	struct parse_data_t mem;
+	char cmd[MAX_USER_INPUT_LEN];
+	unsigned int val;
+	int error;
+
+	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
+	if (error)
+		return error;
+
+	if (count > MAX_USER_INPUT_LEN)
+		memcpy(cmd, buf, MAX_USER_INPUT_LEN);
+	else
+		memcpy(cmd, buf, count);
+
+	/* chop of '\n' introduced by echo at the end of the input */
+	if (cmd[count - 1] == '\n')
+		cmd[count - 1] = '\0';
+
+	if (da7280_parse_args(dev, cmd, &mem) < 0)
+		return -EINVAL;
+
+	memcpy(haptics->snp_mem, mem.val, mem.len);
+
+	error = da7280_haptic_mem_update(haptics);
+	if (error)
+		return error;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(ps_seq_id);
+static DEVICE_ATTR_RW(ps_seq_loop);
+static DEVICE_ATTR_RW(gpi_seq_id0);
+static DEVICE_ATTR_RW(gpi_seq_id1);
+static DEVICE_ATTR_RW(gpi_seq_id2);
+static DEVICE_ATTR_WO(patterns);
+static struct attribute *da7280_sysfs_attr[] = {
+	&dev_attr_ps_seq_id.attr,
+	&dev_attr_ps_seq_loop.attr,
+	&dev_attr_gpi_seq_id0.attr,
+	&dev_attr_gpi_seq_id1.attr,
+	&dev_attr_gpi_seq_id2.attr,
+	&dev_attr_patterns.attr,
+	NULL,
+};
+
+static const struct attribute_group da7280_attr_group = {
+	.attrs = da7280_sysfs_attr,
+};
+
+static int da7280_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct da7280_haptic *haptics;
+	unsigned int period2freq;
+	int error;
+
+	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
+	if (!haptics)
+		return -ENOMEM;
+	haptics->dev = dev;
+
+	if (!client->irq) {
+		dev_err(dev, "No IRQ configured\n");
+		return -EINVAL;
+	}
+
+	da7280_parse_properties(&client->dev, haptics);
+
+	if (haptics->op_mode == DA7280_PWM_MODE) {
+		/* Get pwm and regulatot for haptics device */
+		haptics->pwm_dev = devm_pwm_get(&client->dev, NULL);
+		if (IS_ERR(haptics->pwm_dev)) {
+			dev_err(dev, "failed to get PWM device\n");
+			return PTR_ERR(haptics->pwm_dev);
+		}
+
+		/*
+		 * FIXME: pwm_apply_args() should be removed when switching to
+		 * the atomic PWM API.
+		 */
+		pwm_apply_args(haptics->pwm_dev);
+
+		/* Check PWM Period, it must be in 10k ~ 250kHz */
+		period2freq = 1000000 / pwm_get_period(haptics->pwm_dev);
+		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
+		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
+			dev_err(dev, "Not supported PWM frequency(%d)\n",
+				period2freq);
+			return -EINVAL;
+		}
+	}
+
+	INIT_WORK(&haptics->work, da7280_haptic_work);
+	haptics->client = client;
+	i2c_set_clientdata(client, haptics);
+
+	haptics->regmap =
+		devm_regmap_init_i2c(client, &da7280_haptic_regmap_config);
+	if (IS_ERR(haptics->regmap)) {
+		error = PTR_ERR(haptics->regmap);
+		dev_err(dev, "Failed to allocate register map : %d\n",
+			error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, client->irq, NULL,
+					  da7280_irq_handler,
+					  IRQF_ONESHOT,
+					  "da7280-haptics", haptics);
+	if (error != 0) {
+		dev_err(dev,
+			"Failed to request IRQ : %d\n", client->irq);
+		return error;
+	}
+
+	error = da7280_init(haptics);
+	if (error) {
+		dev_err(dev, "failed to initialize device\n");
+		return error;
+	}
+
+	/* Initialize input device for haptic device */
+	haptics->input_dev = devm_input_allocate_device(dev);
+	if (!haptics->input_dev) {
+		dev_err(dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	haptics->input_dev->name = "da7280-haptic";
+	haptics->input_dev->dev.parent = client->dev.parent;
+	haptics->input_dev->open = da7280_haptic_open;
+	haptics->input_dev->close = da7280_haptic_close;
+	input_set_drvdata(haptics->input_dev, haptics);
+	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
+
+	error = input_ff_create_memless(haptics->input_dev, NULL,
+					da7280_haptic_play);
+	if (error) {
+		dev_err(dev, "failed to create force-feedback\n");
+		return error;
+	}
+
+	error = input_register_device(haptics->input_dev);
+	if (error) {
+		dev_err(dev, "failed to register input device\n");
+		return error;
+	}
+
+	error = devm_device_add_group(dev, &da7280_attr_group);
+	if (error) {
+		dev_err(dev, "Failed to create sysfs attributes: %d\n",
+			error);
+	}
+
+	return error;
+}
+
+static int __maybe_unused da7280_suspend(struct device *dev)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&haptics->input_dev->mutex);
+
+	da7280_haptic_disable(haptics);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK, 0);
+	if (error)
+		dev_err(haptics->dev,
+			"I2C error : %d\n", error);
+
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
+}
+
+static int __maybe_unused da7280_resume(struct device *dev)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&haptics->input_dev->mutex);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK,
+				   DA7280_STANDBY_EN_MASK);
+	if (error)
+		dev_err(haptics->dev,
+			"i2c error : %d\n", error);
+
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
+}
+
+static const struct of_device_id da7280_of_match[] = {
+	{ .compatible = "dlg,da7280", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da7280_of_match);
+
+static const struct i2c_device_id da7280_i2c_id[] = {
+	{ "da7280", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, da7280_i2c_id);
+
+static SIMPLE_DEV_PM_OPS(da7280_pm_ops,
+		 da7280_suspend, da7280_resume);
+
+static struct i2c_driver da7280_driver = {
+	.driver		= {
+		.name	= "da7280",
+		.of_match_table = of_match_ptr(da7280_of_match),
+		.pm	= &da7280_pm_ops,
+	},
+	.probe	= da7280_probe,
+	.id_table	= da7280_i2c_id,
+};
+module_i2c_driver(da7280_driver);
+
+MODULE_DESCRIPTION("DA7280 haptics driver");
+MODULE_AUTHOR("Roy Im <Roy.Im.Opensource@diasemi.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/da7280.h b/drivers/input/misc/da7280.h
new file mode 100644
index 0000000..d9310b6
--- /dev/null
+++ b/drivers/input/misc/da7280.h
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * DA7280 Haptic device driver registers
+ *
+ * Copyright (c) 2017 Dialog Semiconductor.
+ * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
+ */
+
+#ifndef _DA7280_REG_DEFS_H
+#define _DA7280_REG_DEFS_H
+
+#include <linux/bitops.h>
+
+/* Registers */
+
+#define DA7280_CHIP_REV                       0x00
+#define DA7280_IRQ_EVENT1                     0x03
+#define DA7280_IRQ_EVENT_WARNING_DIAG         0x04
+#define DA7280_IRQ_EVENT_SEQ_DIAG             0x05
+#define DA7280_IRQ_STATUS1                    0x06
+#define DA7280_IRQ_MASK1                      0x07
+#define DA7280_CIF_I2C1                       0x08
+#define DA7280_FRQ_LRA_PER_H                  0x0A
+#define DA7280_FRQ_LRA_PER_L                  0x0B
+#define DA7280_ACTUATOR1                      0x0C
+#define DA7280_ACTUATOR2                      0x0D
+#define DA7280_ACTUATOR3                      0x0E
+#define DA7280_CALIB_V2I_H                    0x0F
+#define DA7280_CALIB_V2I_L                    0x10
+#define DA7280_CALIB_IMP_H                    0x11
+#define DA7280_CALIB_IMP_L                    0x12
+#define DA7280_TOP_CFG1                       0x13
+#define DA7280_TOP_CFG2                       0x14
+#define DA7280_TOP_CFG3                       0x15
+#define DA7280_TOP_CFG4                       0x16
+#define DA7280_TOP_INT_CFG1                   0x17
+#define DA7280_TOP_INT_CFG6_H                 0x1C
+#define DA7280_TOP_INT_CFG6_L                 0x1D
+#define DA7280_TOP_INT_CFG7_H                 0x1E
+#define DA7280_TOP_INT_CFG7_L                 0x1F
+#define DA7280_TOP_INT_CFG8                   0x20
+#define DA7280_TOP_CTL1                       0x22
+#define DA7280_TOP_CTL2                       0x23
+#define DA7280_SEQ_CTL1                       0x24
+#define DA7280_SWG_C1                         0x25
+#define DA7280_SWG_C2                         0x26
+#define DA7280_SWG_C3                         0x27
+#define DA7280_SEQ_CTL2                       0x28
+#define DA7280_GPI_0_CTL                      0x29
+#define DA7280_GPI_1_CTL                      0x2A
+#define DA7280_GPI_2_CTL                      0x2B
+#define DA7280_MEM_CTL1                       0x2C
+#define DA7280_MEM_CTL2                       0x2D
+#define DA7280_ADC_DATA_H1                    0x2E
+#define DA7280_ADC_DATA_L1                    0x2F
+#define DA7280_POLARITY                       0x43
+#define DA7280_LRA_AVR_H                      0x44
+#define DA7280_LRA_AVR_L                      0x45
+#define DA7280_FRQ_LRA_PER_ACT_H              0x46
+#define DA7280_FRQ_LRA_PER_ACT_L              0x47
+#define DA7280_FRQ_PHASE_H                    0x48
+#define DA7280_FRQ_PHASE_L                    0x49
+#define DA7280_FRQ_CTL                        0x4C
+#define DA7280_TRIM3                          0x5F
+#define DA7280_TRIM4                          0x60
+#define DA7280_TRIM6                          0x62
+#define DA7280_TOP_CFG5                       0x6E
+#define DA7280_IRQ_EVENT_ACTUATOR_FAULT       0x81
+#define DA7280_IRQ_STATUS2                    0x82
+#define DA7280_IRQ_MASK2                      0x83
+#define DA7280_SNP_MEM_0                      0x84
+#define DA7280_SNP_MEM_99                     0xE7
+
+/* DA7280_CHIP_REV (Address 0x00) */
+#define DA7280_CHIP_REV_MAJOR_SHIFT		0
+#define DA7280_CHIP_REV_MAJOR_MASK		(15 << 0)
+#define DA7280_CHIP_REV_MINOR_SHIFT		4
+#define DA7280_CHIP_REV_MINOR_MASK		(15 << 4)
+
+/* DA7280_IRQ_EVENT1 (Address 0x03) */
+#define DA7280_E_SEQ_CONTINUE_SHIFT		0
+#define DA7280_E_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_E_UVLO_SHIFT			1
+#define DA7280_E_UVLO_MASK			BIT(1)
+#define DA7280_E_SEQ_DONE_SHIFT			2
+#define DA7280_E_SEQ_DONE_MASK			BIT(2)
+#define DA7280_E_OVERTEMP_CRIT_SHIFT		3
+#define DA7280_E_OVERTEMP_CRIT_MASK		BIT(3)
+#define DA7280_E_SEQ_FAULT_SHIFT		4
+#define DA7280_E_SEQ_FAULT_MASK			BIT(4)
+#define DA7280_E_WARNING_SHIFT			5
+#define DA7280_E_WARNING_MASK			BIT(5)
+#define DA7280_E_ACTUATOR_FAULT_SHIFT		6
+#define DA7280_E_ACTUATOR_FAULT_MASK		BIT(6)
+#define DA7280_E_OC_FAULT_SHIFT			7
+#define DA7280_E_OC_FAULT_MASK			BIT(7)
+
+/* DA7280_IRQ_EVENT_WARNING_DIAG (Address 0x04) */
+#define DA7280_E_OVERTEMP_WARN_SHIFT            3
+#define DA7280_E_OVERTEMP_WARN_MASK             BIT(3)
+#define DA7280_E_MEM_TYPE_SHIFT                 4
+#define DA7280_E_MEM_TYPE_MASK                  BIT(4)
+#define DA7280_E_LIM_DRIVE_ACC_SHIFT            6
+#define DA7280_E_LIM_DRIVE_ACC_MASK             BIT(6)
+#define DA7280_E_LIM_DRIVE_SHIFT                7
+#define DA7280_E_LIM_DRIVE_MASK                 BIT(7)
+
+/* DA7280_IRQ_EVENT_PAT_DIAG (Address 0x05) */
+#define DA7280_E_PWM_FAULT_SHIFT		5
+#define DA7280_E_PWM_FAULT_MASK			BIT(5)
+#define DA7280_E_MEM_FAULT_SHIFT		6
+#define DA7280_E_MEM_FAULT_MASK			BIT(6)
+#define DA7280_E_SEQ_ID_FAULT_SHIFT		7
+#define DA7280_E_SEQ_ID_FAULT_MASK		BIT(7)
+
+/* DA7280_IRQ_STATUS1 (Address 0x06) */
+#define DA7280_STA_SEQ_CONTINUE_SHIFT		0
+#define DA7280_STA_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_STA_UVLO_VBAT_OK_SHIFT		1
+#define DA7280_STA_UVLO_VBAT_OK_MASK		BIT(1)
+#define DA7280_STA_SEQ_DONE_SHIFT		2
+#define DA7280_STA_SEQ_DONE_MASK		BIT(2)
+#define DA7280_STA_OVERTEMP_CRIT_SHIFT		3
+#define DA7280_STA_OVERTEMP_CRIT_MASK		BIT(3)
+#define DA7280_STA_SEQ_FAULT_SHIFT		4
+#define DA7280_STA_SEQ_FAULT_MASK		BIT(4)
+#define DA7280_STA_WARNING_SHIFT		5
+#define DA7280_STA_WARNING_MASK			BIT(5)
+#define DA7280_STA_ACTUATOR_SHIFT		6
+#define DA7280_STA_ACTUATOR_MASK		BIT(6)
+#define DA7280_STA_OC_SHIFT			7
+#define DA7280_STA_OC_MASK			BIT(7)
+
+/* DA7280_IRQ_MASK1 (Address 0x07) */
+#define DA7280_SEQ_CONTINUE_M_SHIFT		0
+#define DA7280_SEQ_CONTINUE_M_MASK		BIT(0)
+#define DA7280_E_UVLO_M_SHIFT			1
+#define DA7280_E_UVLO_M_MASK			BIT(1)
+#define DA7280_SEQ_DONE_M_SHIFT			2
+#define DA7280_SEQ_DONE_M_MASK			BIT(2)
+#define DA7280_OVERTEMP_CRIT_M_SHIFT		3
+#define DA7280_OVERTEMP_CRIT_M_MASK		BIT(3)
+#define DA7280_SEQ_FAULT_M_SHIFT		4
+#define DA7280_SEQ_FAULT_M_MASK			BIT(4)
+#define DA7280_WARNING_M_SHIFT			5
+#define DA7280_WARNING_M_MASK			BIT(5)
+#define DA7280_ACTUATOR_M_SHIFT			6
+#define DA7280_ACTUATOR_M_MASK			BIT(6)
+#define DA7280_OC_M_SHIFT			7
+#define DA7280_OC_M_MASK			BIT(7)
+
+/* DA7280_CIF_I2C1 (Address 0x08) */
+#define DA7280_I2C_TO_ENABLE_SHIFT		6
+#define DA7280_I2C_TO_ENABLE_MASK		BIT(6)
+#define DA7280_I2C_WR_MODE_SHIFT		7
+#define DA7280_I2C_WR_MODE_MASK			BIT(7)
+
+/* DA7280_FRQ_LRA_PER_H (Address 0x0a) */
+#define DA7280_LRA_PER_H_SHIFT			0
+#define DA7280_LRA_PER_H_MASK			(255 << 0)
+
+/* DA7280_FRQ_LRA_PER_L (Address 0x0b) */
+#define DA7280_LRA_PER_L_SHIFT			0
+#define DA7280_LRA_PER_L_MASK			(127 << 0)
+
+/* DA7280_ACTUATOR1 (Address 0x0c) */
+#define DA7280_ACTUATOR_NOMMAX_SHIFT		0
+#define DA7280_ACTUATOR_NOMMAX_MASK		(255 << 0)
+
+/* DA7280_ACTUATOR2 (Address 0x0d) */
+#define DA7280_ACTUATOR_ABSMAX_SHIFT		0
+#define DA7280_ACTUATOR_ABSMAX_MASK		(255 << 0)
+
+/* DA7280_ACTUATOR3 (Address 0x0e) */
+#define DA7280_IMAX_SHIFT			0
+#define DA7280_IMAX_MASK			(31 << 0)
+
+/* DA7280_CALIB_V2I_H (Address 0x0f) */
+#define DA7280_V2I_FACTOR_H_SHIFT		0
+#define DA7280_V2I_FACTOR_H_MASK		(255 << 0)
+
+/* DA7280_CALIB_V2I_L (Address 0x10) */
+#define DA7280_V2I_FACTOR_L_SHIFT		0
+#define DA7280_V2I_FACTOR_L_MASK		(255 << 0)
+
+/* DA7280_CALIB_IMP_H (Address 0x11) */
+#define DA7280_IMPEDANCE_H_SHIFT		0
+#define DA7280_IMPEDANCE_H_MASK			(255 << 0)
+
+/* DA7280_CALIB_IMP_L (Address 0x12) */
+#define DA7280_IMPEDANCE_L_SHIFT		0
+#define DA7280_IMPEDANCE_L_MASK			(3 << 0)
+
+/* DA7280_TOP_CFG1 (Address 0x13) */
+#define DA7280_AMP_PID_EN_SHIFT			0
+#define DA7280_AMP_PID_EN_MASK			BIT(0)
+#define DA7280_RAPID_STOP_EN_SHIFT		1
+#define DA7280_RAPID_STOP_EN_MASK		BIT(1)
+#define DA7280_ACCELERATION_EN_SHIFT		2
+#define DA7280_ACCELERATION_EN_MASK		BIT(2)
+#define DA7280_FREQ_TRACK_EN_SHIFT		3
+#define DA7280_FREQ_TRACK_EN_MASK		BIT(3)
+#define DA7280_BEMF_SENSE_EN_SHIFT		 4
+#define DA7280_BEMF_SENSE_EN_MASK		BIT(4)
+#define DA7280_ACTUATOR_TYPE_SHIFT		5
+#define DA7280_ACTUATOR_TYPE_MASK		BIT(5)
+#define DA7280_EMBEDDED_MODE_SHIFT		7
+#define DA7280_EMBEDDED_MODE_MASK		BIT(7)
+
+/* DA7280_TOP_CFG2 (Address 0x14) */
+#define DA7280_FULL_BRAKE_THR_SHIFT		0
+#define DA7280_FULL_BRAKE_THR_MASK		(15 << 0)
+#define DA7280_MEM_DATA_SIGNED_SHIFT		4
+#define DA7280_MEM_DATA_SIGNED_MASK		BIT(4)
+
+/* DA7280_TOP_CFG3 (Address 0x15) */
+#define DA7280_VDD_MARGIN_SHIFT			0
+#define DA7280_VDD_MARGIN_MASK			(15 << 0)
+
+/* DA7280_TOP_CFG4 (Address 0x16) */
+#define DA7280_TST_CALIB_IMPEDANCE_DIS_SHIFT	6
+#define DA7280_TST_CALIB_IMPEDANCE_DIS_MASK	BIT(6)
+#define DA7280_V2I_FACTOR_FREEZE_SHIFT		7
+#define DA7280_V2I_FACTOR_FREEZE_MASK		BIT(7)
+
+/* DA7280_TOP_INT_CFG1 (Address 0x17) */
+#define DA7280_BEMF_FAULT_LIM_SHIFT		0
+#define DA7280_BEMF_FAULT_LIM_MASK		(3 << 0)
+#define DA7280_FRQ_LOCKED_LIM_SHIFT		2
+#define DA7280_FRQ_LOCKED_LIM_MASK		(63 << 2)
+
+/* DA7280_TOP_INT_CFG6_H (Address 0x1c) */
+#define DA7280_FRQ_PID_KP_H_SHIFT		0
+#define DA7280_FRQ_PID_KP_H_MASK		(255 << 0)
+
+/* DA7280_TOP_INT_CFG6_L (Address 0x1d) */
+#define DA7280_FRQ_PID_KP_L_SHIFT		0
+#define DA7280_FRQ_PID_KP_L_MASK		(255 << 0)
+
+/* DA7280_TOP_INT_CFG7_H (Address 0x1e) */
+#define DA7280_FRQ_PID_KI_H_SHIFT		0
+#define DA7280_FRQ_PID_KI_H_MASK		(255 << 0)
+
+/* DA7280_TOP_INT_CFG7_L (Address 0x1f) */
+#define DA7280_FRQ_PID_KI_L_SHIFT		0
+#define DA7280_FRQ_PID_KI_L_MASK		(255 << 0)
+
+/* DA7280_TOP_INT_CFG8 (Address 0x20) */
+#define DA7280_TST_FRQ_TRACK_BEMF_LIM_SHIFT     0
+#define DA7280_TST_FRQ_TRACK_BEMF_LIM_MASK      (15 << 0)
+#define DA7280_TST_AMP_RAPID_STOP_LIM_SHIFT     4
+#define DA7280_TST_AMP_RAPID_STOP_LIM_MASK      (7 << 4)
+
+/* DA7280_TOP_CTL1 (Address 0x22) */
+#define DA7280_OPERATION_MODE_SHIFT		0
+#define DA7280_OPERATION_MODE_MASK		(7 << 0)
+#define DA7280_STANDBY_EN_SHIFT			3
+#define DA7280_STANDBY_EN_MASK			BIT(3)
+#define DA7280_SEQ_START_SHIFT			4
+#define DA7280_SEQ_START_MASK			BIT(4)
+
+/* DA7280_TOP_CTL2 (Address 0x23) */
+#define DA7280_OVERRIDE_VAL_SHIFT		0
+#define DA7280_OVERRIDE_VAL_MASK		(255 << 0)
+
+/* DA7280_SEQ_CTL1 (Address 0x24) */
+#define DA7280_SEQ_CONTINUE_SHIFT		0
+#define DA7280_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_WAVEGEN_MODE_SHIFT		1
+#define DA7280_WAVEGEN_MODE_MASK		BIT(1)
+#define DA7280_FREQ_WAVEFORM_TIMEBASE_SHIFT	2
+#define DA7280_FREQ_WAVEFORM_TIMEBASE_MASK	BIT(2)
+
+/* DA7280_SWG_C1 (Address 0x25) */
+#define DA7280_CUSTOM_WAVE_GEN_COEFF1_SHIFT	0
+#define DA7280_CUSTOM_WAVE_GEN_COEFF1_MASK	(255 << 0)
+
+/* DA7280_SWG_C2 (Address 0x26) */
+#define DA7280_CUSTOM_WAVE_GEN_COEFF2_SHIFT	0
+#define DA7280_CUSTOM_WAVE_GEN_COEFF2_MASK	(255 << 0)
+
+/* DA7280_SWG_C3 (Address 0x27) */
+#define DA7280_CUSTOM_WAVE_GEN_COEFF3_SHIFT	0
+#define DA7280_CUSTOM_WAVE_GEN_COEFF3_MASK	(255 << 0)
+
+/* DA7280_SEQ_CTL2 (Address 0x28) */
+#define DA7280_PS_SEQ_ID_SHIFT			0
+#define DA7280_PS_SEQ_ID_MASK			(15 << 0)
+#define DA7280_PS_SEQ_LOOP_SHIFT		4
+#define DA7280_PS_SEQ_LOOP_MASK			(15 << 4)
+
+/* DA7280_GPIO_0_CTL (Address 0x29) */
+#define DA7280_GPI0_POLARITY_SHIFT		0
+#define DA7280_GPI0_POLARITY_MASK		(3 << 0)
+#define DA7280_GPI0_MODE_SHIFT			2
+#define DA7280_GPI0_MODE_MASK			BIT(2)
+#define DA7280_GPI0_SEQUENCE_ID_SHIFT		3
+#define DA7280_GPI0_SEQUENCE_ID_MASK		(15 << 3)
+
+/* DA7280_GPIO_1_CTL (Address 0x2a) */
+#define DA7280_GPI1_POLARITY_SHIFT		0
+#define DA7280_GPI1_POLARITY_MASK		(3 << 0)
+#define DA7280_GPI1_MODE_SHIFT			2
+#define DA7280_GPI1_MODE_MASK			BIT(2)
+#define DA7280_GPI1_SEQUENCE_ID_SHIFT		3
+#define DA7280_GPI1_SEQUENCE_ID_MASK		(15 << 3)
+
+/* DA7280_GPIO_2_CTL (Address 0x2b) */
+#define DA7280_GPI2_POLARITY_SHIFT		0
+#define DA7280_GPI2_POLARITY_MASK		(3 << 0)
+#define DA7280_GPI2_MODE_SHIFT			2
+#define DA7280_GPI2_MODE_MASK			BIT(2)
+#define DA7280_GPI2_SEQUENCE_ID_SHIFT		3
+#define DA7280_GPI2_SEQUENCE_ID_MASK		(15 << 3)
+
+/* DA7280_MEM_CTL1 (Address 0x2c) */
+#define DA7280_WAV_MEM_BASE_ADDR_SHIFT		0
+#define DA7280_WAV_MEM_BASE_ADDR_MASK		(255 << 0)
+
+/* DA7280_MEM_CTL2 (Address 0x2d) */
+#define DA7280_WAV_MEM_LOCK_SHIFT		7
+#define DA7280_WAV_MEM_LOCK_MASK		BIT(7)
+
+/* DA7280_ADC_DATA_H1 (Address 0x2e) */
+#define DA7280_ADC_VDD_H_SHIFT			0
+#define DA7280_ADC_VDD_H_MASK			(255 << 0)
+
+/* DA7280_ADC_DATA_L1 (Address 0x2f) */
+#define DA7280_ADC_VDD_L_SHIFT			0
+#define DA7280_ADC_VDD_L_MASK			(127 << 0)
+
+/* DA7280_POLARITY (Address 0x43) */
+#define DA7280_POLARITY_SHIFT			0
+#define DA7280_POLARITY_MASK			BIT(0)
+
+/* DA7280_LRA_AVR_H (Address 0x44) */
+#define DA7280_LRA_PER_AVERAGE_H_SHIFT		0
+#define DA7280_LRA_PER_AVERAGE_H_MASK		(255 << 0)
+
+/* DA7280_LRA_AVR_L (Address 0x45) */
+#define DA7280_LRA_PER_AVERAGE_L_SHIFT		0
+#define DA7280_LRA_PER_AVERAGE_L_MASK		(127 << 0)
+
+/* DA7280_FRQ_LRA_PER_ACT_H (Address 0x46) */
+#define DA7280_LRA_PER_ACTUAL_H_SHIFT		0
+#define DA7280_LRA_PER_ACTUAL_H_MASK		(255 << 0)
+
+/* DA7280_FRQ_LRA_PER_ACT_L (Address 0x47) */
+#define DA7280_LRA_PER_ACTUAL_L_SHIFT		0
+#define DA7280_LRA_PER_ACTUAL_L_MASK		(127 << 0)
+
+/* DA7280_FRQ_PHASE_H (Address 0x48) */
+#define DA7280_PHASE_DELAY_H_SHIFT		0
+#define DA7280_PHASE_DELAY_H_MASK		(255 << 0)
+
+/* DA7280_FRQ_PHASE_L (Address 0x49) */
+#define DA7280_DELAY_SHIFT_L_SHIFT		0
+#define DA7280_DELAY_SHIFT_L_MASK		(7 << 0)
+#define DA7280_DELAY_SHIFT_FREEZE_SHIFT		7
+#define DA7280_DELAY_SHIFT_FREEZE_MASK		BIT(7)
+
+/* DA7280_FRQ_CTL (Address 0x4c) */
+#define DA7280_FREQ_TRACKING_FORCE_ON_SHIFT	0
+#define DA7280_FREQ_TRACKING_FORCE_ON_MASK	BIT(0)
+#define DA7280_FREQ_TRACKING_AUTO_ADJ_SHIFT	1
+#define DA7280_FREQ_TRACKING_AUTO_ADJ_MASK	BIT(1)
+
+/* DA7280_TRIM3 (Address 0x5f) */
+#define DA7280_REF_UVLO_THRES_SHIFT		3
+#define DA7280_REF_UVLO_THRES_MASK		(3 << 3)
+#define DA7280_LOOP_FILT_LOW_BW_SHIFT		5
+#define DA7280_LOOP_FILT_LOW_BW_MASK		BIT(5)
+#define DA7280_LOOP_IDAC_DOUBLE_RANGE_SHIFT	6
+#define DA7280_LOOP_IDAC_DOUBLE_RANGE_MASK	BIT(6)
+
+/* DA7280_TRIM4 (Address 0x60) */
+#define DA7280_LOOP_FILT_RES_TRIM_SHIFT		0
+#define DA7280_LOOP_FILT_RES_TRIM_MASK		(3 << 0)
+#define DA7280_LOOP_FILT_CAP_TRIM_SHIFT		2
+#define DA7280_LOOP_FILT_CAP_TRIM_MASK		(3 << 2)
+
+/* DA7280_TRIM6 (Address 0x62) */
+#define DA7280_HBRIDGE_ERC_HS_TRIM_SHIFT	0
+#define DA7280_HBRIDGE_ERC_HS_TRIM_MASK		(3 << 0)
+#define DA7280_HBRIDGE_ERC_LS_TRIM_SHIFT	2
+#define DA7280_HBRIDGE_ERC_LS_TRIM_MASK		(3 << 2)
+
+/* DA7280_TOP_CFG5 (Address 0x6e) */
+#define DA7280_V2I_FACTOR_OFFSET_EN_SHIFT		0
+#define DA7280_V2I_FACTOR_OFFSET_EN_MASK		BIT(0)
+#define DA7280_FRQ_PAUSE_ON_POLARITY_CHANGE_SHIFT	1
+#define DA7280_FRQ_PAUSE_ON_POLARITY_CHANGE_MASK	BIT(1)
+#define DA7280_DELAY_BYPASS_SHIFT			2
+#define DA7280_DELAY_BYPASS_MASK			BIT(2)
+
+/* DA7280_IRQ_EVENT_ACTUATOR_FAULT (Address 0x81) */
+#define DA7280_ADC_SAT_FAULT_SHIFT		2
+#define DA7280_ADC_SAT_FAULT_MASK		BIT(2)
+
+/* DA7280_IRQ_STATUS2 (Address 0x82) */
+#define DA7280_STA_ADC_SAT_SHIFT		7
+#define DA7280_STA_ADC_SAT_MASK			BIT(7)
+
+/* DA7280_IRQ_MASK2 (Address 0x83) */
+#define DA7280_ADC_SAT_M_SHIFT			7
+#define DA7280_ADC_SAT_M_MASK			BIT(7)
+
+/* DA7280_SNP_MEM_XX (Address 0x84 ~ 0xe7) */
+#define DA7280_SNP_MEM_SHIFT			0
+#define DA7280_SNP_MEM_MASK			(255 << 0)
+
+#endif
-- 
end-of-patch for RESEND PATCH V7

