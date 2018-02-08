Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHBvM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:51:12 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45256 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeBHBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:51:10 -0500
X-Google-Smtp-Source: AH8x225umra/ZiYXRKHwtH56O7h0/sBdCD5ZREppSk/GISPTyzn4vC0xi4U1xurpyS/2OdcmwMJp8w==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/2] amdgpu/dc/dml: Consolidate redundant CFLAGS
Date: Wed,  7 Feb 2018 17:51:02 -0800
Message-Id: <20180208015103.169603-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use subdir-ccflags instead of specifying the same flags for every source
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
Changes in v2:
- added 'Reviewed-by: Guenter Roeck <groeck@chromium.org>' tag

 drivers/gpu/drm/amd/display/dc/dml/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 3488af2b5786..b8cadf833e71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -24,15 +24,7 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-CFLAGS_display_mode_vba.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_mode_lib.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_pipe_clocks.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dml1_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_rq_dlg_helpers.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_soc_bounding_box.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dml_common_defs.o := -mhard-float -msse -mpreferred-stack-boundary=4
-
+subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4
 
 DML = display_mode_lib.o display_rq_dlg_calc.o \
 	  display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
-- 
2.16.0.rc1.238.g530d649a79-goog
