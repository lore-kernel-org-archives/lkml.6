Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1016C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A402082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A402082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJCDoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:44:07 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJCDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:44:07 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2Ujn-1fjLJR1xXD-013rDP; Tue, 02 Oct 2018 22:58:38 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2Ujn-1fjLJR1xXD-013rDP; Tue, 02 Oct 2018 22:58:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
Date:   Tue,  2 Oct 2018 22:58:26 +0200
Message-Id: <20181002205836.2323084-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:CAhRBA/In5ku2tFknwpua/SmjexO2s8uUXbcJNLzC5PYgbuZd5t
 WRNkhHlf8jY5YLZnOm6HVS0TMfrLgJyvuBDb/y8uic7D04WHnwuQQ5r2IlKyLnzF+7ASjSl
 u7TumGjPiHnbjFjnQvcOolCJAlhcvLEtgqZa+moT4oYVH+pFwDDXHTXUE1kFqx3RAGHOn+o
 PbOQ+5fXwzHYBHjjDOa/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UfBjkdJEm2g=:bcbIVwfp/wZQlW9EZzKwFs
 p9alzm+/XArwe90s56diugEo5nbHDbGZ+GDgHtK6UXLJ6AHrfqHNeLb436FH7moJJ6ZFhVlkB
 muJkYBLFPIAVGRUSwgjgJUoitva06skA9vCSxU6nc2zR99ytiEEdslI4YthuPVrX6QE5QElx6
 pJF0Y74Sc/5KCcsXOCUpxwMN0v2nWxjORM3y9SvKqzjT9dgTaNM2uYoFpcZqDlF0Mns1oKy3r
 T+1FkO0h1QOQxaokTTTIq8oSi17ydYiwaNrqytQFINRwm0E3S8TpeiJropT38o/B/bodADzie
 MHxe5z1CC8ra7eMmEGTKwTT8jkosXeWO8B9IQTUlTqtDPZgY+0ql2ZVw3juDTF7V9244OSZPZ
 p1/7tTMXWiU65pxr62uLo7P/Z/7Z2DDqph4H/sEWybTe6PNPj1WWe0BRrIeTQ51QJdXRaP6d0
 q8jEwtWsQk4C/WVdt5oBV/Y3Fe06XwOpcuWkVpyPVqO0QHfJIO9f8p3g5le3KT4NnOfqfyyhU
 GA8DNmEUBnxY4vYVkIt+IRsD+jL6TLJzyOhNdQc19nNk7/5z959qfjRyUGJ0IOFsW5dTvnzue
 a4GVSVN0JOBZ7dGD3DmQ6myEE0lhztVyTcJev7mDY9ft+kM6NwdIoUzWl9Vvk4LSONENOrGz3
 vH68bJGkl65Vu3CPAi+3tB9MaB3ou5d/HiEGkuFWtYU0KoVtsC75/1sywDiYn30WpQOA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is now referenced unconditionally, but still
declared in an #ifdef:

drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?

Remove the #ifdef so it can always be accessed.

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

