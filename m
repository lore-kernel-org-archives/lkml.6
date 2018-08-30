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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526420834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmaS1q+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7526420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeH3TsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53882 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3TsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so2472763wme.3;
        Thu, 30 Aug 2018 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GG6wm40smk2VetGm2lnviKqcGAT7hYe3vQr/oTzaQVI=;
        b=bmaS1q+BXPmP+DBPMWuqMWjvwRfnyLvqywziuN95cD4E2O2H/937CWvaU7dZGRLfIB
         TNRg2u02nRjE/1uV1ZWJ3llffiaf+/xJvWhJNkNe1rffeAUhxNF84g5U6aQsjPVj1W/8
         SImjeOvtj2Tzv3c8OPFIrUY/VnOon5z6mX4nijxLnSN3qwRqX5ZcmTakFNd/OmrHR6Wz
         s9eWI6ggYw9pOxvwuATKCl1KZ9jY/ejuGwVwLnvsRxgYJm4Z9UaRD0u1jnwd3HnBSAxw
         Zu5W1BxReIWEFeXrxzTprw77LxhzdxvJw3yXI+Wtf4/yfprWDsSh8TjI+i25nCXdJaOW
         Y0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GG6wm40smk2VetGm2lnviKqcGAT7hYe3vQr/oTzaQVI=;
        b=dWQlmP2YnFN7O75a3P9PCahB5+wLd3FDQzZ3eMdHkSe5odC6oD4ia6JPi9BHHCoKAL
         5MwVTvitWhZwCDA5ZyFZo0kHdHkVnKlH3QsSngbaiO5dXKPgbIu+XbBSWgeIMF5ZSdLU
         hc8zDNUNq41hjf1yWN3IOwcIUySWasKYWXeRuQhk8HAouSY/f+IQHm7E4Z2cQUUB0CBQ
         Wb9j83vOSUWFKidFdGt9tSuGSMhNJ0JPX0fsEPcJa2CPcJUL3iBCxs/0ke6S0yUHBeOS
         7LlcKzTviNLEOcYZOVzUGxHf68h3tTGofGmmfrypmR8jZRkTPEX94q0qlfGmGwlKkYtk
         pudw==
X-Gm-Message-State: APzg51BIniBWQnBRFMRmcEgVidehMns7dZ8bPaO+xbjTsdjEzej24TGI
        n4/KFcZwPrqclqOkichT+RI=
X-Google-Smtp-Source: ANB0VdartHcfUT/nLcBRFFSP0xJuRdhM2ofPyAGtXEWOSTAVOlQdEA31+/7iJBAgj7G7lNw7quj1hw==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr2114853wmf.59.1535643936145;
        Thu, 30 Aug 2018 08:45:36 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:35 -0700 (PDT)
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
Subject: [PATCH v3 16/30] iio: adc: sun4i-gpadc-iio: rework: readout temp_data
Date:   Thu, 30 Aug 2018 17:45:04 +0200
Message-Id: <20180830154518.29507-17-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For adding newer sensor some basic rework of the code is necessary.

This commit reworks the code and uses regmap field to read out
temp_data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d48f338af563..c278e165e161 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -63,6 +63,7 @@ struct gpadc_data {
 	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
 	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
 	bool		support_irq;
+	u32		temp_data_base;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -77,6 +78,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.adc_channel = true,
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -89,6 +91,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.adc_channel = true,
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -101,12 +104,14 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.adc_channel = true,
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 struct sun4i_gpadc_iio {
@@ -271,18 +276,18 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
-	if (!info->data->support_irq) {
-		pm_runtime_get_sync(indio_dev->dev.parent);
+	if (info->data->adc_channel)
+		return sun4i_gpadc_read(indio_dev, 0, val,
+				SUN4I_GPADC_IRQ_TEMP_DATA);
 
-		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+	pm_runtime_get_sync(indio_dev->dev.parent);
 
-		pm_runtime_mark_last_busy(indio_dev->dev.parent);
-		pm_runtime_put_autosuspend(indio_dev->dev.parent);
+	regmap_read(info->regmap, info->data->temp_data_base, val);
 
-		return 0;
-	}
+	pm_runtime_mark_last_busy(indio_dev->dev.parent);
+	pm_runtime_put_autosuspend(indio_dev->dev.parent);
 
-	return sun4i_gpadc_read(indio_dev, 0, val, SUN4I_GPADC_IRQ_TEMP_DATA);
+	return 0;
 }
 
 static int sun4i_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
-- 
2.11.0

