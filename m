Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeE2NKr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:10:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35584 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934083AbeE2NKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:36 -0400
X-Google-Smtp-Source: AB8JxZpXHFNUrrQOCIEsQ7Fiqa3fTiOmVRAzfH8Q5D/G93WOCOK+O7JdrAkIIXdKovGLZRGh52HyIQ==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/19] Bluetooth: hci_bcm: Add serdev_id_table
Date: Tue, 29 May 2018 15:09:57 +0200
Message-Id: <20180529131014.18641-3-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_bcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 441f5e1deb11..f4d7846c06b8 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1325,6 +1325,11 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 #endif
 
+static const struct serdev_device_id bcm_serdev_id[] = {
+	{ "bcm43438-bt", },
+	{}
+};
+
 static struct serdev_device_driver bcm_serdev_driver = {
 	.probe = bcm_serdev_probe,
 	.remove = bcm_serdev_remove,
@@ -1334,6 +1339,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
 		.pm = &bcm_pm_ops,
 	},
+	.id_table = bcm_serdev_id,
 };
 
 int __init bcm_init(void)
-- 
2.17.0
