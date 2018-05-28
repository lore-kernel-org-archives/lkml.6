Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbeE1P73 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:59:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeE1P7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:59:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Gwendal Grignou <gwendal@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform: chrome: Add input dependency for tablet switch driver
Date: Mon, 28 May 2018 17:58:46 +0200
Message-Id: <20180528155858.2966723-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:7yQ/qrJTiO4zeqavhzbkzn1xs9IW5rZavdqFq/Oer4kfrIskvJg
 slxD5Ax9FDc5grvdRKj4qW81hcC1zDptvfUDGL0JNJ54y9p+GZDgBar53ghuY1PGtIKMu7z
 Y50YYNyzWbZwrGNbDRcJuJASWX4Xo0KfXXanjw4H9FU5v5Q2m0PYQChaJYO7Wcn4XdK5XTt
 JwIyt+6i3B1EqWzeUFkfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hkSHGmWifxI=:f3VdYOwqK67k1QA5mnjZqb
 GzqNuQsr7VDwXgjhtdLqPRt0TLKd9vHR2+c+g/gKKWnwRhkbHfCAq44yrEAzsH3Zp4k6Q2cQR
 bcvBPvMjIN/VrvCvfFZRhdR5IVPvTDYB1UAGW7rXs2g3khyDWsGUjGb+/z9RkmeZ1DgK0KP6b
 3usNsifnnB6TxUb0KdfSB+9t8mZ1KVkK75fx911gmxXlrK5nzdsbsyDxBstfX2TYYQXoIdOpo
 3Q4mEXjbgAC/6KPVZZ0Ro8CFd71D9MR0Si9NZFHayTvE7//EoNhU3xU/1GAK+ZMsgUb30f+WP
 9FadRzMJCJxePmCZfrH8oaIlVIWMTWVVi/auZUISQeFS1ruyb89mxlvBY37yiTAKH/JbUZJgv
 I+GvecgsZcLVUI8/onTmLtkf9Jeb20qsTenp53SxYdewDIbE0DKIzs4Tw7jSyke6j1dSil/Xn
 udlB7RYLltCXMiLnNxVXX1CjjGb7dA2zcTOcAmvbOlPBELBBNrohDKz3cSAc7s+kGgF2td9HP
 QYyqdoROK8NU/yGvXyPrWGgJvJYm3pvp7iEAF+25mvV2qRkdLFdS2U36fTdtc5CarIQgePkjQ
 mSaKGdsLpSSes+ZsYzEae5+QPO5eOlym3I/d+s2PmriDclwhOzRpYGSqTO0khZb6UeEDz7bqw
 RSXkDqsr75e1X9p0JFh76jZDt/YbKfNGZCDI/yRpC4WUKhlOZKf6wH0mt4DBWtsPV75I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_INPUT, or with a modular input layer and built-in
tablet driver, we get a link error:

ERROR: "input_event" [drivers/platform/chrome/chromeos_tbmc.ko] undefined!
ERROR: "input_register_device" [drivers/platform/chrome/chromeos_tbmc.ko] undefined!
ERROR: "input_set_capability" [drivers/platform/chrome/chromeos_tbmc.ko] undefined!
ERROR: "devm_input_allocate_device" [drivers/platform/chrome/chromeos_tbmc.ko] undefined!

This adds the corresponding Kconfig dependency

Fixes: b418f74170d7 ("platform: chrome: Add Tablet Switch ACPI driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/chrome/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 57aabe6e94a3..cb0df9eb3e0f 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -41,6 +41,7 @@ config CHROMEOS_PSTORE
 config CHROMEOS_TBMC
 	tristate "ChromeOS Tablet Switch Controller"
 	depends on ACPI
+	depends on INPUT
 	help
 	  This option adds a driver for the tablet switch on
 	  select Chrome OS systems.
-- 
2.9.0
