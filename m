Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64855218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anmKynuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfBMTkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:40:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36877 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbfBMTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:40:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so3673722wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-description
         :content-disposition:user-agent;
        bh=CZ9apr+eyhfGs2tDk9OQ4Ylv401DwQ0Rbmzf2JqJXjo=;
        b=anmKynuwNlJr6ZOVRODcmE0GXccvfo8OYLT7jiFL/atbzd5fg8iKt6pBKEfvt4yhd4
         95+Z6mbktnZYouL4DqfpijQjGoj2Nkyc+600mLZZFcn6/qa1Wn3mxE1pD30qBg0zbi2A
         WZWzLhr4cpAk9YfDXMTy4ImVQd8/Z8hbMJ7qEIxH2OdjKZd8S/aTJu3CXmFrMi+yxWMK
         TUMdmHhGkM6J2lslupWPlsWlqp3gL5m3lMDQBIBhan8ofUptKmAwwNQPJDAjiWtqi/ib
         ayUpvWW1DFfQAdAvQA3+Nn5pARAjlP3YH3I6+K0q247g3x1+YHNyuGywWS7Ww/7JVhH7
         YVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-description:content-disposition:user-agent;
        bh=CZ9apr+eyhfGs2tDk9OQ4Ylv401DwQ0Rbmzf2JqJXjo=;
        b=g0YjEWd4k+NdD5fSJsLcYuerbeVrRtx61k50vje8ROhxCiMMXtLU9FEjcHuHfRYJsi
         swI1izPyqBmp07fSHoSVfKGhPgmNiPBvhvssEmQG11GqJqNqidJZpBhfnq6xeg4Pfmnt
         IJa6U5FGbdCPL7hrSHpV/muoBJ22QtjVo01pnIrFoH8KizBFspxc/s2sscu+iL+Tx8Sp
         HCkhiz3+Y6ubvdnCZ9qjxhTG8EePq5L7iMwfzH+61C+3x1toAZmPU6KxydOE5A6M+dNN
         TvTHjNlyz/pk9SyAIJCm8tXC/SVsdnuxfIFoYXu0br8hyFaRIGRAfmaeeNZ8/VUKpkG8
         f7oQ==
X-Gm-Message-State: AHQUAuZKecSVPC/ktLV/0I0O1umXvPWWys0qCEX+cQNI5+LAOibiraUL
        hao7BGZo0FC04YPrbXne2pc=
X-Google-Smtp-Source: AHgI3IYLknE8uP9Twj/OHz7Gc2l8sFMkWuWVJa1id/PHH8hA57nJ9ibLV/nFq2qPkrjiRc62B05jLw==
X-Received: by 2002:a1c:7fcb:: with SMTP id a194mr1140721wmd.51.1550086838552;
        Wed, 13 Feb 2019 11:40:38 -0800 (PST)
Received: from metis.ciupak.eu ([31.130.108.122])
        by smtp.gmail.com with ESMTPSA id l21sm83962wme.38.2019.02.13.11.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 11:40:37 -0800 (PST)
Date:   Wed, 13 Feb 2019 20:40:35 +0100
From:   Marcin Ciupak <marcin.s.ciupak@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: nrf24: add new driver for 2.4GHz radio
 transceiver
Message-ID: <20190213194035.n2ldlt7xque5qaps@metis.ciupak.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: evel@driverdev.osuosl.org,
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver for Nordic Semiconductor nRF24L01+ radio
transceiver.

Signed-off-by: Marcin Ciupak <marcin.s.ciupak@gmail.com>
---
Changes in v2:
  - add terminating newlines to all logging formats
Changes in v3:
  - patch subject
  - comments cleanup
  - goto labels cleanup
  - scnprintf bugfix
  - ida_simple_remove bugfix
Changes in v4:
  - fix smatch warnings

drivers/staging/Kconfig                       |   2 +
 drivers/staging/Makefile                      |   1 +
 drivers/staging/nrf24/Kconfig                 |  16 +
 drivers/staging/nrf24/Makefile                |   3 +
 drivers/staging/nrf24/TODO                    |   7 +
 .../nrf24/devicetree/nrf24-spi0-overlay.dts   |  54 ++
 .../nrf24/devicetree/nrf24-spi1-overlay.dts   |  54 ++
 drivers/staging/nrf24/devicetree/nrf24.txt    |   1 +
 drivers/staging/nrf24/nRF24L01.h              |  82 ++
 drivers/staging/nrf24/nrf24_enums.h           |  60 ++
 drivers/staging/nrf24/nrf24_hal.c             | 764 +++++++++++++++
 drivers/staging/nrf24/nrf24_hal.h             |  54 ++
 drivers/staging/nrf24/nrf24_if.c              | 893 ++++++++++++++++++
 drivers/staging/nrf24/nrf24_if.h              |  63 ++
 drivers/staging/nrf24/nrf24_sysfs.c           | 707 ++++++++++++++
 drivers/staging/nrf24/nrf24_sysfs.h           |  14 +
 16 files changed, 2775 insertions(+)
 create mode 100644 drivers/staging/nrf24/Kconfig
 create mode 100644 drivers/staging/nrf24/Makefile
 create mode 100644 drivers/staging/nrf24/TODO
 create mode 100644 drivers/staging/nrf24/devicetree/nrf24-spi0-overlay.dts
 create mode 100644 drivers/staging/nrf24/devicetree/nrf24-spi1-overlay.dts
 create mode 100644 drivers/staging/nrf24/devicetree/nrf24.txt
 create mode 100644 drivers/staging/nrf24/nRF24L01.h
 create mode 100644 drivers/staging/nrf24/nrf24_enums.h
 create mode 100644 drivers/staging/nrf24/nrf24_hal.c
 create mode 100644 drivers/staging/nrf24/nrf24_hal.h
 create mode 100644 drivers/staging/nrf24/nrf24_if.c
 create mode 100644 drivers/staging/nrf24/nrf24_if.h
 create mode 100644 drivers/staging/nrf24/nrf24_sysfs.c
 create mode 100644 drivers/staging/nrf24/nrf24_sysfs.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index c0901b96cfe4..8473823aaa6f 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -124,4 +124,6 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/erofs/Kconfig"
 
+source "drivers/staging/nrf24/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 57c6bce13ff4..10709ab6f42c 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
+obj-$(CONFIG_NRF24)		+= nrf24/
diff --git a/drivers/staging/nrf24/Kconfig b/drivers/staging/nrf24/Kconfig
new file mode 100644
index 000000000000..67ebf14dd982
--- /dev/null
+++ b/drivers/staging/nrf24/Kconfig
@@ -0,0 +1,16 @@
+config NRF24
+        tristate "nRF24L01+ 2.4GHz radio module support"
+        depends on SPI
+        help
+          This enables support for Nordic Semiconductor nRF24L01+ radio module,
+          with the following features:
+            - multiple radio module instances via nrfX
+            - dedicated /dev/nrfX.Y device per pipe per instance
+            - dynamic and static payload lengths
+            - configuration via sysfs (/sys/class/nrfX)
+            - poll mechanism
+            - 64kB RX FIFO per pipe
+            - 64kB TX FIFO
+
+          To compile this driver as a module, choose M here: the module will be
+          called nrf24.
diff --git a/drivers/staging/nrf24/Makefile b/drivers/staging/nrf24/Makefile
new file mode 100644
index 000000000000..f5222567c632
--- /dev/null
+++ b/drivers/staging/nrf24/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_NRF24) += nrf24.o
+
+nrf24-objs := nrf24_if.o nrf24_hal.o nrf24_sysfs.o
diff --git a/drivers/staging/nrf24/TODO b/drivers/staging/nrf24/TODO
new file mode 100644
index 000000000000..a089e43faac5
--- /dev/null
+++ b/drivers/staging/nrf24/TODO
@@ -0,0 +1,7 @@
+Todo:
+- opening and closing pipes via sysfs
+- improve switching in between RX and TX
+- improve handling of MAX_RT interrupt
+- find and fix bugs
+- code cleanup
+
diff --git a/drivers/staging/nrf24/devicetree/nrf24-spi0-overlay.dts b/drivers/staging/nrf24/devicetree/nrf24-spi0-overlay.dts
new file mode 100644
index 000000000000..130e6787b76d
--- /dev/null
+++ b/drivers/staging/nrf24/devicetree/nrf24-spi0-overlay.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//
+// Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+//
+
+// Definitions for NRF24
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible = "bcm,bcm2835", "bcm,bcm2708", "bcm,bcm2709";
+
+	fragment@0 {
+		target = <&spi0>;
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+
+			spidev@0 {
+				status = "disabled";
+			};
+
+			nrf0: nrf0@0 {
+				compatible = "nordic,nrf24";
+				reg = <0>; /* CS0 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&nrf0_pins>;
+				interrupt-parent = <&gpio>;
+				interrupts = <24 0x2>; /* falling edge */
+				irq-gpio = <&gpio 24 0>;
+				ce-gpio = <&gpio 25 0>;
+				spi-max-frequency = <5000000>;
+				status = "okay";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&gpio>;
+		__overlay__ {
+			nrf0_pins: nrf0_pins {
+				brcm,pins = <24 25>;
+				brcm,function = <0 1>; /* in out */
+			};
+		};
+	};
+
+	__overrides__ {
+		int_pin = <&nrf0>, "interrupts:0", <&nrf0_pins>, "brcm,pins:0";
+		speed   = <&nrf0>, "spi-max-frequency:0";
+	};
+};
diff --git a/drivers/staging/nrf24/devicetree/nrf24-spi1-overlay.dts b/drivers/staging/nrf24/devicetree/nrf24-spi1-overlay.dts
new file mode 100644
index 000000000000..ff07507d0a14
--- /dev/null
+++ b/drivers/staging/nrf24/devicetree/nrf24-spi1-overlay.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//
+// Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+//
+
+/* Definitions for NRF24 */
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible = "bcm,bcm2835", "bcm,bcm2708", "bcm,bcm2709";
+
+	fragment@0 {
+		target = <&spi1>;
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+
+			spidev@0 {
+				status = "disabled";
+			};
+
+			nrf1: nrf1@0 {
+				compatible = "nordic,nrf24";
+				reg = <0>; /* CS0 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&nrf1_pins>;
+				interrupt-parent = <&gpio>;
+				interrupts = <17 0x2>; /* falling edge */
+				irq-gpio = <&gpio 17 0>;
+				ce-gpio = <&gpio 27 0>;
+				spi-max-frequency = <5000000>;
+				status = "okay";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&gpio>;
+		__overlay__ {
+			nrf1_pins: nrf1_pins {
+				brcm,pins = <17 27>;
+				brcm,function = <0 1>; // in out
+			};
+		};
+	};
+
+	__overrides__ {
+		int_pin = <&nrf1>, "interrupts:0", <&nrf1_pins>, "brcm,pins:0";
+		speed   = <&nrf1>, "spi-max-frequency:0";
+	};
+};
diff --git a/drivers/staging/nrf24/devicetree/nrf24.txt b/drivers/staging/nrf24/devicetree/nrf24.txt
new file mode 100644
index 000000000000..0eff8bfae97f
--- /dev/null
+++ b/drivers/staging/nrf24/devicetree/nrf24.txt
@@ -0,0 +1 @@
+scripts/dtc/dtc -@ -I dts -O dtb -o nrf24-spi0.dtbo nrf24-spi0-overlay.dts
diff --git a/drivers/staging/nrf24/nRF24L01.h b/drivers/staging/nrf24/nRF24L01.h
new file mode 100644
index 000000000000..ed7fac6c9c38
--- /dev/null
+++ b/drivers/staging/nrf24/nRF24L01.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#ifndef NRF24L01_H
+#define NRF24L01_H
+
+/* nRF24L01 Register map */
+
+#define CONFIG			0x00
+#define EN_AA			0x01
+#define EN_RXADDR		0x02
+#define SETUP_AW		0x03
+#define SETUP_RETR		0x04
+#define RF_CH			0x05
+#define RF_SETUP		0x06
+#define STATUS			0x07
+#define OBSERVE_TX		0x08
+#define	CD			0x09
+#define RX_ADDR_P0		0x0A
+#define RX_ADDR_P1		0x0B
+#define RX_ADDR_P2		0x0C
+#define RX_ADDR_P3		0x0D
+#define RX_ADDR_P4		0x0E
+#define RX_ADDR_P5		0x0F
+#define TX_ADDR			0x10
+#define RX_PW_P0		0x11
+#define RX_PW_P1		0x12
+#define RX_PW_P2		0x13
+#define RX_PW_P3		0x14
+#define RX_PW_P4		0x15
+#define RX_PW_P5		0x16
+#define FIFO_STATUS		0x17
+#define DYNPD			0x1C
+#define FEATURE			0x1D
+
+/* nRF24L01 Instruction Definitions */
+#define W_REGISTER		0x20
+#define R_RX_PL_WID		0x60
+#define R_RX_PAYLOAD		0x61
+#define W_TX_PAYLOAD		0xA0
+#define W_ACK_PAYLOAD		0xA8
+#define W_TX_PAYLOAD_NOACK	0xB0
+#define FLUSH_TX		0xE1
+#define FLUSH_RX		0xE2
+#define REUSE_TX_PL		0xE3
+#define LOCK_UNLOCK		0x50
+#define NOP			0xFF
+
+/* CONFIG 0x00 */
+#define MASK_RX_DR		0x40
+#define MASK_TX_DS		0x20
+#define MASK_MAX_RT		0x10
+#define EN_CRC			0x08
+#define CRCO			0x04
+#define PWR_UP			0x02
+#define PRIM_RX			0x01
+
+/* RF_SETUP 0x06 */
+#define RF_DR_LO		0x20
+#define PLL_LOCK		0x10
+#define RF_DR_HI		0x08
+#define RF_PWR1			0x04
+#define RF_PWR0			0x02
+
+/* STATUS 0x07 */
+#define RX_DR			0x40
+#define TX_DS			0x20
+#define MAX_RT			0x10
+#define TX_FULL			0x01
+
+/* FEATURE 0x1D */
+#define EN_DPL			0x04
+#define EN_ACK_PAY		0x02
+#define EN_DYN_ACK		0x01
+
+#define PLOAD_MAX		32
+
+#endif
diff --git a/drivers/staging/nrf24/nrf24_enums.h b/drivers/staging/nrf24/nrf24_enums.h
new file mode 100644
index 000000000000..89f35db370b6
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_enums.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#ifndef NRF24_ENUMS_H
+#define NRF24_ENUMS_H
+
+enum nrf24_pipe_num {
+	NRF24_PIPE0,
+	NRF24_PIPE1,
+	NRF24_PIPE2,
+	NRF24_PIPE3,
+	NRF24_PIPE4,
+	NRF24_PIPE5,
+	NRF24_TX,
+	NRF24_PIPE_ALL = 0xFF
+};
+
+enum nrf24_crc_mode {
+	NRF24_CRC_OFF,
+	NRF24_CRC_8BIT = 2,
+	NRF24_CRC_16BIT
+};
+
+enum nrf24_address_width {
+	NRF24_AW_3 = 3,
+	NRF24_AW_4,
+	NRF24_AW_5
+};
+
+enum nrf24_pload {
+	NRF24_TX_PLOAD = 7,
+	NRF24_TX_PLOAD_NOACK,
+	NRF24_RX_PLOAD,
+	NRF24_ACK_PLOAD
+};
+
+enum nrf24_datarate {
+	NRF24_DATARATE_1MBPS,
+	NRF24_DATARATE_2MBPS,
+	NRF24_DATARATE_256KBPS
+};
+
+enum nrf24_mode {
+	NRF24_MODE_TX,
+	NRF24_MODE_RX
+};
+
+enum nrf24_rf_power {
+	NRF24_POWER_18DBM,
+	NRF24_POWER_12DBM,
+	NRF24_POWER_6DBM,
+	NRF24_POWER_0DBM
+};
+
+#endif
+
diff --git a/drivers/staging/nrf24/nrf24_hal.c b/drivers/staging/nrf24/nrf24_hal.c
new file mode 100644
index 000000000000..0d2242276d40
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_hal.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/spi/spi.h>
+
+#include "nrf24_hal.h"
+
+static ssize_t nrf24_read_reg(struct spi_device *spi, u8 addr)
+{
+	ssize_t ret;
+
+	ret = spi_w8r8(spi, addr);
+
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: read 0x%X FAILED\n", __func__, addr);
+
+	return ret;
+}
+
+static ssize_t nrf24_write_reg(struct spi_device *spi, u8 addr, u8 val)
+{
+	ssize_t ret;
+	u8 buffer[2];
+
+	buffer[0] = addr;
+	buffer[1] = val;
+
+	if (addr < W_REGISTER) {
+		buffer[0] = buffer[0] + W_REGISTER;
+		ret = spi_write(spi, buffer, 2);
+	} else if (addr != FLUSH_TX &&
+		   addr != FLUSH_RX &&
+		   addr != REUSE_TX_PL) {
+		ret = spi_write(spi, buffer, 2);
+	} else {
+		ret = spi_write(spi, buffer, 1);
+	}
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: write 0x%X to 0x%X  FAILED\n",
+			__func__, val, addr);
+
+	return ret;
+}
+
+static ssize_t nrf24_write_multireg(struct spi_device *spi,
+				    u8 reg,
+				    u8 *buf,
+				    u8 length)
+{
+	u8 buffer[PLOAD_MAX + 1];
+
+	if (!length)
+		return -EINVAL;
+
+	switch (reg) {
+	case NRF24_PIPE0:
+	case NRF24_PIPE1:
+	case NRF24_TX:
+		buffer[0] = W_REGISTER + RX_ADDR_P0 + reg;
+		break;
+	case NRF24_TX_PLOAD:
+		buffer[0] = W_TX_PAYLOAD;
+		break;
+	case NRF24_TX_PLOAD_NOACK:
+		buffer[0] = W_TX_PAYLOAD_NOACK;
+		break;
+	default:
+		dev_dbg(&spi->dev, "%s: invalid parameter\n", __func__);
+		return -EINVAL;
+	}
+
+	memcpy(buffer + 1, buf, length);
+
+	return spi_write(spi, buffer, length + 1);
+}
+
+static ssize_t nrf24_read_multireg(struct spi_device *spi, u8 reg, u8 *buf)
+{
+	ssize_t ret;
+	u8 reg_addr;
+	ssize_t length = 0;
+
+	switch (reg) {
+	case NRF24_PIPE0:
+	case NRF24_PIPE1:
+	case NRF24_TX:
+		length = nrf24_get_address_width(spi);
+		if (length < 0)
+			return length;
+		reg_addr = RX_ADDR_P0 + reg;
+		break;
+	case NRF24_RX_PLOAD:
+		ret = nrf24_get_rx_data_source(spi);
+		if (ret < 0)
+			return ret;
+
+		if (ret < NRF24_TX_PLOAD) {
+			length = nrf24_get_rx_pl_w(spi);
+			if (length < 0)
+				return length;
+			reg_addr = R_RX_PAYLOAD;
+		}
+		break;
+	default:
+		dev_dbg(&spi->dev, "%s: invalid parameter\n", __func__);
+		return -EINVAL;
+	}
+
+	if (length > 0) {
+		ret = spi_write_then_read(spi,
+					  &reg_addr,
+					  1,
+					  buf,
+					  length);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return length;
+}
+
+ssize_t nrf24_get_dynamic_pl(struct spi_device *spi)
+{
+	ssize_t feature;
+
+	feature = nrf24_read_reg(spi, FEATURE);
+	if (feature < 0)
+		return feature;
+
+	return (feature & EN_DPL) == EN_DPL;
+}
+
+ssize_t nrf24_enable_dynamic_pl(struct spi_device *spi)
+{
+	ssize_t feature;
+
+	feature = nrf24_read_reg(spi, FEATURE);
+	if (feature < 0)
+		return feature;
+	return nrf24_write_reg(spi, FEATURE, feature | EN_DPL);
+}
+
+ssize_t nrf24_disable_dynamic_pl(struct spi_device *spi)
+{
+	ssize_t feature;
+
+	feature = nrf24_read_reg(spi, FEATURE);
+	if (feature < 0)
+		return feature;
+	return nrf24_write_reg(spi, FEATURE, feature & ~EN_DPL);
+}
+
+static ssize_t nrf24_setup_dynamic_pl(struct spi_device *spi,
+				      u8 pipe,
+				      bool enable)
+{
+	ssize_t dynpd;
+	ssize_t ret;
+
+	if (pipe != NRF24_PIPE0 && enable) {
+		ret = nrf24_setup_dynamic_pl(spi, NRF24_PIPE0, enable);
+		if (ret < 0)
+			return ret;
+	}
+	dynpd = nrf24_read_reg(spi, DYNPD);
+	if (dynpd < 0)
+		return dynpd;
+
+	if (enable) {
+		ret = nrf24_setup_auto_ack(spi, pipe, enable);
+		if (ret < 0)
+			return ret;
+
+		dynpd |= BIT(pipe);
+	} else {
+		dynpd &= ~BIT(pipe);
+	}
+	ret = nrf24_write_reg(spi, DYNPD, dynpd);
+	if (ret < 0)
+		return ret;
+
+	if (dynpd)
+		ret = nrf24_enable_dynamic_pl(spi);
+	else
+		ret = nrf24_disable_dynamic_pl(spi);
+
+	return ret;
+}
+
+ssize_t nrf24_setup_auto_ack(struct spi_device *spi, u8 pipe, bool enable)
+{
+	ssize_t aa;
+
+	aa = nrf24_read_reg(spi, EN_AA);
+	if (aa < 0)
+		return aa;
+	if (enable)
+		aa |= BIT(pipe);
+	else
+		aa &= ~BIT(pipe);
+
+	return nrf24_write_reg(spi, EN_AA, aa);
+}
+
+static ssize_t nrf24_enable_pipe(struct spi_device *spi, u8 pipe)
+{
+	ssize_t rxaddr;
+
+	rxaddr = nrf24_read_reg(spi, EN_RXADDR);
+	if (rxaddr < 0)
+		return rxaddr;
+	return nrf24_write_reg(spi, EN_RXADDR, rxaddr | BIT(pipe));
+}
+
+static ssize_t nrf24_disable_pipe(struct spi_device *spi, u8 pipe)
+{
+	ssize_t rxaddr;
+
+	rxaddr = nrf24_read_reg(spi, EN_RXADDR);
+	if (rxaddr < 0)
+		return rxaddr;
+	return nrf24_write_reg(spi, EN_RXADDR, rxaddr & ~BIT(pipe));
+}
+
+ssize_t nrf24_open_pipe(struct spi_device *spi, enum nrf24_pipe_num pipe)
+{
+	ssize_t ret = -EINVAL;
+
+	switch (pipe) {
+	case NRF24_PIPE0:
+	case NRF24_PIPE1:
+	case NRF24_PIPE2:
+	case NRF24_PIPE3:
+	case NRF24_PIPE4:
+	case NRF24_PIPE5:
+		ret = nrf24_enable_pipe(spi, pipe);
+		break;
+	case NRF24_PIPE_ALL:
+		ret = nrf24_write_reg(spi, EN_RXADDR, 0x3F);
+		break;
+	default:
+		dev_dbg(&spi->dev, "%s: invalid parameter\n", __func__);
+	}
+
+	return ret;
+}
+
+ssize_t nrf24_close_pipe(struct spi_device *spi, enum nrf24_pipe_num pipe)
+{
+	ssize_t ret = -EINVAL;
+
+	switch (pipe) {
+	case NRF24_PIPE0:
+	case NRF24_PIPE1:
+	case NRF24_PIPE2:
+	case NRF24_PIPE3:
+	case NRF24_PIPE4:
+	case NRF24_PIPE5:
+		ret = nrf24_disable_pipe(spi, pipe);
+		if (ret < 0)
+			break;
+		ret = nrf24_setup_auto_ack(spi, pipe, false);
+		break;
+	case NRF24_PIPE_ALL:
+		ret = nrf24_write_reg(spi, EN_RXADDR, 0x00);
+		if (ret)
+			break;
+		ret = nrf24_write_reg(spi, EN_AA, 0x00);
+		break;
+	default:
+		dev_dbg(&spi->dev, "%s: invalid parameter\n", __func__);
+	}
+
+	return ret;
+}
+
+ssize_t nrf24_set_address(struct spi_device *spi,
+			  enum nrf24_pipe_num pipe,
+			  u8 *addr)
+{
+	ssize_t ret = -EINVAL;
+	ssize_t length;
+
+	switch (pipe) {
+	case NRF24_TX:
+	case NRF24_PIPE0:
+	case NRF24_PIPE1:
+		length = nrf24_get_address_width(spi);
+		if (length < 0)
+			return length;
+		ret = nrf24_write_multireg(spi, pipe, addr, length);
+		break;
+	case NRF24_PIPE2:
+	case NRF24_PIPE3:
+	case NRF24_PIPE4:
+	case NRF24_PIPE5:
+		ret = nrf24_write_reg(spi, RX_ADDR_P0 + pipe, *addr);
+		break;
+	default:
+		dev_dbg(&spi->dev, "%s: invalid parameter\n", __func__);
+	}
+
+	return ret;
+}
+
+ssize_t nrf24_get_address(struct spi_device *spi,
+			  enum nrf24_pipe_num pipe,
+			  u8 *addr)
+{
+	ssize_t ret;
+	ssize_t length;
+
+	switch (pipe) {
+	case NRF24_PIPE0:
+	case NRF24_PIPE1:
+	case NRF24_TX:
+		ret = nrf24_read_multireg(spi, pipe, addr);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		length = nrf24_read_multireg(spi, NRF24_PIPE1, addr);
+		if (length < 0)
+			return length;
+		ret = nrf24_read_reg(spi, RX_ADDR_P0 + pipe);
+		if (ret < 0)
+			return ret;
+		*(addr) = ret;
+		break;
+	}
+
+	return nrf24_get_address_width(spi);
+}
+
+ssize_t nrf24_set_crc_mode(struct spi_device *spi, enum nrf24_crc_mode mode)
+{
+	ssize_t config;
+
+	config = nrf24_read_reg(spi, CONFIG);
+	if (config < 0)
+		return config;
+	config &= ~(EN_CRC | CRCO);
+	config |= (mode << 2);
+
+	config = nrf24_write_reg(spi, CONFIG, config);
+
+	return config;
+}
+
+ssize_t nrf24_get_crc_mode(struct spi_device *spi)
+{
+	ssize_t config;
+
+	config = nrf24_read_reg(spi, CONFIG);
+	if (config < 0)
+		return config;
+	config &= (EN_CRC | CRCO);
+	config >>= 2;
+
+	return config;
+}
+
+ssize_t nrf24_set_auto_retr_delay(struct spi_device *spi, u16 delay)
+{
+	ssize_t retr;
+
+	retr = nrf24_read_reg(spi, SETUP_RETR);
+	if (retr < 0)
+		return retr;
+
+	retr &= 0x0F;
+	retr |= (((delay / 250) - 1) << 4);
+
+	return nrf24_write_reg(spi, SETUP_RETR, retr);
+}
+
+ssize_t nrf24_get_auto_retr_delay(struct spi_device *spi)
+{
+	ssize_t retr;
+
+	retr = nrf24_read_reg(spi, SETUP_RETR);
+	if (retr < 0)
+		return retr;
+
+	return ((retr >> 4) + 1) * 250;
+}
+
+ssize_t nrf24_set_auto_retr_count(struct spi_device *spi, u8 count)
+{
+	ssize_t retr;
+
+	retr = nrf24_read_reg(spi, SETUP_RETR);
+	if (retr < 0)
+		return retr;
+
+	retr &= 0xF0;
+	retr |= (count & 0x0F);
+
+	return nrf24_write_reg(spi, SETUP_RETR, retr);
+}
+
+ssize_t nrf24_get_auto_retr_count(struct spi_device *spi)
+{
+	ssize_t retr;
+
+	retr = nrf24_read_reg(spi, SETUP_RETR);
+
+	if (retr < 0)
+		return retr;
+
+	return retr & 0x0F;
+}
+
+ssize_t nrf24_set_address_width(struct spi_device *spi,
+				enum nrf24_address_width aw)
+{
+	return nrf24_write_reg(spi, SETUP_AW, aw - 2);
+}
+
+ssize_t nrf24_get_address_width(struct spi_device *spi)
+{
+	return nrf24_read_reg(spi, SETUP_AW) + 2;
+}
+
+ssize_t nrf24_lock_unlock(struct spi_device *spi)
+{
+	return nrf24_write_reg(spi, LOCK_UNLOCK, 0x73);
+}
+
+ssize_t nrf24_set_datarate(struct spi_device *spi, enum nrf24_datarate datarate)
+{
+	ssize_t rf;
+
+	rf = nrf24_read_reg(spi, RF_SETUP);
+	if (rf < 0)
+		return rf;
+	if (datarate == NRF24_DATARATE_1MBPS)
+		rf &= ~RF_DR_HI;
+	else
+		rf |= RF_DR_HI;
+
+	return nrf24_write_reg(spi, RF_SETUP, rf);
+}
+
+ssize_t nrf24_get_datarate(struct spi_device *spi)
+{
+	ssize_t rf;
+	ssize_t lo;
+	ssize_t hi;
+
+	rf = nrf24_read_reg(spi, RF_SETUP);
+	if (rf < 0)
+		return rf;
+
+	lo = rf & RF_DR_LO;
+	hi = rf & RF_DR_HI;
+
+	if (lo && hi)
+		return -EINVAL;
+	if (lo)
+		return NRF24_DATARATE_256KBPS;
+	if (hi)
+		return NRF24_DATARATE_2MBPS;
+	return NRF24_DATARATE_1MBPS;
+}
+
+ssize_t nrf24_set_mode(struct spi_device *spi, enum nrf24_mode mode)
+{
+	ssize_t config;
+
+	config = nrf24_read_reg(spi, CONFIG);
+
+	if (config < 0)
+		return config;
+
+	if (mode == NRF24_MODE_RX)
+		config |= PRIM_RX;
+	else
+		config &= ~PRIM_RX;
+
+	return nrf24_write_reg(spi, CONFIG, config);
+}
+
+ssize_t nrf24_set_rf_power(struct spi_device *spi, enum nrf24_rf_power rf_pwr)
+{
+	ssize_t rf_setup;
+
+	rf_setup = nrf24_read_reg(spi, RF_SETUP);
+
+	if (rf_setup < 0)
+		return rf_setup;
+
+	rf_setup &= ~(RF_PWR1 | RF_PWR0);
+	rf_setup |= (rf_pwr << 1);
+
+	return nrf24_write_reg(spi, RF_SETUP, rf_setup);
+}
+
+ssize_t nrf24_get_rf_power(struct spi_device *spi)
+{
+	ssize_t rf;
+
+	rf = nrf24_read_reg(spi, RF_SETUP);
+
+	if (rf < 0)
+		return rf;
+
+	rf &= (RF_PWR1 | RF_PWR0);
+	rf >>= 1;
+
+	return rf;
+}
+
+//plw = 0 -> dynamic
+ssize_t nrf24_set_rx_pload_width(struct spi_device *spi, u8 pipe, u8 plw)
+{
+	ssize_t ret;
+
+	if (plw > PLOAD_MAX)
+		return -EINVAL;
+
+	ret = nrf24_write_reg(spi, RX_PW_P0 + pipe, plw);
+	if (ret < 0)
+		return ret;
+
+	return nrf24_setup_dynamic_pl(spi, pipe, plw == 0);
+}
+
+ssize_t nrf24_set_rf_channel(struct spi_device *spi, u8 channel)
+{
+	return nrf24_write_reg(spi, RF_CH, channel);
+}
+
+ssize_t nrf24_power_up(struct spi_device *spi)
+{
+	ssize_t config;
+
+	config = nrf24_read_reg(spi, CONFIG);
+
+	if (config < 0)
+		return config;
+
+	return nrf24_write_reg(spi, CONFIG, config | PWR_UP);
+}
+
+ssize_t nrf24_write_tx_pload(struct spi_device *dev, u8 *buf, u8 length)
+{
+	return nrf24_write_multireg(dev, NRF24_TX_PLOAD, buf, length);
+}
+
+ssize_t nrf24_write_tx_pload_noack(struct spi_device *dev, u8 *buf, u8 length)
+{
+	return nrf24_write_multireg(dev, NRF24_TX_PLOAD_NOACK, buf, length);
+}
+
+ssize_t nrf24_read_rx_pload(struct spi_device *spi, u8 *buf)
+{
+	return nrf24_read_multireg(spi, NRF24_RX_PLOAD, buf);
+}
+
+ssize_t nrf24_get_status(struct spi_device *spi)
+{
+	return nrf24_read_reg(spi, STATUS);
+}
+
+ssize_t nrf24_get_rx_data_source(struct spi_device *spi)
+{
+	ssize_t status;
+
+	status = nrf24_get_status(spi);
+	if (status < 0)
+		return status;
+	return (status & 0x0E) >> 1;
+}
+
+ssize_t nrf24_get_rx_pload_width(struct spi_device *spi, u8 pipe)
+{
+	return nrf24_read_reg(spi, RX_PW_P0 + pipe);
+}
+
+ssize_t nrf24_get_rx_pl_w(struct spi_device *spi)
+{
+	return nrf24_read_reg(spi, R_RX_PL_WID);
+}
+
+ssize_t nrf24_soft_reset(struct spi_device *spi)
+{
+	ssize_t ret;
+	u8 addr0[5] = {0xE7, 0xE7, 0xE7, 0xE7, 0xE7};
+	u8 addr1[5] = {0xC2, 0xC2, 0xC2, 0xC2, 0xC2};
+
+	ret = nrf24_write_reg(spi, CONFIG, 0x08);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, EN_AA, 0x3F);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, EN_RXADDR, 0x03);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, SETUP_AW, 0x03);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, SETUP_RETR, 0x03);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RF_CH, 0x02);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RF_SETUP, 0x07);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, STATUS, 0x70);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_address(spi, NRF24_PIPE0, addr0);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_address(spi, NRF24_PIPE1, addr1);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_ADDR_P2, 0xC3);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_ADDR_P3, 0xC4);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_ADDR_P4, 0xC5);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_ADDR_P5, 0xC6);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_address(spi, NRF24_TX, addr0);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_PW_P0, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_PW_P1, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_PW_P2, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_PW_P3, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_PW_P4, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, RX_PW_P5, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, DYNPD, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_write_reg(spi, FEATURE, 0x00);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+ssize_t nrf24_clear_irq(struct spi_device *spi, u8 irq)
+{
+	return nrf24_write_reg(spi, STATUS, irq);
+}
+
+ssize_t nrf24_flush_fifo(struct spi_device *spi)
+{
+	ssize_t ret;
+
+	ret = nrf24_write_reg(spi, FLUSH_RX, 0);
+	if (ret < 0)
+		return ret;
+	return nrf24_write_reg(spi, FLUSH_TX, 0);
+}
+
+ssize_t nrf24_print_status(struct spi_device *spi)
+{
+const u8 nrf_reg[] = {
+	CONFIG,
+	EN_AA,
+	EN_RXADDR,
+	SETUP_AW,
+	SETUP_RETR,
+	RF_CH,
+	RF_SETUP,
+	STATUS,
+	OBSERVE_TX,
+	CD,
+	FIFO_STATUS,
+	DYNPD,
+	FEATURE
+};
+
+char *nrf_reg_name[] = {
+	"CONFIG",
+	"EN_AA",
+	"EN_RXADDR",
+	"SETUP_AW",
+	"SETUP_RETR",
+	"RF_CH",
+	"RF_SETUP",
+	"STATUS",
+	"OBSERVE_TX",
+	"CD",
+	"FIFO_STATUS",
+	"DYNPD",
+	"FEATURE"
+};
+
+	ssize_t loop;
+	ssize_t ret;
+
+	for (loop = 0; loop < 13; loop++) {
+		ret = spi_w8r8(spi, nrf_reg[loop]);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(&spi->dev,
+			"%s: %s = 0%02zx\n",
+			__func__,
+			nrf_reg_name[loop],
+			ret);
+	}
+
+	return 0;
+}
+
+ssize_t nrf24_get_auto_ack(struct spi_device *spi, u8 pipe)
+{
+	ssize_t aa;
+
+	aa = nrf24_read_reg(spi, EN_AA);
+	if (aa < 0)
+		return aa;
+
+	return (aa & BIT(pipe)) == BIT(pipe);
+}
+
+ssize_t nrf24_is_rx_fifo_empty(struct spi_device *spi)
+{
+	ssize_t fifo;
+
+	fifo = nrf24_read_reg(spi, FIFO_STATUS);
+	if (fifo < 0)
+		return fifo;
+
+	return fifo & 0x01;
+}
+
+ssize_t nrf24_reuse_tx_pl(struct spi_device *spi)
+{
+	return nrf24_write_reg(spi, REUSE_TX_PL, 0);
+}
+
diff --git a/drivers/staging/nrf24/nrf24_hal.h b/drivers/staging/nrf24/nrf24_hal.h
new file mode 100644
index 000000000000..ce7fc190e286
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_hal.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#ifndef NRF24_HAL_H
+#define NRF24_HAL_H
+
+#include "nRF24L01.h"
+#include "nrf24_enums.h"
+
+ssize_t nrf24_open_pipe(struct spi_device *spi, enum nrf24_pipe_num pipe);
+ssize_t nrf24_close_pipe(struct spi_device *spi, enum nrf24_pipe_num pipe);
+ssize_t nrf24_set_address(struct spi_device *spi, enum nrf24_pipe_num pipe, u8 *addr);
+ssize_t nrf24_get_address(struct spi_device *spi, enum nrf24_pipe_num pipe, u8 *addr);
+ssize_t nrf24_set_crc_mode(struct spi_device *spi, enum nrf24_crc_mode mode);
+ssize_t nrf24_get_crc_mode(struct spi_device *spi);
+ssize_t nrf24_set_auto_retr_count(struct spi_device *spi, u8 count);
+ssize_t nrf24_get_auto_retr_count(struct spi_device *spi);
+ssize_t nrf24_set_auto_retr_delay(struct spi_device *spi, u16 delay);
+ssize_t nrf24_get_auto_retr_delay(struct spi_device *spi);
+ssize_t nrf24_set_address_width(struct spi_device *spi, enum nrf24_address_width aw);
+ssize_t nrf24_get_address_width(struct spi_device *spi);
+ssize_t nrf24_lock_unlock(struct spi_device *spi);
+ssize_t nrf24_set_datarate(struct spi_device *spi, enum nrf24_datarate datarate);
+ssize_t nrf24_get_datarate(struct spi_device *spi);
+ssize_t nrf24_set_mode(struct spi_device *spi, enum nrf24_mode mode);
+ssize_t nrf24_set_rf_power(struct spi_device *spi, enum nrf24_rf_power rf_pwr);
+ssize_t nrf24_get_rf_power(struct spi_device *spi);
+ssize_t nrf24_set_rx_pload_width(struct spi_device *spi, u8 pipe_no, u8 plw);
+ssize_t nrf24_set_rf_channel(struct spi_device *spi, u8 channel);
+ssize_t nrf24_write_tx_pload(struct spi_device *dev, u8 *buf, u8 length);
+ssize_t nrf24_write_tx_pload_noack(struct spi_device *dev, u8 *buf, u8 length);
+ssize_t nrf24_read_rx_pload(struct spi_device *spi, u8 *buf);
+ssize_t nrf24_power_up(struct spi_device *spi);
+ssize_t nrf24_get_status(struct spi_device *spi);
+ssize_t nrf24_get_rx_data_source(struct spi_device *spi);
+ssize_t nrf24_get_rx_pload_width(struct spi_device *spi, u8 pipe);
+ssize_t nrf24_soft_reset(struct spi_device *spi);
+ssize_t nrf24_clear_irq(struct spi_device *spi, u8 irq);
+ssize_t nrf24_flush_fifo(struct spi_device *spi);
+ssize_t nrf24_get_rx_pl_w(struct spi_device *spi);
+ssize_t nrf24_print_status(struct spi_device *spi);
+ssize_t nrf24_get_auto_ack(struct spi_device *spi, u8 pipe);
+ssize_t nrf24_setup_auto_ack(struct spi_device *spi, u8 pipe, bool enable);
+ssize_t nrf24_is_rx_fifo_empty(struct spi_device *spi);
+ssize_t nrf24_reuse_tx_pl(struct spi_device *spi);
+ssize_t nrf24_get_dynamic_pl(struct spi_device *spi);
+ssize_t nrf24_enable_dynamic_pl(struct spi_device *spi);
+ssize_t nrf24_disable_dynamic_pl(struct spi_device *spi);
+
+#endif
diff --git a/drivers/staging/nrf24/nrf24_if.c b/drivers/staging/nrf24/nrf24_if.c
new file mode 100644
index 000000000000..b40188b329d0
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_if.c
@@ -0,0 +1,893 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/spi/spi.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/kfifo.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/list.h>
+
+#include "nrf24_if.h"
+#include "nrf24_sysfs.h"
+#include "nrf24_hal.h"
+
+#define N_NRF24_MINORS                  BIT(MINORBITS)
+
+static dev_t nrf24_dev;
+static DEFINE_IDA(nrf24_ida_pipe);
+static DEFINE_IDA(nrf24_ida_dev);
+static struct class *nrf24_class;
+
+ATTRIBUTE_GROUPS(nrf24_pipe);
+ATTRIBUTE_GROUPS(nrf24);
+
+static bool nrf24_is_rx_active(struct nrf24_device *device)
+{
+	struct nrf24_pipe *pipe;
+
+	bool active = false;
+
+	list_for_each_entry(pipe, &device->pipes, list)
+		active |= pipe->rx_size > 0;
+
+	return active;
+}
+
+static void nrf24_ce_hi(struct nrf24_device *device)
+{
+	gpiod_set_value(device->ce, 1);
+}
+
+static void nrf24_ce_lo(struct nrf24_device *device)
+{
+	gpiod_set_value(device->ce, 0);
+}
+
+static struct nrf24_pipe *nrf24_find_pipe_id(struct nrf24_device *device, int id)
+{
+	struct nrf24_pipe *pipe;
+
+	list_for_each_entry(pipe, &device->pipes, list)
+		if (pipe->id == id)
+			return pipe;
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int nrf24_tx_thread(void *data)
+{
+	struct nrf24_device *device = data;
+	struct nrf24_pipe *p;
+	u8 pload[PLOAD_MAX];
+	int ret;
+	ssize_t size;
+	ssize_t pload_length;
+	ssize_t sent = 0;
+	u8 *buf;
+	bool spl;
+	bool dpl = false;
+
+	while (true) {
+		dev_dbg(&device->dev,
+			"%s: waiting for new messages\n",
+			__func__);
+		wait_event_interruptible(device->tx_wait_queue,
+					 kthread_should_stop() ||
+					 (!nrf24_is_rx_active(device) && !kfifo_is_empty(&device->tx_fifo)));
+
+		if (kthread_should_stop())
+			return 0;
+
+		device->tx_done = false;
+
+		//fifo lock is needed as write to tx fifo may be done by 6 pipes
+		mutex_lock(&device->tx_fifo_mutex);
+
+		ret = kfifo_out(&device->tx_fifo, &p, sizeof(p));
+		if (ret != sizeof(p)) {
+			dev_dbg(&device->dev, "get pipe from fifo failed\n");
+			mutex_unlock(&device->tx_fifo_mutex);
+			continue;
+		}
+
+		ret = kfifo_out(&device->tx_fifo, &size, sizeof(size));
+		if (ret != sizeof(size)) {
+			dev_dbg(&device->dev, "get size from fifo failed\n");
+			mutex_unlock(&device->tx_fifo_mutex);
+			continue;
+		}
+
+		buf = kzalloc(size, GFP_KERNEL);
+		if (!buf) {
+			dev_dbg(&device->dev, "buf alloc failed\n");
+			mutex_unlock(&device->tx_fifo_mutex);
+			continue;
+		}
+
+		ret = kfifo_out(&device->tx_fifo, buf, size);
+		if (ret != size) {
+			dev_dbg(&device->dev, "get buf from fifo failed\n");
+			mutex_unlock(&device->tx_fifo_mutex);
+			goto next;
+		}
+
+		mutex_unlock(&device->tx_fifo_mutex);
+
+		//enter Standby-I mode
+		nrf24_ce_lo(device);
+
+		ret = nrf24_set_mode(device->spi, NRF24_MODE_TX);
+		if (ret < 0)
+			goto next;
+
+		//set PIPE0 address in order to receive ACK
+		ret = nrf24_set_address(device->spi,
+					NRF24_PIPE0,
+					(u8 *)&p->cfg.address);
+		if (ret < 0) {
+			dev_dbg(&device->dev, "set PIPE0 address failed (%d)\n", ret);
+			goto next;
+		}
+
+		ret = nrf24_set_address(device->spi,
+					NRF24_TX,
+					(u8 *)&p->cfg.address);
+		if (ret < 0) {
+			dev_dbg(&device->dev, "set TX address failed (%d)\n", ret);
+			goto next;
+		}
+
+		//check if pipe uses static payload length
+		spl = p->cfg.plw != 0;
+
+		//check if dynamic payload length is enabled
+		dpl = nrf24_get_dynamic_pl(device->spi);
+
+		if (spl && dpl) {
+			//disable dynamic payload if pipe
+			//does not use dynamic payload
+			//and dynamic paload is enabled
+			ret = nrf24_disable_dynamic_pl(device->spi);
+			if (ret < 0)
+				goto next;
+		}
+
+		memset(pload, 0, PLOAD_MAX);
+		memcpy(pload, &size, sizeof(size));
+
+		//calculate payload length
+		pload_length = spl ? p->cfg.plw : sizeof(size);
+
+		//send size
+		nrf24_write_tx_pload(device->spi, pload, pload_length);
+		if (ret < 0) {
+			dev_dbg(&device->dev, "write TX PLOAD failed (%d)\n", ret);
+			goto next;
+		}
+
+		//enter TX MODE and start transmission
+		nrf24_ce_hi(device);
+
+		//wait for ACK
+		wait_event_interruptible(device->tx_done_wait_queue,
+					 (device->tx_done ||
+					 kthread_should_stop()));
+
+		if (kthread_should_stop())
+			goto abort;
+
+		sent = 0;
+
+		while (size > 0) {
+			pload_length = spl ? p->cfg.plw : min_t(ssize_t, size, PLOAD_MAX);
+
+			dev_dbg(&device->dev, "tx %zd bytes\n", pload_length);
+
+			memset(pload, 0, PLOAD_MAX);
+			memcpy(pload, buf + sent, pload_length);
+
+			ret = nrf24_write_tx_pload(device->spi, pload, pload_length);
+
+			if (ret < 0) {
+				dev_dbg(&device->dev,
+					"write TX PLOAD failed (%d)\n",
+					ret);
+				goto next;
+			}
+
+			sent += pload_length;
+			size -= pload_length;
+
+			device->tx_done = false;
+
+			//wait for ACK
+			wait_event_interruptible(device->tx_done_wait_queue,
+						 (device->tx_done ||
+						 kthread_should_stop()));
+
+			if (kthread_should_stop())
+				goto abort;
+		}
+next:
+		kfree(buf);
+
+		//restore dynamic payload feature
+		if (dpl)
+			nrf24_enable_dynamic_pl(device->spi);
+
+		//if all sent enter RX MODE and start receiving
+		if (kfifo_is_empty(&device->tx_fifo)) {
+			dev_dbg(&device->dev, "%s: NRF24_MODE_RX\n", __func__);
+
+			//enter Standby-I
+			nrf24_ce_lo(device);
+
+			p = nrf24_find_pipe_id(device, NRF24_PIPE0);
+			if (!IS_ERR(p)) {
+				//restore PIPE0 address as it was corrupted
+				nrf24_set_address(device->spi,
+						  p->id,
+						  (u8 *)&p->cfg.address);
+			}
+
+			nrf24_set_mode(device->spi, NRF24_MODE_RX);
+			nrf24_ce_hi(device);
+		}
+	}
+abort:
+	kfree(buf);
+
+	return 0;
+}
+
+static int nrf24_rx_thread(void *data)
+{
+	struct nrf24_device *device = data;
+	ssize_t pipe;
+	ssize_t length;
+	u8 pload[PLOAD_MAX];
+	struct nrf24_pipe *p;
+
+	while (true) {
+		wait_event_interruptible(device->rx_wait_queue,
+					 (!nrf24_is_rx_fifo_empty(device->spi) ||
+					 kthread_should_stop()));
+		if (kthread_should_stop())
+			return 0;
+
+		pipe = nrf24_get_rx_data_source(device->spi);
+		if (pipe < 0) {
+			dev_dbg(&device->dev,
+				"%s: get pipe failed (err: %zd)\n",
+				__func__,
+				pipe);
+			continue;
+		}
+
+		if (pipe > NRF24_PIPE5) {
+			dev_dbg(&device->dev,
+				"%s: RX FIFO is empty!\n",
+				__func__);
+			continue;
+		}
+
+		p = nrf24_find_pipe_id(device, pipe);
+		if (IS_ERR(p))
+			continue;
+
+		memset(pload, 0, PLOAD_MAX);
+		length = nrf24_read_rx_pload(device->spi, pload);
+		if (length < 0) {
+			dev_dbg(&device->dev,
+				"%s: could not read pload (err = %zd)\n",
+				__func__,
+				length);
+			continue;
+		}
+
+		dev_dbg(p->dev, "rx %zd bytes\n", length);
+		if (p->rx_size <= 0) {
+			memcpy(&p->rx_size, pload, sizeof(p->rx_size));
+			dev_dbg(p->dev, "RX active\n");
+		} else {
+			length = p->rx_size < p->cfg.plw ? p->rx_size : length;
+
+			p->rx_size -= kfifo_in(&p->rx_fifo, &pload, length);
+
+			if (p->rx_size <= 0) {
+				dev_dbg(p->dev, "RX done\n");
+				wake_up_interruptible(&p->poll_wait_queue);
+			}
+		}
+
+		//start tx if all rx done and tx requested during active rx
+		if (!nrf24_is_rx_active(device) && !kfifo_is_empty(&device->tx_fifo)) {
+			dev_dbg(&device->dev, "wake up TX...\n");
+			wake_up_interruptible(&device->tx_wait_queue);
+		}
+	}
+}
+
+static void nrf24_isr_work_handler(struct work_struct *work)
+{
+	struct nrf24_device *device;
+	ssize_t status;
+
+	device = container_of(work, struct nrf24_device, isr_work);
+
+	status = nrf24_get_status(device->spi);
+	if (status < 0)
+		return;
+
+	if (status & RX_DR) {
+		dev_dbg(&device->dev, "%s: RX_DR\n", __func__);
+		nrf24_clear_irq(device->spi, RX_DR);
+		wake_up_interruptible(&device->rx_wait_queue);
+	}
+
+	if (status & TX_DS) {
+		dev_dbg(&device->dev, "%s: TX_DS\n", __func__);
+		nrf24_clear_irq(device->spi, TX_DS);
+		device->tx_done = true;
+		wake_up_interruptible(&device->tx_done_wait_queue);
+	}
+
+	if (status & MAX_RT) {
+		nrf24_ce_lo(device);
+		dev_dbg_ratelimited(&device->dev, "%s: MAX_RT\n", __func__);
+		nrf24_clear_irq(device->spi, MAX_RT);
+		nrf24_reuse_tx_pl(device->spi);
+		nrf24_ce_hi(device);
+	}
+}
+
+static irqreturn_t nrf24_isr(int irq, void *dev_id)
+{
+	unsigned long flags;
+	struct nrf24_device *device = dev_id;
+
+	spin_lock_irqsave(&device->lock, flags);
+
+	schedule_work(&device->isr_work);
+
+	spin_unlock_irqrestore(&device->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t nrf24_read(struct file *filp,
+			  char __user *buf,
+			  size_t size,
+			  loff_t *f_pos)
+{
+	struct nrf24_pipe *p;
+	unsigned int copied;
+	ssize_t n;
+
+	p = filp->private_data;
+
+	if (kfifo_is_empty(&p->rx_fifo) && (filp->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	n = kfifo_to_user(&p->rx_fifo, buf, size, &copied);
+	if (n)
+		return n;
+	return copied;
+}
+
+static ssize_t nrf24_write(struct file *filp,
+			   const char __user *buf,
+			   size_t size,
+			   loff_t *f_pos)
+{
+	struct nrf24_device *device;
+	struct nrf24_pipe *p;
+	ssize_t n;
+	unsigned int copied;
+
+	p = filp->private_data;
+	device = to_nrf24_device(p->dev->parent);
+
+	dev_dbg(p->dev, "write (%zd)\n", size);
+
+	mutex_lock(&device->tx_fifo_mutex);
+
+	n = kfifo_in(&device->tx_fifo, &p, sizeof(p));
+	if (n != sizeof(p))
+		goto err_kfifo_reset;
+
+	n = kfifo_in(&device->tx_fifo, &size, sizeof(size));
+	if (n != sizeof(size))
+		goto err_kfifo_reset;
+
+	n = kfifo_from_user(&device->tx_fifo,
+			    buf,
+			    size,
+			    &copied);
+	if (n || size != copied)
+		goto err_kfifo_reset;
+
+	mutex_unlock(&device->tx_fifo_mutex);
+
+	wake_up_interruptible(&device->tx_wait_queue);
+
+	return copied;
+err_kfifo_reset:
+	kfifo_reset(&device->tx_fifo);
+	mutex_unlock(&device->tx_fifo_mutex);
+	return -EAGAIN;
+}
+
+static int nrf24_open(struct inode *inode, struct file *filp)
+{
+	struct nrf24_pipe *pipe;
+
+	pipe = container_of(inode->i_cdev, struct nrf24_pipe, cdev);
+
+	if (!pipe) {
+		pr_err("device: minor %d unknown.\n", iminor(inode));
+		return -ENODEV;
+	}
+
+	filp->private_data = pipe;
+	nonseekable_open(inode, filp);
+
+	return 0;
+}
+
+static int nrf24_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+static unsigned int nrf24_poll(struct file *filp,
+			       struct poll_table_struct *wait)
+{
+	struct nrf24_device *device;
+	struct nrf24_pipe *p;
+
+	p = filp->private_data;
+	device = to_nrf24_device(p->dev->parent);
+
+	dev_dbg(p->dev, "%s: waiting...\n", __func__);
+	poll_wait(filp, &p->poll_wait_queue, wait);
+	if (!kfifo_is_empty(&p->rx_fifo)) {
+		dev_dbg(p->dev, "%s: got data!\n", __func__);
+		return POLLIN | POLLRDNORM;
+	}
+	dev_dbg(p->dev, "%s: no data!\n", __func__);
+	return 0;
+}
+
+static void nrf24_destroy_devices(struct nrf24_device *device)
+{
+	struct nrf24_pipe *pipe, *temp;
+
+	list_for_each_entry_safe(pipe, temp, &device->pipes, list) {
+		cdev_del(&pipe->cdev);
+		device_destroy(nrf24_class, pipe->devt);
+		ida_simple_remove(&nrf24_ida_pipe, MINOR(pipe->devt));
+		list_del(&pipe->list);
+		kfree(pipe);
+	}
+}
+
+static const struct file_operations nrf24_fops = {
+	.owner = THIS_MODULE,
+	.open = nrf24_open,
+	.release = nrf24_release,
+	.read = nrf24_read,
+	.write = nrf24_write,
+	.llseek = no_llseek,
+	.poll = nrf24_poll,
+};
+
+static struct nrf24_pipe *nrf24_create_pipe(struct nrf24_device *device, int id)
+{
+	int ret;
+	struct nrf24_pipe *p;
+
+	//sets flags to false as well
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto err_return;
+	}
+
+	ret = ida_simple_get(&nrf24_ida_pipe, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&device->dev, "%s: get_minor failed\n", __func__);
+		goto err_free_mem;
+	}
+
+	p->devt = MKDEV(MAJOR(nrf24_dev), ret);
+	p->id = id;
+
+	INIT_KFIFO(p->rx_fifo);
+	init_waitqueue_head(&p->poll_wait_queue);
+
+	p->dev = device_create_with_groups(nrf24_class,
+					   &device->dev,
+					   p->devt,
+					   p,
+					   nrf24_pipe_groups,
+					   "%s.%d",
+					   dev_name(&device->dev),
+					   id);
+
+	if (IS_ERR(p->dev)) {
+		dev_err(&device->dev,
+			"%s: device_create of pipe %d failed\n",
+			__func__,
+			p->id);
+		ret = PTR_ERR(p->dev);
+		goto err_ida_remove;
+	}
+
+	cdev_init(&p->cdev, &nrf24_fops);
+	p->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&p->cdev, p->devt, 1);
+	if (ret < 0) {
+		dev_err(&device->dev, "%s: cdev failed\n", __func__);
+		goto err_dev_destroy;
+	}
+
+	dev_dbg(&device->dev,
+		"%s: device created: major(%d), minor(%d)\n",
+		__func__,
+		MAJOR(p->devt),
+		MINOR(p->devt));
+
+	return p;
+
+err_dev_destroy:
+	device_destroy(nrf24_class, p->devt);
+err_ida_remove:
+	ida_simple_remove(&nrf24_ida_pipe, MINOR(p->devt));
+err_free_mem:
+	kfree(p);
+err_return:
+	return ERR_PTR(ret);
+}
+
+static void nrf24_gpio_free(struct nrf24_device *device)
+{
+	if (!IS_ERR(device->ce))
+		gpiod_put(device->ce);
+
+	free_irq(device->spi->irq, device);
+}
+
+static int nrf24_gpio_setup(struct nrf24_device *device)
+{
+	int ret;
+
+	device->ce = gpiod_get(&device->spi->dev, "ce", 0);
+
+	if (device->ce == ERR_PTR(-ENOENT))
+		dev_dbg(&device->dev, "%s: no entry for CE\n", __func__);
+	else if (device->ce == ERR_PTR(-EBUSY))
+		dev_dbg(&device->dev, "%s: CE is busy\n", __func__);
+
+	if (IS_ERR(device->ce)) {
+		ret = PTR_ERR(device->ce);
+		dev_err(&device->dev, "%s: CE gpio setup error\n", __func__);
+		return ret;
+	}
+
+	nrf24_ce_lo(device);
+
+	ret = request_irq(device->spi->irq,
+			  nrf24_isr,
+			  0,
+			  dev_name(&device->dev),
+			  device);
+	if (ret < 0) {
+		gpiod_put(device->ce);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void nrf24_dev_release(struct device *dev)
+{
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ida_simple_remove(&nrf24_ida_dev, device->id);
+	kfree(device);
+}
+
+static struct device_type nrf24_dev_type = {
+	.name = "nrf24_device",
+	.release = nrf24_dev_release,
+};
+
+static struct nrf24_device *nrf24_dev_init(struct spi_device *spi)
+{
+	int ret;
+	struct nrf24_device *device;
+	int id;
+
+	id = ida_simple_get(&nrf24_ida_dev, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	//sets flags to false as well
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device) {
+		ida_simple_remove(&nrf24_ida_dev, id);
+		return ERR_PTR(-ENOMEM);
+	}
+	device->spi = spi;
+
+	dev_set_name(&device->dev, "nrf%d", id);
+	device->id = id;
+	device->dev.parent = &spi->dev;
+	device->dev.class = nrf24_class;
+	device->dev.type = &nrf24_dev_type;
+	device->dev.groups = nrf24_groups;
+	ret = device_register(&device->dev);
+	if (ret < 0) {
+		put_device(&device->dev);
+		ida_simple_remove(&nrf24_ida_dev, id);
+
+		return ERR_PTR(ret);
+	}
+
+	init_waitqueue_head(&device->tx_wait_queue);
+	init_waitqueue_head(&device->tx_done_wait_queue);
+	init_waitqueue_head(&device->rx_wait_queue);
+
+	INIT_WORK(&device->isr_work, nrf24_isr_work_handler);
+	INIT_KFIFO(device->tx_fifo);
+	spin_lock_init(&device->lock);
+	mutex_init(&device->tx_fifo_mutex);
+
+	INIT_LIST_HEAD(&device->pipes);
+
+	return device;
+}
+
+static int nrf24_hal_init(struct nrf24_device *device)
+{
+	int ret;
+	struct spi_device *spi = device->spi;
+	struct nrf24_pipe *pipe;
+
+	ret = nrf24_soft_reset(spi);
+	if (ret < 0)
+		return ret;
+
+	list_for_each_entry(pipe, &device->pipes, list) {
+		ret = nrf24_get_address(spi,
+					pipe->id,
+					(u8 *)&pipe->cfg.address);
+		if (ret < 0)
+			return ret;
+		ret = nrf24_get_auto_ack(spi, pipe->id);
+		if (ret < 0)
+			return ret;
+		pipe->cfg.ack = ret;
+
+		//0 -> dynamic pload
+		pipe->cfg.plw = 0;
+		ret = nrf24_set_rx_pload_width(spi, pipe->id, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = nrf24_flush_fifo(spi);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_open_pipe(spi, NRF24_PIPE_ALL);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_lock_unlock(spi);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_mode(spi, NRF24_MODE_RX);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_crc_mode(spi, NRF24_CRC_16BIT);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_auto_retr_count(spi, 15);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_auto_retr_delay(spi, 4000);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_rf_power(spi, NRF24_POWER_0DBM);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_set_datarate(spi, NRF24_DATARATE_2MBPS);
+	if (ret < 0)
+		return ret;
+	ret = nrf24_power_up(spi);
+	if (ret < 0)
+		return ret;
+
+	nrf24_ce_hi(device);
+
+	return ret;
+}
+
+static int nrf24_probe(struct spi_device *spi)
+{
+	int ret;
+	struct nrf24_device *device;
+	struct nrf24_pipe *pipe;
+	int i;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "%s: spi_setup failed\n", __func__);
+		return ret;
+	}
+
+	device = nrf24_dev_init(spi);
+	if (IS_ERR(device)) {
+		dev_err(&spi->dev, "%s: dev_init failed\n", __func__);
+		return PTR_ERR(device);
+	}
+
+	ret = nrf24_gpio_setup(device);
+	if (ret < 0) {
+		dev_err(&device->dev, "%s: gpio_setup failed\n", __func__);
+		goto err_dev_unregister;
+	}
+
+	for (i = 0; i <= NRF24_PIPE5; i++) {
+		pipe = nrf24_create_pipe(device, i);
+		if (IS_ERR(pipe)) {
+			ret = PTR_ERR(pipe);
+			goto err_devs_destroy;
+		}
+		list_add(&pipe->list, &device->pipes);
+	}
+
+	ret = nrf24_hal_init(device);
+	if (ret < 0)
+		goto err_devs_destroy;
+
+	device->rx_task_struct = kthread_run(nrf24_rx_thread,
+					     device,
+					     "nrf%d_rx_thread",
+					     device->id);
+	if (IS_ERR(device->rx_task_struct)) {
+		dev_err(&device->dev, "start of tx thread failed\n");
+		goto err_devs_destroy;
+	}
+
+	device->tx_task_struct = kthread_run(nrf24_tx_thread,
+					     device,
+					     "nrf%d_tx_thread",
+					     device->id);
+	if (IS_ERR(device->tx_task_struct)) {
+		dev_err(&device->dev, "start of tx thread failed\n");
+		goto err_kthread_stop;
+	}
+
+	spi_set_drvdata(spi, device);
+
+	return 0;
+
+err_kthread_stop:
+	kthread_stop(device->rx_task_struct);
+err_devs_destroy:
+	nrf24_destroy_devices(device);
+	nrf24_gpio_free(device);
+err_dev_unregister:
+	device_unregister(&device->dev);
+	return ret;
+}
+
+static int nrf24_remove(struct spi_device *spi)
+{
+	struct nrf24_device *device = spi_get_drvdata(spi);
+
+	nrf24_gpio_free(device);
+
+	kthread_stop(device->tx_task_struct);
+	kthread_stop(device->rx_task_struct);
+
+	nrf24_destroy_devices(device);
+
+	device_unregister(&device->dev);
+
+	return 0;
+}
+
+static const struct of_device_id nrf24_dt_ids[] = {
+	{ .compatible = "nordic,nrf24" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, nrf24_dt_ids);
+
+static  struct spi_driver nrf24_spi_driver = {
+	.driver = {
+		.name = "nrf24",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(nrf24_dt_ids),
+	},
+	.probe = nrf24_probe,
+	.remove = nrf24_remove,
+};
+
+static int __init nrf24_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&nrf24_dev, 0, N_NRF24_MINORS,
+				  nrf24_spi_driver.driver.name);
+	if (ret < 0) {
+		pr_err("Unable to alloc chrdev region\n");
+		goto err_ida_destroy;
+	}
+
+	nrf24_class = class_create(THIS_MODULE, nrf24_spi_driver.driver.name);
+	if (IS_ERR(nrf24_class)) {
+		pr_err("Unable to create class\n");
+		ret = PTR_ERR(nrf24_class);
+		goto err_unreg_chrdev;
+	}
+
+	ret = spi_register_driver(&nrf24_spi_driver);
+	if (ret < 0) {
+		pr_err("Unable to register spi driver\n");
+		goto err_class_destroy;
+	}
+
+	return 0;
+
+err_class_destroy:
+	class_destroy(nrf24_class);
+err_unreg_chrdev:
+	unregister_chrdev(MAJOR(nrf24_dev), nrf24_spi_driver.driver.name);
+err_ida_destroy:
+	ida_destroy(&nrf24_ida_dev);
+	ida_destroy(&nrf24_ida_pipe);
+
+	return ret;
+}
+module_init(nrf24_init);
+
+static void __exit nrf24_exit(void)
+{
+	spi_unregister_driver(&nrf24_spi_driver);
+	class_destroy(nrf24_class);
+	unregister_chrdev(MAJOR(nrf24_dev), nrf24_spi_driver.driver.name);
+	ida_destroy(&nrf24_ida_dev);
+	ida_destroy(&nrf24_ida_pipe);
+}
+module_exit(nrf24_exit);
+
+MODULE_AUTHOR("Marcin Ciupak <marcin.s.ciupak@gmail.com>");
+MODULE_DESCRIPTION("Driver for NRF24L01+");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:nrf24");
+
diff --git a/drivers/staging/nrf24/nrf24_if.h b/drivers/staging/nrf24/nrf24_if.h
new file mode 100644
index 000000000000..2d9b0a8eaedc
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_if.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#ifndef NRF24_IF_H
+#define NRF24_IF_H
+
+#define FIFO_SIZE			65536
+
+struct nrf24_pipe_cfg {
+	u64			address;
+	u8			ack;
+	ssize_t			plw;
+};
+
+struct nrf24_pipe {
+	dev_t			devt;
+	struct device		*dev;
+	struct cdev		cdev;
+	int			id;
+	struct nrf24_pipe_cfg	cfg;
+
+	STRUCT_KFIFO_REC_1(FIFO_SIZE) rx_fifo;
+	wait_queue_head_t	poll_wait_queue;
+	ssize_t			rx_size;
+
+	struct list_head list;
+};
+
+struct nrf24_device {
+	u32			id;
+	struct device		dev;
+	struct spi_device	*spi;
+	struct list_head	pipes;
+
+	struct gpio_desc	*ce;
+
+	/* for irqsave */
+	spinlock_t		lock;
+
+	struct work_struct	isr_work;
+
+	/* tx */
+	STRUCT_KFIFO_REC_2(FIFO_SIZE) tx_fifo;
+
+	/* tx fifo lock */
+	struct mutex		tx_fifo_mutex;
+	struct task_struct	*tx_task_struct;
+	wait_queue_head_t	tx_wait_queue;
+	wait_queue_head_t	tx_done_wait_queue;
+
+	struct task_struct	*rx_task_struct;
+	wait_queue_head_t	rx_wait_queue;
+
+	u8			tx_done;
+};
+
+#define to_nrf24_device(device)	container_of(device, struct nrf24_device, dev)
+
+#endif /* NRF24_IF_H */
diff --git a/drivers/staging/nrf24/nrf24_sysfs.c b/drivers/staging/nrf24/nrf24_sysfs.c
new file mode 100644
index 000000000000..f9aaf39f0fb9
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_sysfs.c
@@ -0,0 +1,707 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/err.h>
+#include <linux/kfifo.h>
+#include <linux/list.h>
+
+#include "nrf24_if.h"
+#include "nrf24_hal.h"
+#include "nrf24_enums.h"
+
+static struct nrf24_pipe *nrf24_find_pipe_ptr(struct device *dev)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	struct nrf24_pipe *pipe;
+
+	list_for_each_entry(pipe, &device->pipes, list)
+		if (pipe->dev == dev)
+			return pipe;
+
+	return ERR_PTR(-ENODEV);
+}
+
+static ssize_t ack_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	int ret;
+	struct nrf24_pipe *pipe;
+
+	pipe = nrf24_find_pipe_ptr(dev);
+	if (IS_ERR(pipe))
+		return PTR_ERR(pipe);
+
+	ret = nrf24_get_auto_ack(device->spi, pipe->id);
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t ack_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf,
+			 size_t count)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	int ret;
+	u8 new;
+	struct nrf24_pipe *pipe;
+
+	pipe = nrf24_find_pipe_ptr(dev);
+	if (IS_ERR(pipe))
+		return PTR_ERR(pipe);
+
+	ret = kstrtou8(buf, 10, &new);
+	if (ret < 0)
+		return ret;
+	if (new < 0 || new > 1)
+		return -EINVAL;
+
+	ret = nrf24_setup_auto_ack(device->spi, pipe->id, new);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t plw_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	int ret;
+	struct nrf24_pipe *pipe;
+
+	pipe = nrf24_find_pipe_ptr(dev);
+	if (IS_ERR(pipe))
+		return PTR_ERR(pipe);
+
+	ret = nrf24_get_rx_pload_width(device->spi, pipe->id);
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t plw_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf,
+			 size_t count)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	int ret;
+	u8 new;
+	ssize_t old;
+	struct nrf24_pipe *pipe;
+
+	pipe = nrf24_find_pipe_ptr(dev);
+	if (IS_ERR(pipe))
+		return PTR_ERR(pipe);
+
+	ret = kstrtou8(buf, 10, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new < 0 || new > PLOAD_MAX)
+		return -EINVAL;
+	old = nrf24_get_rx_pload_width(device->spi, pipe->id);
+	if (old < 0)
+		return old;
+
+	if ((u8)old != new) {
+		ret = nrf24_set_rx_pload_width(device->spi, pipe->id, new);
+		if (ret < 0)
+			return ret;
+		pipe->cfg.plw = new;
+	}
+
+	return count;
+}
+
+static ssize_t address_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	u8 addr[16];
+	int ret;
+	int count;
+	int i;
+	struct nrf24_pipe *pipe;
+
+	pipe = nrf24_find_pipe_ptr(dev);
+	if (IS_ERR(pipe))
+		return PTR_ERR(pipe);
+
+	ret = nrf24_get_address(device->spi, pipe->id, addr);
+	if (ret < 0)
+		return ret;
+
+	count = scnprintf(buf, PAGE_SIZE, "0x");
+	for (i = --ret; i >= 0; i--)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%02X", addr[i]);
+	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+
+	return count;
+}
+
+static ssize_t address_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf,
+			     size_t count)
+{
+	struct nrf24_device *device = to_nrf24_device(dev->parent);
+	int ret;
+	u64 address;
+	int len;
+	struct nrf24_pipe *pipe;
+
+	ret = kstrtoull(buf, 16, &address);
+	if (ret < 0)
+		return ret;
+
+	len = nrf24_get_address_width(device->spi);
+	if (len < 0)
+		return len;
+
+	if (address >= BIT_ULL(len * BITS_PER_BYTE))
+		return -EINVAL;
+
+	pipe = nrf24_find_pipe_ptr(dev);
+	if (IS_ERR(pipe))
+		return PTR_ERR(pipe);
+
+	ret = nrf24_set_address(device->spi, pipe->id, (u8 *)&address);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(ack);
+static DEVICE_ATTR_RW(plw);
+static DEVICE_ATTR_RW(address);
+
+struct attribute *nrf24_pipe_attrs[] = {
+	&dev_attr_ack.attr,
+	&dev_attr_plw.attr,
+	&dev_attr_address.attr,
+	NULL,
+};
+
+static ssize_t tx_address_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct nrf24_device *device = to_nrf24_device(dev);
+	u8 addr[16];
+	int ret;
+	int count;
+	int i;
+
+	ret = nrf24_get_address(device->spi, NRF24_TX, addr);
+	if (ret < 0)
+		return ret;
+
+	count = scnprintf(buf, PAGE_SIZE, "0x");
+	for (i = --ret; i >= 0; i--)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%02X", addr[i]);
+	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+
+	return count;
+}
+
+static ssize_t tx_address_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct nrf24_device *device = to_nrf24_device(dev);
+	int ret;
+	u64 address;
+	int len;
+
+	ret = kstrtoull(buf, 16, &address);
+	if (ret < 0)
+		return ret;
+
+	len = nrf24_get_address_width(device->spi);
+	if (len < 0)
+		return len;
+
+	if (address >= BIT_ULL(len * BITS_PER_BYTE))
+		return -EINVAL;
+
+	ret = nrf24_set_address(device->spi, NRF24_TX, (u8 *)&address);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	nrf24_print_status(device->spi);
+	ret = nrf24_get_status(device->spi);
+	if (ret < 0)
+		return ret;
+	return scnprintf(buf, PAGE_SIZE, "STATUS = 0x%02X\n", ret);
+}
+
+static ssize_t available_crc_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0 8 16\n");
+}
+
+static ssize_t crc_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ret = nrf24_get_crc_mode(device->spi);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case NRF24_CRC_OFF:
+		ret = scnprintf(buf, PAGE_SIZE, "0\n");
+		break;
+	case NRF24_CRC_8BIT:
+		ret = scnprintf(buf, PAGE_SIZE, "8\n");
+		break;
+	case NRF24_CRC_16BIT:
+		ret = scnprintf(buf, PAGE_SIZE, "16\n");
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t crc_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf,
+			 size_t count)
+{
+	int ret;
+	u8 new;
+	struct nrf24_device *device;
+
+	device = to_nrf24_device(dev);
+
+	ret = kstrtou8(buf, 10, &new);
+	if (ret < 0)
+		return ret;
+
+	switch (new) {
+	case 0:
+		new = NRF24_CRC_OFF;
+		break;
+	case 8:
+		new = NRF24_CRC_8BIT;
+		break;
+	case 16:
+		new = NRF24_CRC_16BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = nrf24_get_crc_mode(device->spi);
+	if (ret < 0)
+		return ret;
+
+	if (new != ret) {
+		ret = nrf24_set_crc_mode(device->spi, new);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: new crc mode = %d\n", __func__, new);
+	}
+	return count;
+}
+
+static ssize_t available_address_width_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "3 4 5\n");
+}
+
+static ssize_t address_width_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ret = nrf24_get_address_width(device->spi);
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t address_width_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	int ret;
+	u8 new;
+	struct nrf24_device *device;
+
+	device = to_nrf24_device(dev);
+
+	ret = kstrtou8(buf, 10, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new != NRF24_AW_3 &&
+	    new != NRF24_AW_4 &&
+	    new != NRF24_AW_5)
+		return -EINVAL;
+
+	ret = nrf24_get_address_width(device->spi);
+	if (ret < 0)
+		return ret;
+
+	if (new != ret) {
+		ret = nrf24_set_address_width(device->spi, new);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: new address width = %d\n", __func__, new);
+	}
+	return count;
+}
+
+static ssize_t available_output_power_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0 -6 -12 -18\n");
+}
+
+static ssize_t rf_power_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ret = nrf24_get_rf_power(device->spi);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case NRF24_POWER_0DBM:
+		ret = scnprintf(buf, PAGE_SIZE, "0\n");
+		break;
+	case NRF24_POWER_6DBM:
+		ret = scnprintf(buf, PAGE_SIZE, "-6\n");
+		break;
+	case NRF24_POWER_12DBM:
+		ret = scnprintf(buf, PAGE_SIZE, "-12\n");
+		break;
+	case NRF24_POWER_18DBM:
+		ret = scnprintf(buf, PAGE_SIZE, "-18\n");
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t rf_power_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t count)
+{
+	int ret;
+	u8 new;
+	s8 tmp;
+	struct nrf24_device *device;
+
+	device = to_nrf24_device(dev);
+
+	ret = kstrtos8(buf, 10, &tmp);
+	if (ret < 0)
+		return ret;
+
+	switch (abs(tmp)) {
+	case 0:
+		new = NRF24_POWER_0DBM;
+		break;
+	case 6:
+		new = NRF24_POWER_6DBM;
+		break;
+	case 12:
+		new = NRF24_POWER_12DBM;
+		break;
+	case 18:
+		new = NRF24_POWER_18DBM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = nrf24_get_rf_power(device->spi);
+	if (ret < 0)
+		return ret;
+
+	if (new != ret) {
+		ret = nrf24_set_rf_power(device->spi, new);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: new rf power level = %d\n", __func__, new);
+	}
+	return count;
+}
+
+static ssize_t available_data_rate_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "256 1024 2048\n");
+}
+
+static ssize_t data_rate_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ret = nrf24_get_datarate(device->spi);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case NRF24_DATARATE_256KBPS:
+		ret = scnprintf(buf, PAGE_SIZE, "256\n");
+		break;
+	case NRF24_DATARATE_1MBPS:
+		ret = scnprintf(buf, PAGE_SIZE, "1024\n");
+		break;
+	case NRF24_DATARATE_2MBPS:
+		ret = scnprintf(buf, PAGE_SIZE, "2048\n");
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t data_rate_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	int ret;
+	u8 new;
+	u16 tmp;
+	struct nrf24_device *device;
+
+	device = to_nrf24_device(dev);
+
+	ret = kstrtou16(buf, 10, &tmp);
+	if (ret < 0)
+		return ret;
+
+	switch (tmp) {
+	case 256:
+		new = NRF24_DATARATE_256KBPS;
+		break;
+	case 1024:
+		new = NRF24_DATARATE_1MBPS;
+		break;
+	case 2048:
+		new = NRF24_DATARATE_2MBPS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = nrf24_get_datarate(device->spi);
+	if (ret < 0)
+		return ret;
+
+	if (new != ret) {
+		ret = nrf24_set_datarate(device->spi, new);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: new datarate = %d\n", __func__, new);
+	}
+	return count;
+}
+
+static ssize_t available_retr_delay_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int i;
+	int count = 0;
+
+	for (i = 1; i <= 16; i++)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%d ", i * 250);
+	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+
+	return count;
+}
+
+static ssize_t retr_delay_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ret = nrf24_get_auto_retr_delay(device->spi);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t retr_delay_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	int ret;
+	u16 new;
+	struct nrf24_device *device;
+
+	device = to_nrf24_device(dev);
+
+	ret = kstrtou16(buf, 10, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new < 250 || new > 4000 || new % 250)
+		return -EINVAL;
+
+	ret = nrf24_get_auto_retr_delay(device->spi);
+	if (ret < 0)
+		return ret;
+
+	if (new != ret) {
+		ret = nrf24_set_auto_retr_delay(device->spi, new);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: new autr retr delay = %d\n", __func__, new);
+	}
+	return count;
+}
+
+static ssize_t available_retr_count_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int i;
+	int count = 0;
+
+	for (i = 0; i < 16; i++)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%d ", i);
+	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+
+	return count;
+}
+
+static ssize_t retr_count_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct nrf24_device *device = to_nrf24_device(dev);
+
+	ret = nrf24_get_auto_retr_count(device->spi);
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t retr_count_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	int ret;
+	u16 new;
+	struct nrf24_device *device;
+
+	device = to_nrf24_device(dev);
+
+	ret = kstrtou16(buf, 10, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new < 0 || new > 15)
+		return -EINVAL;
+
+	ret = nrf24_get_auto_retr_count(device->spi);
+	if (ret < 0)
+		return ret;
+
+	if (new != ret) {
+		ret = nrf24_set_auto_retr_count(device->spi, new);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: new autr retr count = %d\n", __func__, new);
+	}
+	return count;
+}
+
+static DEVICE_ATTR_RW(tx_address);
+static DEVICE_ATTR_RO(status);
+static DEVICE_ATTR_RO(available_crc);
+static DEVICE_ATTR_RW(crc);
+static DEVICE_ATTR_RO(available_address_width);
+static DEVICE_ATTR_RW(address_width);
+static DEVICE_ATTR_RO(available_output_power);
+static DEVICE_ATTR_RW(rf_power);
+static DEVICE_ATTR_RO(available_data_rate);
+static DEVICE_ATTR_RW(data_rate);
+static DEVICE_ATTR_RO(available_retr_delay);
+static DEVICE_ATTR_RW(retr_delay);
+static DEVICE_ATTR_RO(available_retr_count);
+static DEVICE_ATTR_RW(retr_count);
+
+struct attribute *nrf24_attrs[] = {
+	&dev_attr_tx_address.attr,
+	&dev_attr_status.attr,
+	&dev_attr_crc.attr,
+	&dev_attr_available_crc.attr,
+	&dev_attr_address_width.attr,
+	&dev_attr_available_address_width.attr,
+	&dev_attr_rf_power.attr,
+	&dev_attr_available_output_power.attr,
+	&dev_attr_data_rate.attr,
+	&dev_attr_available_data_rate.attr,
+	&dev_attr_retr_delay.attr,
+	&dev_attr_available_retr_delay.attr,
+	&dev_attr_retr_count.attr,
+	&dev_attr_available_retr_count.attr,
+	NULL,
+};
+
diff --git a/drivers/staging/nrf24/nrf24_sysfs.h b/drivers/staging/nrf24/nrf24_sysfs.h
new file mode 100644
index 000000000000..ae6575b13ffe
--- /dev/null
+++ b/drivers/staging/nrf24/nrf24_sysfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2017 Marcin Ciupak <marcin.s.ciupak@gmail.com>
+ *
+ */
+
+#ifndef NRF24_SYSFS_H
+#define NRF24_SYSFS_H
+
+extern struct attribute *nrf24_pipe_attrs[];
+extern struct attribute *nrf24_attrs[];
+
+#endif /* NRF24_SYSFS_H */
-- 
2.20.1

