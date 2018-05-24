Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964835AbeEXGBU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 02:01:20 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36881 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935515AbeEXGBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 02:01:18 -0400
X-Google-Smtp-Source: AB8JxZqY1JJJXfm9rwIHf5AKfbfX51/KRMTMk4EibJq0ZRv564c5DseB8fE9MsrV8saOs7hutszzLg==
Date: Thu, 24 May 2018 09:01:14 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH 9/9] regulator: bd71837: Build BD71837 regulator driver
Message-ID: <20180524060114.GJ4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configurations and Makefile for BD71837 regulator driver

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/Kconfig  | 11 +++++++++++
 drivers/regulator/Makefile |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 097f61784a7d..139f4b53fea0 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -180,6 +180,17 @@ config REGULATOR_BCM590XX
 	  BCM590xx PMUs. This will enable support for the software
 	  controllable LDO/Switching regulators.
 
+config REGULATOR_BD71837
+	tristate "ROHM BD71837 Power Regulator"
+	depends on MFD_BD71837
+	help
+	  This driver supports voltage regulators on ROHM BD71837 PMIC.
+	  This will enable support for the software controllable buck
+	  and LDO regulators.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called bd71837-regulator.
+
 config REGULATOR_BD9571MWV
 	tristate "ROHM BD9571MWV Regulators"
 	depends on MFD_BD9571MWV
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 590674fbecd7..1b4d8ec416c2 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
+obj-$(CONFIG_REGULATOR_BD71837) += bd71837-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
-- 
2.14.3
