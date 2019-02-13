Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3346222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="p3MjEF3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbfBMNoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:44:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51822 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391273AbfBMNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:44:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2524726wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyF/lYrXa4aZsXur/pzKaUabjktiLGBj4fanbTYeB6U=;
        b=p3MjEF3Byy6BZL4NEFPtnj9ARzliBH8WZk0mzqm9b6xBd4TcvbNkv5bpdd3gQGKsXf
         EYnRRbQBiwF4Q5S/3eLSnGQviGyePuuYtrh7KxEmDlj+PPWjN0+mmOMphhzBkcRTEdh+
         vtIZGLI4sSlVxYsBQA9ExfSUoy81hjYllMDbWz1yKKFrQcackXtuj409k6BIwarvDxI4
         CUdxPhJcA9GFCVJrKuQ6oxNOjPTZVLg++LSBXx1xnq2b/FKzQ0caOE/b8Us+Sn7LYXnb
         sgCSKQofL3Mm4JU2vCp1vMqcJVcAkE5SeoKc/w4Xvx7+uDRddiqT9mOFA1D67o3Ovx9U
         Tz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyF/lYrXa4aZsXur/pzKaUabjktiLGBj4fanbTYeB6U=;
        b=ZHfl6tCc7jP8+2W8xnGf41Ezsj5ZXCtVr715WZoivAbjGL4lQE//agFdj1TTiirs7G
         0f45hTknRg6Oj64UFyE8fkiJsNWDvQJlzn9TYFccHr2/ednZtoQITZkEomFGWuB/4w5T
         x8qVWO8A5DdF/m/DyoiC/prQJ4dpn/vXkTUMVl7yJ4hSt4oxVGY28wVeUjvEFHuOs7W4
         ZiNEQYSwBdF0rI1K0EEaR3Sntp9I1bezcJbxkNp04bAnDZplaz237VcB3mE9DMKF86UC
         4HKiXYKcCOksk72CSHjnk+RmCB9wbSIuIa1+vXKa4gL0FSxKKbGR6wjO0A+0R522dqNT
         v3ZQ==
X-Gm-Message-State: AHQUAuZZuq8a6SwNdXIxd2BJ+NTCOrxK3luAa5UWYOPEJGfYkO4i276i
        a+uHZFOV6zjeamyX6HOv3nijLw==
X-Google-Smtp-Source: AHgI3IbbF48VOUVBEzahxem5NKWQ156Wo7BnfJ0R+IOJnutWgcEACCNO4rO7qW4n2t/3KMLZClEaTQ==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr349456wmp.63.1550065444489;
        Wed, 13 Feb 2019 05:44:04 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:44:03 -0800 (PST)
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
Subject: [PATCH v5 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Wed, 13 Feb 2019 14:43:35 +0100
Message-Id: <20190213134335.10838-12-brgl@bgdev.pl>
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

