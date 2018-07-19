Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29593C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98C320661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7HCB+Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98C320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbeGSRDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:03:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38996 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbeGSRDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:03:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so6966250wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mtoEkUenwKXEVaYbLXYNYms73QdfgGVwiTkvGMMXbUc=;
        b=h7HCB+TimIpmhToaMwJaEFFBzqR+qNrE9o1oaW0duPE1abrV7PPQPZ6duGld4DAnke
         FSDCW+uiu/Gg0rxhhYxKBN0L1bCrk4qvROu6rRJwh82SE6tAoAj/dL/aeHfkaebJoK4U
         xpMckLeth5OMVrl60O0VGUoTh2YpM4CX+I8og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mtoEkUenwKXEVaYbLXYNYms73QdfgGVwiTkvGMMXbUc=;
        b=LymxUd4EGx6TRE4HmDLBuFQjnLIzl6R1nFCF2VG9ccTw3ym4QmKnqOOF93ivzemWhH
         7SirNPbFi6i7poVb66WYMS15ZE6sceMunIJGSJwxtx54tQDW5CWv3m1IA1w+lvp+TLql
         GV1/yd05902RPI9R4Thgg53FIH09wg97nsi7NR737gCNQ6bEG5RoYWBu7yLnvIN0yLuU
         +LNohERFoqqeNfO5VaLQ1jILxhzr/iQ6PihseVhd2EG4xbd+hKPl2ow6RDAUDXP5l4Wk
         Ef02eF6Sk8ksrMqudiAeHcSqBf4CWX+73Zqfqa5CJLyCHtmkGZgLRI8y5+V7lQKqVZwq
         J1Yw==
X-Gm-Message-State: AOUpUlFI/pFtd7Tiyu+i4nk9SULPRGDruvF0CPh6Wk14ryBdsshTwwqd
        DC3+UXAoADdkdWEU6B6/dVOONw==
X-Google-Smtp-Source: AAOMgpfIqTeUDtC/mnpNFU20vWnw+LXi5Tc8gDdWQ9ZjGdUjz1URvCU7vRVr/4wiH79C2QDo++mI8Q==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr4753800wmj.130.1532017182509;
        Thu, 19 Jul 2018 09:19:42 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r125-v6sm9610361wmb.27.2018.07.19.09.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 09:19:41 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2] backlight: pwm_bl: Fix uninitialized variable
Date:   Thu, 19 Jul 2018 17:19:23 +0100
Message-Id: <20180719161923.21510-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716210241.9457-1-daniel.thompson@linaro.org>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined and the interpolation code will deploy randomly.
Fix this.

Additionally fix a small grammar error that was identified and
tighten up return code checking of DT properties, both of which came
up during review of this patch.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Notes:
    v2:
     - Simplify SoB chain (with Marcel's permission)
     - Separate complex if statement and make other similar calls use same
       return code checking approach
     - Tidy up comment formatting and fix pre-existing grammar error

 drivers/video/backlight/pwm_bl.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..f7799f62fea0 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -284,30 +284,29 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		ret = of_property_read_u32_array(node, "brightness-levels",
 						 data->levels,
 						 data->max_brightness);
-		if (ret < 0)
+		if (!ret)
 			return ret;

 		ret = of_property_read_u32(node, "default-brightness-level",
 					   &value);
-		if (ret < 0)
+		if (!ret)
 			return ret;

 		data->dft_brightness = value;

 		/*
 		 * This property is optional, if is set enables linear
-		 * interpolation between each of the values of brightness levels
-		 * and creates a new pre-computed table.
+		 * interpolation between each of the values of brightness
+		 * levels and creates a new pre-computed table.
 		 */
-		of_property_read_u32(node, "num-interpolated-steps",
-				     &num_steps);
-
-		/*
-		 * Make sure that there is at least two entries in the
-		 * brightness-levels table, otherwise we can't interpolate
-		 * between two points.
-		 */
-		if (num_steps) {
+		ret = of_property_read_u32(node, "num-interpolated-steps",
+					   &num_steps);
+		if (!ret || num_steps) {
+			/*
+			 * Make sure that there are at least two entries in
+			 * the brightness-levels table, otherwise we can't
+			 * interpolate between two points.
+			 */
 			if (data->max_brightness < 2) {
 				dev_err(dev, "can't interpolate\n");
 				return -EINVAL;
--
2.17.1

