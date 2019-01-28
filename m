Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696290;
	bh=Q42/dfcWUcuSnQDph101c4xf0FYsTxEP3V3rrFsJKcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rqIvonUC0EGtP1mKnOprJdpJHXnP8/6kNnbVCbbp7UBo6bLHAnI1Jn9xJKpNvewG3
	 k4AfT1BpZ+stFJhIJyUFcLbTHKSjmLSpYrEFlsoT72SLsPzdL9zIG8RCqXwbCC+H+c
	 BKoU8QmhOCaWxbw+cwHQXNHsdrFTeKd1Ab5z8wbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfA1RYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:24:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbfA1QBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1742082E;
        Mon, 28 Jan 2019 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691292;
        bh=Q42/dfcWUcuSnQDph101c4xf0FYsTxEP3V3rrFsJKcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV4Ww5CBtGVyIBRlqgsgAESCDveblDDGFo1C7lZn+JjWp9t08joudgARtZuPkhaxN
         1HSJ1HwRy1RgW9NDjb3tbIgEt2qtP9ElA3mfY3uxH5ThMDLo9VJ2FlIUuQEgqr+PsQ
         WdI9a4w8CpN9V02ixSjDhKGQ7SRvNXzvLuTz241I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Murton Liu <murton.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 048/258] drm/amd/display: fix gamma not being applied correctly
Date:   Mon, 28 Jan 2019 10:55:54 -0500
Message-Id: <20190128155924.51521-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murton Liu <murton.liu@amd.com>

[ Upstream commit 8ce504b9389be846bcdf512ed5be8f661b3bf097 ]

[why]
Gamma was always being set as identity on SDR monitor,
leading to no changes in gamma. This caused nightlight to
not apply correctly.

[how]
Added a default gamma structure to compare against
in the sdr case.

Signed-off-by: Murton Liu <murton.liu@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cfcc54f2ce65..33a9d0c58966 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1190,7 +1190,8 @@ static bool dcn10_set_input_transfer_func(struct pipe_ctx *pipe_ctx,
 		tf = plane_state->in_transfer_func;
 
 	if (plane_state->gamma_correction &&
-		!plane_state->gamma_correction->is_identity
+		!dpp_base->ctx->dc->debug.always_use_regamma
+		&& !plane_state->gamma_correction->is_identity
 			&& dce_use_lut(plane_state->format))
 		dpp_base->funcs->dpp_program_input_lut(dpp_base, plane_state->gamma_correction);
 
-- 
2.19.1

