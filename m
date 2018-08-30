Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5729AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121D720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSomAZIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121D720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeH3Tt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:49:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40615 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeH3TsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so8510552wrw.7;
        Thu, 30 Aug 2018 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tH+coJrBrADIqfyrRfncPAy+/dBVRmXaC+ssyvweTRQ=;
        b=tSomAZIfZ4Bt/SxfSxf/Vm1zKdiYAyr1R/H/C4bmYm6GUnDwr+TeazwGUEfCwUxOC+
         RDJuxwTtxQ+D22LUu3G0J5w/nhxHwQthP4dwpZv/Ib/N6ZEmEiUl/gYmDRR0hZuWWxne
         FGyyH7Alsg5YAM9BQF7w7V+mpAL0Oy4a05OAPc+3IWztjjdV/Y0OX6EVQcpI5bcdZQyJ
         2ZNBa/nnw+wm0sFvfIgAT4AO7W7TFUs+tGT5X9HYbBqf/5J1PjaYVa2aeknIAEIIjw39
         nDOCQhg9u2JXbXs7wYdB9nuiWDma0KRPEYLprib8b6IGjdop9YqO2euA+2f4OX0fyPb+
         yoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tH+coJrBrADIqfyrRfncPAy+/dBVRmXaC+ssyvweTRQ=;
        b=lxB6JoC+wFY2gJmHh/tteZYY36d4vngHtPXRYKJpxeQvKip3kEyCMpf9mpYhqdifAU
         UIWd9zx1fqCWIY1kadSnFZEBHjm1ev8h+PvLgF3miqEf0aNMPZH7w02sUPnD+trdVeWP
         uOoKw7Pk3aIM7i1myq5YTArvjoOOgvlklJygsdD2SoLqsSbVnwQiKqjQiBG4UuTGj/0b
         8KYHhX3aHFy7eNBNY6bUvMZ2yHBqg3UblUPaVcua5mPuBXSaEwCRDQNj9H7CuCP9LEWt
         I0Dtv6FTgsaPji8l32M+9QW/vZHAwnnJEgQKt1PkS0f9il3Pduk5Z6bt+cQk7X/JdxKD
         VBHA==
X-Gm-Message-State: APzg51BIHFmZr/jBk0BtukfUE5jKqgHwyk3wxxuiuBsoGOmYY06bzEDv
        HQw4rnDvsk7wSmP+It5XsdA=
X-Google-Smtp-Source: ANB0VdYSolJLm8cuC5xWQsxS+GbMgnObtfCJ9RZYtvbZrdjeMUkgcnzZlH1oDuWWGIYLOM3Dq+uLxg==
X-Received: by 2002:adf:c64e:: with SMTP id u14-v6mr7702233wrg.177.1535643934972;
        Thu, 30 Aug 2018 08:45:34 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:34 -0700 (PDT)
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
Subject: [PATCH v3 15/30] iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain A33
Date:   Thu, 30 Aug 2018 17:45:03 +0200
Message-Id: <20180830154518.29507-16-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

As the H3 SoC, which is also in sun8i line, has totally different
register map for the thermal sensor (a cut down version of GPADC), we
should rename A23/A33-specified registers to contain A33, in order to
prevent obfuscation with H3 registers. Currently these registers are
only prefixed "SUN8I", not "SUN8I_A33".

Add "_A33" after "SUN8I" on the register names.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c   | 2 +-
 include/linux/iio/adc/sun4i-gpadc.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index e1fe5e8e9dc0..d48f338af563 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -106,7 +106,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
 static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
-	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
+	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
 };
 
 struct sun4i_gpadc_iio {
diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
index ca59336f246b..d6850f39dcfb 100644
--- a/include/linux/iio/adc/sun4i-gpadc.h
+++ b/include/linux/iio/adc/sun4i-gpadc.h
@@ -38,9 +38,9 @@
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
 
-/* TP_CTRL1 bits for sun8i SoCs */
-#define SUN8I_GPADC_CTRL1_CHOP_TEMP_EN			BIT(8)
-#define SUN8I_GPADC_CTRL1_GPADC_CALI_EN			BIT(7)
+/* TP_CTRL1 bits for A33 */
+#define SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN		BIT(8)
+#define SUN8I_A33_GPADC_CTRL1_GPADC_CALI_EN		BIT(7)
 
 #define SUN4I_GPADC_CTRL2				0x08
 
-- 
2.11.0

