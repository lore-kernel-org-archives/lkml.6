Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403F320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifjRSj4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403F320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeH3Ts2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3Ts0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so8499652wrr.4;
        Thu, 30 Aug 2018 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQqP9NLkOkVzk7D1LMI8Y+J0UMHbo42I8dLSpZuhXRc=;
        b=ifjRSj4labF3yu/ZzTuSbrT/tXp0Y94XnTmFsd7hGvpHksuOTJFkstfQyLwsdSeuhg
         2cQOsLTCbSQ/peuCBn+Scy3WOGD6UqaEAOfoOFyy6ImZdzy0LMrgYMDLGIZKkcZ426J2
         fytPVBhEHAqXxCS9LJdkT7br17YVBn8152BzGmYR7hbvRwVS0KMevexNN3I3XIFUSiKa
         QgmXIUaFF9bqwtBDZ80VEBYG9mmhI6CLG+A2QdbWAmIM+vVoTZpiGLwvy5HsQavSNFIH
         CTHaCqDSkjNf6oBEX367tVx3X/lizfdCeNa7ftNg8Aa2J/WAfRJjgvkqJJtJOky876zo
         fRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQqP9NLkOkVzk7D1LMI8Y+J0UMHbo42I8dLSpZuhXRc=;
        b=Kd7uFW52UtkYNM9kACVpvyS1uUZIaVSAUH2CjU/SEA+FIhphZQ3kVxWZjOD6NovAAS
         kX//eyZX6Mx905BsDlj6yj3cfkekGMhSqQ12FIzQTE4ek7SBbQVJ7Y2JYrZzDYpPaV/8
         qz2+BOdK4iRi5mJVtYPdkV/FeyCNj2Cw10tsbLrJ5i3sqV+sZvsmiITwmVzVEsfXRJNo
         D0zpVszDxLb9aEJXK3ApZTydzscYI2BOrU3LsMChKY6wllb95RY1k6Tqv9lMLw3X/2wL
         gOpP3npvMosvPpmPcmf0b219gCioU4G9Sk6LKzhY0Y3kvtE1HsCukTKTHKPDYZ5/XHrf
         IkIA==
X-Gm-Message-State: APzg51CVC5PVDn8mKnwnrqkjrmmAm5JlOd91fID1Vh/voZS0+ldy/Xzw
        /rNqzceVvlWCtiGZSGrDPJ8=
X-Google-Smtp-Source: ANB0VdbPUje7m+TY75vPDhE9sYa/+ktpN26Akzo30ji9NJssK0h+wSx/ea7ItLTibVU6zFY3qvT0gw==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr7702826wrg.24.1535643939495;
        Thu, 30 Aug 2018 08:45:39 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:38 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 19/30] iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
Date:   Thu, 30 Aug 2018 17:45:07 +0200
Message-Id: <20180830154518.29507-20-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the driver to support nvmem calibration cells.
The driver checks if the nvmem calibration is supported and reads out
the nvmem.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 18ab72e52d78..2fd73d143815 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -70,6 +71,7 @@ struct gpadc_data {
 	bool		has_mod_clk;
 	u32		temp_data_base;
 	int		sensor_count;
+	bool		supports_nvmem;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -146,6 +148,7 @@ struct sun4i_gpadc_iio {
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
 	struct reset_control		*reset;
+	u32				calibration_data[2];
 };
 
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
@@ -484,6 +487,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	struct resource *mem;
 	void __iomem *base;
 	int ret;
+	struct nvmem_cell *cell;
+	ssize_t cell_size;
+	u32 *cell_data;
 
 	info->data = of_device_get_match_data(&pdev->dev);
 	if (!info->data)
@@ -494,6 +500,24 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	if (info->data->supports_nvmem) {
+
+		cell = nvmem_cell_get(&pdev->dev, "calibration");
+		if (IS_ERR(cell)) {
+			if (PTR_ERR(cell) == -EPROBE_DEFER)
+				return PTR_ERR(cell);
+		} else {
+			cell_data = (u32 *)nvmem_cell_read(cell, &cell_size);
+			if (cell_size != 8)
+				dev_err(&pdev->dev,
+					"Calibration data has wrong size\n");
+			else {
+				info->calibration_data[0] = cell_data[0];
+				info->calibration_data[1] = cell_data[1];
+			}
+		}
+	}
+
 	if (info->data->has_bus_clk)
 		info->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus",
 				base, &sun4i_gpadc_regmap_config);
-- 
2.11.0

