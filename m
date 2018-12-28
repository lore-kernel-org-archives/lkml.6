Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F520879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgONh5LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbeL1Pqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43394 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbeL1PqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so18986861lji.10;
        Fri, 28 Dec 2018 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/c+ISyiSRiDIt4sidmbC1nUvxvjzDpzrqa5uzk8AQg=;
        b=KgONh5LI5USOdOJ6deR/sjVqQrwYSNhOIx9RjfXsA9IQlndnSNJZm99gkZ7f1VGDmi
         9wFYJJYo6dzoLFTf1Rtzo9Vccx6Nq1tb9kt0lrQDifdzsXGBNMnJj0lI8BYqtra4McOi
         P8N/AOpOblMQY68yWpO/aEE3zVdFL3gpbmCztwzD6N6it8O0nYhzsyWg6cuFd/UINlHS
         N0bH8rZ6vh28k6BZMNMzazAP8EUGpe9R+3vGLExMem0S1Ul47o6vI8MYiR0Nks92gwTe
         XWISxAlIPnxAYiF9oktsYSmn8rdf7LDsugTkeAGovcgx3R0Ee7slhj6q0QyPEDnJuGTl
         ZwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/c+ISyiSRiDIt4sidmbC1nUvxvjzDpzrqa5uzk8AQg=;
        b=GocpqE+PE3gg/r4AKC40wutDz91iWQ4jayLjCSe41Q+NGMsFmEdI7cVKSoV20qvA0l
         gLFldmAYy94Hvkskdcl4xK76w8bFumiWwN9LT6bPsMeLfBjRCFO7v539oHpxlkF8MWi7
         Gvj7FeIjrBnqNoTwL9Wy7WqnLkMqQay+y00XNk97HGsJgsUY7coKxo5s2WM56b4tQnuT
         Y8bWHwhaDg6SGP13Y1UBQAUXM9GajIDPbTWvu5uCZbyG6kJMXMKRQWYjrH7OhVbAccXo
         3FhwmSJmwiVdMZ909LyXgJ2m+SowkVyZTbqGUyI6MEn7oZCecVrMBsJXz5F0+VLxDeiU
         Q5Ig==
X-Gm-Message-State: AJcUukdIb3pml1/v4c3ZkWZCQqgGHnxnwjeDc95yUqK+C5BiECxF79su
        aoEdmkJe1xL9TAbvcGqioc6Em2MVwd2zdg==
X-Google-Smtp-Source: ALg8bN48aLT1MsWm8MLzesRbKovjRYcn8sZUL2D+IP9EimtSTUdOsriUXKanWTgDywcnSPv9Wxp/8Q==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr16122839lju.116.1546011980006;
        Fri, 28 Dec 2018 07:46:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:19 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 3/7] Input: tm2-touchkey: Correct initial brightness
Date:   Fri, 28 Dec 2018 16:46:05 +0100
Message-Id: <20181228154609.14846-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
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
index 5a1fe08bdd76..0336789ab1bb 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -230,7 +230,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 
 	/* led device */
 	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
-	touchkey->led_dev.brightness = LED_FULL;
+	touchkey->led_dev.brightness = LED_ON;
 	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
 
-- 
2.17.1

