Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeDPG5v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:57:51 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4188 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeDPG5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:57:49 -0400
X-IronPort-AV: E=Sophos;i="5.48,458,1517900400";
   d="scan'208";a="11085157"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] iio: adc: select buffer for at91-sama5d2_adc
Date: Mon, 16 Apr 2018 09:54:03 +0300
Message-ID: <1523861643-3419-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to select the buffer code, otherwise we get build errors
with undefined functions on the trigger and buffer,
if we select just IIO and then AT91_SAMA5D2_ADC from menuconfig

This adds a Kconfig 'select' statement like other ADC
drivers have it already.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Hello Jonathan,

While you are at it, I also found this small kconfig issue during my tests.
Would be good to have as a fix as well.

Thanks,
Eugen

 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15606f2..9da7907 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -158,6 +158,7 @@ config AT91_SAMA5D2_ADC
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on HAS_DMA
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
-- 
2.7.4
