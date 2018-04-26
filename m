Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524756579; cv=none;
        d=google.com; s=arc-20160816;
        b=vjFQWrDXVlBcA4pkM8Hb6aD9gvFnRuOdoi4pftFyNfrT1WM+zpmRdug5n5WHlzQ7s7
         4O3OPfH1fJB+M0UyjPum8nLp1Ox/YOp9+Iza6OuBBSX5V9JTGrfom5tlTvMEaIDHInM+
         9HtXapk1MPpyrLJkCwqTbfjTDAmajg2ueXER7wz+xIX6JU0+otUXcfg9aeA//RYw1tlG
         SeAZLnZDYK4jXHJf8AH9OiZZWkf+OyUf6j11I8zZ3n/0WQSOpeXzpfjdtUzuI+l20FHt
         5PLUM8Wji1fLGiN7gIM0QtPjdpckM2yG38El5UBU3l5Vys3iY3/8NX3rfgiQ+SyZUwoJ
         EvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WnQuJXVTSeMq7JNTlBOZGHl3KR8ySUXtb6WxGSGIr1I=;
        b=0ERnY85KqGy5pUWm6DBQ6XryWAZwl1CFSWrYKSBkhov6HF6flOSu7qqjJKEwbRTUXw
         W78eyfvbD+rL9nbQskR/lhTVYdKv6gEpPJ8uBPTuF5ayewt42F6lxlISfjEf6tqqUCDF
         Ji1nAUpPF9lt0tQ3s4vwnOGCNqxzRNlRr1reD1WwafoFd9WvVjJkYT90QqpFeGrstUaV
         wSL1D1aCaB3z6QS6fPVv2TKdk5ckGvRwtf+rSJSMMihtDyC02ZfWyZUkLV3KNTHloFu/
         O0mXXc9bSFhMgAbLCGm9My2fw7YAuKkfhpo23sQUdCiKba+GEkyKiwi0zZjso0lkUjlH
         MsyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Z3Vk8S4x;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Z3Vk8S4x;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx49lUdv9rFxYtt8BWEIkmBcmwZ6QfG8YcGdOLhE4Bz20ITMR9aegchkisBIFVmbTwsentmgI9g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Rosin <peda@axentia.se>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFC PoC 2/2] misc: implement a dummy early platform driver
Date: Thu, 26 Apr 2018 17:29:20 +0200
Message-Id: <20180426152920.21569-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426152920.21569-1-brgl@bgdev.pl>
References: <20180426152920.21569-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823155281818966?=
X-GMAIL-MSGID: =?utf-8?q?1598823155281818966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a very simple early platform driver. Its purpose is to show
how such drivers can be registered and to emit a message when probed.

It can be then added to the device tree or machine code to verify that
the early platform devices work as expected.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/Kconfig       |  8 +++++++
 drivers/misc/Makefile      |  1 +
 drivers/misc/dummy-early.c | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/misc/dummy-early.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5d713008749b..99cde8aefdb0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -91,6 +91,14 @@ config DUMMY_IRQ
 	  The sole purpose of this module is to help with debugging of systems on
 	  which spurious IRQs would happen on disabled IRQ vector.
 
+config DUMMY_EARLY
+	bool "Dummy early platform driver"
+	select EARLYDEV
+	default n
+	help
+	  This module's only function is to register itself with the early
+	  platform device framework and be probed early in the boot process.
+
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
 	depends on X86 && PCI && INPUT
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 20be70c3f118..84ad0225eb14 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
+obj-$(CONFIG_DUMMY_EARLY)	+= dummy-early.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
diff --git a/drivers/misc/dummy-early.c b/drivers/misc/dummy-early.c
new file mode 100644
index 000000000000..f00fb1fbd5fa
--- /dev/null
+++ b/drivers/misc/dummy-early.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Texas Instruments
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * Dummy testing driver whose only purpose is to be registered and probed
+ * using the early platform device mechanism.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/earlydev.h>
+
+static int dummy_early_probe(struct platform_device *pdev)
+{
+	if (earlydev_probing_early())
+		dev_notice(&pdev->dev, "dummy-early driver probed early!\n");
+	else
+		dev_notice(&pdev->dev, "dummy-early driver probed late!\n");
+
+	return 0;
+}
+
+static const struct of_device_id dummy_early_of_match[] = {
+	{ .compatible = "none,dummy-early", },
+	{ },
+};
+
+static struct earlydev_driver dummy_early_driver = {
+	.plat_drv = {
+		.probe = dummy_early_probe,
+		.driver = {
+			.name = "dummy-early",
+			.of_match_table = dummy_early_of_match,
+		},
+	}
+};
+earlydev_platform_driver(dummy_early_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_DESCRIPTION("Dummy early platform device driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
