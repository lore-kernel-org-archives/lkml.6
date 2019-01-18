Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E8DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905812086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ATrlBtI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfARNot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:44:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46202 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfARNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so15044784wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8G/x4xDqyiyiiW8CGc7IfA1RztIv2wZUUR9EI3hBaeM=;
        b=ATrlBtI9bodRec6OVYjWkV1535+WWPEMdtdjM0/neMsCDGG3DoeodNzxNnWOYr4nlZ
         v6ChZG4t1NmXrEw2tFgaD3sjTtPLnoQ0C2eNVjOVYD0fmLuBtUyVClE0p+x4mnCq/ypT
         QgkDmfkb7dUPWiiL69PbdUCODxitpzybhVH1U86bJBXkWYGSNLkcVoyf6B3YPphZsXQD
         NyDXvTqEOxqpbS9CLwvV9A05IHjowowNJquDDpedKz8/G3SosWeRbEre4Iu7oHn9ErI3
         e2+kBLpjB2d0+7/MTESx2wsOaN6eVBaQlwBPOfehtMyJV8zMSgt4gXbJrG9XcQ3G9shv
         vu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8G/x4xDqyiyiiW8CGc7IfA1RztIv2wZUUR9EI3hBaeM=;
        b=RKMEHzagx/4FSWbCaKjBWJoSaZ68VbwCV+PGbVp9l9bdI+jhTrkTBax195B5ZH6TfC
         0u8vWEQUUeRY0QxakwsTGeaCGWh86cTrZ/j20jMd8STVLRI8w06yC1t6ZZq9gdfjX+Ij
         RBAKdUS3Wc4ZxCEobjxWXTm/cvLLF8geADqv2AujYdVMRfU+szoeQk/SWbrzCekKO/sl
         6MX3XwraKfFUpbo680nzdiCFLnRtgiwpXI8W7+7YHE94RrSx8qb3MiOjZ/N6Rihkrcn9
         gMpq7JHXrH5GdwiyNttC4y2Jrp47BPock6V96G4AMFvWhZz7RK8nXr09dnNXurVHycBW
         LCsw==
X-Gm-Message-State: AJcUukcHa5ho40VsPQ2JNNCYGCW/L9jrKq9GJCOeA5ids1waDZzucaZQ
        WXSqkQKWsWqZftQ1+KaFlcu41Q==
X-Google-Smtp-Source: ALg8bN5ZjFyQBMqR6yEThU3ueox6Vzlo5b+PwkbmkwoGBHh9QMmifvzfQ5SzMh2cTCifDd8GYQimgA==
X-Received: by 2002:a5d:47d1:: with SMTP id l17mr16313740wrs.319.1547818984972;
        Fri, 18 Jan 2019 05:43:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:04 -0800 (PST)
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
Subject: [PATCH 01/13] dt-bindings: mfd: add DT bindings for max77650
Date:   Fri, 18 Jan 2019 14:42:32 +0100
Message-Id: <20190118134244.22253-2-brgl@bgdev.pl>
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
2.19.1

