Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3311BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbXr9E95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08B620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJBPJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:09:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35427 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:09:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so783779lff.2;
        Tue, 02 Oct 2018 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vur/nZx57X35xCVeK+GvGWS7rgTTqrCBUYltbYz91FM=;
        b=XbXr9E95kd+StqYEioLGstUrfM0Do5qLwR6m7SSdTQgjp+ip0LE/cqnqq7Hm0T8Z8a
         87+12Xmwl8539NPdKQmZ9adYHFiGqehZgHLubys4NDo8MsGcvgKI7RTD+pTCruRnr4yS
         ydujA7o8KZtXQlH8oX9iYq1VHrJFEn4L4E3xkVpvoOqJPBM14/RpitMaUGwCSJVttS/a
         CphvN05bCk/Cbc9iNnd4BdgRpsY8xiLMVjU3PXsKNVwNlTFjRowSDFz3UGYxOsZfM4Kl
         wUG3I0AISpeuyKP7P0XsUSBfij0EuZPUoUU0UehlcXJKNPSa8nfhkJVZe8BaDI2ZS4iy
         7asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vur/nZx57X35xCVeK+GvGWS7rgTTqrCBUYltbYz91FM=;
        b=SEBYXnRnYn3ZTRVK28tpNMyfiIvlhBCu+J85q5OtHBi7Z4l07YvsgMX9NMdQm8Cnin
         SwzHSB7mD6yc6UUXucYWXtQT8KTSdnWDZ1ttg2HO0f5hn4PvrYfeez11ouZ0MijF0/kA
         UrtwLBTtQ7NKpqSrW1OO5qBODAXYnyHrnN5kWo4HSmhDrGlD30ZAhUNk+SXYQv39Fu+r
         ziPbR0Ysk7k665SrSobuLRMaZnwAjxhFrVf4HnYcm1hp2eVYCrcl/rry+W9ZLFUYTWeN
         3rGhArw5IGRoA11lQRHhgQdztEXvCsaWsRbcfim+/nvhL+Ymu1EHNCIBCphkcrOumCFL
         83cA==
X-Gm-Message-State: ABuFfoj4x6p+wklsVlrLqKdOg1CNaWZyrAD1oM1+51VUeTH5tSXF9SbW
        qrVZw42VAmTsTfGTbM9t0As=
X-Google-Smtp-Source: ACcGV62Fua0sTnDbp25rLcaUy+ljwXApJOvPVWPSXYObHI/OX8TLkQSXJ6IRnahd28fZw7wOqd3KHA==
X-Received: by 2002:a19:d906:: with SMTP id q6-v6mr7488442lfg.62.1538468856559;
        Tue, 02 Oct 2018 01:27:36 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1493531lji.87.2018.10.02.01.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:27:34 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v3 2/3] pinctrl: msm: Use init_valid_mask exported function
Date:   Tue,  2 Oct 2018 10:27:30 +0200
Message-Id: <20181002082731.20141-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
References: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
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

