Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23239C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E777A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hU3cVi22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfARNol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:44:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40768 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfARNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so4516749wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTSndq9JGcH1Dn9M4h6E0lGXK3kJ2m8mtr89zhshVnY=;
        b=hU3cVi22UjkEgCs923BIv0KFHTZ19zu4QjP9MhjIac+dk4K4d4tJfyod88ng5xVB/U
         x+Yvm/ynGMcCsVEcdTXKG1wbXVXR5u3LiSRXFsPjvg5Y2KbOygr8DC4JkB9RLs4JnuCh
         PEz3eeqLvPNp+7jFKCfzcUU97q8BTICmX5yK/ZsvJS3RjAoNo19fE9KJ6V4yKgd2adMZ
         XsxAhqdqjsoECFxcQslHPthZjVlbUARIgFYle9K5qg8J7yncHDotdCRpBkVK4almGHb9
         DVYtS1cXz4pO7tGRXYrF4C1p5EuEfQg7kwi8vpdqFSUHbH8Tz4cIgLYeyp4UbSMCjMcy
         NKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTSndq9JGcH1Dn9M4h6E0lGXK3kJ2m8mtr89zhshVnY=;
        b=UqFbtjqkpWLtdC2/lfgMK9ztnNGe/mbZCugFk/XgoY0DQgKQ/gG9n9oI0hV2d0/tl8
         HS5toQoUa0hPOv9q5032UVjQB1KRdrvEn1xpeI/+CGwtKpfg+/fIzu75fcxOTNMP5mhH
         Dsy3s1BxdUqf5RhEAKeUFnVxCpFVU69DZMzjxYT5x5FOinYRI4JBK7gX+vlsAJJG9nOB
         0A2n9a5wGbDtBNZ4uy960TkFRieIccTj29kZP5y3sZU/r2xoD0ho2opj8cRpavytUutS
         gGJ7JMO5lEiBOFnm7c1HhhlOgNd0/HTVrNa0n3pw2SNhKEVQw4fwgzbYlAGs499BES9D
         vZmw==
X-Gm-Message-State: AJcUukdCEtNqNQ+lLKXb2CT+/Pkt5/bZd1BxKz1wI0+y8p/Xtc5mbWjM
        D8IgUOv7CzzArHAHsa+B05BZ/g==
X-Google-Smtp-Source: ALg8bN4BN+uE2HPWfvIuIcY8nRDloRrgnv3ezNiGx9VnouVtpaD0B2z+3ASSBl0vz3BupBm2aMLTPg==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr14968529wme.95.1547818987673;
        Fri, 18 Jan 2019 05:43:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:07 -0800 (PST)
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
Subject: [PATCH 03/13] dt-bindings: power: supply: add DT bindings for max77650
Date:   Fri, 18 Jan 2019 14:42:34 +0100
Message-Id: <20190118134244.22253-4-brgl@bgdev.pl>
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
2.19.1

