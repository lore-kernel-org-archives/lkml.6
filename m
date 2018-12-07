Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6234C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCFC208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGUWPiUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCFC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLGK67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46227 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLGK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so2662453lfc.13;
        Fri, 07 Dec 2018 02:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiNySdvKpdqVZthIZ2SEKv6yRudMOPr8qkp6aqwtEDU=;
        b=EGUWPiUJ5vLhV2r2QgVzTtRuWhddBEGZ1ZSmdDP0uzHNWgVjqlFVf/1APt50eZDgke
         peMAo4IbOC8TCdJNypovGB1YJ96ppzqAayQ1G3pj8jtUGr1Wj8jDARxebkKoEZb/UGBv
         OEXr3fI692ntFkBqLKHvr5yVTbWbPhpDUwzz124esyfzGDPM9u7W+U85CuX7le1XPRN9
         rNSOUgOwiryd9HfgyHO/yWulpdh/6JpGZF7H6kyruk1pTiZNLGudriXJaAJDjFwE6X8k
         f3JOLHqlA5k/U6XWj7KdNHD120YS5xN+hG8sDr/43bSUMbOwdPEWOwviUHfv8l+ZjwHF
         GvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiNySdvKpdqVZthIZ2SEKv6yRudMOPr8qkp6aqwtEDU=;
        b=jMe2ZegPAH5PmLE5IhtVcx5zBD7D7Z/p7qwXgaUvRXG9ZFlEk4mvIRe5jY4TXXX0UY
         MGm17jh54WWWkpiTsQq2jH0dl6bsLxA/pzHcmqeK6ln7lxFeLnK50B8QAjJgUePWCFWm
         AceJUsItuPOv2PLk4/mQt1ZHFql6t/paOedHGV9o/isu9WyS+UANVA0on/bGNKk2vRWA
         wMcBjLFjQW+bz62PKd4GlTas5y8sJHp2wSRM0ZqNSN7gxyQNmDGFcA2ItXuU8bZUnWmO
         TA/3rbP0HHxUU9a1qxpV7C+FKf7vfL+I3RUG4DGGvGzbnEBI8HYe/9Pj0+ppW8ha/4ne
         cIjg==
X-Gm-Message-State: AA+aEWY9BcvW9fweIkBdsSpFHB0X+80SGfDPTm2XMDkq5KXov1Ze0Qw2
        umWi6FXkGFFLpUrgkmODulc=
X-Google-Smtp-Source: AFSGD/V0KyDsG5eDwdXFS8YyypebvaADggIfJiZTg0aj3TTrIgq51PDJ7vOjHqGkVByN4ac7ocemLA==
X-Received: by 2002:a19:a86:: with SMTP id 128mr955668lfk.139.1544180305167;
        Fri, 07 Dec 2018 02:58:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:24 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 4/8] Input: tm2-touchkey: Correct initial brightness
Date:   Fri,  7 Dec 2018 11:58:07 +0100
Message-Id: <20181207105811.1831-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Tm2-touchkey don't have brightness levels, but only on/off states,
so replace LED_FULL with LED_ON.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index cc713b901bf2..a73894b8dede 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -235,7 +235,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 
 	/* led device */
 	touchkey->led_dev.name = touchkey->variant->name;
-	touchkey->led_dev.brightness = LED_FULL;
+	touchkey->led_dev.brightness = LED_ON;
 	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
 
-- 
2.17.1

