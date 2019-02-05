Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E5D2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pLsvjfhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBEK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40319 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfBEKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so2972854wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27fRyiWZ0ynKcoArUhLUGUmMVLR0Snw6wALdX/O3/sY=;
        b=pLsvjfhe2Sy72wpGSTZbBewjTkEl0VspBE+T+E1szo5SGxX/EqNhmaSDxa3VaAqpk9
         iY2q1k1tvbYR0+FRyPooAuFg0g0K8hhpfw4nM1OANWTI71KI9xXCCo9nBal3lNDDgF6r
         HZ+sITobg8KTheefnAdWQ9ZdtUct49EseHmWHNHmeowUg7BwLt+ipykYCYmspsbo1zdk
         ka8b7/Jqgyf3vrDLet67yeyIvSmvtKHUr/CoKABmShP7IjSq0sVDZZIZOiB4z0kH9Oph
         GHUQgHiP8LWxqWEho9Y79r69uOk/mtB6Gu90H9poeiMKKX/ygxY+E+28X+OtMsZlosAI
         seUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27fRyiWZ0ynKcoArUhLUGUmMVLR0Snw6wALdX/O3/sY=;
        b=Fv/1V0js2iyvevaKHxgcaS+NtV4fG5Q0hSaISJvtacPXfH4oaV9EB/arqZtyYeL4nI
         HIEjiTmDOk+VxajKo/KZdanD8ADRFKws683FtUMXANsKI6OD8pXjInVc3N6R8wt9Sf0J
         2PSeAeJ1lH9gm64Me8sGc9b35JRVOu06GIHVOAINXnH2Hu0LYA7MMamGdAy0GE+VqqXK
         zB7o7DxoEx1bivONHB4HnJi3WQFr8RZtRFvMTVLlOZWR8ioQWNw6/iqaJ3nWSmtDTzrA
         kuuz+kIE2BhuRHDD1J2TT2Ca85HB/Dtxb11JhsmJPoWgeNr8bQ+xfS/6iYkwwtJ01X1o
         tCDw==
X-Gm-Message-State: AHQUAubwPNCEVpXPeSORH6z50inP3ej6IyyfoDr/QMWLXgjn7sCFkQIE
        vxwoXZqGvK/nu7WSQ3pjQXmpDg==
X-Google-Smtp-Source: AHgI3Ib//l3NPzOtNoGwt14htmcBcVhmPw9WtBzSknykhyhvUWdPbFvZ/ophHf3xBiYQnoYsUR1X9w==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr3022054wma.19.1549362354011;
        Tue, 05 Feb 2019 02:25:54 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/8] ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
Date:   Tue,  5 Feb 2019 11:25:41 +0100
Message-Id: <20190205102546.29457-4-brgl@bgdev.pl>
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

Add lookup entries for the vbus and overcurrent gpios for omapl138-hawk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 94c4f126ef86..856c5707bae9 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -302,6 +302,14 @@ static const short da850_hawk_usb11_pins[] = {
 	-1
 };
 
+static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
+	.dev_id		= "ohci-da8xx",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, "vbus", 0),
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_OC_PIN, "oc", 0),
+	},
+};
+
 static int hawk_usb_set_power(unsigned port, int on)
 {
 	gpio_set_value(DA850_USB1_VBUS_PIN, on);
@@ -390,6 +398,8 @@ static __init void omapl138_hawk_usb_init(void)
 		goto usb11_setup_oc_fail;
 	}
 
+	gpiod_add_lookup_table(&hawk_usb_gpio_lookup);
+
 	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
 	if (ret) {
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-- 
2.20.1

