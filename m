Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967033AbeEYPwA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:52:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967009AbeEYPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:51:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drm/v3d: add CONFIG_MMU dependency
Date: Fri, 25 May 2018 17:50:12 +0200
Message-Id: <20180525155030.3667352-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:6T3Ud88LEAdQJdKJHT0oMDM4g9lJpFi/VazujwBMEEqHBcOpQVJ
 ZZZj+7YCZORAkc+Wcb1XYsO04cymWjGa715bXUX5aX1avmyMsu5A1yly4TVI0zQoYAskFXG
 vzRacFrzfy84xw8q7pXujFRlN97zfkL35KfszYAwxRfJEGKQBkvIxFXJ2Hig6SQyuk1eIDI
 o04YlXLAcGS4k0JHQxxbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NfT+Q2RFkTQ=:3bqtg0g0FcJmnDWRdMfpBN
 DKimFMckwaETwQ3H2gCYqKSGR0qlTzeePaj+kaYilsNGq4dBa5drizBy5SL1rynehau5EMBrO
 tW6NXFtzg1AFcK34+UD9fLYCnOYuVbqUMtZKkIXJ7YO6p4A1V0oGHtzZ5ta/JDo3/hEPn+EJG
 qoM+DTn/8vo+5yzMN/il7N1EWjUkNq46B10VHVa6CC8TTIZgv8xtSIgN1hFO128QI/R+sOwXM
 GVGjBIgavaGHaEJsMmNxfXaht7h9lEbsUY/J5oSRg/dCKl3/Wrt4d2Lp57U9JATgp1bn9bdE9
 UKMglzncK6II7R9JSJtgflRvpKqjL/CJM53deO6i2OEXZ4HIq2R74nbb2jmZGIW2MLvxccOiC
 savlntfUdXTUvS3Be57wN9Emufe1ZafoOIP1l81BxKes4BeZFWTdI6b6bFt4OIN+MsnqsNvOM
 P6ThdmcUSjPfNaWnwQyzq8Oam2aHh+UhZSAn0pOu7dpMT31uJ3wdnrjVvMvEH66UESNBEg/v7
 ciWoY6kbmOkzvSMAZjXDu9Oo8tE6R0l8Vz5BjsNNNCwNdYhcqv5WbmWpEWtx8wy/tVGPb20aU
 6R9Po0D5taB2oC+ddVn/acY39N8BffnS+dg+bYL6F74ZbuPqX8hWdQvrZjT73fYVDedCFYwAO
 wJSmaGLjJlCZvwM+2d5U1HXGpKU+iblb97qJtR8C1MIZKYN/PYAo1Ku3In/GRoEYBBS8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_MMU, we get a link error:

drivers/gpu/drm/v3d/v3d_bo.o: In function `v3d_gem_fault':
v3d_bo.c:(.text+0x3ca): undefined reference to `vm_insert_mixed'

The other drivers with this problem already depend on CONFIG_MMU,
so let's do the same thing here.

Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/v3d/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index a0c0259355bd..1552bf552c94 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -3,6 +3,7 @@ config DRM_V3D
 	depends on ARCH_BCM || ARCH_BCMSTB || COMPILE_TEST
 	depends on DRM
 	depends on COMMON_CLK
+	depends on MMU
 	select DRM_SCHED
 	help
 	  Choose this option if you have a system that has a Broadcom
-- 
2.9.0
