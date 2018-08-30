Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30FEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EAE2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh6RwoWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EAE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeH3Tsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37078 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3Tsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so2500260wmc.2;
        Thu, 30 Aug 2018 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uoEW1Lce/hl33oDLPjB5cxodu2SyLnmSsJFrygMlmqs=;
        b=Jh6RwoWxDC3TNp+VvxHA+iolxoDzrXV+U7Lig65VMEdphV+dgKItdD0cdGltj+F4/m
         Jkisj0SVxZvgvCy2jnDA1jWzMx+3wU2dfB2MWxCQLCcWkv23PAXb2L6x5MgL7BaGpdz8
         B6h3Xx7ndTOT23W8++WlBtHZZUH3UwxFT9PdPmVhppFFEzxHMBHkdGlzJFThpsaNf9Fj
         wrUPRh0BVAW10kNHPDr3s/1Q7J/RdS7qlA0eqxIk5b7PZaGAQ36ea33uMd2/mcibOHo+
         RYJxY/57n7StOFIrrSozokTZRRcRjSZNxOqzmmyq98Kx8L957SeiWjaVicnwSuiPADWm
         pOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uoEW1Lce/hl33oDLPjB5cxodu2SyLnmSsJFrygMlmqs=;
        b=lrSt2rMpnUX5dlGJ3u+2+GtTaLiAwfR6ueaOplfy952lqOCUaqcB0/0T4Dig8+Peoj
         nM0JlE07j0fD/xBfMoj7ZZwrJnLQdhi8mL9tXnpB22rZ9zY5PfKBGbDAfUXBvOLGIZGI
         TkvuOYRjMT1WGy7CgpXsQ8BGdICxkF+3D/Apj3SO7bJ75WIAOJGMGmebGzAlcvHcyTiw
         Jj3oSEnHbS/Gg5+L8hGr3XvTMpPCV7TVkqlKgkW7K8aUMTLbJ1oX/SmrwQoT7U4Hh96u
         1jd3aH82pHNIDujxwK6GGmgzyjc7wM6PcJXoLbjDsaFHHwMRPK5WgUoc7M4GA4w4wZ4e
         GPig==
X-Gm-Message-State: APzg51Bc3Efrgarne7t+B8YZzH/xE8+kpgeW1CLosQOImHvJK20LP0DV
        vUkiL+CMW5GwCbSGUJ6LXm8=
X-Google-Smtp-Source: ANB0Vdaq010tVp+C/vjyjcNY1De7ly6z1Dl5gNXx3Cp9eE4zj+WxCXnCKw1WvQ9PtrcXGG7mXER/Eg==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr2139131wmx.75.1535643943254;
        Thu, 30 Aug 2018 08:45:43 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:42 -0700 (PDT)
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
Subject: [PATCH v3 22/30] iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
Date:   Thu, 30 Aug 2018 17:45:10 +0200
Message-Id: <20180830154518.29507-23-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the A83T ths sensor.

The A83T supports interrupts. The interrupt is configured to update the
the sensor values every second.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c   | 59 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/adc/sun4i-gpadc.h |  6 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d5c7971b2558..a184a87c56d4 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -84,6 +84,8 @@ static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info);
 static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info);
 static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data);
 
+static int sun8i_a83t_ths_resume(struct sun4i_gpadc_iio *info);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -158,6 +160,21 @@ static const struct gpadc_data sun8i_h3_ths_data = {
 	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0,
 };
 
+static const struct gpadc_data sun8i_a83t_ths_data = {
+	.temp_offset = -2724,
+	.temp_scale = -70,
+	.temp_data_base = SUN8I_H3_THS_TDATA0,
+	.ths_irq_thread = sunx8i_h3_irq_thread,
+	.support_irq = true,
+	.sensor_count = 3,
+	.supports_nvmem = true,
+	.ths_resume = sun8i_a83t_ths_resume,
+	.ths_suspend = sun8i_h3_ths_suspend,
+	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0 |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_1 |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_2,
+};
+
 struct sun4i_sensor_tzd {
 	struct sun4i_gpadc_iio		*info;
 	struct thermal_zone_device	*tzd;
@@ -541,6 +558,44 @@ static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun8i_a83t_ths_resume(struct sun4i_gpadc_iio *info)
+{
+	u32 value;
+
+	sun8i_h3_calibrate(info);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
+			SUN4I_GPADC_CTRL0_T_ACQ(0x13f));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
+			SUN8I_H3_THS_ACQ1(0x13f));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
+			SUN8I_H3_THS_INTS_TDATA_IRQ_0   |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_1 |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_2);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
+			SUN4I_GPADC_CTRL3_FILTER_EN |
+			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
+			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
+			SUN8I_A83T_THS_INTC_TDATA_IRQ_EN1 |
+			SUN8I_A83T_THS_INTC_TDATA_IRQ_EN2 |
+			SUN8I_H3_THS_TEMP_PERIOD(0x257));
+
+	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
+			SUN8I_H3_THS_TEMP_SENSE_EN0   |
+			SUN8I_A83T_THS_TEMP_SENSE_EN1 |
+			SUN8I_A83T_THS_TEMP_SENSE_EN2 |
+			value);
+
+	return 0;
+}
+
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
 	struct sun4i_sensor_tzd *tzd = data;
@@ -588,6 +643,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-h3-ths",
 		.data = &sun8i_h3_ths_data,
 	},
+	{
+		.compatible = "allwinner,sun8i-a83t-ths",
+		.data = &sun8i_a83t_ths_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
index 169b4de9a34d..673459bb3ec3 100644
--- a/include/linux/iio/adc/sun4i-gpadc.h
+++ b/include/linux/iio/adc/sun4i-gpadc.h
@@ -105,13 +105,19 @@
 #define SUN8I_H3_THS_CTRL2				0x40
 #define SUN8I_H3_THS_ACQ1(x)			(GENMASK(31, 16) & ((x) << 16))
 #define SUN8I_H3_THS_TEMP_SENSE_EN0			BIT(0)
+#define SUN8I_A83T_THS_TEMP_SENSE_EN1			BIT(1)
+#define SUN8I_A83T_THS_TEMP_SENSE_EN2			BIT(2)
 
 #define SUN8I_H3_THS_INTC				0x44
 #define SUN8I_H3_THS_TEMP_PERIOD(x)		(GENMASK(31, 12) & ((x) << 12))
 #define SUN8I_H3_THS_INTC_TDATA_IRQ_EN0			BIT(8)
+#define SUN8I_A83T_THS_INTC_TDATA_IRQ_EN1		BIT(9)
+#define SUN8I_A83T_THS_INTC_TDATA_IRQ_EN2		BIT(10)
 
 #define SUN8I_H3_THS_STAT				0x48
 #define SUN8I_H3_THS_INTS_TDATA_IRQ_0			BIT(8)
+#define SUN8I_A83T_THS_INTS_TDATA_IRQ_1			BIT(9)
+#define SUN8I_A83T_THS_INTS_TDATA_IRQ_2			BIT(10)
 
 #define SUN8I_H3_THS_FILTER				0x70
 #define SUNXI_THS_CDATA_0_1				0x74
-- 
2.11.0

