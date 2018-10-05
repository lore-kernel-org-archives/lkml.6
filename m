Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFDFC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB320834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYVQqPMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeJENuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:50:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44794 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJENuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:50:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so10593064ljc.11;
        Thu, 04 Oct 2018 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vur/nZx57X35xCVeK+GvGWS7rgTTqrCBUYltbYz91FM=;
        b=qYVQqPMKGTGHtunHtFiNbFIuSsdgfFB3V9FeDzdfgUwSZltEXYGZHIodlzQRg+cWEG
         JxfgMjN28n6SkTbtU8FXdkYiyFZ8DRM8Jn6m9qkLFblITUg2Cms6fqh5rky+BKzQz4aw
         g4OBFMKces3u+Ks1RkNhgN9tCs+orOUlHbdWFHTBEessJhgV1ezoj4CvokaRagZUp4v3
         xD/lygdcnD6CqRIVbUeXfUDC0FF0Y113J3UjbyqNVKheRp41gWTetJau7S4IlOOkrJ5a
         0hGBXw5TMraXwJ2OhB3aujX8ROy4K5A/05XHcREMZVM0Jy7jB77P8UEOFhyL/zANVsQb
         vSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vur/nZx57X35xCVeK+GvGWS7rgTTqrCBUYltbYz91FM=;
        b=C+qelVJLr4XQT6ibOKhY/sVUzg8XHpJJ81oC4yUAX9sH0rQImI6GRpoR4j77lXYIZP
         RVrxBBF/UgrfNxdMe2D3cXZUZe0D15dQAbdz2/0KVQFv04tljlGg4pJleRXL4oIpUZ4B
         5AU6jEB2tsQGgGKcG/BTZVJioknAYDjYYcIaAlNBpJWtWAjmgKIGWRU4YhlATSyGyA/J
         NoBrFYPx6hAKKD/089nkNeYyazJRmu8dWGkcsDYxCtEn2dfgURvJ43GNwMKSjksttHb2
         wBahWwoMQl43P0EE/CdkZIv50p93op5ACh3YVd4BXETG95DT7R6IXMdJGUMooiccE5An
         Yfhw==
X-Gm-Message-State: ABuFfojpm3QkgrN8OBrIL8HHwTYblEjBhLDZdFvFH2AuEZ0tCHjyPCxt
        41zstY67jhpM/zLt/sHqfDU=
X-Google-Smtp-Source: ACcGV62BleszJBHQ4ziXtPFnoQP8eyBBW3tE2zuv37bQERXQnNXDZru3onPunOHXbtJsAj0u1BAqgw==
X-Received: by 2002:a2e:48d:: with SMTP id a13-v6mr6214857ljf.27.1538722384567;
        Thu, 04 Oct 2018 23:53:04 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id t21-v6sm1608871ljg.32.2018.10.04.23.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 23:53:02 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v5 2/3] pinctrl: msm: Use init_valid_mask exported function
Date:   Fri,  5 Oct 2018 08:52:59 +0200
Message-Id: <20181005065300.22882-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code produces XPU violation if get_direction is called just
after the initialization.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 79 ++++++++++++++----------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 5d72ffad32c2..ce1ade47ea37 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -566,6 +566,42 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #define msm_gpio_dbg_show NULL
 #endif
 
+static int msm_gpio_init_valid_mask(struct gpio_chip *chip)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
+	int ret;
+	unsigned int len, i;
+	unsigned int max_gpios = pctrl->soc->ngpios;
+	u16 *tmp;
+
+	/* The number of GPIOs in the ACPI tables */
+	len = ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL,
+						   0);
+	if (ret < 0)
+		return 0;
+
+	if (ret > max_gpios)
+		return -EINVAL;
+
+	tmp = kmalloc_array(len, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp, len);
+	if (ret < 0) {
+		dev_err(pctrl->dev, "could not read list of GPIOs\n");
+		goto out;
+	}
+
+	bitmap_zero(chip->valid_mask, max_gpios);
+	for (i = 0; i < len; i++)
+		set_bit(tmp[i], chip->valid_mask);
+
+out:
+	kfree(tmp);
+	return ret;
+}
+
 static const struct gpio_chip msm_gpio_template = {
 	.direction_input  = msm_gpio_direction_input,
 	.direction_output = msm_gpio_direction_output,
@@ -575,6 +611,7 @@ static const struct gpio_chip msm_gpio_template = {
 	.request          = gpiochip_generic_request,
 	.free             = gpiochip_generic_free,
 	.dbg_show         = msm_gpio_dbg_show,
+	.init_valid_mask  = msm_gpio_init_valid_mask,
 };
 
 /* For dual-edge interrupts in software, since some hardware has no
@@ -855,41 +892,6 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
-				    struct msm_pinctrl *pctrl)
-{
-	int ret;
-	unsigned int len, i;
-	unsigned int max_gpios = pctrl->soc->ngpios;
-	u16 *tmp;
-
-	/* The number of GPIOs in the ACPI tables */
-	len = ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
-	if (ret < 0)
-		return 0;
-
-	if (ret > max_gpios)
-		return -EINVAL;
-
-	tmp = kmalloc_array(len, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp, len);
-	if (ret < 0) {
-		dev_err(pctrl->dev, "could not read list of GPIOs\n");
-		goto out;
-	}
-
-	bitmap_zero(chip->valid_mask, max_gpios);
-	for (i = 0; i < len; i++)
-		set_bit(tmp[i], chip->valid_mask);
-
-out:
-	kfree(tmp);
-	return ret;
-}
-
 static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 {
 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
@@ -926,13 +928,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		return ret;
 	}
 
-	ret = msm_gpio_init_valid_mask(chip, pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
-		gpiochip_remove(&pctrl->chip);
-		return ret;
-	}
-
 	/*
 	 * For DeviceTree-supported systems, the gpio core checks the
 	 * pinctrl's device node for the "gpio-ranges" property.
-- 
2.19.0

