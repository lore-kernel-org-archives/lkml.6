Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D9BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629DA2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnVLxEat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629DA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeH3TsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeH3TsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so8481997wrc.13;
        Thu, 30 Aug 2018 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tFfQ9c8YXGxQQwqrjR6oys9dfg5aGNdXZejyyuPf1vg=;
        b=YnVLxEatWQEYx0jHq0IAvzD9z53G/4ynMvpPRtxkaxEI3G1r7xDvs4lBRl8BKK8sVC
         D5/DAi1jGWwWcEyBNzp2KrXMslYIwz/nCM/rpdE77V3LZ+YVPFOs8xrO6jvk/axBNTTw
         MkKG3wT8DM5RE9G3TSon4Jf/EwCE1MGW4cJblbzEUbgBxcJrZYnTGlhzAx5o97g4csS/
         6ctjYf3028zCgUg9aOdMQrqIudXpw4GRZzkp9JzOry0Hkx4XDWR4vMbEIfnI+BuoyGGp
         A1UfSjhlocjJ3Pad4GikQ/RED085n+gCm7azaCschaGpWhG+I6cg5GmnV1VqBGAWMNQn
         qEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tFfQ9c8YXGxQQwqrjR6oys9dfg5aGNdXZejyyuPf1vg=;
        b=nMnrIWUxWdO34w/x/JT2QnZXnHh0x97CXRIw8Ghsd4aeHONk2+6bZ19UhPr4tiq514
         igzkgdeG/ntUpu0/CnnCgC28FLNhOkYNsR4zHyITgkZ+RXD1rV1jRoXDpSUoaXXXmVef
         OoxYUmapVZ017e+d6JhkdNm3t45VzHYB8W/3S2kgJZNJWkwj5WE2O7dlrsm7ykNlPumN
         BjjefPDLtdX6azcOwEt8NvZUJLJ099hzXKVafpVPp45TbFa3r7KjvAo/2RzOw9psAttP
         wIKK1fQCvDpG+Jbhp2p16LiairVedA+91D45S5RupAMmwnI4z8itOSNhAc3O4pAHFbQn
         5Tcw==
X-Gm-Message-State: APzg51Db+Ca7h5ymOfflMtINw/BI0i5Fms19HE+QGKVwjV2mrEgDTAbn
        Az/O+YUej8X8D0o1H7mizy4=
X-Google-Smtp-Source: ANB0Vda7gM6oXRTKYIaCexUkUiShe9Jn2An6YoMbuiIqmF7diafLDl42iCOez3qQIYf63qK/9HpN2A==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr8486837wrq.82.1535643926751;
        Thu, 30 Aug 2018 08:45:26 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:26 -0700 (PDT)
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
Subject: [PATCH v3 07/30] iio: adc: remove mfd_probe & sunwi_irq_init function
Date:   Thu, 30 Aug 2018 17:44:55 +0200
Message-Id: <20180830154518.29507-8-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous commit we removed the function call, now we remove the
unused functions.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 126 --------------------------------------
 1 file changed, 126 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d6f00d3b802d..f787442a9e5f 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -431,55 +431,6 @@ static const struct dev_pm_ops sun4i_gpadc_pm_ops = {
 	.runtime_resume = &sun4i_gpadc_runtime_resume,
 };
 
-static int sun4i_irq_init(struct platform_device *pdev, const char *name,
-			  irq_handler_t handler, const char *devname,
-			  unsigned int *irq, atomic_t *atomic)
-{
-	int ret;
-	struct sun4i_gpadc_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
-	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(&pdev->dev));
-
-	/*
-	 * Once the interrupt is activated, the IP continuously performs
-	 * conversions thus throws interrupts. The interrupt is activated right
-	 * after being requested but we want to control when these interrupts
-	 * occur thus we disable it right after being requested. However, an
-	 * interrupt might occur between these two instructions and we have to
-	 * make sure that does not happen, by using atomic flags. We set the
-	 * flag before requesting the interrupt and unset it right after
-	 * disabling the interrupt. When an interrupt occurs between these two
-	 * instructions, reading the atomic flag will tell us to ignore the
-	 * interrupt.
-	 */
-	atomic_set(atomic, 1);
-
-	ret = platform_get_irq_byname(pdev, name);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
-		return ret;
-	}
-
-	ret = regmap_irq_get_virq(mfd_dev->regmap_irqc, ret);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get virq for irq %s\n", name);
-		return ret;
-	}
-
-	*irq = ret;
-	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
-					   devname, info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
-			name, ret);
-		return ret;
-	}
-
-	disable_irq(*irq);
-	atomic_set(atomic, 0);
-
-	return 0;
-}
-
 static const struct of_device_id sun4i_gpadc_of_id[] = {
 	{
 		.compatible = "allwinner,sun8i-a33-ths",
@@ -523,83 +474,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
-static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
-				 struct iio_dev *indio_dev)
-{
-	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
-	struct sun4i_gpadc_dev *sun4i_gpadc_dev =
-		dev_get_drvdata(pdev->dev.parent);
-	int ret;
-
-	info->no_irq = false;
-	info->regmap = sun4i_gpadc_dev->regmap;
-
-	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
-	indio_dev->channels = sun4i_gpadc_channels;
-
-	info->data = (struct gpadc_data *)platform_get_device_id(pdev)->driver_data;
-
-	/*
-	 * Since the controller needs to be in touchscreen mode for its thermal
-	 * sensor to operate properly, and that switching between the two modes
-	 * needs a delay, always registering in the thermal framework will
-	 * significantly slow down the conversion rate of the ADCs.
-	 *
-	 * Therefore, instead of depending on THERMAL_OF in Kconfig, we only
-	 * register the sensor if that option is enabled, eventually leaving
-	 * that choice to the user.
-	 */
-
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		/*
-		 * This driver is a child of an MFD which has a node in the DT
-		 * but not its children, because of DT backward compatibility
-		 * for A10, A13 and A31 SoCs. Therefore, the resulting devices
-		 * of this driver do not have an of_node variable.
-		 * However, its parent (the MFD driver) has an of_node variable
-		 * and since devm_thermal_zone_of_sensor_register uses its first
-		 * argument to match the phandle defined in the node of the
-		 * thermal driver with the of_node of the device passed as first
-		 * argument and the third argument to call ops from
-		 * thermal_zone_of_device_ops, the solution is to use the parent
-		 * device as first argument to match the phandle with its
-		 * of_node, and the device from this driver as third argument to
-		 * return the temperature.
-		 */
-		info->sensor_device = pdev->dev.parent;
-	} else {
-		indio_dev->num_channels =
-			ARRAY_SIZE(sun4i_gpadc_channels_no_temp);
-		indio_dev->channels = sun4i_gpadc_channels_no_temp;
-	}
-
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
-				     sun4i_gpadc_temp_data_irq_handler,
-				     "temp_data", &info->temp_data_irq,
-				     &info->ignore_temp_data_irq);
-		if (ret < 0)
-			return ret;
-	}
-
-	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
-			     sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
-			     &info->fifo_data_irq, &info->ignore_fifo_data_irq);
-	if (ret < 0)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-				"failed to register iio map array\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int sun4i_gpadc_probe(struct platform_device *pdev)
 {
 	struct sun4i_gpadc_iio *info;
-- 
2.11.0

