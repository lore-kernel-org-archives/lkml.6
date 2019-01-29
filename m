Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CE4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0872214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eEWjmwyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfA2NgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41128 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfA2Nf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so22059565wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7jIseMqCPPj3u7DXuTWdGC+Sbz7UI6uCT01nprpTw4=;
        b=eEWjmwyQxtvyeH7evby+YC/d1Qahl1I6dZz/7AZo+M2cRxvwLrGNHQvXpgXVwOzu+X
         ILPhOigvoB8M1xG6aqJoogzT1AGSAPBdeU01Nvf5mmLfn9ywiCcMl+5aKtWftD3a/fEj
         fz+JFuOjCwevbn3j5kVVcrLSX9l5SXERxDgd2pGryOBWvr0sqAyz2o0kmiF+5Q9YZOBc
         TMq7BfPdG4jUbWrR7dpbg3PerKo8QFY78UK0KLRZa4+7o62buwKIrofDzdj4UWng0s5P
         g5G6ReEMDfBVohRerWuXOBxzMc3zRQb3oXLur1kbP5fncajxjAYdmHn2YJbIPLaixfGv
         eeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7jIseMqCPPj3u7DXuTWdGC+Sbz7UI6uCT01nprpTw4=;
        b=d+1vu/HQFfuk1yLfAmRrd+1smkAmjF6E0Y66k/53I+S2DbmgCIWD3ohtLZGkeXs8d3
         QIkL3HlrAtvRxYlXPSeH7BDY23wJdPt2yfbz1Fbnz+hQHIap8TbccfSSZb9eHsTjOTFm
         /LJ3u0c/RQsrAaVHXRSGMZn7piEek4skNcDJnVOomx7ITjKo2rLlyMqgiXLTzGHsWZ4a
         CdX09rON0HLBIm7BvnwWDTI/E1iqXLimjED8Xr+gvm0ixyhaF66u7BNa5FjQK8Rw91VN
         yy7DmPD5tIU0KZLFBnjOng5mxd/SYK1IV/pMHUnJsQZLq8CEtN4HTPQQFXcWfzNfSSX5
         ssZw==
X-Gm-Message-State: AJcUukdc0MVHUQhSDapu6UHxeqwBCdpKMF141tmxuOBf1T1BZK43+vlN
        4vCemhEmPRlTKT6fAcPYtcEeog==
X-Google-Smtp-Source: ALg8bN7i18tvj7lvPU0ShfxlnWpbBYXXojbtTiDR/vBkuLnotQrR62zVvbEFRQLDgb4jKxUKyOrJRA==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr24691786wrj.91.1548768957934;
        Tue, 29 Jan 2019 05:35:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:57 -0800 (PST)
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
Subject: [PATCH v2 04/13] dt-bindings: gpio: add DT bindings for max77650
Date:   Tue, 29 Jan 2019 14:35:36 +0100
Message-Id: <20190129133545.1931-6-brgl@bgdev.pl>
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

