Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D822F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVRJpklC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D822F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeH3Tu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:50:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55437 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeH3TsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so2477184wmc.5;
        Thu, 30 Aug 2018 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=awFDsrjcpE5oAq0WnCWku0Gz21mtatXT2tD8s1pCm9w=;
        b=CVRJpklCpNJsCTdg11FncVMkwcUQVQA1BlM9n47a9EIY+R8d0ofPHmS9q1EC0UfDpz
         H2452z7JiwuolbMoiF3yM8uBLqKqjxwwzTTyYnsXToWWncvcQatk5kdzcjJF3OMmra9u
         /YVDw+o+2STQj+nJ27FduOkNCuLLMzKbCauXkUMDbKROroYSTPwrubhV+qFrgpXltUrz
         Lf+9SNEDKW2pq3y4UctwY1h35sbR9XFJ6oOTDaOnH9k7xxBNm8/qHPyi42CBOwMs/i35
         hYGEmuv2bPwXDMCze5yzAUgs1ncm+KZ/YCKWY/I5sh27ZeQDdvTS+EgwbaZ6C5fmRax0
         cELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=awFDsrjcpE5oAq0WnCWku0Gz21mtatXT2tD8s1pCm9w=;
        b=fRKJlsl6cD8VX8kNct1dU+XXaPJv6kuSSfO1kRCYQs0CzP2KgOwDkWjiOPDBQzrX3k
         kCorsr0RXi8LDAeSJ1hVlbTVsevC30bJA0IG5WN2EKxqtN6Q8LBfzmR3afio9xJdR0BE
         /cmxZl3DBauTUgDmVW3eL2o7nHPATLSXsTtHJeJo61euczpq313729GLyFwO74rK4Qbc
         UvFbXEwwpueAZ0QWrB8l+YKkayZ5oYCC7TL75auMdltkNe6B0JLBbpAlp/yqEx/T7zL6
         C69nxowdhTrsFDMx5k49qfQTLLKN/1dPvhfxbbIDioHm8OgaizJxyTdwhxTzNRaOIu0f
         3YAQ==
X-Gm-Message-State: APzg51B/5wBPRg/GHTGLke4O55lmuLKPL9VgUo9TV7PEiHdZjziVL8H4
        a69ddz2hrEBgLu3XbAtUfT8=
X-Google-Smtp-Source: ANB0VdaiSw2OprTQRSxIQK11FYUAWcbWxEvRfhNWqaQJhP7+j8aNXVGYvRjkqXfQz97UM7mg5BLNIw==
X-Received: by 2002:a7b:c096:: with SMTP id r22-v6mr1839371wmh.118.1535643927725;
        Thu, 30 Aug 2018 08:45:27 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:27 -0700 (PDT)
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
Subject: [PATCH v3 08/30] iio: adc: remove hwmon structure
Date:   Thu, 30 Aug 2018 17:44:56 +0200
Message-Id: <20180830154518.29507-9-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We remove the hwmon structure that was requiered for the mfd driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index f787442a9e5f..ab474ce86fb6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -109,14 +109,6 @@ struct sun4i_gpadc_iio {
 	struct device			*sensor_device;
 };
 
-static struct iio_map sun4i_gpadc_hwmon_maps[] = {
-	{
-		.adc_channel_label = "temp_adc",
-		.consumer_dev_name = "iio_hwmon.0",
-	},
-	{ /* sentinel */ },
-};
-
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
 	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
 	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
-- 
2.11.0

