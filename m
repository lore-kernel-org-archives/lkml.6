Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553FA222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="J5iGyv0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439012AbfBNOAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:00:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391964AbfBNOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so6193488wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=J5iGyv0rqkwIpFFbJRbK+qzrq75T9AtKK3Dmo0azpNmAlG+5q66D4A4vyM2vQmTDg0
         P3/SXxl0/Eh8OqMhgIM6zchBqSGLxP/l9isxNUQzrvWwTaTlK7ty+Evm3ADbi2dWzuRd
         7P9uHifEXSoXa1eDO8+ymUjSpXpEIWu9mxNZxBctNybfsU/+NB6sBbovJ3m3yqdxkhrg
         5xSYO+G6qooB6lOTI/gd0DPYdI+bwahV/Akg4p/EPXOPEQl2ySetAthpSLZUP7BbSQvb
         lJwR09U85Pix9tRhEbuKRnntBn6AlPfsR7JNoheDzz2y2Edgj04/xsEWTuSVjh4t/MaN
         xvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=ZAEgJaWBZoR2G+3uacZZzDyc/uCSEmVBpvDBHcvABKW91/jwvCBxFlNYa4JozzFjRV
         wxgLQiTrZujwoGxPp6+qw7F/v/G+pFTUEQBnxBgA0YSpBHnBn5aTpbkAO4W5l+9CR6kl
         g349pnaVfQAPJW+y9jAkieG3j+IKJDzNvZVz5MmT1m8O8G1e4Tov6yfomIpSi9ERYTmR
         fQEo9wDdMwoagvHLR6QQ58YrfFrw0REPHnKtyEZZL0S2pVQFKg36HxRCEjyyeQXNjgQp
         wGMC+1D5EX5zax4H4z4Q6Edww8V3tq9sb7aAvquJbKpTOc6N481C3rZUx1maevirSz6Q
         RWBA==
X-Gm-Message-State: AHQUAuYZYVM+s1BZslFJtZhVKokG/CZyMSRwOS+Wp1Lrn4Dd169E9nLj
        m4amU0PMaxCyde4zVSqVJHu9Nw==
X-Google-Smtp-Source: AHgI3IaaYZnNXy+LsFbmSaEWk0gbylen2SNKkZg86HhWw/nzlej2ZlYjOK8igcQ4RDfEYFFcy9saEA==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr2798916wmg.124.1550152841208;
        Thu, 14 Feb 2019 06:00:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:40 -0800 (PST)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Thu, 14 Feb 2019 15:00:14 +0100
Message-Id: <20190214140022.19201-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214140022.19201-1-brgl@bgdev.pl>
References: <20190214140022.19201-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
new file mode 100644
index 000000000000..3a67115cc1da
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -0,0 +1,57 @@
+LED driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The LED controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has three current sinks.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-led"
+- #address-cells:	Must be <1>.
+- #size-cells:		Must be <0>.
+
+Each LED is represented as a sub-node of the LED-controller node. Up to
+three sub-nodes can be defined.
+
+Required properties of the sub-node:
+------------------------------------
+
+- reg:			Must be <0>, <1> or <2>.
+
+Optional properties of the sub-node:
+------------------------------------
+
+- label:		See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	leds {
+		compatible = "maxim,max77650-led";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			label = "blue:usr0";
+		};
+
+		led@1 {
+			reg = <1>;
+			label = "red:usr1";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			reg = <2>;
+			label = "green:usr2";
+		};
+	};
-- 
2.20.1

