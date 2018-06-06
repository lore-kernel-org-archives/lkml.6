Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olm5fVcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BA4C601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeFFKCh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:02:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52183 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeFFKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:27 -0400
X-Google-Smtp-Source: ADUXVKLUmrI3RjJNtC9Kjl5v7wZYZtcOJqPS7qtxmLeZVl9GF2kthKPgF6w+hlXSiKpzbRua7tVuog==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 05/14] mfd: da9063: Use PLATFORM_DEVID_NONE
Date: Wed,  6 Jun 2018 11:59:54 +0200
Message-Id: <20180606100003.17067-5-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V4: New patch
V5: Rebase on top of new 01 and 02 patches
---
 drivers/mfd/da9063-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 76258e5709f8..f57558590283 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -226,9 +226,9 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = devm_mfd_add_devices(da9063->dev, -1, da9063_devs,
-				   ARRAY_SIZE(da9063_devs), NULL,
-				   da9063->irq_base, NULL);
+	ret = devm_mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
+				   da9063_devs, ARRAY_SIZE(da9063_devs),
+				   NULL, da9063->irq_base, NULL);
 	if (ret)
 		dev_err(da9063->dev, "Cannot add MFD cells\n");
 
-- 
2.16.2
