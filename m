Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeBZMRy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:17:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32558 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752451AbeBZMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:17:50 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Vincent Abriou" <vincent.abriou@st.com>
Subject: [PATCH] drm: clarify adjusted_mode for a bridge connected to a crtc
Date: Mon, 26 Feb 2018 13:16:04 +0100
Message-ID: <20180226121605.12050-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clarifies the adjusted_mode documentation
for a bridge directly connected to a crtc.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
This patch is linked to the discussion https://lkml.org/lkml/2018/1/25/367

 include/drm/drm_bridge.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3270fec46979..b5f3c070467c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -177,7 +177,8 @@ struct drm_bridge_funcs {
 	 * pipeline has been called already. If the bridge is the first element
 	 * then this would be &drm_encoder_helper_funcs.mode_set. The display
 	 * pipe (i.e.  clocks and timing signals) is off when this function is
-	 * called.
+	 * called. If the bridge is connected to the crtc, the adjusted_mode
+	 * parameter is the one defined in &drm_crtc_state.adjusted_mode.
 	 */
 	void (*mode_set)(struct drm_bridge *bridge,
 			 struct drm_display_mode *mode,
-- 
2.15.1
