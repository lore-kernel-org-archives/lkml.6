Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB84C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A630420821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738285;
	bh=bwo4TZcq8NiIRQhab8Vd/JhKZP44Lyfszc3O9H24ds0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cc9VzSF98QoRqmMyCqw0a7ThMucsAcL54rK6J4NfAhXcM56p+ygFEXzTPfXcNADB4
	 QArAvr50SR0pSA6QVIIgJukzTVtzn6mLHbkfSvCY8zazH+19vrCmMHAnYP+cctkfCU
	 R4VRwKRdd5RAWf0NG9cjKovictD7JRbtxy1b+mSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfBISvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfBISuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4426720821;
        Sat,  9 Feb 2019 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738201;
        bh=bwo4TZcq8NiIRQhab8Vd/JhKZP44Lyfszc3O9H24ds0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbokKKGnthz6nTQGmIUsrVA1Up5g26M+i8XCAi8kku4tjxBOxRxwYUEdbSl/ncnsd
         vVAPCPulFmKDxciJu7uKsTj/KSymiARkAw063PeHxvbZfCPe3Qz+aDM7rRTX3Tx5Ed
         TXnT/CGMcU9az9aHGfdPPMRfIYeRoHjpN8i2IPfM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 07/12] drm/bridge: tc358767: fix output H/V syncs
Date:   Sat,  9 Feb 2019 13:49:47 -0500
Message-Id: <20190209184952.127009-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184952.127009-1-sashal@kernel.org>
References: <20190209184952.127009-1-sashal@kernel.org>
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
index 16fa42984c50..fa3f2f039a74 100644
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

