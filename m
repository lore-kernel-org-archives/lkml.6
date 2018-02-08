Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBHUxm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:53:42 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34192 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBHUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:53:41 -0500
X-Google-Smtp-Source: AH8x225UZfF6akPpOacdAGADlkMj60BnLcLIyI/EmzLfrY3wsrSziTkc4y+y/Zv4Mi0zVGmReC1OqQ==
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
Subject: [PATCH v3 1/4] amdgpu/dc/dml: Consolidate redundant CFLAGS
Date: Thu,  8 Feb 2018 12:53:13 -0800
Message-Id: <20180208205316.93330-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a variable for common CFLAGS instead of specifying the same flags
for every source file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- Use variable for compiler options instead of subdir-ccflags-y

 drivers/gpu/drm/amd/display/dc/dml/Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 3488af2b5786..96b337a03172 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -24,15 +24,16 @@
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
+dml_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
 
+CFLAGS_display_mode_vba.o := $(dml_ccflags)
+CFLAGS_display_mode_lib.o := $(dml_ccflags)
+CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
+CFLAGS_display_rq_dlg_calc.o := $(dml_ccflags)
+CFLAGS_dml1_display_rq_dlg_calc.o := $(dml_ccflags)
+CFLAGS_display_rq_dlg_helpers.o := $(dml_ccflags)
+CFLAGS_soc_bounding_box.o := $(dml_ccflags)
+CFLAGS_dml_common_defs.o := $(dml_ccflags)
 
 DML = display_mode_lib.o display_rq_dlg_calc.o \
 	  display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
-- 
2.16.0.rc1.238.g530d649a79-goog
