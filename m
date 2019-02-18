Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E76C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF10217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498318;
	bh=gt8js6bW8WLLjEi5Zh3UB7HXo/ikp0tVHO9urK7YR1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ijzS1/dRQ1oEJbcmp0vHRDMafTz5kZkZHaiEwz+CV7LphEuGp42mkFGyuaZvK0QeD
	 uweuEPVoMZJZyWWnh48GfURa/rrJ7HKjdWzHsEjj96q5VG2o9SWEHSIrF7cqhv8QCL
	 D7Nm/ub2CIUsHFesI+mbRSubx9Ravi9vYqIRR9NU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbfBRN6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbfBRN6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B50217D9;
        Mon, 18 Feb 2019 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498310;
        bh=gt8js6bW8WLLjEi5Zh3UB7HXo/ikp0tVHO9urK7YR1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W87+2bQZe8Cp46iGVYL+4yq8NCwPcjf4ywrTHwI5jMV/OCuehDGApOQa9M7qpluQU
         Pu4Sm2rQDbP/zPYyKDU8IevoOK5/yoHn3FlPRbQa0Uu7vPWqcMlAXJZZPbBHfOmcQt
         5DC0pWPj7KQFATqHsnAHv7HdXGunkgaCYHUX09aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 28/58] drm/bridge: tc358767: fix output H/V syncs
Date:   Mon, 18 Feb 2019 14:43:49 +0100
Message-Id: <20190218133510.768733485@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



