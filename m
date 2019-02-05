Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE1AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E25F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rr7vZ4+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfBEJMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:12:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfBEJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:12:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so2710950wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHjGX90PhzkO2zCPEWu+WmU7YdHgBvwkN4duLM8BeyU=;
        b=rr7vZ4+bniMJKiQfElqNx2kcXe4M/BxKzM/RvPFH1hryN24210sIoREv9HqDmL5wSu
         mNJYct7qMnMOdHkbxBroUNoRnWms//iJwOUcnp8ZmkPxsUjpS/+QXG+N3W95pjYSot7M
         t42afY7HVG0ZBxzRIexnRYkac1xi9cO0CMEHVUdxkime/KTh5586q796A2XmXolLls6N
         j0PAqi6clE1cycOQAgHM7+zDew2WsCqBSrwPe6zy3ULwnjXf2XOoPb5J7qYJBnIoKOaL
         2ZiDgWEK63VIdDEgWH7ks8jRm6JuNp9YdzmXdwl+xB8gP7DBDUxUNIopuEXOp4XY5tRh
         1NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHjGX90PhzkO2zCPEWu+WmU7YdHgBvwkN4duLM8BeyU=;
        b=QVcJkQvFMtAQBUxHdDO+EtAJk0WHFpiNlCeARrg3P038+zvyrFi/nDuf9npc1qVrHH
         cIjytdEPYEDEspPEVxp8holHxXPEGHw4cXDJ8UQST2Hu9QXgwGQf2esmYHazCoHocK0p
         YvIsvMyum3UBorAJx9A3TJ5eR9oCvmaDP02z5PJIwdbrgUgw9d6Irl21cD94LymunhOB
         /reOqnwgNK/SPdxesC2eSLkDjuT9H/039JQYrxFCtvvBLtJoWOjkfw5FQvdOoNMstRn1
         UJMVvD4D57mGs5ETjU473QooqQwGLSi7Eb8eM+OWzXQQqWAHD6XXAJvhauxQDJMzG7Jb
         9wbw==
X-Gm-Message-State: AHQUAuZw+4hND2Bi2u6VXb1yN/NE10ZkA3uc5Y3e5bcAlIJ8XlnM9tGM
        WP5jPVtnBUZULmOVVRb5Tg33Vg==
X-Google-Smtp-Source: AHgI3IYcHlDl1IkLFPznjYc6kZ+x7wJuFWWByZfaU9tXVL6t4gNEqGuc3EnOsfxlzOPA/XXRADHiGQ==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr2638342wrv.147.1549357965000;
        Tue, 05 Feb 2019 01:12:45 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s5sm10433657wmh.37.2019.02.05.01.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:12:44 -0800 (PST)
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
Subject: [PATCH v4 01/10] dt-bindings: mfd: add DT bindings for max77650
Date:   Tue,  5 Feb 2019 10:12:28 +0100
Message-Id: <20190205091237.6448-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205091237.6448-1-brgl@bgdev.pl>
References: <20190205091237.6448-1-brgl@bgdev.pl>
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

