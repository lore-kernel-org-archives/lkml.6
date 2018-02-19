Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeBSQHa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:07:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55151 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeBSQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:07:29 -0500
X-Google-Smtp-Source: AH8x2255bizg4wvcu6Ajv8ZyGekyn189GVNUKPL3U+X2E/z1lYkuKi/ANtMCCU4eJ1z0WxNtaIJ2IQ==
Date: Mon, 19 Feb 2018 17:07:17 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: linux-kernel@vger.kernel.org, paul.burton@mips.com
Subject: [PATCH 2/3] auxdisplay: img-ascii-lcd: Fix doc comment to silence
 warnings
Message-ID: <20180219160717.3jp7kzemb7hbhakx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with W=1 with gcc 7.2.0 gives 2 warnings:

  drivers/auxdisplay/img-ascii-lcd.c:233: warning: Function parameter or
  member 't' not described in 'img_ascii_lcd_scroll'
  drivers/auxdisplay/img-ascii-lcd.c:233: warning: Excess function
  parameter 'arg' description in 'img_ascii_lcd_scroll'

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
I saw this while fixing the ones reported by the build service.
I will queue it up for 4.17.

drivers/auxdisplay/img-ascii-lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 9180b9bd5821..d8133024fd5d 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -224,7 +224,7 @@ MODULE_DEVICE_TABLE(of, img_ascii_lcd_matches);
 
 /**
  * img_ascii_lcd_scroll() - scroll the display by a character
- * @arg: really a pointer to the private data structure
+ * @t: really a pointer to the private data structure
  *
  * Scroll the current message along the LCD by one character, rearming the
  * timer if required.
-- 
2.14.1
