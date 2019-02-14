Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A422229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DO/9XQUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395295AbfBNOAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:00:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38330 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391981AbfBNOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so6589293wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GccRuQFRqaVkBzcusF5ev7XeftbkUHIeHQdHXzkyWfM=;
        b=DO/9XQUmfVfOY620y7LQDI7qMwLysvUZWgPJ440lJx0Ax+iNA/OaT7oyhRwOORsVjy
         srAWoKET5dIH45ZlReNH29HpMRqsfe9JTxAZ0MORLDiSz1buQJhmaGpjN9ggOf5KqwRZ
         BYOUBvZojLcpHDkAo6kPvSi0tD2GUDeOorKlgSsFEs1VWzwOD9lTjuRHdTAwuFQIGpzz
         lcxK3LPkXfNpjO4sET7WeWmoph57UaGTW98XCfgWKUF85T0nFp8fFENJmg21knBGlcQF
         NIEpDHzYjX+usmhlcQX9gSoDetfv10bJCOxH1CVN1qrrq4ypF0Cm1qvHjOA/xwfO2pjo
         UGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GccRuQFRqaVkBzcusF5ev7XeftbkUHIeHQdHXzkyWfM=;
        b=oVNf+NwgiMk50aC7qcLTpS1gp4TdAvmZMNbawUHi2XvQU78JOJvGvyl0cdPTGd3QNp
         x7oaQ27XCi3VNYVvUZoZ4rtwmD++eFPwmVM9p/6iHsIgjK6LwnwqN3mvIY9PvJf6OkVf
         2H+tIHqHlvhCfIMkDRQcOtP4Ah7uS8jmKysVVbWM6AwjZX0wGoUm5NkvkpxRF9AMb0De
         HosKQ+knmtM3OKankpYyesg03T6fzSAwOyBO/MuSCKmL4AAmYQIh1/zWARghKH1C3xmO
         msNwJQxDakDaIH07/qXhYJuRUIh3dETrzQdAzaXIgYwNBuS9lkG1wUN+F6oovW2cdOnK
         9xUw==
X-Gm-Message-State: AHQUAubBkXJ/iysmNoXp8JoSjXknXMf8CymL/brfvhEViqxm3SBmL1zx
        wTDdns2qaRq5GQIH2AuDpZCVWw==
X-Google-Smtp-Source: AHgI3IYKNOaqYyAhxj+U0/dHFZhx6MkzavyyIb2QmJuotNT33H0opYFSpwDu1Slsg7VoMmw+6iHqXg==
X-Received: by 2002:adf:9061:: with SMTP id h88mr2983406wrh.65.1550152838301;
        Thu, 14 Feb 2019 06:00:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:37 -0800 (PST)
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
Subject: [PATCH v6 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Thu, 14 Feb 2019 15:00:12 +0100
Message-Id: <20190214140022.19201-2-brgl@bgdev.pl>
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

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device and the GPIO module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/mfd/max77650.txt      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
new file mode 100644
index 000000000000..b529d8d19335
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -0,0 +1,46 @@
+MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+Required properties:
+-------------------
+- compatible:		Must be "maxim,max77650"
+- reg:			I2C device address.
+- interrupts:		The interrupt on the parent the controller is
+			connected to.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:	Must be <2>.
+
+- gpio-controller:	Marks the device node as a gpio controller.
+- #gpio-cells:		Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+The GPIO-controller module is represented as part of the top-level PMIC
+node. The device exposes a single GPIO line.
+
+For device-tree bindings of other sub-modules (regulator, power supply,
+LEDs and onkey) refer to the binding documents under the respective
+sub-system directories.
+
+For more details on GPIO bindings, please refer to the generic GPIO DT
+binding document <devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	pmic@48 {
+		compatible = "maxim,max77650";
+		reg = <0x48>;
+
+		interrupt-controller;
+		interrupt-parent = <&gpio2>;
+		#interrupt-cells = <2>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "max77650-charger";
+	};
-- 
2.20.1

