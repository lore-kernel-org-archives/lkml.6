Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4440FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169C421748
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169C421748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeI0ByV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:54:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0ByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:54:21 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9Ib1-1g9x0w120N-006M12; Wed, 26 Sep 2018 21:38:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: fix build failure without CONFIG_DRM_FBDEV_EMULATION
Date:   Wed, 26 Sep 2018 21:38:36 +0200
Message-Id: <20180926193846.2490574-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Gz+H6gNv9Glg2j0PPAgu2dIx/vRoZdb1+bnx2nthpW2drusOC7A
 2SkxIBR8zbSSxZJs+XpFZHhBSrAqS7kq16TlvuetwSrVyPmrsp6UelcM6E9g7fembxN/gDJ
 LoX6pNwiDBLSvDtYSW2oclqz7Bl1hZEtnjaLeITZYa4q/JGHWVmJEoQnOgZD379ndnOmRQ+
 C9glDt1HTZwfLUIJshO9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ty3JvOnbWoc=:H7jehdhza8AqlSrbwCT6XA
 0UYKv3tYIlwesSTRmQGR0ruuu07bOFp4MzWVxKD82R1yBgQW0kRrjp2rt4MwxyDe76xnrmsV2
 pcqXaBmXiueL2fLYVNW7OFEFkvjaVfqTc3qFoS+T2tBxG44cqiCr1nMfgsTAj1ZnIagWvg+hy
 XfSr301wvl4wlNXCOWtsxO2+EfQPMgTMRHEVw5ekBjTForsQHsgtA9mvPT7zO4n1c4wdIM3k3
 neD0NMmhddVnJ1zmdXclwaBMGIf8mveS45IJWk/o/XCYeanL5f1gDxGM+nnGyC4TRVwvVUdO2
 zkzAicoEDvwb/VaD4/oIo8UKGcJ2RD/xSkaZ7dFtPhPkw3tRCJYBSkkamSJ9NFZ77TFoaOsNO
 bh75Bjz4sxfAIo7nUhem+VRNSwqySGxCvO3RpIWMPq8U6M/Da9XEHMAY9f6BuWOSfLSuGc7aT
 ddTBEdJ0kMGhLkPYWkbwli/x+YHEPcFOQt91OonXvf9+ZMCYS78WiPBw0pIXSVMXgHVlnfG9u
 jO8l6Zu83jd9KwP4F+r0bJ+9gUB5dWKnAmUUNmYbRunVEnApeRQgJvUvxOTc1QDj3yDChWAfB
 2BMJsSmtiaS0WOMrIfR/f3n7bkexoMMknxMh2udCzY6Rdwc2d2FMznsQL7jnx30nMcusErBd9
 Fj+OTmqXxRTLfjE3D5R1VX02nsOjgE1prAEXeh4fDCkM6B5te/YwBnp8NmfBcjYQxWzU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is declared in an #ifdef section, but the user is
now unconditional, which leads to a build failure:

drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?

Remove the remaining #ifdef as well.

Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index a70f3131a377..0e6942f21a4e 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -35,10 +35,8 @@
 
 #define MAX_CRTC	4
 
-#if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
 static int legacyfb_depth = 16;
 module_param(legacyfb_depth, int, 0444);
-#endif
 
 DEFINE_DRM_GEM_CMA_FOPS(imx_drm_driver_fops);
 
-- 
2.18.0

