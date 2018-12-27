Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC21DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA92214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MZEWHRlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbeL0Vu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:50:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbeL0Vuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:50:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so17714072wmj.1;
        Thu, 27 Dec 2018 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpJZNxi0lfyjPq2DOZ1N4ZgeJo5jnwrwv6zYfdTu/XE=;
        b=MZEWHRlxukr3TVr/+J9GcVck7lzhvcJo7uRAyUDuYKhq3QM9as3zFVCmdWfTT1BTCL
         Mo0BEQ/Oc1hFiVUVwOwITnUQTPEWEz7kR4uDnrCwVM1HzcE2b4R8bVYgG+Ead57WeJFd
         pZhqSAKhUnTbQ0tKBicrWo7RbqpxsyrQWagnhF4Xc07JyGAYlr6vjzoXXBueQ33TRJEh
         5gRx2KUOulz+JSVhRLUyR++9PhYUb+2rIxlM5rFFt4LFyetLo2BHwKHWcoQsOoywOyTS
         f837w8nRT835Ns5lZ8NGLAdHOuqCQLa674Cn89RR07MgmC4pT+j0PH+ZDjZYgS9BDjq8
         AAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpJZNxi0lfyjPq2DOZ1N4ZgeJo5jnwrwv6zYfdTu/XE=;
        b=jeIbPWLRVwS+wYm3snj7XZBd0B1ushyn1V3wWiRc5ee65l8rqEwS6QJdWsGCsx8tgm
         qEf97RO9SfWK7tPmpbuUDq2V3B6vbOZE1HKnc/RiWbwQZMRpNFtWDxJDsIniQQRuVZZE
         yweGx0cZ/nX2D9qjswjMokgdo0k0YKHldBOlU2SCuqdHbiIuPDSAplj56KVmCVDKCIzr
         RXJbEjROdMQqKbVFxl2z3CqRxOVxVXjBKtA9nMS2VHFpvyX1aKqcEWd9/3c161NDFyxw
         Smun4KJo1AUHtnHyXQyczcD0qRK3OshzNowETEuFG+bPApMEMHwR/Fu0VJIbn3U0ky9x
         u39A==
X-Gm-Message-State: AJcUukeJVtx81yOA/VDt3r+E+wN3V0aomcZUQ9w32c8gKPscx4ReYI2r
        ambwq0wTDkxYv8O697LYRvU=
X-Google-Smtp-Source: ALg8bN4LwXOC6Od3bQrCvJ5wI00pK1Br2wvc86MuMB8vExxb417vahgIsH0SVF7dTI6iI9phpIo4qg==
X-Received: by 2002:a1c:4807:: with SMTP id v7mr22944033wma.53.1545947446671;
        Thu, 27 Dec 2018 13:50:46 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD711B00071582302E30AD474.dip0.t-ipconnect.de. [2003:dc:d711:b000:7158:2302:e30a:d474])
        by smtp.googlemail.com with ESMTPSA id m4sm34538164wmi.3.2018.12.27.13.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 13:50:46 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     balbes-150@yandex.ru, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] iio: adc: meson-saradc: enable the temperature sensor two more SoCs
Date:   Thu, 27 Dec 2018 22:50:20 +0100
Message-Id: <20181227215020.9803-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson8b and Meson8m2 use the same logic to convert the ADC register
value to celsius, which is different from Meson8:
- Meson8 has different multiplier and divider values
- Meson8 uses a 4-bit TSC (temperature sensor coefficient) which fits
  into the 4-bit field in the MESON_SAR_ADC_DELTA_10 register:
  MESON_SAR_ADC_DELTA_10_TS_C_MASK. Meson8b and Meson8m2 have a 5-bit
  TSC which requires writing the upper-most bit into the
  MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.

This adds support for the temperature sensor on the Meson8b and Meson8m2
SoCs by implementing the logic to write the upper-most TSC bit into the
HHI register area. The SoC-specific values (temperature_trimming_bits,
temperature_multiplier, temperature_divider) are added - these simply
integrate into the existing infrastructure (which was implemented for
Meson8) and thus require no further changes to the existing temperature
calculation logic.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 729becb2d3d9..f8600fbcdfe3 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/mfd/syscon.h>
 
 #define MESON_SAR_ADC_REG0					0x00
 	#define MESON_SAR_ADC_REG0_PANEL_DETECT			BIT(31)
@@ -174,6 +175,9 @@
 #define MESON_SAR_ADC_EFUSE_BYTE3_UPPER_ADC_VAL			GENMASK(6, 0)
 #define MESON_SAR_ADC_EFUSE_BYTE3_IS_CALIBRATED			BIT(7)
 
+#define MESON_HHI_DPLL_TOP_0					0x318
+#define MESON_HHI_DPLL_TOP_0_TSC_BIT4				BIT(9)
+
 /* for use with IIO_VAL_INT_PLUS_MICRO */
 #define MILLION							1000000
 
@@ -280,6 +284,7 @@ struct meson_sar_adc_priv {
 	struct completion			done;
 	int					calibbias;
 	int					calibscale;
+	struct regmap				*tsc_regmap;
 	bool					temperature_sensor_calibrated;
 	u8					temperature_sensor_coefficient;
 	u16					temperature_sensor_adc_val;
@@ -727,6 +732,15 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
+	priv->tsc_regmap =
+		syscon_regmap_lookup_by_phandle(indio_dev->dev.parent->of_node,
+						"amlogic,hhi-sysctrl");
+	if (IS_ERR(priv->tsc_regmap)) {
+		dev_err(indio_dev->dev.parent,
+			"failed to get amlogic,hhi-sysctrl regmap\n");
+		return PTR_ERR(priv->tsc_regmap);
+	}
+
 	read_len = MESON_SAR_ADC_EFUSE_BYTES;
 	buf = nvmem_cell_read(temperature_calib, &read_len);
 	if (IS_ERR(buf)) {
@@ -861,6 +875,22 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 				    priv->temperature_sensor_coefficient);
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
 				   MESON_SAR_ADC_DELTA_10_TS_C_MASK, regval);
+
+		if (priv->param->temperature_trimming_bits == 5) {
+			if (priv->temperature_sensor_coefficient & BIT(4))
+				regval = MESON_HHI_DPLL_TOP_0_TSC_BIT4;
+			else
+				regval = 0;
+
+			/*
+			 * bit [4] (the 5th bit when starting to count at 1)
+			 * of the TSC is located in the HHI register area.
+			 */
+			regmap_update_bits(priv->tsc_regmap,
+					   MESON_HHI_DPLL_TOP_0,
+					   MESON_HHI_DPLL_TOP_0_TSC_BIT4,
+					   regval);
+		}
 	} else {
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
 				   MESON_SAR_ADC_DELTA_10_TS_REVE1, 0);
@@ -1064,6 +1094,9 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
 	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
+	.temperature_trimming_bits = 5,
+	.temperature_multiplier = 10,
+	.temperature_divider = 32,
 };
 
 static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
-- 
2.20.1

