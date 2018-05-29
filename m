Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeE2NNl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:13:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934552AbeE2NK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:57 -0400
X-Google-Smtp-Source: AB8JxZoXW+bZK/Poomx/EVG1AXrgPmlprwTRZQOL+o0P7dRlpLZNQcXjMj1lIs/zkAu5GvcwybCm3A==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 15/19] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Tue, 29 May 2018 15:10:10 +0200
Message-Id: <20180529131014.18641-16-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/net/ethernet/qualcomm/qca_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index db6068cd7a1f..bb7aed805083 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -405,6 +405,12 @@ static void qca_uart_remove(struct serdev_device *serdev)
 	free_netdev(qca->net_dev);
 }
 
+static struct serdev_device_id qca_uart_serdev_id[] = {
+	{ QCAUART_DRV_NAME, },
+	{},
+};
+MODULE_DEVICE_TABLE(serdev, qca_uart_serdev_id);
+
 static struct serdev_device_driver qca_uart_driver = {
 	.probe = qca_uart_probe,
 	.remove = qca_uart_remove,
@@ -412,6 +418,7 @@ static struct serdev_device_driver qca_uart_driver = {
 		.name = QCAUART_DRV_NAME,
 		.of_match_table = of_match_ptr(qca_uart_of_match),
 	},
+	.id_table = qca_uart_serdev_id,
 };
 
 module_serdev_device_driver(qca_uart_driver);
-- 
2.17.0
