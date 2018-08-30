Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE06C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DA320836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNWOp0PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DA320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeH3TsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeH3TsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so8500348wre.10;
        Thu, 30 Aug 2018 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5XND9vHjfuJCOwJpFz7zMX/u/hpV4Qa0BGP58J/DvOk=;
        b=TNWOp0PAQHFrUDVCcHK0c4JtKL0NoAr5sk9Sj+OC0whe1rqb0aWUX2gGlSE0Vm+aMp
         j5Ti6Sc7JwEFNxgodD1mBSZDfxesQvlBe6cqTSBS8eHPj8NkJ4X6gqUUfC4et2Rih3SR
         TNVIpnaevlZtr2lMfAVo7sGUg/dvjSfUO3V73cTNsDLBctf2ET2j1nth9a05CdtkdlZ9
         o+U/hl+6+3TM83z0q2vQXzMSen+DzFC10If2E2/1lGhCrZP9kSt4ZRiQc+6E2+3Z1nhL
         KnIXLIcBGl8+0l4QawJdXQeGcIiZFMz6B+Fj9e0HgsLXQ8ELyS0qruBhznyrSX/cTRpp
         ddKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5XND9vHjfuJCOwJpFz7zMX/u/hpV4Qa0BGP58J/DvOk=;
        b=HrsyCCrQPw01/4lKluHxg8JA0S9lu6s70wXJlV9cpZJI73taE4fFSTJabskN4E+nRz
         OrwVL6vZ1+pTBmdzUS93mgSoS3Dk7jRSyF056T2tbG+jFdxf4JpsF6qrJCA92FgiI0Xt
         y2RZ/ztFfFU89pN5U/xJmv5XPelPOLmEySxqFZ+vNxmGL+QhrjEcL8vHK3rI2msjwqQh
         DucbBKO1Ot5/AY/kcsLi6ZhaCqmfP9/TNXlNkyl+u+/Dhuqf2golqYww5yxcJVZ/C5WW
         y5YrKkSXKDPEv+wDfYYVAprKidQY5ZX7xFS1J2K6zx+OJaYwgt2fHzeey61vUmSbeHYH
         +xbA==
X-Gm-Message-State: APzg51CzCH4JEFgsiAJVFVaG+bFNP/dTaSV25ccK+wW48lQY4NyjBGkm
        Bmd50UDiPd4nOSXbxekNbms=
X-Google-Smtp-Source: ANB0VdbimhtaitKvqHvNaGjItKwbG+oI0Tg7BVULZDbnbRdQ/1/LwDiOKY96rI7o/z4NQ0cRTyM6xQ==
X-Received: by 2002:adf:e648:: with SMTP id b8-v6mr8388682wrn.254.1535643928697;
        Thu, 30 Aug 2018 08:45:28 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:28 -0700 (PDT)
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
Subject: [PATCH v3 09/30] iio: adc: Threat A33 as thermal sensor and remove non thermal sun4i channel
Date:   Thu, 30 Aug 2018 17:44:57 +0200
Message-Id: <20180830154518.29507-10-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to use this driver mostly as thermal sensor, that still supports
the adc for the older chips, thus we threat the A33 as thermal sensor.
We also remove the adc channel without thermal support.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index ab474ce86fb6..658a7e3e3370 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -123,23 +123,6 @@ static const struct iio_chan_spec sun4i_gpadc_channels[] = {
 	},
 };
 
-static const struct iio_chan_spec sun4i_gpadc_channels_no_temp[] = {
-	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
-	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
-	SUN4I_GPADC_ADC_CHANNEL(2, "adc_chan2"),
-	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
-};
-
-static const struct iio_chan_spec sun8i_a33_gpadc_channels[] = {
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE) |
-				      BIT(IIO_CHAN_INFO_OFFSET),
-		.datasheet_name = "temp_adc",
-	},
-};
-
 static const struct regmap_config sun4i_gpadc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -444,8 +427,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return -ENODEV;
 
 	info->no_irq = true;
-	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
-	indio_dev->channels = sun8i_a33_gpadc_channels;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem);
-- 
2.11.0

