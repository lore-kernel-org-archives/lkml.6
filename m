Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F265F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="u3Q4zH4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBKKhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50836 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfBKKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so891356wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
        b=u3Q4zH4InQZAGR7svFMkRl7v89pFKfHGoRrnJFlv5DW9Px1T+nn4Q2VhAPlAPpq9Vc
         MO+q9mckzodN35P/zXsf2kMs2hUX306418rHNrmmGXyZA2ZoWXhkjisQAY1JyYwkKzHs
         lB85w49K3cPwbDMTMw0WaLs4xaa11TgDZuie+m/2RZ+8qMprTWEv5+IeJPyaGZRRfD1I
         MMikG29Rk+LjyyZ+RYXT4XxSMl7qC5CGS32pm2Jjq4CsgecqzVuJ4bzRM9OCIBkK5hDg
         AuCfBpK5kAE+t5DNYH7bfn5rSQOpkGvKg8k2ASkkrun97VzQ3biLXyYtoVmJHn6geSif
         j/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
        b=ivprB4ZWqiXhr1uRE40rbIXNA9MwdkcrG5aAg2LNeQUUY0VHRPXXBR88mxzdCevRit
         g71K5o9Tw6Tw2QG66GckQ//vjZccoDTkhdVv0Y6j4taHeKvOxkO7mPoHjI//tgygzQP9
         1oVS3hyVc0g0GjXhYnpiHRXU3yjkHfecHhKj/PHnHn2WX/nJGPBUDQFtUc7xrLvTZ+7D
         5pvJfvH7dgGptULaVeKZJ7ZCqXdjtjvhzbvIsx0PUkAWPiYshR+KP6uiGCMqhDcog7P/
         eGNsvjyFZBGzMO+pGvVT1L+OMR2EkPLox0oT/AuqFxLGKi9+phKLyOTB0sp+yi6/1NT/
         RTMQ==
X-Gm-Message-State: AHQUAuZ3QvpLEF2eL2NDTud+q0MwKwg/vLcunRcEdA2mkCD/IDmjieJ6
        TOmiIauvSFzMFEnBXnzvSt3dSQ==
X-Google-Smtp-Source: AHgI3IZe1dMiumbFFArVH10zKtDOgopWjaSrOZMfbCL3N1BeBwlapJzl5oFuZGmteU62M2T/bQ24Cw==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr8285090wmi.141.1549881434634;
        Mon, 11 Feb 2019 02:37:14 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 7/8] ARM: davinci: da830-evm: remove legacy usb helpers
Date:   Mon, 11 Feb 2019 11:37:01 +0100
Message-Id: <20190211103702.4277-8-brgl@bgdev.pl>
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

