Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F21C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F207C20823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738620;
	bh=usF7bQ3zN4VSY0Qbhe5+9OumbZ1jw9ho1p+MeIhxWtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ipbhrnZjyzBJBqzj1HHPQK7Fv+8UnefEhqigZ2O0w+nRiBYp0ekr7KVmu9SJCYgk3
	 X5WJEiIH7yM76ngountXXzD1l4jaVOZOh2e+awbf6co47dAc964nRor/PDes2jU6Iy
	 PToLguT1IZac84VxM4hWCZ7aDRB3f76YL0ZzcEtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfBIS46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfBISrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D76021916;
        Sat,  9 Feb 2019 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738071;
        bh=usF7bQ3zN4VSY0Qbhe5+9OumbZ1jw9ho1p+MeIhxWtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWbWQ/5yqOzbbne089tKdCyj/en7sz/TWX77M5Ryu9vhRBRU8MpR+Mc27yC20WijY
         j5YKjq8hkjsOjMLxnBrrGZwmlHMGaSKetcrHVy0UpBQ+eihlOBkIvhQBdWyHYDnzy5
         OgqHdtnMnEiTzgPlRRmRn5CG185Ix7tzjN6N4W9M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 15/42] drm/bridge: tc358767: add bus flags
Date:   Sat,  9 Feb 2019 13:47:07 -0500
Message-Id: <20190209184734.125935-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 4842379cbe6e851de914a7132f76f4e200b9a98b ]

tc358767 driver does not set DRM bus_flags, even if it does configures
the polarity settings into its registers. This means that the DPI source
can't configure the polarities correctly.

Add sync flags accordingly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-2-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 8e28e738cb52..29a7e33e8ae0 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1195,6 +1195,10 @@ static int tc_bridge_attach(struct drm_bridge *bridge)
 
 	drm_display_info_set_bus_formats(&tc->connector.display_info,
 					 &bus_format, 1);
+	tc->connector.display_info.bus_flags =
+		DRM_BUS_FLAG_DE_HIGH |
+		DRM_BUS_FLAG_PIXDATA_NEGEDGE |
+		DRM_BUS_FLAG_SYNC_NEGEDGE;
 	drm_connector_attach_encoder(&tc->connector, tc->bridge.encoder);
 
 	return 0;
-- 
2.19.1

