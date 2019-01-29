Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFE92147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l3RpApoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfA2NgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54724 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfA2Nf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so17880371wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88EGuRhmZ5Mi0OmBRzcZ/azoI1Z+qLZaZYAJ4dxXFVk=;
        b=l3RpApoT4APiZ7Cw5LpJ/itCPkfvh70uCXirMHVDI5BLUAdZNBpyUqScq7lReJLVFR
         3A3XJbr22mg+/1IchSCpQi7QIX4NFQ55RQnGTvk9xAXbeREq9/V72vS09QNmwXyL+3YN
         /KtDgMaiO+/vFVTbvCNPW7jUv4jND3BYCQHMebwquDxtoV5midRcdLulhQl8sArRiyZF
         a+MCpsm5UWt2NGD8NY8CbT+jZpmHGW1Kfs3xocl06V3aXhw+EhzKCzAMArsoz/1hN/0N
         Upqez+DL0gg1kvoN0sm84WvfOKgvXmuSFSClLzYBOTbrcsrQWzV58cjMG8QWBIZpEcqZ
         ES/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88EGuRhmZ5Mi0OmBRzcZ/azoI1Z+qLZaZYAJ4dxXFVk=;
        b=NkgY+RBtaY1+4kZU2ttUwYW66fb7o4nwoCUTrHw6WgW2XDzSYceOAl8waYM6TSvlhH
         0VqzxZ19YcGzNGmq8X1xAHDFzTWSQbcwZ+ejsjo7fkSTHowCTsY8uGBjph76hyUcytFb
         o321LljgKSgRXEP6J+jsFfaEaWSebRX6FWv1k2Ne8gLb4cNojtvlHTECXM/wI1FhmVwL
         LLZFpDLxy8GDTUNXC7NH/6PPV1/l0R2d9CG7EPDDj/73T+3uxN+iCUJba7oa9ep4gjMI
         HGs1Y0azFzMcIztAzRCyGU/qvGv+0I/XIxFRJgltOpBIgZZ6jDzZ04FCt5fYPqAfM29Q
         N0lg==
X-Gm-Message-State: AJcUukfp9Ke+4f5tsJJ/ZnRH0YriRxAT/33SwLIr+9MIINipaPLS4B1w
        0rTNbmcwgZMY+z+uMxfN46boCA==
X-Google-Smtp-Source: ALg8bN6EhWzbvygw8pteP0XUbWsmKCXcyIG0Jw4vPolZwKEv7IBaqMwg316ipbf/EhwLWojaRF2F8g==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr19776466wmc.133.1548768956501;
        Tue, 29 Jan 2019 05:35:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:55 -0800 (PST)
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
Subject: [PATCH v2 03/13] dt-bindings: power: supply: add DT bindings for max77650
Date:   Tue, 29 Jan 2019 14:35:35 +0100
Message-Id: <20190129133545.1931-5-brgl@bgdev.pl>
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

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..f3e00d41e299
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,27 @@
+Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The charger is represented as a sub-node of the PMIC node on the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-charger"
+
+Optional properties:
+--------------------
+- maxim,vchgin-min:	Minimum CHGIN regulation voltage (in microvolts). Must be
+			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
+			4500000, 4600000, 4700000.
+- maxim,ichgin-lim:	CHGIN input current limit (in microamps). Must be one of:
+			95000, 190000, 285000, 380000, 475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		maxim,vchgin-min = <4200000>;
+		maxim,ichgin-lim = <285000>;
+	};
-- 
2.20.1

