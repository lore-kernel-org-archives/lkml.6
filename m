Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeCFLEq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:04:46 -0500
Received: from regular1.263xmail.com ([211.150.99.136]:35438 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCFLEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:04:21 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <b9b5ae092067a31de5fec77a44a12506>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Date: Tue,  6 Mar 2018 19:04:01 +0800
Message-Id: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are now allowing to register debugfs for syscon regmap, and not
having a valid name will end up using "dummy" to create debugfs dir.

Fixes: 9b947a13e7f6 ("regmap: use debugfs even when no device")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/mfd/syscon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 7eaa40bc703f..250d22f40c84 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -109,6 +109,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.name = of_node_full_name(np);
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
-- 
2.11.0
