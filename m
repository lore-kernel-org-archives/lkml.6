Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938362083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MoAHwcxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfBEK0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34765 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfBEKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so936640wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z56W91f7fqmIDFSLo4iJF9+SrfI/T8Kx4jtFNkkkjzw=;
        b=MoAHwcxemgeMFWMQt4IdehE/7Fdw7yCzsmTWpDEnr1CEQQbs/ddD4vX93WWur3pRVT
         9KvEXV+cxsw9u+g3n0+IzpCObafCXqv4aKzH/I8wez8C/0suiYi9VR2pfRix+uaQ/jSJ
         QHuClehNjVoP0tEtdK4/khhrZ3Icej2tk2LLBc1VmAAD1UYDLuW75GXX0cvH1qKvN9EH
         b1xHsIL2PxLzW0gEeZ63b6xJQZdRBSGZ1uZGto0pyimuwKgbcym/pObsPUS89u9EYHTJ
         puT3NdlfRn03FTs9PcGu+2IICupyTvSEYAcoNW6ej/M+R6cKoK5xie9TZkGj1bQzN4MQ
         eTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z56W91f7fqmIDFSLo4iJF9+SrfI/T8Kx4jtFNkkkjzw=;
        b=km4rFLn4Pu4nv7a1TQFOSvL1jxg/1pYKlhgvo0jI/uaoi6QeyeiS3pv/EvI61rdOZF
         e0SE3KnbpqKr+e4SxEidSJNZI+l8z4oKu49R8eZyIkddWOTkPK/s4vFcH7CAUQyO6c3/
         fezhQPDsBLXVyM2kWyf4wN6XlzpbRNWzVoWoRFRJXCnlVkO2gCX7zbTkIQMXlwI4+kSt
         5yjJYAEQu/yOHU9Gw/nvRbYuavNjWfBl2Y7IwQcsgfcMcqyGK+ETS65WbvRifFLpyRvm
         KE2H51Mzq4Fh+VQ2elo7rTnjqhe3hZvmWXCxSt+8w5okS2DqkwCZgq/3c1ivtK9cOZvG
         i+RQ==
X-Gm-Message-State: AHQUAuYNhNUihUkjulpy8IX5Yh78yHC3I39uBXtYNG9E1BIl25gQjSsW
        UapLY7/4A5pC0u9c/jcI8vKfyQ==
X-Google-Smtp-Source: AHgI3IbX4VJ9GcfVZ5wpdRdpWJ4nD2fAZBEhplwdWN3bhxqRzFHpzwHkY3dH9afTxW0lezeUb6XNUQ==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr3247348wra.100.1549362357530;
        Tue, 05 Feb 2019 02:25:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/8] ARM: davinci: omapl138-hawk: remove legacy usb helpers
Date:   Tue,  5 Feb 2019 11:25:44 +0100
Message-Id: <20190205102546.29457-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
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

