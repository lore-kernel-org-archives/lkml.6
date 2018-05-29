Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934730AbeE2NOj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:14:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39639 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934579AbeE2NKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:52 -0400
X-Google-Smtp-Source: AB8JxZoR55p/6uKrd+bPGa+NhdxdTTa0B2BfHOPQb2eFhLIVhnXpPHlIrcUtEMxDM3bzpHHuXhNE2Q==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/19] Bluetooth: hci_ll: MODULE_DEVICE_TABLE(serdev)
Date: Tue, 29 May 2018 15:10:07 +0200
Message-Id: <20180529131014.18641-13-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_ll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c31942c9b466..5c36d8967a00 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -789,8 +789,10 @@ static struct serdev_device_id hci_ti_id[] = {
 	{ "wl1831-st", },
 	{ "wl1835-st", },
 	{ "wl1837-st", },
+	{ "hci-ti", },
 	{},
 };
+MODULE_DEVICE_TABLE(serdev, hci_ti_id);
 
 static struct serdev_device_driver hci_ti_drv = {
 	.driver		= {
-- 
2.17.0
