Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477C221841
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HYoM7iC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfA2NgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38604 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfA2NgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so22054844wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=HYoM7iC6xQfh7wKcObTnnddwVLDqcZXIXvqUU4ooHDrmEo5TL0TpPUs+AjCqzWRHgL
         HgItjWlwPfWES8ATjxSRg2d77LPh+AKWDmloL7R0KXQ3To/EvHuV032sunIark1Memkb
         4U3IM90u+NCqIIdZn3Qw9qD2FbqOtV4r49p1fs+cKdp0SXg+bqxJrHM1EDfK4TsJQ2bE
         3eI3LOqCZqq3aofhHFmLFWZgk7IhUNLyAquBs+Rewdid6Ct2Wo21TUiZCyR9cHlIE0LU
         RXgOn2eaVXNaYiH/B0pnVV1obumhnsQkBIneoA9LZXXQwJz3uhub1TQ+1lLNLqb5JW0C
         ljpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=meCnxtocOpTAcTBwkErwxzCbMVNtgbQs173Ws28YTYjhIARttR0ggGAeQH5JVth2YX
         H4Xyg483i6ElnkiKYvBg/t9qT1JBBiZzQOPaiz+uBcT47Q7OlZupmlP+xrOkQW23SYPH
         lUvCwEgmJTYry072bR+xvHaZUtk7OGY1ybxWPYAEJQToZktqVaMl1rs8uLjFvW93Zuep
         j5NU8BqDs/0KZVwo1BIOgh6XxTXPuxclWBnZvvdSS+VfBFpRx0z2Z17F4gWwx61MiDB4
         e81IUYdupP1D86nxOd+eFfdJ/FhKXTzCij6VqazVdnMYqI05s89P+UbWk+6nUs4BXz2w
         uy5A==
X-Gm-Message-State: AJcUukcoHuRzFUAnSCqS7Vye19JukAK8pPuSSZRybhafBQmrFZHih3Gr
        36lXFGWCQFnjQqKbJr+J2LOY6Q==
X-Google-Smtp-Source: ALg8bN77gugys53OLgBISREJeuKACcQwuiAMawTX24Qc3pYtWs7cP/xv5bq2SGu8/LEFd9Jpu7KDRg==
X-Received: by 2002:adf:9123:: with SMTP id j32mr27274478wrj.122.1548768960736;
        Tue, 29 Jan 2019 05:36:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:36:00 -0800 (PST)
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
Subject: [PATCH v2 06/13] dt-bindings: input: add DT bindings for max77650
Date:   Tue, 29 Jan 2019 14:35:38 +0100
Message-Id: <20190129133545.1931-8-brgl@bgdev.pl>
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

