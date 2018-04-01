Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbeDAQmd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:42:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44857 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753720AbeDAQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:42:31 -0400
X-Google-Smtp-Source: AIpwx4//AYUM1Zx33tE9+xquZ5y4b0R4jdup4QWTsFbWQBpC9/dM2Scr8WBrG/0V/qdspmtSwF5KJA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: alex.aring@gmail.com, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, ulf.hansson@linaro.org,
        khilman@kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] soc: bcm: raspberrypi-power: Fix use of __packed
Date: Sun,  1 Apr 2018 09:42:25 -0700
Message-Id: <20180401164225.8920-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a09cd356586d ("ARM: bcm2835: add rpi power domain driver")
attempted to annotate the structure rpi_power_domain_packet with
__packed but introduced a typo and made it named __packet instead. Just
drop the annotation since the structure is naturally aligned already.

Fixes: a09cd356586d ("ARM: bcm2835: add rpi power domain driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/raspberrypi-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index fe96a8b956fb..f7ed1187518b 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -45,7 +45,7 @@ struct rpi_power_domains {
 struct rpi_power_domain_packet {
 	u32 domain;
 	u32 on;
-} __packet;
+};
 
 /*
  * Asks the firmware to enable or disable power on a specific power
-- 
2.14.1
