Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92181C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20E20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOYif+ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A20E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbeIUQYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:24:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43423 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:24:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id u23so1191175edx.10;
        Fri, 21 Sep 2018 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KRReny5VpNNTdbbaaXk16iyPudk0xjZLoIJb/EyF1q4=;
        b=OOYif+ZMRuVWJtkZCPtl6stUw53hCHfJ8PKmYLkj8YzuXHwPx6mJ6/7Ufoeqc7bb1H
         znHGP+uAUPtqPW+/Dkcp0sM1i3suHR+yvSVSWCcC08Np5XIWkzczCBVq+wOLUWt/cwKb
         tb4t/7k16ZXaewz64JVhd7uDiXdAacXBcAnqU/opD/bPj5pwJEOhemqwXVuq7Igj2hge
         enr6UxSRF78/W3YefIggVNHSQVqU5GVPwvxD37Qt6nmNegKOcuhx5xTQeDm1+qfd7W17
         lvnKuxXlhfaceiwDK+qaIUcH4X74QplfT2uImGMO0Qfc6Gxqvd4zTVDQhujKzBAjkSlW
         iwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KRReny5VpNNTdbbaaXk16iyPudk0xjZLoIJb/EyF1q4=;
        b=ECDHAVfCTeFxl1/2eaIlvjFY2NU541Qd2YhzkaDw1RUGQS1VwbO/FqITkFgOvWEAtD
         7qJQbSkEKbKhyFsjQbYlKbKdCWPb36KgPInwE85UggBZ1cTrzHHDD2lWpUSf922I8wrF
         0sef9d3kFg0WKS7nj/a50PNzfH6HjrWLBJXGzd/gFK/2QEFTZebqj0la2x4KjsTZjMSN
         SRkWhtWZPdE62Aky8uCxHsSHpGoSf+dS5Y3TMD3zb9SSjcjr00b6/Isk5lNvHHZJ2tDW
         N8O+kSjXAP3Jqt9jbBEwwgB3DFkt0m8GrTPwQS21QDv9A+M42N09ijr5jkzegnEt9CWA
         4AhQ==
X-Gm-Message-State: ABuFfojYc4OfoLfowIprSzWN1bEappf9I+64fZjf3HhZs4KtDVCHp+V/
        iDSjgsjckUFgunCrFy36Zpg=
X-Google-Smtp-Source: ACcGV63aMUmSu/jN7ly0seSJt/WHOvU5D9fxk5pVoNJ2YVNIcna88n84Ck1xnEw07xp+IbfLSZKxMA==
X-Received: by 2002:a50:d9c6:: with SMTP id x6-v6mr2650063edj.63.1537526166941;
        Fri, 21 Sep 2018 03:36:06 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id k28-v6sm1900871ede.11.2018.09.21.03.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:36:05 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] gpiolib: Fix gpio_direction_* for single direction GPIOs
Date:   Fri, 21 Sep 2018 12:36:03 +0200
Message-Id: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs with no programmable direction are not required to implement
direction_output nor direction_input.

If we try to set an output direction on an output-only GPIO or input
direction on an input-only GPIO simply return 0.

This allows this single direction GPIO to be used by libgpiod.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a57300c1d649..4b45de883ada 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2512,19 +2512,27 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
 int gpiod_direction_input(struct gpio_desc *desc)
 {
 	struct gpio_chip	*chip;
-	int			status = -EINVAL;
+	int			status = 0;
 
 	VALIDATE_DESC(desc);
 	chip = desc->gdev->chip;
 
-	if (!chip->get || !chip->direction_input) {
+	if (!chip->get && chip->direction_input) {
 		gpiod_warn(desc,
-			"%s: missing get() or direction_input() operations\n",
+			"%s: missing get() and direction_input() operations\n",
 			__func__);
 		return -EIO;
 	}
 
-	status = chip->direction_input(chip, gpio_chip_hwgpio(desc));
+	if (chip->direction_input) {
+		status = chip->direction_input(chip, gpio_chip_hwgpio(desc));
+	} else if (chip->get_direction &&
+		  (chip->get_direction(chip, gpio_chip_hwgpio(desc)) != 1)) {
+		gpiod_warn(desc,
+			"%s: missing direction_input() operation\n",
+			__func__);
+		return -EIO;
+	}
 	if (status == 0)
 		clear_bit(FLAG_IS_OUT, &desc->flags);
 
@@ -2546,16 +2554,28 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
 	struct gpio_chip *gc = desc->gdev->chip;
 	int val = !!value;
-	int ret;
+	int ret = 0;
 
-	if (!gc->set || !gc->direction_output) {
+	if (!gc->set && !gc->direction_output) {
 		gpiod_warn(desc,
-		       "%s: missing set() or direction_output() operations\n",
+		       "%s: missing set() and direction_output() operations\n",
 		       __func__);
 		return -EIO;
 	}
 
-	ret = gc->direction_output(gc, gpio_chip_hwgpio(desc), val);
+	if (gc->direction_output) {
+		ret = gc->direction_output(gc, gpio_chip_hwgpio(desc), val);
+	} else {
+		if (gc->get_direction &&
+		    gc->get_direction(gc, gpio_chip_hwgpio(desc))) {
+			gpiod_warn(desc,
+				"%s: missing direction_output() operation\n",
+				__func__);
+			return -EIO;
+		}
+		gc->set(gc, gpio_chip_hwgpio(desc), val);
+	}
+
 	if (!ret)
 		set_bit(FLAG_IS_OUT, &desc->flags);
 	trace_gpio_value(desc_to_gpio(desc), 0, val);
-- 
2.18.0

