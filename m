Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E4DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA2214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vWZNWsQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfARNnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34556 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfARNnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so15193895wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJgaRxvdLEz10xwcfFGy19fU0asErTcgCnz6M9qAYUg=;
        b=vWZNWsQpCnMw6W+kMzqDWmebSRUuVpjzcZR1XCmg7Uy03JpsRQBPRcq12C9b4PTWvK
         8e+wGI6CZBiirjM+08OFImmdHkGwviukPWYdOzwRzt5bgIZWAGaCdfiQjzoD/ompzGMS
         ypCTAYqdWhyhBRTi9xs3C7pxiSnHUu3I2Ad97ohi9822HtC24nb+UAt0TTlISVAPst0o
         9kHksS332bdFjvcwWP1Zb3Y1q9MqFVsESCPGnc6I6DIvtIyIthtNiYeN/4Re85TO3KUH
         KID4lMr6cBbctHWp6VUFcXSfI7V6p3sv9eexFfGR02gJFs8/IApgBLISP2dPB04vb9l0
         stfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJgaRxvdLEz10xwcfFGy19fU0asErTcgCnz6M9qAYUg=;
        b=J0OnqMHg769zvBBaf6JG6v+bm1uXErkiYlh+Qk85w9BX/1svtofER14P/EZ5NWyVsQ
         RPJvH4hJLbcn+tCdxBgD6Gzl5fWkusY31s6N2UQbVjdRLNdeGYf4LiQfu22W2oaPmlNP
         6bmBZgM2TzrGBbM6fNAfY9c5DYq1kg+DXjD8qUbBFrp3g/qRT0mEbqW28pkXvoimfGn6
         rgGLmY6h/pSaU4/htXKAuMlkfT/2Wr1gAXeVIr4Hh3lzZtbCScC0MKdCxXKb8Rn1VEVq
         GdGQyazH+oPR39c09CE0mxgeFlhraVf9zmAX6vSnUN1hs3KckMlxw3g2/SR7EFvOGUY5
         j5Fg==
X-Gm-Message-State: AJcUukfgzJqupholR8nyWRabS2bpXpCXOYPM7OALrNPasNtYt3yni4ZG
        KJt07fFQGzWY4iKrO4j1CpNMVQ==
X-Google-Smtp-Source: ALg8bN60XLBfK8i/rGRPp1ZcEqc6V3ZegokgqCoDdW8g8D9DqJLDqcZRQ9KrpWiTQCk5mZXofLgS+g==
X-Received: by 2002:adf:d089:: with SMTP id y9mr16945662wrh.22.1547818989032;
        Fri, 18 Jan 2019 05:43:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:08 -0800 (PST)
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
Subject: [PATCH 04/13] dt-bindings: gpio: add DT bindings for max77650
Date:   Fri, 18 Jan 2019 14:42:35 +0100
Message-Id: <20190118134244.22253-5-brgl@bgdev.pl>
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

Add the DT binding document for the GPIO module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/gpio/gpio-max77650.txt           | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-max77650.txt b/Documentation/devicetree/bindings/gpio/gpio-max77650.txt
new file mode 100644
index 000000000000..b5dbbe934deb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-max77650.txt
@@ -0,0 +1,34 @@
+GPIO driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The GPIO controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has a single GPIO pin.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-gpio"
+- gpio-controller : 	Marks the device node as a gpio controller.
+- #gpio-cells : 	Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	gpio {
+		compatible = "maxim,max77650-gpio";
+		gpio-line-names = "max77650-charger";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
-- 
2.19.1

