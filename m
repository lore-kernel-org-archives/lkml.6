Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeBAQ5H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:57:07 -0500
Received: from mout.web.de ([212.227.15.3]:52307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752375AbeBAQ5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:57:04 -0500
Subject: [PATCH 1/2] i2c-tiny-usb: Delete an error message for a failed memory
 allocation in i2c_tiny_usb_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Till Harbaum <till@harbaum.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Message-ID: <39c40369-48ef-e245-4e19-4caf12e9f06b@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:57:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:075sf+zCWrMy1y05V9egReG8tEp8OT5xFMrGYon7V+49v+bTWOZ
 KtmRHi0KZMy+ruUeYZyod+nveHjIuNe3XX/DR6buHpT3TRFhQr0RWuNJEOs9liWVJWdXrnu
 /aipI3j4SKg2DtWkasA4xvTBt4W3mZ3DVIMkic4wTd9msSw74HScWiue544vQc0eFH9BBgh
 NpqFVmQSW3mKfUxV5AQWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x5BpGAxJYEU=:mjBA32OY/ZBtRtrmQTp4sr
 amXFivwSo+VnAkwsnThLhGgGI1+o0d8SpyOTMxaBabXHRIQjvOuWJR2uTmtjI8qBKc3yVseMX
 vJX/1ujTphX0aBGkTAETTfiXJiaGhq5YZZpR73iLLYtn5zop36yPRCRLWvQUOEXSHFIre713a
 j8a1h4argCTZAFavfWOTPtQi7Xets1G7dJKK0Bg2tfu7ogvj3Xr7WdTYyQbV7VArGo0lJDidG
 1324vkYS6PkWRkFOZYd5EoqltHV1koHNU5JYLuGO48JpUK10xJM78t3xsHybuYjnWDLH1J7dM
 WNkzEg3gsH+Zz019/tD1WWtdMBpCP8l06Bk4Oy7aHDuRftsWUmJdyX/XxrEAplsVYXnQKrlQ3
 QWGCvZQYTWt1CrwGDGb757srcF87vuJdBV+BvRFC4Qv2J5OgPlUTzGQ1ZVOPQPyQV2gLSCgbq
 Xu5eJBSG801LAyVVmVAyDO0pAPMypOZ7J70bhvO7K36Z28e3/mxLq1sSmJHFixWmh0wliW8Pk
 BXJ3ZCdwU/POjuqYZc8s8JvkJJyi4SoPwT+cGzo7LNP3XkyOv4miNNLEQOyeTm8Qbura4pRao
 nIbIaIEUpmPmQud7zcxJdiJcCguPr/KC9Vkm6XVr/mXB44k70X9meKTSHZh1BL2naL2cdVkSa
 cdiehdDbFEziAZpAlg3p5k2CD2iSJ752z2orSdK1zv+mBK+I1uyopmF2IN3ENhFyz18+Mw36I
 EPtMyBUfaxtR49GEXES+p90P2RWN73WHCigsmj1uy4eLj6/+vCEWLXSOFazzLNIUbB4t6wa/Q
 3pi6feKHwrOVyC+XS1+uBPVau/PVmWThBQZnsr7W6tY8idRIzg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:36:50 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index a2e3dd715380..e210e36df123 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -230,10 +230,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!dev)
 		goto error;
-	}
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
-- 
2.16.1
