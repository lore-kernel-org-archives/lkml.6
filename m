Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB66222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UvyOVHH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbfBMNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:45:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54539 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390700AbfBMNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:43:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2505942wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHjGX90PhzkO2zCPEWu+WmU7YdHgBvwkN4duLM8BeyU=;
        b=UvyOVHH6XZA5nKIFrxKAEJCRdIR3VvozWK1VikwT3gVvyArYBz5UZFkvE3mQrZXlXg
         wV6XfXtwCb4rLeWA4QgmtRJsCCErzbFqYQ7DUglQQS8mTv0euAKGdjqAkfb/3no7KtaW
         PrV+mCKHxynJZg3OvGfDptF995cVMXPF+jchGuHWQtQ/lG7Iz029dp0DweloQPQYCMxO
         t9Uq6SyYWuLgeGneRlJyskFQGdlK1Rvsua6je0ocZzanSQn/Pl74Lzo25pHV3EkbGaNB
         wL+PDt11LFAglZ7osvsgU7x9pkTYcmpjoB5tqaqj6e0lZz33Yndid3GWNRqm/u1Y+Td/
         hLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHjGX90PhzkO2zCPEWu+WmU7YdHgBvwkN4duLM8BeyU=;
        b=gHKYGRNj2xGV70ya+J+KGpHCKsqpWF6rqR6Do/Bkb2j6he52pRkRmFJ/a5/iPQhCiB
         EF5A3UQtLEEdJkg2BmE6U4Kfw8Vk0TVIDo4y+7BgfK49WgayMBPrO9BFJ6Vc4KtaGhCH
         lW+F2HmcPTph6HlSyOkn3Fcn78Z2HV7bPpIy4MSYX457y/2holUuQMFj9zBURkKkCQho
         M4BHKH0bthaVA84a+duW0wfYoJP1Px3R/Dw529l08EMg6L1rKfZLF5aDCqhFYPZ7wCwx
         TTDGINNC91K3l5/y2sw+4/GF8a16xzyOYU2BFSlz2lxaDArdnJfUglp+JjVL/NNLN7zF
         Txlg==
X-Gm-Message-State: AHQUAuYwvm+asRN+RXGE277YdD2MHLZaXlh5+j9OOhKwaJzDmjsoWzo7
        N+FTgJ3o7rLx5fgdwDqqkTbplA==
X-Google-Smtp-Source: AHgI3Ibwu+jFcZzOVRtX+31o+c2713At08tHLqC86VEjBV/58awy09PMGE/Jh+fgpXaKyPYdcgwXkg==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr376169wml.11.1550065430363;
        Wed, 13 Feb 2019 05:43:50 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:43:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Wed, 13 Feb 2019 14:43:25 +0100
Message-Id: <20190213134335.10838-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134335.10838-1-brgl@bgdev.pl>
References: <20190213134335.10838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device and the GPIO module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/mfd/max77650.txt      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
new file mode 100644
index 000000000000..0a40e9c6aab8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -0,0 +1,47 @@
+MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+Required properties:
+-------------------
+- compatible:		Must be "maxim,max77650"
+- reg:			I2C device address.
+- interrupts:		The interrupt on the parent the controller is
+			connected to.
+- interrupt-parent:	phandle of the parent interrupt controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:	Must be <2>.
+
+- gpio-controller : 	Marks the device node as a gpio controller.
+- #gpio-cells : 	Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+The GPIO-controller module is represented as part of the top-level PMIC
+node. The device exposes a single GPIO line.
+
+For device-tree bindings of other sub-modules (regulator, power supply,
+LEDs and onkey) refer to the binding documents under the respective
+sub-system directories.
+
+For more details on GPIO bindings, please refer to the generic GPIO DT
+binding document <devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	pmic: max77650@48 {
+		compatible = "maxim,max77650";
+		reg = <0x48>;
+
+		interrupt-controller;
+		interrupt-parent = <&gpio2>;
+		#interrupt-cells = <2>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "max77650-charger";
+	};
-- 
2.20.1

