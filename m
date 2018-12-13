Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA57C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02F20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675344;
	bh=8lsBQtSTM/RdnxZ+FR10LTHgzmmFPISdxgYkJsR6mNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NegZi7ue8WejgyZ8pCKly03m29nYe+A+Jyr8uaXNbqy3bdpozl1yZYpxXVZiPTFY3
	 3gupXCHJLX6Iri4xBnjO5dMsD8skPaPSQBfyFbQJIfrWeTU6fhdt/vRmGQ0NVp/83a
	 HNQ4rENEBmjHdreJeGGEZylp10mN57rJpTN6C+94=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeLME3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbeLME2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D833620849;
        Thu, 13 Dec 2018 04:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675332;
        bh=8lsBQtSTM/RdnxZ+FR10LTHgzmmFPISdxgYkJsR6mNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlUbZjEFaQ7feXojfAyUJTkx8QxRtKsUueJNLNLSnPrn1f9mlujk/9/pfkXj1OZoL
         0ggo9NFVfGSN+vrpzuu2Gq6PX8DN3QRVDl5JNkcJrgLOFgO4d9m+MED7kQIW6vqQdq
         zeMRU3637DxQY9QXeePDDDv8fdxkoQunWDMfrVsw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roman Li <Roman.Li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 10/73] drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)
Date:   Wed, 12 Dec 2018 23:27:35 -0500
Message-Id: <20181213042838.75160-10-sashal@kernel.org>
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

From: Roman Li <Roman.Li@amd.com>

[ Upstream commit c6888879fd55b1ba903c2a770127edbf6aef6f27 ]

[Why]
More than 4x4K didn't lightup on Vega20 due to low dcfclk value.
Powerplay expects valid min requirement for dcfclk from DC.

[How]
Update min_dcfclock_khz based on min_engine_clock value.

v2: backport to 4.20 (Alex)

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index b2f308766a9e..0941f3c689bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2530,6 +2530,8 @@ static void pplib_apply_display_requirements(
 			dc,
 			context->bw.dce.sclk_khz);
 
+	pp_display_cfg->min_dcfclock_khz = pp_display_cfg->min_engine_clock_khz;
+
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
 			= context->bw.dce.sclk_deep_sleep_khz;
 
-- 
2.19.1

