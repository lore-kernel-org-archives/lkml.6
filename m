Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934678AbeE2NUo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:20:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54945 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934204AbeE2NKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:39 -0400
X-Google-Smtp-Source: AB8JxZoSlAm4AGQFa2dJEwF6dP54dodubmErcnVpO5XQiVXdDwcNXuLvCWaWRaT2NXCb0SDyB3hqPQ==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
Date: Tue, 29 May 2018 15:09:59 +0200
Message-Id: <20180529131014.18641-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe which hardware is supported by the current driver.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_nokia.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 3539fd03f47e..e32dfcd56b8d 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
 MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
 #endif
 
+static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
+	{ "hp4-bluetooth", },
+	{},
+};
+
 static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 	.probe = nokia_bluetooth_serdev_probe,
 	.remove = nokia_bluetooth_serdev_remove,
@@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 		.pm = &nokia_bluetooth_pm_ops,
 		.of_match_table = of_match_ptr(nokia_bluetooth_of_match),
 	},
+	.id_table = nokia_bluetooth_serdev_id,
 };
 
 module_serdev_device_driver(nokia_bluetooth_serdev_driver);
-- 
2.17.0
