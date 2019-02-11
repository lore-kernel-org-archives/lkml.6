Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFCFC282DC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666EC2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oWmZOODH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBKKhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54873 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBKKhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so16789803wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDfzI32lULSZi0KPO52EnMBMtQh72KGGsTTNyrojGSQ=;
        b=oWmZOODHEAixm/1e2wgdfOLsfIc9IDHSjpG1BwW0YuPn2nUl/ttK9oOzgpCPJtzS6N
         DuKSO+zvN/upV89PdkHuedTqjSJX/AJKkafNhPrmdRpOmO1jF1kEMkGhz7k/bYyb1scx
         g340TQM7jblbGE5aPe6knXbPMrpCnYwGDzun+BWgwjNA3JuIxo/+6RTTA6jHztqlUFK7
         yOZs0jo0M6VVIN7EEHP5uELpGpDhFAa895/GyEqymT8PaIXDmd0eIwTOX+ob0Ie2F0/U
         3ZoZDJJrWQ9OKcRWjUijSWeduUbFFA3mdqWdutGDLfO5hlNdlHuRsyh9ebelNVyDgA3o
         PcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDfzI32lULSZi0KPO52EnMBMtQh72KGGsTTNyrojGSQ=;
        b=onUZgid24BvooMbWCjJQXQ+11t56lkBHQX7cSL65HZt8ry4HI9j1r11x7mRXmCoGHX
         Jj9yOKkWVWEHczPtDi8ko9eDrR6HN7wAMjUUazs1K2enmh+07EcELXbRUXyrdxOOr/r7
         K/GWqHg5pz/pp3jTB0kqyMpA9QdIZNuRYqv1Y/z5Wl9YQvEYiYQun6F86ky4NVkuhiC/
         t5RIHkQgdr0WZX7jowuqmKZRO/MCMu//VNoYfHxSj7G5hT/utWBKSFJijl/Qotxkzwop
         gA/hn+ggbhgHDvCQJ17MOEcE0ACoEKqLcD8AYFQgQ8kRuCtaF0xnlpxy2szcZwJgf//p
         WVmQ==
X-Gm-Message-State: AHQUAuZ7hc7YKWvOtz0CDJfImUPI6XJCA0faGl+sS4IKrq29CBrEn+zG
        O97kTujzH4LNgJOkVB1qKnO6iw==
X-Google-Smtp-Source: AHgI3IYXhpG/oxXOdIneaSd3s3Pky+0wz1hkzYaJnd5e3gipZIWhNMei/K1g/PlCdRxJnupjWMrGxg==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr17674777wru.21.1549881431259;
        Mon, 11 Feb 2019 02:37:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/8] ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
Date:   Mon, 11 Feb 2019 11:36:58 +0100
Message-Id: <20190211103702.4277-5-brgl@bgdev.pl>
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

Add lookup entries for vbus and overcurrent gpios for da830-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

