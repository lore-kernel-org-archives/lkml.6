Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F9ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF855214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHRCST8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF855214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIQXor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:44:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45388 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbeIQXoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:44:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so7921986pfo.12;
        Mon, 17 Sep 2018 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HazVNGD9t6FfNvcp88ZRO3a2sLfWT0t9gqSYYowwjIc=;
        b=fHRCST8y8fiCjUuF8LMaFMwcxAnNCySikGe+6L1wyBsEQHsa0tjYmI0h789VRHGw7y
         5/8aFQW9KRuX1L06zWZiFuNHqRMz9slhFuRqedmTQHcDNajrqxe7h9OQkubn6by/UVvo
         hp3FCZpmAZyCEqcHMx8q7gGoFcmygEFrigh1MAWZC+f5d+k6rrM9iLq/Cxd0QzJfg5ta
         zrRvZhwgXsBCRyhMRlYClEt/Rg79vrfa7SqP08OLQryA8RoGL1uEIObr0SicZ3jCURJe
         0q5RVEkStEskHrxpRp50ShWnUywFw2OTnc+Ewr2ZCKTw1Zi8Dj1hzqJnF9yuey2xMpCt
         PzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HazVNGD9t6FfNvcp88ZRO3a2sLfWT0t9gqSYYowwjIc=;
        b=njSBjWdlq1s+hAzQkM7OYeat4KUnKY4oi5EPspoHQxTffDQ/6Z5kriWYvS5qQ44t91
         XucbgjXIrw1VbuTxEFw2Ag/5T4IKP/Auf1weMZkRAuDrl1e9UuEQsHPozo4PiSQ9MW9Q
         K6WB3ZQaXy3f/fYo3nn4cW3K6w2lpPx8Two/wN/5dlIRcR6bf2SF7sbAUpe34PxttEDv
         nUenC1xMtAd0Lnn2vaj53cuXbFlaazfuCIOFd1FI7pFsPopp5feUicBnsohOW+wG+0Yc
         cVzfUD1JxjJEfHlo+3aS53zfYXwnELrcmRn3IDOPEGA0GGeTId3cMAbKgwkfPIjyQxld
         vrQA==
X-Gm-Message-State: APzg51B5MtbVrbyONOjyu8QEDdV7mHKjpNyuF2hBdWpSxZVnIUI54pAL
        qig0aPO8yU3nUzsV+/7sR1U=
X-Google-Smtp-Source: ANB0VdaTmM5ZIMl0DBUv9NjUnOD4oXlKnFz8JTWC14Tijnm2wF4kc2rBUIw+nkUzHqrC2qVRu+4bzw==
X-Received: by 2002:a63:d70e:: with SMTP id d14-v6mr24867555pgg.110.1537208176009;
        Mon, 17 Sep 2018 11:16:16 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 74-v6sm24076366pfv.33.2018.09.17.11.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:16:14 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC/PATCH 5/5] RFC: ARM: simone: Hacked in keys
Date:   Mon, 17 Sep 2018 11:16:03 -0700
Message-Id: <20180917181603.125492-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This serves as an illustration of how to use the gpio-keys
in board files using static device properties and machine GPIO descriptor
tables.

It is a hack for the joystick connector on the entirely
boardfile-based SIM.ONE. It will probably not be applied.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-ep93xx/simone.c | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 41aa57581356..b998d6772158 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -24,7 +24,11 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/property.h>
 
 #include <mach/hardware.h>
 #include <mach/gpio-ep93xx.h>
@@ -34,6 +38,47 @@
 
 #include "soc.h"
 
+static const struct property_entry simone_key_enter_props[] __initconst = {
+	PROPERTY_ENTRY_U32("linux,code",	KEY_ENTER),
+	PROPERTY_ENTRY_STRING("label",		"enter"),
+	PROPERTY_ENTRY_STRING("gpios",		"enter-gpios"),
+	{ }
+};
+
+static const struct property_entry simone_key_up_props[] __initconst = {
+	PROPERTY_ENTRY_U32("linux,code",	KEY_UP),
+	PROPERTY_ENTRY_STRING("label",		"up"),
+	PROPERTY_ENTRY_STRING("gpios",		"up-gpios"),
+	{ }
+};
+
+static const struct property_entry simone_key_up_props[] __initconst = {
+	PROPERTY_ENTRY_U32("linux,code",	KEY_LEFT),
+	PROPERTY_ENTRY_STRING("label",		"left"),
+	PROPERTY_ENTRY_STRING("gpios",		"left-gpios"),
+	{ }
+};
+
+static const struct property_entry simone_key_props[] __initconst = {
+	/* There are no properties at device level on this device */
+	{ }
+};
+
+static struct gpiod_lookup_table simone_keys_gpiod_table = {
+	.dev_id = "gpio-keys",
+	.table = {
+		/* Use local offsets on gpiochip/port "B" */
+		GPIO_LOOKUP_IDX("B", 0, "enter-gpios", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("B", 1, "up-gpios", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("B", 2, "left-gpios", 2, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct platform_device simone_keys_device = {
+	.name = "gpio-keys",
+	.id = -1,
+};
+
 static struct ep93xx_eth_data __initdata simone_eth_data = {
 	.phy_id		= 1,
 };
@@ -107,6 +152,21 @@ static void __init simone_init_machine(void)
 			    ARRAY_SIZE(simone_i2c_board_info));
 	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
 			    ARRAY_SIZE(simone_spi_devices));
+
+	gpiod_add_lookup_table(&simone_keys_gpiod_table);
+	device_add_properties(&simone_keys_device.dev,
+			      simone_keys_device_props);
+	device_add_child_properties(&simone_keys_device.dev,
+				    dev_fwnode(&simone_keys_device.dev),
+				    simone_key_enter_props);
+	device_add_child_properties(&simone_keys_device.dev,
+				    dev_fwnode(&simone_keys_device.dev),
+				    simone_key_up_props);
+	device_add_child_properties(&simone_keys_device.dev,
+				    dev_fwnode(&simone_keys_device.dev),
+				    simone_key_left_props);
+	platform_device_register(&simone_keys_device);
+
 	simone_register_audio();
 }
 
-- 
2.19.0.397.gdd90340f6a-goog

