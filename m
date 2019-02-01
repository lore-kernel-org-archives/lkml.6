Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B032C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2120870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uCftNi1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfBAJsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:48:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43473 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbfBAJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so6304823wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFkhmaEQUzdaTJR4lhnbhp1irRv/17xUnhxf+z/b5Fo=;
        b=uCftNi1UhBh5tcgKk747QyyUOOEEMvevxU/E6uOII5cK8fo7rDHS6GsFr4jd38vV4u
         Tsh6IufVgt/rWmzp53C/cxBXAOayjJ8YZymfUjLj4UiNEasOG33iyr9vAPVCNmcWEWYB
         w/5cou/E+nLlXyqQ4orUyDrrbeXTVCsMOP3EDbxNZlxXpPGT75GtOQ8nztp9voUODZn8
         NhewqWvSTPiUT1FHESK/wGbvEJHjHT/MqtEFMy5Oe/Hos1Nasf3U8pCKOUyTSchCRdDx
         7GbgxVSYbHjAEcuY//B3jYi1UkcSUGWSrgCw+KLQ+jBEye0gbEfmhYeUbT0m/QcaWkDD
         E+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFkhmaEQUzdaTJR4lhnbhp1irRv/17xUnhxf+z/b5Fo=;
        b=rORtNyloAvqy3nBGpQ1QEQe+FypvX8YPglqZlShqSAILj2qusQXaly6RSC5oxIRAQk
         Ehsejr+FCwAwra5qXxdsfKWzxm3U7uL3FKu5RO3hIRX6O7hGJihOi+/Cvv6lwHINAIlQ
         x26HIbwp9cER+a40QM2uwdbp+tK70jOk45ipmnZisJvKjXn0JeCMxmzbokD0uWlq4Sg9
         +aMsaFssewT0BqWIID5KV2L7qtv9mHr7/und6WB+vhoESTnR3EWDj1xjO0h45n5PeYZt
         Gy+O7zCY52jk98WQ6jhAy9gRf4AokUSZYL3YKg8NgpJeCDO7Uw/K764Jt1YRIxT96TU5
         xK2Q==
X-Gm-Message-State: AJcUuke7e3j5O24FWhPcJQfNTia+xFJdcp3fXMcLjnxA6y2L8LwjG2Zk
        lrpfFYwe5lbWw6zTebihEb5aRnwpcay/Tg==
X-Google-Smtp-Source: ALg8bN5bz0seoSx3UKNkjBiTjMS9FT9x9CQKgo7HCB+HnSf+Xjr2EScLqhIKna4nvFZsYkmRvml+yw==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr36192477wri.210.1549014487320;
        Fri, 01 Feb 2019 01:48:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:06 -0800 (PST)
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
Subject: [PATCH v3 04/11] dt-bindings: leds: add DT bindings for max77650
Date:   Fri,  1 Feb 2019 10:47:29 +0100
Message-Id: <20190201094736.32057-5-brgl@bgdev.pl>
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

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

