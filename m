Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C966C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAB421B68
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026831;
	bh=/fdL2QZLBUc6YA0ThfsjV5gihgnjA/nzrOzRvpjC3OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2LTBY5YalUgKuLTDBZYiT1wGTh6UDd1nbK+/XON4bNMefuiaEhFOSi1n0wug3eC1G
	 gwLFKOW0T+B/3KkAPcAnywVLGchdbh6SW7UFOJL7ua02OxFVFAlR6AKtV/N3kD6R39
	 shOLl3usHIX9LzUbDOv+AoYQRMvlp6MZc4D92rVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfBMCff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387998AbfBMCfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0598D206B6;
        Wed, 13 Feb 2019 02:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025324;
        bh=/fdL2QZLBUc6YA0ThfsjV5gihgnjA/nzrOzRvpjC3OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCAiM61NYCrZ4qby4QeCDI06eu2K3YV7JZK5+l2Wl9N9s/feni+z/B3DGrnwyZtaV
         rWK0SHzOxgfS/BfGmoonIzTzuc3FV0Uybbj+HhR85xvhmOpSvvO4ERfto/LeOKDj7b
         2Qz0fTa8U/VEOaUyeWRffdK7dtjZRRJj8ayyd9NI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charlene Liu <charlene.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 069/105] drm/amd/display: fix PME notification not working in RV desktop
Date:   Tue, 12 Feb 2019 21:33:00 -0500
Message-Id: <20190213023336.19019-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charlene Liu <charlene.liu@amd.com>

[ Upstream commit 20300db4aec5ba5edf6f0ad6f7111a51fbea7e10 ]

[Why]
PPLIB not receive the PME when unplug.

Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index a6bcb90e8419..0ae41693cd9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1000,7 +1000,7 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 
 		pipe_ctx->stream_res.audio->funcs->az_enable(pipe_ctx->stream_res.audio);
 
-		if (num_audio == 1 && pp_smu != NULL && pp_smu->set_pme_wa_enable != NULL)
+		if (num_audio >= 1 && pp_smu != NULL && pp_smu->set_pme_wa_enable != NULL)
 			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
 			pp_smu->set_pme_wa_enable(&pp_smu->pp_smu);
 		/* un-mute audio */
@@ -1017,6 +1017,8 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx, int option)
 	pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
 			pipe_ctx->stream_res.stream_enc, true);
 	if (pipe_ctx->stream_res.audio) {
+		struct pp_smu_funcs_rv *pp_smu = dc->res_pool->pp_smu;
+
 		if (option != KEEP_ACQUIRED_RESOURCE ||
 				!dc->debug.az_endpoint_mute_only) {
 			/*only disalbe az_endpoint if power down or free*/
@@ -1036,6 +1038,9 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx, int option)
 			update_audio_usage(&dc->current_state->res_ctx, dc->res_pool, pipe_ctx->stream_res.audio, false);
 			pipe_ctx->stream_res.audio = NULL;
 		}
+		if (pp_smu != NULL && pp_smu->set_pme_wa_enable != NULL)
+			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
+			pp_smu->set_pme_wa_enable(&pp_smu->pp_smu);
 
 		/* TODO: notify audio driver for if audio modes list changed
 		 * add audio mode list change flag */
-- 
2.19.1

