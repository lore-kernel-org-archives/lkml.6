Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754741AbeDTL0C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:26:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46201 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbeDTLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:25:59 -0400
X-Google-Smtp-Source: AIpwx49Q8FzJNtivl6iIFJpakQW1Y51ojg2hkXMMFUSqiOP8t8luJfXDTsfGD1c7K3LlQtBUQv/uqw==
From: Anders Roxell <anders.roxell@linaro.org>
To: tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend on OF
Date: Fri, 20 Apr 2018 13:25:51 +0200
Message-Id: <20180420112551.27027-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
COMPILE_TEST") broke compilation without CONFIG_OF selected.
  CC      drivers/video/fbdev/core/fbmem.o
drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function ‘omapdss_update_prop’:
drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error: implicit declaration of function ‘of_update_property’; did you mean ‘of_get_property’? [-Werror=implicit-function-declaration]
  of_update_property(node, prop);
  ^~~~~~~~~~~~~~~~~~
  of_get_property
cc1: some warnings being treated as errors
scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o' failed
make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o] Error 1
scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss' failed
make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
make[6]: *** Waiting for unfinished jobs....

Add OF dependency in order to make all configurations work again.

of_update_property() has no inline stub, and that that could be added as
an alternative.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/video/fbdev/omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
index 82008699d253..4de381f2452e 100644
--- a/drivers/video/fbdev/omap2/Kconfig
+++ b/drivers/video/fbdev/omap2/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_OMAP2PLUS || COMPILE_TEST
+if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
 
 source "drivers/video/fbdev/omap2/omapfb/Kconfig"
 
-- 
2.17.0
