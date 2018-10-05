Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B98C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A60120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3dF5Hd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A60120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJENu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:50:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33116 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJENu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:50:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id o21-v6so8602605lfe.0;
        Thu, 04 Oct 2018 23:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDv7+lrfVHx6crNgWoKYdtCEXUNPEwDIMvB3Aq/NiOY=;
        b=U3dF5Hd/6yXGlzsw+OcTsxfReqrXFy2yFJ4m7PNFNgqz8tkeIIinx6jtyS/YSYmWhI
         Z58awvvaAm41fqxDObeJCrZ3yyOYK7MumxMJ63HD/juPrXX+nYcS8xd46+KNp8K6oQdF
         SLPAbv+Q5UGX93RU6grtxZBn5pHR787GemwqZkgA4z0jNXpS09gWoyeqzxQTwYZ/zEVH
         NUP1pC5HR/4R0ut1XaiKx2LosCF/OHMauiG/y/IwYlZz0NBiqiONXh29Sx0roZxFgQeU
         J7xfzcmoetuIztvZhXowmnnhJ6a1qfQhZxZO6U0Y04Jav05Do2MqhlfmB5/gwVOfea8t
         UJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDv7+lrfVHx6crNgWoKYdtCEXUNPEwDIMvB3Aq/NiOY=;
        b=XdpcML8vGKau12Ukl9ozl5SwGcJR+mpiFsub8xbl+iCo1tyZ2GrQUBAV5HU2oVv4AE
         kN13BCzxgHboxWIHZQQ8cxQR3+uiXsvtf8LXqrCXvQ+hVdy87Y1K7S8al4QS+9ojuwGf
         +ca0wvCj1otV30yt64Rkj5/+uP2+wtwI5slWIGJak0tcWze95H1WXW8i302uHKkJN1kD
         j9ZpvMR808lF2amleRisiEez7lomD+uhxCQq5QFlnx7UrP3bK3blyA54yCw0gt0Mz8tE
         NuO0KS5X640tqoxB/NszY+Y7r/ugwjom1kRhCBbFCVoYpNR8tHJyBJtYGcw56rii3KG2
         NpXw==
X-Gm-Message-State: ABuFfoiYXYb+cBoozPOGC2Y4qu62m08HeMNC+BbmgrC5jA4YKb/YwCGd
        3a6iKPFMQBMSD+KpQnonWKA=
X-Google-Smtp-Source: ACcGV61KRnBQS0qflgMGeYEwS3+PckOqyS5OfVGo/+rttSWA6v0S2DGKO04UChvRE78kC1pGH/DxiA==
X-Received: by 2002:a19:ea57:: with SMTP id i84-v6mr5582566lfh.91.1538722387064;
        Thu, 04 Oct 2018 23:53:07 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id t21-v6sm1608871ljg.32.2018.10.04.23.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 23:53:04 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
Date:   Fri,  5 Oct 2018 08:53:00 +0200
Message-Id: <20181005065300.22882-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
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
 drivers/gpio/gpiolib.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 907019b67a58..e016b22658ff 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1349,20 +1349,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
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
@@ -1391,6 +1377,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_chip;
 
+	for (i = 0; i < chip->ngpio; i++) {
+		struct gpio_desc *desc = &gdev->descs[i];
+
+		desc->gdev = gdev;
+
+		if (chip->get_direction && gpiochip_line_is_valid(chip, i))
+			desc->flags = !chip->get_direction(chip, i) ?
+					(1 << FLAG_IS_OUT) : 0;
+		else
+			desc->flags = !chip->direction_input ?
+					(1 << FLAG_IS_OUT) : 0;
+	}
+
 	acpi_gpiochip_add(chip);
 
 	machine_gpiochip_add(chip);
-- 
2.19.0

