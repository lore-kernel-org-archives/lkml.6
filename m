Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbeBGTKe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:10:34 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35665 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754141AbeBGTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:10:32 -0500
X-Google-Smtp-Source: AH8x225KF0ZnwuDm5IrA5w17x9cJSVuyuKcUGPqZqR3eUBkpH5a9ZB7uOiX9qwiV0/3OfN65dw3i9A==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] drm/amd/powerplay: Remove extra pair of parentheses
Date: Wed,  7 Feb 2018 11:10:17 -0800
Message-Id: <20180207191017.77392-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double parentheses are not needed. Removing them fixes the following
warning when building with clang:

drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c:419:29:
  error: equality comparison with extraneous parentheses
    [-Werror,-Wparentheses-equality]
  if ((data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2)) {

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 79e5c05571bc..f5b3de29b632 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -416,7 +416,7 @@ static int tonga_populate_cac_tables(struct pp_hwmgr *hwmgr,
 			convert_to_vid(vddc_lookup_table->entries[index].us_cac_high);
 	}
 
-	if ((data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2)) {
+	if (data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2) {
 		/* We are populating vddgfx CAC data to BapmVddgfx table in split mode */
 		for (count = 0; count < vddgfx_level_count; count++) {
 			index = phm_get_voltage_index(vddgfx_lookup_table,
-- 
2.16.0.rc1.238.g530d649a79-goog
