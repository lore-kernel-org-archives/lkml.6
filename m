Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4FC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022FF21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SQ1IiYVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfA2Nhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:37:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51331 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfA2Nfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so17895629wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcpQpQ3AxfWeWSRUFYkA1wobTem0k2VnDhGHRGUQrIk=;
        b=SQ1IiYVJWuIkLZuGQv7SbK8qlc08f0coxDCyfNfkE08nbCn/LCtEpds6XqdoeGd3O9
         +ka+rAdHEBZ2GAq+V6mLFKJqPurCWZPTwR958WkE2tN6kUj5GEmpF1RHXkRK4lqzXcz/
         icQGuZOxWh8drNWUx7PPLLLGUn1n+QcDE3pLZZUQusnz/nf+l0fbBWt7udiDDmviSp3F
         LkU6gNxzh9bq5fGbpupPPJhZz3mq6N0lhXOGy7vYl65S5pnUec2UFu06Rk0Pl51TYs/T
         kTmYers0K69o9WVgVxIxevtubeyHKyVqmlM5amlmcqFpu+S2MufmNj5JM7F9sp3bCcpY
         lbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcpQpQ3AxfWeWSRUFYkA1wobTem0k2VnDhGHRGUQrIk=;
        b=h8CBZppZe5CtjwS4BA+ePfBmfKtGdTg19kurf1pqdtzQUjVewr5t6OJMci+6O0VBtm
         YIMdatDZUBQFN+hsgI398uKV19jqbnO8mhZlAdXyaUB/MoyC0XoKAIWno/BSc1ReNJkv
         EyUAvyves0zr3MaaBVmXa0k9Juuy7xR+8HmCL2fcyslTUsgHq7FLIR4yfNqrRW4OIKz3
         pjJC9u/dpfSaw/3zVE9SqS5EKJbsDSH2aJIvDTNgdwG9y3rx+8d2pYXHVdMgFF2HdLbQ
         T0ghkKrfcwFdCF5QtTmzZIECnC4STzIbzf+HrKyY2ZgagoNXmxkG2+pFO9IgtunB09eS
         w1bA==
X-Gm-Message-State: AJcUukf5dYypzUSLCWwoYbmFwwRnILlJn1O8xPu01TPXYdLX/Ef02cQF
        YRsVLk93GJEns5kxTy1ToQY4Rw==
X-Google-Smtp-Source: ALg8bN4/Qu+Il48oLBzEAEv2F9m1th254moFL+ccfoo5/KekHqUvkT/QlVVpXikz5tRIHLWMIole3g==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr20815926wmb.153.1548768952405;
        Tue, 29 Jan 2019 05:35:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/13] dt-bindings: mfd: add DT bindings for max77650
Date:   Tue, 29 Jan 2019 14:35:32 +0100
Message-Id: <20190129133545.1931-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/mfd/max77650.txt      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
new file mode 100644
index 000000000000..84631d3b1e14
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -0,0 +1,28 @@
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
+For device-tree bindings of sub-modules (regulator, power supply, GPIO, LEDs
+and onkey) refer to the binding documents under the respective sub-system
+directories.
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
+	};
-- 
2.20.1

