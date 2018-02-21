Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeBUXnH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbeBUXlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D05C217A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Subject: [PATCH 09/13] pinctrl: Drop TZ1090 drivers
Date: Wed, 21 Feb 2018 23:38:21 +0000
Message-Id: <20180221233825.10024-10-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, along with TZ1090 SoC support,
remove the TZ1090 pinctrl drivers. They are of no value without the
architecture and SoC platform code.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-metag@vger.kernel.org
---
 .../bindings/pinctrl/img,tz1090-pdc-pinctrl.txt    |  127 --
 .../bindings/pinctrl/img,tz1090-pinctrl.txt        |  227 ---
 drivers/pinctrl/Kconfig                            |   12 -
 drivers/pinctrl/Makefile                           |    2 -
 drivers/pinctrl/pinctrl-tz1090-pdc.c               |  989 ----------
 drivers/pinctrl/pinctrl-tz1090.c                   | 2005 --------------------
 6 files changed, 3362 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/img,tz1090-pdc-pinctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/img,tz1090-pinctrl.txt
 delete mode 100644 drivers/pinctrl/pinctrl-tz1090-pdc.c
 delete mode 100644 drivers/pinctrl/pinctrl-tz1090.c

diff --git a/Documentation/devicetree/bindings/pinctrl/img,tz1090-pdc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/img,tz1090-pdc-pinctrl.txt
deleted file mode 100644
index cf9ccdff4455..000000000000
diff --git a/Documentation/devicetree/bindings/pinctrl/img,tz1090-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/img,tz1090-pinctrl.txt
deleted file mode 100644
index 2dfd9a3fc1e4..000000000000
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 0f254b35c378..f5ef8201c09f 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -263,18 +263,6 @@ config PINCTRL_ST
 	select PINCONF
 	select GPIOLIB_IRQCHIP
 
-config PINCTRL_TZ1090
-	bool "Toumaz Xenif TZ1090 pin control driver"
-	depends on SOC_TZ1090
-	select PINMUX
-	select GENERIC_PINCONF
-
-config PINCTRL_TZ1090_PDC
-	bool "Toumaz Xenif TZ1090 PDC pin control driver"
-	depends on SOC_TZ1090
-	select PINMUX
-	select PINCONF
-
 config PINCTRL_U300
 	bool "U300 pin controller driver"
 	depends on ARCH_U300
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d3692633e9ed..6255546735ff 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -34,8 +34,6 @@ obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_SIRF)	+= sirf/
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
-obj-$(CONFIG_PINCTRL_TZ1090)	+= pinctrl-tz1090.o
-obj-$(CONFIG_PINCTRL_TZ1090_PDC)	+= pinctrl-tz1090-pdc.o
 obj-$(CONFIG_PINCTRL_U300)	+= pinctrl-u300.o
 obj-$(CONFIG_PINCTRL_COH901)	+= pinctrl-coh901.o
 obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
diff --git a/drivers/pinctrl/pinctrl-tz1090-pdc.c b/drivers/pinctrl/pinctrl-tz1090-pdc.c
deleted file mode 100644
index b16d1c96b7eb..000000000000
diff --git a/drivers/pinctrl/pinctrl-tz1090.c b/drivers/pinctrl/pinctrl-tz1090.c
deleted file mode 100644
index 2379ce2be365..000000000000
-- 
2.13.6
