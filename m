Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A256CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C51F20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wlsHSJK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfBEJMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:12:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54220 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBEJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:12:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so2715599wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=wlsHSJK/PnBPdoTspbamIjFNIf/gY+cEoxY5JlnF/NvyV3a1qBigELwBSZKI8Xw99A
         3B/aqh2NGsIBo5eSEopHxtr+V8K1JpLdIZQiMlTOJtSMZenwysO6YqMBjdzDGWTn7iJJ
         F1pKV5nf/9XydpLt7TDpsUkndXgxLCzWv20l2/V0rkyxIkuZTFUi0gpIassA6Ae91dU0
         UQVANXOCNYNWNFNgcimu5h2tdjmwg5X64TnRPIK6h6+RFsYGxAc/9vVYbhxB0KM7xUU3
         MSgN0cWevsq4CmGqZAxM/G8NP5kTcgBahJisbaqW0h7bCupcg99GNyqqZOjshM3ZJa9m
         HA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=P1RJM7wAR5DOEF619lI49FyIVsy2Ax/ZbmUgwPEFLjABZ5tg6aXFQqbJFSJLktQMKv
         O0j9SJ7E0tffhapFfiYySaEt6I2wYGZituze0p3Pk7EFtllPkNL6lWH63E+5eZ4C2p1M
         mmtQDu3k9Zok9GdaT/OV+sl9G5um8R7UMF/l7m6Qn/0o8ka14j3cgTl0r8Cf0q4xxfd1
         8bN1O3poYwHG0312S814A7Fah2RBSFi77oG2oidwFdK9GzvLgAwF4PjvPFIVfwCjjXMo
         T5soDHg+QYxu76c82svPEqsXYWDRnuv4BFzEZwmlp30OGnxu/bu4PYXmj+U89L9L/N84
         F8+w==
X-Gm-Message-State: AHQUAuZYLz2cPaxyp9YLPyRZHgj22u8ixyTJ38qLgp4KN5TmBCOKiYo3
        Bzm2K4m7o1dJQ85IT36wiOWR8g==
X-Google-Smtp-Source: AHgI3IbJOnmBG9bBjctzaBa5S2CZm5FHoVUtiIKci4wRzc2L3/+Cj55f6ogaMntlJtrOPXNWT8/5GA==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr2689076wmh.29.1549357969326;
        Tue, 05 Feb 2019 01:12:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s5sm10433657wmh.37.2019.02.05.01.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:12:48 -0800 (PST)
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
Subject: [PATCH v4 04/10] dt-bindings: input: add DT bindings for max77650
Date:   Tue,  5 Feb 2019 10:12:31 +0100
Message-Id: <20190205091237.6448-5-brgl@bgdev.pl>
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

