Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463F82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HVqgYLXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439143AbfBNOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:01:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33020 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395115AbfBNOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so4378930wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KouBHCieDSV7idkFJwAAq2H7EglJYSpQY5o99NkrtdQ=;
        b=HVqgYLXvPJPcpIoBiW40YjVbYUeYGMMBLaPYTxQDS1iNsho/7p7VRhfZJauap0YgPJ
         +41lFayAOTi5T/wbEyUpFKAeNzVIsdWU0ORhsNPWNPnhkc652759e5zMGe5e8j/72SOo
         cVKb09atQBxRIk2bO1u3XgRXybH8CrEZrY8A16sQc6tnpNbMdQB9ftLV4YG227/3bhu6
         6HjsvMiizLy8Im4ZsAG+24Veyj7EXO9k4/ty42utwJbrQfTWHL7Zrh+TZV5VXBQydJ6z
         R7YbKch9mFEO1oIn8z2fvNbP1BxojHSJpJ4cfEK5Uw7Pq1GScKegrQ5EkqPLYb1oo2SX
         N50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KouBHCieDSV7idkFJwAAq2H7EglJYSpQY5o99NkrtdQ=;
        b=co0Bw55TLoAzYqSUyMkRKO8SZCQCOdA4V7IdzX9STPFHyhsqEl+Kzf8L+MK/PyRWWu
         jHnxkTCrYSxBqiMsw8I8h8Hdopfd2k/Qpk+DKWesP5CsCfGuyq3qHI9WzO0itVmah+RS
         M6IHrMjJSrmTKGjKVtUK5q8zTowKhifL1k1SA6LzvUaKtuSifG3EB+PplogPoyqUVTHH
         O9+vDmOgve0SunNi3+uuw8uv1UXdSyfzYYuj3SPecFPQe42IRLeaVeR5HpcCwPQTzNC2
         nhatw0jdM98VlE9P+bqWa62GR5i6UGPibaEZIeMi2+wdDhvbh/a7s5zc/p+5V+HYNxVb
         2vUA==
X-Gm-Message-State: AHQUAuaweeR+TCWMAeLjvcR1zQFMMW4bUGPP0slKKgsq5PFDqyTqA+ii
        JbFNewmUTq/x29xz5PsaUta1/g==
X-Google-Smtp-Source: AHgI3IYoOwzAI3EqqjaUJafuaJu68nQAAx9lDeBKFSa0iZXYTN3HUkWXbd9Jum2ZmJI4liXu/+NYhw==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr3065123wmc.102.1550152839793;
        Thu, 14 Feb 2019 06:00:39 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:39 -0800 (PST)
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
Subject: [PATCH v6 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Thu, 14 Feb 2019 15:00:13 +0100
Message-Id: <20190214140022.19201-3-brgl@bgdev.pl>
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

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..d25c95369616
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
+- min-microvolt:	Minimum CHGIN regulation voltage (in microvolts). Must be
+			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
+			4500000, 4600000, 4700000.
+- curr-lim-microamp:	CHGIN input current limit (in microamps). Must be one of:
+			95000, 190000, 285000, 380000, 475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		min-microvolt = <4200000>;
+		curr-lim-microamp = <285000>;
+	};
-- 
2.20.1

