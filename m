Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433FF2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="u+fysFoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439098AbfBNOBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:01:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439061AbfBNOAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so6614494wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyF/lYrXa4aZsXur/pzKaUabjktiLGBj4fanbTYeB6U=;
        b=u+fysFoYQJfTVV6CUmA3oKwsCG/igjIisjgFOimmPflSS2HW2L1teYVCTWgUe0kLfs
         NbBQrsl7wcPRulJG59dRp57qs/lLz95EGd11lVNoVJw4LyDhzPOYlxe8Vj3Cm2PqaWhs
         ChjfwE3Ix8hY9uq3FHBAa2d/fjVxdAiM/XEkRorBFgAunOUwQTmTKsBAB3GloCUFBS2k
         9t314v3hC1qmD9wnCN81gPLAedlO3UOwpgeZwWE0NHS+iy8NNx+8XBMo7TxBwbxX0RAz
         JAe2EwmnKzmyyIanuxvZt7Jkb1BTGCg5xE8f3PW+ZRO/V0Cvnk2c3eqmqmjLF/Jxe2Ly
         bfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyF/lYrXa4aZsXur/pzKaUabjktiLGBj4fanbTYeB6U=;
        b=k04PfJg28PER0YggSm/qJ5j8/j0Y1D5DcTCuRC43XnTcBDf6k5AUp5mc4RKponnsRp
         gsqiIPJYzjUF3LxDElRlo9o7LQ7WLx+UwmhOjH7iOCW3y72VQKuhMrknKSHWmWpw3wzT
         iiZgCSrg3SqJEZH9N0YUySWNVM0YDdbPt3v8uL9Prvjx/U4x+xplvj0fCy007NayW33A
         +qB3FSE5zcYATNM4QB/fe3gjBXpNyPyPJq9FdK1CCGp4rDRJSprQsejyo31ow/LrjCFR
         6TF5mBTZDNzYCoqn2g3t9YJh6/4CI4yXFhLgQBXrEkNsjW1L28Af5MYkBMH+aqD2Vc4e
         yuDw==
X-Gm-Message-State: AHQUAuYhhIK4qMirckI6xkxWCbEgXUzng9CABLojQ2hM2jUtohVN50Fl
        jFUBqHmPdcuJhYpkucrH6AWONg==
X-Google-Smtp-Source: AHgI3IbmUPE1PTWlFfc1x+FyVGF42ngksO4fTqr4r27eK5pkY9LZJEwiter1+EovZWp0j0TAa8kufA==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr2910904wrw.269.1550152852460;
        Thu, 14 Feb 2019 06:00:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:51 -0800 (PST)
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
Subject: [PATCH v6 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Thu, 14 Feb 2019 15:00:22 +0100
Message-Id: <20190214140022.19201-12-brgl@bgdev.pl>
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

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..ac96659bcfe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9226,6 +9226,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.20.1

