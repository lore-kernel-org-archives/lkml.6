Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8941DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B3620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697933;
	bh=NRWgOEtTezcQc88knb+15/kLmDndZMMp/nlNONsW16c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2OwJzuw4jcsP0oSn938TsLe9bHBoOEFXdEc74L4CZabsPSsTqQBvh3lARGFhV3cu
	 v/kiTbuXnc/fX3ezV/i3oBYgKwCR/uHOGWa2yrBC5vTE6J32wk+4JnoeWVSWlTwjoN
	 RuxVtZguHraz95zO1G5VfWZUDzwv63sjZXuDJscY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfA1RwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfA1PoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B2B214DA;
        Mon, 28 Jan 2019 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690241;
        bh=NRWgOEtTezcQc88knb+15/kLmDndZMMp/nlNONsW16c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTqemF5R72ekkYEnnTxkYnWfkgveJdgasqcF9YbO28lsbtjOJ9N2tbo+9z2IO4X/1
         heJsjXH+C8i1a+poDNWpSfPJbA3JYQwQFDlgWZmtsog6qevzTQHBUTzkV2JE9ylMUJ
         YVffQAmwqLZX3zN4SaBFOAztNEwEyW5CiV10XIT0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 013/304] drm/amd/display: Fix potential nullptr error
Date:   Mon, 28 Jan 2019 10:38:50 -0500
Message-Id: <20190128154341.47195-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[ Upstream commit 4f7129112c2a30331f3045a42026fad82e6cb72b ]

[Why]
Fix surface/plane potential nullptr

[How]
add null check

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3118ae0e7a87..315a245aedc2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5333,6 +5333,12 @@ enum surface_update_type dm_determine_update_type_for_commit(struct dc *dc, stru
 	struct dc_stream_update stream_update;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
 
+	if (!updates || !surface) {
+		DRM_ERROR("Plane or surface update failed to allocate");
+		/* Set type to FULL to avoid crashing in DC*/
+		update_type = UPDATE_TYPE_FULL;
+		goto ret;
+	}
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		new_dm_crtc_state = to_dm_crtc_state(new_crtc_state);
-- 
2.19.1

