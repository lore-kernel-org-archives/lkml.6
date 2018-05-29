Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934704AbeE2NOR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:14:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51334 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934159AbeE2NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:54 -0400
X-Google-Smtp-Source: AB8JxZqWs+4cRoNv9a+72zP/btrKLDARHY7iBRUPVd+t9jcC275Q5vgOqcvVKqiQOztYEXMvbDVR4Q==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/19] Bluetooth: hci_nokia: MODULE_DEVICE_TABLE(serdev)
Date: Tue, 29 May 2018 15:10:08 +0200
Message-Id: <20180529131014.18641-14-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_nokia.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index e32dfcd56b8d..c283e1ca6064 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -803,8 +803,10 @@ MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
 
 static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
 	{ "hp4-bluetooth", },
+	{ "nokia-bluetooth", },
 	{},
 };
+MODULE_DEVICE_TABLE(serdev, nokia_bluetooth_serdev_id);
 
 static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 	.probe = nokia_bluetooth_serdev_probe,
-- 
2.17.0
