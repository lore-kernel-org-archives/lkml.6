Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321EC218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aX349u0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfBAJsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:48:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbfBAJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so5408253wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=aX349u0uwisMMyB+gBJA3B+CmkX+J8W548y5le5Gi9fCLFQI5JeU3Ro9nYQQjq2/9W
         8dedgvTL6l2QXdOSCJl0iHLlLv9t03vmWSGdMRhvnRIcv7HkiU/cCEfQ35cqHkzcFW3Y
         7SGK+DR0241Bx0j3JdE9/p6Yzw3A2wLBs3EVUscqh7BiW3vRrN8nwLg8vYSRst8j+Ppd
         c5DYZoYlpesjyVVYwaxbZooF3PfC6wUpFnyB7auw85pjOVPJRqGMq5evGNvixEuBGop0
         WP0Au4eCPghh7F8Tsj0v7GMd+1E0HgDmwwP8qjyrHOMvtHrhP2HV6wKxOhfM+QjPxG3v
         JWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=C4NS1stVlJlReV8zBSnyl0rh3XnGUfb7DMe6s7OyIZJqAU1gHxhQ0RHaZcCBWKvtzC
         AAY9QGV5O12+R1G6RraELKTj8OgJqfqkZXaDuSdTRxlKS0cbAaz50qsXeR3dyeMQDtqH
         oyI4005wsgPUm7Nu4RBHjAjGNSeAHHKMr72Jd0NIKmqTrrqXeOh+0AVmzkk0rAhXT7Y0
         amW1M3VLGsMac6ipJNQa5rLbS+I+/IYQFxs0oUI5Z/zvJRfzjn+ZEd5YgZK4AwRGy7lC
         a1ObXjtjnv+A1M+V2i8Ovpn7PGI5zlae6TdZ3aItHbjS5cAdW0YyFc6x9a095qfIhQd4
         /XgQ==
X-Gm-Message-State: AHQUAubus/qm1oYH/9n8X6xOh3+FuF8Kw211bYvPf/WLFJ7K8ymspesF
        lq0izwNvnu0sd/xhmd6K1o1e3Q==
X-Google-Smtp-Source: AHgI3Ib2nSB+GHS5VJtyC3St0D7cgcsTpgT/T0QXVAN6G944PZ91yHETIlaPJfU4qNeyqJgFXZ8h3g==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr1565300wmm.52.1549014488653;
        Fri, 01 Feb 2019 01:48:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:08 -0800 (PST)
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
Subject: [PATCH v3 05/11] dt-bindings: input: add DT bindings for max77650
Date:   Fri,  1 Feb 2019 10:47:30 +0100
Message-Id: <20190201094736.32057-6-brgl@bgdev.pl>
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

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..37c80898be4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -0,0 +1,26 @@
+Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The onkey controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-onkey".
+
+Optional properties:
+- linux,code:		The key-code to be reported when the key is pressed.
+			Defaults to KEY_POWER.
+- maxim,onkey-mode:	Must be "push" or "slide" depending on the type of
+			button used by the system. Defaults to "push".
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-mode = "slide";
+	};
-- 
2.20.1

