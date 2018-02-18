Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeBRIyP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 03:54:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49772 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeBRIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 03:54:14 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: airlied@linux.ie
Cc: mario.kleiner.de@gmail.com, daniel.vetter@intel.com,
        gustavo@padovan.org, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
Date: Sun, 18 Feb 2018 16:53:59 +0800
Message-Id: <20180218085359.7817-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit e10aec652f31 ("drm/edid: Add 6 bpc quirk for display
AEO model 0."), the EDID reports "DFP 1.x compliant TMDS" but it support
6bpc instead of 8 bpc.

Hence, use 6 bpc quirk for this panel.

Fixes: 196f954e2509 ("drm/i915/dp: Revert "drm/i915/dp: fall back to 18 bpp when sink capability is unknown"")
BugLink: https://bugs.launchpad.net/bugs/1749420
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ddd537914575..d9c8d718e261 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -113,6 +113,9 @@ static const struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
 
+	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
+	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
+
 	/* Belinea 10 15 55 */
 	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
 	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
-- 
2.15.1
