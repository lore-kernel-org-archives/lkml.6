Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeCIBwW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 20:52:22 -0500
Received: from regular1.263xmail.com ([211.150.99.136]:42173 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCIBwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 20:52:20 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <220ea8ca12fd1cb0be4b37239e0d6641>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org,
        alexandre.belloni@bootlin.com
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 1/4] mfd: syscon: Set name of regmap_config
Date: Fri,  9 Mar 2018 09:51:43 +0800
Message-Id: <20180309015146.8297-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
References: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3:
Modify commit message.

 drivers/mfd/syscon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index fc9ba0ea4e44..b6d05cd934e6 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -110,6 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.name = of_node_full_name(np);
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
-- 
2.11.0
