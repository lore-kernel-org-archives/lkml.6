Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932397AbeCLX74 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:59:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42412 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeCLX7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:59:55 -0400
X-Google-Smtp-Source: AG47ELsE/elwH0URMA8PYOGKKbyq6keiVu0BRWBKCMpBRrZVku3vhl59FQHKXnuLVYDZE3Gq4B9I4Q==
Date: Tue, 13 Mar 2018 00:59:40 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: triad@df.lth.se, linus.walleij@linaro.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] auxdisplay: arm-charlcd: Fix struct charlcd doc line
Message-ID: <20180312235940.6coamzh4qhckaohh@gmail.com>
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
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 drivers/auxdisplay/arm-charlcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
index b3176ee92b90..dde180995582 100644
--- a/drivers/auxdisplay/arm-charlcd.c
+++ b/drivers/auxdisplay/arm-charlcd.c
@@ -54,12 +54,14 @@
 #define HD_BUSY_FLAG			0x80U
 
 /**
+ * struct charlcd - Private data structure
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
