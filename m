Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC544C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCE3222B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894917;
	bh=sl3/65gnbN55u/33PWXDOI+hgYejdqgkf1ttKFUTuyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdPZ8T/7rL+aG7h5znXEx1fqK/zkopVnTVgbQrBtJPZJc2+oThPrumOHmKJjNdqmc
	 gpNs/9s1PMxrBfu8AqdV8D9Gt1O1sggsH45cDOJpvxubYqETcxja7fNFs/SJtofzVq
	 WCu/0m41EIBpv2GmvNXar0MxEvAare41CJgCATpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfBKOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfBKOVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2193222B6;
        Mon, 11 Feb 2019 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894914;
        bh=sl3/65gnbN55u/33PWXDOI+hgYejdqgkf1ttKFUTuyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQWhwa3awmtSF8soHOcwyWhfbPtYhbUH9LYLPsxZ5sRyLzIshEw7qQgP3Lp1BKKhg
         0K7R9r3ufJtLyaUZTRFsrFdUvDLpI49v+fE6lVrUYoLHp2DM3vMOqP2AubccHiwPZ+
         0yBuWyQb3GZw8jHVc3FpKjif8P4xgCC7jiqJGu7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 013/352] drm/amd/display: Fix potential nullptr error
Date:   Mon, 11 Feb 2019 15:14:00 +0100
Message-Id: <20190211141847.251717353@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



