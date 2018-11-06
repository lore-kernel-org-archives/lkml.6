Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BEFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA22086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPMaO9jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAA22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbeKGHfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37070 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbeKGHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so10043952lfh.4;
        Tue, 06 Nov 2018 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1nKBaibi56yUmTmkuYCfoWlWz/nSasCx82UG1C36UrU=;
        b=tPMaO9jdPLf5PSKX5kTmIFFOwD9Ps5rPu4pA/jySJiZahes4COZ/hDXU+sz1hTD4Tb
         cXIflM+vVwGMje5Zxihfe6J6GDqjhZtyk9o5HBLWr+ZSFpwHOUrydOXIMTMQouGdUYJg
         ksFtcoDJBl10E7wu/dZx6VCusu39Ol25QDWLPE4hCp+OqjQUpTnlP5dhbKaEVya/oehS
         lQBkm5dgbF1x1C1vaN7XCBjCYmm7vgWkasarfS7KND1UHvNQx1i3TFRnrvXmGATMhYg1
         aPPRdtRM8f+akmxzu/2Q/P3I6uVCjZt9qXgtoahrS5IDDVOpL+sxNHTrnkSHsjsOorlK
         bohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1nKBaibi56yUmTmkuYCfoWlWz/nSasCx82UG1C36UrU=;
        b=OROTSnslSc8e1KIfGS4YHKgn2x3lPXS4O0dovmvw7GaG6mMfCIxTYovdN0vPbiU7/F
         dJbDwrfQ3d7IQd4KNzfY+zd+3KAM+YAO+XliHEa+MSBvL12ExF67bsGgW8ZO+YuMtvao
         gwn++C3yuCj4B5ns3YrbkkreiSgPcQ41M3Nr0e58g6fp/muVwKqDf08dgtSXQAyjPizG
         hGI8SixUm54KV0i3Te0GqfwrCESpqwJhY9xD/Dzac6HgxaeEZtM/zp9F1eav++t0MfJB
         tIx0hSils6iRM8yFKnum3pDlkf+nk57RCM3Izr3ReoA9+cluNFL3y04seULUFHeY3VbP
         UCOg==
X-Gm-Message-State: AGRZ1gJa8emNZoWnK99AHC4kERnTG5fv88ylm/NPVk4zRDBfGy1CiuhW
        I8grc4lQU8Pza+78X8lU1sts5MYewj0=
X-Google-Smtp-Source: AJdET5fftAyutvzSBzDtHo4ZV/bDrto8yF9IP/ilF708ssSAyNtewqrKzyjevRHC6he+Ev+XorPC9Q==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr17033512lfj.83.1541542107827;
        Tue, 06 Nov 2018 14:08:27 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:27 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 24/24] leds: an30259a: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:32 +0100
Message-Id: <1541542052-10081-25-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Simon Shields <simon@lineageos.org>
---
 drivers/leds/leds-an30259a.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 1c1f0c8..d714ee8 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
-#include <uapi/linux/uleds.h>
 
 #define AN30259A_MAX_LEDS 3
 
@@ -54,6 +53,8 @@
 #define AN30259A_BLINK_MAX_TIME 7500 /* ms */
 #define AN30259A_SLOPE_RESOLUTION 500 /* ms */
 
+#define AN30259A_NAME "an30259a"
+
 #define STATE_OFF 0
 #define STATE_KEEP 1
 #define STATE_ON 2
@@ -62,11 +63,11 @@ struct an30259a;
 
 struct an30259a_led {
 	struct an30259a *chip;
+	struct fwnode_handle *fwnode;
 	struct led_classdev cdev;
 	u32 num;
 	u32 default_state;
 	bool sloping;
-	char label[LED_MAX_NAME_SIZE];
 };
 
 struct an30259a {
@@ -226,14 +227,7 @@ static int an30259a_dt_init(struct i2c_client *client,
 
 		led->num = source;
 		led->chip = chip;
-
-		if (of_property_read_string(child, "label", &str))
-			snprintf(led->label, sizeof(led->label), "an30259a::");
-		else
-			snprintf(led->label, sizeof(led->label), "an30259a:%s",
-				 str);
-
-		led->cdev.name = led->label;
+		led->fwnode = of_fwnode_handle(child);
 
 		if (!of_property_read_string(child, "default-state", &str)) {
 			if (!strcmp(str, "on"))
@@ -312,13 +306,21 @@ static int an30259a_probe(struct i2c_client *client)
 	chip->regmap = devm_regmap_init_i2c(client, &an30259a_regmap_config);
 
 	for (i = 0; i < chip->num_leds; i++) {
+		struct led_init_data init_data = { chip->leds[i].fwnode };
+
+		int ret = led_compose_name(init_data.fwnode, AN30259A_NAME, ":",
+					   init_data.name);
+		if (ret)
+			return ret;
+
 		an30259a_init_default_state(&chip->leds[i]);
 		chip->leds[i].cdev.brightness_set_blocking =
 			an30259a_brightness_set;
 		chip->leds[i].cdev.blink_set = an30259a_blink_set;
 
-		err = devm_led_classdev_register(&client->dev,
-						 &chip->leds[i].cdev);
+		err = devm_led_classdev_register_ext(&client->dev,
+						 &chip->leds[i].cdev,
+						 &init_data);
 		if (err < 0)
 			goto exit;
 	}
-- 
2.1.4

