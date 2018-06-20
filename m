Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3479DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E4220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="xpmGpM6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E4220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbeFTOrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:47:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33893 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754110AbeFTOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:47:11 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so1899041plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PAbpvTw1BYnoBJe19FGpiZx+XHaIgMEVDhT0LlBYPw=;
        b=xpmGpM6fUEIq1D8hOhi4ZkndxwC0AQXQt//gVyT1ff3E9aKVbcRjmiQJW5s2eUfmO2
         QYPuBAcAYds6cFSTnU4xZXCvbJMKQNDt6uRIqmQvOMLj3d2aZfBD6Y9TINXI0/Oo/0Te
         v65qfA/zLio3rGIBhBt5mRDiLPrgVIYz+Q1sZ5hW0YP81xB5UGeUrWlYd5L7LKf6tY41
         oBIiELiZNoV3mde8mY2MhU6GHtn1Z1QQ4IvieOcGarrLhlwg02MLwPUwZ3Wl/mfDGHK0
         mix2EhKnpfoZYxaJpVFC3p9Wj+R1DlGrsqS7bGUNjxjR8qzhYBU54Tn5WqKP493FYkFx
         p6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PAbpvTw1BYnoBJe19FGpiZx+XHaIgMEVDhT0LlBYPw=;
        b=WY0YoZ6je39yqv6sANr4fqvMcEnuqu2VEJeqKtxtrVbfNS61Myoaq7W7A0hXJwvjr8
         Og+/+aGLzAjzGPQAU8KSLEUHGG7do/ckadM4UO77fqAmZQy3GI8JWK7VguJPW5qSI6H2
         QJe5SEGHaE1X2pNKCGQQA0CwkjnB1QEvh8bv5nldCMJfiZhPuqLNuh0UNSGn3hGsSQzn
         Yn1VfCzKvSnj1upbjePVMW+4dApprCzgj/4920hiQfOUyShVAJJpaEORUQPp0QaInImg
         tI6gwsNLPaGSPzX25aDrgdwI3y7NHHi7dGIWXQVrbNZXzeqnJ4MlytPbSeXyn5IfAlSV
         Xccg==
X-Gm-Message-State: APt69E0ZQnoJvdUkaMKkyJMDTpMjNuSWRneEstleBXFlSKmYPN3gK0io
        heYiIlu4z/jZRqypX50BkFyUAw==
X-Google-Smtp-Source: ADUXVKLdV/DLIPXVGXhI6GB/EZGXxxkR1kjvla+G/t76loqrlZbc62cG8XqJglSn35AgrM87wWCwww==
X-Received: by 2002:a17:902:8341:: with SMTP id z1-v6mr24409795pln.40.1529506030292;
        Wed, 20 Jun 2018 07:47:10 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id w7-v6sm3029398pgr.82.2018.06.20.07.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 07:47:09 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     corentin.chary@gmail.com, dvhart@infradead.org,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v3 2/2] platform/x86: asus-wmi: Add keyboard backlight toggle support
Date:   Wed, 20 Jun 2018 22:46:45 +0800
Message-Id: <20180620144645.2084-2-chiu@endlessm.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180620144645.2084-1-chiu@endlessm.com>
References: <20180620144645.2084-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ASUS laptops like UX550GE has hotkey (Fn+F7) for keyboard
backlight toggle which would emit the scan code 0xc7 each keypress.
On the UX550GE, the max keyboard brightness level is 3 so the
toggle would not be simply on/off the led but need to be cyclic.
Per ASUS spec, it should increment the brightness for each keypress,
then toggle(off) the LED when it already reached the max level.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f2b9037f6ded..51dc019fa91d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -67,6 +67,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_BRNDOWN_MAX		0x2e
 #define NOTIFY_KBD_BRTUP		0xc4
 #define NOTIFY_KBD_BRTDWN		0xc5
+#define NOTIFY_KBD_BRTTOGGLE		0xc7
 
 /* WMI Methods */
 #define ASUS_WMI_METHODID_SPEC	        0x43455053 /* BIOS SPECification */
@@ -1762,6 +1763,13 @@ static void asus_wmi_notify(u32 value, void *context)
 		do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
 		goto exit;
 	}
+	if (code == NOTIFY_KBD_BRTTOGGLE) {
+		if (asus->kbd_led_wk == asus->kbd_led.max_brightness)
+			do_kbd_led_set(&asus->kbd_led, 0);
+		else
+			do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
+		goto exit;
+	}
 
 	if (is_display_toggle(code) &&
 	    asus->driver->quirks->no_display_toggle)
-- 
2.11.0

