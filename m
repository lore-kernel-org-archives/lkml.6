Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F1220823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Oe/PNe6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfBEJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:13:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbfBEJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:13:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so2737633wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVyvi+G8dDAJC0Xir9B1tDQd9JkS7vlenMm/TBoPGCE=;
        b=Oe/PNe6FIlQd/q64/aakA+vZg3jSz8Ixcm4Gy76k7oNLZHV69TP6udnp8ytpaxQHFp
         4B9XwTFjuYdyKZy/sYrNjGlxIXeUWNFzjhcsiUAW1ulSVI6n3/uQvPLFy3ulqFqul3bG
         G2Xe9F7jXDR2OKRCW6aFqJexUYt3sw0qtltiQRBiVfakbTt20cV/bv1kNK6GmvUYtn53
         M1ojK8esiONwmCsuDat8ikkdIOID07HneY9IA9SAluHhOx3HhCi5GAVId7VHikFCVymR
         2w95rf8GPzFl1zC4ya6VEw6rrQhuiMRfErN3+rsejPAs8tj0J1VUS0tmrc7bUeAQZozd
         z/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVyvi+G8dDAJC0Xir9B1tDQd9JkS7vlenMm/TBoPGCE=;
        b=U2H43uaMVpjeIvX5x5I9wly5xaZZfJtXAAkkUiW+Vcm5WYwK80YCioy8fPIRsFj4hP
         /Yb6Tw5RdYPXjDI565JQB1AfObYl+LDvfQw2ziYaypT7fBWUpN17WvkqsQTfInmHqTYR
         yPxgO5+G/Ve571RKIWdXmvu9zxLJRb395ciD34gl8C/kT6GdVlqPHXzJ2gV2fTDMj2Ej
         vvQJ4hYWTuLEOwkdnIIgy6CPNF0WSl9wsCOAkv1tuPlVAbtaOg09z8lS5svgpA34klX/
         UozEG50keMJzVsSTKNQLxX9ZXeBbvul/89CptZzrMz4xTlNgFXhKO3+yDebeA2EV9bWV
         eIbg==
X-Gm-Message-State: AHQUAuYB8CY1ij1ac+3SKZGXI6inw4oh2GINBacZUHjjLQA0qUc7pIdq
        MAzSeE3P1+gaIHDHZHz8WXd1RQ==
X-Google-Smtp-Source: AHgI3IZaxJqoSBEXKTWGnMW6PWjLRzIrhmt+vyJWF+9kvvpguOZgyABxlSw1sm/qQba4wg53IiCbqA==
X-Received: by 2002:adf:f1c5:: with SMTP id z5mr2836842wro.118.1549357978463;
        Tue, 05 Feb 2019 01:12:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s5sm10433657wmh.37.2019.02.05.01.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:12:57 -0800 (PST)
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
Subject: [PATCH v4 10/10] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Tue,  5 Feb 2019 10:12:37 +0100
Message-Id: <20190205091237.6448-11-brgl@bgdev.pl>
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

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c68de3cfd80..70106d30272b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9221,6 +9221,20 @@ S:	Maintained
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

