Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08022C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B083820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT2aLqwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B083820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeH3TsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36115 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeH3TsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so2528012wmj.1;
        Thu, 30 Aug 2018 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c6Ey3Xe6CN/vhTyJgfjyN2P4uA8psZ12lezphNsl3O8=;
        b=WT2aLqwbvZWYRL1x96iSTzU+B4CACYgVizEDuSTCdgumBQ2wlbmQC+50S6MwT29d0p
         O/8kqtcyg8In7OQH5WzkOu3UBR+PhFZth9mUoNsViY0Nt/bJxxqZgEsa0b5mFkdR8J4f
         wC0dT1XNeCWc0HDsfXOKuzZp0sqPMxguf6bNYS2J3YoFtr0KUmKlT/Ao7sQmz1Jz3nOe
         9pAr2pPxwEtMJ10GrdDl8AcOaYlpx7aaAbj+MAGrGPxPH1lAEU61kQZTTtaoXmuc3u0Z
         nRc3HEtT/oQ3y9Png8XVbSe2BAoFYc0OoFg7RMFXYrVbcsbbrlrJG4lgSntS4BQrdtBF
         EHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c6Ey3Xe6CN/vhTyJgfjyN2P4uA8psZ12lezphNsl3O8=;
        b=iS/A7cbkMgB8frkrkKyDWw+B2x3UUUWAi0xmzZswau1nhfCloOtaIrnrD4sTTQjTLm
         x6jTP5tXsrlmCUpKSKnGLQuRBzVS/k/TCQgKrC1E+pS9wj2xrS2bwx9RRnNsRJgH3c1a
         Rb5C44Ykz5/RzjCVK8Y0xLVdLA8ESgbfuErGsh/SuZ33GXL2GBcoLfI7kvKZzVBMS7yP
         43OpozOQQDaZqwNZBMHD8tc4pkGIrzkpw9MnsyU7+0CmPr0H287dU9Rq+z1J6bPfo+bB
         fMon0s2dj+TgWI9Trb7nIVm/Rr+epTpOsJM/3vNI9hnyVUP3X9Qj3oqwhs/1I0zJ09Vu
         c07w==
X-Gm-Message-State: APzg51AhUkf7zyshjm0JW1Mr5gIg23elCEbx4i+CJg6O2Mq4CbPdRcLx
        im4narmlVkT9nleqxrI66Zw=
X-Google-Smtp-Source: ANB0VdY0ssrNPLY2K5WNdfkiCKFiZwOWX1cXOMfVV1gHhZ+53D8544pYl1mtXuXsbZORGEEy6PQmcw==
X-Received: by 2002:a1c:1f48:: with SMTP id f69-v6mr2113339wmf.152.1535643924712;
        Thu, 30 Aug 2018 08:45:24 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:24 -0700 (PDT)
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
Subject: [PATCH v3 05/30] iio: adc: move SUN4I_GPADC_CHANNEL define to header file
Date:   Thu, 30 Aug 2018 17:44:53 +0200
Message-Id: <20180830154518.29507-6-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are moving the SUN4I_GPADC_CHANNEL define to the header file.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
 include/linux/mfd/sun4i-gpadc.h   | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d95dd0fde2a6..666329940e1e 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -109,15 +109,6 @@ struct sun4i_gpadc_iio {
 	struct device			*sensor_device;
 };
 
-#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
-	.type = IIO_VOLTAGE,					\
-	.indexed = 1,						\
-	.channel = _channel,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-	.datasheet_name = _name,				\
-}
-
 static struct iio_map sun4i_gpadc_hwmon_maps[] = {
 	{
 		.adc_channel_label = "temp_adc",
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 139872c2e0fe..54c7c9375c1b 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -90,6 +90,15 @@
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
 
+#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = _name,				\
+}
+
 struct sun4i_gpadc_dev {
 	struct device			*dev;
 	struct regmap			*regmap;
-- 
2.11.0

