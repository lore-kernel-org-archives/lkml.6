Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5129EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F00A20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMCeWlRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfAMPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:30:38 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:37928 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfAMPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:30:37 -0500
Received: by mail-pg1-f178.google.com with SMTP id g189so8393213pgc.5;
        Sun, 13 Jan 2019 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wWJQP3qlm0dkufRBC92pArEv03qZqPjGRD3HuPdEs4=;
        b=oMCeWlRQ2QQqDoLvuxXcKMQqQxJ3rnJyehBfMkQnCGpd75xUohqetHPmz7/hOvPjvv
         Bo7wMBLAvepX1ovx6F1Xf/iaRHKFWP7vcCT+pYtux3u4X+kwJzRybT7UeKCXSpM9b+R0
         Th2TtbFEFnZfDuVDw1YZ9mQFoUPjIZfhN7VQ7ULzlY2U20C670jKRlDCxzcGstdoFnEa
         +l2msuHLFuBXsnWUMyB4HJrgSOltWMH7TFE1t+LY3z1qDa3a7UAEHBDc2YCxOXyoO5yA
         Zw+3qFAvyDsfXZItEmCRDWTlHNyg90P052Aio2IonMceuP79RDFmsD+E1QdobbScvpES
         6Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wWJQP3qlm0dkufRBC92pArEv03qZqPjGRD3HuPdEs4=;
        b=aq7KaoW0bl8quOOr+mdoPjILW7NtsYFVmMF4vaCpzC6nV3EBdvh7MnLMKiCGTceqtx
         QSW13G9oeFJOGf0RYiE3EIksA5cZFTl5mJmIZUqtcCUBKubmWbdQOSgtNBsp3zZkzMNs
         isnNxcVRFXBv9tJqeAqzwiOTM69L61u7kug1ioktSjR97f56CA18DACbUfMbWSreMLbF
         DQ5BDkL8IqvsyabnYL4TkSSWcAgOew/tkjv+K2tVsX/XeEz2dh7xzMQScL1YN6jwtn/C
         DHtvFQfBxhDEhRzKWDsz7uMVgQ52b9otP/0FkRHjkE5iIXlvk5jTsSV0l8pdEz3lhMvb
         c7sQ==
X-Gm-Message-State: AJcUukfyBE5A7YuP/5tfvic9+6387mOBcTGprpQXKsSfeavvdExgYms6
        5XvP/THvE4WGcfXj0SUxbqEPAXIS
X-Google-Smtp-Source: ALg8bN6EAWVUOAov0iU9P6gxA9IZF0kFm2UfrixriBbFO3+1uZIiRssPAD7nEeGcG9U3UZuYMfA8Dg==
X-Received: by 2002:a62:4e16:: with SMTP id c22mr21686745pfb.167.1547393435804;
        Sun, 13 Jan 2019 07:30:35 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
        by smtp.gmail.com with ESMTPSA id r187sm265107745pfc.63.2019.01.13.07.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 07:30:35 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PatchV2 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
Date:   Sun, 13 Jan 2019 15:30:22 +0000
Message-Id: <20190113153022.5040-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113153022.5040-1-linux.amoon@gmail.com>
References: <20190113153022.5040-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing vin-supply node 5.0V regulator setting to power
to usb ports, changes help fix the usb reset warning.

[  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2

Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
Tested-by: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch
Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
- Split the patch into two part: new patch
- Fix the commit message
- Added Tested by Kevin Hilman
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 25a36d117183..a947b46bfaa8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -28,6 +28,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	usb_otg_pwr: regulator-usb-pwrs {
 		compatible = "regulator-fixed";
 
@@ -36,6 +43,8 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		vin-supply = <&p5v0>;
+
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
-- 
2.20.1

