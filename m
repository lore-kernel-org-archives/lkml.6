Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775F0218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yLwNqsg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbfBMNpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:45:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40024 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391012AbfBMNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:43:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so2456933wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4b9AHscYwHc4AK+X4761NE8PqFk+QkjrMOkHjgIcbc=;
        b=yLwNqsg0RZWMjaf7xvR7gdoH7WAt1qd3NZAPvdNWCc/v8qGemCvXSW4ClKZLMMXs/w
         ++TExscX046KdVzvmZdRj1TSGf3h6JiP+yvxz6XMg3gIlWfeCcNUJT9fdxVD6YbbOPEm
         vkujhqB1yi0y1ce5bJWN24Ii7XiTGIxDNuYipZJXLHv2fonCrMA0BD+LcWLq82UQUn61
         Uxfgl8U2odOKTFloiHr9vpygSfsr7M8KRm7ASqxSf0Q70FxuIg66oHqtnOA9xKzpaTu7
         XFcphjmXqBmdF4Xyqazge6cXaV3twknJh6ZEhzsSe7viOPSyHeZCNfwPbyTKvaYzTtPV
         J8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4b9AHscYwHc4AK+X4761NE8PqFk+QkjrMOkHjgIcbc=;
        b=PuZ8ppHCzoiRNzsWDV3VVNdv3gIHbObE+ICMN7ZFtJsaX9/ybE9poRtqshLLZDM0zm
         AwprGB3DM7MjznoP1St/sC9tbWsJwQv24E9Sd4P23a67atN7rbfQLX/7ZC5TvCpttIPO
         s6WhmwyWu7LdtXHFCE3ZsL+PxJ4vM3c16hl8c6AQyEVu7D/SMnUAMaljmZYXkw1+mfTd
         glEdG8/OuwYP4T5jXv9+8OW6my5J8gx7Lc+HahPP/QpYIJ0drg+DpRmtUzyrHlf4JHk7
         FEOZsHwuWrSKCEKXYkqM6wAfWhE1Z9DDrakjMVidhzVhsXtWUqJSTy1woHWK24eiKvHH
         QYaw==
X-Gm-Message-State: AHQUAuZwONGL8kVDl9AnfnrM74nB7ayBvmJkaSNqL/n5F34Njt5RHn2M
        AMk9v3sW04noX8NXdVhDFTh/qA==
X-Google-Smtp-Source: AHgI3IY6HBskRoYDWoYvrYczkpFcgHLUGZkGVX1N0eWAk0J/2GOt5GdKqDbSR0lFn9qiMXURt8yg+A==
X-Received: by 2002:a1c:47:: with SMTP id 68mr347390wma.89.1550065431794;
        Wed, 13 Feb 2019 05:43:51 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:43:51 -0800 (PST)
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
Subject: [PATCH v5 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Wed, 13 Feb 2019 14:43:26 +0100
Message-Id: <20190213134335.10838-3-brgl@bgdev.pl>
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

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..16e24173c80e
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
+- min-input-voltage:	Minimum CHGIN regulation voltage (in microvolts). Must be
+			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
+			4500000, 4600000, 4700000.
+- current-limit:	CHGIN input current limit (in microamps). Must be one of:
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

