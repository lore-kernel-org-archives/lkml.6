Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C7C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6202520895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202520895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeJMSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 14:55:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52870 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeJMSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 14:55:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 104CC260B2D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        zain wang <wzz@rock-chips.com>,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] drm/bridge: analogix_dp: Fix misleading indentation reported by smatch
Date:   Sat, 13 Oct 2018 13:18:44 +0200
Message-Id: <20181013111844.22183-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that building the bridge/analogix source code with
smatch triggers complaints about inconsistent indenting.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index d68986cea132..75e2649d7515 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1219,12 +1219,12 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge)
 	 * plat_data->attch return, that's why we record the connector
 	 * point after plat attached.
 	 */
-	 if (dp->plat_data->attach) {
-		 ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
-		 if (ret) {
-			 DRM_ERROR("Failed at platform attch func\n");
-			 return ret;
-		 }
+	if (dp->plat_data->attach) {
+		ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
+		if (ret) {
+			DRM_ERROR("Failed at platform attch func\n");
+			return ret;
+		}
 	}
 
 	if (dp->plat_data->panel) {
-- 
2.19.1

