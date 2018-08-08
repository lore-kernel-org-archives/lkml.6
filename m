Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32743C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C821708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWewDClj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39C821708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHHKvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:51:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44396 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:51:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so962455lfb.11;
        Wed, 08 Aug 2018 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d8BAQ2SUJ4nqTOCnknO3EEWnkLCRhFHf994AudOYwNo=;
        b=dWewDCljYuukwrphP6ntmKo4FnEoxUDeIce6X3PWdMoxHraoU7O8fEBLtKyYDy3WdG
         WIeoFzhwquT9l4edLjK8r9TooBFwv7e0WAk4mmkKhah1IXqRXt/DRPI+1zwfO0VjRp8a
         uJfdVBpVbCD8v3suuTTpBTXzKY1YzgxDteDPTlLf0MiUN0Ji3hi411FZX0wpuBn+ZZCc
         8JlBm8nEEQUBOkLWKrNPV0m7RgVGxJI38R8OLbfXJ8j1IbLdzU309e4h9VsG9iu5xGXf
         V/B79nvgWbegmFbjyOxj4ZJZEmTqK/LGgFD70BYDQZDvhV9CI8DoxxFvPCIrJOL+CxWo
         aX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d8BAQ2SUJ4nqTOCnknO3EEWnkLCRhFHf994AudOYwNo=;
        b=kPrW2Gs1oVwnL2+rHOzlEdUkktqtWKbwi1ui9ypzTbFcbZfCdeLfvwFGsIlcPSxqzy
         C1WeaBUspf2P7rXypxhHJXSU6c2Pc44/UMVjMjwE/Cs276WxGxwwHxHfwEFClQOy04OB
         45sWOcxalEd13WjmQMy/YrbxA3B1IJI6gX+HKkpVo5Nu5OC5rPk+nu0piFPfmC9OOjAH
         /0kvRjJhvs70f6g3UzWvd50576wYJhyA5pzREazEt3QHwCsxw4xxwkMyXUIJMzTjy4K0
         VeIksUyKL7eyJScFwbhbNDC/qocTH4X0IDoWkKwyMu+JiDHp/99T3FutvGGVOSwsKugN
         smKw==
X-Gm-Message-State: AOUpUlE9nntqCbDAOxqve1VWzglzt5sbZjIHQ/rQn7PVP87b2Vw5jxhV
        MI7Y6fXCWsqcvgcYek/gGUU=
X-Google-Smtp-Source: AA+uWPzgi15RlY1Ph0Rbf2eD6bBMBCoH4KmXlXKvZAOTe0NO0oKKX92iFg6vPEvWFQz9xhvSoyt5Sw==
X-Received: by 2002:a19:1ad1:: with SMTP id a200-v6mr1243668lfa.49.1533717189202;
        Wed, 08 Aug 2018 01:33:09 -0700 (PDT)
Received: from localhost.localdomain (c-2ec252a3-74736162.cust.telenor.se. [46.194.82.163])
        by smtp.gmail.com with ESMTPSA id f136-v6sm708782lfe.71.2018.08.08.01.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:33:07 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] iio: adc: add support for mcp3911
Date:   Wed,  8 Aug 2018 10:09:15 +0200
Message-Id: <20180808080917.2427-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Co-Developed-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
    	- remove defined(CONFIG_OF) and of_match_ptr() macro
    	- do not check adc->clki as clock api is NULL-aware
    	- add Kent as co-developer
    v3:
    	- rename adc_clk to clki
    	- add error handling/cleanup for clock
    v2:
    	- cleanups and bugfixes (thanks Peter Meerwald-Stadler)
    	- drop hardware gain
    	- use the presence or lack of regulator to indicate if we go for internal or external voltage reference
    	- do not store device node in private struct
    	- drop support to set width in devicetree
    	- use the presence or lack of clock to indicate if we go for internal or external clock

 drivers/iio/adc/Kconfig   |  10 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/mcp3911.c | 361 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 drivers/iio/adc/mcp3911.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15606f237480..f9a41fa96fcc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -501,6 +501,16 @@ config MCP3422
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3422.
 
+config MCP3911
+	tristate "Microchip Technology MCP3911 driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Microchip Technology's MCP3911
+	  analog to digital converter.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mcp3911.
+
 config MEDIATEK_MT6577_AUXADC
         tristate "MediaTek AUXADC driver"
         depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 28a9423997f3..3cfebfff7d26 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
+obj-$(CONFIG_MCP3911) += mcp3911.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
new file mode 100644
index 000000000000..540c8fbcce89
--- /dev/null
+++ b/drivers/iio/adc/mcp3911.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Microchip MCP3911, Two-channel Analog Front End
+ *
+ * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
+ * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#define MCP3911_REG_CHANNEL0		0x00
+#define MCP3911_REG_CHANNEL1		0x03
+#define MCP3911_REG_MOD			0x06
+#define MCP3911_REG_PHASE		0x07
+#define MCP3911_REG_GAIN		0x09
+
+#define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
+#define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
+#define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
+#define MCP3911_STATUSCOM_EN_GAINCAL	BIT(1)
+
+#define MCP3911_REG_CONFIG		0x0c
+#define MCP3911_CONFIG_CLKEXT		BIT(1)
+#define MCP3911_CONFIG_VREFEXT		BIT(2)
+
+#define MCP3911_REG_OFFCAL_CH0		0x0e
+#define MCP3911_REG_GAINCAL_CH0		0x11
+#define MCP3911_REG_OFFCAL_CH1		0x14
+#define MCP3911_REG_GAINCAL_CH1		0x17
+#define MCP3911_REG_VREFCAL		0x1a
+
+#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
+#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
+
+/* Internal voltage reference in uV */
+#define MCP3911_INT_VREF_UV		1200000
+
+#define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 << 0)) & 0xff)
+#define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
+
+#define MCP3911_NUM_CHANNELS		2
+
+struct mcp3911 {
+	struct spi_device *spi;
+	struct mutex lock;
+	struct regulator *vref;
+	struct clk *clki;
+	u32 dev_addr;
+};
+
+static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
+{
+	int ret;
+
+	reg = MCP3911_REG_READ(reg, adc->dev_addr);
+	ret = spi_write_then_read(adc->spi, &reg, 1, val, len);
+	if (ret < 0)
+		return ret;
+
+	be32_to_cpus(val);
+	*val >>= ((4 - len) * 8);
+	dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
+			reg>>1);
+	return ret;
+}
+
+static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
+{
+	dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", val, reg);
+
+	val <<= (3 - len) * 8;
+	cpu_to_be32s(&val);
+	val |= MCP3911_REG_WRITE(reg, adc->dev_addr);
+
+	return spi_write(adc->spi, &val, len + 1);
+}
+
+static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
+		u32 val, u8 len)
+{
+	u32 tmp;
+	int ret;
+
+	ret = mcp3911_read(adc, reg, &tmp, len);
+	if (ret)
+		return ret;
+
+	val &= mask;
+	val |= tmp & ~mask;
+	return mcp3911_write(adc, reg, val, len);
+}
+
+static int mcp3911_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct mcp3911 *adc = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	mutex_lock(&adc->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mcp3911_read(adc,
+				MCP3911_CHANNEL(channel->channel), val, 3);
+		if (ret)
+			goto out;
+
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_OFFSET:
+		ret = mcp3911_read(adc,
+				MCP3911_OFFCAL(channel->channel), val, 3);
+		if (ret)
+			goto out;
+
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (adc->vref) {
+			ret = regulator_get_voltage(adc->vref);
+			if (ret < 0) {
+				dev_err(indio_dev->dev.parent,
+					"failed to get vref voltage: %d\n",
+				       ret);
+				goto out;
+			}
+
+			*val = ret / 1000;
+		} else {
+			*val = MCP3911_INT_VREF_UV;
+		}
+
+		*val2 = 24;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	}
+
+out:
+	mutex_unlock(&adc->lock);
+	return ret;
+}
+
+static int mcp3911_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int val,
+			    int val2, long mask)
+{
+	struct mcp3911 *adc = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	mutex_lock(&adc->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		if (val2 != 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Write offset */
+		ret = mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
+				3);
+		if (ret)
+			goto out;
+
+		/* Enable offset*/
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
+				MCP3911_STATUSCOM_EN_OFFCAL,
+				MCP3911_STATUSCOM_EN_OFFCAL, 2);
+		break;
+	}
+
+out:
+	mutex_unlock(&adc->lock);
+	return ret;
+}
+
+#define MCP3911_CHAN(idx) {					\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.channel = idx,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+			BIT(IIO_CHAN_INFO_OFFSET) |		\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static const struct iio_chan_spec mcp3911_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+};
+
+static const struct iio_info mcp3911_info = {
+	.read_raw = mcp3911_read_raw,
+	.write_raw = mcp3911_write_raw,
+};
+
+static int mcp3911_config(struct mcp3911 *adc, struct device_node *of_node)
+{
+	u32 configreg;
+	int ret;
+
+	of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
+	if (adc->dev_addr > 3) {
+		dev_err(&adc->spi->dev,
+				"invalid device address (%i). Must be in range 0-3.\n",
+				adc->dev_addr);
+		return -EINVAL;
+	}
+	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
+
+	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
+	if (ret)
+		return ret;
+
+	if (adc->vref) {
+		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
+		configreg |= MCP3911_CONFIG_VREFEXT;
+	} else {
+		dev_dbg(&adc->spi->dev, "use internal voltage reference (1.2V)\n");
+		configreg &= ~MCP3911_CONFIG_VREFEXT;
+	}
+
+	if (adc->clki) {
+		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
+		configreg |= MCP3911_CONFIG_CLKEXT;
+	} else {
+		dev_dbg(&adc->spi->dev, "use crystal oscillator as clocksource\n");
+		configreg &= ~MCP3911_CONFIG_CLKEXT;
+	}
+
+	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
+}
+
+static int mcp3911_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct mcp3911 *adc;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->spi = spi;
+
+	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
+	if (IS_ERR(adc->vref)) {
+		if (PTR_ERR(adc->vref) == -ENODEV) {
+			adc->vref = NULL;
+		} else {
+			dev_err(&adc->spi->dev,
+					"failed to get regulator (%ld)\n",
+					PTR_ERR(adc->vref));
+			return PTR_ERR(adc->vref);
+		}
+
+	} else {
+		ret = regulator_enable(adc->vref);
+		if (ret)
+			return ret;
+	}
+
+	adc->clki = devm_clk_get(&adc->spi->dev, NULL);
+	if (IS_ERR(adc->clki)) {
+		if (PTR_ERR(adc->clki) == -ENOENT) {
+			adc->clki = NULL;
+		} else {
+			dev_err(&adc->spi->dev,
+					"failed to get adc clk (%ld)\n",
+					PTR_ERR(adc->clki));
+			ret = PTR_ERR(adc->clki);
+			goto reg_disable;
+		}
+	} else {
+		ret = clk_prepare_enable(adc->clki);
+		if (ret < 0) {
+			dev_err(&adc->spi->dev,
+				"Failed to enable clki: %d\n", ret);
+			goto reg_disable;
+		}
+	}
+
+	ret = mcp3911_config(adc, spi->dev.of_node);
+	if (ret)
+		goto clk_disable;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mcp3911_info;
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->channels = mcp3911_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mcp3911_channels);
+
+	mutex_init(&adc->lock);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto clk_disable;
+
+	return ret;
+
+clk_disable:
+	clk_disable_unprepare(adc->clki);
+reg_disable:
+	if (adc->vref)
+		regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static int mcp3911_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct mcp3911 *adc = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	clk_disable_unprepare(adc->clki);
+	if (adc->vref)
+		regulator_disable(adc->vref);
+
+	return 0;
+}
+
+static const struct of_device_id mcp3911_dt_ids[] = {
+	{ .compatible = "microchip,mcp3911" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
+
+static const struct spi_device_id mcp3911_id[] = {
+	{ "mcp3911", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mcp3911_id);
+
+static struct spi_driver mcp3911_driver = {
+	.driver = {
+		.name = "mcp3911",
+		.of_match_table = mcp3911_dt_ids,
+	},
+	.probe = mcp3911_probe,
+	.remove = mcp3911_remove,
+	.id_table = mcp3911_id,
+};
+module_spi_driver(mcp3911_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_AUTHOR("Kent Gustavsson <kent@minoris.se>");
+MODULE_DESCRIPTION("Microchip Technology MCP3911");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0.rc2

