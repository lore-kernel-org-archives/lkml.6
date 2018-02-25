Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBYMsC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 07:48:02 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44467 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeBYMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 07:47:54 -0500
X-Google-Smtp-Source: AG47ELt1HuGLLK28U7VkcdDnlIqzgI91FCtobPrUnJUD0HvQjGoY0Uh/leYh7ElPuse9V5osvtcDjg==
Date: Sun, 25 Feb 2018 13:46:52 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: triad@df.lth.se, linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: arm-charlcd: Fix struct charlcd doc line
Message-ID: <20180225124652.76r5tucjebyplw2q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a missing first line and a missing member,
which gave a warning under W=1:

    CC      drivers/auxdisplay/arm-charlcd.o
  drivers/auxdisplay/arm-charlcd.c:57: warning: Cannot understand
   * @dev: a pointer back to containing device on line 57 - I thought
  it was a doc line

Cc: Linus Walleij <triad@df.lth.se>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
Please let me know if anyone does not want this in 4.17.

 drivers/auxdisplay/arm-charlcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
index b3176ee92b90..27cf08a05e93 100644
--- a/drivers/auxdisplay/arm-charlcd.c
+++ b/drivers/auxdisplay/arm-charlcd.c
@@ -54,12 +54,14 @@
 #define HD_BUSY_FLAG			0x80U
 
 /**
+ * struct charlcd
  * @dev: a pointer back to containing device
  * @phybase: the offset to the controller in physical memory
  * @physize: the size of the physical page
  * @virtbase: the offset to the controller in virtual memory
  * @irq: reserved interrupt number
  * @complete: completion structure for the last LCD command
+ * @init_work: delayed work structure to initialize the display on boot
  */
 struct charlcd {
 	struct device *dev;
-- 
2.14.1
