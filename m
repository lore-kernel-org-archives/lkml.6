Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeFDHEI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbeFDHEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugen Hristev <eugen.hristev@microchip.com>,
        Stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.16 32/47] iio: adc: select buffer for at91-sama5d2_adc
Date: Mon,  4 Jun 2018 08:58:44 +0200
Message-Id: <20180604065550.814561680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 76974ef9d1bf397b7bb97892a3b3bc516a1fc2c2 upstream.

We need to select the buffer code, otherwise we get build errors
with undefined functions on the trigger and buffer,
if we select just IIO and then AT91_SAMA5D2_ADC from menuconfig

This adds a Kconfig 'select' statement like other ADC
drivers have it already.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -159,6 +159,7 @@ config AT91_SAMA5D2_ADC
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on HAS_DMA
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
