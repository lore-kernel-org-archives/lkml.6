Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeBAQ6c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:58:32 -0500
Received: from mout.web.de ([212.227.15.3]:53175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbeBAQ6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:58:30 -0500
Subject: [PATCH 2/2] i2c-tiny-usb: Return an error code only as a constant in
 i2c_tiny_usb_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Till Harbaum <till@harbaum.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Message-ID: <b6a54fdf-eb83-cf33-b3f9-d26d9be14d03@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CYMWmP3+kCGoM3ZUfPutYcjkRXl5J20nqTaZcyM+ZtFbwjQPTaP
 zeSUs9yYzPKBZCc/iTGpaGspLta9j1h2qflbbhJsF/xVVEJGIxG/jjjgog43kfbKjZ8THD+
 d+Y8qSzuftudgCALfJNM85fqDBqGK9k950nZ3ysYirE7VnqhaI6tNcxELhhMI9LHLh0xIpC
 HCWY6Dbm6eEmwAeR8fB+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7AZkT0uitoU=:XJcdT2t30wrwTfUXsP5Qrt
 Fcd0MeAM4GP/0zIt+IhQdM1R/Z41h2FV+kxMSyU4KCtyAJFEQyQqBytIzr249t1l0eN2xNhZh
 EUGuB2uHXwIVFFMcGxa0L1o8/hDW1Im+V7CWaGt/ndC/i7flWBM0kTAEt7FY1WsrNYb/xAQEs
 q1jovRXRD26R330mEndB05/EvN1HsAHWXXXuHiteoZg81eJ+5Kjz98hxIEifpi38IC1BPjxC7
 NKUsBa9U6gavxSGcu8AL995ZwCS1NfD1QWH9B3G34rkROMDg5Rtcpy2Og2mrsuqzzgV+Y+lJW
 TuOXUgodmUxYil9ouoX3KHQlEx0oV4yQPIPzpR6b6zV2A2/4IQHgVmriddHzwKjFsySmx0oVq
 +lwPMG9kwRqJKFwhPhz3/1MhgBxIhML/dNSE/Je5l/408AMpAEMbl4yTQ7R1LESPoV7jiSaij
 EofYIezbCZbFxFBs+/GQu2QM/SwFZ9jLKDK36nZXWpwFoAW7BKO+pBV1cZ//nx6U+5MFf+Vr4
 jyNF6M8eZwvIvLfw7NWOriNT2pbV5TJJiZg/+3TQ7abv0y7sAOUDxm2L5zB4CUzurUcwavWqW
 J/nTbOqjFzTHVtgcnwJjECXOy53GS+he+zOCmw6x9YMsLuHyiOGQKkJ6ys1ARHemByFFzOftX
 9jH8+8zaVznTDOIX2FUBIiBfbtORJFWc5kIfOPslYmSxc3knp7U102LTSs2CBxEa4u+ESAD6F
 Hqn3yNhLayTWF1Ts45iIidfnALLw/4WnAobY5IqR1eN6rUkf4IZip2n4yDQuzJhZzsCNpwVmX
 iPg6iXiGcwBz12hj7jViP0Xt6cINa4b4slxmUtVSNeRh8BXlz8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:45:21 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "error" and local variable "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index e210e36df123..2416bb0d8a88 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -223,7 +223,6 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 			      const struct usb_device_id *id)
 {
 	struct i2c_tiny_usb *dev;
-	int retval = -ENOMEM;
 	u16 version;
 
 	dev_dbg(&interface->dev, "probing usb device\n");
@@ -231,7 +230,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto error;
+		return -ENOMEM;
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
@@ -257,8 +256,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	if (usb_write(&dev->adapter, CMD_SET_DELAY, delay, 0, NULL, 0) != 0) {
 		dev_err(&dev->adapter.dev,
 			"failure setting delay to %dus\n", delay);
-		retval = -EIO;
-		goto error;
+		i2c_tiny_usb_free(dev);
+		return -EIO;
 	}
 
 	dev->adapter.dev.parent = &dev->interface->dev;
@@ -270,12 +269,6 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	dev_info(&dev->adapter.dev, "connected i2c-tiny-usb device\n");
 
 	return 0;
-
- error:
-	if (dev)
-		i2c_tiny_usb_free(dev);
-
-	return retval;
 }
 
 static void i2c_tiny_usb_disconnect(struct usb_interface *interface)
-- 
2.16.1
