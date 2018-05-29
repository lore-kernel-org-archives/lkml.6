Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbeE2NOB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:14:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50302 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933818AbeE2NKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:55 -0400
X-Google-Smtp-Source: AB8JxZok5jN6SVNxG3oevnfzXoSe7IVLxRA24Fri66JxCI206x9LXMmCC8Sfg3X6+C7LuMXSkW+mpQ==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 14/19] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
Date: Tue, 29 May 2018 15:10:09 +0200
Message-Id: <20180529131014.18641-15-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mfd/rave-sp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 5c858e784a89..807c237e061b 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
 MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
 
+static struct serdev_device_id rave_sp_serdev_id[] = {
+	{ "rave-sp", },
+	{},
+};
+MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
+
 static struct serdev_device_driver rave_sp_drv = {
 	.probe			= rave_sp_probe,
 	.driver = {
 		.name		= "rave-sp",
 		.of_match_table	= rave_sp_dt_ids,
 	},
+	.id_table = rave_sp_serdev_id,
 };
 module_serdev_device_driver(rave_sp_drv);
 
-- 
2.17.0
