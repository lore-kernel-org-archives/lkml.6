Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E52FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12A82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CJO7XVo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfARNnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfARNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4546907wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Br82eUdliRcYW5k5XdaEofZ+bBn9gd9M92yB3kYlbF0=;
        b=CJO7XVo4nJzuLOlQCd76suu7u1tTTgUJ1nukNUyCNXyfJ43s7gxFUD9kSS+d+Kwx3q
         2zyAF97Qq4Et3vmYiniLNWOEJ83f6ZAjuj9F6B4v+S1O3TNNLKq9rNrWABPO3RXd4fsi
         lDFEAmFMBmoN2VfBdlaG8NiIR/c9RFF0lMEx6cdVUEjykDZke7CCmcTxXEVrggrOpf1T
         szM8hSGOpwftvp522xYtxCkuYmv7VS7VZMNDsQaNcudxINy9JOzGAPOBCuV7n4c4BJKI
         r0qpCaipoUsdCd11YHtx3uDhH0hUrGtNWMpVVOcgAYb3/5SDuZZLSqvWeBR7y6ogrlnP
         xpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Br82eUdliRcYW5k5XdaEofZ+bBn9gd9M92yB3kYlbF0=;
        b=hBNRUBJ9lVNPG3xqA+wBu2ap2ok5Ppyc/YjcY2/EF2wg6f1ViL2g5cyvTT2PcTE28r
         JVVzTabZjWVvlIu2Q4u3viePBnaVVuSeaYYwoszRP/5PsAPJ8iVJN43HOXpMxGpmk6t8
         wmxlXq+fUo7ybvCX+yx859wWU96p8kHQ5H7QuPnqKiqZJyc5z80sfIGiiF83WV1s6MFG
         QlqSY//jaG3bSmy+6OHcRrMs8qgQ558DuhhGmz1mV44UsdZ+xjstYJSDirEUZqS6wxzZ
         ATiuwv2Cj9K2oldpBIK5b8pt8HGNbcINz50FCYnxWqd6oDzbQaCKgK4M+LlOOmwrEfIm
         rErw==
X-Gm-Message-State: AJcUukd7H3z0IzWCiwGB/ATrXDyVfxML+30l4uBsjLLu43TL2IVJk+qQ
        mZH7VNzVZeVeFGxKacCixY+ziQ==
X-Google-Smtp-Source: ALg8bN79rgtueAh2YoeFOEiapjNWpk3EUz91OIu1yf/VDdDVtSpYFM2Ha0rmYbxCr0sT7T58n1p1mg==
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr14772914wmg.132.1547818986398;
        Fri, 18 Jan 2019 05:43:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:05 -0800 (PST)
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
Subject: [PATCH 02/13] dt-bindings: regulator: add DT bindings for max77650
Date:   Fri, 18 Jan 2019 14:42:33 +0100
Message-Id: <20190118134244.22253-3-brgl@bgdev.pl>
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

Add the DT binding document for max77650 regulators.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/regulator/max77650-regulator.txt | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
new file mode 100644
index 000000000000..f1cbe813c30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -0,0 +1,41 @@
+Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The regulator controller is represented as a sub-node of the PMIC node
+on the device tree.
+
+The device has a single LDO regulator and a SIMO buck-boost regulator with
+three independent power rails.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-regulator"
+
+Each rail must be instantiated under the regulators subnode of the top PMIC
+node. Up to four regulators can be defined. For standard regulator properties
+refer to Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
+
+Example:
+--------
+
+	regulators {
+		compatible = "maxim,max77650-regulator";
+
+		max77650_ldo: regulator@0 {
+			regulator-compatible = "ldo";
+			regulator-name = "max77650-ldo";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <2937500>;
+		};
+
+		max77650_sbb0: regulator@1 {
+			regulator-compatible = "sbb0";
+			regulator-name = "max77650-sbb0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1587500>;
+		};
+	};
-- 
2.19.1

