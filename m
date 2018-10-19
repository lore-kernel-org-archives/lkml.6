Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5338BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54120838
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE54120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJSRzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:55:40 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60156 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726964AbeJSRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:55:38 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9J9ncPQ006594;
        Fri, 19 Oct 2018 04:50:06 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2n3e40rv1d-1;
        Fri, 19 Oct 2018 04:50:05 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id B1BE9611C8B1;
        Fri, 19 Oct 2018 04:52:23 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Oct 2018
 10:50:03 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9J9o3ox015276; Fri,
 19 Oct 2018 10:50:04 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 2/5] mfd: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Fri, 19 Oct 2018 10:50:00 +0100
Message-ID: <20181019095003.26046-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810190090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board. Audio system topology,
clocking and power can all be controlled through the Lochnagar
controller chip, allowing the device under test to be used in
a variety of possible use cases.

As the Lochnagar is a fairly complex device this MFD driver
allows the drivers for the various features to be bound
in. Initially clocking, regulator and pinctrl will be added as
these are necessary to configure the system. But in time at least
audio and voltage/current monitoring will also be added.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Minor updates to the device names bound in for the clock driver

Thanks,
Charles

 MAINTAINERS                         |  13 +
 drivers/mfd/Kconfig                 |   8 +
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/lochnagar-i2c.c         | 732 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/lochnagar.h       |  48 +++
 include/linux/mfd/lochnagar1_regs.h | 157 ++++++++
 include/linux/mfd/lochnagar2_regs.h | 253 +++++++++++++
 7 files changed, 1213 insertions(+)
 create mode 100644 drivers/mfd/lochnagar-i2c.c
 create mode 100644 include/linux/mfd/lochnagar.h
 create mode 100644 include/linux/mfd/lochnagar1_regs.h
 create mode 100644 include/linux/mfd/lochnagar2_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d9e6d86488df4..f1f3494ac5cd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3557,6 +3557,19 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
 
+CIRRUS LOGIC LOCHNAGAR DRIVER
+M:	Charles Keepax <ckeepax@opensource.cirrus.com>
+M:	Richard Fitzgerald <rf@opensource.cirrus.com>
+L:	patches@opensource.cirrus.com
+S:	Supported
+F:	drivers/clk/clk-lochnagar.c
+F:	drivers/mfd/lochnagar-i2c.c
+F:	drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+F:	drivers/regulator/lochnagar-regulator.c
+F:	include/dt-bindings/clk/lochnagar.h
+F:	include/dt-bindings/pinctrl/lochnagar.h
+F:	include/linux/mfd/lochnagar*
+
 CISCO FCOE HBA DRIVER
 M:	Satish Kharat <satishkh@cisco.com>
 M:	Sesidhar Baddela <sebaddel@cisco.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f3a5f8d027906..dc64151373714 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1676,6 +1676,14 @@ config MFD_VX855
 	  VIA VX855/VX875 south bridge. You will need to enable the vx855_spi
 	  and/or vx855_gpio drivers for this to do anything useful.
 
+config MFD_LOCHNAGAR
+	bool "Cirrus Logic Lochnagar Audio Development Board"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C=y && OF
+	help
+	  Support for Cirrus Logic Lochnagar audio development board.
+
 config MFD_ARIZONA
 	select REGMAP
 	select REGMAP_IRQ
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5856a9489cbd8..f16773cb887ff 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -37,6 +37,8 @@ obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o tmio_core.o
 
+obj-$(CONFIG_MFD_LOCHNAGAR)	+= lochnagar-i2c.o
+
 obj-$(CONFIG_MFD_ARIZONA)	+= arizona-core.o
 obj-$(CONFIG_MFD_ARIZONA)	+= arizona-irq.o
 obj-$(CONFIG_MFD_ARIZONA_I2C)	+= arizona-i2c.o
diff --git a/drivers/mfd/lochnagar-i2c.c b/drivers/mfd/lochnagar-i2c.c
new file mode 100644
index 0000000000000..b878a79a49066
--- /dev/null
+++ b/drivers/mfd/lochnagar-i2c.c
@@ -0,0 +1,732 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lochnagar I2C bus interface
+ *
+ * Copyright (c) 2012-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/lochnagar.h>
+
+#define LOCHNAGAR_BOOT_RETRIES		10
+#define LOCHNAGAR_BOOT_DELAY_MS		350
+
+#define LOCHNAGAR_CONFIG_POLL_US	10000
+
+static bool lochnagar1_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LOCHNAGAR_SOFTWARE_RESET:
+	case LOCHNAGAR_FIRMWARE_ID1:
+	case LOCHNAGAR_FIRMWARE_ID2:
+	case LOCHNAGAR1_CDC_AIF1_SEL:
+	case LOCHNAGAR1_CDC_AIF2_SEL:
+	case LOCHNAGAR1_CDC_AIF3_SEL:
+	case LOCHNAGAR1_CDC_MCLK1_SEL:
+	case LOCHNAGAR1_CDC_MCLK2_SEL:
+	case LOCHNAGAR1_CDC_AIF_CTRL1:
+	case LOCHNAGAR1_CDC_AIF_CTRL2:
+	case LOCHNAGAR1_EXT_AIF_CTRL:
+	case LOCHNAGAR1_DSP_AIF1_SEL:
+	case LOCHNAGAR1_DSP_AIF2_SEL:
+	case LOCHNAGAR1_DSP_CLKIN_SEL:
+	case LOCHNAGAR1_DSP_AIF:
+	case LOCHNAGAR1_GF_AIF1:
+	case LOCHNAGAR1_GF_AIF2:
+	case LOCHNAGAR1_PSIA_AIF:
+	case LOCHNAGAR1_PSIA1_SEL:
+	case LOCHNAGAR1_PSIA2_SEL:
+	case LOCHNAGAR1_SPDIF_AIF_SEL:
+	case LOCHNAGAR1_GF_AIF3_SEL:
+	case LOCHNAGAR1_GF_AIF4_SEL:
+	case LOCHNAGAR1_GF_CLKOUT1_SEL:
+	case LOCHNAGAR1_GF_AIF1_SEL:
+	case LOCHNAGAR1_GF_AIF2_SEL:
+	case LOCHNAGAR1_GF_GPIO2:
+	case LOCHNAGAR1_GF_GPIO3:
+	case LOCHNAGAR1_GF_GPIO7:
+	case LOCHNAGAR1_RST:
+	case LOCHNAGAR1_LED1:
+	case LOCHNAGAR1_LED2:
+	case LOCHNAGAR1_I2C_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default lochnagar1_reg_defaults[] = {
+	{ LOCHNAGAR1_CDC_AIF1_SEL,    0x00 },
+	{ LOCHNAGAR1_CDC_AIF2_SEL,    0x00 },
+	{ LOCHNAGAR1_CDC_AIF3_SEL,    0x00 },
+	{ LOCHNAGAR1_CDC_MCLK1_SEL,   0x00 },
+	{ LOCHNAGAR1_CDC_MCLK2_SEL,   0x00 },
+	{ LOCHNAGAR1_CDC_AIF_CTRL1,   0x00 },
+	{ LOCHNAGAR1_CDC_AIF_CTRL2,   0x00 },
+	{ LOCHNAGAR1_EXT_AIF_CTRL,    0x00 },
+	{ LOCHNAGAR1_DSP_AIF1_SEL,    0x00 },
+	{ LOCHNAGAR1_DSP_AIF2_SEL,    0x00 },
+	{ LOCHNAGAR1_DSP_CLKIN_SEL,   0x01 },
+	{ LOCHNAGAR1_DSP_AIF,         0x08 },
+	{ LOCHNAGAR1_GF_AIF1,         0x00 },
+	{ LOCHNAGAR1_GF_AIF2,         0x00 },
+	{ LOCHNAGAR1_PSIA_AIF,        0x00 },
+	{ LOCHNAGAR1_PSIA1_SEL,       0x00 },
+	{ LOCHNAGAR1_PSIA2_SEL,       0x00 },
+	{ LOCHNAGAR1_SPDIF_AIF_SEL,   0x00 },
+	{ LOCHNAGAR1_GF_AIF3_SEL,     0x00 },
+	{ LOCHNAGAR1_GF_AIF4_SEL,     0x00 },
+	{ LOCHNAGAR1_GF_CLKOUT1_SEL,  0x00 },
+	{ LOCHNAGAR1_GF_AIF1_SEL,     0x00 },
+	{ LOCHNAGAR1_GF_AIF2_SEL,     0x00 },
+	{ LOCHNAGAR1_GF_GPIO2,        0x00 },
+	{ LOCHNAGAR1_GF_GPIO3,        0x00 },
+	{ LOCHNAGAR1_GF_GPIO7,        0x00 },
+	{ LOCHNAGAR1_RST,             0x00 },
+	{ LOCHNAGAR1_LED1,            0x00 },
+	{ LOCHNAGAR1_LED2,            0x00 },
+	{ LOCHNAGAR1_I2C_CTRL,        0x01 },
+};
+
+static const struct regmap_config lochnagar1_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = 0x50,
+	.readable_reg = lochnagar1_readable_register,
+
+	.use_single_rw = true,
+
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = lochnagar1_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(lochnagar1_reg_defaults),
+};
+
+static const struct reg_sequence lochnagar1_patch[] = {
+	{ 0x40, 0x0083 },
+	{ 0x46, 0x0001 },
+	{ 0x47, 0x0018 },
+	{ 0x50, 0x0000 },
+};
+
+static struct mfd_cell lochnagar1_devs[] = {
+	{
+		.name = "lochnagar-pinctrl",
+	},
+	{
+		.name = "lochnagar1-clk",
+	},
+};
+
+static bool lochnagar2_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LOCHNAGAR_SOFTWARE_RESET:
+	case LOCHNAGAR_FIRMWARE_ID1:
+	case LOCHNAGAR_FIRMWARE_ID2:
+	case LOCHNAGAR2_CDC_AIF1_CTRL:
+	case LOCHNAGAR2_CDC_AIF2_CTRL:
+	case LOCHNAGAR2_CDC_AIF3_CTRL:
+	case LOCHNAGAR2_DSP_AIF1_CTRL:
+	case LOCHNAGAR2_DSP_AIF2_CTRL:
+	case LOCHNAGAR2_PSIA1_CTRL:
+	case LOCHNAGAR2_PSIA2_CTRL:
+	case LOCHNAGAR2_GF_AIF3_CTRL:
+	case LOCHNAGAR2_GF_AIF4_CTRL:
+	case LOCHNAGAR2_GF_AIF1_CTRL:
+	case LOCHNAGAR2_GF_AIF2_CTRL:
+	case LOCHNAGAR2_SPDIF_AIF_CTRL:
+	case LOCHNAGAR2_USB_AIF1_CTRL:
+	case LOCHNAGAR2_USB_AIF2_CTRL:
+	case LOCHNAGAR2_ADAT_AIF_CTRL:
+	case LOCHNAGAR2_CDC_MCLK1_CTRL:
+	case LOCHNAGAR2_CDC_MCLK2_CTRL:
+	case LOCHNAGAR2_DSP_CLKIN_CTRL:
+	case LOCHNAGAR2_PSIA1_MCLK_CTRL:
+	case LOCHNAGAR2_PSIA2_MCLK_CTRL:
+	case LOCHNAGAR2_SPDIF_MCLK_CTRL:
+	case LOCHNAGAR2_GF_CLKOUT1_CTRL:
+	case LOCHNAGAR2_GF_CLKOUT2_CTRL:
+	case LOCHNAGAR2_ADAT_MCLK_CTRL:
+	case LOCHNAGAR2_SOUNDCARD_MCLK_CTRL:
+	case LOCHNAGAR2_GPIO_FPGA_GPIO1:
+	case LOCHNAGAR2_GPIO_FPGA_GPIO2:
+	case LOCHNAGAR2_GPIO_FPGA_GPIO3:
+	case LOCHNAGAR2_GPIO_FPGA_GPIO4:
+	case LOCHNAGAR2_GPIO_FPGA_GPIO5:
+	case LOCHNAGAR2_GPIO_FPGA_GPIO6:
+	case LOCHNAGAR2_GPIO_CDC_GPIO1:
+	case LOCHNAGAR2_GPIO_CDC_GPIO2:
+	case LOCHNAGAR2_GPIO_CDC_GPIO3:
+	case LOCHNAGAR2_GPIO_CDC_GPIO4:
+	case LOCHNAGAR2_GPIO_CDC_GPIO5:
+	case LOCHNAGAR2_GPIO_CDC_GPIO6:
+	case LOCHNAGAR2_GPIO_CDC_GPIO7:
+	case LOCHNAGAR2_GPIO_CDC_GPIO8:
+	case LOCHNAGAR2_GPIO_DSP_GPIO1:
+	case LOCHNAGAR2_GPIO_DSP_GPIO2:
+	case LOCHNAGAR2_GPIO_DSP_GPIO3:
+	case LOCHNAGAR2_GPIO_DSP_GPIO4:
+	case LOCHNAGAR2_GPIO_DSP_GPIO5:
+	case LOCHNAGAR2_GPIO_DSP_GPIO6:
+	case LOCHNAGAR2_GPIO_GF_GPIO2:
+	case LOCHNAGAR2_GPIO_GF_GPIO3:
+	case LOCHNAGAR2_GPIO_GF_GPIO7:
+	case LOCHNAGAR2_GPIO_CDC_AIF1_BCLK:
+	case LOCHNAGAR2_GPIO_CDC_AIF1_RXDAT:
+	case LOCHNAGAR2_GPIO_CDC_AIF1_LRCLK:
+	case LOCHNAGAR2_GPIO_CDC_AIF1_TXDAT:
+	case LOCHNAGAR2_GPIO_CDC_AIF2_BCLK:
+	case LOCHNAGAR2_GPIO_CDC_AIF2_RXDAT:
+	case LOCHNAGAR2_GPIO_CDC_AIF2_LRCLK:
+	case LOCHNAGAR2_GPIO_CDC_AIF2_TXDAT:
+	case LOCHNAGAR2_GPIO_CDC_AIF3_BCLK:
+	case LOCHNAGAR2_GPIO_CDC_AIF3_RXDAT:
+	case LOCHNAGAR2_GPIO_CDC_AIF3_LRCLK:
+	case LOCHNAGAR2_GPIO_CDC_AIF3_TXDAT:
+	case LOCHNAGAR2_GPIO_DSP_AIF1_BCLK:
+	case LOCHNAGAR2_GPIO_DSP_AIF1_RXDAT:
+	case LOCHNAGAR2_GPIO_DSP_AIF1_LRCLK:
+	case LOCHNAGAR2_GPIO_DSP_AIF1_TXDAT:
+	case LOCHNAGAR2_GPIO_DSP_AIF2_BCLK:
+	case LOCHNAGAR2_GPIO_DSP_AIF2_RXDAT:
+	case LOCHNAGAR2_GPIO_DSP_AIF2_LRCLK:
+	case LOCHNAGAR2_GPIO_DSP_AIF2_TXDAT:
+	case LOCHNAGAR2_GPIO_PSIA1_BCLK:
+	case LOCHNAGAR2_GPIO_PSIA1_RXDAT:
+	case LOCHNAGAR2_GPIO_PSIA1_LRCLK:
+	case LOCHNAGAR2_GPIO_PSIA1_TXDAT:
+	case LOCHNAGAR2_GPIO_PSIA2_BCLK:
+	case LOCHNAGAR2_GPIO_PSIA2_RXDAT:
+	case LOCHNAGAR2_GPIO_PSIA2_LRCLK:
+	case LOCHNAGAR2_GPIO_PSIA2_TXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF3_BCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF3_RXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF3_LRCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF3_TXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF4_BCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF4_RXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF4_LRCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF4_TXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF1_BCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF1_RXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF1_LRCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF1_TXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF2_BCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF2_RXDAT:
+	case LOCHNAGAR2_GPIO_GF_AIF2_LRCLK:
+	case LOCHNAGAR2_GPIO_GF_AIF2_TXDAT:
+	case LOCHNAGAR2_GPIO_DSP_UART1_RX:
+	case LOCHNAGAR2_GPIO_DSP_UART1_TX:
+	case LOCHNAGAR2_GPIO_DSP_UART2_RX:
+	case LOCHNAGAR2_GPIO_DSP_UART2_TX:
+	case LOCHNAGAR2_GPIO_GF_UART2_RX:
+	case LOCHNAGAR2_GPIO_GF_UART2_TX:
+	case LOCHNAGAR2_GPIO_USB_UART_RX:
+	case LOCHNAGAR2_GPIO_CDC_PDMCLK1:
+	case LOCHNAGAR2_GPIO_CDC_PDMDAT1:
+	case LOCHNAGAR2_GPIO_CDC_PDMCLK2:
+	case LOCHNAGAR2_GPIO_CDC_PDMDAT2:
+	case LOCHNAGAR2_GPIO_CDC_DMICCLK1:
+	case LOCHNAGAR2_GPIO_CDC_DMICDAT1:
+	case LOCHNAGAR2_GPIO_CDC_DMICCLK2:
+	case LOCHNAGAR2_GPIO_CDC_DMICDAT2:
+	case LOCHNAGAR2_GPIO_CDC_DMICCLK3:
+	case LOCHNAGAR2_GPIO_CDC_DMICDAT3:
+	case LOCHNAGAR2_GPIO_CDC_DMICCLK4:
+	case LOCHNAGAR2_GPIO_CDC_DMICDAT4:
+	case LOCHNAGAR2_GPIO_DSP_DMICCLK1:
+	case LOCHNAGAR2_GPIO_DSP_DMICDAT1:
+	case LOCHNAGAR2_GPIO_DSP_DMICCLK2:
+	case LOCHNAGAR2_GPIO_DSP_DMICDAT2:
+	case LOCHNAGAR2_GPIO_I2C2_SCL:
+	case LOCHNAGAR2_GPIO_I2C2_SDA:
+	case LOCHNAGAR2_GPIO_I2C3_SCL:
+	case LOCHNAGAR2_GPIO_I2C3_SDA:
+	case LOCHNAGAR2_GPIO_I2C4_SCL:
+	case LOCHNAGAR2_GPIO_I2C4_SDA:
+	case LOCHNAGAR2_GPIO_DSP_STANDBY:
+	case LOCHNAGAR2_GPIO_CDC_MCLK1:
+	case LOCHNAGAR2_GPIO_CDC_MCLK2:
+	case LOCHNAGAR2_GPIO_DSP_CLKIN:
+	case LOCHNAGAR2_GPIO_PSIA1_MCLK:
+	case LOCHNAGAR2_GPIO_PSIA2_MCLK:
+	case LOCHNAGAR2_GPIO_GF_GPIO1:
+	case LOCHNAGAR2_GPIO_GF_GPIO5:
+	case LOCHNAGAR2_GPIO_DSP_GPIO20:
+	case LOCHNAGAR2_GPIO_CHANNEL1:
+	case LOCHNAGAR2_GPIO_CHANNEL2:
+	case LOCHNAGAR2_GPIO_CHANNEL3:
+	case LOCHNAGAR2_GPIO_CHANNEL4:
+	case LOCHNAGAR2_GPIO_CHANNEL5:
+	case LOCHNAGAR2_GPIO_CHANNEL6:
+	case LOCHNAGAR2_GPIO_CHANNEL7:
+	case LOCHNAGAR2_GPIO_CHANNEL8:
+	case LOCHNAGAR2_GPIO_CHANNEL9:
+	case LOCHNAGAR2_GPIO_CHANNEL10:
+	case LOCHNAGAR2_GPIO_CHANNEL11:
+	case LOCHNAGAR2_GPIO_CHANNEL12:
+	case LOCHNAGAR2_GPIO_CHANNEL13:
+	case LOCHNAGAR2_GPIO_CHANNEL14:
+	case LOCHNAGAR2_GPIO_CHANNEL15:
+	case LOCHNAGAR2_GPIO_CHANNEL16:
+	case LOCHNAGAR2_MINICARD_RESETS:
+	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
+	case LOCHNAGAR2_ANALOGUE_PATH_CTRL2:
+	case LOCHNAGAR2_COMMS_CTRL4:
+	case LOCHNAGAR2_SPDIF_CTRL:
+	case LOCHNAGAR2_POWER_CTRL:
+	case LOCHNAGAR2_MICVDD_CTRL1:
+	case LOCHNAGAR2_MICVDD_CTRL2:
+	case LOCHNAGAR2_VDDCORE_CDC_CTRL1:
+	case LOCHNAGAR2_VDDCORE_CDC_CTRL2:
+	case LOCHNAGAR2_SOUNDCARD_AIF_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool lochnagar2_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LOCHNAGAR2_GPIO_CHANNEL1:
+	case LOCHNAGAR2_GPIO_CHANNEL2:
+	case LOCHNAGAR2_GPIO_CHANNEL3:
+	case LOCHNAGAR2_GPIO_CHANNEL4:
+	case LOCHNAGAR2_GPIO_CHANNEL5:
+	case LOCHNAGAR2_GPIO_CHANNEL6:
+	case LOCHNAGAR2_GPIO_CHANNEL7:
+	case LOCHNAGAR2_GPIO_CHANNEL8:
+	case LOCHNAGAR2_GPIO_CHANNEL9:
+	case LOCHNAGAR2_GPIO_CHANNEL10:
+	case LOCHNAGAR2_GPIO_CHANNEL11:
+	case LOCHNAGAR2_GPIO_CHANNEL12:
+	case LOCHNAGAR2_GPIO_CHANNEL13:
+	case LOCHNAGAR2_GPIO_CHANNEL14:
+	case LOCHNAGAR2_GPIO_CHANNEL15:
+	case LOCHNAGAR2_GPIO_CHANNEL16:
+	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default lochnagar2_reg_defaults[] = {
+	{ LOCHNAGAR2_CDC_AIF1_CTRL,         0x0000 },
+	{ LOCHNAGAR2_CDC_AIF2_CTRL,         0x0000 },
+	{ LOCHNAGAR2_CDC_AIF3_CTRL,         0x0000 },
+	{ LOCHNAGAR2_DSP_AIF1_CTRL,         0x0000 },
+	{ LOCHNAGAR2_DSP_AIF2_CTRL,         0x0000 },
+	{ LOCHNAGAR2_PSIA1_CTRL,            0x0000 },
+	{ LOCHNAGAR2_PSIA2_CTRL,            0x0000 },
+	{ LOCHNAGAR2_GF_AIF3_CTRL,          0x0000 },
+	{ LOCHNAGAR2_GF_AIF4_CTRL,          0x0000 },
+	{ LOCHNAGAR2_GF_AIF1_CTRL,          0x0000 },
+	{ LOCHNAGAR2_GF_AIF2_CTRL,          0x0000 },
+	{ LOCHNAGAR2_SPDIF_AIF_CTRL,        0x0000 },
+	{ LOCHNAGAR2_USB_AIF1_CTRL,         0x0000 },
+	{ LOCHNAGAR2_USB_AIF2_CTRL,         0x0000 },
+	{ LOCHNAGAR2_ADAT_AIF_CTRL,         0x0000 },
+	{ LOCHNAGAR2_CDC_MCLK1_CTRL,        0x0000 },
+	{ LOCHNAGAR2_CDC_MCLK2_CTRL,        0x0000 },
+	{ LOCHNAGAR2_DSP_CLKIN_CTRL,        0x0000 },
+	{ LOCHNAGAR2_PSIA1_MCLK_CTRL,       0x0000 },
+	{ LOCHNAGAR2_PSIA2_MCLK_CTRL,       0x0000 },
+	{ LOCHNAGAR2_SPDIF_MCLK_CTRL,       0x0000 },
+	{ LOCHNAGAR2_GF_CLKOUT1_CTRL,       0x0000 },
+	{ LOCHNAGAR2_GF_CLKOUT2_CTRL,       0x0000 },
+	{ LOCHNAGAR2_ADAT_MCLK_CTRL,        0x0000 },
+	{ LOCHNAGAR2_SOUNDCARD_MCLK_CTRL,   0x0000 },
+	{ LOCHNAGAR2_GPIO_FPGA_GPIO1,       0x0000 },
+	{ LOCHNAGAR2_GPIO_FPGA_GPIO2,       0x0000 },
+	{ LOCHNAGAR2_GPIO_FPGA_GPIO3,       0x0000 },
+	{ LOCHNAGAR2_GPIO_FPGA_GPIO4,       0x0000 },
+	{ LOCHNAGAR2_GPIO_FPGA_GPIO5,       0x0000 },
+	{ LOCHNAGAR2_GPIO_FPGA_GPIO6,       0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO1,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO2,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO3,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO4,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO5,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO6,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO7,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_GPIO8,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO1,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO2,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO3,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO4,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO5,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO6,        0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_GPIO2,         0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_GPIO3,         0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_GPIO7,         0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF1_BCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF1_RXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF1_LRCLK,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF1_TXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF2_BCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF2_RXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF2_LRCLK,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF2_TXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF3_BCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF3_RXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF3_LRCLK,   0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_AIF3_TXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF1_BCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF1_RXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF1_LRCLK,   0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF1_TXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF2_BCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF2_RXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF2_LRCLK,   0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_AIF2_TXDAT,   0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA1_BCLK,       0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA1_RXDAT,      0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA1_LRCLK,      0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA1_TXDAT,      0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA2_BCLK,       0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA2_RXDAT,      0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA2_LRCLK,      0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA2_TXDAT,      0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF3_BCLK,     0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF3_RXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF3_LRCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF3_TXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF4_BCLK,     0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF4_RXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF4_LRCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF4_TXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF1_BCLK,     0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF1_RXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF1_LRCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF1_TXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF2_BCLK,     0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF2_RXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF2_LRCLK,    0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_AIF2_TXDAT,    0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_UART1_RX,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_UART1_TX,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_UART2_RX,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_UART2_TX,     0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_UART2_RX,      0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_UART2_TX,      0x0000 },
+	{ LOCHNAGAR2_GPIO_USB_UART_RX,      0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_PDMCLK1,      0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_PDMDAT1,      0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_PDMCLK2,      0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_PDMDAT2,      0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICCLK1,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICDAT1,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICCLK2,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICDAT2,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICCLK3,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICDAT3,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICCLK4,     0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_DMICDAT4,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_DMICCLK1,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_DMICDAT1,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_DMICCLK2,     0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_DMICDAT2,     0x0000 },
+	{ LOCHNAGAR2_GPIO_I2C2_SCL,         0x0000 },
+	{ LOCHNAGAR2_GPIO_I2C2_SDA,         0x0000 },
+	{ LOCHNAGAR2_GPIO_I2C3_SCL,         0x0000 },
+	{ LOCHNAGAR2_GPIO_I2C3_SDA,         0x0000 },
+	{ LOCHNAGAR2_GPIO_I2C4_SCL,         0x0000 },
+	{ LOCHNAGAR2_GPIO_I2C4_SDA,         0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_STANDBY,      0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_MCLK1,        0x0000 },
+	{ LOCHNAGAR2_GPIO_CDC_MCLK2,        0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_CLKIN,        0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA1_MCLK,       0x0000 },
+	{ LOCHNAGAR2_GPIO_PSIA2_MCLK,       0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_GPIO1,         0x0000 },
+	{ LOCHNAGAR2_GPIO_GF_GPIO5,         0x0000 },
+	{ LOCHNAGAR2_GPIO_DSP_GPIO20,       0x0000 },
+	{ LOCHNAGAR2_MINICARD_RESETS,       0x0000 },
+	{ LOCHNAGAR2_ANALOGUE_PATH_CTRL2,   0x0000 },
+	{ LOCHNAGAR2_COMMS_CTRL4,           0x0001 },
+	{ LOCHNAGAR2_SPDIF_CTRL,            0x0008 },
+	{ LOCHNAGAR2_POWER_CTRL,            0x0001 },
+	{ LOCHNAGAR2_SOUNDCARD_AIF_CTRL,    0x0000 },
+};
+
+static const struct regmap_config lochnagar2_i2c_regmap = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = 0x1F1F,
+	.readable_reg = lochnagar2_readable_register,
+	.volatile_reg = lochnagar2_volatile_register,
+
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = lochnagar2_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(lochnagar2_reg_defaults),
+};
+
+static const struct reg_sequence lochnagar2_patch[] = {
+	{ 0x00EE, 0x0000 },
+	{ 0x00F0, 0x0001 },
+};
+
+static struct mfd_cell lochnagar2_devs[] = {
+	{
+		.name = "lochnagar-pinctrl",
+	},
+	{
+		.name = "lochnagar2-clk",
+	},
+	{
+		.name = "lochnagar-regulator",
+	},
+	{
+		.name = "lochnagar2-sound-card",
+	},
+};
+
+static struct lochnagar_config {
+	int id;
+	const char * const name;
+	enum lochnagar_type type;
+	const struct regmap_config *regmap;
+	struct mfd_cell *devs;
+	int ndevs;
+	const struct reg_sequence *patch;
+	int npatch;
+} lochnagar_configs[] = {
+	{
+		.id = 0x50,
+		.name = "lochnagar1",
+		.type = LOCHNAGAR1,
+		.regmap = &lochnagar1_i2c_regmap,
+		.devs = lochnagar1_devs,
+		.ndevs = ARRAY_SIZE(lochnagar1_devs),
+		.patch = lochnagar1_patch,
+		.npatch = ARRAY_SIZE(lochnagar1_patch),
+	},
+	{
+		.id = 0xCB58,
+		.name = "lochnagar2",
+		.type = LOCHNAGAR2,
+		.regmap = &lochnagar2_i2c_regmap,
+		.devs = lochnagar2_devs,
+		.ndevs = ARRAY_SIZE(lochnagar2_devs),
+		.patch = lochnagar2_patch,
+		.npatch = ARRAY_SIZE(lochnagar2_patch),
+	},
+};
+
+static const struct of_device_id lochnagar_of_match[] = {
+	{ .compatible = "cirrus,lochnagar1", .data = &lochnagar_configs[0] },
+	{ .compatible = "cirrus,lochnagar2", .data = &lochnagar_configs[1] },
+	{},
+};
+
+static int lochnagar_wait_for_boot(struct regmap *regmap, unsigned int *id)
+{
+	int i, ret;
+
+	for (i = 0; i < LOCHNAGAR_BOOT_RETRIES; ++i) {
+		msleep(LOCHNAGAR_BOOT_DELAY_MS);
+
+		ret = regmap_read(regmap, LOCHNAGAR_SOFTWARE_RESET, id);
+		if (!ret)
+			return ret;
+	}
+
+	return -ETIMEDOUT;
+}
+
+int lochnagar_update_config(struct lochnagar *lochnagar)
+{
+	struct regmap *regmap = lochnagar->regmap;
+	unsigned int done = LOCHNAGAR2_ANALOGUE_PATH_UPDATE_STS_MASK;
+	int timeout_ms = LOCHNAGAR_BOOT_DELAY_MS * LOCHNAGAR_BOOT_RETRIES;
+	unsigned int val = 0;
+	int ret;
+
+	switch (lochnagar->type) {
+	case LOCHNAGAR1:
+		return 0;
+	case LOCHNAGAR2:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write(regmap, LOCHNAGAR2_ANALOGUE_PATH_CTRL1, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(regmap, LOCHNAGAR2_ANALOGUE_PATH_CTRL1,
+			   LOCHNAGAR2_ANALOGUE_PATH_UPDATE_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read_poll_timeout(regmap,
+				       LOCHNAGAR2_ANALOGUE_PATH_CTRL1, val,
+				       (val & done), LOCHNAGAR_CONFIG_POLL_US,
+				       timeout_ms * 1000);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lochnagar_update_config);
+
+static int lochnagar_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	const struct lochnagar_config *config = NULL;
+	const struct of_device_id *of_id;
+	struct lochnagar *lochnagar;
+	unsigned int val;
+	struct gpio_desc *reset, *present;
+	unsigned int firmwareid;
+	int devid, rev;
+	int ret;
+
+	lochnagar = devm_kzalloc(dev, sizeof(*lochnagar), GFP_KERNEL);
+	if (!lochnagar)
+		return -ENOMEM;
+
+	of_id = of_match_device(lochnagar_of_match, dev);
+	if (!of_id)
+		return -EINVAL;
+
+	config = of_id->data;
+
+	lochnagar->dev = dev;
+	mutex_init(&lochnagar->analogue_config_lock);
+
+	dev_set_drvdata(dev, lochnagar);
+
+	reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
+		return ret;
+	}
+
+	present = devm_gpiod_get_optional(dev, "present", GPIOD_OUT_HIGH);
+	if (IS_ERR(present)) {
+		ret = PTR_ERR(present);
+		dev_err(dev, "Failed to get present GPIO: %d\n", ret);
+		return ret;
+	}
+
+	msleep(20);
+
+	/* Bring Lochnagar out of reset */
+	gpiod_set_value_cansleep(reset, 1);
+
+	/* Identify Lochnagar */
+	lochnagar->type = config->type;
+	lochnagar->regmap = devm_regmap_init_i2c(i2c, config->regmap);
+	if (IS_ERR(lochnagar->regmap)) {
+		ret = PTR_ERR(lochnagar->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for Lochnagar to boot */
+	ret = lochnagar_wait_for_boot(lochnagar->regmap, &val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read device ID: %d\n", ret);
+		return ret;
+	}
+
+	devid = val & LOCHNAGAR_DEVICE_ID_MASK;
+	rev = val & LOCHNAGAR_REV_ID_MASK;
+
+	if (devid != config->id) {
+		dev_err(dev,
+			"ID does not match %s (expected 0x%x got 0x%x)\n",
+			config->name, config->id, devid);
+		return -ENODEV;
+	}
+
+	/* Identify firmware */
+	ret = regmap_read(lochnagar->regmap, LOCHNAGAR_FIRMWARE_ID1, &val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read firmware id 1: %d\n", ret);
+		return ret;
+	}
+
+	firmwareid = val;
+
+	ret = regmap_read(lochnagar->regmap, LOCHNAGAR_FIRMWARE_ID2, &val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read firmware id 2: %d\n", ret);
+		return ret;
+	}
+
+	firmwareid |= (val << config->regmap->val_bits);
+
+	dev_info(dev, "Found %s (0x%x) revision %d firmware 0x%.6x\n",
+		 config->name, devid, rev + 1, firmwareid);
+
+	ret = regmap_register_patch(lochnagar->regmap, config->patch,
+				    config->npatch);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register patch: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, config->devs,
+				   config->ndevs, NULL, 0, NULL);
+	if (ret != 0) {
+		dev_err(dev, "Failed to add subdevices: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_of_platform_populate(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to populate child nodes: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct i2c_driver lochnagar_i2c_driver = {
+	.driver = {
+		.name = "lochnagar",
+		.of_match_table = of_match_ptr(lochnagar_of_match),
+		.suppress_bind_attrs = true,
+	},
+
+	.probe_new = lochnagar_i2c_probe,
+};
+
+static int __init lochnagar_i2c_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&lochnagar_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register Lochnagar driver: %d\n", ret);
+
+	return ret;
+}
+subsys_initcall(lochnagar_i2c_init);
diff --git a/include/linux/mfd/lochnagar.h b/include/linux/mfd/lochnagar.h
new file mode 100644
index 0000000000000..be485d6714f7c
--- /dev/null
+++ b/include/linux/mfd/lochnagar.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lochnagar internals
+ *
+ * Copyright (c) 2013-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#ifndef CIRRUS_LOCHNAGAR_H
+#define CIRRUS_LOCHNAGAR_H
+
+#include "lochnagar1_regs.h"
+#include "lochnagar2_regs.h"
+
+struct device;
+struct regmap;
+struct mutex;
+
+enum lochnagar_type {
+	LOCHNAGAR1,
+	LOCHNAGAR2,
+};
+
+struct lochnagar {
+	enum lochnagar_type type;
+	struct device *dev;
+	struct regmap *regmap;
+
+	/* Lock to protect updates to the analogue configuration */
+	struct mutex analogue_config_lock;
+};
+
+/* Register Addresses */
+#define LOCHNAGAR_SOFTWARE_RESET                             0x00
+#define LOCHNAGAR_FIRMWARE_ID1                               0x01
+#define LOCHNAGAR_FIRMWARE_ID2                               0x02
+
+/* (0x0000)  Software Reset */
+#define LOCHNAGAR_DEVICE_ID_MASK                           0xFFFC
+#define LOCHNAGAR_DEVICE_ID_SHIFT                               2
+#define LOCHNAGAR_REV_ID_MASK                              0x0003
+#define LOCHNAGAR_REV_ID_SHIFT                                  0
+
+int lochnagar_update_config(struct lochnagar *lochnagar);
+
+#endif
diff --git a/include/linux/mfd/lochnagar1_regs.h b/include/linux/mfd/lochnagar1_regs.h
new file mode 100644
index 0000000000000..114b846245d96
--- /dev/null
+++ b/include/linux/mfd/lochnagar1_regs.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lochnagar1 register definitions
+ *
+ * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#ifndef LOCHNAGAR1_REGISTERS_H
+#define LOCHNAGAR1_REGISTERS_H
+
+/* Register Addresses */
+#define LOCHNAGAR1_CDC_AIF1_SEL                       0x0008
+#define LOCHNAGAR1_CDC_AIF2_SEL                       0x0009
+#define LOCHNAGAR1_CDC_AIF3_SEL                       0x000A
+#define LOCHNAGAR1_CDC_MCLK1_SEL                      0x000B
+#define LOCHNAGAR1_CDC_MCLK2_SEL                      0x000C
+#define LOCHNAGAR1_CDC_AIF_CTRL1                      0x000D
+#define LOCHNAGAR1_CDC_AIF_CTRL2                      0x000E
+#define LOCHNAGAR1_EXT_AIF_CTRL                       0x000F
+#define LOCHNAGAR1_DSP_AIF1_SEL                       0x0010
+#define LOCHNAGAR1_DSP_AIF2_SEL                       0x0011
+#define LOCHNAGAR1_DSP_CLKIN_SEL                      0x0012
+#define LOCHNAGAR1_DSP_AIF                            0x0013
+#define LOCHNAGAR1_GF_AIF1                            0x0014
+#define LOCHNAGAR1_GF_AIF2                            0x0015
+#define LOCHNAGAR1_PSIA_AIF                           0x0016
+#define LOCHNAGAR1_PSIA1_SEL                          0x0017
+#define LOCHNAGAR1_PSIA2_SEL                          0x0018
+#define LOCHNAGAR1_SPDIF_AIF_SEL                      0x0019
+#define LOCHNAGAR1_GF_AIF3_SEL                        0x001C
+#define LOCHNAGAR1_GF_AIF4_SEL                        0x001D
+#define LOCHNAGAR1_GF_CLKOUT1_SEL                     0x001E
+#define LOCHNAGAR1_GF_AIF1_SEL                        0x001F
+#define LOCHNAGAR1_GF_AIF2_SEL                        0x0020
+#define LOCHNAGAR1_GF_GPIO2                           0x0026
+#define LOCHNAGAR1_GF_GPIO3                           0x0027
+#define LOCHNAGAR1_GF_GPIO7                           0x0028
+#define LOCHNAGAR1_RST                                0x0029
+#define LOCHNAGAR1_LED1                               0x002A
+#define LOCHNAGAR1_LED2                               0x002B
+#define LOCHNAGAR1_I2C_CTRL                           0x0046
+
+/*
+ * (0x0008 - 0x000C, 0x0010 - 0x0012, 0x0017 - 0x0020)
+ * CDC_AIF1_SEL - GF_AIF2_SEL
+ */
+#define LOCHNAGAR1_SRC_MASK                             0xFF
+#define LOCHNAGAR1_SRC_SHIFT                               0
+
+/* (0x000D)  CDC_AIF_CTRL1 */
+#define LOCHNAGAR1_CDC_AIF2_LRCLK_DIR_MASK              0x40
+#define LOCHNAGAR1_CDC_AIF2_LRCLK_DIR_SHIFT                6
+#define LOCHNAGAR1_CDC_AIF2_BCLK_DIR_MASK               0x20
+#define LOCHNAGAR1_CDC_AIF2_BCLK_DIR_SHIFT                 5
+#define LOCHNAGAR1_CDC_AIF2_ENA_MASK                    0x10
+#define LOCHNAGAR1_CDC_AIF2_ENA_SHIFT                      4
+#define LOCHNAGAR1_CDC_AIF1_LRCLK_DIR_MASK              0x04
+#define LOCHNAGAR1_CDC_AIF1_LRCLK_DIR_SHIFT                2
+#define LOCHNAGAR1_CDC_AIF1_BCLK_DIR_MASK               0x02
+#define LOCHNAGAR1_CDC_AIF1_BCLK_DIR_SHIFT                 1
+#define LOCHNAGAR1_CDC_AIF1_ENA_MASK                    0x01
+#define LOCHNAGAR1_CDC_AIF1_ENA_SHIFT                      0
+
+/* (0x000E)  CDC_AIF_CTRL2 */
+#define LOCHNAGAR1_CDC_AIF3_LRCLK_DIR_MASK              0x40
+#define LOCHNAGAR1_CDC_AIF3_LRCLK_DIR_SHIFT                6
+#define LOCHNAGAR1_CDC_AIF3_BCLK_DIR_MASK               0x20
+#define LOCHNAGAR1_CDC_AIF3_BCLK_DIR_SHIFT                 5
+#define LOCHNAGAR1_CDC_AIF3_ENA_MASK                    0x10
+#define LOCHNAGAR1_CDC_AIF3_ENA_SHIFT                      4
+#define LOCHNAGAR1_CDC_MCLK1_ENA_MASK                   0x02
+#define LOCHNAGAR1_CDC_MCLK1_ENA_SHIFT                     1
+#define LOCHNAGAR1_CDC_MCLK2_ENA_MASK                   0x01
+#define LOCHNAGAR1_CDC_MCLK2_ENA_SHIFT                     0
+
+/* (0x000F)  EXT_AIF_CTRL */
+#define LOCHNAGAR1_SPDIF_AIF_LRCLK_DIR_MASK             0x20
+#define LOCHNAGAR1_SPDIF_AIF_LRCLK_DIR_SHIFT               5
+#define LOCHNAGAR1_SPDIF_AIF_BCLK_DIR_MASK              0x10
+#define LOCHNAGAR1_SPDIF_AIF_BCLK_DIR_SHIFT                4
+#define LOCHNAGAR1_SPDIF_AIF_ENA_MASK                   0x08
+#define LOCHNAGAR1_SPDIF_AIF_ENA_SHIFT                     3
+
+/* (0x0013)  DSP_AIF */
+#define LOCHNAGAR1_DSP_AIF2_LRCLK_DIR_MASK              0x40
+#define LOCHNAGAR1_DSP_AIF2_LRCLK_DIR_SHIFT                6
+#define LOCHNAGAR1_DSP_AIF2_BCLK_DIR_MASK               0x20
+#define LOCHNAGAR1_DSP_AIF2_BCLK_DIR_SHIFT                 5
+#define LOCHNAGAR1_DSP_AIF2_ENA_MASK                    0x10
+#define LOCHNAGAR1_DSP_AIF2_ENA_SHIFT                      4
+#define LOCHNAGAR1_DSP_CLKIN_ENA_MASK                   0x08
+#define LOCHNAGAR1_DSP_CLKIN_ENA_SHIFT                     3
+#define LOCHNAGAR1_DSP_AIF1_LRCLK_DIR_MASK              0x04
+#define LOCHNAGAR1_DSP_AIF1_LRCLK_DIR_SHIFT                2
+#define LOCHNAGAR1_DSP_AIF1_BCLK_DIR_MASK               0x02
+#define LOCHNAGAR1_DSP_AIF1_BCLK_DIR_SHIFT                 1
+#define LOCHNAGAR1_DSP_AIF1_ENA_MASK                    0x01
+#define LOCHNAGAR1_DSP_AIF1_ENA_SHIFT                      0
+
+/* (0x0014)  GF_AIF1 */
+#define LOCHNAGAR1_GF_CLKOUT1_ENA_MASK                  0x40
+#define LOCHNAGAR1_GF_CLKOUT1_ENA_SHIFT                    6
+#define LOCHNAGAR1_GF_AIF3_LRCLK_DIR_MASK               0x20
+#define LOCHNAGAR1_GF_AIF3_LRCLK_DIR_SHIFT                 5
+#define LOCHNAGAR1_GF_AIF3_BCLK_DIR_MASK                0x10
+#define LOCHNAGAR1_GF_AIF3_BCLK_DIR_SHIFT                  4
+#define LOCHNAGAR1_GF_AIF3_ENA_MASK                     0x08
+#define LOCHNAGAR1_GF_AIF3_ENA_SHIFT                       3
+#define LOCHNAGAR1_GF_AIF1_LRCLK_DIR_MASK               0x04
+#define LOCHNAGAR1_GF_AIF1_LRCLK_DIR_SHIFT                 2
+#define LOCHNAGAR1_GF_AIF1_BCLK_DIR_MASK                0x02
+#define LOCHNAGAR1_GF_AIF1_BCLK_DIR_SHIFT                  1
+#define LOCHNAGAR1_GF_AIF1_ENA_MASK                     0x01
+#define LOCHNAGAR1_GF_AIF1_ENA_SHIFT                       0
+
+/* (0x0015)  GF_AIF2 */
+#define LOCHNAGAR1_GF_AIF4_LRCLK_DIR_MASK               0x20
+#define LOCHNAGAR1_GF_AIF4_LRCLK_DIR_SHIFT                 5
+#define LOCHNAGAR1_GF_AIF4_BCLK_DIR_MASK                0x10
+#define LOCHNAGAR1_GF_AIF4_BCLK_DIR_SHIFT                  4
+#define LOCHNAGAR1_GF_AIF4_ENA_MASK                     0x08
+#define LOCHNAGAR1_GF_AIF4_ENA_SHIFT                       3
+#define LOCHNAGAR1_GF_AIF2_LRCLK_DIR_MASK               0x04
+#define LOCHNAGAR1_GF_AIF2_LRCLK_DIR_SHIFT                 2
+#define LOCHNAGAR1_GF_AIF2_BCLK_DIR_MASK                0x02
+#define LOCHNAGAR1_GF_AIF2_BCLK_DIR_SHIFT                  1
+#define LOCHNAGAR1_GF_AIF2_ENA_MASK                     0x01
+#define LOCHNAGAR1_GF_AIF2_ENA_SHIFT                       0
+
+/* (0x0016)  PSIA_AIF */
+#define LOCHNAGAR1_PSIA2_LRCLK_DIR_MASK                 0x40
+#define LOCHNAGAR1_PSIA2_LRCLK_DIR_SHIFT                   6
+#define LOCHNAGAR1_PSIA2_BCLK_DIR_MASK                  0x20
+#define LOCHNAGAR1_PSIA2_BCLK_DIR_SHIFT                    5
+#define LOCHNAGAR1_PSIA2_ENA_MASK                       0x10
+#define LOCHNAGAR1_PSIA2_ENA_SHIFT                         4
+#define LOCHNAGAR1_PSIA1_LRCLK_DIR_MASK                 0x04
+#define LOCHNAGAR1_PSIA1_LRCLK_DIR_SHIFT                   2
+#define LOCHNAGAR1_PSIA1_BCLK_DIR_MASK                  0x02
+#define LOCHNAGAR1_PSIA1_BCLK_DIR_SHIFT                    1
+#define LOCHNAGAR1_PSIA1_ENA_MASK                       0x01
+#define LOCHNAGAR1_PSIA1_ENA_SHIFT                         0
+
+/* (0x0029)  RST */
+#define LOCHNAGAR1_DSP_RESET_MASK                       0x02
+#define LOCHNAGAR1_DSP_RESET_SHIFT                         1
+#define LOCHNAGAR1_CDC_RESET_MASK                       0x01
+#define LOCHNAGAR1_CDC_RESET_SHIFT                         0
+
+/* (0x0046)  I2C_CTRL */
+#define LOCHNAGAR1_CDC_CIF_MODE_MASK                    0x01
+#define LOCHNAGAR1_CDC_CIF_MODE_SHIFT                      0
+
+#endif
diff --git a/include/linux/mfd/lochnagar2_regs.h b/include/linux/mfd/lochnagar2_regs.h
new file mode 100644
index 0000000000000..2c6340c3006b7
--- /dev/null
+++ b/include/linux/mfd/lochnagar2_regs.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lochnagar2 register definitions
+ *
+ * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#ifndef LOCHNAGAR2_REGISTERS_H
+#define LOCHNAGAR2_REGISTERS_H
+
+/* Register Addresses */
+#define LOCHNAGAR2_CDC_AIF1_CTRL                      0x000D
+#define LOCHNAGAR2_CDC_AIF2_CTRL                      0x000E
+#define LOCHNAGAR2_CDC_AIF3_CTRL                      0x000F
+#define LOCHNAGAR2_DSP_AIF1_CTRL                      0x0010
+#define LOCHNAGAR2_DSP_AIF2_CTRL                      0x0011
+#define LOCHNAGAR2_PSIA1_CTRL                         0x0012
+#define LOCHNAGAR2_PSIA2_CTRL                         0x0013
+#define LOCHNAGAR2_GF_AIF3_CTRL                       0x0014
+#define LOCHNAGAR2_GF_AIF4_CTRL                       0x0015
+#define LOCHNAGAR2_GF_AIF1_CTRL                       0x0016
+#define LOCHNAGAR2_GF_AIF2_CTRL                       0x0017
+#define LOCHNAGAR2_SPDIF_AIF_CTRL                     0x0018
+#define LOCHNAGAR2_USB_AIF1_CTRL                      0x0019
+#define LOCHNAGAR2_USB_AIF2_CTRL                      0x001A
+#define LOCHNAGAR2_ADAT_AIF_CTRL                      0x001B
+#define LOCHNAGAR2_CDC_MCLK1_CTRL                     0x001E
+#define LOCHNAGAR2_CDC_MCLK2_CTRL                     0x001F
+#define LOCHNAGAR2_DSP_CLKIN_CTRL                     0x0020
+#define LOCHNAGAR2_PSIA1_MCLK_CTRL                    0x0021
+#define LOCHNAGAR2_PSIA2_MCLK_CTRL                    0x0022
+#define LOCHNAGAR2_SPDIF_MCLK_CTRL                    0x0023
+#define LOCHNAGAR2_GF_CLKOUT1_CTRL                    0x0024
+#define LOCHNAGAR2_GF_CLKOUT2_CTRL                    0x0025
+#define LOCHNAGAR2_ADAT_MCLK_CTRL                     0x0026
+#define LOCHNAGAR2_SOUNDCARD_MCLK_CTRL                0x0027
+#define LOCHNAGAR2_GPIO_FPGA_GPIO1                    0x0031
+#define LOCHNAGAR2_GPIO_FPGA_GPIO2                    0x0032
+#define LOCHNAGAR2_GPIO_FPGA_GPIO3                    0x0033
+#define LOCHNAGAR2_GPIO_FPGA_GPIO4                    0x0034
+#define LOCHNAGAR2_GPIO_FPGA_GPIO5                    0x0035
+#define LOCHNAGAR2_GPIO_FPGA_GPIO6                    0x0036
+#define LOCHNAGAR2_GPIO_CDC_GPIO1                     0x0037
+#define LOCHNAGAR2_GPIO_CDC_GPIO2                     0x0038
+#define LOCHNAGAR2_GPIO_CDC_GPIO3                     0x0039
+#define LOCHNAGAR2_GPIO_CDC_GPIO4                     0x003A
+#define LOCHNAGAR2_GPIO_CDC_GPIO5                     0x003B
+#define LOCHNAGAR2_GPIO_CDC_GPIO6                     0x003C
+#define LOCHNAGAR2_GPIO_CDC_GPIO7                     0x003D
+#define LOCHNAGAR2_GPIO_CDC_GPIO8                     0x003E
+#define LOCHNAGAR2_GPIO_DSP_GPIO1                     0x003F
+#define LOCHNAGAR2_GPIO_DSP_GPIO2                     0x0040
+#define LOCHNAGAR2_GPIO_DSP_GPIO3                     0x0041
+#define LOCHNAGAR2_GPIO_DSP_GPIO4                     0x0042
+#define LOCHNAGAR2_GPIO_DSP_GPIO5                     0x0043
+#define LOCHNAGAR2_GPIO_DSP_GPIO6                     0x0044
+#define LOCHNAGAR2_GPIO_GF_GPIO2                      0x0045
+#define LOCHNAGAR2_GPIO_GF_GPIO3                      0x0046
+#define LOCHNAGAR2_GPIO_GF_GPIO7                      0x0047
+#define LOCHNAGAR2_GPIO_CDC_AIF1_BCLK                 0x0048
+#define LOCHNAGAR2_GPIO_CDC_AIF1_RXDAT                0x0049
+#define LOCHNAGAR2_GPIO_CDC_AIF1_LRCLK                0x004A
+#define LOCHNAGAR2_GPIO_CDC_AIF1_TXDAT                0x004B
+#define LOCHNAGAR2_GPIO_CDC_AIF2_BCLK                 0x004C
+#define LOCHNAGAR2_GPIO_CDC_AIF2_RXDAT                0x004D
+#define LOCHNAGAR2_GPIO_CDC_AIF2_LRCLK                0x004E
+#define LOCHNAGAR2_GPIO_CDC_AIF2_TXDAT                0x004F
+#define LOCHNAGAR2_GPIO_CDC_AIF3_BCLK                 0x0050
+#define LOCHNAGAR2_GPIO_CDC_AIF3_RXDAT                0x0051
+#define LOCHNAGAR2_GPIO_CDC_AIF3_LRCLK                0x0052
+#define LOCHNAGAR2_GPIO_CDC_AIF3_TXDAT                0x0053
+#define LOCHNAGAR2_GPIO_DSP_AIF1_BCLK                 0x0054
+#define LOCHNAGAR2_GPIO_DSP_AIF1_RXDAT                0x0055
+#define LOCHNAGAR2_GPIO_DSP_AIF1_LRCLK                0x0056
+#define LOCHNAGAR2_GPIO_DSP_AIF1_TXDAT                0x0057
+#define LOCHNAGAR2_GPIO_DSP_AIF2_BCLK                 0x0058
+#define LOCHNAGAR2_GPIO_DSP_AIF2_RXDAT                0x0059
+#define LOCHNAGAR2_GPIO_DSP_AIF2_LRCLK                0x005A
+#define LOCHNAGAR2_GPIO_DSP_AIF2_TXDAT                0x005B
+#define LOCHNAGAR2_GPIO_PSIA1_BCLK                    0x005C
+#define LOCHNAGAR2_GPIO_PSIA1_RXDAT                   0x005D
+#define LOCHNAGAR2_GPIO_PSIA1_LRCLK                   0x005E
+#define LOCHNAGAR2_GPIO_PSIA1_TXDAT                   0x005F
+#define LOCHNAGAR2_GPIO_PSIA2_BCLK                    0x0060
+#define LOCHNAGAR2_GPIO_PSIA2_RXDAT                   0x0061
+#define LOCHNAGAR2_GPIO_PSIA2_LRCLK                   0x0062
+#define LOCHNAGAR2_GPIO_PSIA2_TXDAT                   0x0063
+#define LOCHNAGAR2_GPIO_GF_AIF3_BCLK                  0x0064
+#define LOCHNAGAR2_GPIO_GF_AIF3_RXDAT                 0x0065
+#define LOCHNAGAR2_GPIO_GF_AIF3_LRCLK                 0x0066
+#define LOCHNAGAR2_GPIO_GF_AIF3_TXDAT                 0x0067
+#define LOCHNAGAR2_GPIO_GF_AIF4_BCLK                  0x0068
+#define LOCHNAGAR2_GPIO_GF_AIF4_RXDAT                 0x0069
+#define LOCHNAGAR2_GPIO_GF_AIF4_LRCLK                 0x006A
+#define LOCHNAGAR2_GPIO_GF_AIF4_TXDAT                 0x006B
+#define LOCHNAGAR2_GPIO_GF_AIF1_BCLK                  0x006C
+#define LOCHNAGAR2_GPIO_GF_AIF1_RXDAT                 0x006D
+#define LOCHNAGAR2_GPIO_GF_AIF1_LRCLK                 0x006E
+#define LOCHNAGAR2_GPIO_GF_AIF1_TXDAT                 0x006F
+#define LOCHNAGAR2_GPIO_GF_AIF2_BCLK                  0x0070
+#define LOCHNAGAR2_GPIO_GF_AIF2_RXDAT                 0x0071
+#define LOCHNAGAR2_GPIO_GF_AIF2_LRCLK                 0x0072
+#define LOCHNAGAR2_GPIO_GF_AIF2_TXDAT                 0x0073
+#define LOCHNAGAR2_GPIO_DSP_UART1_RX                  0x0074
+#define LOCHNAGAR2_GPIO_DSP_UART1_TX                  0x0075
+#define LOCHNAGAR2_GPIO_DSP_UART2_RX                  0x0076
+#define LOCHNAGAR2_GPIO_DSP_UART2_TX                  0x0077
+#define LOCHNAGAR2_GPIO_GF_UART2_RX                   0x0078
+#define LOCHNAGAR2_GPIO_GF_UART2_TX                   0x0079
+#define LOCHNAGAR2_GPIO_USB_UART_RX                   0x007A
+#define LOCHNAGAR2_GPIO_CDC_PDMCLK1                   0x007C
+#define LOCHNAGAR2_GPIO_CDC_PDMDAT1                   0x007D
+#define LOCHNAGAR2_GPIO_CDC_PDMCLK2                   0x007E
+#define LOCHNAGAR2_GPIO_CDC_PDMDAT2                   0x007F
+#define LOCHNAGAR2_GPIO_CDC_DMICCLK1                  0x0080
+#define LOCHNAGAR2_GPIO_CDC_DMICDAT1                  0x0081
+#define LOCHNAGAR2_GPIO_CDC_DMICCLK2                  0x0082
+#define LOCHNAGAR2_GPIO_CDC_DMICDAT2                  0x0083
+#define LOCHNAGAR2_GPIO_CDC_DMICCLK3                  0x0084
+#define LOCHNAGAR2_GPIO_CDC_DMICDAT3                  0x0085
+#define LOCHNAGAR2_GPIO_CDC_DMICCLK4                  0x0086
+#define LOCHNAGAR2_GPIO_CDC_DMICDAT4                  0x0087
+#define LOCHNAGAR2_GPIO_DSP_DMICCLK1                  0x0088
+#define LOCHNAGAR2_GPIO_DSP_DMICDAT1                  0x0089
+#define LOCHNAGAR2_GPIO_DSP_DMICCLK2                  0x008A
+#define LOCHNAGAR2_GPIO_DSP_DMICDAT2                  0x008B
+#define LOCHNAGAR2_GPIO_I2C2_SCL                      0x008C
+#define LOCHNAGAR2_GPIO_I2C2_SDA                      0x008D
+#define LOCHNAGAR2_GPIO_I2C3_SCL                      0x008E
+#define LOCHNAGAR2_GPIO_I2C3_SDA                      0x008F
+#define LOCHNAGAR2_GPIO_I2C4_SCL                      0x0090
+#define LOCHNAGAR2_GPIO_I2C4_SDA                      0x0091
+#define LOCHNAGAR2_GPIO_DSP_STANDBY                   0x0092
+#define LOCHNAGAR2_GPIO_CDC_MCLK1                     0x0093
+#define LOCHNAGAR2_GPIO_CDC_MCLK2                     0x0094
+#define LOCHNAGAR2_GPIO_DSP_CLKIN                     0x0095
+#define LOCHNAGAR2_GPIO_PSIA1_MCLK                    0x0096
+#define LOCHNAGAR2_GPIO_PSIA2_MCLK                    0x0097
+#define LOCHNAGAR2_GPIO_GF_GPIO1                      0x0098
+#define LOCHNAGAR2_GPIO_GF_GPIO5                      0x0099
+#define LOCHNAGAR2_GPIO_DSP_GPIO20                    0x009A
+#define LOCHNAGAR2_GPIO_CHANNEL1                      0x00B9
+#define LOCHNAGAR2_GPIO_CHANNEL2                      0x00BA
+#define LOCHNAGAR2_GPIO_CHANNEL3                      0x00BB
+#define LOCHNAGAR2_GPIO_CHANNEL4                      0x00BC
+#define LOCHNAGAR2_GPIO_CHANNEL5                      0x00BD
+#define LOCHNAGAR2_GPIO_CHANNEL6                      0x00BE
+#define LOCHNAGAR2_GPIO_CHANNEL7                      0x00BF
+#define LOCHNAGAR2_GPIO_CHANNEL8                      0x00C0
+#define LOCHNAGAR2_GPIO_CHANNEL9                      0x00C1
+#define LOCHNAGAR2_GPIO_CHANNEL10                     0x00C2
+#define LOCHNAGAR2_GPIO_CHANNEL11                     0x00C3
+#define LOCHNAGAR2_GPIO_CHANNEL12                     0x00C4
+#define LOCHNAGAR2_GPIO_CHANNEL13                     0x00C5
+#define LOCHNAGAR2_GPIO_CHANNEL14                     0x00C6
+#define LOCHNAGAR2_GPIO_CHANNEL15                     0x00C7
+#define LOCHNAGAR2_GPIO_CHANNEL16                     0x00C8
+#define LOCHNAGAR2_MINICARD_RESETS                    0x00DF
+#define LOCHNAGAR2_ANALOGUE_PATH_CTRL1                0x00E3
+#define LOCHNAGAR2_ANALOGUE_PATH_CTRL2                0x00E4
+#define LOCHNAGAR2_COMMS_CTRL4                        0x00F0
+#define LOCHNAGAR2_SPDIF_CTRL                         0x00FE
+#define LOCHNAGAR2_POWER_CTRL                         0x0116
+#define LOCHNAGAR2_MICVDD_CTRL1                       0x0119
+#define LOCHNAGAR2_MICVDD_CTRL2                       0x011B
+#define LOCHNAGAR2_VDDCORE_CDC_CTRL1                  0x011E
+#define LOCHNAGAR2_VDDCORE_CDC_CTRL2                  0x0120
+#define LOCHNAGAR2_SOUNDCARD_AIF_CTRL                 0x0180
+
+/* (0x000D-0x001B, 0x0180)  CDC_AIF1_CTRL - SOUNCARD_AIF_CTRL */
+#define LOCHNAGAR2_AIF_ENA_MASK                       0x8000
+#define LOCHNAGAR2_AIF_ENA_SHIFT                          15
+#define LOCHNAGAR2_AIF_LRCLK_DIR_MASK                 0x4000
+#define LOCHNAGAR2_AIF_LRCLK_DIR_SHIFT                    14
+#define LOCHNAGAR2_AIF_BCLK_DIR_MASK                  0x2000
+#define LOCHNAGAR2_AIF_BCLK_DIR_SHIFT                     13
+#define LOCHNAGAR2_AIF_SRC_MASK                       0x00FF
+#define LOCHNAGAR2_AIF_SRC_SHIFT                           0
+
+/* (0x001E - 0x0027)  CDC_MCLK1_CTRL - SOUNDCARD_MCLK_CTRL */
+#define LOCHNAGAR2_CLK_ENA_MASK                       0x8000
+#define LOCHNAGAR2_CLK_ENA_SHIFT                          15
+#define LOCHNAGAR2_CLK_DIR_MASK                       0x4000
+#define LOCHNAGAR2_CLK_DIR_SHIFT                          14
+#define LOCHNAGAR2_CLK_SRC_MASK                       0x00FF
+#define LOCHNAGAR2_CLK_SRC_SHIFT                           0
+
+/* (0x0031 - 0x009A)  GPIO_FPGA_GPIO1 - GPIO_DSP_GPIO20 */
+#define LOCHNAGAR2_GPIO_SRC_MASK                      0x00FF
+#define LOCHNAGAR2_GPIO_SRC_SHIFT                          0
+
+/* (0x00B9 - 0x00C8)  GPIO_CHANNEL1 - GPIO_CHANNEL16 */
+#define LOCHNAGAR2_GPIO_CHANNEL_STS_MASK              0x8000
+#define LOCHNAGAR2_GPIO_CHANNEL_STS_SHIFT                 15
+#define LOCHNAGAR2_GPIO_CHANNEL_SRC_MASK              0x00FF
+#define LOCHNAGAR2_GPIO_CHANNEL_SRC_SHIFT                  0
+
+/* (0x00DF)  MINICARD_RESETS */
+#define LOCHNAGAR2_DSP_RESET_MASK                     0x0002
+#define LOCHNAGAR2_DSP_RESET_SHIFT                         1
+#define LOCHNAGAR2_CDC_RESET_MASK                     0x0001
+#define LOCHNAGAR2_CDC_RESET_SHIFT                         0
+
+/* (0x00E3)  ANALOGUE_PATH_CTRL1 */
+#define LOCHNAGAR2_ANALOGUE_PATH_UPDATE_MASK          0x8000
+#define LOCHNAGAR2_ANALOGUE_PATH_UPDATE_SHIFT             15
+#define LOCHNAGAR2_ANALOGUE_PATH_UPDATE_STS_MASK      0x4000
+#define LOCHNAGAR2_ANALOGUE_PATH_UPDATE_STS_SHIFT         14
+
+/* (0x00E4)  ANALOGUE_PATH_CTRL2 */
+#define LOCHNAGAR2_P2_INPUT_BIAS_ENA_MASK             0x0080
+#define LOCHNAGAR2_P2_INPUT_BIAS_ENA_SHIFT                 7
+#define LOCHNAGAR2_P1_INPUT_BIAS_ENA_MASK             0x0040
+#define LOCHNAGAR2_P1_INPUT_BIAS_ENA_SHIFT                 6
+#define LOCHNAGAR2_P2_MICBIAS_SRC_MASK                0x0038
+#define LOCHNAGAR2_P2_MICBIAS_SRC_SHIFT                    3
+#define LOCHNAGAR2_P1_MICBIAS_SRC_MASK                0x0007
+#define LOCHNAGAR2_P1_MICBIAS_SRC_SHIFT                    0
+
+/* (0x00F0)  COMMS_CTRL4 */
+#define LOCHNAGAR2_CDC_CIF1MODE_MASK                  0x0001
+#define LOCHNAGAR2_CDC_CIF1MODE_SHIFT                      0
+
+/* (0x00FE)  SPDIF_CTRL */
+#define LOCHNAGAR2_SPDIF_HWMODE_MASK                  0x0008
+#define LOCHNAGAR2_SPDIF_HWMODE_SHIFT                      3
+#define LOCHNAGAR2_SPDIF_RESET_MASK                   0x0001
+#define LOCHNAGAR2_SPDIF_RESET_SHIFT                       0
+
+/* (0x0116)  POWER_CTRL */
+#define LOCHNAGAR2_PWR_ENA_MASK                       0x0001
+#define LOCHNAGAR2_PWR_ENA_SHIFT                           0
+
+/* (0x0119)  MICVDD_CTRL1 */
+#define LOCHNAGAR2_MICVDD_REG_ENA_MASK                0x8000
+#define LOCHNAGAR2_MICVDD_REG_ENA_SHIFT                   15
+
+/* (0x011B)  MICVDD_CTRL2 */
+#define LOCHNAGAR2_MICVDD_VSEL_MASK                   0x001F
+#define LOCHNAGAR2_MICVDD_VSEL_SHIFT                       0
+
+/* (0x011E)  VDDCORE_CDC_CTRL1 */
+#define LOCHNAGAR2_VDDCORE_CDC_REG_ENA_MASK           0x8000
+#define LOCHNAGAR2_VDDCORE_CDC_REG_ENA_SHIFT              15
+
+/* (0x0120)  VDDCORE_CDC_CTRL2 */
+#define LOCHNAGAR2_VDDCORE_CDC_VSEL_MASK              0x007F
+#define LOCHNAGAR2_VDDCORE_CDC_VSEL_SHIFT                  0
+
+#endif
-- 
2.11.0

