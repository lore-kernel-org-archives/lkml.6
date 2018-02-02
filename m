Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeBBQpQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:45:16 -0500
Received: from mout.web.de ([212.227.15.14]:64223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbeBBQpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:45:09 -0500
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] i2c-ibm_iic: Delete an error message for a failed memory
 allocation in iic_probe()
Message-ID: <3c085530-c0d4-e2b2-8dcd-393ef7571243@users.sourceforge.net>
Date: Fri, 2 Feb 2018 17:45:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xNNIusdv6HpMBQdtHq/cwd2ML/Qb2eAOvEbZuCeYvm9pLZiTAO7
 17Zb7vnWQuW4Xr5RZyPPSwgLgvF3rknsMp9zChMX599IvOXv3jzSa1VnDKxIBxQhPYpTLK1
 v7E6+AyGt5gEbCHpcq1Tyx383TuMywDrDUTUTbjQ3+AGD4cbBiWiXPuJAYF9Xm2Cw+jVQSX
 j3/OZDoBQ5WL+bm/TnWMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kRU13CNCSjI=:/XN8Lf1Hf6dIQzZ5T3JTAQ
 x2vUaYw5fhe0tHImPVbM+hhKX3sRSvnlZoMsn5tli4766hCau+YNXUlljjj88LWZani8Uc4Gs
 7GAlxD97jdkk9jn2X+midmhkLIs0kNuZv2Af85WxF+mjSZWIY5pebUhqYn4wq0Cx1rtZ4OS+0
 gTUUgPMQT+cWuUg9dC/c5+H6mSjFU1VayuuFXcRvKxwBJuINW0wRyoHUZrqqOE4fmE0zfHRvR
 T3alPfoiGYqIlWBhlCLljv3v0KCzbDC11l+dUtSE+7V/NFdecSv55VlpN6eQ6bGYdQJ9HvPtm
 70e7RVdYOV8TYzZsPRvcVMEqRz/az0I31UHuF78kVDW31g+NMaLNJZkUJkp6+Qo/6k7XYX8V/
 RQXvWmqOgdvizQe2OOe3mn1VM55ezzLyUmdiXZ3FjbnsgsvJ6vcoaXw5O7oShrJalC+UY4agI
 IsmTvbFcKsShSxUfahvbwu6/cdMagG2BqHmmARCQ+IfzjQAMk5eqL6zHGOjxxPvvEOOAr6sJs
 zsRi1bIJ8gAjAbaU3fTqwBP6wOh3Ti1SHzYx1RbPv3ISvAmBuJQ0WrX3s/7sBxg3EZLcngNLD
 GIbJmy3oRkA6cEvKbIi3w6dMzOrSARShrkJYQiPEnVbq1VLbsFrKq67ArIUhbPv96EofA08hf
 Dboxp0BwnooWwQS36SFC7npFvPaZJdAikGgIyHw23KBk1rcek/DO0n3xTAAWnfxosxQGIuV2O
 5fYai3bYTXMtFXqtyk+A1zPv4+LvutNCmp2ocPxM1uY7BuIjZvJ54lMHyGOPWas4oKLOcQQ3J
 VlHMrYRBs8OXsP/BHpdQ+3dBHrGheZM5IfWujvMnhm78XDgv8I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 17:24:57 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 961c5f42d956..1bd4d6dde0fe 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -702,10 +702,8 @@ static int iic_probe(struct platform_device *ofdev)
 	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&ofdev->dev, "failed to allocate device data\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(ofdev, dev);
 
-- 
2.16.1
