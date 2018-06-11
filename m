Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id smyfOtghHluyWgAAmS7hNA
	; Mon, 11 Jun 2018 07:18:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B771E607A4; Mon, 11 Jun 2018 07:18:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ZXGnvohn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F10860385;
	Mon, 11 Jun 2018 07:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F10860385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeFKHSx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:18:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39329 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbeFKHSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:18:51 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so11806872plt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VFI3XHE7sXwJCC9HPXBJTtkLBfmxzRFUKjmMAyho8jQ=;
        b=ZXGnvohnHAqYWPgBXpZr4UJElJXRMJ6NNEudhK/paULF5/rpEQrh7rqSiCrX7mGV4T
         GEdj4gCiq7yWfc/BOe7MZKrKKhzJ0eL30fUXtJ/O3IHQPdDEQF4dYgyyLO+DaH67ja7Y
         v6eif073acW6p1unmJvk8cCN+R0pxWFFu1yiAB2+f5AeewZXL68Ols+dyoISYvLuILjn
         9d0EV+HcHgYnpnuEPjOkKtGQPGpi7RtTZfPeM4nMChyyrXuSE/IcNpD77tjtXOfctYxr
         BHT73LRyVt3btFTLKbswscL2vfM3cvzI4agQhpS26TQWWVUIjCeeqSCs5ZEjdJh8layR
         vcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VFI3XHE7sXwJCC9HPXBJTtkLBfmxzRFUKjmMAyho8jQ=;
        b=Fk/pw3HmMlZ/e8k3R/LzmSinHrqUFcMNkiPYtXwL3NWM4wrUPxGXNCyiTz5oCzG7gL
         or6TZ4EHxLcdM1EvR7oZC7AXP6cgvED6BHjFub6c5jYU87Q6Q1AcjbRM/H4s4eU3nRKb
         5VDNuPFaTFp78KMPS7jg5El4YVV8P6Hq0dlckOYFKjiREzfIZkdY/KB4xG/v0GZ/lADr
         3bdc87wQVdQB0i1ZiMWoIFzaR53g5jvEyJEYUKM/N4VP1cuslQsQ0u+RJIRoaksYKWo9
         fKrizyPpFmUMMnnMznLUFsVQlUMcYS5qKWmKU4wnerPNoiL0LAbbL4nLCSCjnIcoG0rD
         3z6Q==
X-Gm-Message-State: APt69E18Ak5DL+gwLFLXS5LLokybsuxP6za4zDaGLDR+xogWWN6v6zaW
        CLKertIy/jYdV6S2+rCRr5E4mWdd
X-Google-Smtp-Source: ADUXVKKmKOFn+KHUqbPG60fAvvWmxbAeIxh41jacxVnaxLGOqViLU8GCq1YwsgicUpWURHPXzBugEg==
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr17309275plf.47.1528701531174;
        Mon, 11 Jun 2018 00:18:51 -0700 (PDT)
Received: from localhost.localdomain (114-26-212-90.dynamic-ip.hinet.net. [114.26.212.90])
        by smtp.gmail.com with ESMTPSA id t13-v6sm30349692pgv.43.2018.06.11.00.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 00:18:50 -0700 (PDT)
From: Chris Chiu <chiu@endlessm.com>
To: corentin.chary@gmail.com, dvhart@infradead.org,
        andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on kbd brightness change
Date: Mon, 11 Jun 2018 15:18:37 +0800
Message-Id: <20180611071838.47945-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make asus-wmi notify on hotkey kbd brightness changes, listen for
brightness events and update the brightness directly in the driver.
For this purpose, bound check on brightness in kbd_led_set must be
based on the same data type to prevent illegal value been set.

Update the brightness by led_classdev_notify_brightness_hw_changed.
This will allow userspace to monitor (poll) for brightness changes
on the LED without reporting via input keymapping.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1f6e68f0b646..a18484f4bae3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -460,6 +460,7 @@ static void kbd_led_update(struct work_struct *work)
 		ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
 
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
+	led_classdev_notify_brightness_hw_changed(&asus->kbd_led, asus->kbd_led_wk);
 }
 
 static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
@@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
 
 	asus = container_of(led_cdev, struct asus_wmi, kbd_led);
 
-	if (value > asus->kbd_led.max_brightness)
+	if ((int)value > (int)asus->kbd_led.max_brightness)
 		value = asus->kbd_led.max_brightness;
-	else if (value < 0)
+	else if ((int)value < 0)
 		value = 0;
 
 	asus->kbd_led_wk = value;
@@ -656,6 +657,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 
 		asus->kbd_led_wk = led_val;
 		asus->kbd_led.name = "asus::kbd_backlight";
+		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
 		asus->kbd_led.brightness_set = kbd_led_set;
 		asus->kbd_led.brightness_get = kbd_led_get;
 		asus->kbd_led.max_brightness = 3;
@@ -1745,6 +1747,15 @@ static void asus_wmi_notify(u32 value, void *context)
 		}
 	}
 
+	if (code == NOTIFY_KBD_BRTUP) {
+		kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
+		goto exit;
+	}
+	if (code == NOTIFY_KBD_BRTDWN) {
+		kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
+		goto exit;
+	}
+
 	if (is_display_toggle(code) &&
 	    asus->driver->quirks->no_display_toggle)
 		goto exit;
-- 
2.11.0
