Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3321C21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNo6/epD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3321C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJBPJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:09:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33447 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeJBPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:09:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so975190ljz.0;
        Tue, 02 Oct 2018 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDcT737/quUU7Lv5/p9BcXm7XROdXOvHTo1MWEuta7M=;
        b=qNo6/epD9zhT9i7eFl392ifXVFVIgpDQ3gEaS0KRaTKwRHDZX4EmYmRNOPcZZ5m8xK
         DKc+GmXVTnD3wnkuzXvQXILLrHh54aDMXOqtlqZg/BgRep7sno7JiynAvegud7NmobV/
         HwgP+Y5xXcy/AK6GBVxtXUaCy1vsSLQzMrObVZNrvvL1Urhb1aGbLyV7LLbooI7wTjSJ
         P6p6Y9P0vo5whlzP1cFntFyYpZ2rklcUjPBf1LjbWRu5bnZJfl3Ow2QX1VeIt7Ebf+0S
         FNhughZh+SAYJe0rYNodiYnJ5w2QwhBdDWStIjsZ2PMBJPyXp1+o8LotaXibJoMaVTS+
         Nq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDcT737/quUU7Lv5/p9BcXm7XROdXOvHTo1MWEuta7M=;
        b=pv6NYUnJmCdzsQrmJF95lJetrjlfl+/YcvB9gm+5oKhZz0im333ce435YgZTd7YTDv
         74oC4otZphlzUubaFS0Q0+HMshBPuY68l9c5bswBNTBQ/BE33RnjFbMLtPRq125MLdAC
         byT492pT6vqZ7EopjbJ/voA7OlDeaLzAixUwhQmnusq6j107mF+lV2JB5TdLXdx63IfG
         6riVRInyVBQndjCw9aO/GBqYDfJUCEPrHF3v+TctA0w2Svd07CFaP2YuYWKE8TdiumDK
         C9ughxxZ2ixaWICNIgHZmULq8rm0pps2A8niWpmNXnO3p1E1AtsWDVargcKc29mzocUc
         BgwQ==
X-Gm-Message-State: ABuFfohBbhBp77XThqZ1gdbIAXgCQz8uUyBoXsWh3rN/RBLhKiANuga4
        MkAj9sdtwLaVw94vicY3Pdk=
X-Google-Smtp-Source: ACcGV63bNydptegBMlTLCfRHlza2rLgeH7lmgrrH6O5gMeDN7D6ynlNS3V/LZUI1NRwfReIyv/sDTA==
X-Received: by 2002:a2e:6f0c:: with SMTP id k12-v6mr8918282ljc.66.1538468858362;
        Tue, 02 Oct 2018 01:27:38 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1493531lji.87.2018.10.02.01.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:27:37 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v3 3/3] gpiolib: Show correct direction from the beginning
Date:   Tue,  2 Oct 2018 10:27:31 +0200
Message-Id: <20181002082731.20141-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
References: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code assumes that the direction is input if direction_input
function is set.
This might not be the case on GPIOs with programmable direction.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6925196136ce..eaadbcb5c0f8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1344,20 +1344,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
-	for (i = 0; i < chip->ngpio; i++) {
-		struct gpio_desc *desc = &gdev->descs[i];
-
-		desc->gdev = gdev;
-
-		/* REVISIT: most hardware initializes GPIOs as inputs (often
-		 * with pullups enabled) so power usage is minimized. Linux
-		 * code should set the gpio direction first thing; but until
-		 * it does, and in case chip->get_direction is not set, we may
-		 * expose the wrong direction in sysfs.
-		 */
-		desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
-	}
-
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -1374,6 +1360,25 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_irqchip_mask;
 
+	for (i = 0; i < chip->ngpio; i++) {
+		struct gpio_desc *desc = &gdev->descs[i];
+
+		desc->gdev = gdev;
+
+		/* REVISIT: most hardware initializes GPIOs as inputs (often
+		 * with pullups enabled) so power usage is minimized. Linux
+		 * code should set the gpio direction first thing; but until
+		 * it does, and in case chip->get_direction is not set, we may
+		 * expose the wrong direction in sysfs.
+		 */
+		if (chip->get_direction && gpiochip_line_is_valid(chip, i))
+			desc->flags = !chip->get_direction(chip, i) ?
+					(1 << FLAG_IS_OUT) : 0;
+		else
+			desc->flags = !chip->direction_input ?
+					(1 << FLAG_IS_OUT) : 0;
+	}
+
 	status = gpiochip_add_irqchip(chip, lock_key, request_key);
 	if (status)
 		goto err_remove_chip;
-- 
2.19.0

