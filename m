Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E86FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B94C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675395;
	bh=91zXGUhQY1tdEY7BDh2cg7C+Us+933/M93z/lmPwKqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=viJ8UnVg3HsdHBQ40yeUkY06wcTEjhUVmsW8kVRO7S2yu0e+8VE9q1gBF/l4FcECc
	 ALuqdOdhH4Dn2QQm8nnngSfXesSjmCz1epPjfDULow9fntKNX+O7ewaZwRdEiIL+ei
	 MiB/Je5rcQvKY2T4gurFbMj+sRth8Y4RTf3YPmTI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B94C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbeLME3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbeLME3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8E820879;
        Thu, 13 Dec 2018 04:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675389;
        bh=91zXGUhQY1tdEY7BDh2cg7C+Us+933/M93z/lmPwKqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/dVO8K52V8D8QJwqoYvZtV8kLUXy/JnvvJr/du0J/4yBM93HIzo0TqaiIcRunP8D
         A8jpeq3VWhnaLGykWIjXHf5fmu3//6rYVoA4eqQQ0xkkzwuB+WXEVnj8VlIVErWe7u
         nhbVd2qgVLspRQzm9+OLA/GQf8ptToVIv9fV4tu4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 36/73] drm/amd/powerplay: issue pre-display settings for display change event
Date:   Wed, 12 Dec 2018 23:28:01 -0500
Message-Id: <20181213042838.75160-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 10cb3e6b63bf4266a5198813526fdd7259ffb8be ]

For display config change event only, pre-display config settings are
needed.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c  | 3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 8994aa5c8cf8..64596029b696 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -365,6 +365,9 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr, enum amd_pp_task task_id,
 
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
+		ret = phm_pre_display_configuration_changed(hwmgr);
+		if (ret)
+			return ret;
 		ret = phm_set_cpu_power_state(hwmgr);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
index 91ffb7bc4ee7..56437866d120 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
@@ -265,8 +265,6 @@ int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool skip,
 	if (skip)
 		return 0;
 
-	phm_pre_display_configuration_changed(hwmgr);
-
 	phm_display_configuration_changed(hwmgr);
 
 	if (hwmgr->ps)
-- 
2.19.1

