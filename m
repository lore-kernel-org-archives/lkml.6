Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D2A20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qhQJlepe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfBAJs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:48:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32822 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbfBAJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so4114360wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9B/EYyDjVhwtFa4eu+FJyKZCq3f87a75jGygGJDT3Ao=;
        b=qhQJlepegW+vOTICAcYfONdJxPc69Cn641c4tlh/FDv4e4ZFJ3RSCugphxbjVQn7xN
         2OfmVhdh2Ra8AtHKdFWNUpMXb5ZOIY5SfCGVRA6wsAAaN35KOMnWAaQAhDNCRdszrO2A
         QsWsMjX14Cu/y8KeAox+Xp8nmwPlZ+2CCVbEUseV4qZqzT7QS6zS4WzDHwdjIn7VI4oK
         1DIB3OpFFpjnEl540Q4WiEcA639IgKhjGvpfDVyOV6ShDrUvpH4+mABt2qaHgIP/eDNl
         flOIZp4v1DKfaFpnQSf1kcIQr/JAnUWMpvzD2OIsbmIsTyURK36VBpmGua8LQQPepvNA
         +y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9B/EYyDjVhwtFa4eu+FJyKZCq3f87a75jGygGJDT3Ao=;
        b=kGpkWOnjKKYkS0ipC924IlAaRIt/R1Xl5MXPJ7IvtwTIZTYBqPS/D/iyFpzosvEnWF
         bciAIgMjigAiSeXlyNvUWfVv+Rl2QrmYAgpI61+/WLdE16Y8nIlWiV4l7K5AbqyH91Qm
         sAg0z9mgFM7tHQ59znOoQBIieGhpW+wZvkqDZkmx9k90NqL+OqypOHkr/WD37+LFelnD
         H36i13GjQVJk9I+07dAR9LujC/cUBFbczmXlm7ijd3QpKhvL9L+xIMc/t9LvQypaCp53
         q2H1ror2V7m0WeqOZt/jvG92FvJEnNtoS8FqroQAqjudFtziiMH3CwlS5rIsNSalST5v
         fwKQ==
X-Gm-Message-State: AHQUAuYWdjXI4HIEOY8thlmaSGuBVY7RPV0slWPF8f6cq93xnytsUmGl
        0Mij2OQXLoLPpH9CoRJ19i0KXg==
X-Google-Smtp-Source: AHgI3IY6GA0hGW3drJaGQqNPDCjuSPZzd36dvV368FCk7icZsqVzmEzov/Ofzftv42gyfIBwEW4u2Q==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr1531331wmk.59.1549014496991;
        Fri, 01 Feb 2019 01:48:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:16 -0800 (PST)
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
Subject: [PATCH v3 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Fri,  1 Feb 2019 10:47:36 +0100
Message-Id: <20190201094736.32057-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201094736.32057-1-brgl@bgdev.pl>
References: <20190201094736.32057-1-brgl@bgdev.pl>
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
index 9f64f8d3740e..d4032d94c275 100644
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

