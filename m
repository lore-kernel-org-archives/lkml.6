Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeBHUxr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:53:47 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37585 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeBHUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:53:44 -0500
X-Google-Smtp-Source: AH8x226cuLCiaHQfPQLq+fb/od/vwI/FJZVRgmHTtqcJf5AJ9/IUoe+ckrz+/68LL2AtF8IZkFo6eg==
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
Subject: [PATCH v3 2/4] amdgpu/dc/calcs: Consolidate redundant CFLAGS
Date: Thu,  8 Feb 2018 12:53:14 -0800
Message-Id: <20180208205316.93330-2-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180208205316.93330-1-mka@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a variable for common CFLAGS instead of specifying the same flags
for every source file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added

 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 7959e382ed28..af0f452f3c9f 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -24,9 +24,11 @@
 # It calculates Bandwidth and Watermarks values for HW programming
 #
 
-CFLAGS_dcn_calcs.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dcn_calc_auto.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dcn_calc_math.o := -mhard-float -msse -mpreferred-stack-boundary=4 -Wno-tautological-compare
+calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
+
+CFLAGS_dcn_calcs.o := $(calcs_ccflags)
+CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
+CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
 
 BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
 
-- 
2.16.0.rc1.238.g530d649a79-goog
