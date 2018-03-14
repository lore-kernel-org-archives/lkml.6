Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeCNPpB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:45:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeCNPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:44:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org
Subject: [PATCH 21/47] media: platform: remove m32r specific arv driver
Date: Wed, 14 Mar 2018 16:35:34 +0100
Message-Id: <20180314153603.3127932-22-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:djlz6B5A35Usy7EZPRiGX42/L5rU/KR95nT4dQRi5QtfRg9dnOX
 xYy9xF3+qN9vqjmZdrIHpvoBJSra7VIwU3O+HyfI9wPVMB0nL7IpY0Jtn9H9Qpl6Ua6QGj9
 05xzjElCHtP33e+S0G9qaNtpbVtwlpo/coNfXlBtTtPRNbBRXmMWgNSN9Vhg4LMU7lOvgLj
 npuKyg3VfKAnaXwUAy2MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/j7Eu0kl6cU=:egvfVOkDd1hq71nrJT5kK0
 I7UAeRVyDWM03ehqFiIIGcIBeynZVC0NRjrkayjQUCeRHPgJZUTi7F38F3VTU6YLVtZM3w+uL
 0LSm33NX9z8hKpC4qjOm8bODwXWfpjDpEwypNXjbTW/VUEvzmjkS+0yFjp1Brkfenlo3SwXo2
 9U/rrTOIrmTLxz/NSMZdgI9T6wd6OnXuppQ2pvYnXA/Rk4Z7CbcHMaACUL3pSQmCDLWMDGr+q
 /TGY2/5bXw0iUyzbdK8ay7AUGX9EBuz4OxLpNWMj6lnMswPFHXjO4+iX12jMmF+sAoPNiHAJ1
 irWC7ryA8zOzjsTSYVKMvGAHVOveqPMREfJglJ9y9ieHn7CMjUW2Iko5PPCG+/u8PYfc5WXlq
 pbNPl5c0IXvJWUAHIHsa5HYmWJevmyJ6evP1CW3T08G4sAMzBuZeRJbgR5vHi0VVP6srKRwFl
 JMaMHRYrIvwZQHcIgNkgUSs/60eata91HN8izwWUTcR9KBzAvod3e0cxhRBA54/7O9BXCHzVr
 mWjwLTmnwux2W/VTW5xZhUFzMpcN6k2XkswA1nGZgeMGSeZ1VW5qZjF9rF0XAp2Kc3koI85Pc
 Aa7n6ybyc8OeqzpkJBwO0QGCDlBC8LQfNQcZrMtqJhGq4aMPjkX+yekHWnhL2xoV5slnoOpzn
 mx5OBWACygG37Xxntx15VwfiJppHYwjQcOkE5Q7SGlMV5KLND4fanwKQTnyjflAsvdq01SVzY
 8MnsbOL9WltONQI8B24//ub9K6zn+EbYeLklWQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m32r architecture is getting removed, so this one is no longer needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/Kconfig  |  20 -
 drivers/media/platform/Makefile |   2 -
 drivers/media/platform/arv.c    | 884 ----------------------------------------
 3 files changed, 906 deletions(-)
 delete mode 100644 drivers/media/platform/arv.c

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2136702c95fc..c7a1cf8a1b01 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -52,26 +52,6 @@ config VIDEO_VIU
 	  Say Y here if you want to enable VIU device on MPC5121e Rev2+.
 	  In doubt, say N.
 
-config VIDEO_M32R_AR
-	tristate "AR devices"
-	depends on VIDEO_V4L2
-	depends on M32R || COMPILE_TEST
-	---help---
-	  This is a video4linux driver for the Renesas AR (Artificial Retina)
-	  camera module.
-
-config VIDEO_M32R_AR_M64278
-	tristate "AR device with color module M64278(VGA)"
-	depends on PLAT_M32700UT
-	select VIDEO_M32R_AR
-	---help---
-	  This is a video4linux driver for the Renesas AR (Artificial
-	  Retina) with M64278E-800 camera module.
-	  This module supports VGA(640x480 pixels) resolutions.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called arv.
-
 config VIDEO_MUX
 	tristate "Video Multiplexer"
 	select MULTIPLEXER
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 2b07f2e2fca6..932515df4477 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the video capture/playback device drivers.
 #
 
-obj-$(CONFIG_VIDEO_M32R_AR_M64278) += arv.o
-
 obj-$(CONFIG_VIDEO_VIA_CAMERA) += via-camera.o
 obj-$(CONFIG_VIDEO_CAFE_CCIC) += marvell-ccic/
 obj-$(CONFIG_VIDEO_MMP_CAMERA) += marvell-ccic/
diff --git a/drivers/media/platform/arv.c b/drivers/media/platform/arv.c
deleted file mode 100644
index 1e865fea803c..000000000000
-- 
2.9.0
