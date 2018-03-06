Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeCFAYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:24:33 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.214]:18269 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932395AbeCFAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:24:31 -0500
Date: Mon, 5 Mar 2018 18:00:43 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] Input: appletouch - use true and false for boolean values
Message-ID: <20180306000043.GA1603@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1et027-003ro7-F8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:46206
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/mouse/appletouch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 81a695d..032d279 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -587,7 +587,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		/* Perform size detection, if not done already */
 		if (unlikely(!dev->size_detect_done)) {
 			atp_detect_size(dev);
-			dev->size_detect_done = 1;
+			dev->size_detect_done = true;
 			goto exit;
 		}
 	}
@@ -813,7 +813,7 @@ static int atp_open(struct input_dev *input)
 	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
 		return -EIO;
 
-	dev->open = 1;
+	dev->open = true;
 	return 0;
 }
 
@@ -823,7 +823,7 @@ static void atp_close(struct input_dev *input)
 
 	usb_kill_urb(dev->urb);
 	cancel_work_sync(&dev->work);
-	dev->open = 0;
+	dev->open = false;
 }
 
 static int atp_handle_geyser(struct atp *dev)
-- 
2.7.4
