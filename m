Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EEEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3BE2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LUsFREtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfBAJtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:49:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46572 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfBAJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so6281919wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7jIseMqCPPj3u7DXuTWdGC+Sbz7UI6uCT01nprpTw4=;
        b=LUsFREtRjSp7ytn52sF1HluRFd4G56Fqe7qQ5svPHxksVpYwI3vyzQRWEzT5GO1NBW
         Sf4pXmJUE/X012pkE6tvtXXCI1U1ngGpcxOu+QiNIndtzdu6xt8p351dlBYmRyblVxhj
         cvHhoETn5tqBIqLnCDFXFnjfTdwaFu1ypl8QQPaCSkHNfkNqXOdi6UaUmQXh/QXFX98d
         VLpaGU1EB6QDRcoISecVyJ2F1vmhxv9XPyrAgxDYs1dK2TcsSD78GPBamAplc1W+y/t1
         N90k9BQPnaEWjNbLW6TfU0RKwiUAJTyjlXt3nhzDTyCjZTc0WhB9zgamd3rlNTWJJ/S5
         0MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7jIseMqCPPj3u7DXuTWdGC+Sbz7UI6uCT01nprpTw4=;
        b=mvHIKy3JquGqrLl2jSyoAqOJBMXe/+XmVqQ5y25WWjKzTWlIwUC92ueQrnrgruoUR2
         Sj6Z0yMcC6GwUHnTgtu/4sxkwM4QTf+AaqSLEsP6DC+QwJy+1umXmldkO5eCOEOX/lC1
         BkvwrnLgXSec+Da+qjQs6rtHPvZ7Q3M+dDZfI5yX7v86wvtPX0POhg7+g8pQbX9uQPOw
         YZyJuHpH4Zf5jYERmy9h9bujaLNYYeZbm5ViZATvs553N5Cfi72Gpw9Z8PB01ct5h8rg
         PzZ5h5ve0Jg22TNkzk4b++3l0OVsAu8tH8+LVdSAa60/B9AmMsrJmUqkY52QnJ1T1lwk
         wbbA==
X-Gm-Message-State: AHQUAuZOhQm/+IeX+8sEUmexaag8BzJ3QO4dy1v8Eoqmub1cAEGlwGvW
        nZlN1NczorKUJRifgCzOt2mz8Q==
X-Google-Smtp-Source: AHgI3IYY8Br/kMLMaxmWnq8xBt3yxOGqyIxR+RWE5+KFk6TFZy2g+wixqUbOo+GK/iqAN/Z/D2gw/w==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr528711wrp.138.1549014485976;
        Fri, 01 Feb 2019 01:48:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:05 -0800 (PST)
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
Subject: [PATCH v3 03/11] dt-bindings: gpio: add DT bindings for max77650
Date:   Fri,  1 Feb 2019 10:47:28 +0100
Message-Id: <20190201094736.32057-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201094736.32057-1-brgl@bgdev.pl>
References: <20190201094736.32057-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the GPIO module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/gpio/gpio-max77650.txt           | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-max77650.txt b/Documentation/devicetree/bindings/gpio/gpio-max77650.txt
new file mode 100644
index 000000000000..b5dbbe934deb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-max77650.txt
@@ -0,0 +1,34 @@
+GPIO driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The GPIO controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has a single GPIO pin.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-gpio"
+- gpio-controller : 	Marks the device node as a gpio controller.
+- #gpio-cells : 	Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	gpio {
+		compatible = "maxim,max77650-gpio";
+		gpio-line-names = "max77650-charger";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
-- 
2.20.1

