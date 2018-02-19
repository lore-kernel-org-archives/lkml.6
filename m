Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeBSQGK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:06:10 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37598 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeBSQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:06:09 -0500
X-Google-Smtp-Source: AH8x2242RLtFfuPYb0uM2AChsUvcPYD9we5QV2EZzx6SQ+T0rzqTd0igqPyUJKrYdhA5EjYCuNA2zw==
Date: Mon, 19 Feb 2018 17:05:37 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: linux-kernel@vger.kernel.org, w@1wt.eu, geert@linux-m68k.org
Subject: [PATCH 1/3] auxdisplay: panel: Change comments to silence
 fallthrough warnings
Message-ID: <20180219160537.rwmlmnsg6xpbp6o7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with W=1 with gcc 7.2.0 gives 3 warnings like:

  drivers/auxdisplay/panel.c: In function ‘panel_process_inputs’:
  drivers/auxdisplay/panel.c:1374:17: warning: this statement may fall
  through [-Wimplicit-fallthrough=]

Cc: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
I saw this while fixing the ones reported by the build service.
I will queue it up for 4.17.

 drivers/auxdisplay/panel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index ea7869c0d7f9..b7bb118f1497 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1372,7 +1372,7 @@ static void panel_process_inputs(void)
 				break;
 			input->rise_timer = 0;
 			input->state = INPUT_ST_RISING;
-			/* no break here, fall through */
+			/* fallthrough */
 		case INPUT_ST_RISING:
 			if ((phys_curr & input->mask) != input->value) {
 				input->state = INPUT_ST_LOW;
@@ -1385,11 +1385,11 @@ static void panel_process_inputs(void)
 			}
 			input->high_timer = 0;
 			input->state = INPUT_ST_HIGH;
-			/* no break here, fall through */
+			/* fallthrough */
 		case INPUT_ST_HIGH:
 			if (input_state_high(input))
 				break;
-			/* no break here, fall through */
+			/* fallthrough */
 		case INPUT_ST_FALLING:
 			input_state_falling(input);
 		}
-- 
2.14.1
