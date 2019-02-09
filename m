Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DF5C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C542920821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738367;
	bh=ESzFSYHOBJ/UzhhB2aaCrCQ/mAHhKVA04AnH7OAlfw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fyrop8t+ZYS6UEqGLmPVLwRO3ZUfOWQuXSYNHmDzQdcezZm6Y82k3l42Ext9L7YtJ
	 YHPdfHQgiQYdd3E0cztrEt6ogofybFlX29SUGFyfdKBT3yMM69ZUvIUHPmfc8ilh3D
	 eqgw6mqvstue3hLVpqn/sVTvECS4IoUPKLvNyNfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfBISwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfBIStj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205492192C;
        Sat,  9 Feb 2019 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738178;
        bh=ESzFSYHOBJ/UzhhB2aaCrCQ/mAHhKVA04AnH7OAlfw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LquAQ/q4FhjV0NBTUd+r+0U8BoRaoIZwcbas+hZgGmClm5QSs8O3+umwVFb+C2A+5
         x3vaefPuDARu8ggmtOhGzwbbGDhY8vcYJL59pfdtiR3Gjkrv+ZFmy9urwmNb6wbR7L
         QGNMaRmPmp+d3wFGti9ZTEmd5IaFY3gDpIv3X+VA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 08/16] drm/bridge: tc358767: fix output H/V syncs
Date:   Sat,  9 Feb 2019 13:49:19 -0500
Message-Id: <20190209184927.126791-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184927.126791-1-sashal@kernel.org>
References: <20190209184927.126791-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 7923e09c7a766e2d58de7fc395bb84c18e5bc625 ]

The H and V syncs of the DP output are always set to active high. This
patch fixes the syncs by configuring them according to the videomode.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-7-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 792a2548d3bb..6eebd8ad0c52 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -96,6 +96,8 @@
 #define DP0_STARTVAL		0x064c
 #define DP0_ACTIVEVAL		0x0650
 #define DP0_SYNCVAL		0x0654
+#define SYNCVAL_HS_POL_ACTIVE_LOW	(1 << 15)
+#define SYNCVAL_VS_POL_ACTIVE_LOW	(1 << 31)
 #define DP0_MISC		0x0658
 #define TU_SIZE_RECOMMENDED		(63) /* LSCLK cycles per TU */
 #define BPC_6				(0 << 5)
@@ -724,7 +726,9 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 
 	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
 
-	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0));
+	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
+		 ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
+		 ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
 
 	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
 		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
-- 
2.19.1

