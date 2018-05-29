Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934665AbeE2NLE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:11:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36282 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934564AbeE2NKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:51 -0400
X-Google-Smtp-Source: ADUXVKJQQM/3UkpYbi6sRHPahPgQmlcMoxchczRnzPn2fEWOh8/Dqv/+ug1BE1f1mFsHa6Wi2pukeQ==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/19] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
Date: Tue, 29 May 2018 15:10:06 +0200
Message-Id: <20180529131014.18641-12-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f4d7846c06b8..ff0fd3502a90 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1327,8 +1327,10 @@ MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 
 static const struct serdev_device_id bcm_serdev_id[] = {
 	{ "bcm43438-bt", },
+	{ "hci_uart_bcm", },
 	{}
 };
+MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);
 
 static struct serdev_device_driver bcm_serdev_driver = {
 	.probe = bcm_serdev_probe,
-- 
2.17.0
