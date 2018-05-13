Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeEMAVA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 20:21:00 -0400
Received: from onstation.org ([52.200.56.107]:59726 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeEMAU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 20:20:59 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: tsl2583: correct values in integration_time_available
Date: Sat, 12 May 2018 20:20:39 -0400
Message-Id: <20180513002039.6984-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The times reported by the in_illuminance_integration_time_available
sysfs attribute are actually in milliseconds, not microseconds. This
patch corrects the times with the correct unit.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index f2e50edaa242..4b5d9988f025 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -600,7 +600,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 
 static IIO_CONST_ATTR(in_illuminance_calibscale_available, "1 8 16 111");
 static IIO_CONST_ATTR(in_illuminance_integration_time_available,
-		      "0.000050 0.000100 0.000150 0.000200 0.000250 0.000300 0.000350 0.000400 0.000450 0.000500 0.000550 0.000600 0.000650");
+		      "0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500 0.550 0.600 0.650");
 static IIO_DEVICE_ATTR_RW(in_illuminance_input_target, 0);
 static IIO_DEVICE_ATTR_WO(in_illuminance_calibrate, 0);
 static IIO_DEVICE_ATTR_RW(in_illuminance_lux_table, 0);
-- 
2.14.3
