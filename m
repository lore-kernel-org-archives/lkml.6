Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA907C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F082177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690953;
	bh=7oaOCg9/4PXoDswpIKriba+PuT/7aD2jCg/jSz1NeYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=acb4Ab2SY0MME/rOCrg1s/w1VSC2L3QA3Lre3SukoiuBBpwgA0cZQXeLS8rxT6r3T
	 vUJNrWFVlAxfGzfDojdDHEdmUAG0+32yS0Zjnjl8JjbK6+RbApsFtBe+B9zHBlhz+1
	 vaHABzkwWIqraqMO95pDkZobZZbdWDTwP/3qkfek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfA1Pzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfA1Pzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18B121741;
        Mon, 28 Jan 2019 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690948;
        bh=7oaOCg9/4PXoDswpIKriba+PuT/7aD2jCg/jSz1NeYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yASCcxZ7e59e0SYxpuhF6M5M9QvwOcBxfnk80fe6TBYR6E1chsmoKFTGikDhMdY2b
         +OBFiuYQJgFGNbz2bgM4ipdQjchRmCm92QSuX05CmrTfA7Sc558+qqkspNgb65lgP1
         hNdV75c375wSG9i5c1kTH/hBthmz7h0cdOR7N6pg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenjing Liu <Wenjing.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 243/304] drm/amd/display: validate extended dongle caps
Date:   Mon, 28 Jan 2019 10:42:40 -0500
Message-Id: <20190128154341.47195-243-sashal@kernel.org>
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

From: Wenjing Liu <Wenjing.Liu@amd.com>

[ Upstream commit 99b922f9ed6a6313c0d2247cde8aa1e4a0bd67e4 ]

[why]
Some dongle doesn't have a valid extended dongle caps,
but we still set the extended dongle caps to be valid.
This causes validation fails for all timing.

[how]
If no dp_hdmi_max_pixel_clk is provided,
don't use extended dongle caps.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d91df5ef0cb3..d33a5ebe990b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2240,7 +2240,8 @@ static void get_active_converter_info(
 					translate_dpcd_max_bpc(
 						hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
 
-				link->dpcd_caps.dongle_caps.extendedCapValid = true;
+				if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk != 0)
+					link->dpcd_caps.dongle_caps.extendedCapValid = true;
 			}
 
 			break;
-- 
2.19.1

