Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbeDSQSy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:18:54 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34275 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbeDSQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:18:53 -0400
X-Google-Smtp-Source: AB8JxZr/liT398hs8gPNLAWXLMwdDFcuVlDjs5B453tqgXuhvL6luSxkLxIJdl9r09AnwfUpul5PGQ==
Date: Thu, 19 Apr 2018 12:18:50 -0400
From: ryang <decatf@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps6586x: Add support for TPS658624
Message-ID: <20180419161850.GA9144@computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is exists in the Samsung Galaxy Tab 10.1 which is based on the
Nvidia Tegra 2 board. The TPS658624 has the same SM2 voltage table as
TPS658623.

Signed-off-by: ryang <decatf@gmail.com>
---
 drivers/regulator/tps6586x-regulator.c | 1 +
 include/linux/mfd/tps6586x.h           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 9e9d220..ba3dae7 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -342,6 +342,7 @@ static struct tps6586x_regulator *find_regulator_info(int id, int version)
 
 	switch (version) {
 	case TPS658623:
+	case TPS658624:
 		table = tps658623_regulator;
 		num = ARRAY_SIZE(tps658623_regulator);
 		break;
diff --git a/include/linux/mfd/tps6586x.h b/include/linux/mfd/tps6586x.h
index 2fe68e4..b19c280 100644
--- a/include/linux/mfd/tps6586x.h
+++ b/include/linux/mfd/tps6586x.h
@@ -18,6 +18,7 @@
 #define TPS658621A	0x15
 #define TPS658621CD	0x2c
 #define TPS658623	0x1b
+#define TPS658624	0x0a
 #define TPS658640	0x01
 #define TPS658640v2	0x02
 #define TPS658643	0x03
-- 
2.7.4
