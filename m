Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeBVIWU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:22:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32983 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeBVIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:22:08 -0500
X-Google-Smtp-Source: AH8x225p+P7ygdgUpWxcCTruH0XYy9zADR4vFnoxOWpj5X0P0hiOQys0rc6XoqrXXC9ASiAClMHo9g==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com, david1.zhou@amd.com, Dieter@nuetzel-hh.de,
        l.stach@pengutronix.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] drm/amd: Remove inclusion of non-existing include directories
Date: Thu, 22 Feb 2018 08:21:49 +0000
Message-Id: <1519287709-28638-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
References: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following build warnings:
  CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o
cc1: warning: ../display/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: ../display/include: No such file or directory [-Wmissing-include-dirs]
  CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
cc1: warning: ../display/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: ../display/include: No such file or directory [-Wmissing-include-dirs]
[...]
This warning is shown for each file in amdgpu directory, so it spams a lot.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/amd/display/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index c27c81cdeed3..22c72dffdf98 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -26,8 +26,6 @@
 
 AMDDALPATH = $(RELATIVE_AMD_DISPLAY_PATH)
 
-subdir-ccflags-y += -I$(AMDDALPATH)/ -I$(AMDDALPATH)/include
-
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
-- 
2.16.1
