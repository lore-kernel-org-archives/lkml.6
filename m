Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02007C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926AB20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT6lYmI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926AB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeH3Ts1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52411 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeH3Ts0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so2458958wmc.2;
        Thu, 30 Aug 2018 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6141Ki7LdUw674d0MdnXgMDsiqsMsbsw/lSIG8XBVs=;
        b=NT6lYmI5yFXY3XhT2a8Myi90wRHmOlJKv2BJqHJ1T3iKAEZyEQN+XDucZN+mkifPI4
         2QhItys/+hIIWExLpXM5V4dRGNd/2Ks8P/7iof1q03TL5DZ6NPbPQF7ISFWOb/J4V5f4
         QgI8TeafNUXWSKBK6eWXrqaQtRkJjHdLTL95IPtKaQrAtnNnGHOwEkh4/7Tdcc3ZHBIN
         Fbge05vGS4AwKfeOT665K2vrIkGIB5e4CdpOd+5XdGbyyuFH8qvw0qMw+B7XaxLSCni/
         W0G8xPHcFdtafkFsJnOTsypN1xCAaSozfW9ZZ3DDwWWU/nHqSgvUFmWLhXtT1LLWIv2N
         nYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6141Ki7LdUw674d0MdnXgMDsiqsMsbsw/lSIG8XBVs=;
        b=OYV/16T7jxGrCLWUYCQBTGg4snFLikllVqet4NrKzH0+wAerEgWXQMryIvP4w3eEjv
         KvN1IW7m7b21TFxWFORMs74bZbw9Md9V+W7M5SVg6rvA0mpS8KXhz9Rm6L8BMdyicFMV
         B3a1INN0KQoy2D2G9dng+/b3iUoOQ9Cx5wX42OVY0HtwAvgSe6FnYi22PlsqQKfr93Zy
         Vi5Fba9HmtrL3xjfuVAXcd4b95aMNpI6PU6EyvfmJ77RytoCpR8+Lb65JLMkPKTaeJWf
         taaNHLnSVuqSpCaPVIQJX4G3tgBRXkXWJWSG9bWotP7+t4pc6TjD3h105fUv1MZHCb6Z
         nq+Q==
X-Gm-Message-State: APzg51BjbIe6n4nBiN08Tcy8P2fK8LTdxnar//WgCI414k8rwTbalsnN
        rOVMdToyWZRO/MO7YsiMuY8=
X-Google-Smtp-Source: ANB0VdZ8sncvXVWUgtJ/cgboupUxORCKh5ILa2CfhCfUImztEU9/DcFFeKHRuzX3YsdxRGBHNYcpxQ==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr2123984wma.101.1535643938382;
        Thu, 30 Aug 2018 08:45:38 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:37 -0700 (PDT)
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
Subject: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
Date:   Thu, 30 Aug 2018 17:45:06 +0200
Message-Id: <20180830154518.29507-19-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For adding newer sensor some basic rework of the code is necessary.

This patch reworks the driver to be able to handle more than one
thermal sensor. Newer SoC like the A80 have 4 thermal sensors.
Because of this the maximal sensor count value was set to 4.

The sensor_id value is set during sensor registration and is for each
registered sensor indiviual. This makes it able to differntiate the
sensors when the value is read from the register.

In function sun4i_gpadc_read_raw(), the sensor number of the ths sensor
was directly set to 0 (sun4i_gpadc_temp_read(x,x,0)). This selects
in the temp_read function automatically sensor 0. A check for the
sensor_id is here not required since the old sensors only have one
thermal sensor. In addition to that is the sun4i_gpadc_read_raw()
function only used by the "older" sensors (before A33) where the
thermal sensor was a cobination of an adc and a thermal sensor.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c   | 63 +++++++++++++++++++++++++------------
 include/linux/iio/adc/sun4i-gpadc.h |  3 ++
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index c12de48c4e86..18ab72e52d78 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -69,6 +69,7 @@ struct gpadc_data {
 	bool		has_bus_rst;
 	bool		has_mod_clk;
 	u32		temp_data_base;
+	int		sensor_count;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -84,6 +85,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.sensor_count = 1,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -97,6 +99,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.sensor_count = 1,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -110,6 +113,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.sensor_count = 1,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
@@ -117,6 +121,13 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.sensor_count = 1,
+};
+
+struct sun4i_sensor_tzd {
+	struct sun4i_gpadc_iio		*info;
+	struct thermal_zone_device	*tzd;
+	unsigned int			sensor_id;
 };
 
 struct sun4i_gpadc_iio {
@@ -130,7 +141,7 @@ struct sun4i_gpadc_iio {
 	const struct gpadc_data		*data;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
-	struct thermal_zone_device	*tzd;
+	struct sun4i_sensor_tzd		tzds[MAX_SENSOR_COUNT];
 	struct device			*sensor_device;
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
@@ -280,7 +291,8 @@ static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
 			SUN4I_GPADC_IRQ_FIFO_DATA);
 }
 
-static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
+static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
+				int sensor)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
@@ -290,7 +302,8 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 
 	pm_runtime_get_sync(indio_dev->dev.parent);
 
-	regmap_read(info->regmap, info->data->temp_data_base, val);
+	regmap_read(info->regmap, info->data->temp_data_base + 0x4 * sensor,
+			val);
 
 	pm_runtime_mark_last_busy(indio_dev->dev.parent);
 	pm_runtime_put_autosuspend(indio_dev->dev.parent);
@@ -334,7 +347,7 @@ static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
 			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
 						   val);
 		else
-			ret = sun4i_gpadc_temp_read(indio_dev, val);
+			ret = sun4i_gpadc_temp_read(indio_dev, val, 0);
 
 		if (ret)
 			return ret;
@@ -420,10 +433,11 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
-	struct sun4i_gpadc_iio *info = data;
+	struct sun4i_sensor_tzd *tzd = data;
+	struct sun4i_gpadc_iio *info = tzd->info;
 	int val, scale, offset;
 
-	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
+	if (sun4i_gpadc_temp_read(info->indio_dev, &val, tzd->sensor_id))
 		return -ETIMEDOUT;
 
 	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
@@ -569,7 +583,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 {
 	struct sun4i_gpadc_iio *info;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
 	if (!indio_dev)
@@ -603,18 +617,24 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-						    0, info,
-						    &sun4i_ts_tz_ops);
-	/*
-	 * Do not fail driver probing when failing to register in
-	 * thermal because no thermal DT node is found.
-	 */
-	if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
-		dev_err(&pdev->dev,
-			"could not register thermal sensor: %ld\n",
-			PTR_ERR(info->tzd));
-		return PTR_ERR(info->tzd);
+	for (i = 0; i < info->data->sensor_count; i++) {
+		info->tzds[i].info = info;
+		info->tzds[i].sensor_id = i;
+
+		info->tzds[i].tzd = thermal_zone_of_sensor_register(
+				info->sensor_device,
+				i, &info->tzds[i], &sun4i_ts_tz_ops);
+		/*
+		 * Do not fail driver probing when failing to register in
+		 * thermal because no thermal DT node is found.
+		 */
+		if (IS_ERR(info->tzds[i].tzd) && \
+				PTR_ERR(info->tzds[i].tzd) != -ENODEV) {
+			dev_err(&pdev->dev,
+				"could not register thermal sensor: %ld\n",
+				PTR_ERR(info->tzds[i].tzd));
+			return PTR_ERR(info->tzds[i].tzd);
+		}
 	}
 
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
@@ -639,11 +659,14 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	int i;
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
+	for (i = 0; i < info->data->sensor_count; i++)
+		thermal_zone_of_sensor_unregister(info->sensor_device,
+						  info->tzds[i].tzd);
 
 	if (!info->data->support_irq)
 		iio_map_array_unregister(indio_dev);
diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
index d6850f39dcfb..99feeba28105 100644
--- a/include/linux/iio/adc/sun4i-gpadc.h
+++ b/include/linux/iio/adc/sun4i-gpadc.h
@@ -99,4 +99,7 @@
 	.datasheet_name = _name,				\
 }
 
+/* SUNXI_THS COMMON REGISTERS + DEFINES */
+#define MAX_SENSOR_COUNT				4
+
 #endif
-- 
2.11.0

