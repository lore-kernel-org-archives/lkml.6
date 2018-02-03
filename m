Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeBCUSU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:18:20 -0500
Received: from mout.web.de ([217.72.192.78]:59901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753426AbeBCUSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:18:13 -0500
Subject: [PATCH 1/2] HID: picoLCD: Delete an error message for a failed memory
 allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Message-ID: <59255454-a570-14a3-16dc-6a800283043f@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:18:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:F0bZgrk9bc3hs9gdrfBFjS81LL8VuR7jJatGWE7W47qPozT0aT6
 nujReo/DoZDnX5KwbGpnQTvOMU83/xIM6j/N1fgD5rQiJZ9NJDRss7UN3UZOfrNEY1IKg42
 mEO0qMfUu9TATtgp2z46mNuJJN3lDnMFKPzzJljgdr4HRwT9Vegy14RvFKYfHPexHxCnb0b
 H9MdSJV8sXLtmWqdTdCkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:56I5yQ/smU4=:+5XwaMMYTE8Q4xgDrqOmGk
 iPzWUpXdSUnmQkxB1qQhKubD4Km6G2njAbzlvwQXdhb0FKXcRwXCPXsEDGUq6BNjpEqNPh3z0
 w0owooeVKPLIUP0yBtzexVxUsWqmDq+awyCiYmbjymVqtENXkLwiOV4x7yiSUXBPuBO9jfYda
 7MsJYwQd2TPIqJxUzaTWKdjHNlgqSUPOLDJh6Uew3idkr3NmxmAEKFC4T/26+iNdiiPhfsHfU
 9VZlg8qEF6jLnJ6hzdHhcIbmIm+tJ2qeTs7BrXMjF0SVwl3rfRKveZWSvN9Q5+yuVc/pWU+AM
 a3MO1opRY1UY3d/oBoVtcQ6gK4hd6/nndqEM1hJO2e6HHaCeLqR2rQKLYhW4OBWDFQqrip/Ia
 9m6tVxE6n4PVk5Is9p3ZXYocva/vwyznwOzTr4YEsOMh7D5j6/SbeM4ad+KDxAb//Zq68VPS9
 A2muiKT6l+/kVnNiGLeU3J2LOyjez2Xoae1u8+G+SZY5cw4Ch/9dtcadLdkMns+F1Lf5AVeSS
 heuyW5/WDVW6/jtOjJLkinkKrENW2RNqhuuoNw7OkdC24buVlOAim1AaoHkzbS9xmLNIrEsJa
 djsPXrCdTMWgx/kxjuYBXH4gybT5QF5qOonyz2QndDCsbZ2KkbQflNRtI0n3nYosywdpFEyfz
 r6rtagyUY161LLtEp7A6xM93gJ98+bwfpSjpu+dkR5F7aVKciTGYy3kwW/Mye7/seFLZnYbfO
 YXgs3snLL7V9j/htIxyMNv77/JnQfWxSiE1Dsn5WjqANfPOovAKvTkf3lKl7mHlMn7TxXXuAT
 eD9PUtDvHWvbmecqKQHiCeAg0sqkq15YVjiB4R+tXWQcUNTb5U=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:00:37 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-picolcd_core.c | 1 -
 drivers/hid/hid-picolcd_fb.c   | 5 ++---
 drivers/hid/hid-picolcd_leds.c | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index c1b29a9eb41a..5dc48ecc1b98 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -549,7 +549,6 @@ static int picolcd_probe(struct hid_device *hdev,
 	 */
 	data = kzalloc(sizeof(struct picolcd_data), GFP_KERNEL);
 	if (data == NULL) {
-		hid_err(hdev, "can't allocate space for Minibox PicoLCD device data\n");
 		error = -ENOMEM;
 		goto err_no_cleanup;
 	}
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 7f965e231433..5fb0b67b8d59 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -548,10 +548,9 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
 	fbdata->force   = 1;
 	fbdata->vbitmap = info->par + sizeof(struct picolcd_fb_data);
 	fbdata->bitmap  = vmalloc(PICOLCDFB_SIZE*8);
-	if (fbdata->bitmap == NULL) {
-		dev_err(dev, "can't get a free page for framebuffer\n");
+	if (!fbdata->bitmap)
 		goto err_nomem;
-	}
+
 	info->screen_base = (char __force __iomem *)fbdata->bitmap;
 	info->fix.smem_start = (unsigned long)fbdata->bitmap;
 	memset(fbdata->vbitmap, 0xff, PICOLCDFB_SIZE);
diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index a802b4f49c7b..871cad90730a 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -122,7 +122,6 @@ int picolcd_init_leds(struct picolcd_data *data, struct hid_report *report)
 	for (i = 0; i < 8; i++) {
 		led = kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
 		if (!led) {
-			dev_err(dev, "can't allocate memory for LED %d\n", i);
 			ret = -ENOMEM;
 			goto err;
 		}
-- 
2.16.1
