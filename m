Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103712086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FLOI+O1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfARNn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40302 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfARNnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so15114003wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8KA8pFK+0PJtvt+TimzBASH8n0QQ2+79sGfJ2pgn1c=;
        b=FLOI+O1/t6VHUBjZtS+cl7SZ6GmIUwfMpUjIri0gth1qhZ9K7hwwVaAMqzqtr4tL3V
         NlsLx9sulge1Opxl4m+WivAEnqP66s8mQwgyX5XCjR60re+gqQLCzjP9lRZF912F8ukd
         oIyI4IuCUEzksVcHPc9b5kzOCj0UfDrRD8xPhUnwUuGjnlba14GUj6gy/bgKJmX5Gaqc
         Ct7VPiaI/0LeAy25SUTjhg0t92lBMwH4lRdfZk1FDsp3pxdctrdI0r7HAW4rRKbxM6uX
         BF61kbYrAbu/iIhLUn775qjCwFL6xAPHb6jx7SqCTew6M4yjLIacZxeH/XBD6eMc6Fd6
         eocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8KA8pFK+0PJtvt+TimzBASH8n0QQ2+79sGfJ2pgn1c=;
        b=E2kpQ6gEycHXmr4NQkGQDJzpfEOsrISHOsvOnzBKKoWPl+FWoRKzAYwUJX02hPxmEu
         V08YL6zzdX5jF5Vr5h+XrX0MM7IsjdxkNAFJzqUQNRVecoHCP5A5d6agb459KB2gnLgU
         +aV+PsMZUQQmUZw+xMDIvdVbbduxrTscudKQTtheKQrc0M5lVG9mMhWechlY1fS9uEqx
         XykNcTJ4GKvDAdc8ny0J/2/qUJXfl92W6Y3xm5b98VyWJyXNIEkSAprbih59aT9KvT1f
         UNqgtI6+ORF6r8eW33UpbYhx7lzWbr68YTKlhx4FyGUbtGPNp27xOdhY/o1FGfIqR47B
         5RzQ==
X-Gm-Message-State: AJcUukeW/BNfzoyaqGwS3MpGB03lhWQVWiO1nMSXSJJtr3msBnYZD1mC
        30hY6JAHloX3OhhbigM5TRoovw==
X-Google-Smtp-Source: ALg8bN5stQtKYwuNF7m4ohACBo+ZZjBsLcsxQoTPG3gLh/UTvBbKO/gsNyYJ9uoxIT5xmN5o3oLLsw==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr16960100wro.194.1547819001519;
        Fri, 18 Jan 2019 05:43:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:20 -0800 (PST)
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
Subject: [PATCH 13/13] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Fri, 18 Jan 2019 14:42:44 +0100
Message-Id: <20190118134244.22253-14-brgl@bgdev.pl>
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

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..bb29fe250796 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9220,6 +9220,20 @@ S:	Maintained
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
2.19.1

