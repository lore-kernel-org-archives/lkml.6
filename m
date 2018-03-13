Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeCMVAk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:00:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeCMVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:00:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Philippe CORNU <philippe.cornu@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: rm68200: add backlight dependency
Date: Tue, 13 Mar 2018 21:59:54 +0100
Message-Id: <20180313210015.3344380-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:kiZY1fw7iZFXAuT43xvMpNnLRcv0S2QQug5CxhTjOJ5AzfEF0z4
 M4e6wGdhcrFHnQq3uFyaI709ciE8xT4oirtvU/sJX94w55a1hlrj2+hLqwWdFrqliOLqLte
 UOY1yv8e2pCommHvs8oTxUrfH8C9sYIBGZ8rgpwS0qasNQ4TXhRe66wAMKZjJFaidlXr6sE
 xHT4Gxk2IeFl2PAgHjp3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YZTXKv0waXQ=:E/xFG+upmgXw2pv9aEAESq
 gm30qffnPgiykwbYeFKxcqkYBf7yH+PNcvsEs65t61r11vKFUWCUlaykSS76341tdnfsvJzHI
 BHL2TZKS+HjhCzFsypFEWpB/oS3IZm7wY2GADFJDaH7HGrXm0h9kG91eMRSmOWQ+nwrO6/89P
 cJ9MgSJjKtvHFNobSukQXWi9Iy1dNS9Ol4F3RL4h3LvdUvVQIWFdSFfjqKOkyPV7mBgmoTxWx
 u+bpOq4OybOPRUM79wvBIKM7FCNhCOykJ0n876aH0tgGvXhcASvq4XU3IPlt3S1X7zvAe1Vaa
 UniXG1wTf+YW43+vCYk0axxb0Kkrh1wxHhNOlHxElTi5dAH40CUzECEhMvUCNUnvM5S6V6PCH
 12hWlsrQZ41NEMHYBBMo6ZRjmPQljPVmvF5+0XnzkXOXRi5YCDDYkEJ5QVQYvDTZhwc6nhlS0
 jaL+cKrx/UjegGwoB29H3KrOT62b8OBtL1s2qRB3LzooBR9GO0LdupfeidQemfTaPobGJ0cCw
 e3VbqbHfGFrfKLENluve0uI0EzbyaTlmbbeFSgCOH2vkzf2N84Wx2q/cRlHuF60bnJKSDMIO7
 /dsiIAPXnLH4CI0ZHXsAg+77rTUeACVBS4uw8BWAdz0+RJ1EMlEbalzfL26f6Xesa2PpcKh8m
 UAyB0WvDDsK+Z4Q3xx2EigQfvtbOdp8Uqo+SzZiLvn2UmcoikeaPC19W5/wgzaHlNaon4sk0Z
 WYgQ3nY8oMhZXTDrQdwrPC1GGnGDMZQAbEec2A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like many other panel drivers, this one fails to build
when backlight support is disabled:

drivers/gpu/drm/panel/panel-raydium-rm68200.o: In function `rm68200_probe':
panel-raydium-rm68200.c:(.text+0x14a): undefined reference to `devm_of_find_backlight'

This adds the appropriate dependency.

Fixes: 2b7ed18bed1a ("drm/panel: Add support for Raydium RM68200 panel driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 077bc58c1913..25682ff3449a 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -112,6 +112,7 @@ config DRM_PANEL_RAYDIUM_RM68200
 	tristate "Raydium RM68200 720x1280 DSI video mode panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for Raydium RM68200
 	  720x1280 DSI video mode panel.
-- 
2.9.0
