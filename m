Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbeB1Pr4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:47:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13322 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933045AbeB1Prv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:47:51 -0500
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 0/5] mmc: add stm32 sdmmc controller
Date: Wed, 28 Feb 2018 16:47:19 +0100
Message-ID: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch serie adds support of stm32 SDMMC controller.
stm32h7 is the first SoC to use stm32 SDMMC controller
(previous SoC had pl180 controller).

The SDMMC features include the following:
-Full compliance with MultiMediaCard System Specification Version 4.51.
 Card support for three different databus modes:
 1-bit (default), 4-bit and 8-bit.
-Full compliance with SD memory card specifications version 4.1.
 SDR104 speed limited to maximum allowed I/O speed, SPI mode and
 UHS-II mode not supported.
-Full compliance with SDIO card specification version 4.0.

change V2:
-dt-bindings: properties name
st,dir-output-high; st,neg-edge; st,use-ckin
-dt-bindings: node example s/sdmmc@/mmc@/g
-removes return of enable/disable_imask functions
-adds dev_warn if clk divisor is too short.
-replaces overprotection of n_elem by fail of dma_map_sg
-removes shortcut host->base
-Use device_property_present

Ludovic Barre (5):
  dt-bindings: mmc: document the stm32 sdmmc bindings
  mmc: add stm32 sdmmc controller driver
  ARM: dts: stm32: add sdmmc support for stm32h743
  ARM: dts: stm32: add sdmmc1 support for stm32h743i-eval
  ARM: configs: stm32: add mmc and ext2/3/4 support

 .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     |  35 +
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  26 +
 arch/arm/boot/dts/stm32h743.dtsi                   |  26 +
 arch/arm/boot/dts/stm32h743i-eval.dts              |  11 +
 arch/arm/configs/stm32_defconfig                   |   4 +-
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/stm32-sdmmc.c                     | 708 +++++++++++++++++++++
 drivers/mmc/host/stm32-sdmmc.h                     | 220 +++++++
 9 files changed, 1038 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
 create mode 100644 drivers/mmc/host/stm32-sdmmc.c
 create mode 100644 drivers/mmc/host/stm32-sdmmc.h

-- 
2.7.4
