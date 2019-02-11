Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67435C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3487F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zQKAKx5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfBKKhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50830 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfBKKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so891175wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z56W91f7fqmIDFSLo4iJF9+SrfI/T8Kx4jtFNkkkjzw=;
        b=zQKAKx5zLCaIyJYe1hm0ICz57RS4juItNm7pQ+l/pKGcHfA1cpzsoH3JBO1gnbYz97
         ovcETZOVvWT1Ccyquku63LHG1Zl7Yx0Spu/YIvcsG6xLO2r+2EMkoT9jzhhHFxqQMehJ
         JlVFhEo30R/dyUhqD1G+TAfZVlqmtm1nFJVk/2gSRUfo7FtHmbLo7gJdRHWeWfBjdmPm
         DPciAVRXifK7o6PsRe/LMbjWr65/Fu5dlVj27bBJuuEgDrCUXEn4vTowoFcNNNhdSptw
         DNqOAUqVqJ5zJtRJIcXTQPP6YaI9zHt3Eo0bxN/+92N3CQJ9eRNi5etVO3f2VqnSnMnl
         LS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z56W91f7fqmIDFSLo4iJF9+SrfI/T8Kx4jtFNkkkjzw=;
        b=ijlgXXjR8WX9FiFgDS+WjFhycgZqEFvAqyg4vSJ/ovPe1uBN9+Luvd/HbLQOTwboJJ
         YthOcLnHXxD66b0eS5H9s7KP3msxYbRpeIRsQj626yiNKrr/goY8VJMVgjVwPtY2G+XL
         oXXaubgzo2Is4xpo4Tka1MklPHBDhC3PAP9Ge9qfMlEbGkmDmgggC76xvdhX2kULk8Fh
         pVRV4dZzDjl2+vs5+SVy4TWzhh7Q/6TEe+cI8AqfE7BBLGyDM6dRfNtnASAQnpLVA0ra
         eFUkr+SJ2CpT3jWqxcM6kPLlBIwj+hgRgaV6ZHEbMMnUey/bPadXcBf1lHT93z+oV8B9
         h9BA==
X-Gm-Message-State: AHQUAuaU4K0Oq4PF4qY5cOD0FPWKwilKTsn5VmN4RZVoVqAUzKPyTsB8
        j8QcY43VgMW/PN8jCFS6JyY8Aw==
X-Google-Smtp-Source: AHgI3IaqtZZIN/H9RqZ5gAnvMDY+UmAo0KBTaI2NvxnknK+IG282wnQAzpD+m61G25BbXjxFwbvBwg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr7468234wmk.47.1549881433564;
        Mon, 11 Feb 2019 02:37:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 6/8] ARM: davinci: omapl138-hawk: remove legacy usb helpers
Date:   Mon, 11 Feb 2019 11:37:00 +0100
Message-Id: <20190211103702.4277-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The logic implemented by these routines now lives in the da8xx-ohci
driver. Remove dead code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 75 +--------------------
 1 file changed, 1 insertion(+), 74 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 856c5707bae9..88a0c62eee86 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -294,9 +294,6 @@ static int omapl138_hawk_register_aemif(void)
 	return platform_device_register(&omapl138_hawk_aemif_device);
 }
 
-static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
-static da8xx_ocic_handler_t hawk_usb_ocic_handler;
-
 static const short da850_hawk_usb11_pins[] = {
 	DA850_GPIO2_4, DA850_GPIO6_13,
 	-1
@@ -310,58 +307,11 @@ static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
 	},
 };
 
-static int hawk_usb_set_power(unsigned port, int on)
-{
-	gpio_set_value(DA850_USB1_VBUS_PIN, on);
-	return 0;
-}
-
-static int hawk_usb_get_power(unsigned port)
-{
-	return gpio_get_value(DA850_USB1_VBUS_PIN);
-}
-
-static int hawk_usb_get_oci(unsigned port)
-{
-	return !gpio_get_value(DA850_USB1_OC_PIN);
-}
-
-static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
-	int error       = 0;
-
-	if (handler != NULL) {
-		hawk_usb_ocic_handler = handler;
-
-		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
-					"OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch "
-				"over-current indicator changes\n", __func__);
-	} else {
-		free_irq(irq, NULL);
-	}
-	return error;
-}
-
 static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
-	.set_power      = hawk_usb_set_power,
-	.get_power      = hawk_usb_get_power,
-	.get_oci        = hawk_usb_get_oci,
-	.ocic_notify    = hawk_usb_ocic_notify,
 	/* TPS2087 switch @ 5V */
 	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
 };
 
-static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
-{
-	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
-	return IRQ_HANDLED;
-}
-
 static __init void omapl138_hawk_usb_init(void)
 {
 	int ret;
@@ -382,36 +332,13 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB PHY registration failed: %d\n",
 			__func__, ret);
 
-	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
-			GPIOF_DIR_OUT, "USB1 VBUS");
-	if (ret < 0) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port "
-			"power control: %d\n", __func__, ret);
-		return;
-	}
-
-	ret = gpio_request_one(DA850_USB1_OC_PIN,
-			GPIOF_DIR_IN, "USB1 OC");
-	if (ret < 0) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port "
-			"over-current indicator: %d\n", __func__, ret);
-		goto usb11_setup_oc_fail;
-	}
-
 	gpiod_add_lookup_table(&hawk_usb_gpio_lookup);
 
 	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
-	if (ret) {
+	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-		goto usb11_setup_fail;
-	}
 
 	return;
-
-usb11_setup_fail:
-	gpio_free(DA850_USB1_OC_PIN);
-usb11_setup_oc_fail:
-	gpio_free(DA850_USB1_VBUS_PIN);
 }
 
 static __init void omapl138_hawk_init(void)
-- 
2.20.1

