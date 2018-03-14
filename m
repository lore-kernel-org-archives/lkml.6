Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbeCNPpy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:45:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCNPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:45:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Subject: [PATCH 24/47] gpio: remove etraxfs driver
Date: Wed, 14 Mar 2018 16:35:37 +0100
Message-Id: <20180314153603.3127932-25-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:0oecEE3YzVvcnfKPYOzsThjSA8hEp5tU5WL9XZtTO9wSHFTb2YA
 X7GjuRb1jk10ZBlkrK00fq4LcpxLu8U8suQRgTT9kCZudLogtx8LJyXw+fcK/mYmdaNq/rJ
 uwy0A9m7bTn9Wb6GLW9CAJncyHmtFH9GyIqNi7sIVDgtenmC4BtZAE17jxYu2P5j6aEd0Q0
 z7zYtMLqX3C68bBX49JPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qgv6RW8xWyQ=:BfIGVDQGR8hduhWWJLeMbG
 PjsiVElykZkj/M8gs0ZJQzuIFkD3eX+01XGrh0xcOMTV0WB8ffsqj4ASACbCaOvNF1+4RMl/C
 n5jjIjy0hAaSUa1Z9RxGkVWQoUOCRMhRKgtBE3epuNhIay3pYO4ItP9IGq0LhxDbr152zcPJJ
 32OoId3+AjIPXdnv/90hu6EOPNbXLYCGPPK76j5dpjAsSYsmTGkEETPKCFZqmWOi4MzpBLgJ1
 zHZPjXh+ygP16uiDgZc5XAR6H7t7xp0iVUczi5sga7UltfDDBUB1PBGZTXEf7M8157ypEiFIE
 6gUsqjipjFFUEnBs8EADorlLSUK9IduJVl1PqjyZ/jxyYGibfiuSzYYUOY/5DitHICixPPF4u
 14nHjZg7L+bIjhGEh1PeaVz3vZVCBbXVcy47CgXq00pJu58iR9jqRzxKBrEBedBvEEhUe6Chq
 9PUXexyDdqzVIYOZKYHtCeErw06PdXaAT7MAUVJ2XOEl69x8F5YO8VuNFPwlOfAYj9Pah71gG
 celMb7feSWzd6/CzxYg1HB/hFCJ2oAplE6jEpm7IW5/Qt6YWcfniIOuec+DTYLP9W6lDESxuB
 kCGxYaRYdTh6sPuxGz6wlJbxbpTAPTHS38bgPfiM3RyjY0Mmwutjyh8aR3a3ijFGrcKQiQEpE
 VzANcFmIbvmkFkAuyVW4V8BcvfHRYKk2P9u/I75ftroCPuQT9lw6sG/vj9YDhlCjwkyyEOa/P
 wJzPAGcupXnG3QVWpA5Cj4RGb5Jh2xukAmSbhA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cris architecture is getting removed, so we no longer need the
etraxfs driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/gpio/gpio-etraxfs.txt      |  22 -
 drivers/gpio/Kconfig                               |   9 -
 drivers/gpio/Makefile                              |   1 -
 drivers/gpio/gpio-etraxfs.c                        | 475 ---------------------
 4 files changed, 507 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-etraxfs.txt
 delete mode 100644 drivers/gpio/gpio-etraxfs.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-etraxfs.txt b/Documentation/devicetree/bindings/gpio/gpio-etraxfs.txt
deleted file mode 100644
index 170194af3027..000000000000
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6b1ee11295d5..43c85cbfb878 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -181,15 +181,6 @@ config GPIO_EP93XX
 	depends on ARCH_EP93XX
 	select GPIO_GENERIC
 
-config GPIO_ETRAXFS
-	bool "Axis ETRAX FS General I/O"
-	depends on CRIS || COMPILE_TEST
-	depends on OF_GPIO
-	select GPIO_GENERIC
-	select GPIOLIB_IRQCHIP
-	help
-	  Say yes here to support the GPIO controller on Axis ETRAX FS SoCs.
-
 config GPIO_EXAR
 	tristate "Support for GPIO pins on XR17V352/354/358"
 	depends on SERIAL_8250_EXAR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 5c1f087c65aa..c92c5d78bb04 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -47,7 +47,6 @@ obj-$(CONFIG_GPIO_DLN2)		+= gpio-dln2.o
 obj-$(CONFIG_GPIO_DWAPB)	+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
-obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
 obj-$(CONFIG_GPIO_EXAR)		+= gpio-exar.o
 obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
 obj-$(CONFIG_GPIO_FTGPIO010)	+= gpio-ftgpio010.o
diff --git a/drivers/gpio/gpio-etraxfs.c b/drivers/gpio/gpio-etraxfs.c
deleted file mode 100644
index 94db1bf4bfdb..000000000000
-- 
2.9.0
