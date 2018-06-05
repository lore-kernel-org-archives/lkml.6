Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFEXKk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:10:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54510 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeFEXKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:35 -0400
X-Google-Smtp-Source: ADUXVKLatdQdZpOvwCLz72QcgYp/wpGoxKRkcAOAh60wm0cPrM5dKhxx1ciuRnPdjSdgkSFgNSC6Kg==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 03/12] mfd: da9063: Use PLATFORM_DEVID_NONE
Date: Wed,  6 Jun 2018 01:10:04 +0200
Message-Id: <20180605231013.1803-3-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PLATFORM_DEVID_NONE instead of -1 in mfd_add_devices.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V4: New patch
---
 drivers/mfd/da9063-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 8226ebd8b96d..61ffee5eac2c 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -226,7 +226,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
+	ret = mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE, da9063_devs,
 			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
 			      NULL);
 	if (ret) {
-- 
2.16.2
