Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14790C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE9820837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTL2MKoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE9820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLGTL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:11:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42975 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:11:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so4448072lja.9;
        Fri, 07 Dec 2018 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lZ1jc9eu+qngoQSAA5KNgJbshVX5vnWxLkDtgSyMDI=;
        b=DTL2MKoPhuwQPtRKrUkKDelyhdY0lUC3nLAMbQyPWQLlC7mGxuY/CZY4GMsZqQwp0t
         Xu13lS2mvRDFmTWR+WsWDufyPomAn7GXFezlHdZ7DKYBgNKitStQ0bC+axqBzWhR+17w
         dL0jlpgfIZjczX+6NFsihD7beFxAg2gDIJvkH9YAvSyJUDKSJV4Z5g+2DmDwXR89nox2
         HgOs53kUfkVdhQWDbYHCwneGMkiXRmqDu7opknV1OTHQz+d5DX/bdOn7dRchfriJv4fI
         LUY/u9F8HHy4OMsLpM09hHUV7zx8+VV4IBr7soB0jQfAKetVkRFfeUbWFoj00PLKNOMr
         NLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lZ1jc9eu+qngoQSAA5KNgJbshVX5vnWxLkDtgSyMDI=;
        b=I4kwnGleL6FMovpwywXTtI4ShxqlYajBiudxNlscM8shvgG4OMquE/T24Bg7SKfGfU
         07+tNViw8zz++c3GTQESIrisWXeU54pJ6NMNMSOP9+quj+QYmmfrecoqoqBpk+VwQzlp
         bFhs48Cs3EgfP4mI1uF79Jemhe9INB8/5O9mYedofFn8uyZ1NZg6A5S5PNKC5FG4R1Md
         BpFj+zMZHL8HOY5vRD032xOjaPgPm7LuqgxPsKPw11j9ea5lYfIJgQvAh02Vwpv8LZkR
         +CmFA1AbZ8F3v82laz5qU+OAkjEaZa367MXTu59eCpoYlVQsLTXoN95IZAis18c9X3p9
         ZjVw==
X-Gm-Message-State: AA+aEWbBQRpwvRM8sswyawtwSFUZg7lyCrAM0OtmI8GVRIn3s9vE+4mv
        3/2TM3OAwNhAjoMFDDMI1I4=
X-Google-Smtp-Source: AFSGD/XLtd860YcbUUErKxHr82lc8x+SxGhOFNQbMdvXXFtQCqeBCCCTlBgHl0KRWlpBUEotjGf0nA==
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr2030639lja.46.1544209910517;
        Fri, 07 Dec 2018 11:11:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:11:49 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, broonie@kernel.org,
        arnaud.pouliquen@st.com, baolin.wang@linaro.org,
        smohanad@codeaurora.org, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
        geert@linux-m68k.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: exynos-adc: Add S5PV210 variant
Date:   Fri,  7 Dec 2018 20:11:34 +0100
Message-Id: <20181207191136.5464-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

S5PV210's ADC variant is almost the same as v1 except that it has 10
channels and doesn't require the pmu register

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/iio/adc/exynos_adc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index f10443f92e4c..fa2d2b5767f3 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -115,6 +115,7 @@
 #define MAX_ADC_V2_CHANNELS		10
 #define MAX_ADC_V1_CHANNELS		8
 #define MAX_EXYNOS3250_ADC_CHANNELS	2
+#define MAX_S5PV210_ADC_CHANNELS	10
 
 /* Bit definitions common for ADC_V1 and ADC_V2 */
 #define ADC_CON_EN_START	(1u << 0)
@@ -282,6 +283,16 @@ static const struct exynos_adc_data exynos_adc_v1_data = {
 	.start_conv	= exynos_adc_v1_start_conv,
 };
 
+static const struct exynos_adc_data exynos_adc_s5pv210_data = {
+	.num_channels	= MAX_S5PV210_ADC_CHANNELS,
+	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
+
+	.init_hw	= exynos_adc_v1_init_hw,
+	.exit_hw	= exynos_adc_v1_exit_hw,
+	.clear_irq	= exynos_adc_v1_clear_irq,
+	.start_conv	= exynos_adc_v1_start_conv,
+};
+
 static void exynos_adc_s3c2416_start_conv(struct exynos_adc *info,
 					  unsigned long addr)
 {
@@ -478,6 +489,9 @@ static const struct of_device_id exynos_adc_match[] = {
 	}, {
 		.compatible = "samsung,s3c6410-adc",
 		.data = &exynos_adc_s3c64xx_data,
+	}, {
+		.compatible = "samsung,s5pv210-adc",
+		.data = &exynos_adc_s5pv210_data,
 	}, {
 		.compatible = "samsung,exynos-adc-v1",
 		.data = &exynos_adc_v1_data,
-- 
2.17.1

