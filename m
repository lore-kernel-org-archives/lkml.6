Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896CD218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I6pZ+2QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfBMNn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:43:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35041 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391105AbfBMNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:43:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2485140wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFkhmaEQUzdaTJR4lhnbhp1irRv/17xUnhxf+z/b5Fo=;
        b=I6pZ+2QWiVZhe6Vq0DlOX36dXxsIJEZi1fDtFjCoLBCitY6KirrSPj3Rk0FD6/pccD
         W6GtM3EUT+stkElLmyGPoYIYw4foLU2PcHWzK3mlPu2zLUXC3X8sRrUSK0uQM+nbk7Nl
         kphpZ6N9nVaEcjGGAElN8+NB9d2MfGFYdH0d1Ko9fZtVxfSGGPoAL01nH/PnyqFa/Pud
         Om5BasoYt2C3fDtD9Wjn95K+jE9PP/GllewvomJ1xGUQZjeBX6P/EvSJxDy89paPghBC
         djICRUQ82lzuK3LgFEgMO6FkCBZW1j9G2GOGTOX2KO7NFkAE41yZMohKnCflLJPC08TI
         XbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFkhmaEQUzdaTJR4lhnbhp1irRv/17xUnhxf+z/b5Fo=;
        b=aE3rfetxUrP+iva7RG4v3+AvBMn26918TG6srLALxNcTRXfJJEftdCKSRT7xH0TBme
         qocsrsbIGUH+QHV/qtnNDtfe2RFavMlPAg0yWJES3a9guOnBFM/W/OjT5yzmR1797DMY
         xKxFFi0wzP0ftwrhzQbfxqDr6yhsn/8WgI/OCKpWnRSMlMGW3ecWN7K4RQOM7cOj/8Yg
         jDPWh+WfeepsCCM3racFG0b0USRXTzwW5URGuCz5OAEcFQWtYKCh0PPgzHd5iyR6+hVL
         8jYBB9hC8d0caKMIkgUh/14H/9uVuJ/ID7n+GfphzEdGywhZ8xMcAdC84W6AE01Bcy2f
         vVkA==
X-Gm-Message-State: AHQUAubSyf8KfoUdJNHQOpHjpLQ+u1xjx7r0iSO9vHA5BEpG9mQn51YR
        qDXei004aqj1u9F32ZV/WIedvA==
X-Google-Smtp-Source: AHgI3IbVkMrORRPGtLmlvAanfH+80GJlKtqlRHfllYN4gK9ZEXPKIp/X8JGmz7owhuruyR0TgkVRnQ==
X-Received: by 2002:a1c:6589:: with SMTP id z131mr376609wmb.120.1550065433188;
        Wed, 13 Feb 2019 05:43:53 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:43:52 -0800 (PST)
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
Subject: [PATCH v5 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Wed, 13 Feb 2019 14:43:27 +0100
Message-Id: <20190213134335.10838-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134335.10838-1-brgl@bgdev.pl>
References: <20190213134335.10838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
new file mode 100644
index 000000000000..3a67115cc1da
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -0,0 +1,57 @@
+LED driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The LED controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has three current sinks.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-led"
+- #address-cells:	Must be <1>.
+- #size-cells:		Must be <0>.
+
+Each LED is represented as a sub-node of the LED-controller node. Up to
+three sub-nodes can be defined.
+
+Required properties of the sub-node:
+------------------------------------
+
+- reg:			Must be <0>, <1> or <2>.
+
+Optional properties of the sub-node:
+------------------------------------
+
+- label:		See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	leds {
+		compatible = "maxim,max77650-led";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			label = "blue:usr0";
+		};
+
+		led@1 {
+			reg = <1>;
+			label = "red:usr1";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			reg = <2>;
+			label = "green:usr2";
+		};
+	};
-- 
2.20.1

