Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965494AbeCACdR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:33:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965468AbeCACdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:33:16 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] auxdisplay: fix broken menu
To: LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <62ac821e-290a-6b7c-ef6e-9c5e4c49de36@infradead.org>
Date: Wed, 28 Feb 2018 18:33:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Having the CHARLCD Kconfig symbol between "menuconfig AUXDISPLAY"
and "if AUXDISPLAY" breaks the AUXDISPLAY submenus, so move the
CHARLCD Kconfig symbol near the end of the file so that the menu
display is continuous.

Also include ARM_CHARLCD inside of the if AUXDISPLAY/endif block.
Geert says that it should be there.

Fixes: 39f8ea46724e ("auxdisplay: charlcd: Extract character LCD core from misc/panel")

Cc: stable@vger.kernel.org # v4.12
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/auxdisplay/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20180228.orig/drivers/auxdisplay/Kconfig
+++ linux-next-20180228/drivers/auxdisplay/Kconfig
@@ -14,9 +14,6 @@ menuconfig AUXDISPLAY
 
 	  If you say N, all options in this submenu will be skipped and disabled.
 
-config CHARLCD
-	tristate "Character LCD core support" if COMPILE_TEST
-
 if AUXDISPLAY
 
 config HD44780
@@ -157,8 +154,6 @@ config HT16K33
 	  Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
 	  LED controller driver with keyscan.
 
-endif # AUXDISPLAY
-
 config ARM_CHARLCD
 	bool "ARM Ltd. Character LCD Driver"
 	depends on PLAT_VERSATILE
@@ -169,6 +164,8 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
 
+endif # AUXDISPLAY
+
 config PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
@@ -448,3 +445,6 @@ config PANEL_BOOT_MESSAGE
 	  printf()-formatted message is valid with newline and escape codes.
 
 endif # PANEL
+
+config CHARLCD
+	tristate "Character LCD core support" if COMPILE_TEST
