Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E380F20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="wNmHVnd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E380F20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbeHPLiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:38:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35318 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbeHPLiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:38:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10-v6so1748018pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=y4PHHWGgb1VEd7a2iwknInHmrtvQEkgYTSsBpz46itk=;
        b=wNmHVnd+hfrXlxYublfv05BoJ+PMY/A9K32iXbRNdfumiwxpmhn7L8LACfDfSg5+lH
         5O1LjccI2c5LGnYv8dQyZevbkz4xg9jnUq1f6IJP/mU8T1Kql0ZT/n9q8vq7qWmT12x7
         jv/1dXgOPK91CJ6DT7bz5o0AIsjAy2KTsHYOkm4LWbDVeLO/ifaYJaHqOb1tNnk7EYlE
         GM7zvlIWMKrpZGJlwRWojncbISng6VnBePdqvFjZY/jnOeuPTjV0aKYk3gdqr9iU2C/Z
         MF15mgHBcdgMPk/bJ1c6c6sBOcGJRZNynfB9ercTZG1gWcURtLkcWIwlkqFiA2oMG1/x
         WscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4PHHWGgb1VEd7a2iwknInHmrtvQEkgYTSsBpz46itk=;
        b=oMnqNDyhJBw4af+9YVM8IziM58FEyouVVdMM8RRH9fU59MnbY1rtJT7Kta2ymHoJEP
         amesksoDFwol7RC/Do8vCyWtlSpJ1Ex22S+Bhxz2zETqEvxlbSLVHffFs04YUhWAps+Q
         o7FIHNI/ZV4JlBoNid6DWGdKA9hBpnkoh/KFjyEd9nH8J6mVp4+myMzN+M1H8Wg2XOZk
         X3hPiFPslUOKVPQEiDz/uV5WVcvFPG0oduvMBW4G+bJrF8Tlc/w9pYoVYMTzVZfUD/aW
         /0k9OL6LPxWY9GsMFXheqhxjJDKpVM13ygRHwfCzt6YuOjH58sGxPrC4c55wEYrCDFT7
         EPhw==
X-Gm-Message-State: AOUpUlGI1nKR08qmKtpF4pxU52yIh3X6phR0/Nln1GikiY8Ha3p+alqa
        pNkOnwQ28CaAE40TE+5DNl3QlQ==
X-Google-Smtp-Source: AA+uWPykkCEkUtsSI5hZwZQLOLXUrMg4pDfbKwT5gcutgLe1YKh3V/2ZzAvi3oOxckYOuXXdMZFIbg==
X-Received: by 2002:a63:77ce:: with SMTP id s197-v6mr404142pgc.172.1534408881864;
        Thu, 16 Aug 2018 01:41:21 -0700 (PDT)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id 14-v6sm50643046pft.93.2018.08.16.01.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 01:41:21 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [RFC PATCH] platform/x86: asus-wmi: Simplify the keyboard brightness updating process
Date:   Thu, 16 Aug 2018 16:41:04 +0800
Message-Id: <20180816084104.434-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
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
index 34dcc1aac4ea..d3d500851a7a 100644
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
@@ -2314,7 +2308,7 @@ static int asus_hotk_resume(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
-		queue_work(asus->led_workqueue, &asus->kbd_led_work);
+		kbd_led_update(asus);
 
 	return 0;
 }
@@ -2350,7 +2344,7 @@ static int asus_hotk_restore(struct device *device)
 		rfkill_set_sw_state(asus->uwb.rfkill, bl);
 	}
 	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
-		queue_work(asus->led_workqueue, &asus->kbd_led_work);
+		kbd_led_update(asus);
 
 	return 0;
 }
-- 
2.11.0

