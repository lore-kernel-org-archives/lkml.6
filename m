Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC2C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F972145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1acO/Tza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfBEK0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38399 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfBEK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:26:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so2980445wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
        b=1acO/TzaTS03s9bceKurSqbS0vnd6Wsw05XIWMfb6Q2TUUfpvFDveRnfJ2Kzk4em+l
         OjQL9v8R1DrfVaeDQKUkF8JOrVbqpzOgHmFXnRmTr92FWfHKpJddgbQc7TQmC4ztVaS5
         tPZtuw7wux1ULY4TvoZEMToU38yEeWQi9Twg+kDMuTrCEdw6plCxpJX2C0ihtxWe2TC6
         ey5twDj3VC8lUzf9lCYzwyIdbiMb3NrQ6rd5Od4Kic4x+LZIisPDbAi9+PTCNgdbFcCQ
         zQ0kEbnp3QIochiozQP6p8/PQ1IU5+yylC87Xie+1IvcLeEG7kztOVefqgvRU2moGjaG
         0ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
        b=Fyqy/+KNvXdhtJgyQ+lMS8+3J66OcyALEcPRas/nxqg/kt1ViMH73vmr5dzPYTC96v
         Ykb1k7TQAkQHphYDhr+gY9uvU48l2huAOHGBUVp55ZoGOaihjKb8RalF+Uigu0RGpd+0
         MOi/Lrbv4EE29mm4coLj4BKZo0SGeA2CgIc44KFhagr26r/SNQ7Pd2xSTxvXDD96zaGH
         OqjhZrY/2g4VHVCMXkxgI4MzIkRz1c2T1y6YO9QJH96pKMSAcx/oUqwyhJ5v2kPcfTXw
         /IVN3yufzMD6ThtZLh0VmOELU235BJiNEGQTBP7kO4qYvWQOzyq9WVrLvAuLAnsWGfa+
         Ty2A==
X-Gm-Message-State: AHQUAuY512XUq7kiUruPHHWb0pfErkZZIIPv5abp43sQnsSlcY7OKSew
        d8cdlaoQQt703X5cSPvkgKbm2Q==
X-Google-Smtp-Source: AHgI3IaJHGNe/jeXwZM5GgTrUi1I/64CzT56Inrtp+00XAI6g8YCac9ynWVLI2Q0xYU6hZq2/Weg2A==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr3225217wrm.2.1549362358789;
        Tue, 05 Feb 2019 02:25:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 7/8] ARM: davinci: da830-evm: remove legacy usb helpers
Date:   Tue,  5 Feb 2019 11:25:45 +0100
Message-Id: <20190205102546.29457-8-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 67 -------------------------
 1 file changed, 67 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 0712a37153a8..8d30f68773a0 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -52,8 +52,6 @@ static const short da830_evm_usb11_pins[] = {
 	-1
 };
 
-static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
-
 static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
 	.dev_id		= "ohci-da8xx",
 	.table = {
@@ -62,60 +60,11 @@ static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
 	},
 };
 
-static int da830_evm_usb_set_power(unsigned port, int on)
-{
-	gpio_set_value(ON_BD_USB_DRV, on);
-	return 0;
-}
-
-static int da830_evm_usb_get_power(unsigned port)
-{
-	return gpio_get_value(ON_BD_USB_DRV);
-}
-
-static int da830_evm_usb_get_oci(unsigned port)
-{
-	return !gpio_get_value(ON_BD_USB_OVC);
-}
-
-static irqreturn_t da830_evm_usb_ocic_irq(int, void *);
-
-static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq 	= gpio_to_irq(ON_BD_USB_OVC);
-	int error	= 0;
-
-	if (handler != NULL) {
-		da830_evm_usb_ocic_handler = handler;
-
-		error = request_irq(irq, da830_evm_usb_ocic_irq,
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				    "OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch over-current indicator changes\n",
-			       __func__);
-	} else
-		free_irq(irq, NULL);
-
-	return error;
-}
-
 static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
-	.set_power	= da830_evm_usb_set_power,
-	.get_power	= da830_evm_usb_get_power,
-	.get_oci	= da830_evm_usb_get_oci,
-	.ocic_notify	= da830_evm_usb_ocic_notify,
-
 	/* TPS2065 switch @ 5V */
 	.potpgt		= (3 + 1) / 2,	/* 3 ms max */
 };
 
-static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
-{
-	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata, 1);
-	return IRQ_HANDLED;
-}
-
 static __init void da830_evm_usb_init(void)
 {
 	int ret;
@@ -150,22 +99,6 @@ static __init void da830_evm_usb_init(void)
 		return;
 	}
 
-	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port power control: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_output(ON_BD_USB_DRV, 0);
-
-	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port over-current indicator: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_input(ON_BD_USB_OVC);
-
 	gpiod_add_lookup_table(&da830_evm_usb_gpio_lookup);
 
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
-- 
2.20.1

