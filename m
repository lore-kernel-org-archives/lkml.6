Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeA3NV4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:21:56 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:38250 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeA3NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:21:49 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] iio: adc: STM32_DFSDM_ADC should depend on HAS_DMA
Date: Tue, 30 Jan 2018 14:21:46 +0100
Message-Id: <1517318506-14664-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/iio/adc/stm32-dfsdm-adc.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Fixes: e2e6771c64625165 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 39e3b345a6c84033..d976c64107c8e9fd 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -683,6 +683,7 @@ config STM32_DFSDM_CORE
 config STM32_DFSDM_ADC
 	tristate "STMicroelectronics STM32 dfsdm adc"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	depends on HAS_DMA
 	select STM32_DFSDM_CORE
 	select REGMAP_MMIO
 	select IIO_BUFFER_HW_CONSUMER
-- 
2.7.4
