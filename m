Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeCNLSC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:18:02 -0400
Received: from ozlabs.org ([103.22.144.67]:44801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeCNLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:18:01 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: [RESEND PATCH] Input: joystick/analog - Use get_cycles() on PPC
Date: Wed, 14 Mar 2018 22:17:52 +1100
Message-Id: <20180314111752.1748-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The analog joystick driver spits a warning at us:

  drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
  not defined for this architecture.

PPC has get_cycles() so use that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/input/joystick/analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


This is the third resend, I'll take it via the powerpc tree if no one else
does.

cheers

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index c868a878c84f..a942c4ccd2af 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -163,7 +163,7 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	do { x = (unsigned int)rdtsc(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
-#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
+#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"get_cycles"
-- 
2.14.1
