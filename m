Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A1FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494EA2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vAP2BenT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfBEK0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfBEKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so2991753wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLOzCbKWD80mlDEOSPNdWjjwiH1Ipwg9Oy8HlbpRsTU=;
        b=vAP2BenTdlZm0orJT9mvE5UCY8UMTRZWEauOeamJFuOW/jGj8fV0mV5qFzFJewGLbd
         JFvmy55LgY64QP96lKrxdgpMGk5FKq/S/1k87WiFOUlqOhikHS5rlh1d0xd85+lVSiN2
         6XbSQGqrFt6QE09vtEoqi1amlddpYzcJUvbAeWNelZlMH950txMHvgmu5vuzZ9/7mTFU
         QuA8YIzd8l+XEnXIuky08t/ZDyZXHQ7xC5ht7UH+YjMNQsBmBqh/pOiEqzpnY9ME/1by
         vwWnckJ7Qpl80NXD+g/CAHh/uTr8xhTMeCKO4AOrmo0L33jELUp2X54CUdkWM1zyOkqA
         9+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLOzCbKWD80mlDEOSPNdWjjwiH1Ipwg9Oy8HlbpRsTU=;
        b=UyfarkNszSyx0D6O9LCD6DHnvLlFIXSp6Vf3WaDfFAJAR9F7YRfBxm32XSV0g1Mc5L
         LO59hAZbBfcOpyyEsrsQJHlKFAPzFidgLi6cnbrYlHakiVeuyLI9NJZnbW0DsklAnXff
         97Z2rps1gM3OMM37lbqSslcwPxP/tr185wSZ66AOzSBKXks9tgAF44J46Bf408DQr4de
         wiOO4xQYPxjxuRCy9MnC+nAoLvMCM9rqdVSl9W711TTsdadc7f62YiwRe5ugfeOiKlwS
         Xjke643mkhKkIUXLGJaW/rmSVmp/eGWkC83Xp73l+tRTwz35a9PgaxZOSL5egkzPgPDF
         NbZg==
X-Gm-Message-State: AHQUAubyru8+KFN+co2bVtdV5KLNzqwetvhqXm3ojY5XAYnW7N50Oyb/
        eTCY/G7y9ebVcABZnm3BWrpnDw==
X-Google-Smtp-Source: AHgI3IaAs81CZZtfteh3BPxtLJAaLsBYbc/ux/lHNRGTT8q5dKsCcDlFmHXEK/CTWJ+bO9cLbgRPNg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr3088898wmf.3.1549362355078;
        Tue, 05 Feb 2019 02:25:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/8] ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
Date:   Tue,  5 Feb 2019 11:25:42 +0100
Message-Id: <20190205102546.29457-5-brgl@bgdev.pl>
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

Add lookup entries for vbus and overcurrent gpios for da830-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c4da635ee4ce..0712a37153a8 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -54,6 +54,14 @@ static const short da830_evm_usb11_pins[] = {
 
 static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
 
+static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
+	.dev_id		= "ohci-da8xx",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_OVC, "oc", 0),
+	},
+};
+
 static int da830_evm_usb_set_power(unsigned port, int on)
 {
 	gpio_set_value(ON_BD_USB_DRV, on);
@@ -158,6 +166,8 @@ static __init void da830_evm_usb_init(void)
 	}
 	gpio_direction_input(ON_BD_USB_OVC);
 
+	gpiod_add_lookup_table(&da830_evm_usb_gpio_lookup);
+
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-- 
2.20.1

