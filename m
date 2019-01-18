Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF5F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XkOLNzXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfARNnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50444 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfARNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so4571642wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOyfIqvP8fWVIkX996tvkSS9AcitJcU7J4dbz2exdQ4=;
        b=XkOLNzXHaoqwYINhSTjKGsqTlpKE3rtZ+YUpqHqHFfzP0e3kmfQnivJLKZzVKM6ilU
         3LKeKaSml5Za1AJv+H6OpYsdxVz9Xfq1cn636wzX0XP5xKhEEggN0LivlQaEJ8pEDHsy
         /+A24CvqKrrJunvXrRn7XAcbsUB2Z7sJuifPKi58pzp0XiJqGj2hWe0aBmY9nldeVLlY
         FdkIwYLZkhAUZvyM8c0r5bTuO9Ltb15UllQejeif9ty9bVuu42TppC6rcmfo5bT8cQSO
         gaqK2Bf8Ri7GxxTCEdpu9Xclsw51MKGu+w2Xmpammc7csoUHeNvH8Bvc6cmGSEBYGA0Y
         C5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOyfIqvP8fWVIkX996tvkSS9AcitJcU7J4dbz2exdQ4=;
        b=O+OICOHAmQ4OglF5OuJOjSQZ3F+NwWSuOJyVka/gfhVen5V84+Y/HNmmZs/FbHshLk
         c6TCVg/VkPQVn55bpiIQRPHKOFBkMbUTHgUhfh9JBo6pABm3ydnQf6dbpmYTE291n7Oe
         3z5mZwb5Dfzwpbl4KA4obp54nz0zMoo8Os+VJcbCE0kIo4RyDNOwfn4b4g5CbzoW7fUT
         kuREc1nKOyeJlJJ3LN1iumEdbV3M5b3s2VQceJtarElZxYZFVJ48RdoGzvm+MoAT9Z5R
         EXgg1lb/n9h4DaZRXc2E3fTKZYmabcJDuhbqQLHisc7vBjdNYHBjq0uLwu6dgzMNhIil
         GYCA==
X-Gm-Message-State: AJcUukcKcI9kTv43jWUHH8BVzY5rEhjOeAT+NotoR4zzGpgqW7TPh1/z
        1JbsRGGTBFtjcZAanE+dnq6YDA==
X-Google-Smtp-Source: ALg8bN5QbJYhaGeEKDXSYdtRbdg9vOXCE6CCpJkPHy+taNd+kZ5XjX1RHG735upNj8ibiLwSZtrlow==
X-Received: by 2002:a1c:26c1:: with SMTP id m184mr15108259wmm.25.1547818991881;
        Fri, 18 Jan 2019 05:43:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:11 -0800 (PST)
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
Subject: [PATCH 06/13] dt-bindings: input: add DT bindings for max77650
Date:   Fri, 18 Jan 2019 14:42:37 +0100
Message-Id: <20190118134244.22253-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190118134244.22253-1-brgl@bgdev.pl>
References: <20190118134244.22253-1-brgl@bgdev.pl>
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
2.19.1

