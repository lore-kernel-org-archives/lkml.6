Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F22229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="q6KV2U1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438994AbfBNOAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:00:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40713 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395251AbfBNOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so6190734wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TOJKenVjAulalDtU9bnkhV2ILna2e7vaU64Q45T5iM=;
        b=q6KV2U1BbemW9B0DqYerypDhQ9923KH06n+93nQBAkobPuRsiy/qWTCmJVTjyrBfCT
         2OyUDjV7DhfTbrHbH2O2lPJ9aiwAGH9EhjIxPQaGfrs9VhFS6YP0mtBFQxFmyU+H3y7P
         cph34E9nXrRWRPeksPhLwkM3+sh2HiSBRsAddOSYZlfWeYGSLqcp0bPpyEazIZT5l5mx
         rwS4qLHpQ+19VpNWOxKFNd/yU8K0LVfn3w4FrPuWmRqKqo6hCE4RdXL5VRZQuzVwV1+u
         ozgq43P0guhpKNbFLh0dyRnFlOQcQkxPdlLv+C5dlcBDEtIcg+HrRV4UKRecTN2cUXSN
         ws4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TOJKenVjAulalDtU9bnkhV2ILna2e7vaU64Q45T5iM=;
        b=T7P2t9OjRavzIy1yGabXShA9QcCWoivSvjVvV0RXmA9Vp8PLif+FYd0vpSjBut+uDH
         /hbIdoNDjJDJNaG3dKmLH881BswBZP6wq37HkKXywDx18F/O843YF90ENSdN86NoimRO
         rPkk6tTqDjdtcRFv4/QqaFbG2Bw95ahmlxJm9LmXdJHlT8rjlqCNW+h916ESAKlHXkti
         h5OOtUjqpQtjyM8DdXuxEU0tzOVTY9nTR0tYNgzIJI6dhzJ11sWj+Qwy6MKCoVsYvt+H
         zLzaPMM8R8+bnYppSwkAihCqO8FVSOirH0i389Mag4dY8Xu1sV7ghEgMP41FCmMZxS9h
         QA/A==
X-Gm-Message-State: AHQUAuYrpugCQMLafA0xorYfQu7g28rXuCBBGEkXt+bDRCGjwkq6JjYX
        nBnQB0jJCf0BGKiKvVYknPlBFg==
X-Google-Smtp-Source: AHgI3Iaw7TGYEP82QDU3K6oXsH9ax7eB0O+cvqBoHLQGJMIctc+/vm3gQug+4oI/mWiiEtfriTABpg==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr3038210wmg.143.1550152842627;
        Thu, 14 Feb 2019 06:00:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:41 -0800 (PST)
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
Subject: [PATCH v6 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Thu, 14 Feb 2019 15:00:15 +0100
Message-Id: <20190214140022.19201-5-brgl@bgdev.pl>
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

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..477dc74f452a
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
+- maxim,onkey-slide:	The system's button is a slide switch, not the default
+			push button.
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-slide;
+	};
-- 
2.20.1

