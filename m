Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE78C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA9621570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="hsWkxJmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA9621570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeI0PIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38684 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeI0PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so1410937pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iBc/SOI345QfGxvKdfvkTT+7P+THgElx/Kz0O2jep8E=;
        b=hsWkxJmEc8nb065d+Md/1f9dww/VL5fh1JqJomdQUpOoTfXdw8CjKpdT3ItZbrhu0n
         nGoxqbRlOwOrKunZOnKOL9nG60bX+8OJYrZ4Hh/bR4SAUR6Q9jCJpMXODkpzgJ7UgnBR
         mEsiK9SS1c9ifkWWh8ZVeygcWP1zAOMWI0RRw6naR1i+kk28pSKwZNQKTWcrVELTYdeT
         KXxxh9vSHyQn9oEf3+5leCcB0ekZiFIluovUj1y3iykGiCq4FYc27kjxnq68HdayvWJP
         UhUsanhIAI7mRZAoJbHT5BWUliBeV3Hvq17bMqWhTh9eobhWWGkldM7JA/ac1Z5eoVz8
         gGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iBc/SOI345QfGxvKdfvkTT+7P+THgElx/Kz0O2jep8E=;
        b=sJN2OWkrRUmx/iT7SZJwCy2rB1T6y29dN9qYCLkjlxnC+fHGtFNdOmvRVL7y3IW86B
         MjeIIwVkQ8NnX2Tzhhns+X15u4a7ehO68H4bCmqpifRyMY5DH7PFQy5s1whPet7OYlAK
         s5mF+kD5/A0G8TkbWKyUOyf40l4qY16bsvmXwXvQd0nJqf4V3UtlCjLnTUYPrCEUa+IG
         l1mCksfgoJjXYtka/fUozIh2qulFgPnsvFIaalUX2ypDMMi/GSpPh8NRXPtKLViPZbSL
         sZqx8lHmQKlVpefEnQFRo0MfTbsymUKPtZJpg/vVnIYBS39+e86cTfytLQL04Ijux5Je
         zlUg==
X-Gm-Message-State: ABuFfogOPSP9jDEJzESZRSvd6nkZ7LxQFmUjFpa1/o7y8Dw/bg8XsLoT
        jjCGpvSQAQZjuRi0o0N7lAS8Zg==
X-Google-Smtp-Source: ACcGV61Y+SYRLeTsHN4EGaEMW0VH5vRV/hZ2Zf2ZBJrIJGEHULr4x1cU6xd69C2UtZVoHbigoaCNCw==
X-Received: by 2002:a63:574c:: with SMTP id h12-v6mr9215162pgm.423.1538038291225;
        Thu, 27 Sep 2018 01:51:31 -0700 (PDT)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id b64-v6sm2330188pfg.66.2018.09.27.01.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:30 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] platform/x86: asus-wmi: Simplify the keyboard brightness updating process
Date:   Thu, 27 Sep 2018 16:50:09 +0800
Message-Id: <20180927085009.4190-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180816084104.434-1-jian-hong@endlessm.com>
References: <20180816084104.434-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original asus-wmi queues a work which calls the ACPI/WMI methods to
update the keyboard LED brightness.  Similar drivers - acer-wmi,
dell-wmi-led just call the ACPI/WMI methods directly without workqueues.

This patch simplifies the keyboard brightness updating process which
calls the kbd_led_update function directly without workqueue in
asus-wmi.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2d6e272315a8..9441cce636e6 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -239,7 +239,6 @@ struct asus_wmi {
 	int lightbar_led_wk;
 	struct workqueue_struct *led_workqueue;
 	struct work_struct tpd_led_work;
-	struct work_struct kbd_led_work;
 	struct work_struct wlan_led_work;
 	struct work_struct lightbar_led_work;
 
@@ -456,12 +455,9 @@ static enum led_brightness tpd_led_get(struct led_classdev *led_cdev)
 	return read_tpd_led_state(asus);
 }
 
-static void kbd_led_update(struct work_struct *work)
+static void kbd_led_update(struct asus_wmi *asus)
 {
 	int ctrl_param = 0;
-	struct asus_wmi *asus;
-
-	asus = container_of(work, struct asus_wmi, kbd_led_work);
 
 	/*
 	 * bits 0-2: level
@@ -516,7 +512,7 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
 		value = 0;
 
 	asus->kbd_led_wk = value;
-	queue_work(asus->led_workqueue, &asus->kbd_led_work);
+	kbd_led_update(asus);
 }
 
 static void kbd_led_set(struct led_classdev *led_cdev,
@@ -671,8 +667,6 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 
 	led_val = kbd_led_read(asus, NULL, NULL);
 	if (led_val >= 0) {
-		INIT_WORK(&asus->kbd_led_work, kbd_led_update);
-
 		asus->kbd_led_wk = led_val;
 		asus->kbd_led.name = "asus::kbd_backlight";
 		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
@@ -2310,7 +2304,7 @@ static int asus_hotk_resume(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
-		queue_work(asus->led_workqueue, &asus->kbd_led_work);
+		kbd_led_update(asus);
 
 	return 0;
 }
@@ -2346,7 +2340,7 @@ static int asus_hotk_restore(struct device *device)
 		rfkill_set_sw_state(asus->uwb.rfkill, bl);
 	}
 	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
-		queue_work(asus->led_workqueue, &asus->kbd_led_work);
+		kbd_led_update(asus);
 
 	return 0;
 }
-- 
2.11.0

