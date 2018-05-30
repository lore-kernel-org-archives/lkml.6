Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968734AbeE3IXu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:23:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44129 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968628AbeE3IXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:23:47 -0400
X-Google-Smtp-Source: ADUXVKKqHBtWjf7VBcZeCKRiSJQm9NX/752mkUOSKgohpN3p9Doc5AJrSqAZ7i05783sphWwtTrvPg==
From: Artiom Vaskov <velemas@gmail.com>
Cc: honwchong@gmail.com, Larry.Finger@lwfinger.net,
        Artiom Vaskov <velemas@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add additional device ID for RTL8822BE
Date: Wed, 30 May 2018 11:23:00 +0300
Message-Id: <20180530082300.5510-1-velemas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6BC33699-4306-4EE9-A290-B5845A402C4C@holtmann.org>
References: <6BC33699-4306-4EE9-A290-B5845A402C4C@holtmann.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asus ROG GL702ZC laptop contains a Realtek RTL8822BE device with
an associated BT chip using a USB ID of 13d3:3526. This ID is added
to the driver.

The /sys/kernel/debug/usb/devices portion for this device is:

T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=04 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3526 Rev= 1.10
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Artiom Vaskov <velemas@gmail.com>
---
Changes in v2:
- changed commit message

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b937cc1e2c07..34e5aedd4e27 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -379,6 +379,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3526), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
 
 	/* Silicon Wave based devices */
-- 
2.17.1
